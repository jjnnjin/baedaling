<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=cp%>/resource/css/storepage.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/pay.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/review_re.css" type="text/css">
<script type="text/javascript">
function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}




function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

$(function(){
	$("#tab-0").addClass("active");
	listPage();
	
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});

		
		$("#tab-"+tab).addClass("active");
		listPage();
	});
});

function listPage(){
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url = "<%=cp%>/franchise";
	var query = "restaurantsNum="+${dto.restaurantsNum};
	var purl = "";
	if(tab == 0){
		purl = "/menu";
	}else if(tab == 1){
		listPagee(1);
		return;
	}else if(tab == 2){
		purl = "/info";
	}
	
	url = url + purl;
	
	$("#contentLayout").empty();
	
	var selector = "#contentLayout";
	ajaxHTML(url, "get", query, selector);
}

function listPagee(page) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url="<%=cp%>/franchise/review";
	var query="pageNo="+page;
	query += "&restaurantsNum="+${dto.restaurantsNum};
	
	$("#contentLayout").empty();
	var selector = "#contentLayout";
	
	ajaxHTML(url, "get", query, selector);
}


$(function(){
	$("body").on("click",".listCatrgory",function(){
		var restaurnatsNum = ${dto.restaurantsNum}
		var menuCategoryNum = $(this).attr("data-menuCategoryNum");
		var $tr = $(this).next(".detailCategory");
		var isVisible = $tr.is(':visible');
		if(isVisible){
			$tr.hide();
		}else{
			$tr.find("td").load("<%=cp%>/franchise/detailMenu?menuCategoryNum="+menuCategoryNum + "&restaurantsNum=" + restaurnatsNum);
			
			$tr.show();
		}
		
		
	});
});

$(function(){
	$("body").on("click",".menu",function(){
		var menuNum = $(this).attr("data-menuNum");
		$("form[name=readMenuForm]").each(function(){
			this.reset();
		});
		
		$('#readMenu-dialog').dialog({
			  modal: true,
			  height: 650,
			  width: 600,
			  title: '메뉴 정보',
			  open: function(){
				
				var url = "<%=cp%>/franchise/read";
				var query = "menuNum="+menuNum;
				var fn = function(data){
					var dto = data.dto;
					var menuNum = dto.menuNum;
					var menuName = dto.menuName;
					var menuPrice = dto.menuPrice;
					var saveFilename = dto.saveFilename;
					var menuInfo = dto.menuInfo;
					$("#readMenu-dialog input[name=menuNum]").val(menuNum);
					$("#menuNameView").html(menuName);
					$("#menuPriceView").html(menuPrice);
					$("#menuInfoView").html(menuInfo);				
					
					$(".detail-image").attr("src", "<%=cp%>/uploads/menu/"+saveFilename);
				};
				ajaxJSON(url, "get", query, fn);
			  },
			  
			  close: function(event, ui) {
			  }
		});
	});
});

$(function(){
	$("body").on("click",".buyAdd",function(){
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());
		
		var menuNum = $(this).closest("table").find("input[name=menuNum]").val();
		var menuName = $(this).closest("table").find("#menuNameView").html();
		var menuPrice = parseInt($(this).closest("table").find("#menuPriceView").html());
		var qty = 1;
		
		var t = "#buyTr"+menuNum;
		if($(t).length){
			qty = $(t+" input[name=quantity]").val();
			if(! qty){
				qty = 0;
			}
			
			pty = parseInt(qty)+1;
			
			$(t+" input[name=quantity]").val(pty);
			$(t+" .productPrice").text(pty*menuPrice);
			
			totalBuyAmt = totalBuyAmt + menuPrice;
			$("#totalBuyAmt").text(totalBuyAmt);
			$('#readMenu-dialog').dialog("close");
			
			return;
		}
		
		
		var $tr, $td, $input;
		
		var vprice = "<span class='productPrice'>" + menuPrice + "</span>원";
		
		$tr = $("<tr height='40px'>");
		$td = $("<td>",{colspan:"3",style:"padding-left: 15px; font-size: 14px; font-weight:bold;", html:menuName});
		$tr.append($td);
		$("#buyList").append($tr);
		
		
		
		
		$tr = $("<tr height='40px' id='buyTr"+menuNum+"' style='border-bottom:1px solid black;' >");
		
		$td = $("<td>",{style:"padding: 15px; font-size: 14px;"});
		$input = $("<input>",{"type":"button", "class":"btn buyCancel", "data-code":menuNum, "data-price":menuPrice, "value":"X"});
		$td.append($input);
		$tr.append($td);
		
		$td  = $("<td>",{html:vprice});
		$tr.append($td);
		
		$td = $("<td>");
		$input = $("<input>",{"type":"button", "style":"background-color:white; width: 23px; border: 0.5px solid #38BCC6;", "class":"btn btnMinus", "value":"-"});
		$td.append($input);
		$input = $("<input>",{"type":"text","style":"width: 23px;", "name":"quantity", "value":qty, "readonly":"readonly", "data-code":menuNum, "data-price":menuPrice, "data-menuName":menuName});
		$td.append($input);
		$input = $("<input>",{"type":"hidden","name":"menuNum", "value":menuNum});
		$td.append($input);
		$input = $("<input>",{"type":"button", "style":"background-color:white; width: 23px; border: 0.5px solid #38BCC6;", "class":"btn btnPlus", "value":"+"});
		$td.append($input);
		
		$tr.append($td);
		$("#buyList").append($tr);
		$('#readMenu-dialog').dialog("close");
		
		totalBuyAmt=totalBuyAmt+menuPrice;
		$("#totalBuyAmt").text(totalBuyAmt);
	
	});
});

$(function(){
	$("body").on("click",".buyCancel", function(){
		var menuNum = $(this).attr("data-code")
		var menuPrice = parseInt($(this).attr("data-price"));
		var t = "#buyTr"+menuNum;
		var qty = $(t+" input[name=quantity]").val();
		if(! qty){
			qty = 0;
		}
		
		$(t).prev().remove();
		$(t).remove();
		
		
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());
		totalBuyAmt=totalBuyAmt-(menuPrice*parseInt(qty));
		$("#totalBuyAmt").text(totalBuyAmt);
	});
});

$(function(){
	$("body").on("click",".btnPlus", function(){
		var menuPrice = parseInt($(this).closest("tr").find(".buyCancel").attr("data-price"));
		var qty = parseInt($(this).parent().children("input[name=quantity]").val());
		var productPrice = parseInt($(this).closest("tr").find(".productPrice").text());
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());
		
		qty = qty +1;
		productPrice = productPrice+menuPrice;
		
		$(this).prev().prev().val(qty);
		$(this).closest("tr").find(".productPrice").text(productPrice);
		
		totalBuyAmt=totalBuyAmt+menuPrice;
		$("#totalBuyAmt").text(totalBuyAmt);
	});
	
	$("body").on("click",".btnMinus", function(){
		var menuPrice = parseInt($(this).closest("tr").find(".buyCancel").attr("data-price"));
		var qty = parseInt($(this).parent().children("input[name=quantity]").val());
		var productPrice = parseInt($(this).closest("tr").find(".productPrice").text());
		var totalBuyAmt = parseInt($("#totalBuyAmt").text());
		
		if(qty<=0){
			return;
		}
		
		qty = qty-1;
		productPrice = productPrice-menuPrice;
		
		$(this).next().val(qty);
		$(this).closest("tr").find(".productPrice").text(productPrice);
		
		totalBuyAmt=totalBuyAmt-menuPrice;
		$("#totalBuyAmt").text(totalBuyAmt);
	});
});

$(function(){
	$("body").on("click",".allCancel", function(){
		$("#buyList").empty();
		$("#totalBuyAmt").text(0);
	})
});

$(function(){
	$("body").on("click","#order",function(){
		var payTotalBuyAmt = $("#totalBuyAmt").text();
		$("#choiceMenu").hide();
		$("#buyList input[name=quantity]").each(function(){
			var menuNum = $(this).attr("data-code");
			var menuName = $(this).attr("data-menuName");
			var menuPrice = $(this).attr("data-price");
			var quantity = $(this).val();
			var pay = parseInt(menuPrice)*parseInt(quantity);
			
			var $tr, $td,$span;
			$tr = $("<tr height='40px'>");
			$td = $("<td>",{colspan:"3",style:"padding-left: 15px; font-weight:bold; font-size: 14px;", html:menuName});
			$tr.append($td);
			$("#payBuyList").append($tr);
			
			$tr = $("<tr height='35px' style='border-bottom:1px solid black;'>");
			$td = $("<td>",{colspan:"2",style:"padding-left: 15px; font-size: 14px;"});
			$span = $("<span>",{text:quantity});
			$td.append($span);
			$span = $("<span>",{text:"개"});
			$td.append($span);
			$tr.append($td);
			$td = $("<td>",{html:pay+"원"});
			$tr.append($td);
			$("#payBuyList").append($tr);
		});
		
		if(payTotalBuyAmt<${dto.minorder}){
			alert("최소 주문금액 이상부터 주문이 가능합니다.");
			$("#choiceMenu").show();
			return false; 
		};
		
		$("#pay").show();
		$("#payTotalBuyAmt").text(payTotalBuyAmt);
	});
	
});

$(function(){
	$("body").on("click", "#orderCancel",function(){
		$("#payBuyList").empty();
		$("#pay").hide();
		$("#choiceMenu").show();
	});
});

$(function(){
	$("body").on("click","#pay_btn",function(){
		var f = document.payForm;
		var str ="";
		
		str = f.addr1.value;
		if(!str){
			alert("정확한 주소를 입력해 주세요.");
			return;
		}
		str = f.addr2.value;
		if(!str){
			alert("정확한 상세 주소를 입력해 주세요.");
			return;
		}
		
		str = f.tel.value;
		if(!str){
			alert("정확한 전화번호를 입력해 주세요.");
			return;
		}
		
		str = f.foodorderhowpay.value;
		if(!str){
			alert("결제 방법을 선택해 주세요.");
			return;
		}
		
		str = f.foodorderdeliverymethod.value;
		if(!str){
			alert("배달 방법을 선택해 주세요.");
			return;
		}
		
		
		f.action = "<%=cp%>/franchise/newOrder";
		f.submit();
	});
});

$(function(){
	$("body").on("click",".howpay", function(){
		var $table = $(this).closest("table");
		
		$table.find(".howpay").each(function(){
			$(this).removeClass('userclick');
		});
		
		$(this).addClass('userclick');
		var foodorderhowpay = $(this).attr('data-foodorderhowpay');
		$('#foodorderhowpay').val(foodorderhowpay);
	});
	$("body").on("click",".deliverymethod",function(){
		var $table = $(this).closest("table");
		$table.find(".deliverymethod").each(function(){
			$(this).removeClass('userclick');
		});
		
		$(this).addClass('userclick');
		var deliverymethod = $(this).attr('data-deliverymethod');
		$('#foodorderdeliverymethod').val(deliverymethod);
	});
	
	
	var s = $(".preViewContent").text();
	$(".preViewContent").html(s);
});
</script>
<style type="text/css">
.userclick {
	background: #989898;
}
</style>
</head>
<body>


<form method="post" name="payForm">
<!-- 메뉴 선택회면 -->
<div id="choiceMenu">
	<div class="sideOrderBox" style="overflow: scroll; max-height: 400px;">
	<aside class="sideOrderBox2">
	   <table style="width: 330px; border:1px solid #DCDBDB; height: 200px; background-color: white; max-height: 400px; border-collapse: collapse;">
	      
		      <tr class="orderBoxTitile">
		         <td colspan="3" rowspan="2"  style="color: white; font-size: 18.4px; font-family: '배달의민족 한나체 Pro','bm-hanna-pro';">&nbsp; 주문표<a class="allCancel"><span style="float: right; padding-right: 20px; color: white;"><i class="fas fa-trash-alt"></i></span></a> </td>
		      </tr>
		      
		      <tbody id = "buyList">
		      </tbody>
		      
		      <tr height="35px;">
		         <td colspan="3" style="border-top:1.5px solid #DCDBDB; text-align: right;">배달요금 2,000원 별도</td>
		      </tr>
		      
		      <tr height="40px;">
		         <td  colspan="3" style="background-color:#fff8eb; color:red; text-align: right; font-size: 15px; border-top:1px solid #DCDBDB; "><span>합계 :</span> <span id="totalBuyAmt">0</span><span>원</span></td>
		      </tr>
		      
		      <tr height="46px;" style="padding-top: 10px;">
		         <td colspan="3" style="background-color:#38BCC6; text-align: center; color:white; font-size: 17px; border-top:1px solid #DCDBDB;" id="order">주문하기</td>
		      </tr>
		      
	   </table>
	</aside>
	</div>
	
	<div class="storeBox">
			<div class="store_basic">
				<ul>
					<li id="shop_title">${dto.name}</li>
				</ul>
				<div id="store_content">
					<ul>
						<li><img id="store_img" alt="logo"
							src="<%=cp%>/resource/dashboard/${dto.titleimg}" onerror="this.src='<%=cp%>/resource/img/ready.jpg'"></li>
					</ul>
					<div id="st_content">
						<ul>
							<li>
								<span style="color: #F2D51B">&nbsp;
									<c:forEach  begin="1" end="${aveStarCount2 }">
										★
									</c:forEach>
								<c:forEach  begin="${aveStarCount2+1 }" end="5">
										☆
								</c:forEach>								
								</span> ${aveStarCount }
							</li>
							<li id="red">&nbsp;4,000원 할인</li>
							<li>&nbsp;<span id="light_gray">최소주문금액 </span>${dto.minorder}</li>
							<li>&nbsp;<span id="light_gray">결제</span> 신용카드,현금,<span
								id="red"> 배다링 결제</span></li>
							<li style="margin-left: 80px;">&nbsp;<span id="light_gray">배달
									시간</span> ${dto.deliTime }분 <span><a href=""><i
										class="far fa-question-circle"></i></a> </span>
							</li>
						</ul>
						<input type="hidden" name = "restaurantsNum" value = "${dto.restaurantsNum}">
					</div>
				</div>
				<div id="st_notice">
					<ul>
						<li><i class="fas fa-bullhorn"></i><span
							style="font-weight: bold;"> 사장님알림</span></li>
						<li style="color: gray; text-overflow: ellipsis; white-space: nowrap; width: 400px; overflow: hidden;"><span class="preViewContent">${dto.introduce}</span><span> <a
								href=""> <i class="fas fa-chevron-right"></i></a></span>
						</li>
					</ul>
				</div>
	
				<div style="clear: both;">
					<ul class="tabs">				 
							<li id="tab-0" data-tab="0" style="width: 190.5px; text-align: center;">메뉴</li>
							<li id="tab-1" data-tab="1" style="width: 190.5px; text-align: center;">리뷰</li>
							<li id="tab-2" data-tab="2" style="width: 190.5px; text-align: center;">정보</li>
					</ul>
				</div>
				<div id="contentLayout"></div>
			</div>
	</div>
</div>

<!-- 결제화면 -->
<div id="pay" style="display: none; min-height: 1045px">

<div class="sideOrderBox" style="overflow: scroll; max-height: 400px;">
	<aside class="sideOrderBox2">
	   <table style="width: 330px; border:1px solid #DCDBDB; height: 200px; background-color: white; max-height: 400px; border-collapse: collapse;">
	      
		      <tr class="orderBoxTitile">
		         <td colspan="3" style="color: white; font-size: 15.4px; font-family: '배달의민족 한나체 Pro','bm-hanna-pro';">&nbsp; 주문내역 </td>
		      </tr>
		      
		  	  <tr height="35px;" style="border-bottom: 1px solid black">
		         <td colspan="3" style="border-top:1.5px solid #DCDBDB; font-weight:bold; font-size:15px; text-align: left; padding-left: 13px;">${dto.name}</td>
		      </tr>
		  		
		     
		      <tbody id = "payBuyList">
		      </tbody>
		      
		      <tr height="35px;">
		         <td colspan="3" style="border-top:1.5px solid #DCDBDB; text-align: right;">배달요금 2,000원 별도</td>
		      </tr>
		      
		      <tr height="40px;">
		         <td  colspan="3" style="background-color:#fff8eb; color:red; text-align: right; font-size: 15px; border-top:1px solid #DCDBDB; "><span>합계 :</span> <span id="payTotalBuyAmt"></span><span>원</span></td>
		      </tr>
		      
		      <tr height="46px;" style="padding-top: 10px;">
		         <td id="pay_btn" colspan="2" style="background-color:#38BCC6; text-align: center; color:white; font-size: 17px; border-top:1px solid #DCDBDB;">결제하기</td>
		         <td  style="background-color:#c8c8c8; text-align: center; color:white; font-size: 17px; border-top:1px solid #DCDBDB;" id = "orderCancel">취소</td>
		      </tr>
		      
	   </table>
	</aside>
	</div>


<div id="order_main_body">
		<div id="order_header">결제하기</div>
		<div class="order_container_box">
			<div class="order_sub_header">배달정보</div>
			<table class="location_table">
				<tr>
					<td class="pay_table_info">주소</td>
					<td class="pay_table_input"><input type="text" id="addr1" name="addr1"></td>
				</tr>
				<tr>
					<td></td>
					<td class="pay_table_input"><input type="text" id="addr2" placeholder="(필수)상세주소 입력" name="addr2">
				</tr>
				<tr>
					<td class="pay_table_info">휴대전화번호</td>
					<td class="pay_table_input"><input type="text" id="usertel" placeholder="(필수)휴대전화 번호 입력" name="tel"></td>
				</tr>
				<tr>
					<td></td>
					<td class="pay_table_chkbox"><input type="checkbox">안심번호 사용</td>
				</tr>
			</table>
		</div>
		
		<div class="order_container_box">
			<div class="order_sub_header">주문시 요청사항</div>
			<div class="pay_textarea"><textarea placeholder="코로나 19 예방을 위해 비대면 배달 권장드립니다 요기서 결제 선택 후 '문 앞 배달'을 요청사항에 남겨주세요" style="resize: none;" name="memo"></textarea>
			<p style="text-align: right; margin: 0px; font-size: 13px; ">0 / 100자</p>
			</div>
		</div>
		
		<div class="order_container_box">
			<div class="order_sub_header">결제수단 선택</div>
			<table class="each_pay_table">
				<tr>
					<td colspan="3" class="order_text_line"><b>배달링결제</b> 웹에서 미리 결제 -5% <br>
						<p>* 신용카드와 휴대전화 결제는 Internet Explorer에서 가능합니다.<p>
					</td>
				</tr>
				<tr>
					<td class="each_pay howpay" data-foodorderhowpay="신용카드"><span style="color: #888787"><i class="fas fa-credit-card"></i>  </span>신용카드</td>
					<td class="each_pay howpay" data-foodorderhowpay="휴대전화"><span style="color: #888787"><i class="fas fa-mobile"></i>  </span>휴대전화</td>
				</tr>
				<tr>
					<td class="each_pay howpay" data-foodorderhowpay="카카오페이"><span style="color: #888787"><i class="fas fa-wallet"></i>  </span>카카오페이</td>
					<td class="each_pay howpay" data-foodorderhowpay="네이버페이"><span style="color: #888787"><i class="fas fa-wallet"></i>  </span>네이버페이</td>
				</tr>
				<tr>
					<td colspan="3" class="order_text_line"><b>현장결제</b> 음식받고 직접 결제</td>
				</tr>
				<tr>
					<td class="each_pay howpay" data-foodorderhowpay="현장신용카드"><span style="color: #888787"><i class="fas fa-credit-card"></i>  </span>신용카드</td>
					<td class="each_pay howpay" data-foodorderhowpay="현장현금"><span style="color: #888787"><i class="fas fa-money-bill-wave-alt"></i>  </span>현금</td>
				</tr>
			</table>
			<input type="hidden" id="foodorderhowpay" name="foodorderhowpay" value="">
		</div>
		
		<div class="order_container_box">
			<div class="order_sub_header">수령 방법</div>
			<table class="each_pay_table">
			<tr>
					<td class="each_pay deliverymethod" style="width: 304px;" data-deliverymethod="배달"><span style="color: #888787"><i class="fas fa-bicycle"></i>  </span>배달</td>
					<td class="each_pay deliverymethod" data-deliverymethod="직접수령"><span style="color: #888787"><i class="fas fa-shopping-bag"></i>  </span>직접수령</td>
			</tr>
			</table>
			<input type="hidden" id="foodorderdeliverymethod" name="foodorderdeliverymethod" value="">
		</div>
		
		<div class="order_container_box">
			<div class="order_sub_header">마일리지 사용</div>
			<table class="each_pay_table">
				<tr>
					<td style="text-align: center; width: 125px;">마일리지</td>
					<td class="point_use_input" style="width: 225px;"><input type="text" style="width: 220px; height: 30px;border-radius: 2px; border: 1px solid #c8c8c8;"></td>
					<td><button style="width: 75px; height: 35px; border-radius: 10px; font-size: 11px"><b>모두사용</b></button></td>
				</tr>
			</table>
		</div>	
	</div>
</div>
</form>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_order.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_user.css" type="text/css">
<script type="text/javascript">

$(function(){
	
	$(".detailOrderBtn").click(function(){
		var foodOrderNum = $(this).attr("data-foodOrderNum");
		/* $("#orderDetail-dialog").each(function(){
			this.reset();
		}); */
		var restaurantsNum = $(this).attr("data-restaurantsNum");
		
		$('#orderDetail-dialog').dialog({
			  modal: true,
			  height: 546,
			  width: 632,
			  title: '주문 상세 내역',
			  open: function() {
	
					
					var url="<%=cp%>/mypage/readOrderDetail";
					var query = "foodOrderNum="+foodOrderNum;
					
					var fn = function(data){
						
						var dto = data.dto;
						var list = data.list;
						var name = dto.name;
						var foodOrderDate = dto.foodOrderDate;
						var foodOrderTotalPrice = dto.foodOrderTotalPrice;
						var foodOrderHowPay = dto.foodOrderHowPay;
						var fctel = dto.fctel;
						var foodOrderAddr = dto.foodOrderAddr;
						var memo = dto.memo;
						
						$("#fcName").html(name);
						$("#foodOrderDate").html(foodOrderDate);
						$("#foodOrderTotalPrice").html(foodOrderTotalPrice);
						$("#foodOrderHowPay").html(foodOrderHowPay);
						$("#fctel").html(fctel);
						$("#foodOrderAddr").html(foodOrderAddr);
						$("#memo").html(memo);
						
					
						var out="";
						for(var i=0; i<list.length; i++) {
							var item = list[i];
							if(item==null) continue;
								
							console.log(item);
							
							var menuName = item.menuName;
							var qty = item.qty;
							var orderOnePrice = item.orderOnePrice;
							
							out+="<tr height='40' style='border-bottom:1px solid #cccccc;'>";
							out+="<td style='padding: 10px 10px 5px 15px; font-size: 15px;'>"+menuName+"("+qty+"개) </td>";
							out+="<td style='padding: 10px 10px 10px 15px; font-size: 15px;' align='right'> "+orderOnePrice+"원 </td>";
							out+="</tr>";
						}
						
						$("#orderDetailMenuList").html(out);
						$(".viewBtn").attr("data-restaurantsNum",restaurantsNum);
						
					};

					ajaxJSON(url, "get", query, fn);
				
			  },
			  close: function(event, ui) {
			  }
		});
	});
});


$(function(){
	$("body").on("click",".viewBtn",function(){
		var restaurantsNum = $(this).attr("data-restaurantsNum");
		location.href = "<%=cp%>/franchise/page?restaurantsNum="+restaurantsNum;
	});
});

$(function(){
	$("body").on("click",".review_btn",function(){
		var url = "<%=cp%>/mypage/checkReview";
		var foodOrderNum = $(this).attr("data-orderNum");
		var restaurantsNum = $(this).attr("data-restaurantsNum");
		var query = "foodOrderNum="+foodOrderNum+"&restaurantsNum="+restaurantsNum;
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var ok = data.passed;
				if(ok=="true"){
					forwordreview(foodOrderNum,restaurantsNum);
				} else {
					alert("이미 리뷰를 작성하셨습니다.")
				}
			}
		    ,error:function(jqXHR) {
		    	console.log(e.responseText);
		    }
		});
		
	});
});
</script>
<script>
function forwordreview(foodOrderNum,restaurantsNum){
  	location.href = "<%=cp%>/review/write?foodOrderNum="+foodOrderNum+"&restaurantsNum="+restaurantsNum;
}
</script>

<div class="mypage_container">
    <div class="body-container">
        <div class="body-left">
            <div class="list-group">
                <div class="list-group-item lefthead"> 마이페이지</div>
                <a href="<%=cp%>/mypage/userInfo" class="list-group-item active">회원정보</a>
                <a href="<%=cp%>/mypage/userorderList" class="list-group-item">주문내역</a>
                <a href="<%=cp%>/mypage/recommendlist" class="list-group-item">내가 쓴 게시물</a>
                <a href="<%=cp%>/mypage/reviewList" class="list-group-item">내가 쓴 리뷰</a>
                <a href="<%=cp%>/mypage/myInquire" class="list-group-item">내가 쓴 문의</a>
                <a href="<%=cp%>/mypage/message" class="list-group-item">회원정보수정</a>
                <a href="#" class="list-group-item">회원탈퇴</a>
            </div>   
        </div>
    
        <div class="body-right">
            <div class="body-right-container">
                 <div class="body-title">
                     <h3><span style="font-family: Webdings">4</span> 주문 내역 </h3>
                 </div>
			<div class="order_container">
				<div style="width: 100%; margin: 20px auto;">
				<form name="orderForm" method="GET">
					<table style="margin: auto; width: 800px; border-spacing: 0px;" >
							<tr height="35px;">
								<td align="left" style="font-size: 13px;">
								  ${dataCount}개(${page}/${total_page} 페이지)
								</td>
								<td align="right">
								<span style="font-size: 13px;">배달ing&nbsp;>&nbsp;주문내역</span>
								</td>
							</tr>
					</table>
					
					<table style="width: 800px; margin: 0px auto; border-spacing: 0; border-collapse:collapse;">
						<tr align="center" bgcolor="#EFF1F3" height="50" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 14px;">
							<th width="60" style="color:#787878;">번호</th>
							<th width="300" style="color:#787878;" align="center">상호명&nbsp; & &nbsp;주문내역</th>
							<th width="80" style="color:#787878;">금&nbsp;액</th>
							<th width="100" style="color:#787878;">주문날짜</th>
							<th width="70" style="color:#787878;">주문상태</th>
							<th width="70" style="color:#787878;"></th>
						</tr>
					
						<c:forEach var="dto" items="${list}">
						<tr align="center" height="140" style="border-bottom: 1px solid #cccccc;">
							<td>${dto.listNum}</td>
							<td>
								<p style="font-weight: bold;"> ${dto.name} </p>
								<p> ${dto.menuName} </p> 
							</td>
							<td>${dto.foodOrderTotalPrice}원</td>
							<td>${dto.foodOrderDate}</td>
							<td>${dto.foodOrderState}</td>
							<td>
								<button type="button" class="btn btn1 review_btn" data-orderNum="${dto.foodOrderNum}" data-restaurantsNum="${dto.restaurantsNum}">리뷰쓰기</button> <br>
								<button type="button" class="btn btn2" onclick="javascript:location.href='<%=cp%>/franchise/page?restaurantsNum=${dto.restaurantsNum}'">가게보기</button> <br>
								<button type="button" class="btn btn3 detailOrderBtn" data-foodOrderNum="${dto.foodOrderNum}" data-restaurantsNum="${dto.restaurantsNum}">주문상세</button>
							</td>
						</tr>	
						</c:forEach>
					</table>
				
					<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
					   <tr height="40">
							<td align="center">
						        ${dataCount==0? "주문 내역이 없습니다." : paging}
							</td>
					   </tr>
					</table>
					
					<table style="width: 800px; margin: 20px auto; border-spacing: 0px; border-top: 1px solid #787878;">
						<tr height="100">
							<td align="right">
								<button type="button" onclick="javascript:location.href='<%=cp%>/mypage/userorderList'">새로고침</button>
							</td>				
						</tr>			
					</table>
					</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="orderdetail_container"id="orderDetail-dialog" style="display: none;">
            	<div style="width: 600px;">
            		<table style="width: 100%; border: 1px solid #cccccc; border-collapse: collapse; border-spacing: 0;">
						<tr height="45">
							<td colspan="2" align="left" style="padding: 10px 10px 5px 15px; font-size: 20px; font-weight: bold;" id="fcName">
							</td>
						</tr>
						<tr height="50" style="border-bottom:1px solid #cccccc;">	
							<td align="left" style="font-size: 15px; padding: 5px 10px 5px 15px;">
								<span>주문일시 :</span> <span id="foodOrderDate"></span>
							</td>
							<td align="right" style="padding-right: 5px;">
								<button class="btn btn2 viewBtn">가게보기</button>
							</td>
						</tr>
						
						<tbody id="orderDetailMenuList"></tbody>
            			
            			<tr height="40">
            				<td style="padding: 0px 0px 0px 15px; font-size: 17px; font-weight: bold;"> 총 주문금액 </td>
            				<td style="padding: 10px 10px 10px 15px; font-size: 17px; font-weight: bold;" align="right" id="foodOrderTotalPrice">  </td>
            			</tr>
            			<tr style="border-bottom:1px solid #cccccc;">
            				<td style="padding: 0px 10px 5px 15px; font-size:17px; font-weight: bold;"> 결제방법 </td>
            				<td style="padding: 0px 10px 5px 5px; font-size:17px; font-weight: bold;" align="right" id="foodOrderHowPay">  </td>
            			</tr>
            			<tr height="40">
            				<td colspan="2" style="padding: 5px 0px 0px 15px; font-size:17px; font-weight: bold;"> 배달주소 </td>
            			</tr>
            			<tr style="border-bottom:1px solid #cccccc;">
            				<td colspan="2" style="padding: 0px 10px 5px 15px; font-size:15px; font-weight: normal;" id="foodOrderAddr"> 서울 성북구 석관동 </td>
            			</tr>
            			<tr>
            				<td colspan="2" style="padding: 5px 0px 0px 15px; font-size:17px; font-weight: bold;"> 전화번호 </td>
            			</tr>
            			<tr style="border-bottom:1px solid #cccccc;">
            				<td colspan="2" style="padding: 0px 10px 5px 15px; font-size: 15px;"id="fctel"> </td>
            			</tr>
            			<tr>
            				<td colspan="2" style="padding: 5px 0px 0px 15px; font-size:17px; font-weight: bold;"> 가게 사장님께 </td>
            			</tr>
            			<tr>
            				<td colspan="2" style="padding: 0px 10px 5px 15px; font-size: 15px;" id="memo">  </td>
            			</tr>
            		</table>
            		
            	</div>
            </div>
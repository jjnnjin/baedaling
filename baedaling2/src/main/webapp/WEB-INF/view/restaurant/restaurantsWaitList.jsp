<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>	

<link rel="stylesheet" href="<%=cp%>/resource/css/restaurant_list.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">

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
			if($.trim(data)=="error") {
				listPage(1);
				return false;
			}	
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
	$("#tab-2").addClass("active");

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="<%=cp%>/restaurant/restaurantlist";	
		location.href=url;
		
	});
});


function searchList() {
	var f=document.searchForm;
	f.ready.value=$("#selectReady").val();	
	f.action="<%=cp%>/restaurant/restaurantWaitlist";
	f.submit();
}

$(function(){
	$("body").on("click", "input[name='admission']", function(){
		var restaurantsNum = $(this).next().val();
		var url = "<%=cp%>/restaurant/updateRestaurant";
		var query = "restaurantsNum=" + restaurantsNum;
		var fn = function(data){
			 location.href="<%=cp%>/restaurant/restaurantWaitlist";
		};
		ajaxJSON(url, "post", query, fn);
	});
});

</script>

<div class="body-container" align="center">
	<div class="body-title" align="center">
			 <h3 style="margin-top: 70px; margin-bottom: 50px; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 35px; ">
			 |&nbsp;대기 중인 가게 목록 <span><img id="f_img2" src="<%=cp%>/resource/img/gangg.png"> </span></h3>
		</div>
		
		<div class="mylist" style="clear: both; margin-left: -93px; width: 125%;" >
			<ul class="tabs" style="margin-bottom: 20px;">
				<li id="tab-1" data-tab="1">가게 계정 정보</li>
				<li id="tab-2" data-tab="2">대기 중인 가게</li>
			</ul>
		</div>
		
		<div style="width: 125%; margin-left: -90px;">
		<table style="margin: 10px auto; width: 100%; border-spacing: 0px;" >
				<tr height="35px;">
					<td align="left" style="font-size: 13px;">
					 ${dataCount}개(${page}/${total_page} 페이지)
					</td>
					<td align="right">
					</td>
					
					 <td align="right">
			          <select id="selectReady" class="btn" onchange="searchList();">
			          		<option value="1" ${ready=="1" ? "selected='selected'":""}>대기중인 가게</option>
			          		<option value="2" ${ready=="2" ? "selected='selected'":""}>승인된 가게</option>
			          </select>
			      </td>
				</tr>
		</table>
		
	<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			<tr id="list_table" align="center" bgcolor="#EFF1F3" style=" border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; ">
				<th width="60" style="color:#787878;">번호</th>
				<th width="90" style="color:#787878;">이름</th>
				<th width="80" style="color:#787878;">아이디</th>
				<th width="80" style="color:#787878;">상호명</th>
				<th width="130" style="color:#787878;">업체등록번호</th>
				<th width="150" style="color:#787878;">주&nbsp;&nbsp;소</th>
				<th width="100" style="color:#787878;">상&nbsp;&nbsp;태</th>
			</tr>
			
	<c:forEach var="dto" items="${list}">	
			<tr align="center" height="50" style="border-bottom: 2px solid #cccccc; font-size: 12px;">
				<td>${dto.listNum}</td>
				<td>${dto.name}</td>
				<td>${dto.userId}</td>
				<td>${dto.mutualName}</td>
				<td>${dto.licenseNumber}</td>
				<td>${dto.addr1}${dto.addr2}</td>
				<td>
					<c:if test="${dto.ready == 1}">
						<form name = "restaurantsNumForm" method="post">
							<input type="button" name="admission" value="승인">
							<input type="hidden" name="restaurantsNum" value = "${dto.restaurantsNum }"> 
						</form>
					</c:if>
					
					<c:if test="${dto.ready == 2}">
						승인완료된매장입니다.
					</c:if>
				</td>
			</tr>
	</c:forEach>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
				<td align="center">
			        ${dataCount==0?"승인 대기중인 가게가 없습니다.":paging}
				</td>
		   </tr>
		</table>
		
		
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px; border-top: 2px solid #cccccc;">
			<tr height="100">
				<td align="left" style="width: 200px;">
					<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/restaurant/restaurantWaitlist'">새로고침</button>
				</td>
				  <td align="left" style="width: 460px;">
					   <form name="searchForm" action="<%=cp%>/restaurant/restaurantWaitlist" method="post">
			              <select name="condition" class="btn">
			                  <option value="name"     ${condition=="name" ? "selected='selected'":""}>가게이름</option>
			                  <option value="mutualName"   ${condition=="mutualName" ? "selected='selected'":""}>상호명</option>
			                  <option value="licenseNumber"  ${condition=="licenseNumber" ? "selected='selected'":""}>사업자등록번호</option>
			            </select>
			            <input type="text" name="keyword" class="btn" value="${keyword}">
			            <input type="hidden" name="ready" value="${ready}">
			            <input type="hidden" name="page" value="1">
			            <button type="button" class="btn" onclick="searchList()">검색</button>
					</form>
			      </td>		
			</tr>		
		</table>
	</div>
</div>	

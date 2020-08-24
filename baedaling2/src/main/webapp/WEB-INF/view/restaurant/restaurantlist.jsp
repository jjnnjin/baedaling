<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/restaurant_list.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">

<style type="text/css">

ul.mylist, ol.mylist {
    list-style: none;
    margin: 0px;
    padding: 0px;
    max-width: 250px;
    width: 100%;
}

.ui-dialog .ui-dialog-buttonpane {
    text-align: left;
    border-width: 1px 0 0 0;
    background-image: none;
    margin-top: .5em;
    padding: .3em 1em .5em .4em;
    border-top-color: #dddada;
}

</style>

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
	$("#tab-1").addClass("active");

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="<%=cp%>/restaurant/restaurantWaitlist";	
		location.href=url;
		
		
	});
});

function searchList() {
	var f=document.searchForm;
	f.enabled.value=$("#selectEnabled").val();	
	f.action="<%=cp%>/restaurant/restaurantlist";
	f.submit();
}

function detaileRestaurant(restaurantsNum) {
	var dlg = $("#user-dialog").dialog({
		autoOpen: false,
		modal: true,
		buttons: {
			"수정": function() {
				updateOk();
			},
			"닫기": function() {
				$(this).dialog("close");
			}
		},
		height: 430,
		width: 800,
		title: "가게상세정보",
		close: function(event, ui){
		}
	});
	
	var url = "<%=cp%>/restaurant/detaileRestaurant";
	var query = "restaurantsNum="+restaurantsNum;
	
	$.ajax({
		url:url,
		data:query,
		type:'post',
		success: function(data){
			$('#user-dialog').html(data);
			dlg.dialog("open");
		},
		beforeSend: function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		},
		error: function(jqXHR) {
			if(jqXHR.status==403) {
				location.href="<%=cp%>/restaurant/restaurantlist";
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function updateOk() {
	var f = document.detailedRestaurantForm;
	
	if(! f.stateCode.value) {
		f.stateCode.focus();
		return;
	}
	var url="<%=cp%>/restaurant/updateUserState";
	var query=$("#detailedRestaurantForm").serialize();
	
	$.ajax({
		url: url,
		data: query,
		type: 'post',
		success: function(data){
			$("form input[name=page]").val("${page}");
			searchList();
		},
		beforeSend: function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error: function(jqXHR) {
			if(jqXHR.status==403) {
				location.href="<%=cp%>/restaurant/restaurantlist";
			}
			console.log(jqXHR.responseText);
		}
	});
	$('#user-dialog').dialog("close");
}

function selectStateChange() {
	
}
</script>

<div class="body-container" align="center">
	<div class="body-title" align="center">
			 <h3 style="margin-bottom: 30px; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 35px; ">
			 |&nbsp;가게 목록 <span><img id="f_img2" src="<%=cp%>/resource/img/gangg.png"> </span></h3>
		</div>
		
		<div class="mylist" style="border: 1px solid white; margin-bottom:20px; clear: both; margin-left: -93px; width: 125%;">
			<ul class="tabs" style="margin-bottom: 20px;">
				<li id="tab-1" data-tab="1">가게 계정 정보</li>
				<li id="tab-2" data-tab="2">대기 중인 가게</li>
			</ul>
		</div>
		
		<div style="width:125%; margin-left: -90px;">
		<table style="margin: 10px auto; width: 100%; border-spacing: 0px;" >
				<tr height="35px;">
					<td align="left" style="font-size: 13px;">
					 ${dataCount}개(${page}/${total_page} 페이지)
					</td>
					<td align="right">
					</td>
					
					 <td align="right" style="margin-bottom: 21px; margin-top: 10px;">
			          <select id="selectEnabled" class="btn" onchange="searchList();">
			          		<option value="" ${enabled=="" ? "selected='selected'":""}>&nbsp;계정상태&nbsp;</option>
			          		<option value="1" ${enabled=="1" ? "selected='selected'":""}>활성 계정</option>
			          		<option value="0" ${enabled=="0" ? "selected='selected'":""}>잠금 계정</option>
			          </select>
			      </td>
				</tr>
		</table>
		
		<table style="width: 100%;  margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
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
			<tr onclick="detaileRestaurant('${dto.restaurantsNum}');" align="center" height="50" style="border-bottom: 1px solid #cccccc; font-size: 12px;">
				<td>${dto.listNum}</td>
				<td>${dto.name}</td>
				<td>${dto.userId}</td>
				<td>${dto.mutualName}</td>
				<td>${dto.licenseNumber}</td>
				<td>${dto.addr1}${dto.addr2}</td>
				<td>
					${dto.enabled=="1"?"활성":"잠금"}
				</td>
			</tr>
	</c:forEach>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
				<td align="center">
			        ${dataCount==0?"등록된 가맹점이 없습니다.":paging}
				</td>
		   </tr>
		</table>
		
		
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px; border-top: 2px solid #cccccc;">
			<tr height="100">
				<td align="left" style="width: 200px;">
					<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/restaurant/restaurantlist'">새로고침</button>
				</td>
				  <td align="center" style="width:500px;">
					   <form name="searchForm" action="<%=cp%>/restaurant/restaurantlist" method="post">
			              <select name="condition" class="btn">
			                  <option value="userId"     ${condition=="userId" ? "selected='selected'":""}>아이디</option>
			                  <option value="name"   ${condition=="name" ? "selected='selected'":""}>이름</option>
			                  <option value="tel"        ${condition=="tel" ? "selected='selected'":""}>전화번호</option>
			            </select>
			            <input type="text" name="keyword" class="btn" value="${keyword}">
			            <input type="hidden" name="enabled" value="${enabled}">
			            <input type="hidden" name="page" value="1">
			            <button type="button" class="btn" onclick="searchList()">검색</button>
					</form>
			      </td>
			      <td align="left" style="width: 200px;">
			      </td>		
			</tr>		
		</table>
	<div id="user-dialog" style="display: none"></div>
	</div>
</div>
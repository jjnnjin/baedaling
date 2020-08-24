<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/user_list.css" type="text/css">

<script type="text/javascript">

function searchList() {
	var f=document.searchForm;
	f.enabled.value=$("#selectEnabled").val();
	f.action="<%=cp%>/manage/userlist";
	f.submit();
}

function detailUser(userId) {
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
		height: 450,
		width: 800,
		title: "회원상세정보",
		close: function(event, ui) {
		}
	});
	
	var url = "<%=cp%>/manage/detaileUser";
	var query = "userId="+userId;
	
	$.ajax({
		url:url,
		data: query,
		type: 'post',
		success: function(data){
			$('#user-dialog').html(data);
			dlg.dialog("open");
		},
		beforeSend: function(jqXHR){
			jqXHR.setRequestHeader("AJAX", true);
		},
		error : function(jqXHR) {
			if (jqXHR.status == 403) {
				location.href="<%=cp%>/manage/userlist";
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function updateOk() {
	var f = document.detailedUserForm;
	
	if(! f.stateCode.value) {
		f.stateCode.focus();
		return;
	}
	
	var url = "<%=cp%>/manage/updateUserState";
	var query=$("#detailedUserForm").serialize();

	$.ajax({
		url : url,
		data : query,
		type: 'post',
		success : function(data) {
			$("form input[name=page]").val("${page}");
			searchList();
		},
		beforeSend : function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true); 
		},
		error : function(jqXHR) {
			if (jqXHR.status == 403) {
				location.href="<%=cp%>/manage/userlist";
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
	$('#user-dialog').dialog("close");
}

</script>
  
<div class="body-container" align="center">
		  <div class="body-title" align="center">
     <h3 style="margin-bottom: 40px; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 35px; ">|&nbsp;회원 목록 <span><img id="f_img2" src="<%=cp%>/resource/img/gangg.png"> </span></h3>
		</div>
		
	<div style="width:125%; margin-left: -90px;" >
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
				<tr height="35px;">
					<td align="left" style="font-size: 13px; margin-bottom: 20px;">
					  ${dataCount}개(${page}/${total_page} 페이지)
					</td>
					<td align="right">
					</td>
					
				 <td align="right">
			          <select id="selectEnabled" class="btn" onchange="searchList();">
			          		<option value="" ${enabled=="" ? "selected='selected'":""}>&nbsp;계정상태&nbsp;</option>
			          		<option value="1" ${enabled=="1" ? "selected='selected'":""}>활성 계정</option>
			          		<option value="0" ${enabled=="0" ? "selected='selected'":""}>잠금 계정</option>
			          </select>
			      </td>
			      
				</tr>
				
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			<tr id="list_table" align="center" bgcolor="#EFF1F3" style=" border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; ">
				<th width="60" style="color: #787878;">번호</th>
				<th width="70" style="color: #787878;">이름</th>
				<th width="100" style="color: #787878;">아이디</th>
				<th width="80" style="color: #787878;">생년월일</th>
				<th width="100" style="color: #787878;">전화번호</th>
				<th width="120" style="color: #787878;">이메일</th>
				<th width="150" style="color: #787878;">주&nbsp;&nbsp;소</th>
				<th width="100" style="color: #787878;">가입날짜</th>
				<th width="100" style="color: #787878;">상태</th>
			</tr>
			
	<c:forEach var="dto" items="${list}">			
			<tr align="center" height="50" onclick="detailUser('${dto.userId}');"
				style="border-bottom: 1px solid #cccccc; font-size: 12px;">
				<td>${dto.listNum}</td>
				<td>${dto.userName}</td>
				<td>${dto.userId}</td>
				<td>${dto.birth}</td>
				<td>${dto.tel}</td>
				<td>${dto.email}</td>
				<td>${dto.addr1}${dto.addr2}</td>
				<td>${dto.created_date}</td>
				<td>
					${dto.enabled=="1"?"활성":"잠금"}
				</td>
			</tr>
	</c:forEach>			
			
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
				<td align="center">
			        ${dataCount==0?"등록된 게시물이 없습니다.":paging}
				</td>
		   </tr>
		</table>
		
		<div style="margin-left: 20px;">
		<table style="width: 102%; margin: 10px auto; border-spacing: 0px; border-top: 2px solid #cccccc; margin-left: -17px; ">
			<tr height="100">
				<td align="right" style="margin: 10px auto; margin-left: 50px;">
					<button class="btn" style="margin-left:-30px;"  type="button" onclick="javascript:location.href='<%=cp%>/manage/userlist'">새로고침</button>
				</td>
				<td align="center" style="padding-right: 120px;">
				   <form name="searchForm" action="<%=cp%>/restaurant/userlist" method="post">
			              <select name="condition" class="btn">
			                  <option value="userId"     ${condition=="userId" ? "selected='selected'":""}>아이디</option>
			                  <option value="userName"   ${condition=="userName" ? "selected='selected'":""}>이름</option>
			                  <option value="email"      ${condition=="email" ? "selected='selected'":""}>이메일</option>
			                  <option value="tel"        ${condition=="tel" ? "selected='selected'":""}>전화번호</option>
			            </select>
			            <input type="text" name="keyword" class="btn" value="${keyword}">
			            <input type="hidden" name="enabled" value="${enabled}">
			            <input type="hidden" name="page" value="1">
			            <button type="button" class="btn" onclick="searchList()">검색</button>
					</form>
			      </td>
			</tr>		
		</table>
		</div>
		
	</div>
	<div id="user-dialog" style="display: none; height: 295px;"></div>
</div>
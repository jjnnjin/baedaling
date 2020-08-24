<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
  .questionQ{
    display: inline-block;
    padding:7px 10px;
	font-weight: bold;
	color: #ffffff;
	background: #027d87;
	text-align: center;
  }
  .questionSubject{
    display: inline-block;
    position:absolute;
    width:748px;
    overflow:hidden;
    text-overflow:ellipsis;
    word-spacing:nowrap;
    box-sizing:border-box;
    padding:7px 3px;
    margin-left:1px;
	font-weight: bold;
	color: #ffffff;
	background: #027d87;
  }
  .answerA{
    display: inline-block;
    padding:7px 10px;
	font-weight: bold;
	color: #ffffff;
	background: #cc4901;
	text-align: center;
  }
  .answerSubject{
    display: inline-block;
    position:absolute;
    width:748px;
    overflow:hidden;
    text-overflow:ellipsis;
    word-spacing:nowrap;
    box-sizing:border-box;
    padding:7px 3px;
    margin-left:1px;
	font-weight: bold;
	color: #ffffff;
	background: #cc4901;
  }
</style>


<script type="text/javascript">
function deleteInquire() {
<c:if test="${sessionScope.user.userId=='admin' || sessionScope.user.userId==dto.userId}">
var q = "num=${dto.num}&${query}";
var url = "<%=cp%>/inquire/delete?"+q;

if(confirm("삭제하시겠습니까 ? ")){
	location.href=url;
}
</c:if>

<c:if test="${sessionScope.user.userId!='admin' && sessionScope.user.userId!=dto.userId}">
	alert("게시물을 삭제할 수 없습니다.");
</c:if>
}

function updateInquire() {
	<c:if test="${sessionScope.user.userId==dto.userId}">
		var q = "num=${dto.num}&page=${page}";
		var url = "<%=cp%>/inquire/update?"+q;
		
		location.href=url;
	</c:if>
	
	<c:if test="${sessionScope.user.userId!=dto.userId}">
		alert("게시물을 수정할 수 없습니다.");
	</c:if>
}

function updateAdminInquire() {
	<c:if test="${sessionScope.user.userId=='admin'}">
		var q = "num=${dto.num}&page=${page}";
		var url = "<%=cp%>/inquire/updateAdmin?"+q;
		
		location.href=url;
	</c:if>
	
	<c:if test="${sessionScope.user.userId!='admin'}">
		alert("게시물의 답변을 등록할 수 없습니다.");
	</c:if>
}

</script>

<link rel="stylesheet" href="<%=cp%>/resource/css/page.css" type="text/css">
<div align="center" class="box">
<h3 style="width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 35px; ">Q&nbsp; &amp; &nbsp;A&nbsp;&nbsp;<span><img id="f_img2" src="<%=cp%>/resource/img/gangg.png"></span> </h3>
	<br>
	<table  class="freeboard">
		<tr class="f_line">
			<td align="left" style="color: gray; background: #EFF8FB; " class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;Q</td>
			<td align="left" id="ftitle" style="font-size:15px; color: gray; background: #EFF8FB;" >${dto.subject}</td>
		</tr>
		
		<tr class="f_line">
			<td align="left" style="color: gray;" class="subtitle">작성자</td>
			<td align="left" id="subcontent">${dto.userName}</td>
		</tr>
		
		<tr class="f_line">
			<td class="subtitle">작성일</td>
			<td id="subcontent2">
				${dto.created}
			</td>
		</tr>
		
		<tr class="fcontent" align="left" >
			<td colspan="2" align="left" style="height: 75px; border-bottom: 1px solid #DDDFE0; padding: 5px; valign="top"">${dto.question}</td>
		</tr>
	
<c:if test="${not empty dto.answer }">
		<tr class="f_line">
			<td align="left" style="color: gray; background: #EFF8FB;" class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;A</td>
			<td align="left" style="background: #EFF8FB;" id="ftitle">[RE]&nbsp;&nbsp; ${dto.subject}</td>
		</tr>
		
		<tr class="f_line">
			<td align="left" style="color:gray;" class="subtitle">담당자</td>
			<td align="left" id="subcontent">${dto.answerName}</td>
		</tr>
		
		<tr class="f_line">
			<td align="left" style="color:gray;" class="subtitle">답변일자</td>
			<td align="left" id="subcontent2">${dto.answer_created}</td>
		</tr>
		
				
		<tr class="fcontent" align="left" >
			<td colspan="2" align="left" style="height: 20px; valign="top"">${dto.answer}</td>
		</tr>
		
		<!-- 
	<tr height="35" style="border-bottom: 1px solid #cccccc;">
	    <td width="50%" align="left" >
	         담당자 : ${dto.answerName}
	    </td>
	    <td width="50%" align="left" >
	        답변일자 : ${dto.answer_created}
	    </td>
	</tr>
	
	<tr style="border-bottom: 1px solid #cccccc;">
	  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="90">
	      <div style="min-height: 75px; ">${dto.answer}</div>
	   </td>
	</tr>
	 -->
</c:if>	

	</table>
	
	<table>
		<tr class="f_button" align="right">
		<td>
			<c:if test="${sessionScope.user.userId==dto.userId && (empty dto.answer)}">
				<button type="button" id="f_btn3" onclick="updateInquire();">수정</button>
			</c:if>
			<c:if test="${sessionScope.user.userId=='admin'}">
				<button type="button" id="f_btn3" onclick="updateAdminInquire();">답변</button>
			</c:if>	
			<c:if test="${sessionScope.user.userId==dto.userId || sessionScope.user.userId=='admin'}">
				<button type="button" id="f_btn3" onclick="deleteInquire();">삭제</button>
			</c:if> 
			
		</td>
		<td>
			<button type="button" id="f_btn3" onclick="javascript:location.href='<%=cp%>/inquire/list?${query}';">리스트</button>
		</td>
		</tr>
	</table>
</div>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
function delete_send() {
	var q = "num=${dto.num}&${query}";
	var url = "<%=cp%>/event/delete?" + q;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
			location.href=url;
	}
}
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/write.css" type="text/css">

<div align="center" class="box">
	<h3
		style="width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 35px;">
		EVENT&nbsp;<span><img id="f_img2"
			src="<%=cp%>/resource/img/gangg.png"></span>
	</h3>
	<br>
	<table class="freeboard">
		<tr class="f_line">
			<td align="left" style="font-weight: bold;" class="subtitle">제목</td>
			<td align="left" id="ftitle" style="color: gray;">${dto.subject}</td>
		</tr>

		<tr class="f_line">
			<td align="left" style="color: gray;" class="subtitle">작성자</td>
			<td align="left" id="subcontent">${dto.userName}</td>
		</tr>

		<tr class="f_line">
			<td class="subtitle">작성일</td>
			<td id="subcontent2">${dto.created}<span style="display: inline-block; margin-left: 30px; font-weight: bold;">조회수</span>
			<span style="margin-left: 20px;">${dto.hitCount}</span>
			</td>
		</tr>

		<tr class="fcontent" align="left">
			<td colspan="2" align="left"
				style="padding-left: 20px; border-bottom: 1px solid #cccccc;">
				<div style="margin: 0px; width: 940px; min-height:300px; border-color: #DDDFE0; resize: none; color: gray; border-radius: 4px;">${dto.content}</div>
			</td>
		</tr>
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
			<td colspan="2" align="left" style="padding-left: 5px; color: gray;">
			      이전글 :
			       <c:if test="${not empty preReadDto}">
			              <a href="<%=cp%>/event/article?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
			       </c:if>
			</td>
		</tr>
			
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
			<td colspan="2" align="left" style= "padding-left: 5px; color: gray;">
			      다음글 :
			       <c:if test="${not empty nextReadDto}">
			              <a href="<%=cp%>/event/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
			       </c:if>
			</td>
		</tr>		
	</table>
	
	<div class="f_button" align="right" style="padding-right: 250px; padding-top: 10px;">
		<c:if test="${sessionScope.user.separate==2}">
			<button class="btn" type="button"onclick="javascript:location.href='<%=cp%>/event/update?num=${dto.num}&page=${page}';">수정</button>
			<button class="btn" type="button" onclick="delete_send();">삭제</button>
		</c:if>
		<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/event/list';">리스트</button>
	</div>
	
</div>
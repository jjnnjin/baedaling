<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/page.css" type="text/css">
<script type="text/javascript">
function deleteBoard() {
	
	  var q = "num=${dto.num}&${query}";
	  var url = "<%=cp%>/fcnotice/delete?" + q;

	  if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
	  	location.href=url;
}
function updateBoard() {
	
	  var q = "num=${dto.num}&page=${page}";
	  var url = "<%=cp%>/fcnotice/update?" + q;

	  location.href=url;
	

	
}

</script>

<div align="center" class="box">
<h3 style="width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 35px; ">가맹점 공지사항&nbsp;<span><img id="f_img2" src="<%=cp%>/resource/img/gangg.png"></span> </h3>
	<br>
	<table  class="freeboard">
		<tr class="f_line">
			<td align="left" style="font-size:15px; margin-top:3px; font-weight: bold;" class="subtitle">제목</td>
			<td align="left" id="ftitle" style="font-size:15px; color: gray;" > ${dto.subject }</td>
		</tr>
		
		<tr class="f_line">
			<td align="left" style="color: gray;" class="subtitle">작성자</td>
			<td align="left" id="subcontent">${dto.userName }</td>
		</tr>
		
		<tr class="f_line">
			<td class="subtitle">작성일</td>
			<td id="subcontent2">
				${dto.created }
				<span style="display: inline-block; margin-left:30px; font-weight: bold;">조회수</span><span style="margin-left:20px;">${dto.hitCount }</span>
			</td>
		</tr>
		
		<tr class="fcontent" align="left" >
			<td colspan="2" align="left" style="padding-left: 20px; border-bottom: 1px solid #DDDFE0;" >${dto.content }</td>
		</tr>
	
		
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
	    	<td colspan="2" align="left" style="padding-left: 5px; color: gray;">
			       첨&nbsp;&nbsp;부 
			</td>
			<c:forEach var="vo" items="${listFile}">
				<tr height="35" style="border-bottom: 1px solid #cccccc;  color: black;">
	    			<td colspan="2" align="left" style="padding-left: 5px;">
	      				<a href="<%=cp%>/fcnotice/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a>
          				(<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte)
	    			</td>
				</tr>
			</c:forEach>
		</tr>
		
			
		
		
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
			<td colspan="2" align="left" style="padding-left: 5px; color: gray;">
			       이전글 :
			        <c:if test="${not empty preReadDto}">
            			<a href="<%=cp%>/fcnotice/article?num=${preReadDto.num}&${query}">${preReadDto.subject}</a>
        			</c:if>
			</td>
		</tr>
			
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
			<td colspan="2" align="left" style="padding-left: 5px; color: gray;">
			       다음글 :
			        <c:if test="${not empty nextReadDto}">
            			<a href="<%=cp%>/fcnotice/article?num=${nextReadDto.num}&${query}">${nextReadDto.subject}</a>
        			</c:if>
			</td>
		</tr>
	</table>
	<div class="f_button" align="right">
	<c:if test="${sessionScope.user.userName=='관리자'}">
		<button type="button" id="f_btn2" onclick="updateBoard();">수정</button>
		<button type="button" id="f_btn" onclick="deleteBoard()">삭제</button>
	</c:if>	 
		<button type="button" id="f_btn3" onclick="javascript:location.href='<%=cp%>/fcnotice/list?${query}';">리스트</button>
	</div>
</div>
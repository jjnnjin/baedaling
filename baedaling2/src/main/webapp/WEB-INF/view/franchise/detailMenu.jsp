<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<div class="menuImg_table" align="center" style="width:663px; margin: 5px; padding: 5px;">
	<c:forEach var="dto" items="${detailList }">
		<ul class="menu" data-menuNum="${dto.menuNum }">
			<li><img class="store_menu_img" src="<%=cp%>/uploads/menu/${dto.saveFilename}" onerror="this.src='<%=cp%>/resource/img/ready.jpg'"></li>
			<li style="text-align: center;" >${dto.menuName }</li>
			<li style="text-align: center;">${dto.menuPrice }</li>
		</ul>
	</c:forEach>
</div>




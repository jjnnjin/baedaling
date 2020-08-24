<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<c:if test="${empty sessionScope.user}">
<div align="right" style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; background: #fbfbfb; height: 25px; font-size: 15px; font-color: #5a5a5a; margin-right:100px; height: 30px; line-height: 32px;" > 
		<a href="<%=cp%>/user/login" style="color: #5a5a5a;">로그인</a> &nbsp;|&nbsp;
		<a href="<%=cp%>/user/joincheck" style="color: #5a5a5a;">회원가입</a>
</div>
</c:if>

<c:if test="${not empty sessionScope.user}">
<div align="right" style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; background: #fbfbfb; height: 30px; font-size: 15px; color: #C8C8C8; margin-right:100px; font-color: #5a5a5a; line-height: 32px; " > 
		<a href="<%=cp%>/user/logout" style="color: #8b8b8b;">로그아웃</a> &nbsp;|&nbsp;
		<c:if test="${sessionScope.user.separate=='0'}">
			<a href="<%=cp%>/mypage/userInfo" style="color: #5a5a5a;">마이페이지</a>
		</c:if>
		<c:if test="${sessionScope.user.separate=='2'}">
			<a href="<%=cp%>/manage/userlist" style="color: #5a5a5a; font-size: 16px;">관리자</a> &nbsp;|&nbsp;
			<a href="<%=cp%>/main" style="color: #5a5a5a; font-size: 16px;">유저</a>
		</c:if>
		<c:if test="${sessionScope.user.separate=='1'}">
			<a href="<%=cp%>/mypage/userInfo">마이페이지</a> &nbsp;|&nbsp;
			<a href="<%=cp%>/dashboard/dashboard?restaurantsNum=${sessionScope.user.restaurantsNum}">점주</a>
		</c:if>
</div>
</c:if>
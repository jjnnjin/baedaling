<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/@kfonts/bm-hanna-pro/index.css" />
<div id="menu-wrapper" >
      <div id="menu" class="container">
         <a href="<%=cp%>/main"><img align="left" src="<%=cp%>/resource/img/logo.png" id="logo-img"></a>
         	<ul class="snip1275">
            	<li><a href="<%=cp%>/manage/userlist" data-hover="회원">회원 관리</a></li>
            	<li><a href="<%=cp%>/restaurant/restaurantlist" data-hover="가게">가게 관리</a></li>
               	<li><a href="<%=cp%>/fcnotice/list" data-hover="가맹점">가맹점 공지사항</a></li>
				<li><a href="<%=cp%>/inquire/list" data-hover="문의">1:1 문의 리스트</a></li>
			</ul>
      </div>
   </div>
   <c:choose>
   <c:when test="${searchBar=='manageBoard'}">
   		<div style="background-image: url('<%=cp%>/resource/img/banner/managebanner.jpg'); width:100%; height:345px;">
		   <div id="logo" class="container">
		   </div>
	   </div>
	    <hr style="border: 0.5px solid #D8D8D8;"> 
   	</c:when>
   	<c:otherwise>
   	</c:otherwise>
   	</c:choose>

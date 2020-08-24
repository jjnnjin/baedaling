<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/list.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_user.css" type="text/css">
<div class="mypage_container">
    <div class="body-container11">
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
				<div class="body-title" align="center">
		     		<h3 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 35px; ">
     				Q&nbsp; &amp; &nbsp;A <span><img width="70px" height="70px"
					src="<%=cp%>/resource/img/gangg.png"></span> </h3>
    			</div>
     
     	<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
        	 <tr height="35">
            	<td align="left" width="50%" style="color:black;">
               	 	${dataCount}개(${page}/${total_page} 페이지)
            	</td>
            	<td align="right">
                	&nbsp;
            	</td>
         	</tr>
      	</table>

      <table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
        <tr align="center" bgcolor="#EFF1F3" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; "> 
            <th width="60" style="color: #787878;">번호</th>
            <th style="color: #787878;">제목</th>
            <th width="100" style="color: #787878;">작성자</th>
            <th width="80" style="color: #787878;">작성일</th>
            <th width="80" style="color: #787878;">처리결과</th>
        </tr>
       
      <c:forEach var="dto" items="${list}">
       <tr align="center" bgcolor="#ffffff" height="50" style="border-bottom: 1px solid #cccccc;"> 
            <td>${dto.listNum}</td>
            <td align="left" style="padding-left: 10px;">
                <%--  <a href="${articleUrl}&num=${dto.num}" style="color: gray;">${dto.subject}</a> --%>
                ${dto.subject}
            </td>
            <td>${dto.userId}</td>
            <td>${dto.created}</td>
            <td>${not empty dto.answer ? "답변완료" : "답변대기"}</td>
        </tr>
       </c:forEach>
    </table>
       
      <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
         <tr height="35">
         	<td align="center">
         		${dataCount==0 ? "등록된 게시물이 없습니다." : paging}
         	</td>
         </tr>
      </table>
      
      <table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
         <tr height="40">
 			<td>
 				&nbsp;
 			</td>
            <td align="left" width="100">
                <button type="button" class="btn" onclick="javascript:location.href='/mypage/myInquire';">새로고침</button>
            </td>
         </tr>
      </table>
    </div>
</div>
</div>
</div>
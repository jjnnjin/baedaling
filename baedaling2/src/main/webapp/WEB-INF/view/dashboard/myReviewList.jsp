<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="https://unpkg.com/@kfonts/bm-hanna-pro/index.css" />
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/js/util-jquery.js"></script>
<link rel="stylesheet" href="<%=cp%>/resource/css/reviewList.css" type="text/css">

<div style="width: 25px; height:5px; background-color: #F9F9FA">&nbsp;</div>
<div style="width: 100%;">
	<div style="width: 500px; height: 45px; margin-left: 330px; margin-top: 20px;">
		<span style="font-family: "><button id="review_button1" onclick="location.href=<%=cp%>/dashboard/myReviewList?restaurantsNum=${sessionScope.user.restaurantsNum}">내 가게 리뷰</button></span><span><button id="review_button2" onclick="location.href=<%=cp%>/dashboard/myReplyList?restaurantsNum=${sessionScope.user.restaurantsNum}">내가 쓴 댓글</button> </span>
	</div>
	<div style="width: 500px; height: 45px; margin-left: 340px; margin-top: 20px;">
		<span style="font-family:'배달의민족 한나체 Pro', '배달의민족한나체Pro'; color: gray;">리뷰  ${reviewCount}개 (${pageNo}/${total_page} 페이지)</span>
	</div>
	
	<table id="reviewTable">
		<tr style=" border: 1px solid #E6E5E5; text-align: center; width: 800px; height: 50px;">
			<td style="font-weight:bold; border-bottom : 1px solid #E6E5E5; width: 100px;">No</td>
			<td style="font-weight:bold; border-bottom: 1px solid #E6E5E5; width: 150px;">작성자</td>
			<td style="font-weight:bold; border-bottom: 1px solid #E6E5E5; width: 150px;">메뉴</td>
			<td style="font-weight:bold; border-bottom: 1px solid #E6E5E5; width: 100px;">별점</td>
			<td style="font-weight:bold; border-bottom: 1px solid #E6E5E5; width: 150px;">날짜</td>
		</tr>
 <c:forEach var="dto" items="${list}">		
		<tr style=" border: 1px solid #E6E5E5; text-align: center; width: 800px; height: 45px;">
			<td style="width: 100px;"><a href="" style="color: gray;">${dto.reviewNum}</a></td>
			<td style="width: 150px;"><a href="${articleUrl}&reviewNum=${dto.reviewNum}" style="color: gray;"><span style="font-weight: bold;">${dto.userName}</span>님의 리뷰 </a></td>
			<td style="width: 150px;"><a href="${articleUrl}&reviewNum=${dto.reviewNum}" style="color: gray;">${dto.menuName}</a></td>
			<td style="width: 100px;"><a href="" style="color: gray;">${dto.starCount}</a></td>
			<td style="width: 150px;"><a href="" style="color: gray;">${dto.created}</a></td>
		</tr>
</c:forEach>
		<tr style=" border: 1px solid #E6E5E5; text-align: center; width: 800px; height: 45px;">
			<td style="width:200px; font-family:'배달의민족 한나체 Pro', '배달의민족한나체Pro'; color: gray;">${reviewCount==0 ? "등록된 게시물이 없습니다.":paging}</td>
		</tr>
	</table>
</div>

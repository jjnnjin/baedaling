<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="https://unpkg.com/@kfonts/bm-hanna-pro/index.css" />
<style>
/* The Magic */
.accordion:hover .accordion-item:hover .accordion-item-content,
.accordion .accordion-item--default .accordion-item-content {
    height: 7.5em;
}

.accordion-item-content,
.accordion:hover .accordion-item-content {
    height: 0;
    overflow: hidden;
    transition: height .25s;
}

/* Aesthetic */
body {
  background: #f9f9fa;
}

.accordion {
    padding: 0;
    margin: 0 auto;
    width: 100%;
    font-family: "PT Sans" sans-serif
}

.accordion .accordion-item {
  background-image: linear-gradient(90deg, #eee, #f5f5f5, #eee);
  padding-left: 2.3em;
  padding-bottom : 5px;
  padding-top : 5px;
  color: #eee;
  width: 140px;
}

.accordion h1 {
  margin: 0;
}

.accordion .accordion-item:nth-child(1) {
  background-color: hsl(200, 80%, 60%);
  background-image: linear-gradient(-90deg, #38BCC6, #38BCC6, #38BCC6);

}

.accordion .accordion-item:nth-child(2) {
  background-color: hsl(280, 60%, 45%);
  background-image: linear-gradient(-90deg, hsl(280, 80%, 60%), hsl(280, 60%, 45%) 2em, hsl(280, 80%, 60%));
}

.accordion .accordion-item:nth-child(3) {
  background-color: hsl(40, 80%, 40%);
  background-image: linear-gradient(-90deg, hsl(40, 80%, 60%), hsl(40, 80%, 45%) 2em, hsl(40, 80%, 60%));
}

.accordion .accordion-item:nth-child(4) {
  background-color: hsl(80, 40%, 40%);
  background-image: linear-gradient(-90deg, hsl(80, 80%, 40%), hsl(80, 80%, 35%) 2em, hsl(80, 80%, 40%));
}
</style>
<div class="sidebox">
<aside>
<div style="width: 100%; height: 1000px;" >
	<div>
		<ul class="dash_title">
			<li style="padding: 30px 0px 30px 40px; color: white;">매장 관리</li>
		</ul>
	</div>
	
	<div id="menu_content" class="snip1284">
		<ul style="margin-top: 20px;">
			<li id="dash_subTitle" style="margin-bottom: 40px;"><a style="color: #D2D4D4;" href="<%=cp%>/dashboard/dashboard?restaurantsNum=${sessionScope.user.restaurantsNum}"><span style="color: #D2D4D4;"><i class="fas fa-home"></i> </span>Home</a></li>
		</ul>
	</div>
	
	<div id="menu_content" class="snip1284">
		<ul style="margin-top: 20px;">
			<li id="dash_subTitle"><a style="color: #D2D4D4;" href="<%=cp%>/dashboard/orderlist?restaurantsNum=${sessionScope.user.restaurantsNum}">주문관리</a></li>
		</ul>
	</div>
	
	<div id="menu_content" class="accordion">
		<section class="accordion-item">
		<ul style="margin-top: 20px;">
			<li id="dash_subTitle"><a style="color: #D2D4D4;" href="<%=cp%>/menu/list?group=0">메뉴관리</a>
			<ul class="accordion-item-content">
			<li id="dash_subcontent"><a href="<%=cp%>/menu/list?group=1">주메뉴</a></li>
			<li id="dash_subcontent"><a href="<%=cp%>/menu/list?group=2">부메뉴</a></li>
			<li id="dash_subcontent"><a href="<%=cp%>/menu/list?group=3">사이드메뉴</a></li>
			<li id="dash_subcontent"><a href="<%=cp%>/menu/list?group=4">음료&주류</a></li>
			</ul>
			</li>
		</ul>
		</section>
	</div>
	
	<div id="menu_content" class="accordion">
		<section class="accordion-item">
		<ul style="margin-top: 20px;">
			<li id="dash_subTitle" style="color: #D2D4D4;"><a style="color: #D2D4D4;" href="">가게 정보관리</a>
			<ul class="accordion-item-content">
			<li id="dash_subcontent" ><a href="<%=cp%>/dashboard/updateRestaurant?restaurantsNum=${sessionScope.user.restaurantsNum}">가게 정보수정</a></li>
			<li id="dash_subcontent" ><a href="<%=cp%>/dashboard/fcinfo_read?restaurantsNum=${sessionScope.user.restaurantsNum}">상세정보수정</a></li>
			</ul>
			</li>
		</ul>
		</section>
	</div>
	
	
	<div id="menu_content" class="snip1284">
		<ul style="margin-top: 20px;">
			<li id="dash_subTitle"><a style="color: #D2D4D4;" href="<%=cp%>/dashboard/salesList?restaurantsNum=${sessionScope.user.restaurantsNum}">매출관리</a></li>
		</ul>
	</div>
	
	<div id="menu_content" class="accordion">
		<section class="accordion-item">
		<ul style="margin-top: 20px;">
			<li id="dash_subTitle"><a style="color: #D2D4D4;" href="<%=cp%>/dashboard/myReviewList?restaurantsNum=${sessionScope.user.restaurantsNum}">게시글관리</a>
				<ul class="accordion-item-content">
					<li id="dash_subcontent" ><a href="<%=cp%>/dashboard/myReviewList?restaurantsNum=${sessionScope.user.restaurantsNum}">내 가게 리뷰</a></li>
					<li id="dash_subcontent" ><a href="<%=cp%>/dashboard/myReplyList?restaurantsNum=${sessionScope.user.restaurantsNum}">내가 쓴 댓글</a></li>			
				</ul>
			</li>
		</ul>
		</section>
	</div>
	
	<div id="menu_content" class="snip1284">
		<ul style="margin-top: 20px;">
			<li id="dash_subTitle" style="margin-bottom: 40px;"><a style="color: #D2D4D4;" href="<%=cp%>/fcnotice/list"><span style="color: #D2D4D4;"></span>가맹점 공지사항</a></li>
		</ul>
	</div>

	<div>
		<ul style="text-align: center;" class="snip1284">
			<li style="margin-top:200px; font-weight:bold; font-size: 20px; color: #5D5E5F;">오늘매출 ${today.todaySales == '0' ? 0 : today.todaySales}원</li>
			<li style="margin-top: 50px; font-weight:bold; font-size: 18px; color: white;"><a href="<%=cp%>/main">메인화면</a></li>
		</ul>
	</div>
	
</div>	
</aside>
</div>
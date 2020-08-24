<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
$(function(){
	$(".mini_menu_box").click(function(){
		var typecategorynum = $(this).attr('data-typecategorynum');
		location.href = "<%=cp%>/restaurants/list?typecategorynum="+typecategorynum;
	});
});

$(function(){
	$("body").on("click",".fc_list_table",function(){
		var num = parseInt($(this).attr('data-restaurantsNum'));
		var url = "<%=cp%>/franchise/page?restaurantsNum="+num;
		location.href = url;
	});
	$("body").on("change","#sort_type",function(){
		var f = document.listform;
		f.action="<%=cp%>/restaurants/list";
		f.submit();
	})
});
</script>


<link rel="stylesheet" href="<%=cp%>/resource/css/restaurantsmenulist.css" type="text/css">
<div id="mini_menu">
	<table class="mini_menu2">
		<tr>
			<td class="mini_menu_box" data-typecategorynum="13">전체</td>
			<td class="mini_menu_box" data-typecategorynum="2">한식</td>
			<td class="mini_menu_box" data-typecategorynum="6">중식</td>
			<td class="mini_menu_box" data-typecategorynum="5">일식</td>
			<td class="mini_menu_box" data-typecategorynum="11">양식</td>
			<td class="mini_menu_box" data-typecategorynum="7">치킨</td>
			<td class="mini_menu_box" data-typecategorynum="10">피자</td>
			<td class="mini_menu_box" data-typecategorynum="8">패스트푸드</td>
			<td class="mini_menu_box" data-typecategorynum="3">분식</td>
			<td class="mini_menu_box" data-typecategorynum="1">브런치</td>
			<td class="mini_menu_box" data-typecategorynum="4">야식</td>
			<td class="mini_menu_box" data-typecategorynum="9">디저트</td>
		</tr>
		</table>
</div>
<div class="menu_content_box" style="min-height: 400px;">
<form name="listform" method="get">
	<div class="select_sort">
		<select id="sort_type" name="state">
			<option value="distance" ${state=="distance"?"selected='selected'":""}>기본 거리순</option>
			<option value="star" ${state=="star"?"selected='selected'":""}>별점순</option>
			<option value="review" ${state=="review"?"selected='selected'":""}>리뷰순</option>
		</select>
	</div>
	<c:if test="${empty list}">
		<div style="margin-top: 50px;">
			 <h3 style="text-align: center; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 20px; ">이런 주변에 검색되는 음식점이 없네요.<span><img src="<%=cp%>/resource/img/chicken.jpg" style="width: 50px; height: 50px;"></span></h3>
		</div>
	</c:if>
<c:forEach var="dto" items="${list}" varStatus="status">
	<c:if test="${status.index==0}">
           <c:out value="<div class='menu_content_etch_line lineheader'>" escapeXml="false"/>
    </c:if>
    <c:if test="${status.index!=0 && status.index%2==0}">
           <c:out value="</div><div class='menu_content_etch_line lineheader'>" escapeXml="false"/>
    </c:if>
		<table class="fc_list_table" data-restaurantsNum="${dto.restaurantsNum}">
			<tr>
				<td class="menu_td1"><div class="menu_img_box"><img src="<%=cp%>/resource/dashboard/${dto.savefilename}" onerror="this.src='<%=cp%>/resource/img/ready.jpg'" style="width: 85px; height: 85px;"></div></td>
				<td class="menu_td2">
					<b>${dto.name}</b>
					<br>
					<span><span style="color: #d6822b;">★</span><fmt:formatNumber pattern="0.0" value="${dto.starcount}"/> | 리뷰:${dto.reviewcount}개 | 거리:${dto.distance}Km</span>
					<br>
					<div>
						<div class="coupon_line">쿠폰할인</div>
						<div class="delivery_time">영업시간:${dto.openinghour}~${dto.endinghour}</div>
					</div>
				</td>
			</tr>
		</table>
</c:forEach>
<c:out value="</div>" escapeXml="false"/>
	<input type="hidden" name="typecategorynum" id="typecategorynum" value="${typecategorynum}">
	${paging}
	</form>
</div>
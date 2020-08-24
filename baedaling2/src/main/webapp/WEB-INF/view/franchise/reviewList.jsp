<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>



<div class="reviewList" style="width: 100px;">
<div class="reviewContent">
	<ul>
		<li id="score_text">${aveStarCount } </li>
		<li id="star_deco1">
			<c:forEach  begin="1" end="${aveStarCount2 }">
					★
			</c:forEach>
			<c:forEach  begin="${aveStarCount2+1 }" end="5">
					☆
			</c:forEach>
		
		</li>
	</ul>
</div>

<div class="reviewContent2" style="width: 700px;  min-height: 200px;  border: 1px solid #dadadb;">
	

	<ul>
		<li style="padding-left: 20px; padding-top: 32px; font-size: 15px;">리뷰 <span id="bold">  ${dataCount }</span>개 | 사장님 댓글 <span id="bold"> ${replyCount }</span>개</li>
	</ul>

<div class="reviewContent3" >
	<c:forEach var="dto" items="${list }">
		<ul style="padding-left: 10px; padding-top: 10px;">
			<li style="padding-left: 5px;"> <span style="font-size: 16px; font-weight: bold;">${dto.userName }님  </span> ${dto.created }</li>
			<li id="star_deco">
				<c:forEach  begin="1" end="${dto.starCount }">
					★
				</c:forEach>
				<c:forEach  begin="${dto.starCount+1 }" end="5">
					☆
				</c:forEach>
				
			</li>
			<li style="color: #15AFD6; margin-bottom: 10px; font-size: 13px; padding-top: 1px; padding-left: 5px;">${dto.menuName }</li>
			<li style="border-bottom: 0.5px solid #c8c8c8; padding-bottom: 5px;">
				<div style="font-size: 15px; padding: 5px;">
					${dto.content }
				</div>
			</li>
			<c:if test="${dto.reply != null }">
				<li style="background: #f0f0f0; height: 45px;"> <span style="font-size: 15px; font-weight: bold;"><span style="color: gray;"><i class="fas fa-level-up-alt fa-rotate-90" ></i></span> 사장님  </span> ${dto.replyCreated }</li>
				<li style="background: #f0f0f0; height: 50px; font-size: 14px; padding-left: 15px;">${dto.reply }</li>
			</c:if>
		</ul>
	</c:forEach>
	<ul style="padding-left: 10px; padding-top: 10px;">
		<li>
			${dataCount==0?"등록된 리뷰가 없습니다.":paging}
		</li>
	
	</ul>
</div>
	
</div>
</div>





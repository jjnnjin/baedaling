<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<div id="readMenu-dialog">
		<form name="readMenuForm" method="post">
			<div class="detail-image">
				사진
			
			</div>
			
			<div class="detail-text">
				<span>이름</span>
				${dto.menuName }
			</div>
			
			<div class="detail-price">
				<label>가격</label>
				<div>???</div>
			</div>
			
			<div class="quantity-control">
				<label>수량</label>
			</div>
			
			<div>
				<label>총 주문가격</label>
			</div>
		</form>
    </div>
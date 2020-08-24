<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<div class="storeInfo" style="width: 100px;">
<div class="infoContent">
<ul id="info_title">
	<li style="width: 200px;"><i class="fas fa-bullhorn"></i><span style="font-size: 14px; "> 사장님알림</span></li>	
</ul>

<ul style="padding: 10px;">
	<li>${dto.introduce }</li>
</ul>

<ul id="info_title">
	<li><span style="font-size: 14px; "><i class="fas fa-store"></i> 업체정보</span></li>	
</ul>

<ul id="info_content2">
	<li>  <span id="light_gray">영업시간</span>   ${dto.openingHour } - ${dto.endingHour }</li>
	<li>  <span id="light_gray">전화번호</span>   ${dto.fctel }</li>
	<li>  <span id="light_gray">주소</span>   ${dto.addr1 } ${dto.addr2 }</li>
</ul>

<ul id="info_title">
	<li><span style="font-size: 14px; "><i class="far fa-credit-card"></i> 결제정보</span></li>	
</ul>

<ul id="info_content2">
	<li>  <span id="light_gray">최소주문금액</span>  ${dto.minorder }원</li>
	<li>  <span id="light_gray">결제수단</span>   신용카드, 현금, 요기서 결제</li>
</ul>

<ul id="info_title">
	<li><span style="font-size: 14px; "><i class="far fa-credit-card"></i> 사업자정보</span></li>	
</ul>

<ul id="info_content2">
	<li>  <span id="light_gray">상호명</span>   ${dto.mutualName }</li>
	<li>  <span id="light_gray">사업자등록번호</span>   ${dto.licenseNumber }</li>
</ul>


<ul id="info_title">
	<li><span style="font-size: 14px; "><i class="far fa-file-alt"></i> 원산지정보</span></li>	
</ul>

<ul id="info_content2">
	<li> ${dto.origin }</li>
</ul>

</div>
</div>	
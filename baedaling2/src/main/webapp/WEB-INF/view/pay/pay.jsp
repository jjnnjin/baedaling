<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/pay.css" type="text/css">
<div id="order_main_body">
		<div id="order_header">결제하기</div>
		<div class="order_container_box">
			<div class="order_sub_header">배달정보</div>
			<table class="location_table">
				<tr>
					<td class="pay_table_info">주소</td>
					<td class="pay_table_input"><input type="text"></td>
				</tr>
				<tr>
					<td></td>
					<td class="pay_table_input"><input type="text" placeholder="(필수)상세주소 입력">
				</tr>
				<tr>
					<td class="pay_table_info">휴대전화번호</td>
					<td class="pay_table_input"><input type="text" placeholder="(필수)휴대전화 번호 입력"></td>
				</tr>
				<tr>
					<td></td>
					<td class="pay_table_chkbox"><input type="checkbox">안심번호 사용</td>
				</tr>
			</table>
		</div>
		
		<div class="order_container_box">
			<div class="order_sub_header">주문시 요청사항</div>
			<div class="pay_textarea"><textarea placeholder="코로나 19 예방을 위해 비대면 배달 권장드립니다 요기서 결제 선택 후 '문 앞 배달'을 요청사항에 남겨주세요" style="resize: none;"></textarea>
			<p style="text-align: right; margin: 0px; font-size: 13px; ">0 / 100자</p>
			</div>
		</div>
		
		<div class="order_container_box">
			<div class="order_sub_header">결제수단 선택</div>
			<table class="each_pay_table">
				<tr>
					<td colspan="3" class="order_text_line"><b>배달링결제</b> 웹에서 미리 결제 -5% <br>
						<p>* 신용카드와 휴대전화 결제는 Internet Explorer에서 가능합니다.<p>
					</td>
				</tr>
				<tr>
					<td class="each_pay"><i class="fas fa-credit-card"></i>신용카드</td>
					<td class="each_pay"><i class="fas fa-mobile"></i>휴대전화</td>
				</tr>
				<tr>
					<td class="each_pay"><i class="fas fa-wallet"></i>카카오페이</td>
					<td class="each_pay"><i class="fas fa-wallet"></i>네이버페이</td>
				</tr>
				<tr>
					<td colspan="3" class="order_text_line"><b>현장결제</b> 음식받고 직접 결제</td>
				</tr>
				<tr>
					<td class="each_pay"><i class="fas fa-credit-card"></i>신용카드</td>
					<td class="each_pay"><i class="fas fa-money-bill-wave-alt"></i>현금</td>
				</tr>
			</table>
		</div>
	</div>
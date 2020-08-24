<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_user.css" type="text/css">

<div class="mypage_container">
    <div class="body-container">
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
                 <div class="body-title">
                     <h3><span style="font-family: Webdings">4</span> 회원 정보 </h3>
                 </div>
                 <div id="mypage_container">
                 	<div class="alert-info">
			    		<p style="margin-left: 20px;"><i class="fas fa-info-circle"></i>
			    		<span style="font-weight: bold; font-size: 16px;">&nbsp;${sessionScope.user.userName}</span>&nbsp;님의 회원 정보입니다. </p>
			    		<p align="center">회원정보는 개인정보처리방침에 따라 안전하게 보호되며, 회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다. </p>
					</div>
                      <div class="mypage_box">
	                      <table style="margin: auto; width:95%; border-top: 2px solid #E6E6E6; border-bottom: 2px solid #E6E6E6; border-radius: 4px;">
	                      	<tr height="120">
	                      		<td align="center" width="20%" style="background-color: #F2F2F2; font-weight: bold; color:#848484; border-radius: 4px; ">아이디</td>
	                      		<td width="80%" style="padding-left: 15px;">${dto.userId}</td>
	                      	</tr>
	                      	<tr height="120">
	                      		<td align="center" style="background-color: #F2F2F2; font-weight: bold; color:#848484;">이&nbsp;름</td>
	                      		<td style="padding-left: 15px;">
	                      			${dto.userName}
	                      			<p style="color: gray; font-size: 12px; padding-top: 10px;">* 이름이나 생년월일, 성별 등의 정보가 변경되었다면 본인확인을 통해 정보를 수정할 수 있습니다.</p>	
	                      		</td>
	                      	</tr>
	                      	<tr height="120">
	                      		<td align="center" style="background-color: #F2F2F2; font-weight: bold; color:#848484;">생년월일</td>
	                      		<td style="padding-left: 15px;">${dto.birth}</td>
	                      	</tr>
	                      	<tr height="120">
	                      		<td align="center" style="background-color: #F2F2F2; font-weight: bold; color:#848484;">전화번호</td>
	                      		<td style="padding-left: 15px;">
	                      			${dto.tel}
	                      			<p style="color: gray; font-size: 12px; padding-top: 10px;">* 아이디, 비밀번호 찾기 등 본인확인이 필요한 경우 사용할 휴대전화입니다.</p>	
	                      		</td>
	                      	</tr>
	                      	<tr height="120">
	                      		<td align="center" style="background-color: #F2F2F2; font-weight: bold; color:#848484;">이메일</td>
	                      		<td style="padding-left: 15px;">${dto.email}</td>
	                      	</tr>
	                      	<tr height="120">
	                      		<td align="center" style="background-color: #F2F2F2; font-weight: bold; color:#848484;">주&nbsp;소</td>
	                      		<td style="padding-left: 15px;">
	                      			[&nbsp;${dto.zip}&nbsp;] <br>
	                      			${dto.addr1} <br>
	                      			${dto.addr2}
	                      		</td>
	                      	</tr>
	                      	<tr height="120">
	                      		<td align="center" style="background-color: #F2F2F2; font-weight: bold; color:#848484; border-radius: 4px;">가입날짜</td>
	                      		<td style="padding-left: 15px;">${dto.created_date}</td>
	                      	</tr>
	                      </table>
                      </div>
                 </div>
            </div>
        </div>
    </div>        
</div>

</body>
</html>
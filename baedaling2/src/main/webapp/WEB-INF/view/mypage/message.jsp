<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/message.css" type="text/css">

<div class="body-container">

	<form name="pwdChkForm" method="post" action="<%=cp%>/mypage/message">
    <div style="margin: 0px auto; padding-top:90px; width:420px;">
    	<div style="text-align: center;">
        	<span style="font-weight: bold; font-size:27px; color: #424951;"><strong>${title}</strong></span>
        </div>
        
        <div class="messageBox">
            <div style="line-height: 150%; padding-top: 35px;">
                 <!-- 	   탈퇴 하시겠습니까? <p>
                 	   회원 탈퇴를 위한 비밀번호를 다시 한번 입력해주세요. -->
                 ${message}
            </div>
            <div style="margin-top: 20px;">
            		 <div class="re-password">
            		 	<input type="password" name="userPwd" style="width: 300px; height: 46px; padding-left: 28px; margin-left: 43px;">
            		 </div>
                     <button type="submit" class="btnConfirm">확&nbsp;&nbsp;인</button>
            </div>
        </div>
     </div>   
	</form>
</div>
</body>
</html>
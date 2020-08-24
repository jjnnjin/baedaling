<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
function bgLabel(ob, id) {
    if(!ob.value) {
	    document.getElementById(id).style.display="";
    } else {
	    document.getElementById(id).style.display="none";
    }
}
</script>

<script type="text/javascript">

function sendLogin(){
	var f = document.loginForm;

	var str = f.userId.value;
	if(!str) {
	    alert("아이디를 입력하세요. ");
	    f.userId.focus();
	    return;
	}

	str = f.userPwd.value;
	if(!str) {
	    alert("패스워드를 입력하세요. ");
	    f.userPwd.focus();
	    return;
	}

	f.action = "<%=cp%>/user/login";
	f.submit();
}
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/loginform.css" type="text/css">

	<div class="body-container" >
		<div style="border-radius: 8px; border:1px solid #beb8b8; width: 460px; margin: 50px auto; padding-top: 30px; height: 380px;">
			<div style="text-align: center;">
				<span style="font-weight: bold; font-size: 35px; color: black; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro';">로그인</span>
			</div>
			
			<form action="loginForm" name="loginForm" method="post">
			<table style="margin: 15px auto; width: 100%; border-spacing: 0px;">
				<tr align="center" height="60">
					<td> 
					 	<label class="lbl text_login" id="lblUserId" style="margin-top: 21px; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro';">아이디</label>
						<input type="text" name="userId" id="userId" class="loginTF" maxlength="15" tabindex="1"
                           onfocus="document.getElementById('lblUserId').style.display='none';"
                           onblur="bgLabel(this, 'lblUserId');">
					</td>
				</tr>
				<tr align="center" height="60">
					<td>
						<label class="lbl text_login" id="lblUserPwd" style="margin-top: 21px; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro';">패스워드</label>
						<input type="password" name="userPwd" id="userPwd" class="loginTF" maxlength="15" tabindex="2"
                           onfocus="document.getElementById('lblUserPwd').style.display='none';"
                           onblur="bgLabel(this, 'lblUserPwd');">
					</td>
				</tr>
		  		<tr align="center" height="65" > 
		      		<td>
		        		<button type="button" onclick="sendLogin();" class="loginBtn" 
		        		style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 18px; margin-bottom: 30px; margin-top: 20px;">
		        			로그인
		        		</button>
		      		</td>
		  		</tr>
		  		<tr align="center" height="65" style="margin-top: 40px;">
		      		<td  style="margin-top: 40px;">
		       			<a href="<%=cp%>/" style="font-size: 15px; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro';">아이디찾기</a>&nbsp;&nbsp;&nbsp;
		       			<a href="<%=cp%>/" style="font-size: 15px; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro';">비밀번호찾기</a>&nbsp;&nbsp;&nbsp;
		      			<p style="font-size: 15px; color:gray; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro';">아직&nbsp;회원이&nbsp;아니신가요? 
		      				<a href="<%=cp%>/user/joincheck" style="font-size: 15px;">회원가입</a>
		      			</p>
		      		</td>
		  		</tr>
			</table>
			</form>	
		</div>
	</div>
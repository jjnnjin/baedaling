<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/message2.css" type="text/css">

<div class="body-container">
	
    <div style="margin: 0px auto; padding-top:90px; width:420px;">
    	<div style="text-align: center;">
        <%-- 	<span style="font-weight: bold; font-size:27px; color: #424951;"><strong>${title}</strong></span> --%>
        </div>
        
        <div class="messageBox">
            <div style="line-height: 150%; padding-top: 35px;">
                 
                 ${message}	
            </div>
            <div style="margin-top: 20px;">
                     <button type="button" class="btnConfirm" onclick="javascript:location.href='<%=cp%>/';">메인화면으로 이동</button>
                </div>
        </div>
     </div>   
	
</div>
</body>
</html>
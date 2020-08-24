<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%
   String cp = request.getContextPath();
// String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+cp;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/js/util-jquery.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<script type="text/javascript">
$(function(){
	$(document)
	   .ajaxStart(function(){ // AJAX 시작시
		   $("#loadingImage").center();
		   $("#loadingLayout").fadeTo("slow", 0.5);
	   })
	   .ajaxComplete(function(){ // AJAX 종료시
		   $("#loadingLayout").hide();
	   });
});
</script>

</head>

<body>
<div id="wrapper">
	<tiles:insertAttribute name="topheader"/>
	
	<tiles:insertAttribute name="header"/>
		
	<tiles:insertAttribute name="body"/>
</div>
<div id="footer" align="center">
	<tiles:insertAttribute name="footer"/>
</div>
<div id="loadingLayout" style="display: none; position: absolute; left: 0; top:0; width: 100%; height: 100%; z-index: 9000; background: #eeeeee;">
	<i id="loadingImage" class="fa fa-spinner fa-pulse fa-3x fa-fw" style="font-size: 70px; color: 333;"></i>
</div>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>

</body>
</html>
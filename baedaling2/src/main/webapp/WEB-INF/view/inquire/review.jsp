<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/write.css" type="text/css">
<div align="center" class="box">
	<h3
		style="width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 35px;">
		EVENT&nbsp;<span><img id="f_img2"
			src="<%=cp%>/resource/img/gangg.png"></span>
	</h3>
	<table class="freeboard">
		<tr class="f_line">
			<td>별점</td>
			<td>
		</tr>
		
		<tr>
			<td>사진첨부</td>
			<td></td>
		</tr>
		
		<tr>
			<td>구매후기</td>
			<td></td>
		</tr>
	</table>
	
	<table>
		<tr>
		<td>
			<button>등록하기</button>
		</td>
		</tr>
	</table>

</div>

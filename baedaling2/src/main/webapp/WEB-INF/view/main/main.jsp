<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
function findlist(x){
	if(surl!="") {
		var url = "<%=cp%>/restaurants/list?typecategorynum="+x;
		location.href = url;
	} else {
		alert("주소를 설정해주세요.");
	}
	
}
</script>

<div style="background: white; " class="menunu" align="center">
	<table class="menuContainer">
		<tr height="35px">
			<td><a onclick="findlist(13)"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/all.png"></a></td>
			<td><a onclick="findlist(2);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/korea.png"></a></td>
			<td><a onclick="findlist(6);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/china.png"></a></td>
			<td><a onclick="findlist(5);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/japan.png"></a></td>
		</tr>
				
		<tr>
			<td><a onclick="findlist(11);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/west.png"></a></td>
			<td><a onclick="findlist(7);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/chicken.png"></a></td>
			<td><a onclick="findlist(10);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/pizza.png"></a></td>
			<td><a onclick="findlist(8);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/fast.png"></a></td>
		</tr>
			
		<tr>
			<td><a onclick="findlist(3);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/dd.png"></a></td>
			<td><a onclick="findlist(1);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/brunch.png"></a></td>
			<td><a onclick="findlist(4);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/night.png"></a></td>
			<td><a onclick="findlist(9);"><img class="menu-Box" src="<%=cp%>/resource/img/delivery/desert.png"></a></td>
		</tr>
	</table>
</div>	
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/manage/orderlist"
		f.submit();
	}
</script>

<link rel="stylesheet" href="<%=cp%>/resource/css/list.css" type="text/css">
<div class="body-container" align="center">
    <div class="body-title" align="center">
     <h3 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 35px; ">주문 목록<span><img id="f_img2" src="<%=cp%>/resource/img/gangg.png"> </span></h3>
</div>
    
    <div>
      <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
         <tr height="35">
            <td align="left" width="50%">
            </td>
            <td align="right">
                &nbsp;
            </td>
         </tr>
      </table>
      <!-- "#EFF1F3" -->
      <table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
        <tr id="list_table" align="center" bgcolor="#EFF1F3" style="width:1000px; border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; "> 
            <th style="color: #787878; width: 70px;">주문번호</th>
            <th style="color: #787878; width: 150px;">가게</th>
            <th style="color: #787878; width: 150px;">주문자</th>
            <th style="color: #787878; width: 300px;">메뉴</th>
            <th style="color: #787878; width: 100px;">결제금액</th>
			<th style="color: #787878; width: 100px;">결제방법</th>
            <th style="color: #787878; width: 150px;">주문완료시간</th>
            <th style="color: #787878; width: 150px;">배달완료시간</th>
        </tr>
       
      <c:forEach var="dto" items="${list}">
       <tr id="list_table2" align="center" bgcolor="#ffffff" style="border-bottom: 1px solid #cccccc;"> 
            <td>${dto.foodOrderNum}</td>
            <td>${dto.name}</td>
            <td>${dto.userName}</td>
            <td>${dto.menuName}</td>
            <td>${dto.foodOrderTotalPrice}</td>
            <td>${dto.foodOrderHowPay}</td>
            <td>${dto.foodOrderPayCompletionDate}</td>
            <td>${dto.foodOrderCompletionDate }</td>
        </tr>
      </c:forEach>
        </table>
       
      <table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
         <tr height="40">
            <td align="left" width="100">
                <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/manage/orderlist';">새로고침</button>
            </td>
            <td align="center">
                <form name="searchForm" method="get">
                  <select name="condition" class="selectField">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  <option value="name" ${condition=="name"?"selected='selected'":""}>가게이름</option>
		                  <option value="menuName" ${condition=="menuName"?"selected='selected'":""}>메뉴이름</option>
		                  <option value="foodOrderCompletionDate" ${condition=="foodOrderCompletionDate"?"selected='selected'":""}>완료시간</option>
                  </select>
                  <input type="text" name="keyword" value="${keyword}" class="boxTF">
                  <button type="button" class="btn" onclick="searchList();">검색</button>
              </form>
            </td>
         </tr>
      </table>
    </div>

</div>
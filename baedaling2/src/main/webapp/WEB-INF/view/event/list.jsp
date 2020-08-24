<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/event.css" type="text/css">
<style>

.body-container{
   margin: 80px auto;
   width: 900px;
}

</style>

<div class="body-container">
   <div style="width: 900px; margin: 20px auto;">
      <div align="center">
         <h3 style="margin-top: 85px;margin-bottom:20px; width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 37px;">
         이벤트&nbsp;<span><img width="70px" height="70px"
         src="<%=cp%>/resource/img/gangg.png"></span></h3>
      </div>
      
      <form name="eventForm" action="<%=cp%>/event/list" method="post">
      <table style="margin: 0px auto; width: 100%; border-spacing: 0px;" >
            <tr height="35px;">
               <td align="left" style="font-size: 13px;">
                 ${dataCount}개(${page}/${total_page} 페이지)
               </td>
            </tr>
      </table>
      
      <table style="width: 100%; margin: 0px auto; border-spacing: 0; border-collapse:collapse;">
         <tr align="center" height="35" style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; height: 50px; border-top: 2px solid #828282; border-bottom: 1px solid #828282; background: #38BCC6;">
            <th width="60" style="color:white;">번호</th>
            <th style="color:white;">이벤트</th>
            <th width="120" style="color:white;" align="right">이벤트</th>
            <th width="120" style="color:white;" align="left">&nbsp;기간</th>
            <th width="80" style="color:white;">조회수</th>
         </tr>
         
         <c:forEach var="dto" items="${list}">
         <tr align="center" height="140" style="border-bottom: 1px solid #cccccc;">
            <td>${dto.listNum}</td>
            <td>
               <a href="${articleUrl}&num=${dto.num}"><img src="<%=cp%>/resource/event/${dto.imageFilename}" width="340" height="92"></a>
            </td>
            <td>${dto.start_date}<br>&nbsp;~&nbsp;${dto.end_date}</td>
            <td>${dto.eventState}</td>
            <td>${dto.hitCount}</td>
         </tr>
         </c:forEach>
         
      </table>
      
      <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
         <tr height="35">
            <td align="center">
                 ${dataCount==0?"등록된 게시물이 없습니다.":paging}
            </td>
         </tr>
      </table>
      
      <table style="width: 100%; margin: 20px auto; border-spacing: 0px;">
         <tr height="100">
            <td align="right">
               <button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/event/list'">새로고침</button>
                <c:if test="${sessionScope.user.separate==2}">
               	<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/event/created'">등록하기</button>
               </c:if>
            </td>            
         </tr>      
      </table>
      
      </form>
   </div>
</div>
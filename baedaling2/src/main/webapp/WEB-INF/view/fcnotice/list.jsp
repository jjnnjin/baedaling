<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/list.css" type="text/css">
<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>
<div class="body-container" align="center" style="color: black;">
    <div class="body-title" align="center">
     <h3 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 35px; ">가맹점 공지사항 </h3>
    </div>
    
    <div>
      <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
         <tr height="35">
            <td align="left" width="50%">
                	${dataCount }개(${page }/${total_page} 페이지)
            </td>
            <td align="right">
                &nbsp;
            </td>
         </tr>
      </table>
      <!-- "#EFF1F3" -->
      <table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
        <tr id="list_table" align="center" bgcolor="#EFF1F3" style=" border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; "> 
            <th width="70" style="color: #787878;">번호</th>
            <th align="center" style="color: #787878;">제목</th>
            <th width="100" style="color: #787878;">작성자</th>
            <th width="80" style="color: #787878;">작성일</th>
            <th width="60" style="color: #787878;">조회수</th>
            <th width="50" style="color: #787878;">첨부</th>
        </tr>
        <c:forEach var="vo" items="${importantList }" begin="0" end="4">
        	<tr id="list_table2" align="center" bgcolor="#ffffff" style="border-bottom: 1px solid #cccccc; background: #E6E6E6"> 
		            <td><span style="display: inline-block;padding:1px 3px; background: #ED4C00;color: #FFFFFF; ">중요!</span></td>
		            <td align="left" style="padding-left: 10px;">
		                 <a href="${articleUrl}&num=${vo.num}">${vo.subject}</a>
		            </td>
		            <td>${vo.userName }</td>
		            <td>${vo.created }</td>
		            <td>${vo.hitCount }</td>
		            <td>
		           	 	<c:if test="${dto.fileCount > 0}">
		      				<a href="<%=cp%>/fcnotice/zipdownload?num=${dto.num}"><i class="fas fa-file-archive"></i></a>
		      			</c:if>
		            </td>
		            
		        </tr>
        </c:forEach>
        
        
        
	       <c:forEach var="dto" items="${list }">
		       <tr id="list_table2" align="center" bgcolor="#ffffff" style="border-bottom: 1px solid #cccccc;"> 
		            <td>${dto.listNum }</td>
		            <td align="left" style="padding-left: 10px;">
		                 <a href="${articleUrl}&num=${dto.num}">${dto.subject }</a>
		            </td>
		            <td>${dto.userName }</td>
		            <td>${dto.created }</td>
		            <td>${dto.hitCount }</td>
		            <td>
		           	 	<c:if test="${dto.fileCount > 0}">
		      				<a href="<%=cp%>/fcnotice/zipdownload?num=${dto.num}"><i class="fas fa-file-archive"></i></a>
		      			</c:if>
		            </td>
		        </tr>
	        </c:forEach>
        
        </table>
       
        <table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
        	<tr id="list_table" align="center"  style=" border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; ">
        		<td align="center">
       				${dataCount==0?"등록된 게시물이 없습니다.":paging}
				</td>
        	</tr>
        </table>
       
      <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
         <tr height="35">
         <td align="center">
         </tr>
      </table>
      
      <table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
         <tr height="40">
            <td align="left" width="100">
                <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/fcnotice/list';">새로고침</button>
            </td>
            <td align="center">
                <form name="searchForm" action="<%=cp%>/fcnotice/list" method="post">
                    <select name="condition" class="selectField">
                        <option value="all" selected='selected'>모두</option>
                        <option value="subject" >제목</option>
                        <option value="content" >내용</option>
                  </select>
                  <input type="text" name="keyword" value="" class="boxTF">
                  <button type="button" class="btn" onclick="searchList()">검색</button>
              </form>
            </td>
            <td align="right" width="100">
            <c:if test="${sessionScope.user.separate==2}">
                <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/fcnotice/created';">글올리기</button>
            </c:if>
            </td>
         </tr>
      </table>
    </div>

</div>
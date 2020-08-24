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
		f.action="<%=cp%>/freeboard/list"
		f.submit();
	}
</script>

<link rel="stylesheet" href="<%=cp%>/resource/css/list.css" type="text/css">
<div class="body-container" align="center">
    <div class="body-title" align="center">
     <h3 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 35px; ">자유 게시판 <span><img id="f_img2" src="<%=cp%>/resource/img/gangg.png"> </span></h3>
</div>
    
    <div>
      <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
         <tr height="35">
            <td align="left" width="50%">
				  ${dataCount}개(${page}/${total_page} 페이지)
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
       
      <c:forEach var="dto" items="${list}">
       <tr id="list_table2" align="center" bgcolor="#ffffff" style="border-bottom: 1px solid #cccccc;"> 
            <td>${dto.num}</td>
            <td align="left" style="padding-left: 10px;">
            <a href="${articleUrl}&num=${dto.num}">${dto.subject} (${dto.replyCount})</a>
            </td>
            <td>${dto.userName}</td>
            <td>${dto.created}</td>
            <td>${dto.hitCount}</td>
            <td>
             <c:if test="${dto.fileCount != 0}">
                <a href="<%=cp%>/freeboard/zipdownload?num=${dto.num}"><i class="far fa-file"></i>${fileCount}</a>
             </c:if>		      
		   
            </td>
        </tr>
      </c:forEach>
        </table>
       
      <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
         <tr height="35">
         <td align="center">
         	${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
         </td>
         </tr>
      </table>
      
      <table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
         <tr height="40">
            <td align="left" width="100">
                <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/freeboard/list';">새로고침</button>
            </td>
            <td align="center">
                <form name="searchForm" method="get">
                  <select name="condition" class="btn">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
		                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		                  <option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
		                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
                  </select>
                  <input type="text" name="keyword" value="${keyword}" class="btn">
                  <button type="button" class="btn" onclick="searchList();">검색</button>
              </form>
            </td>
            <td align="right" width="100">
                <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/freeboard/write';">글올리기</button>
            </td>
         </tr>
      </table>
    </div>

</div>
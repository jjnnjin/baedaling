<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>

<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">

<div class="body-container" style="width: 900px; margin: 20px auto;">
      <div align="center">
         <h3 style="margin-top: 55px; margin-bottom:20px; width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 37px;">
         공지사항&nbsp;<span><img width="70px" height="70px"
         src="<%=cp%>/resource/img/gangg.png"></span></h3>
      </div>
    
    <div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
		   <tr height="35px">
		      <td align="left" width="50%">
		          ${dataCount}개(${page}/${total_page}페이지)
		      </td>
		      <td align="right">
		          &nbsp;
		      </td>
		   </tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
		  <tr align="center" bgcolor="#eeeeee" height="50px;" style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; border-top: 2px solid #828282; border-bottom: 1px solid #828282; background: #38BCC6;"> 
		      <th width="60" style="color: white;">번호</th>
		      <th style="color: white;">제목</th>
		      <th width="100" style="color: white;">작성자</th>
		      <th width="80" style="color: white;">작성일</th>
		      <th width="60" style="color: white;">조회수</th>
		      <th width="50" style="color: white;">첨부</th>
		  </tr>
		 
		<c:forEach var="dto" items="${checkList}" begin="0" end="4">
		  <tr align="center" bgcolor="#ffffff" height="45" style="border-bottom: 1px solid #cccccc;"> 
		      <td><span style="display: inline-block;padding:1px 3px; background: #ED4C00;color: #FFFFFF">긴급!</span></td>
		      <td align="left" style="padding-left: 10px;">
		           <a href="${articleUrl}&num=${dto.num}">${dto.subject}</a>
		      </td>
		      <td>${dto.userName}</td>
		      <td>${dto.created}</td>
		      <td>${dto.hitCount}</td>
		      <td>
		        <c:if test="${dto.fileCount > 0}">
		      		<a href="<%=cp%>/notice/zipdownload?num=${dto.num}"><i class="fas fa-file-archive"></i></a>
		      	</c:if>
		       </td>
		  </tr>
		</c:forEach>
		 
		<c:forEach var="dto" items="${list}">
		  <tr align="center" bgcolor="#ffffff" height="45" style="border-bottom: 1px solid #cccccc;"> 
		      <td>${dto.listNum}</td>
		      <td align="left" style="padding-left: 10px;">
		           <a href="${articleUrl}&num=${dto.num}">${dto.subject}</a>
		      </td>
		      <td>${dto.userName}</td>
		      <td>${dto.created}</td>
		      <td>${dto.hitCount}</td>
		      <td>
		        <c:if test="${dto.fileCount > 0}">
		      		<a href="<%=cp%>/notice/zipdownload?num=${dto.num}"><i class="fas fa-file-archive"></i></a>
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
		   <tr height="100">
		      <td align="left" width="100">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list';">새로고침</button>
		      </td>
		      <td align="center">
		          <form name="searchForm" action="<%=cp%>/notice/list" method="post">
		              <select name="condition" class="btn">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
		                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		                  <option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
		                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
		            </select>
		            <input type="text" name="keyword" value="${keyword}" class="btn" style="height: 20px;">
		            <button type="button" class="btn" onclick="searchList()">검색</button>
		        </form>
		      </td>
		      <td align="right" width="100">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/created';">글올리기</button>      
		      </td>
		   </tr>
		</table>
    </div>
</div>
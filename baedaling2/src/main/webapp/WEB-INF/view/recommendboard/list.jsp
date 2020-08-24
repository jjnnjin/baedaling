<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
function search(){
	 var f = document.searchForm;
	 f.action = "<%=cp%>/recommend/list";
	 f.submit();
}
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/list.css" type="text/css">
<div class="body-container" align="center">
    <div class="body-title" align="center">
     <h3 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 35px; ">추천 게시판 <span><img id="f_img2" src="<%=cp%>/resource/img/gangg.png"></span></h3>
    </div>
    
    <div>
      <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
         <tr height="35">
            <td align="left" width="50%">
                ${dataCount}개(${on_page}/${total_page}페이지)
            </td>
            <td align="right">
                &nbsp;
            </td>
         </tr>
      </table>
      <!-- "#EFF1F3" -->
      <table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
        <tr id="list_table" align="center" bgcolor="#EFF1F3" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; "> 
            <th width="60" style="color: #787878;">번호</th>
            <th style="color: #787878;">제목</th>
            <th width="100" style="color: #787878;">작성자</th>
            <th width="80" style="color: #787878;">작성일</th>
            <th width="60" style="color: #787878;">조회수</th>
        </tr>
<c:forEach var="dto" items="${list}">
       <tr id="list_table2" align="center" bgcolor="#ffffff" style="border-bottom: 1px solid #cccccc;"> 
            <td>${dto.listNum}</td>
            <td align="left" style="padding-left: 10px;">
                 <a href="${pageUrl}&num=${dto.num}">${dto.subject}[${dto.replyCount}]</a>
            </td>
            <td>${dto.userName}</td>
            <td>${dto.created}</td>
            <td>${dto.hitCount}</td>
        </tr>
</c:forEach>       
        </table>
      <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
         <tr height="35">
         <td align="center">
         	${dataCount==0?"등록된 게시물이 없습니다.":paging}
         </tr>
      </table>
      <table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
         <tr height="40">
            <td align="left" width="100">
                <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/recommend/list'">새로고침</button>
            </td>
            <td align="center">
                <form name="searchForm" method="get">
                    <select name="category" class="btn">
                        <option value="any" ${category=="any"?"selected='selected'":""}>모두</option>
                        <option value="subject" ${category=="subject"?"selected='selected'":""}>제목</option>
                        <option value="content" ${category=="content"?"selected='selected'":""}>내용</option>
                        <option value="userName" ${category=="userName"?"selected='selected'":""}>작성자</option>
                        <option value="created" ${category=="created"?"selected='selected'":""}>등록일</option>
                  </select>
                  <input type="text" name="key" value="" class="btn">
                  <button type="button" class="btn" onclick="search();">검색</button>
              </form>
            </td>
            <td align="right" width="100">
                <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/recommend/write'">글올리기</button>
            </td>
         </tr>
      </table>
    </div>

</div>
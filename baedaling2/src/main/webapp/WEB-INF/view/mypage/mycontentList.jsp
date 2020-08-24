<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_user.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/list.css" type="text/css">

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/mypage/mycontentList"
		f.submit();
	}
</script>

<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_user.css" type="text/css">

<div class="mypage_container">
    <div class="body-container">
        <div class="body-left">
            <div class="list-group">
                <div class="list-group-item lefthead"> 마이페이지</div>
                <a href="<%=cp%>/mapage/userInfo" class="list-group-item active">회원정보</a>
                <a href="<%=cp%>/mypage/userorderList" class="list-group-item">주문내역</a>
                <a href="#" class="list-group-item">내가 쓴 게시물</a>
                <a href="#" class="list-group-item">내가 쓴 리뷰</a>
                <a href="#" class="list-group-item">내가 쓴 댓글</a>
                <a href="<%=cp%>/mypage/message" class="list-group-item">회원정보수정</a>
                <a href="#" class="list-group-item">회원탈퇴</a>
            </div>     
        </div>
    
        <div class="body-right">
            <div class="body-right-container">
                 <div class="body-title">
                     <h3><span style="font-family: Webdings">4</span> 마이페이지 </h3>
                 </div>
                 
            <div class="mycontent_container">
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
                 <table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
        			<tr id="list_table" align="center" bgcolor="#EFF1F3" style=" border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; "> 
           				<th width="70" style="color: #787878;">번호</th>
			            <th align="center" style="color: #787878;">제목</th>
			            <th width="100" style="color: #787878;">작성자</th>
			            <th width="130" style="color: #787878;">작성일</th>
			            <th width="60" style="color: #787878;">조회수</th>
			        </tr>
			 
					<c:forEach var="dto" items="${list}">
				        <tr id="list_table2" align="center" bgcolor="#ffffff" style="border-bottom: 1px solid #cccccc;"> 
				            <td>${dto.num}</td>
				            <td align="left" style="padding-left: 10px;">
				            <%-- <a href="${articleUrl}&num=${dto.num}">${dto.subject} (${dto.replyCount})</a> --%>
				            	<a>${dto.subject} (${dto.replyCount})</a>
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
			                  <select name="condition" class="selectField">
					                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
					                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
					                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
					                  <option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
					                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
			                  </select>
			                  <input type="text" name="keyword" value="${keyword}" class="boxTF">
			                  <button type="button" class="btn" onclick="searchList();">검색</button>
			              </form>
			            </td>
			            <td align="right" width="100">
			                <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/freeboard/write';">글올리기</button>
			            </td>
			         </tr>
			      </table> 
            </div>
                 
                 </div></div></div></div>

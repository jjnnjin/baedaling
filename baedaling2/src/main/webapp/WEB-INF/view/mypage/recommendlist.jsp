<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_user.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/list.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<script type="text/javascript">
$(function(){
	$("#tab-1").addClass("active");

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="<%=cp%>/mypage/freelist";	
		location.href=url;
				
	});
});
</script>

<div class="mypage_container">
    <div class="body-container11">
        <div class="body-left">
            <div class="list-group">
                <div class="list-group-item lefthead"> 마이페이지</div>
                <a href="<%=cp%>/mypage/userInfo" class="list-group-item active">회원정보</a>
                <a href="<%=cp%>/mypage/userorderList" class="list-group-item">주문내역</a>
                <a href="<%=cp%>/mypage/recommendlist" class="list-group-item">내가 쓴 게시물</a>
                <a href="<%=cp%>/mypage/reviewList" class="list-group-item">내가 쓴 리뷰</a>
                <a href="<%=cp%>/mypage/myInquire" class="list-group-item">내가 쓴 문의</a>
                <a href="<%=cp%>/mypage/message" class="list-group-item">회원정보수정</a>
                <a href="#" class="list-group-item">회원탈퇴</a>
            </div>         
        </div>
    
        <div class="body-right">
            <div class="body-right-container">
                 <div class="body-title">
                     <h3><span style="font-family: Webdings">4</span> 내가 쓴 게시물 </h3>
                 </div>
                 
        <div style="clear: both;">
			<ul class="tabs">
				<li id="tab-1" data-tab="1">추천 게시판</li>
				<li id="tab-2" data-tab="2">자유 게시판</li>
			</ul>
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
				            <td>${dto.listNum}</td>
				            <td align="left" style="padding-left: 10px;">
					            <a href="${articleUrl}&num=${dto.num}">${dto.subject} (${dto.replyCount})</a>
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
			            <td align="right" width="100">
			                <button type="button" class="mycontent_btn" onclick="javascript:location.href='<%=cp%>/mypage/recommendlist';">새로고침</button>
			            </td>
			            
			         </tr>
			       </table> 
            	</div>
			</div>
		</div>
	</div>
</div>                 

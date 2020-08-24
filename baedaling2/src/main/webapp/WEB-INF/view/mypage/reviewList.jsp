<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<script type="text/javascript">
function Deletebtn(reviewNum,page) {
	var url = "<%=cp%>/mypage/delete?reviewNum=" + reviewNum +"&page="+page;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
			location.href=url;
	}
}
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_user.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/reviewList.css" type="text/css">
<div class="mypage_container">
    <div class="body-container">
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
                     <h3><span style=" font-family: Webdings">4</span> 내가 쓴 리뷰 </h3>
                 </div>
                 <div id="mypage_container">
                    <div class="alert-info">
                   <p style= "color:white; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 25px; text-align: center;">My Review List</p>
               </div>
               
        <div>
             <table>
               <tr height="35">
               		<td style=" border-bottom:1px solid gray; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 20px; ">내가 쓴 총 리뷰 ${dataCount}&nbsp;개</td>
               </tr>
             </table>
        </div>

        <div class="review_box">
        <c:forEach var="dto" items="${list}">
        	<table style="border-top: 2px solid #848484; border-bottom: 2px solid #848484; margin-bottom: 20px; width: 95%; border-collapse: collapse; border-spacing: 0;" >
        		<tr class="subtitle" height="45" style="border-bottom: 1px solid #cccccc;">
        			<td id="ftitle" style="font-weight: bold; background-color:#FAFAFA;">가게명 </td>
        			<td id="ftitle" style="padding-top: 8px;"  > ${dto.name}
                    	<button type="button" class="reviewDeletebtn" onclick="Deletebtn('${dto.reviewNum}' , '${page}');">삭제</button>
                    </td>
                </tr>
                <tr class="subtitle" height="45" style="border-bottom: 1px solid #cccccc;">
                    <td id="ftitle" style="font-weight: bold; background-color:#FAFAFA;">작성 날짜 </td> 
                    <td id="ftitle">${dto.created}</td>
                </tr>
                <tr class="subtitle" height="45" style="border-bottom: 1px solid #cccccc;">
                	<td id="ftitle" style="font-weight: bold; background-color:#FAFAFA;">내가 준 별점 </td> 
                    <td id="ftitle" style="color:#F2D51B;">
                    	<c:forEach begin="1" end="${dto.starCount}">
                    		★
                    	</c:forEach>
                    	<c:forEach begin="${dto.starCount+1}" end="5">
                    		☆
                    	</c:forEach>
                    </td>
                </tr>
                <tr height="120" style="border-bottom: 1px solid #cccccc;">
                	<td colspan="2" style="color:gray; padding-left: 10px; padding-bottom: 10px;"><br>${dto.content}</td>
                </tr>
                <c:if test="${not empty dto.reply}">
                <tr class="subtitle2">
                	<td width="300" style="border-right-color: #f8f8f8; font-weight: bold; color:black; border-top: 1px solid #cccccc;">
                		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└&nbsp;&nbsp;&nbsp;RE : ${dto.name}&nbsp;사장님</td>
                	<td align="right" colspan="2" style="color: black;" >${dto.replycreated}&nbsp;&nbsp;</td>
                </tr>           
                <tr height="80">
                    <td colspan="2" style="color:black; border: 1px solid #BDBDBD; padding-left: 10px; background-color: #f8f8f8;">${dto.reply}</td>
                </tr>                
                </c:if>
           	</table>
	                <input type="hidden" name="foodOrderNum" value="${foodOrderNum}">
				   	<input type="hidden" name="restaurantsNum" value="${restaurantsNum}">    
				   	<input type="hidden" name="reviewNum" value="${reviewNum}">    
        </c:forEach>
           	
           	<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
        		<tr height="35">
         			<td align="center">
         				${dataCount==0 ? "등록하신 리뷰가 없습니다.":paging}
         			</td>
         		</tr>
      		</table>
      		
			</div>
            </div>
            </div>
        </div>
    </div>        
</div>

</body>
</html>

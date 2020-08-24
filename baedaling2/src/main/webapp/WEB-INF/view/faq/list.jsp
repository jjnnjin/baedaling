<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>

<style type="text/css">
.alert-info {
    border: 1px solid #9acfea;
    border-radius: 4px;
    background-color: #d9edf7;
    color: #31708f;
    padding: 15px;
    margin-top: 20px;
    margin-bottom: 20px;
    }

.btn {
	color: gray;
	font-weight:500;
	border:1px solid #cccccc;
	background-color:#ffffff;
	text-align:center;
	cursor:pointer;
	padding:4px 8px 5px;
	border-radius:4px;
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}

</style>


<script type="text/javascript">
$(function(){
   $("#tab-${group}").addClass("active");

   $("ul.tabs li").click(function() {
      tab = $(this).attr("data-tab");
      
      $("ul.tabs li").each(function(){
         $(this).removeClass("active");
      });
      
      $("#tab-"+tab).addClass("active");
      
      var url="<%=cp%>/faq/list?group="+tab;   
      location.href=url;
   });
});

$(function(){
   $(".board-list tr").hover(function(){
      $(this).addClass("over");
   }, function(){ // 마우스가 벗어나면
      $(this).removeClass("over");
   });
});

$(function(){
   $(".faqSubject").css("cursor", "pointer");
   $(".faqSubject").click(function(){
      var $content = $(this).next();
      var state = $content.is(":hidden");
      $(".faqContent").hide();

      if(state) {
         $content.show();
      } else {
         $content.hide();
      }
   });
});

function searchList() {
   var f=document.searchForm;
   f.submit();
}

function deleteBoard(num) {
   
      var url = "<%=cp%>/faq/delete?num=" + num + "&group="+${group}+"&page="+${page};
      if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
            location.href=url;
      }
   
   }
function updateBoard(num){
    var q = "num="+ num +"&page=${page}";
     var url = "<%=cp%>/faq/update?" + q;

     location.href=url;
}
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<div class="body-container" align="center" style="width: 800px; margin: 20px auto 0px; border-spacing: 0px; color: black;">
   <div class="body-title" align="center">
      <h3 style= " margin-top: 70px; margin-bottom:25px; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 35px; ">FAQ <span><img id="f_img2" src="<%=cp%>/resource/img/gangg.png"> </span></h3>
   </div>

   <div>

      <div style="clear: both;">
         <ul class="tabs">
            <li id="tab-0" data-tab="0">전체</li>
             <c:forEach var="vo" items="${groupList}">
               <li id="tab-${vo.categoryNum}" data-tab="${vo.categoryNum}">${vo.category}</li>
            </c:forEach>
         </ul>
      </div>
      <div id="tab-content" style="clear:both; padding: 20px 0px 0px; ">
      
		<div class="alert-info" style="color: #31708f; background-color:#B2E9ED;">
		   자주 묻는 질문들 리스트 입니다.
		</div>
         
         <table style="width: 100%; margin:0px auto; border-collapse: collapse; border-spacing: 0; table-layout: fixed;">
           <thead>
           <tr height="45" id="list_table" align="center" style=" border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; background-color: white; "> 
               <th width="70" style="color: #787878;">번호</th>
               <th width="130" style="color: #787878;">분류</th>
               <th align="center" style="color: #787878;">제목</th>
               <th width="100" style="color: #787878;">작성자</th> 
           </tr>
          </thead>
          <tbody class="board-list" >

         <c:forEach var="dto" items="${list }">
            <tr style="height: 1px;"> 
               <td colspan="4" style="font-size: 1px;">&nbsp;</td>
              </tr>         
           <tr class="faqSubject" align="center" data-num="${dto.num}" height="35" style="border: 1px solid #ccc;"> 
               <td>${dto.listNum}</td>
               <td>${dto.category}</td>
               <td align="left"style="padding-left: 10px;">
                    ${dto.subject }
               </td>
               <td>${dto.userName }</td>
           </tr>
           <c:if test="${sessionScope.user.separate!=2}">
           <tr class="faqContent" align="left" height="35" style="display:none; border: 1px solid #ccc;"> 
               <td colspan="4" style="padding:10px; word-break:break-all;">${dto.content}</td>
           </tr>
           </c:if>
           <c:if test="${sessionScope.user.separate==2}">
           <tr class="faqContent" align="left" height="35" style="display:none; border: 1px solid #ccc;"> 
               <td colspan="3" style="padding:10px; ">${dto.content}</td>
               <td>
                  <button type="button" class="btn" onclick="updateBoard(${dto.num})">수정</button> 
                  <button type="button" class="btn" onclick="deleteBoard(${dto.num})">삭제</button>
               </td>  
           </tr>
           </c:if>
         </c:forEach>
           </tbody>
         </table>
          
         <table style="width: 100%; border-spacing: 0px;">
            <tr height="35">
            <td align="center">
                   ${paging }
             </td>
            </tr>
         </table>
         
         <table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
            <tr height="40">
               <td align="left" width="100">
                   <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/faq/list?group=${group}';">새로고침</button>
               </td>
               <td align="center">
                   <form name="searchForm" action="<%=cp%>/faq/list" method="post" style="margin-left: -112px;">
                       <select name="condition" class="btn" style="height: 30px; ">
                           <option value="all" ${condition=="all"?"selected='selected'":""}>모두 &nbsp;&nbsp;</option>
                           <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
                           <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
                     </select>
                      <input type="hidden" name="group" value="${group}"> 
                     <input type="text" class="btn" name="keyword" value="${keyword}" class="boxTF"> 
                     <button type="button" class="btn" onclick="searchList()">검색</button>
                 </form>
               </td>
               <c:if test="${sessionScope.user.separate==2}">
                     <td align="right" width="100">
                         <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/faq/created';">글올리기</button>
                     </td>   
               </c:if>   
            </tr>
         </table>
         
      </div>
      
   </div>

</div>


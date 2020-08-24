<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
$(function(){
	listPage(1);
});

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function listPage(page) {
	var url = "<%=cp%>/recommend/listReply";
	var query = "num=${dto.num}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}

function login() {
	location.href="<%=cp%>/user/login";
}
$(function(){
	$(".btnSendRecommendLike").click(function(){
		if(! confirm("추천!")) {
			return false;
		}
		
		var url="<%=cp%>/recommend/insertRecommendLike";
		var num="${dto.num}";
		var query = {num:num};
		
		var fn = function(data){
			var state=data.state;
			if(state=="true") {
				var count = data.recommendLikeCount;
				$("#recommendLikeCount").text(count);
			} else if(state=="false") {
				alert("추천은 한번만 가능합니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

$(function(){
	$(".btnSendReply").click(function(){
		var num="${dto.num}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/recommend/insertReply";
		var query="num="+num+"&content="+content;
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시물을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="<%=cp%>/recommend/deleteReply";
		var query="replyNum="+replyNum+"&mode=reply";
		
		var fn = function(data){
			listPage(page);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});


function updateBoard() {
	
	  var q = "num=${dto.num}&page=${page}";
	  var url = "<%=cp%>/recommend/update?" + q;

	  location.href=url;
	

	
}

</script>

<script type="text/javascript">
function delete_send() {
	  var q = "num=${dto.num}&${query}";
	  var url = "<%=cp%>/recommend/delete?"+q;
	  if(confirm("위 자료를 삭제 하시 겠습니까 ? ")){
	  	location.href=url;
	  }
}
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/page.css" type="text/css">
<div align="center" class="box">
<h3 style="width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 35px; ">추천 게시판&nbsp;<span><img id="f_img2" src="<%=cp%>/resource/img/gangg.png"></span> </h3>
	<br>
	<table  class="freeboard">
		<tr class="f_line">
			<td align="left" style="font-size:15px; margin-top:3px; font-weight: bold;" class="subtitle">제목</td>
			<td align="left" id="ftitle" style="font-size:15px; color: gray;" > ${dto.subject}</td>
		</tr>
		
		<tr class="f_line">
			<td align="left" style="color: gray;" class="subtitle">작성자</td>
			<td align="left" id="subcontent">${dto.userName}</td>
		</tr>
		
		<tr class="f_line">
			<td class="subtitle">작성일</td>
			<td id="subcontent2">
				${dto.created}
				<span style="display: inline-block; margin-left:30px; font-weight: bold;">조회수</span><span style="margin-left:20px;">${dto.hitCount}</span>
			</td>
		</tr>
		
		<tr class="fcontent" align="left" >
			<td colspan="2" align="left" style="padding-left: 20px; border-bottom: 1px solid #DDDFE0;" >${dto.content}</td>
		</tr>
	
		<tr style="border-bottom: 1px solid #cccccc;">
			<td colspan="2" height="40" style="padding-bottom: 15px;" align="center">
					<a type="button" class="btnSendRecommendLike"><span style="color:#38BCC6;"><i class="fab fa-gratipay fa-3x"></i></span></a>&nbsp;&nbsp;<span id="recommendLikeCount" style="color: gray;">${dto.recommendLikeCount}</span>
			</td> 
		</tr>
		<c:forEach var="vo" items="${listFile}">
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
				    <td colspan="2" align="left" style="padding-left: 5px;">
				      <a href="<%=cp%>/recommend/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a>
			          (<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte)
				    </td>
				</tr>
	    </c:forEach>
		
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
			<td colspan="2" align="left" style="padding-left: 5px; color: gray;">
			       이전글 :
			         <c:if test="${not empty preReadDto}">
			              <a href="<%=cp%>/recommend/page?${query}&num=${preReadDto.num}">${preReadDto.subject}</a>
			        </c:if>
			</td>
		</tr>
			
		<tr height="35" style="border-bottom: 1px solid #cccccc;">
			<td colspan="2" align="left" style="padding-left: 5px; color: gray;">
			       다음글 :
			        <c:if test="${not empty nextReadDto}">
			              <a href="<%=cp%>/recommend/page?${query}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
			        </c:if>
			</td>
		</tr>
	</table>
	<div class="f_button" align="right">
		<button id="f_btn2" type="button" onclick="updateBoard()">수정</button>
		<button id="f_btn" type="button" onclick="delete_send();">삭제</button> 
		<button id="f_btn3" type="button" onclick="javascript:location.href='<%=cp%>/recommend/list?${query}';">리스트</button>
	</div>
</div>
<table  style='width: 50%; margin: 15px auto 0px; border-spacing: 0px;'>
		<tr height='30'> 
			 <td align='left' >
			 	<span style='font-weight: bold;' >댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
			 </td>
		</tr>
		<tr >
		   	<td align="center" style='padding:5px 5px 0px;'>
				<textarea class='boxTA' style='height: 70px;'></textarea>
		    </td>
		</tr>
		<tr align="right">
		   <td  class="f_reply">
		        <button type='button' class="btnSendReply" style='height:37px; margin:10px; padding:10px 20px; align-items: center'>댓글 등록</button>
		    </td>
	    </tr>
</table>
<div id="listReply" style="width:1000px; margin: 0px auto;"></div>
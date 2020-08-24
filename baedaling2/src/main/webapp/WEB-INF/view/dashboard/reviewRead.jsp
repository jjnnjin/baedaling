<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>

<link rel="stylesheet" href="https://unpkg.com/@kfonts/bm-hanna-pro/index.css" />
<link rel="stylesheet" href="<%=cp%>/resource/css/review.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/fcReviewRead.css" type="text/css">

<script type="text/javascript">

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

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
			if($("#listReplyBody").attr("data-count")!="0") {
				$(".reviewReplyContent").hide();
			}//수정버튼 - show()
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

$(function(){
	listPage(1);
});

function listPage(page) {
	var restaurantsNum = ${dto.restaurantsNum};
	var reviewNum = ${dto.reviewNum};
	var url = "<%=cp%>/dashboard/listReply";
	var query = "restaurantsNum="+restaurantsNum+"&reviewNum="+reviewNum+"&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}


$(function(){
	$(".sendReply").click(function(){
		var reviewNum="${dto.reviewNum}";
		var $tb = $(this).closest("table");
		var reply=$tb.find("textarea").val().trim();
		if(! reply) {
			$tb.find("textarea").focus();
			return false;
		}
		reply = encodeURIComponent(reply);
		
		var url="<%=cp%>/dashboard/insertReply";
		var query="reviewNum="+reviewNum +"&reply="+reply;
		
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


</script>

<div style="width: 25px; height:70px; background-color: #f9f9fa">&nbsp;</div>
<div class="reviewList" style="width: 100px;  margin-left: 450px; ">

<div class="reviewContent" style="background-color: white;">
	<ul>
		<li id="score_text">${dto.starCount}</li>
		<li id="star_deco">★★★★☆</li>
	</ul>
</div>

<div class="reviewContent2" style="width: 1000px; height: 50px; border: 1px solid #dadadb; background-color: white;">


<div class="reviewContent3" style="background-color: white;">
	<ul style="padding-left: 10px; padding-top: 10px; height: auto;">
		<li > <span style="font-size: 15px; font-weight: bold;">${dto.userName}</span> ${dto.created}</li>
		<li id="star_deco">★★★★★</li>
		<li style="color: #15AFD6;">${dto.menuName}</li>
		<li style="height: auto;">${dto.content}</li>
	</ul>
</div>
	
	
	<table  class="reviewContent4 reviewReplyContent" style=" border-spacing: 0px;">
		<tr height='30'> 
			 <td align='left'>
			 	<span style="font-size: 20px; font-family:'배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; color: gray;" >댓글쓰기</span><span style="font-size:18px; font-family:'배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; color: #B3B2B2;"> - 고객의 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
			 </td>
			 
		</tr>
		<tr >
		   	<td align="center" style='padding:5px 5px 0px;'>
				<textarea class='boxTA' style='height: 70px; width: 1000px;'></textarea>
		    </td>
		</tr>
		<tr align="right">
		   <td  class="f_reply">
		        <button type='button' class="sendReply" style='height:37px; margin:10px; padding:10px 20px; align-items: center'>댓글 등록</button>
		    </td>
	    </tr>
</table>
<div id="listReply" style="width: 1000px; margin: 0px auto;"></div>
</div>
</div>


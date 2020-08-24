<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	$( ".star a" ).click(function() {
		var b=$(this).hasClass("on");
	    $(this).parent().children("a").removeClass("on");
	    $(this).addClass("on").prevAll("a").addClass("on");
	    if(b) 	$(this).removeClass("on");
	    
	    var s=$(".star .on").length;
	    $("#starCount").val(s);
	});
});
</script>

<script type="text/javascript">
function sendReview(){
	var form = document.reviewForm;
	form.action = "<%=cp%>/review/${state}";
	alert("리뷰 등록이 완료 되었습니다.");
	return true;
}
</script>

<style type="text/css">
#starCount{
	border: none;
}
</style>

<link rel="stylesheet" href="<%=cp%>/resource/css/review.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_user.css" type="text/css">
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
                     <h3><span style="font-family: Webdings">4</span> 마이페이지 </h3>
                 </div>
				<div align="center">
				<h3 style="width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 35px; ">REVIEW</h3>
				<br>
				<form name="reviewForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
				<table class="review_table">
				      <tr class="f_line">
				         <td align="left" style="font-weight: bold; border-bottom: 1px solid #cccccc;" class="subtitle"  >별점</td>
				         <td align="left" id="ftitle" style="color: gray; border-bottom: 1px solid #cccccc;">
				         	<p class="star">
				         		<a>★</a>
				         		<a>★</a>
				         		<a>★</a>
				         		<a>★</a>
				         		<a>★</a>
				         		<input id="starCount" name="starCount" value="0" readonly="readonly">/5점
				         	</p>
				         </td>
				      </tr>
				      
				      <tr align="center">
				         <td colspan="2">
				           	<textarea style="min-height: 500px; width: 100%" id="content" name="content"></textarea>
				         </td>
				      </tr>
				   </table>
				   
				   <table>
				      <tr style="height: 60px;">
				      <td>
				         <button type="submit" class="btn" style="height: 35px; width: 100px;" onclick="sendReview();">등록하기</button>
				         <button type="button" class="btn" style="height: 35px; width: 100px;" onclick="javascript:location.href='<%=cp%>/mypage'">취소하기</button>
				      </td>
				      </tr>
				   </table>
				   <input type="hidden" name="foodOrderNum" value="${foodOrderNum}">
				   <input type="hidden" name="restaurantsNum" value="${restaurantsNum}">
				</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "content",
			sSkinURI: "<%=cp%>/resource/se/SmartEditor2Skin.html",	
			htParams : {bUseToolbar : true,
				fOnBeforeUnload : function(){
					//alert("아싸!");
				}
			}, //boolean
			fOnAppLoad : function(){
				//예제 코드
				//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
		
		function pasteHTML() {
			var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
			oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
		}
		
		function showHTML() {
			var sHTML = oEditors.getById["content"].getIR();
			alert(sHTML);
		}
			
		function submitContents(elClickedObj) {
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
			
			// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
			
			try {
				// elClickedObj.form.submit();
				return check();
			} catch(e) {}
		}
		
		function setDefaultFont() {
			var sDefaultFont = '돋움';
			var nFontSize = 24;
			oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
		}
</script>
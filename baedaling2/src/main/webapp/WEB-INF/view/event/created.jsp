<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/write.css" type="text/css">
<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

function check() {
    var f = document.eventForm;

	var str = f.subject.value;
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return false;
    }
    
    var mode="${mode}";
    if(mode=="created"||mode=="update" && f.upload.value!="") {
		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
			/* alert('이미지 파일만 가능합니다.(bmp 파일은 불가) !!!'); */
			f.upload.focus();
			return;
		}
	}
    
	f.action="<%=cp%>/event/${mode}";
	return true;
}

</script>

<div align="center" class="box">
	<h3
		style="width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 35px;">
		이벤트&nbsp;${mode=='update'?'수정':'등록'}<span><img id="f_img2"
			src="<%=cp%>/resource/img/gangg.png"></span>
	</h3>
	<br>
	<form name="eventForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">	
		<table class="freeboard">
			<tbody id="tb">
				<tr class="f_line">
					<td align="left" style="font-weight: bold;" class="subtitle">제목</td>
					<td align="left" id="ftitle" style="color: gray;">
					<input name="subject" class="boxTF" style="width: 95%; color: gray;" value="${dto.subject}"></td>
				</tr>
				<tr class="f_line">
					<td align="left" style="color: gray;" class="subtitle">작성자</td>
					<td align="left" id="subcontent">${sessionScope.user.userName}</td>
				</tr>
				
				<tr class="f_line">
					<td align="left" style="color: gray;" class="subtitle">이벤트 기간</td>
					<td align="left" id="subcontent" >
						<input type="text" name="start_date" value="${dto.start_date}" maxlength="10">~
						<input type="text" name="end_date" value="${dto.end_date}" maxlength="10">
					</td>
					
				</tr>
					
				<tr class="fcontent" align="left">
					<td colspan="2" align="left"
						style="padding-left: 20px; border-bottom: 1px solid #cccccc;">
						<textarea name="content" id="content" style="margin: 0px; width: 960px; height: 420px; border-color: #DDDFE0; resize: none; color: gray; border-radius: 4px;">${dto.content}</textarea>
					</td>
				</tr>
		
				<tr align="left" height="100"
					style="border-bottom: 1px solid #DDDFE0; height: 50px">
					<td align="left" style="font-weight: bold;" class="subtitle">베너 이미지</td>
					<td><input class="boxTF" type="file" name="upload" size="53"
						style="width: 95%;"></td>
				</tr>
				</tbody>
			</table>

	<table>
		<tr>
			<td height="100px">
				<button class="btn" type="submit">${mode=='update'?'수정완료':'등록하기'}</button>
				<button class="btn" type="reset">다시입력</button>
				<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/event/list';">${mode=='update'?'수정취소':'등록취소'}</button>
				  <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="num" value="${dto.num}">
			        	 <input type="hidden" name="page" value="${page}">
			        	 <input type="hidden" name="imageFilename" value="${dto.imageFilename}">
			      </c:if>
			</td>
		</tr>
	</table>
</form>


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

</div>
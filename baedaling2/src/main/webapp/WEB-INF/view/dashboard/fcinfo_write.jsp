<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="https://unpkg.com/@kfonts/bm-hanna-pro/index.css" />

<link rel="stylesheet" href="<%=cp%>/resource/css/fcinfo_write.css" type="text/css">
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
    if(mode=="update" && f.upload.value!="") {
		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
			alert('이미지 파일만 가능합니다.(bmp 파일은 불가)');
			f.upload.focus();
			return;
		}
		alert("등록이 완료되었습니다.")
	}
    
	f.action="<%=cp%>/dashboard/${mode}";
	return true;
}


<c:if test="${mode=='update'}">
function deleteFile(fileNum) {
		var url="<%=cp%>/dashboard/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "json");
}
</c:if>


function  updateFcState() {
	  var q = "restaurantsNum=${dto.restaurantsNum}";
	  var url = "<%=cp%>/dashboard/updateFcState?" + q;
		  	location.href=url;
	}
	

</script>

<div style="width: 25px; background-color: #F6F5F5">&nbsp;</div>
<div class="storeBox">
	<div class="store_basic">
		<div class="storeInfo" style="width: 100px;">
			<div class="infoContent">
				<form name="restaurantsInfoForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
					<ul id="info_title">
						<li style="width: 200px;"><i class="fas fa-bullhorn"></i><span style="font-size: 14px; "> 사장님알림</span></li>	
					</ul>
					<div>
						<ul style="padding: 10px;">
							<li>
								<textarea name="introduce" id="content"  style="margin: 0px; width: 580px; height: 350px; border-color: #DDDFE0; resize: none; color: gray; border-radius: 4px;">${dto.introduce}</textarea>
							</li>
						</ul>
					</div>
					<ul id="info_title">
						<li>
							<span style="font-size: 14px; "><i class="fas fa-store"></i> 업체정보</span>
						</li>	
					</ul>
					<ul id="info_content2">
						<li>
							<span id="light_gray">영업시간</span>
							<input type="time" name="openingHour" value="${dto.openingHour}"> - <input type="time" name="endingHour" value="${dto.endingHour}">
						</li>
						<li>
							<span id="light_gray">전화번호</span> <input type="tel" name="fctel" value="${dto.fctel}">
						</li>
						<li>
							<span id="light_gray">예상배달시간</span> <input type="datetime" name="deliTime" value="${dto.deliTime}">
						</li>
					</ul>
					<ul id="info_title">
						<li><span style="font-size: 14px;"><i class="far fa-credit-card"></i> 결제정보</span></li>	
					</ul>
					<ul id="info_content2">
						<li>
							<span id="light_gray">최소주문금액</span>
								<input type="text" name="minorder" value="${dto.minorder}">원
						</li>
					</ul>
					
					<ul >
						<li>
							<span id="light_gray">파일첨부</span>
							<input type="file" name="upload" size="53">1로고 
							<input type="file" name="upload" size="53">2배경 
						</li>
						
					<c:if test="${mode=='update'}">
						 <c:forEach var="dto" items="${listFile}">
						<li id="f${dto.fileNum}">
							<span id="light_gray">1.로고파일 2.배경이미지</span>
								<a  style="color: gray;" href="javascript:deleteFile('${dto.fileNum}');"><i class="far fa-trash-alt"></i></a> 
						</li>
					 </c:forEach>
					</c:if>
					</ul>
					<ul id="info_title">
						<li>
							<span style="font-size: 14px; "><i class="far fa-credit-card"></i> 사업자정보</span>
						</li>	
					</ul>
					<ul id="info_content2">
						<li>
							<span id="light_gray">상호명</span>  <input type="text" name="mutualName" value="${dto.mutualName}">
						</li>
						<li>
							<span id="light_gray">사업자등록번호</span> <input type="text" name="licenseNumber" value="${dto.licenseNumber}">
						</li>
					</ul>
					<ul id="info_title">
						<li>
							<span style="font-size: 14px; "><i class="far fa-file-alt"></i> 원산지정보</span>
						</li>	
					</ul>
					<ul id="info_content2">
						<li>
							<textarea rows="10" cols="60" style="width: 700px; height: 104px;" name="origin">${dto.origin}</textarea>
						</li>
					</ul>
					<ul>
						<li style="margin-right: 10px; margin-top: 50px; text-align: right;">
							<button style="width: 70px; height: 30px; background-color: white; border: 1px solid;" type="submit" onclick="updateFcState();" >등록하기</button> <button style="width: 70px; height: 30px; background-color: white; border: 1px solid;" type="reset">다시입력</button>
					<c:if test="${mode=='update'}">
			         	 <input type="hidden" name="restaurantsNum" value="${dto.restaurantsNum}">
			        </c:if>
						</li>
					</ul>
				</form>
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
   oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);   // 에디터의 내용이 textarea에 적용됩니다.
   
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



<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">



$(function(){
	$("form input[name=upload]").change(function(){
		if(! $(this).val()) return;
		
		var b=false;
		$("form input[name=upload]").each(function(){
			if(! $(this).val()) {
				b=true;
				return;
			}
		});
		if(b) return false;
			
		var $tr = $(this).closest("tr").clone(true); // 이벤트도 복제
		$tr.find("input").val("");
		$("#tb").append($tr);
	});
});

  <c:if test="${state=='update'}">
  function deleteFile(fileNum) {
		var url="<%=cp%>/recommend/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "json");
  }
</c:if>

function check(){
	var f = document.boardForm;
	var line = f.subject.value;
	if(!line){
		alert("제목을 입력하세요.");
		f.subject.focus();
		return false;
	}
	line = f.content.value;
	if(!line){
		alert("내용을 입력하세요.");
		f.content.focus();
		return false;
	}
	f.action="<%=cp%>/recommend/${state}";
	return true;
	
}
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/write.css" type="text/css">
<div align="center" class="box">
	<h3
		style="width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 35px;">추천 게시판&nbsp;<span><img id="f_img2"src="<%=cp%>/resource/img/gangg.png"></span>
	</h3>
	<br>
	<form name="boardForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
	<table class="freeboard">
		<tbody id="tb">
			<tr class="f_line">
				<td align="left" style="font-weight: bold;" class="subtitle">제목</td>
				<td align="left" id="ftitle" style="color: gray;">
				<input class="boxTF" style="width: 95%; color: gray;" name="subject" value=" ${dto.subject}"></td>
			</tr>
	
			<tr class="f_line">
				<td align="left" style="color: gray;" class="subtitle">작성자</td>
				<td align="left" id="subcontent">${sessionScope.user.userName}</td>
			</tr>
	
			<tr class="fcontent" align="left">
				<td colspan="2" align="left"
					style="padding-left: 20px; border-bottom: 1px solid #cccccc;">
					<textarea style="margin: 0px; width: 940px; height: 420px; border-color: #DDDFE0; resize: none; color: gray; border-radius: 4px;"  id="content" name="content">${dto.content}</textarea>
				</td>
			</tr>
	
			<tr align="left" height="100" style="border-bottom: 1px solid #DDDFE0; height: 50px; width: 95%;">
				<td align="left" style="font-weight: bold;" class="subtitle">첨부파일</td>
				<td><input type="file" name="upload" size="53" style="color: #585858;"></td>
			</tr>
		</tbody>
		<tfoot>
			<c:if test="${state=='update'}">
				   <c:forEach var="dto" items="${listFile}">
						  <tr id="f${dto.fileNum}" height="40" style="border-bottom: 1px solid #cccccc;"> 
						      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
						      <td style="padding-left:10px;"> 
								<a href="javascript:deleteFile('${dto.fileNum}');"><i class="far fa-trash-alt"></i></a> 
								${dto.originalFilename}
						      </td>
						  </tr>
				   </c:forEach>
			</c:if>
		
		</tfoot>
		
		
		
	</table>
	<table>
		<tr>
			<td height="100px">
				<button class="btn" type="submit">등록하기</button>&nbsp;&nbsp;
				<button class="btn" type="reset">다시입력</button>&nbsp;&nbsp;
				<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/recommend/list'">등록취소</button>&nbsp;&nbsp;
				<c:if test="${state=='update'}">
			         	 <input type="hidden" name="num" value="${dto.num}">
			        	 <input type="hidden" name="page" value="${page}">
			        </c:if>
			</td>
		</tr>
	</table>
	</form>
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
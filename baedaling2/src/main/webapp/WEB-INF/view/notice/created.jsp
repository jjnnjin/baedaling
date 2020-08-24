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

<%-- $(function(){
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

  <c:if test="${mode=='update'}">
  function deleteFile(fileNum) {
		var url="<%=cp%>/notice/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "json");
  }
</c:if>
 --%>
 function sendOk() {
	    var f = document.noticeForm;

		var str = f.subject.value;
	    if(!str) {
	        alert("제목을 입력하세요. ");
	        f.subject.focus();
	        return;
	    }

		str = f.content.value;
	    if(!str) {
	        alert("내용을 입력하세요. ");
	        f.content.focus();
	        return;
	    }

		f.action="<%=cp%>/notice/${mode}";
	    f.submit();
	}
	<c:if test="${mode=='update'}">
	function deleteFile(fileNum) {
			var url="<%=cp%>/notice/deleteFile";
			$.post(url, {fileNum:fileNum}, function(data){
				$("#f"+fileNum).remove();
			}, "json");
	}
	</c:if>
	$(function(){
		$("form input[name=upload]").change(function(){
			if(! $(this).val()) return;
			
			var b=false;
			$("form input[name=upload]").each(function(){
				if(! $(this).val()) {
					b=true;
					return false;
				}
			});
			if(b) return false;
			
			var $tr = $(this).closest("tr").clone(true); // 이벤트도 복제
			$tr.find("input").val("");
			$("#tb").append($tr);
		});
	});



</script>

<div align="center" class="box">
	<h3
		style="width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 35px;">
			공지사항&nbsp;${mode=='update'?'수정':'등록'}&nbsp;<span><img id="f_img2"
			src="<%=cp%>/resource/img/gangg.png"></span>
	</h3>
	<br>
<form name="noticeForm" method="post" enctype="multipart/form-data">	
	<table class="freeboard">
		<tbody id="tb">
		<tr class="f_line">
			<td align="left" style="font-weight: bold;" class="subtitle">제목</td>
			<td align="left" id="ftitle" style="color: gray;">
			<input name="subject" class="boxTF" style="width: 95%; color: gray;" value=" ${dto.subject}"></td>
		</tr>
		<tr class="f_line">
			<td align="left" style="color: gray;" class="subtitle" >긴급공지여부</td>
			<td align="left" id="subcontent"> <input type="checkbox" name="checkNotice" value="1" ${dto.checkNotice==1 ? "checked='checked' ":"" } > 긴급공지</td>
		</tr>
		<tr class="f_line">
			<td align="left" style="color: gray;" class="subtitle">작성자</td>
			<td align="left" id="subcontent">${sessionScope.user.userName }</td>
		</tr>

		<tr class="fcontent" align="left">
			<td colspan="2" align="left"
				style="padding-left: 20px; border-bottom: 1px solid #cccccc;">
				<textarea name="content" id="content" style="margin: 0px; width: 940px; height: 420px; border-color: #DDDFE0; resize: none; color: gray; border-radius: 4px;">${dto.content}</textarea>
			</td>
		</tr>

		<tr align="left" height="100"
			style="border-bottom: 1px solid #DDDFE0; height: 50px">
			<td align="left" style="font-weight: bold;" class="subtitle">첨부파일</td>
			<td><input class="boxTF" type="file" name="upload" size="53"
				style="width: 95%;"></td>
		</tr>
		</tbody>
		
		<c:if test="${mode=='update'}">
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

	</table>

	<table>
		<tr>
			<td height="100px">
				<button class="btn" type="submit" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>&nbsp;&nbsp;
				<button class="btn" type="reset">다시입력</button>&nbsp;&nbsp;
				<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>&nbsp;&nbsp;
				  <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="num" value="${dto.num}">
			        	 <input type="hidden" name="page" value="${page}">
			        </c:if>
			</td>
		</tr>
	</table>
</form>
</div>
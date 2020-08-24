<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/write.css" type="text/css">

<script type="text/javascript">

function sendOk() {
	var f = document.createdForm;
	
	var str = f.subject.value;
	if(!str) {
		alert("제목을 입력하세요. ");
		f.subject.focus();
		return;
	}
	var str = f.email.value;
	if(!str) {
		alert("이메일을 입력하세요.");
		f.email.focus();
		return;
	}
	var str = f.question.value;
	if(!str){
		alert("내용을 입력하세요.");
		f.question.focus();
		return;
	}
	f.action="<%=cp%>/inquire/${mode}";
	f.submit();
	
}
</script>


<form name="createdForm" method="post" enctype="multipart/form-data">
<c:if test="${mode=='update'}">
	<input type="hidden" name="page" value="${page}">
</c:if>
<div align="center" class="box">
     <h3 style="margin-top:70px; margin-bottom:20px; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 35px; ">
     Q&nbsp; &amp; &nbsp;A <span><img width="70px" height="70px"
			src="<%=cp%>/resource/img/gangg.png"></span> </h3>
	
	<table class="freeboard">
		<tr class="f_line">
			<td align="left" style="font-weight: bold;" class="subtitle">제목</td>
			<td align="left" id="ftitle" style="color: gray;">
				<input name="subject" class="boxTF" style="width: 95%; color: gray;" value="${dto.subject}">
			</td>
		</tr>

		<tr class="f_line">
			<td align="left" style="color: gray;" class="subtitle">작성자</td>
			<td align="left" id="subcontent">${sessionScope.user.userId}</td>
		</tr>
		
		<tr class="f_line">
			<td align="left" style="color: gray;" class="subtitle">이메일</td>
			<td align="left" id="subcontent" >
				<input name="email" class="boxTF" style="width: 95%; color: gray;" value="${dto.subject}">
			</td>
		</tr>
		
	<tr class="f_line"> 
      <td align="left" style="color: gray;" class="subtitle">카테고리</td>
      <td style="padding-left:10px;"> 
           <select name="category" class="btn">
               <option value="스터디" ${dto.category=="스터디"?"selected='selected'":"" }>배송문의</option>
               <option value="결제문의" ${dto.category=="결제문의"?"selected='selected'":"" }>결제문의</option>
               <option value="회원가입" ${dto.category=="회원가입"?"selected='selected'":"" }>쿠폰문의</option>
               <option value="기타문의" ${dto.category=="기타문의"?"selected='selected'":"" }>기타문의</option>
           </select>
      </td>
  </tr>

	<tr class="fcontent" align="left">
		<td colspan="2" align="left" style="padding-left: 20px;">
			<textarea name="question" style="margin: 0px; width: 940px; height: 420px; border-color: #DDDFE0; resize: none; color: gray; border-radius: 4px;">${dto.question }</textarea>
		</td>
	</tr>
</table>

	<table>
		<tr>
			<td height="100px">
				<button class="btn" type="button" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>&nbsp;&nbsp;
				<button class="btn" type="reset">다시입력</button>&nbsp;&nbsp;
				<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/inquire/list';">${mode=='update'?'수정취소':'등록취소'}</button>&nbsp;&nbsp;
				<c:if test="${mode=='update'}"> 
					<input type="hidden" name="num" value="${dto.num}"> <!-- 수정할때 씀 -->
					<input type="hidden" name="page" value="${page}">
				</c:if>
			</td>
		</tr>
	</table>
	
</div>
	</form>
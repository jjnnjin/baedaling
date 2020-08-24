<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
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
	padding:3px 10px 5px;
	border-radius:4px;
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	margin-top: 20px;
}
}
</style>

<script type="text/javascript">
function login() {
	location.href="<%=cp%>/user/login";
}

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

function sendOk() {
	var f = document.boardForm;

	if(! f.categoryNum.value) {
		alert("분류 명을 선택하세요. ");
		f.groupCategoryNum.focus();
		return;
	}

        
	if(! f.subject.value) {
		alert("제목을 입력하세요. ");
		f.subject.focus();
		return;
	}

	if(! f.content.value) {
		alert("내용을 입력하세요. ");
		f.content.focus();
		return;
	}

	f.action="<%=cp%>/faq/${mode}";

	f.submit();
}



</script>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<div class="body-container" align="center" style="width: 1000px; margin: 0px auto; color: black;">
		<div class="body-title" align="center">
		<h3
			style="width: 80%; font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro'; font-size: 35px; margin-top: 75px;">
			FAQ&nbsp;<span><img id="f_img2"
				src="<%=cp%>/resource/img/gangg.png"></span>
		</h3>
		</div>
	<div>

		<div class="alert-info">
		    자주 묻는 질문 과 내용을 입력하세요
		</div>

		<form name="boardForm" method="post">
			  <table style="  width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#ffffff" style="font-weight: bold; color:gray; text-align: center; border-top: 1px solid #cccccc;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px; border-top: 1px solid #cccccc;" > 
			        <input  type="text" name="subject" class="boxTF" style=" width: 835px; border:1px solid #DDDFE0; padding:3px 5px 5px; border-radius: 4px; background-color: #ffffff; height: 25px;" value="${dto.subject}">
			      </td>
			  </tr>
			
			
			
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#ffffff" style="font-weight: bold; color:gray; text-align: center;">작성자</td>
			      <td style="padding-left:10px; color:gray;"> 
			          ${sessionScope.user.userName}
			      </td>
			  </tr>
			
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#ffffff" style="font-weight: bold; color:gray; text-align: center;">분&nbsp;&nbsp;&nbsp;&nbsp;류</td>
			      <td style="padding-left:10px;"> 
			        <select class="selectField" name="categoryNum" style="width: 150px;">
			        	<option value="">&nbsp; 분류 선택 &nbsp;</option>
			        	<c:forEach var="vo" items="${groupList}">
			        		<option value="${vo.categoryNum}" ${dto.categoryNum==vo.categoryNum?"selected='selected'":""}>${vo.category}</option>
			        	</c:forEach>
			        </select>
						<!-- <button type="button" class="btn" id="btnCategoryUpdate"> 변경 </button> -->
			      </td>
			  </tr>

			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#ffffff" style="font-weight: bold; color:gray; text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" rows="12" class="boxTA" style=" height: 400px; width: 835px; border:1px solid #DDDFE0; padding:3px 5px 5px; border-radius: 4px; background-color: #ffffff; resize: none;">${dto.content}</textarea>
			      </td>
			  </tr>

			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr > 
			      <td align="center">
			        <button  type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button  type="reset" class="btn">다시입력</button>
			        <button  type="button" class="btn" onclick="javascript:location.href='<%=cp%>/faq/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			         <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="num" value="${dto.num}">
			        	 <input type="hidden" name="page" value="${page}">
			        	 <input type="hidden" name="group" value="${group}">
			        </c:if>
			      </td>
			    </tr>
			  </table>
		</form>

	</div>

    <div id="category-dialog" style="display: none;">
    
    </div>
    
</div>
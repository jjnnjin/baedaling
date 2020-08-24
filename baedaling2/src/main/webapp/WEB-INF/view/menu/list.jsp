<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<title>Insert title here</title>
<style type="text/css">
.body{
	background-color: white;
}


</style>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}


.body-container {
    clear:both;
    box-sizing: border-box;  /* padding과 border는 크기에 포함되지 않음 */
    margin: 0px auto 15px;
    min-height: 500px;
    padding-top: 20px;
}

.imgLayout{
	width: 190px;
	height: 205px;
	padding: 10px 5px 10px;
	margin: 5px;
	border: 1px solid #DAD9FF;
	cursor: pointer;
}

</style>
<script type="text/javascript">
function ajaxFileJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
        ,processData: false  // file 전송시 필수
        ,contentType: false  // file 전송시 필수
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

$(function(){
	$("#tab-${group}").addClass("active");

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="<%=cp%>/menu/list?group="+tab;	
		location.href=url;
	});
});



$(function(){
	$("#addMenu").click(function(){
		$("form[name=menuForm]").each(function(){
			this.reset();
		});
		$('#addMenu-dialog').dialog({
			  modal: true,
			  height: 650,
			  width: 600,
			  title: '메뉴 등록',
			  close: function(event, ui) {
			  }
		});
	});
});

$(function(){
	$(".btnUpdateImage").click(function(){
		var menuNum = $(this).attr("data-menuNum");
		$("form[name=menuForm]").each(function(){
			this.reset();
		});
		
		$('#addMenu-dialog').dialog({
			  modal: true,
			  height: 650,
			  width: 600,
			  title: '메뉴 수정',
			  open: function() {
					var f = document.menuForm;
					
					$("#btnCancel").text("수정취소");
					$("#btnDelete").show();
					
					f.mode.value = "update";
					f.menuNum.value=menuNum;
					var url="<%=cp%>/menu/read";
					var query = "menuNum="+menuNum;
					
					var fn = function(data){
						
						var dto = data.dto;
						
						var menuNum = dto.menuNum;
						var menuName = dto.menuName;
						var menuPrice = dto.menuPrice;
						var menuCategoryNum = dto.menuCategoryNum;
						var origin = dto.origin;
						var menuInfo = dto.menuInfo;
						var originalFilename = dto.originalFilename;
						
						f.menuName.value = menuName;
						f.menuPrice.value = menuPrice;
						f.menuCategoryNum.value = menuCategoryNum;
						f.origin.value = origin;
						f.menuInfo.value = menuInfo;
						f.uploadFile.value = originalFilename;
						
						$("#btnDelete").attr("data-menuNum",menuNum);
						
					};

					ajaxJSON(url, "get", query, fn);
				
			  },
			  close: function(event, ui) {
			  }
		});
	});
});

$(function(){
	$("#btnDelete").click(function(){
		var menuNum = $(this).attr("data-menuNum");
		
		var f = document.menuForm;
		var url = "<%=cp%>/menu/delete";
		var query = "menuNum="+menuNum;
		
		var fn = function(data){
			var state=data.state;

	        if(state=="false") {
	            alert("메뉴 삭제실패");
	            return false;
	        }
	        location.href="<%=cp%>/menu/list";
		};
		ajaxJSON(url, "post", query, fn);
	});
	
});

function btnSendOk(){
	var f = document.menuForm;
	var mode = f.mode.value;
	
    var url="<%=cp%>/menu/"+mode;
    
    var query = new FormData(f); // IE는 10이상에서만 가능
    
	var fn = function(data){
		var state=data.state;

        if(state=="false") {
            alert("게시물 추가실패");
            return false;
        }
        location.href="<%=cp%>/menu/list";
	};
	
	ajaxFileJSON(url, "post", query, fn);
}



</script>
</head>
<body>
	
	<div class="body-container" style="width: 1000px; margin-left: 500px;">
    <div class="body-title">
        <h3><i class="far fa-image"></i> 메뉴 리스트 </h3>
    </div>
    
    <div>
    	<div style="clear: both;">
			<ul class="tabs">
				<li id="tab-0" data-tab="0">전체</li>
				 <c:forEach var="vo" items="${groupList}">
					<li id="tab-${vo.menuCategoryNum}" data-tab="${vo.menuCategoryNum}">${vo.menuCategoryName}</li>
				</c:forEach>
			</ul>
		</div>
    
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
		   <tr height="35">
		      <td align="left" width="50%">
		          ${dataCount}개(${page}/${total_page} 페이지)
		      </td>
		      <td align="right">
		          &nbsp;
		      </td>
		   </tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
<c:forEach var="dto" items="${list}" varStatus="status">
                 <c:if test="${status.index==0}">
                       <tr>
                 </c:if>
                 <c:if test="${status.index!=0 && status.index%4==0}">
                        <c:out value="</tr><tr>" escapeXml="false"/>
                 </c:if>
			     <td width="210" align="center">
			        <div class="imgLayout">
			             <img src="<%=cp%>/uploads/menu/${dto.saveFilename}" width="180"
			                   height="180" border="0" data-menuNum="${dto.menuNum}" class="btnUpdateImage">
			           <span class="menuName">
			                   ${dto.menuName}
			             </span>
			            
			         </div>
			     </td>
</c:forEach>

<c:set var="n" value="${list.size()}"/>
<c:if test="${n>0&&n%4!=0}">
		        <c:forEach var="i" begin="${n%4+1}" end="4" step="1">
			         <td width="210">
			             
			         </td>
		        </c:forEach>
</c:if>
	
<c:if test="${n!=0 }">
		       <c:out value="</tr>" escapeXml="false"/>
</c:if>
		</table>           
		 
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
			<td align="center">
			    ${dataCount==0?"등록된 게시물이 없습니다.":paging}
			 </td>
			 <td align="right" width="100">
		         <button id="addMenu" type="button" style="background-color: white; height: 30px; width: 70px; border: 0.5px solid;">메뉴추가</button>
		      </td>
		   </tr>
		</table>
	</div>
</div>
	
<div id="addMenu-dialog" style="display: none;">
		<form name="menuForm" method="post" enctype="multipart/form-data">
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">메뉴이름</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="menuName" id="form-subject" maxlength="100" class="boxTF" style="width: 95%;">
			        </p>
			        <p class="help-block">* 메뉴이름은 필수 입니다.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">카테고리</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			          <select name="menuCategoryNum" id="form-color" class="selectField">
			              <option value="1">주메뉴</option>
			              <option value="2">부메뉴</option>
			              <option value="3">사이드메뉴</option>
			              <option value="4">음료/주류</option>
			          </select>
			        </p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">메뉴가격</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 5px; margin-bottom: 5px;">
			             <input type="text" name="menuPrice">
			        </p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">원산지</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <textarea name="origin" class="boxTA" style="width:93%; height: 70px;"></textarea>
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">메뉴소개</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <textarea name="menuInfo" id="form-memo" class="boxTA" style="width:93%; height: 70px;"></textarea>
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">이미지 첨부</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input class="boxTF" type="file" name="upload" size="53"
							style="width: 95%; color: black">
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">첨부된이미지</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			        	<input class="boxTF" type="text" name="uploadFile" size="53"
							style="width: 95%; color: black" readonly="readonly">
			        </p>
			      </td>
			  </tr>
			  
			  
			  
			  
			  <tr height="45">
			      <td align="center" colspan="2">
			      	<input type="hidden" name="menuNum" value="0">
			      	<input type="hidden" name="saveFilename" value="">
			      	<input type="hidden" name="mode" value="created">
			        <button type="button" class="btn" onclick="btnSendOk();">메뉴등록</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" id="btnCancel">등록취소</button>
			        <button type="button" class="btn" id="btnDelete" style="display: none;" >메뉴삭제</button>
			      </td>
			  </tr>
			</table>
		</form>
    </div>
  	
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.ui-dialog .ui-dialog-titlebar {
    padding: .4em 1em;
    position: relative;
    background: #d9edf7;
    border: 1px solid #9acfea;
    height: 26px;
}

</style>


<table style="margin: 10px auto 20px; width: 100%; border-spacing: 1px; background: #e7e7e7">
<tr height="37" style="background: #ffffff;">
    <td align="right" width="15%" style="padding-right: 7px;"><label style="font-weight: 900;">아이디</label></td>
    <td align="left" width="35%" style="padding-left: 5px;"><span>${dto.userId}</span></td>
    <td align="right" width="15%" style="padding-right: 7px;"><label style="font-weight: 900;">회원번호</label></td>
    <td align="left" width="35%" style="padding-left: 5px;"><span>${dto.userIdx}</span></td>
</tr>
<tr height="37" style="background: #ffffff;">
    <td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">이름</label></td>
    <td align="left" style="padding-left: 5px;"><span>${dto.userName}</span></td>
    <td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">생년월일</label></td>
    <td align="left" style="padding-left: 5px;"><span>${dto.birth}</span></td>
</tr>
<tr height="37" style="background: #ffffff;">
    <td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">전화번호</label></td>
    <td align="left" style="padding-left: 5px;"><span>${dto.tel}</span></td>
    <td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">이메일</label></td>
    <td align="left" style="padding-left: 5px;"><span>${dto.email}</span></td>
</tr>
<tr height="37" style="background: #ffffff;">
    <td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">회원가입일</label></td>
    <td align="left" style="padding-left: 5px;"><span>${dto.created_date}</span></td>
    <td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">계정상태</label></td>
    <td align="left" style="padding-left: 5px;"> ${dto.enabled==1?"활성":"잠금"}</td>
</tr>

<tr height="37" style="background: #ffffff;">
    <td align="right" width="15%" style="padding-right: 9px;"><label style="font-weight: 900;">주소</label></td>
    <td align="left" colspan="3" style="padding-left: 5px;">
		  ${dto.addr1} ${dto.addr2}
    </td>
</tr>
</table>

<form id="detailedUserForm"  name="detailedUserForm" method="post">
<h3 style="font-size: 13px; color: #6a6a6a; font-weight: bold;">회원 상태 변경</h3>
<table style="margin: 5px auto 0px; width: 100%; border-spacing: 1px; background: #e7e7e7">
<tr height="37" style="background: #ffffff;">
   <td align="right" width="15%" style="padding-right: 9px; height:30px;"><label style="font-weight: 900;">계정상태</label></td>
   <td style="padding-left: 5px;">
       <select style="height: 30px; margin-bottom: 0px;" class="btn" id="stateCode" name="stateCode" onchange="selectStateChange()">
       	  <option value="">&nbsp;상태코드&nbsp;</option>
       	  <c:if test="${dto.enabled==0}"> <!-- 0일때 잠금해제 뜸 -->
       	      <option value="1">잠금 해제</option>
       	  </c:if>
       	  <option value="0">불법적인 방법으로 로그인</option>
       	  <option value="0">불건전 게시물 등록</option>
       	  <option value="0">기타 약관 위반</option>
       </select>
   </td>
</tr>

</table>
<input type="hidden" name="userId" value="${dto.userId }">
</form>



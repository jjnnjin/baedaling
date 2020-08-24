<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="all_menuList" style="width: 700px; margin: 0px auto;">

<div style="width: 700px;">
<div class="menuImg_table" align="center" style=" width:705px; margin: 5px; padding: 5px;">
	<c:forEach var="dto" items="${menuList }">
		<ul class="menu" data-menuNum="${dto.menuNum }">
			<li><img class="store_menu_img" src="<%=cp%>/uploads/menu/${dto.saveFilename}" onerror="this.src='<%=cp%>/resource/img/ready.jpg'"></li>
			<li style="text-align: center;" >${dto.menuName }</li>
			<li style="text-align: center;">${dto.menuPrice }</li>
		</ul>
	</c:forEach>

</div>
</div>
<table class="menu_table">
	<tr>
		<td style="font-weight: bold;"><span style="color: #F4D005;"><i class="fas fa-trophy"></i> </span>&nbsp;인기 메뉴 <span style="width:700px; margin-left: 20px; padding-left: 430px;"></span></td>
	</tr>
	<c:forEach var="vo" items="${listCatrgory }">
		<tr style="width: 630px;"  class="listCatrgory" data-menuCategoryNum="${vo.menuCategoryNum }" >
			<td style="width: 630px;">${vo.menuCategoryName }</td>
		</tr>
		<tr class = "detailCategory" style="display: none;">
			<td>
	
			</td>
		</tr>
		
	
	</c:forEach>
</table>

<div id="readMenu-dialog" style="display: none;">
		<form name="readMenuForm">
			<table style="width: 100%;  margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tr>
			      <td colspan="2">
			        <img class="detail-image"  onerror="this.src='<%=cp%>/resource/img/ready.jpg'" style="display: block; width: 100%;  height: 300px;">
			      </td>
			  </tr>
			
			  <tr>
			      <td colspan="2" class="detail-text" id="menuNameView" style="text-align: center; font-size: 25px; padding-top :15px;">

			      		
			      </td>
			  </tr>
			  <tr>
			  	<td style="text-align:center; color: #999999; padding: 10px;" colspan="2" id = "menuInfoView"></td>
			  </tr>
			
			  <tr style="height: 100px;">
			      <td style="border-top: 1px solid #f0f0f0; border-bottom:1px solid #f0f0f0;">
			      	가격 
			        <!-- <input class="detail-price" type="text" name="menuPrice" readonly="readonly"> -->
			      </td >
			      <td style="border-top: 1px solid #f0f0f0; border-bottom:1px solid #f0f0f0; text-align: right;">
			      	<span style="text-align:right; font-weight: bold; padding-right: 15px; font-size: 14px;" id="menuPriceView"></span>원 
			      </td>
			  </tr>
				
			  <tr>
			      
			      <td style="width: 50%; text-align: center; background-color:#38BCC6; color: white; height: 60px;" class="buyAdd">
			       	<span  style="font-weight: bold;">주문표에 추가</span>
			      </td>
			      <td style="width: 50%; text-align: center; background-color:#555555; color: white; height: 60px;">
			      	<span style="font-weight: border: ;">취소</span>
			      </td>
			  </tr>
			  <tr>
			  	<td colspan="2">
			  		<input type="hidden" name="menuNum">
			  	</td>
			  </tr>
			 
			  </table>
		</form>
    </div>

</div>

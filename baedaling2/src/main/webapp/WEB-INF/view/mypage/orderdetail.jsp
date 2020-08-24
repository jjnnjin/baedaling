<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_orderdetail.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_user.css" type="text/css">
  
            <div class="orderdetail_container">
            	<div style="width: 800px;">
            		<table style="width: 100%; border: 1px solid #cccccc; border-collapse: collapse; border-spacing: 0;">
						<tr height="45">
							<td colspan="2" align="left" style="padding: 10px 10px 5px 15px; font-size: 20px; font-weight: bold; ">
									불맛로맨스 
							</td>
						</tr>
						<tr height="50" style="border-bottom:1px solid #cccccc;">	
							<td align="left" style="font-size: 15px; padding: 5px 10px 5px 15px;">
								주문일시 : 2020-06-01 18:30
							</td>
							<td align="right">
								<button class="btn btn1">리뷰작성</button>
								<button class="btn btn2">가게보기</button>
							</td>
						</tr>
            			<tr height="40" style="border-bottom:1px solid #cccccc;">
            				<td style="padding: 10px 10px 5px 15px; font-size: 15px;"> 짬뽕 2개 </td>
            				<td style="padding: 10px 10px 10px 15px; font-size: 15px;" align="right"> 13,000원 </td>
            			</tr>
            			<tr height="40" style="border-bottom:1px solid #cccccc;">
            				<td style="padding: 10px 10px 5px 15px; font-size: 15px;"> 찹쌀 탕수육 中 1개 </td>
            				<td style="padding: 10px 10px 10px 15px; font-size: 15px;" align="right"> 16,000원 </td>
            			</tr>
            			<tr height="40">
            				<td style="padding: 0px 0px 0px 15px; font-size: 17px; font-weight: bold;"> 총 주문금액 </td>
            				<td style="padding: 10px 10px 10px 15px; font-size: 17px; font-weight: bold;" align="right"> 29,000원 </td>
            			</tr>
            			<tr style="border-bottom:1px solid #cccccc;">
            				<td style="padding: 0px 10px 5px 15px; font-size:17px; font-weight: bold;"> 결제방법 </td>
            				<td style="padding: 0px 10px 5px 5px; font-size:17px; font-weight: bold;" align="right"> 직접 만나서 결제 </td>
            			</tr>
            			<tr height="40">
            				<td colspan="2" style="padding: 5px 0px 0px 15px; font-size:17px; font-weight: bold;"> 배달주소 </td>
            			</tr>
            			<tr style="border-bottom:1px solid #cccccc;">
            				<td colspan="2" style="padding: 0px 10px 5px 15px; font-size:15px; font-weight: normal;"> 서울 성북구 석관동 </td>
            			</tr>
            			<tr>
            				<td colspan="2" style="padding: 5px 0px 0px 15px; font-size:17px; font-weight: bold;"> 전화번호 </td>
            			</tr>
            			<tr style="border-bottom:1px solid #cccccc;">
            				<td colspan="2" style="padding: 0px 10px 5px 15px; font-size: 15px;"> 010-1111-2222 </td>
            			</tr>
            			<tr>
            				<td colspan="2" style="padding: 5px 0px 0px 15px; font-size:17px; font-weight: bold;"> 가게 사장님께 </td>
            			</tr>
            			<tr>
            				<td colspan="2" style="padding: 0px 10px 5px 15px; font-size: 15px;"> 단무지 많이 주세여 </td>
            			</tr>
            		</table>
            		
            		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
					   <tr height="35">
							<td align="center">
						        ${dataCount==0?"등록된 게시물이 없습니다.":paging}
							</td>
					   </tr>
					</table>
            		
            		<table>
            			<tr align="right" height="35">
            				<td><button class="btn btn3">리스트</button></td>
            			</tr>
            		</table>
            	</div>
            </div>     
                 
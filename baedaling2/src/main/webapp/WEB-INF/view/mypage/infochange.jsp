<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
$(function(){
	$(".send_info_btn").click(function(){
		var f = document.infochangeForm;
		var str;
		var $messageline = $(this).closest("table");
		
	 	str = f.userId.value;
		str = str.trim();
		$messageon = $messageline.find("#message_line1");
		if(!str) {
			f.userId.focus();
			$messageon.html("<span style='color:red; text-align:centor;'>아이디를 입력하세요</span>");
			return false;
		} 
		
		 if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
			f.userId.focus();
			$messageon.html("<span style='color:red; text-align:centor;'>아이디는 5~10자이며 첫글자는 영문자이어야 합니다.</span>");
			return false;
		} 
		f.userId.value = str;
		
		str = f.userPwd.value;
		str = str.trim();
		$messageon = $messageline.find("#message_line2");
		if(!str) {
			f.userPwd.focus();
			$messageon.html("<span style='color:red; text-align:centor;'>패스워드를 입력하세요.</span>");
			return false;
		}
		if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
			f.userPwd.focus();
			$messageon.html("<span style='color:red; text-align:centor;'>패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</span>");
			return false;
		}
		f.userPwd.value = str;
		$messageon = $messageline.find("#message_line3");
		if(str!= f.userPwd2.value) {
	        f.userPwd2.focus();
	        $messageon.html("<span style='color:red; text-align:centor;'>패스워드가 일치하지 않습니다.</span>");
	        return false;
		}
		
		str = f.userName.value;
		str = str.trim();
		$messageon = $messageline.find("#message_line4");
	    if(!str) {
	        f.userName.focus();
	        $messageon.html("<span style='color:red; text-align:centor;'>이름을 입력하세요.</span>");
	        return false;
	    }
	    f.userName.value = str;
	    
	    if(f.date.value < 10) {
	    	f.date.value = "0"+f.date.value;
	    }
	    str = f.year.value+"-"+f.month.value+"-"+f.date.value;
	    str.trim();
	    $messageon = $messageline.find("#message_line5");
	    if(!str || !isValidDateFormat(str)) {
	        f.year.focus();
	    	$messageon.html("<span style='color:red; text-align:centor;'>생년월일를 입력하세요[YYYY-MM-DD].</span>");
	        return false;
	    }
	    
	    str = f.email.value;
		str = str.trim();
		$messageon = $messageline.find("#message_line6");
	    if(!/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i.test(str)) {
	        f.email.focus();
	    	$messageon.html("<span style='color:red; text-align:centor;'>이메일을 입력하세요[YYYY-MM-DD].</span>");
	        return false;
	    }
	    
	    str = f.tel.value;
		str = str.trim();
		$messageon = $messageline.find("#message_line7");
	    if(/^\d{3}-\d{3,4}-\d{4}$/.test(str)) {
	    	$messageon.html("<span style='color:red; text-align:centor;'>휴대전화번호를 입력하세요.[0100000000].</span>");
	        f.tel1.focus();
	        return false;
	    }
	    
	    
	    str = f.zip.value;
	    str = f.addr2.value;
		str = str.trim();
		$messageon = $messageline.find("#message_line8");
	    if(!str|| !addr2) {
	    	$messageon.html("<span style='color:red; text-align:centor;'>주소를 입력하세요.</span>");
	        f.addr2.focus();
	        return false;
	    }
	    
	    $('#longitude').val(marker.getPosition().Ga);
	    $('#latitude').val(marker.getPosition().Ha);
	    
	    
	    f.action ="<%=cp%>/mypage/infochange";
	    f.submit();
	});
});
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/join.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/mypage_user.css" type="text/css">

<div class="mypage_container">
    <div class="body-container">
        <div class="body-left">
        	<div class="list-group">
                <div class="list-group-item lefthead"> 마이페이지</div>
                <a href="<%=cp%>/mypage/userInfo" class="list-group-item active">회원정보</a>
                <a href="<%=cp%>/mypage/userorderList" class="list-group-item">주문내역</a>
                <a href="<%=cp%>/mypage/recommendlist" class="list-group-item">내가 쓴 게시물</a>
                <a href="<%=cp%>/mypage/reviewList" class="list-group-item">내가 쓴 리뷰</a>
                <a href="<%=cp%>/mypage/myInquire" class="list-group-item">내가 쓴 문의</a>
                <a href="<%=cp%>/mypage/message" class="list-group-item">회원정보수정</a>
                <a href="#" class="list-group-item">회원탈퇴</a>
            </div>     
        </div>
    
        <div class="body-right">
            <div class="body-right-container">
                 <div class="body-title">
                     <h3><span style="font-family: Webdings">4</span> 마이페이지 </h3>
                 </div>
		 <div id="container_join">
			<div id="body_line">
				<form name="infochangeForm" method="post">
					<table>
						<tr class="etch_list1">
							<td class="textinfo_tr">아이디</td>
						</tr>
						<tr class="etch_list2">
							<td class="inputinfo_tr"><input type="text" class="input_normal" name="userId" value="${sessionScope.user.userId}" readonly='readonly'></td>
						</tr>
						<tr class="etch_list3">
							<td id="message_line1"></td>
						</tr>
						<tr class="etch_list1">
							<td class="textinfo_tr">비밀번호</td>
						</tr>
						<tr class="etch_list2">
							<td class="inputinfo_tr"><input type="password" class="input_normal" name="userPwd"></td>
						</tr>
						<tr class="etch_list3">
							<td id="message_line2"></td>
						</tr>
						<tr class="etch_list1">
							<td class="textinfo_tr">비밀번호 확인</td>
						</tr>
						<tr class="etch_list2">
							<td class="inputinfo_tr"><input type="password" class="input_normal" name="userPwd2"></td>
						</tr>
						<tr class="etch_list3">
							<td id="message_line3"></td>
						</tr>
						
						<tr class="etch_list1">
							<td class="textinfo_tr">이름</td>
						</tr>
						<tr class="etch_list2">
							<td class="inputinfo_tr"><input type="text" class="input_normal" name="userName" value="${sessionScope.user.userName}" readonly='readonly'></td>
						<tr class="etch_list3">
							<td id="message_line4"></td>
						</tr>
						
						<tr class="etch_list1">
							<td class="textinfo_tr">생년월일</td>
						</tr>
						<tr class="etch_list2">
							<td class="inputinfo_tr">
							<input type="text" class="birth_tr" name="year" value="${dto.year}">
							<select class="birth_tr birth_tr_select" name="month">
									<option value="">월</option>
									<option value="01" ${dto.month=="01" ? "selected='selected'" : ""}>1</option>
									<option value="02" ${dto.month=="02" ? "selected='selected'" : ""}>2</option>
									<option value="03" ${dto.month=="03" ? "selected='selected'" : ""}>3</option>
									<option value="04" ${dto.month=="04" ? "selected='selected'" : ""}>4</option>
									<option value="05" ${dto.month=="05" ? "selected='selected'" : ""}>5</option>
									<option value="06" ${dto.month=="06" ? "selected='selected'" : ""}>6</option>
									<option value="07" ${dto.month=="07" ? "selected='selected'" : ""}>7</option>
									<option value="08" ${dto.month=="08" ? "selected='selected'" : ""}>8</option>
									<option value="09" ${dto.month=="09" ? "selected='selected'" : ""}>9</option>
									<option value="10" ${dto.month=="10" ? "selected='selected'" : ""}>10</option>
									<option value="11" ${dto.month=="11" ? "selected='selected'" : ""}>11</option>
									<option value="12" ${dto.month=="12" ? "selected='selected'" : ""}>12 </option> 
								</select>
							<input type="text" class="birth_tr" name="date" value="${dto.date}">
							</td>
						</tr>
						<tr class="etch_list3">
							<td id="message_line5"></td>
						</tr>
						
						<tr class="etch_list1">
							<td class="textinfo_tr">이메일</td>
						</tr>
						<tr class="etch_list2">
							<td class="inputinfo_tr"><input type="text" class="input_normal" name="email" value="${dto.email}"></td>
						</tr>
						<tr class="etch_list3">
							<td id="message_line6"></td>
						</tr>
						
						<tr class="etch_list1">
							<td class="textinfo_tr">휴대전화</td>
						</tr>
						<tr class="etch_list2">
							<td class="inputinfo_tr"><input type="text" class="input_normal" name="tel" value="${dto.tel}"></td>
						</tr>
						<tr class="etch_list3">
							<td id="message_line7"></td>
						</tr>
						
						<tr class="etch_list1">
							<td class="textinfo_tr">주소</td>
						</tr>
						<tr class="etch_list2">
							<td class="inputinfo_tr"><input type="text" class="input_normal" id="zip" name="zip" value="${dto.zip}" style="width: 270px; margin-right: 10px;" readonly="readonly"><button type="button" class="city_search_btn" onclick="daumPostcode();">주소검색</button></td>
						</tr>
						<tr class="etch_list2">
							<td class="inputinfo_tr"><input type="text" class="input_normal" id="addr1" name="addr1" value="${dto.addr1}"></td>
						</tr>
						<tr class="etch_list2">
							<td class="inputinfo_tr"><input type="text" class="input_normal" id="addr2" name="addr2" value="${dto.addr2}"></td>
						</tr>
						<tr class="etch_list3">
							<td id="message_line8">
								<span style='color:red; text-align:centor; font-size: 12px;'>정확한 주소설정을 위해 마커를 이용하여 위치를 표시해 주세요.</span>
							</td>
						</tr>
						
						<tr class="etch_list1">
							<td class="inputinfo_tr"><button class="send_lck_btn" id="find_lck_btn" type="button">위치찾기</button></td>
						</tr>
						<tr class="box_list">
							<td class="boxinfo_tr"><div id="map" style="width::472px; height:400px; margin-bottom: 10px;"></div></td>
						</tr>
						
						<tr class="etch_list1">
							<td class="inputinfo_tr"><button type="button" class="send_info_btn" >수정하기</button></td>
						</tr>	
					</table>
						<input type="hidden" id="longitude" name="longitude">
						<input type="hidden" id="latitude" name="latitude">
				</form>
			</div>	
		</div>
	</div>
</div>
</div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=29c323b80554e07678426dcb232dd593&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

</script>
<script type="text/javascript">
var marker = null;
$(function(){
	$("#find_lck_btn").on('click',function(){
		var addrval = $("#addr1").val().replace(/ *\([^)]*\) */g, "");
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(addrval, function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		        marker.setDraggable(true);
				console.log(marker.getPosition());
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});    
	});
});
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr2').focus();
            }
        }).open();
    }
</script>
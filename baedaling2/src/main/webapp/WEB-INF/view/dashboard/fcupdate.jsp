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
		var f = document.fcjoinform;
		var str;
		var $messageline = $(this).closest("table");
		
		/*str = f.userId.value;
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
	    
	    if(f.date.value<10){
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
	    } */
	    
	    
	    str = f.zip.value;
	    str = f.addr2.value;
		str = str.trim();
		$messageon = $messageline.find("#message_line8");
	    if(!str|| !addr2) {
	    	$messageon.html("<span style='color:red; text-align:centor;'>주소를 입력하세요.</span>");
	        f.addr2.focus();
	        return false;
	    }
	    
	    str = f.name.value;
	    str = str.trim();
	    $messageon = $messageline.find("#message_line9");
	    if(!str) {
	    	$messageon.html("<span style='color:red; text-align:centor;'>업체명을 입력하세요.</span>");
	        f.tel1.focus();
	        return false;
	    }

	    
	      if( geocoder){
	   		$('#longitude').val(marker.getPosition().Ga);	  
	   		$('#latitude').val(marker.getPosition().Ha);
	    }      
	   
	    f.action ="<%=cp%>/dashboard/updateRestaurant";
	    f.submit();
	});
});

<%-- function userIdCheck() {
	var str = $("#userId").val();
	str = str.trim();
	
	var url="<%=cp%>/user/userIdCheck";
	var q="userId="+str;
	
	$.ajax({
		type:"post"
		,url:url
		,data:q
		,dataType:"json"
		,success:function(data) {
			var p=data.passed;
			if(p=="true") {
				var s="<span style='color:red; text-align:centor;'>"+str+"</span> 아이디는 사용 가능합니다.";
				$("#userId").parent().parent().next().find("#message_line1").html(s);
			} else {
				var s="<span style='color:red; text-align:centor;'>"+str+"</span> 아이디는 사용할 수 없습니다.";
				$("#userId").parent().parent().next().find("#message_line1").html(s);
				$("#userId").val("");
				$("#userId").focus();
			}
		}
	    ,error:function(e) {
	    	console.log(e.responseText);
	    }
	});
	
} --%>
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/fcjoin.css" type="text/css">
 <div id="container_join">
		<div id="body_line">
		<form id="" name="fcjoinform" method="post">
			<table>
				<!-- <tr class="etch_list1">
					<td class="textinfo_tr">아이디</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" name="userId" id="userId" onchange="userIdCheck();"></td>
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
					<td class="inputinfo_tr"><input type="text" class="input_normal" name="userName"></td>
				<tr class="etch_list3">
					<td id="message_line4"></td>
				</tr>
				
				<tr class="etch_list1">
					<td class="textinfo_tr">생년월일</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr">
					<input type="text" class="birth_tr" name="year">
					<select class="birth_tr birth_tr_select" name="month">
							<option value="">월</option>
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12 </option> 
						</select>
					<input type="text" class="birth_tr" name="date">
					</td>
				</tr>
				<tr class="etch_list3">
					<td id="message_line5"></td>
				</tr>
				
				<tr class="etch_list1">
					<td class="textinfo_tr">이메일</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" name="email"></td>
				</tr>
				<tr class="etch_list3">
					<td id="message_line6"></td>
				</tr>
				
				<tr class="etch_list1">
					<td class="textinfo_tr">휴대전화</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" name="tel"></td>
				</tr>
				<tr class="etch_list3">
					<td id="message_line7"></td>
				</tr>
				
				<tr class="etch_list1">
					<td class="textinfo_tr">주소</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" id="zip" name="zip" style="width: 270px; margin-right: 10px;" readonly="readonly"><button type="button" class="city_search_btn" onclick="daumPostcode1();">주소검색</button></td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" id="addr1" name="addr1" readonly="readonly"></td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" id="addr2" name="addr2"></td>
				</tr>
				<tr class="etch_list3">
					<td id="message_line8">
					</td>
				</tr> -->
				
				<tr class="etch_list1">
					<td class="textinfo_tr">업체명</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" name="name" value = "${dto.name }"></td>
				<tr class="etch_list3">
					<td id="message_line9"></td>
				</tr>
				
				<tr class="etch_list1">
					<td class="textinfo_tr">상호명</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" name="mutualName" value = "${dto.mutualName }"></td>
				<tr class="etch_list3">
					<td id="message_line10"></td>
				</tr>

				<tr class="etch_list1">
					<td class="textinfo_tr">사업자 등록번호</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" name="licenseNumber" value = "${dto.licenseNumber }"></td>
				<tr class="etch_list3">
					<td id="message_line11"></td>
				</tr>
				
				<tr class="etch_list1">
					<td class="textinfo_tr">업종</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr">
						<select id="select_typecategoryNum" name="typeCategoryNum">
							<option value="">선택</option>
							<option value="1">브런치</option>
							<option value="2">한식</option>
							<option value="3">분식</option>
							<option value="4">야식</option>
							<option value="5">일식</option>
							<option value="6">중식</option>
							<option value="7">치킨</option>
							<option value="8">패스트푸드</option>
							<option value="9">디저트</option>
							<option value="10">피자</option>
							<option value="11">양식</option>
							<option value="12">기타</option>
						</select>
					</td>
				<tr class="etch_list3">
					<td id="message_line12"></td>
				</tr>
				
				<tr class="etch_list1">
					<td class="textinfo_tr">업체 전화번호</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" name="fctel" value = "${dto.fctel }"></td>
				</tr>
				<tr class="etch_list3">
					<td id="message_line13"></td>
				</tr>
				
				<tr class="etch_list1">
					<td class="textinfo_tr">업체 주소</td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" id="zip" name="zip" style="width: 270px; margin-right: 10px;" readonly="readonly" value = "${dto.zip }"><button type="button" class="city_search_btn" onclick="daumPostcode2();">주소검색</button></td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" id="addr1" name="addr1" readonly="readonly" value = "${dto.addr1 }"></td>
				</tr>
				<tr class="etch_list2">
					<td class="inputinfo_tr"><input type="text" class="input_normal" id="addr2" name="addr2" value = "${dto.addr2 }"></td>
				</tr>
				<tr class="etch_list3">
					<td id="message_line14">
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
					<td class="inputinfo_tr"><button class="send_info_btn" type="button">가입하기</button></td>
				</tr>
				<tr height="30">
			        <td align="center" style="color: blue;">${message}</td>
			    </tr>
				
				
			</table>
			<input type="hidden" id="longitude" name="longitude" value = "${dto.longitude }">
			<input type="hidden" id="latitude" name="latitude" value = "${dto.latitude }">
			<input type="hidden" id="beforeLongitude" name="beforeLongitude" value = "${dto.longitude }">
			<input type="hidden" id="beforeLatitude" name="beforeLatitude" value = "${dto.latitude }">
			<input type="hidden" name="restaurantsNum" value="${dto.restaurantsNum }">
			</form>
		</div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=29c323b80554e07678426dcb232dd593&libraries=services"></script>
<script>
var longitude = $("#beforeLongitude").val();
var latitude = $("#beforeLatitude").val();
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(longitude, latitude), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

</script>
<script type="text/javascript">
var marker = null;
var geocoder = null;
$(function(){
	$("#find_lck_btn").on('click',function(){
		var addrval = $("#addr1").val().replace(/ *\([^)]*\) */g, "")
		 geocoder = new kakao.maps.services.Geocoder();

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
    function daumPostcode1() {
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
<script>
    function daumPostcode2() {
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
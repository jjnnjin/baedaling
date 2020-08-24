<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/@kfonts/bm-hanna-pro/index.css" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=29c323b80554e07678426dcb232dd593&libraries=services"></script>
<script type="text/javascript">
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
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	}
	
	function ajaxXML(url,type,query,fn){
		$.ajax({
			type:type,
			url:url,
			data:query,
			dataType:"xml",
			success:function(data) {
				fn(data);
			},
			error:function(e){
				console.log(e.responseText);
			}
		});
	}
	
	var surl="";
	$(function(){
		$("#inputbutton").click(function(){
			var url="<%=cp%>/point/search";
			var point = $(this).closest("li").find("#inputline").val();
			var query="point="+point;
			var out="";
			var fn=function(data) {
				surl="ok";
				$('#point_result_list').find('li').remove();
				$(data).find('newAddressListAreaCdSearchAll').each(function(){
					var lnmAdres = $('lnmAdres',this).text();
					var rnAdres = $('rnAdres',this).text();
					$('#point_result_list').find('ul').append("<li class='point_search_li' data_point='"+rnAdres+"'><b class='point_search_b'>도로명 :</b>"+lnmAdres+"<br><b class='point_search_b'>지번 :</b>"+rnAdres+"</li>");
					$('#point_result_list').show();
				});
			};
			ajaxXML(url, "post", query, fn);
		});
	});
	
	$(function(){
		$("#inputline,#point_result_list").hover(function(){
			$('#point_result_list').show();
		},function(){
			$('#point_result_list').hide();
		});
	});
	
	$(function(){
		$("body").on("mouseover", ".point_search_ul li", function(){
			$(this).css("background", "#76d1d8");
		});
		$("body").on("mouseout", ".point_search_ul li", function(){
			$(this).css("background", "white");
		});		
	});	
	
	$(function(){
		$(".top_bbs_sub").add(".top_bbs_sub").parent().hover(function(){
			$('.top_bbs_sub').show();
		},function(){
			$('.top_bbs_sub').hide();
		});
	});
	
	$(function(){
		$(".top_bbs_sub2").add(".top_bbs_sub2").parent().hover(function(){
			$('.top_bbs_sub2').show();
		},function(){
			$('.top_bbs_sub2').hide();
		});
	});
	
	$(function(){
		$("body").on("click",".point_search_ul li", function(){
			var point = $(this).attr('data_point');
			point.replace(/ *\([^)]*\) */g, "");
			var geocoder = new kakao.maps.services.Geocoder();
			var callback = function(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
			    	var item = result[0].address;
			    	var x = item.x;
			    	var y = item.y;
			    	var addr = item.address_name;
			    	ajaxPoint(x,y,addr);
					$("#inputline").val(addr);
			    }
			};
			geocoder.addressSearch(point, callback);
		});
	});
	
	function ajaxPoint(x,y,addr){
		var url = "<%=cp%>/user/location";
		var query = "ln="+x+"&lt="+y+"&addr="+addr;
		var fn = function(){
		};
		ajaxJSON(url, "post", query, fn);
	}
	
</script>


<div id="menu-wrapper" >
      <div id="menu" class="container">
         <a href="<%=cp%>/main"><img align="left" src="<%=cp%>/resource/img/logo.png" id="logo-img"></a>
         	<ul class="snip1275">
            	<li><a href="<%=cp%>/main" data-hover="주문">주문</a></li>
               	<li><a href="#" data-hover="게시판">게시판</a>
               		<ul class="top_bbs_sub" style="padding: 0px;">
               			<li class="sub_li"><a href="<%=cp%>/freeboard/list" data-hover="자유게시판">자유게시판</a></li>
               			<li class="sub_li"><a href="<%=cp%>/recommend/list" data-hover="추천게시판">추천게시판</a>
               		</ul>
               	</li>
               	<li><a href="<%=cp%>/event/list" data-hover="이벤트">이벤트</a></li>
				<li><a href="<%=cp%>/notice/list" data-hover="공지사항">공지사항</a></li>
				<li><a href="#" data-hover="고객센터">고객센터</a>
					<ul class="top_bbs_sub2" style="padding: 0px;">
               			<li class="sub_li"><a href="<%=cp%>/inquire/created" data-hover="1:1문의">1:1문의</a></li>
               			<li class="sub_li"><a href="<%=cp%>/faq/list" data-hover="FAQ">FAQ</a>
               		</ul>
				</li>
			</ul>
      </div>
   </div>
   
   <c:choose>
   	<c:when test="${searchBar=='true' }">
	    <div id="logo" class="container">
	      <h1 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 40px;"><a href="#"> "&nbsp;&nbsp;어&nbsp;디&nbsp;로&nbsp;<span style="color:#276CA2; ">&nbsp;배&nbsp;달&nbsp;</span>해&nbsp;드&nbsp;릴&nbsp;까&nbsp;요&nbsp;?&nbsp;&nbsp;"</a></h1>
	   </div>
	   <div id="page" class="container">
	      <div>
	         <div class="entry" style="margin: 0px;" align="center">
	            <ul>
	               <li style="list-style: none;">
	                  <input id="inputline" type="search" placeholder="주소입력창" value="">
	                  <button id="inputbutton" type="button">검색</button>
	               </li>
	            </ul>
	            <div id="point_result_list" style="display: none; border-bottom-left-radius: 4px; border-bottom-right-radius: 4px;">
					<ul class="point_search_ul">
	            	</ul>
				</div>
	         </div>
	      </div>
	   </div> 
	    <hr style="border: 0.5px solid #D8D8D8;"> 		
   	</c:when>
   	<c:when test="${searchBar=='recommendBoard' }">
   		<div style="background-image: url('<%=cp%>/resource/img/banner/recommandbanner.jpg'); width:100%; height:345px;">
		   <div id="logo" class="container">
		      <h1 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 50px; padding: 100px 0px 0px 0px;"><a href="#" style="color: white; font-size: 50px;"> "&nbsp;&nbsp;오&nbsp;늘&nbsp;&nbsp;저&nbsp;녁&nbsp;은&nbsp;&nbsp;<b style="color: #ffc107">치&nbsp;킨</b>&nbsp;이&nbsp;닭&nbsp;."</a></h1>
		   </div>
	   </div>
	    <hr style="border: 0.5px solid #D8D8D8;"> 
   	</c:when>
   	<c:when test="${searchBar=='freeboard' }">
   		<div style="background-image: url('<%=cp%>/resource/img/banner/freeboardbanner.jpg'); width:100%; height:345px;">
		   <div id="logo" class="container">
		      <h1 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 50px; padding: 100px 0px 0px 0px;"><a href="#" style="color: white; font-size: 50px;"> "&nbsp;&nbsp;<b style="color: #ffc107">피&nbsp;자</b>&nbsp;도&nbsp;&nbsp;우&nbsp;리&nbsp;&nbsp;민&nbsp;족&nbsp;이&nbsp;였&nbsp;어&nbsp;."</a></h1>
		   </div>
	   </div>
	    <hr style="border: 0.5px solid #D8D8D8;"> 
   	</c:when>
   	<c:when test="${searchBar=='mypage' }">
   		<div style="background-image: url('<%=cp%>/resource/img/banner/mypagebanner.jpg'); width:100%; height:345px;">
		   <div id="logo" class="container">
		      <h1 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 50px; padding: 100px 0px 0px 0px;"><a href="#" style="color: white; font-size: 50px;"> "&nbsp;다&nbsp;이&nbsp;어&nbsp;트&nbsp;는&nbsp;&nbsp;내&nbsp;일&nbsp;부&nbsp;터&nbsp;.&nbsp;"</a></h1>
		   </div>
	   </div>
	    <hr style="border: 0.5px solid #D8D8D8;"> 
   	</c:when>
   	<c:when test="${searchBar=='event' }">
   		<div style="background-image: url('<%=cp%>/resource/img/banner/eventbanner.jpg'); width:100%; height:345px;">
		   <div id="logo" class="container">
		      <h1 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 50px; padding: 100px 0px 0px 0px;"><a href="#" style="color: white; font-size: 50px;"> "&nbsp;&nbsp;원&nbsp;하&nbsp;는&nbsp;&nbsp;모&nbsp;든&nbsp;&nbsp;음&nbsp;식&nbsp;은&nbsp;&nbsp;<b style="color: #ffc107">배&nbsp;달&nbsp;링</b>&nbsp;에&nbsp;서&nbsp;."</a></h1>
		   </div>
	   </div>
	    <hr style="border: 0.5px solid #D8D8D8;"> 
   	</c:when>
   	<c:when test="${searchBar=='faq' }">
   		<div style="background-image: url('<%=cp%>/resource/img/banner/faqbanner.jpg'); width:100%; height:345px;">
		   <div id="logo" class="container">
		      <h1 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 50px; padding: 100px 0px 0px 0px;"><a href="#" style="color: white; font-size: 50px;"> "&nbsp;&nbsp;집&nbsp;에&nbsp;서&nbsp;&nbsp;<b style="color: #ffc107">맛&nbsp;집</b>&nbsp;&nbsp;여&nbsp;행&nbsp;중&nbsp;.&nbsp;"</a></h1>
		   </div>
	   </div>
	    <hr style="border: 0.5px solid #D8D8D8;"> 
   	</c:when>
   	<c:when test="${searchBar=='notice' }">
   		<div style="background-image: url('<%=cp%>/resource/img/banner/noticebanner.jpg'); width:100%; height:345px;">
		   <div id="logo" class="container">
		      <h1 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 50px; padding: 100px 0px 0px 0px;"><a href="#" style="color: white; font-size: 50px;"> "&nbsp;&nbsp;저&nbsp;기&nbsp;압&nbsp;일&nbsp;땐&nbsp;&nbsp;<b style="color: #ffc107">고&nbsp;기</b>&nbsp;앞&nbsp;으&nbsp;로&nbsp;"</a></h1>
		   </div>
	   </div>
	    <hr style="border: 0.5px solid #D8D8D8;"> 
   	</c:when>
   	<c:when test="${searchBar=='inquireBoard' }">
   		<div style="background-image: url('<%=cp%>/resource/img/banner/inquirebanner.jpg'); width:100%; height:345px;">
		   <div id="logo" class="container">
		      <h1 style="font-family: '배달의민족 한나체 Pro', '배달의민족한나체Pro', 'bm-hanna-pro'; font-size: 50px; padding: 100px 0px 0px 0px; background-position-y: -90px;"><a href="#" style="color: white; font-size: 50px;"> "&nbsp;&nbsp;<b style="color: #ffc107">햄&nbsp;버&nbsp;거</b>&nbsp;도&nbsp;&nbsp;배&nbsp;달&nbsp;링&nbsp;에&nbsp;서&nbsp;."</a></h1>
		   </div>
	   </div>
	    <hr style="border: 0.5px solid #D8D8D8;"> 
   	</c:when>
   	<c:when test="${searchBar=='page'}">
   		<c:if test="${not empty dto.bannerimg}">
   		<div style="background-image: url('<%=cp%>/resource/dashboard/${dto.bannerimg}'); width:100%; height:345px;">
		   <div id="logo" class="container">
		   </div>
	   </div>
	    <hr style="border: 0.5px solid #D8D8D8;"> 
	    </c:if>
	    <c:if test="${empty dto.bannerimg}">
	    </c:if>
   	</c:when>
   	<c:otherwise>
   	</c:otherwise>
   </c:choose>

   
  

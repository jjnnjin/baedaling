<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="https://unpkg.com/@kfonts/bm-hanna-pro/index.css" />

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>

<script type="text/javascript">
$(function() {
	var url ="<%=cp%>/dashboard/pie3d?restaurantsNum=${restaurantsNum}";
	$.getJSON(url, function(data) {
		console.log(data);
		
		Highcharts.chart('pie3dContainer', {
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45
		        }
		    },
		    title: {
		        text: ''
		    },
		    plotOptions: {
		        pie: {
		            innerSize: 100,
		            depth: 45,
		            colors: [
			            '#38BCC6', 
			            '#0588A9',
			            '#89D4E8',
			            '#F2F2F2',
			            '#D0ECF3',
			            '#0CA7D7'
			        ],
		        }
		    
		    },
		    series: data
		});
	});
});

$(function() {
	var url ="<%=cp%>/dashboard/barChart?restaurantsNum=${restaurantsNum}";
	$.getJSON(url, function(data) {
		console.log(data);
		// Create the chart
		Highcharts.chart('barContainer', {
		    chart: {
		        type: 'column'
		    },
		    title: {
		        text: '2020년 월별 판매현황'
		    },
		    accessibility: {
		        announceNewData: {
		            enabled: true
		        }
		    },
		    xAxis: {
		        type: 'category'
		    },
		    yAxis: {
		        title: {
		            text: '총 판매금액'
		        }

		    },
		    legend: {
		        enabled: false
		    },
		    plotOptions: {
		        series: {
		            borderWidth: 0,
		            dataLabels: {
		                enabled: true
		            },
		            colors: [
			            '#38BCC6', 
			            '#0588A9',
			            '#89D4E8',
			            '#FAF0DA',
			            '#F2F2F2',
			            '#D0ECF3',
			            '#0CA7D7',
			            '#FAC44E'  
			        ]
		        }
		    },

		    series: data
		});

	});
});
</script>

<div style="width: 25px; background-color: #F6F5F5">&nbsp;</div>
<div id="dashboard_box">
<table id="dash_table">
	<tr id="dash_title">
		<td colspan="3" style="padding-left : 20px;">
			오늘매출 <span style="color: #38BCC6;">${today.todaySales} </span>원  <span style="font-size: 18px;">- 전체 판매 리스트</span>
		</td>
		<td style="font-size: 20px;">
			  ${dataCount}개 (${pageNo}/${total_page} 페이지)
		</td>
	</tr>
	<tr style="width: 800px; text-align: center;">
		<td width="100px;" id="waiting_text">no</td>
		<td width="200px;" id="waiting_text">메뉴</td>
		<td width="200px;" id="waiting_text">가격</td>
		<td width="200px;" id="waiting_text">완료시간</td>
	</tr>
	
	<c:forEach var="vo" items="${list}">	
	<tr style="width: 800px; text-align: center;">
		<td width="100px;" >${vo.foodorderNum}</td>
		<td width="200px;" >${vo.menuNum}-${vo.menuName}</td>
		<td width="200px;" >${vo.foodOrderTotalPrice}</td>
		<td width="200px;" >${vo.foodOrderCompletionDate}</td>
	</tr>
	</c:forEach>
	<tr style=" border: 1px solid #E6E5E5; text-align: center; width: 800px; height: 45px;">
			<td style="width:200px; font-family:'배달의민족 한나체 Pro', '배달의민족한나체Pro'; color: gray;">${dataCount==0 ? "판매내역이 없습니다.":paging}</td>
		</tr>
</table>
</div>


<div id="dashboard_box">
<table id="dash_table2">
	<tr id="dash_title">
		<td colspan="3" style="padding-left : 20px;">
			월매출  <span style="color: #38BCC6;">${month.monthSales} </span>원
		</td>
	</tr>
	<tr style="width: 800px; text-align: center;">
		<td width="200px;" id="waiting_text">이달의 베스트메뉴</td>
	</tr>
	
	<tr style="width: 800px; text-align: center;">
		<td width="100%">
			<div id="pie3dContainer"></div>
		</td>
	</tr>

</table>
</div>

<div id="dashboard_box">
<table id="dash_table2">
	<tr id="dash_title">
		<td style="padding-left : 20px;">
			연매출  <span style="color: #38BCC6;">${annual.annualSales}</span>원
		</td>
	</tr>
	<tr style="width: 800px; text-align: center;">
		<td width="100%">
			<div id="barContainer"></div>
		</td>
	</tr>
</table>
</div>
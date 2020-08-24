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
	var url ="<%=cp%>/dashboard/pie3d2?restaurantsNum=${restaurantsNum}";
	$.getJSON(url, function(data) {
		console.log(data);
		
		Highcharts.chart('pie3d2Container', {
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
			            '#B074D0', 
			            '#9445BF',
			            '#CB82F3',
			            '#E3CBF1',
			            '#CBC7CE',
			            '#F9F4FB'
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
		    	text: ''
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


<%-- $(function() {
	var url ="<%=cp%>/dashboard/lineChart?restaurantsNum=${restaurantsNum}";
	$.getJSON(url, function(data) {
		console.log(data);
		// Create the chart
		Highcharts.chart('lineContainer', {

		    title: {
		        text: ''
		    },

		    xAxis: {
		        tickInterval: 1,
		        type: 'logarithmic',
		        accessibility: {
		            rangeDescription: 'Range: 1 to 10'
		        }
		    },

		    yAxis: {
		        type: 'logarithmic',
		        minorTickInterval: 0.1,
		        accessibility: {
		            rangeDescription: 'Range: 0.1 to 1000'
		        }
		    },

		    tooltip: {
		        headerFormat: '<b>{series.name}</b><br />',
		        pointFormat: 'x = {point.x}, y = {point.y}'
		    },

		    series: 
		        data  ,
		        pointStart: 1
		    
});
		
	});
});
 --%>

$(function() {
		var url ="<%=cp%>/dashboard/lineChart?restaurantsNum=${restaurantsNum}";
		$.getJSON(url, function(data) {
			console.log(data);
 		Highcharts.chart('lineContainer', {

	    title: {
	        text: ''
	    },
	  
	    yAxis: {
	        title: {
	            text: '리뷰개수'
	        }
	    },

	    xAxis: {
	
	    },

	    legend: {
	        layout: 'vertical',
	        align: 'right',
	        verticalAlign: 'middle'
	    },

	    plotOptions: {
	        series: {
	            label: {
	                connectorAllowed: false
	            },
	            pointStart: 1
	        }
	    },

	    series: data,

	    responsive: {
	        rules: [{
	            condition: {
	                maxWidth: 500
	            },
	            chartOptions: {
	                legend: {
	                    layout: 'horizontal',
	                    align: 'center',
	                    verticalAlign: 'bottom'
	                }
	            }
	        }]
	    }

	});
		});
});

</script>

<div style="width: 25px; background-color: #F6F5F5">&nbsp;</div>
<div id="dashboard_box">
<table id="dash_table3">
	<tr>
		<td style="font-size: 20px; height: 20px; font-family: '배달의민족 한나체 Pro','bm-hanna-pro';"><span style="color: #38BCC6; "><i class="fas fa-utensils"></i>  </span>대기 중인 주문</td>
		<td style="font-size: 20px; height: 20px;font-family: '배달의민족 한나체 Pro','bm-hanna-pro';"><span style="color: #38BCC6; "><i class="fas fa-utensils"></i>  </span>오늘 주문건</td>
		<td style="font-size: 20px; height: 20px;font-family: '배달의민족 한나체 Pro','bm-hanna-pro';"><span style="color: #38BCC6; "><i class="fas fa-coins"></i>  </span>오늘 매출</td>
		<td style="font-size: 20px; height: 20px; font-family: '배달의민족 한나체 Pro','bm-hanna-pro';"><span style="color: #38BCC6; "><i class="fas fa-coins"></i>  </span>이달 매출</td>
	</tr>
	
	<tr>
		<td style="font-size: 35px; height: 20px; padding-left:50px; font-family: '배달의민족 한나체 Pro',  'bm-hanna-pro';"><a style="color: red;" href="<%=cp%>/dashboard/orderlist?restaurantsNum=${sessionScope.user.restaurantsNum}">${waitngCount =='0'? 0 : waitngCount}</a></td>
		<td style="font-size: 35px; height: 20px; padding-left:50px; font-family: '배달의민족 한나체 Pro', 'bm-hanna-pro';"><a style="color: black;" href="<%=cp%>/dashboard/orderlist?restaurantsNum=${sessionScope.user.restaurantsNum}">${orderCount =='0'? 0 : orderCount}</a></td>
		<td style="font-size: 30px; height: 20px;padding-left:15px; font-family: '배달의민족 한나체 Pro', 'bm-hanna-pro';"><a style="color: black;" href="<%=cp%>/dashboard/salesList?restaurantsNum=${sessionScope.user.restaurantsNum}">${today.todaySales}</a></td>
		<td style="font-size: 30px; height: 20px;padding-left:15px; font-family: '배달의민족 한나체 Pro', 'bm-hanna-pro';"><a style="color: black;" href="<%=cp%>/dashboard/salesList?restaurantsNum=${sessionScope.user.restaurantsNum}">${month.monthSales}</a></td>
	</tr>
	
</table>
</div>

<div style="width: 100%; background-color: white;">
<div id="dashboard_box">
<div style="background-color: white; height: 10px;">&nbsp;</div>
<table id="dash_table4" >
	<tr style="padding-top: 20px;">
		<td width="350px" height="35px;" style="padding-top:30px; font-size: 20px; font-family: '배달의민족 한나체 Pro', 'bm-hanna-pro'; "><span style="color: #38BCC6;"><i class="fas fa-info"></i></span>  내 가게 정보<a style="color: #CCCACA; font-size: 15px; " href="<%=cp%>/dashboard/fcinfo_read?restaurantsNum=${sessionScope.user.restaurantsNum}"><span style="color:#38BCC6;">  <i class="fas fa-chevron-circle-right"></i>  </span>수정</a></td>
		<td style="font-size: 20px;"><span style="color: #F4D005;"><i class="fas fa-trophy"></i>  </span>Today's Best</td>
		<td style="font-size: 20px;"><span style="color: #F4D005;"><i class="fas fa-trophy"></i>  </span>Monthly Best</td>
	</tr>
	
	<tr style="width: 800px; ">
		<td style="color: gray; height: 20px;font-size: 18px;"><span style="color: #38BCC6;"><i class="fas fa-utensil-spoon"></i></span> 상호명 : ${dto.mutualName}</td>
		<td width="450px" rowspan="5" style="padding-top:30px; text-align: center;">
			<div id="pie3d2Container"></div>
		</td>
		<td width="450px" rowspan="5" style="padding-top:30px; text-align: center;">
			<div id="pie3dContainer"></div>
		</td>
	</tr>
	
	<tr>
		<td style="color: gray; height: 20px;font-size: 18px;"><span style="color: #38BCC6;"><i class="fas fa-utensil-spoon"></i></span> 가게 번호: ${dto.fctel}</td>
	</tr>
	
	<tr>
		<td style="color: gray; height: 20px; font-size: 18px;"><span style="color: #38BCC6;"><i class="fas fa-utensil-spoon"></i></span> 영업시간 :  ${dto.openingHour} - ${dto.endingHour}</td>
	</tr>
	
	<tr>
		<td style="color: gray; height: 20px; font-size: 18px;"><span style="color: #38BCC6;"><i class="fas fa-utensil-spoon"></i></span> 사업자번호 : ${dto.licenseNumber}</td>
	</tr>
</table>


</div>

<div id="dashboard_box">
<div style="background-color: white; height: 60px;">&nbsp;</div>
<table id="dash_table4" style="margin-top: 30px;">	
	<tr>
		<td style="font-size: 20px;"><span style="color: #38BCC6;"><i class="fas fa-hand-holding-usd"></i>  </span>Monthly sales</td>
		<td style="font-size: 20px;"><span style="color: #38BCC6;"><i class="far fa-comment-dots"></i>  </span>Monthly review Count</td>
	</tr>

	<tr>
		<td width=450px;>
			<div id="barContainer"></div>
		</td>
		<td width=450px;>
			<div id="lineContainer"></div>
		</td>
	</tr>
</table>
</div>
</div>
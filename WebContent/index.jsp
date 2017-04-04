<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<script type="text/javascript">
	window.onload = function() {
		var path="<%=request.getContextPath()%>";
		_ajaxCallJson(''+path+'/getFindLocation.action',"Gurgaon");
		
		var chart = new CanvasJS.Chart("chartContainer", {
			title: {
				text: "Line Chart"
			},
			axisX: {
				interval: 5
			},
			data: [{
				type: "line",
				dataPoints: [
				  { x: 10, y: 10},
				  { x: 20, y: 14 },
				  { x: 30, y: 20 },
				  { x: 40, y: 60 },
				  { x: 50, y: 50 },
				  { x: 60, y: 80 },
				  { x: 70, y: 40 },
				  { x: 80, y: 60 },
				]
			}]
		});
		chart.render();
	}
	
	
	

	function _ajaxCallJson(actionName, param) {
		var _resp;
		$.ajax( {
			type : "POST",
			url : actionName,
			data : param,
			datatype: "application/json",
			async : false,
			
			success : function(result, arguments, text) {
			    //var responseStatus=xhr.status;
				if (arguments == 'success') {
					var data = text.responseText;
					try{
						_resp = JSON.parse(data);
					}catch (e) {
						alert(" parsing FAIL");
						// TODO: handle excepti
					}				
				} else {
					_resp = 'error';
				}
			},
		    error: function(xhr, status, text) {
		    	var responseStatus=xhr.status;
		    	//alert(responseStatus);
		    	if(responseStatus == 440){
		    		alert("error ");
		    		//window.open(projectName+"/com/skilrock/lms/web/loginMgmt/loggedOut.jsp", target="_top");
		    	}
		    	else if (responseStatus == 403) {
					alert("Request cannot be fulfilled ");
				}else if(responseStatus == 0){
					_resp = "NETERROR";
					return _resp;
				}
		    	
		    	//window.open(projectName+"/com/skilrock/lms/web/loginMgmt/loggedOut.jsp", target="_top");
		        //var response = $.parseJSON(xhr.responseText);

		        console.log('Failure!');

		        //if (response) {
		          //  console.log(response.error);
		       // } else {
		            // This would mean an invalid response from the server - maybe the site went down or whatever...
		        //}
		        _resp = false;
		    }
		});
		return _resp;
	}

	
	</script>

	<title>CanvasJS Example</title>
</head>

<body>
	<div id="chartContainer" style="height: 400px; width: 100%;"></div>
</body>
	<script src="<%=request.getContextPath()%>/js/canvasjs.min.js"></script>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Haze Project</title>

<link href="../css/test.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: black; text-decoration: none;}
</style>
<script type="text/javascript">
var req1 = "REQUESTER1";
var req2 = "REQUESTER2";
var mes = "MES";

setInterval(function() {
$(document).ready(function() {
    jQuery.ajax({
        type:"POST",
        //url:"http://6791a0e7.ngrok.io/get_account?callback=loadlist",
        url:"http://127.0.0.1:5000/get_account?callback=loadlist",
        dataType:"JSON",
        data : "account=" + req1,
        success : function(data) {
          $.each(data, function(key, value) { 
  		 		if (key == "balance_amount") {
  					$('#r1').html(value);
  				}
  		  });
        },
        error : function(xhr, status, error) {
        	$('#r1').html('Error');
        }
    });
    jQuery.ajax({
        type:"POST",
        //url:"http://6791a0e7.ngrok.io/get_account?callback=loadlist",
        url:"http://127.0.0.1:5000/get_account?callback=loadlist",
        dataType:"JSON",
        data : "account=" + req2,
        success : function(data) {
      	  $.each(data, function(key, value) { 
				if (key == "balance_amount") {
					$('#r2').html(value);
				}
			});
        },
        error : function(xhr, status, error) {
        	$('#r2').html('Error');
        }
  	});
    jQuery.ajax({
        type:"POST",
        //url:"http://6791a0e7.ngrok.io/get_account?callback=loadlist",
        url:"http://127.0.0.1:5000/get_account?callback=loadlist",
        dataType:"JSON",
        data : "account=" + mes,
        success : function(data) {
      	  $.each(data, function(key, value) { 
				if (key == "balance_amount") {
					$('#mes').html(value);
				}
			});
        },
        error : function(xhr, status, error) {
        	$('#mes').html('Error');
        }
  	});
    jQuery.ajax({
        type:"POST",
        //url:"http://6791a0e7.ngrok.io/send_block_info?callback=loadlist",
        url:"http://127.0.0.1:5000/send_block_info?callback=loadlist",
        dataType:"JSON",
        success : function(data) {
        var pool = "";
        var block = "";
	var a = 0;
	var b = 0;
	var poolts = "";
	var poolhash = "";
	var poolage = "";
	var poolname = "";
	var poolreq = "";
	var blockts = "";
	var blockbhash = "";
	var blockhash = "";
	var blockage = "";
	var blockname = "";
	var blockreq = "";
	debugger;
        $.each(data, function(key, value) { 
		if (key == "pool_list") {
			$.each(value,function(s,t){
			$.each(t,function(k,v){
				if (k == "time_stamp") {
					poolts = v;
				}
				if (k == "data") {
					$.each(v,function(x,y){
						if (x == "hash"){
							poolhash = y;
						}
						if (x == "solution"){
							$.each(y,function(w,z){
								if (w == "name"){
									poolname = z;
								}
								if (w == "age"){
									poolage = z;
								}
							});
						}
					});
				}
				if (k == "Requester") {
					poolreq = v;
				}
			});
			pool = pool + "time_stamp : " + poolts + "\ndata : {\n\thash : " + poolhash + "\n\tsolution : {\n\t\tname : " + poolname + "\n\t\tage : " + poolage + "\n\t}\n}\nRequester : " + poolreq + "\n\n";
			});
		}
		if (key == "in_block") {
			$.each(value,function(s,t){
			$.each(t,function(k,v){
				if (k == "time_stamp") {
					blockts = v;
				}
				if (k == "Block_hash") {
					blockbhash = v;
				}
				if (k == "data") {
					$.each(v,function(x,y){
						if (x == "hash"){
							blockhash = y;
						}
						if (x == "solution"){
							$.each(y,function(w,z){
								if (w == "name"){
									blockname = z;
								}
								if (w == "age"){
									blockage = z;
								}
							});
						}
					});
				}
				if (k == "Requester") {
					blockreq = v;
				}
			});
			block = block + "time_stamp : " + blockts + "\nblock_hash : " + blockbhash + "\ndata : {\n\thash : " + blockhash + "\n\tsolution : {\n\t\tname : " + blockname + "\n\t\tage : " + blockage + "\n\t}\n}\nRequester : " + blockreq + "\n\n";
			});
		}
	});
        	$('#block').html(block);
        	$('#pool').html(pool);
        },
        error : function(xhr, status, error) {
        	$('#pool').html('Connect Error');
        	$('#block').html('Connect Error');
        }
  	});
    jQuery.ajax({
        type:"POST",
        //url:"http://6791a0e7.ngrok.io/send_frame?callback=loadlist",
        url:"http://127.0.0.1:5000/send_frame?callback=loadlist",
        dataType:"JSON",
        success : function(data) {
          $.each(data, function(key, value) { 
				if (key == "image_packet1") {
					if(value == null || value == "" || value == "none"){
						$('#image1').attr('src', "../files/basicimg.jpg");
					} else{
						$('#image1').attr('src', value);
					}
				}
				if (key == "detected_image1") {
					if(value == null || value == "" || value == "none"){
						$('#result1').attr('src', "../files/basicimg.jpg");
					} else{
						$('#result1').attr('src', value);
					}
				}
				if (key == "sol1") {
					if(value == null || value == "" || value == "none"){
						$('#sol1').html('<p>Not Matched</p>');
					}else{
						$('#sol1').html('<p style="color:#FD6A02">'+value.name+'</p>');
					}
				}
				if (key == "image_packet2") {
					if(value == null || value == "" || value == "none"){
						$('#image2').attr('src', "../files/basicimg.jpg");
					} else{
						$('#image2').attr('src', value);
					}
					
				}
				if (key == "detected_image2") {
					if(value == null || value == "" || value == "none"){
						$('#result2').attr('src', "../files/basicimg.jpg");
					} else{
						$('#result2').attr('src', value);
					}
				}
				if (key == "sol2") {
					if(value == null || value == "" || value == "none"){
						$('#sol2').html('<p>Not Matched</p>');
					}else{
						$('#sol2').html('<p style="color:#FD6A02">'+value.name+'</p>');
					}
				}
		  });
        },
        error : function(xhr, status, error) {
        	$('#sol1').html('<p>Not Matched</p>');
        	$('#sol2').html('<p>Not Matched</p>');
        	$('#image1').attr('src', "../files/basicimg.jpg");
        	$('#result1').attr('src', "../files/basicimg.jpg");
        	$('#image2').attr('src', "../files/basicimg.jpg");
        	$('#result2').attr('src', "../files/basicimg.jpg");
        }
  	});
});
}, 5000);

</script>
</head>
<body>
<div id="allWrap">
<div id="wrap">
<header>
	<div id="hwrap">
		<h1 id="logo">
			<a href="#" style="font-weight: bold; font-family: arial; font-style: oblique;">Haze Project</a>
		</h1>
	<div id="util">
		<ul>
			<a href="logout.jsp">Logout</a>
		</ul>
	</div>
	</div>
</header>
<div id="navibg"></div>
<div id="visual"></div>
<div id="container">
	<div id="ContentsArea">
		<div class="conStart">
			<div class="titleArea">
				<div class="titleCon" style="font-weight: bold; font-family: arial; color:#000;">Edge Surveillance Demonstration</div><!-- //titleCon -->
			</div><!-- //titleArea -->
			<div class="conWrap">
				<div class="board_wrap">
					<div class="table_type02_wrap">
						<table class="type02" style="background:#fdfdfd">
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 25%;">
								<col style="width: 25%;">
								<col style="width: 40%;">
							</colgroup>
							<thead>
								<tr>
									<th></th>
									<th style="font-weight: bold; font-family: arial; font-style: oblique;  font-size: 25px; color:#000">Surveillance Image</br>@Local Camera</th>
									<th style="font-weight: bold; font-family: arial; font-style: oblique;  font-size: 25px; color:#000">Processend Image</br>@Edge Server</th>
									<th style="font-weight: bold; font-family: arial; font-style: oblique;  font-size: 25px; color:#000">Blockchain Data</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td rowspan="2" style="font-weight: bold; font-family: arial; font-style: oblique;  font-size: 25px; color:#000">Requester</br>1</td>
									<td><p class="gall_img_area"><img id="image1" style="width:350px; height:290px;" src="" /></p></td>
									<td><div class="float_center"><p class="gall_img_area"><img id="result1" style="width:350px; height:290px;" src="" /></p></div></td>
									<td rowspan="3">
										<p style="font-weight: bold; font-family: arial; font-style: oblique; font-size: 18px; color:#000">Contract</p>
										<textarea class="pooltext" readonly id="block" name="block" style="font-weight: bold; font-family: arial; font-size: 23px; color:#000">Contract</textarea>
										<p style="font-weight: bold; font-family: arial; font-style: oblique; font-size: 18px; color:#000">Pool</p>
										<textarea class="blocktext" readonly id="pool" name="pool" style="font-weight: bold; font-family: arial; font-size: 23px; color:#000">Pool</textarea>
									</td>
								</tr>
								<tr>
									<td style="font-weight: bold; font-family: arial; font-size: 20px; color:#000">$ <span id="r1" name="r1"></span> HAZE</td>
									<td style="font-weight: bold; font-family: arial; font-size: 20px; color:#000"><span id="sol1" name="sol1"></span></td>
								</tr>
								<tr>
									<td rowspan="2" style="font-weight: bold; font-family: arial; font-style: oblique;  font-size: 25px; color:#000">Requester</br>2</td>
									<td><p class="gall_img_area"><img id="image2" style="width:350px; height:290px;" src="" /></p></td>
									<td><p class="gall_img_area"><img id="result2" style="width:350px; height:290px;" src="" /></p></td>
								</tr>
								<tr>
									<td style="font-weight: bold; font-family: arial; font-size: 20px; color:#000">$ <span id="r2" name="r2"></span> HAZE</td>
									<td style="font-weight: bold; font-family: arial; font-size: 20px; color:#000"><span id="sol2" name="sol2"></span></td>
									<td style="font-weight: bold; font-family: arial; font-size: 20px; color:#000">$ <span id="mes" name="mes"></span> HAZE</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
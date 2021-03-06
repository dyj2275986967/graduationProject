<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="z" uri="/huas/system"%>
<c:set value="${pageContext.request.contextPath}" var="ctx"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>个人信息管理</title>

<!--springboot改图标-->
<link href="${ctx }/res/img/favicon.ico" type="image/x-icon" rel="icon">

<!-- Bootstrap -->
<link href="${ctx }/res/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="${ctx }/res/bootstrap/js/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="${ctx }/res/bootstrap/js/bootstrap.min.js"></script>

<!-- 引入自定义的css -->
<link href="${ctx }/res/css/myCss.css" rel="stylesheet">

<!-- 引入头像裁剪框所需的css -->
<link href="${ctx }/res/txjsandcss/head/cropper.min.css"
	rel="stylesheet">
<link href="${ctx }/res/txjsandcss/head/sitelogo.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${ctx }/res/txjsandcss/css/font-awesome.min.css">
<!-- 引入头像裁剪框所需的js -->
<script src="${ctx }/res/txjsandcss/head/cropper.js"></script>
<script src="${ctx }/res/js/html2canvas.min.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctx }/res/txjsandcss/head/sitelogo.js"></script>
<script>
$(function() {
	
	$.ajax({
		//指定请求地址的url
		url : "${ctx}/user/manager/depMsg",
		//指定
		type : "post",

		//预期服务器返回的数据类型
		dateType : "json",
		//服务器响应成功时候的回调函数
		success : function(result) {

			//为Select追加一个Option(下拉项) 

			var dataArray = JSON.parse(result);
			console.log(dataArray);
			
			//显示所有的院系信息   
			for (var i = 0; i < dataArray.msg.length; i++) {
				//添加模态框
				$("#search_condition_dep").append(
						"<option value='"+dataArray.msg[i].depId+"'>"
								+ dataArray.msg[i].depName + "</option>");
				
			
		
				
				$("#search_condition_dep").val(${session_user.dep});
				
			

			}
		
			
		

		},
		error : function(xhr, textStatus, err) {//服务器响应失败时候的回调函数
			console.log(xhr);
			alert(xhr);
			alert(textStatus);
			alert(err)

		}

	})
	
	//
	 $("#sure").click(function (){
		 if($("#loginName").prop("disabled")){
			 alert("请先点击修改个人信息");
			 
			 
		 }else{
			 
			 
			var id=	${session_user.userId};
			var sex=null;
			
			if($("#nan").prop("checked")){
				sex="男";
			}else{
				sex="女";
				
			}
			var loginName=$("#loginName").val();
			var signature=$("#signature").val();
			var  dep=$("#search_condition_dep").val();
			
			$.ajax({
				//指定请求地址的url
				url : "${ctx}/user/manager/update",
				//指定
				type : "post",
                data:"userId="+id+"&sex="+sex+"&name="+loginName+"&signature="+signature+"&dep="+dep,
				//预期服务器返回的数据类型
				dateType : "json",
				//服务器响应成功时候的回调函数
				success : function(result) {

				
					window.location.href="/user/manager/index";
				

				},
				error : function(xhr, textStatus, err) {//服务器响应失败时候的回调函数
					console.log(xhr);
					alert(xhr);
					alert(textStatus);
					alert(err)

				}

			})
			

		 }
		 
 
	 })
	

	 $("#excel_file").change(function(){
		 
			$("#QueryForm").submit();
	 })
	 
	 
	 $("#createTx").click(function(){
		 
		 $("#excel_file").trigger("click");
		 
		 
		// 打开模态框excel_file
		//	$('#avatar-modal').modal(
			//		'show')
		
		 
	 })



	
	//关闭禁用
	$("#msgSpan").click(function (){
		
		$("#loginName").attr("disabled",false);
		$("#nan").attr("disabled",false);
		$("#nv").attr("disabled",false);
		$("#signature").attr("disabled",false);
		$("#search_condition_dep").attr("disabled",false);
		
	})
	
		//打开禁用
	$("#cancel").click(function (){
		
		$("#loginName").attr("disabled",true);
		$("#nan").attr("disabled",true);
		$("#nv").attr("disabled",true);
		$("#signature").attr("disabled",true);
		$("#search_condition_dep").attr("disabled",true);
		
	})
	//用户绑定操作开始	
	$("#phoneSpanBtn").click(function(){
 
		
   window.location.href="/user/manager/bind";		
		
		
	})
	
	$("#emailSpanBtn").click(function(){
 
		
   window.location.href="/user/manager/bind";		
		
		
	})
	
	
	
})


</script>


</head>
<body>

	<!-- 1，页眉部分 -->
	<header class="container-fluid">

		<!-- 第一行 -->
		<div class="row">


			<!-- 导航栏 -->
			<div class="row">
				<nav class="navbar  navbar-fixed-top navbar-inverse"
					role="navigation">
					<div class="container">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed"
								data-toggle="collapse" data-target="#navbar"
								aria-expanded="false" aria-controls="navbar">
								<span class="sr-only">显示导航条</span> <span class="icon-bar"></span>
								<span class="icon-bar"></span> <span class="icon-bar"></span>
							</button>
							<a class="navbar-brand" href="${ctx }/student/msg/list">学生综合素质管理系统</a>
						</div>
						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse"
							id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav">
								<li><a href="${ctx }/student/msg/list">信息管理</a></li>
								<li><a href="${ctx }/student/grade/list">成绩管理</a></li>
								<li><a href="${ctx }/student/AwardOrPunish/index">奖罚管理</a></li>
							</ul>
							<ul class="nav navbar-nav navbar-right">
								<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" role="button" aria-haspopup="true"
									aria-expanded="false"> <img
										src="/image/${session_user.img}" height="22"
										width="22" class="img-circle "><span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li><a href="${ctx }/user/manager/index">个人中心</a></li>
										<li role="separator" class="divider"></li>
										<li><a  href="${ctx }/user/manager/music" target="_Blank">放松一下</a></li>
										<li role="separator" class="divider"></li>
										<li><a href="${ctx }/user/loginOut">退出</a></li>
									</ul></li>
							</ul>
						</div>
						<!-- /.navbar-collapse -->
					</div>
					<!-- /.container-fluid -->

				</nav>


			</div>




		</div>


		</div>

	</header>
	<div class="container ">



		<!-- 1，页脚部分 -->

		<div class="row" style="margin-top: 85px;">

			<div class="col-md-2 col-md-offset-1 ">

				<div class="row">
					<div class="list-group">
						<a href="${ctx }/user/manager/index" class="list-group-item list-group-item-success ">个人资料</a>


            

                                 <c:choose>
									<c:when test="${session_user.level==2 }">
									<a href="#" class="list-group-item disabled">管理员</a>
									<!--	<a href="#" class="list-group-item disabled">学院管理</a> -->
								
									</c:when>
									<c:otherwise>
									<a href="${ctx }/user/admin/index" class="list-group-item ">管理员</a>
									<!--   <a href="${ctx }/user/admin/index/dep"  class="list-group-item ">学院管理</a> -->
    	                         
									</c:otherwise>
								</c:choose>        


					</div>

				</div>




			</div>

			<div class="row col-md-8 ">

				<div class="panel panel-default ">


					<!-- 1，面板开始 -->
					<div class="panel-body" style="margin-bottom: 100px;">
						<!--第一行个人资料-->
						<div class="row">
							<div class=" col-md-3">

								<span style="font-size: 25px;">个人资料</span>

							</div>
						</div>
						<!--第一行个人资料-->
						<!--第二行 线-->
						<div class="row">
							<div class=" col-md-12">
								<hr>
							</div>

						</div>
						<!--第二行 线-->
						<!--第三行头像-->
						<div class=" row">
							<div class=" col-md-2">
								<div class="row" style="margin-left: 7px">
									<img src="/image/${session_user.img}"
										height="80" width="80" class="img-circle ">
								</div>
								<div class="row " style="margin-left: 16px; margin-top: 8px;">
									<span id="createTx" style="cursor: pointer;color: #3399EA; font-size: 15px;">修改头像</span>
								</div>
							</div>
							<div class=" col-md-10">
								<!--第一行-->
								<div class="row">
									<div class="col-md-4">
										<span style="color: #999999; font-size: 14px">ID:&nbsp${session_user.loginName}</span>
									</div>




								</div>
								<div class="row" style="margin-top: 8px;">
									<div class="col-md-4">
									
										<c:choose>
											<c:when test="${not empty session_user.phone}">
												<span style="color: #999999; font-size: 14px">手机号:<font>${session_user.phone}</font></span>
											</c:when>
											<c:otherwise>
												<span style="color: #999999; font-size: 14px">手机号:<span id="phoneSpanBtn"
											style="cursor: pointer;color:#3399EA;font-size:13px;">绑定手机号</span></span>

											</c:otherwise>
										</c:choose>
								
									</div>
									<div class="col-md-4">
									
									<c:choose>
											<c:when test="${not empty session_user.email}">
												<span style="color: #999999; font-size: 14px">邮箱:<font>${session_user.email}</font></span>
											</c:when>
											<c:otherwise>

								 <span style="color: #999999; font-size: 14px">邮箱:<span id="emailSpanBtn"
											style="cursor: pointer;color:#3399EA;font-size:13px;">绑定邮箱</span></span>

											</c:otherwise>
									</c:choose>
								
									</div>
								</div>
								<div class="row">
									<div class="col-md-12" style="margin-top: 5px;">
										<span style="color: #999999; font-size: 14px">座右铭:&nbsp${session_user.signature}</span>
									</div>
								</div>
						
						
						
						
								<div class="row"
		                         style="margin-top:0px;">
	<div class="col-md-12" style="margin-top:30px;">
	<hr>
	</div>
	
	
	
	</div>
	
	
	</div>
		<!--第三行头像-->
	<!--个人信息页面开始-->
	<div class="row">
	<div class="row" align="right" style="margin-right:20px;" >
     <span id="msgSpan" style="cursor: pointer;color:#3399EA;font-size:13px;">修改个人信息</span>
	</div>
	
	
	
	 	<div class="col-md-8" style="margin-left:140px;">
	<form class="form-horizontal" method="post"
			action="/taobao/identity/login.action"role="form" >
			<div class="form-group">
			
		     	<div class="col-md-1">
					<span style="color:#999999;"> 姓&nbsp名:</span >
				</div>
				<div class="col-md-5" style="margin-left:10px;">
				<label id="name">
					<input class="form-control" value="${session_user.name}" 
						type="text" id="loginName" name="loginName" disabled />	
					</label>
				</div>
	
			</div>

	
		
			<div class="form-group">
				<div class="col-md-1">
					<span style="color:#999999;"> 性&nbsp别:</span >
				</div>
				<div class="col-md-5" style="margin-top:-7px;margin-left:30px;">			
       		
							   <c:choose>
									<c:when test="${session_user.sex=='男' }">
										   <input  type="radio" id="nan" name="unit" value="男" checked="checked"  style="margin-left:10px" disabled/><span style="margin-left:30px">男</span>
		                   <input type="radio" name="unit" id="nv" value="女"  style="margin-left:20px" disabled/> <span style="margin-left:30px;">女</span>

									</c:when>
									<c:otherwise>

									   <input type="radio"id="nan" name="unit" value="男"   style="margin-left:10px" disabled/><span style="margin-left:30px">男</span>
		          <input type="radio" name="unit" id="nv" value="女" checked="checked" style="margin-left:20px"  disabled/> <span style="margin-left:30px;">女</span>

									</c:otherwise>
								</c:choose>
       
		</div>
			</div>
			
			<div class="form-group">
				<div class="col-md-1">
					<span style="color:#999999;"> 学&nbsp院:</span >
				</div>
		     	<div class="col-md-5" style="margin-left:10px;">
				
				
			           <select class="form-control" name="universityDepId"
										id="search_condition_dep" disabled>

									

									</select>
                
				</div>
			</div>
			
				<div class="form-group">
			
		     	<div class="col-md-3"style="margin-left:-21px;">
					<span style="color:#999999;"> 座 &nbsp右&nbsp铭:</span >
				</div>
				<div class="col-md-5" style="margin-left:-55px;">
				<label id="name">
				
				   <textarea class="form-control" id="signature" name="signature"  rows="5" cols="60" disabled   >${session_user.signature}</textarea>
				

				</div>
	
			</div>
		
	      <div class="form-group">
				<div class="col-sm-8 " style="margin-top:50px; margin-left:35px">
				
						<div class="col-md-4" >
							<button type="button" id="cancel" class="btn btn-info">
								<span class="glyphicon glyphicon-remove"></span>&nbsp;取消
							</button>
						</div>
						<div class="col-md-2" >
							<button type="button" id="sure"class="btn btn btn-success">
								<span class="glyphicon glyphicon-ok"></span>确定
							</button>
						</div>
					
				</div>
			</div>
			
		</form>
	 
	 

	
	
	</div>
		
	</div>
		<!--个人信息页面结束-->
	
	
	
	</div>
	
	
	</div>
</div>

</div>
</div>

			
			
	<!--主体结束-->
  </div>		


<!--绑定操作模态框开始-->
  

			
<div class="modal fade" id="myModal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
					    <form class="form-horizontal" method="post"
			action="/taobao/identity/login.action"role="form" style="margin-left:100px;">
			
			
			<div class="form-group" style="margin-bottom:20px;margin-left:30px;">
				<div class="col-md-8">
					<span id="loginTip" style="font-size:20px;">绑定操作</span>
				</div>
	
			</div>

			
			
			<div class="form-group">
				<div class="col-md-8">
					<input class="form-control" value="" placeholder="手机号/邮箱"
						type="text" id="loginName" name="loginName" />
				</div>
	
			</div>
			<div class="form-group" style="margin-top:-20px;">
				<div class="col-md-8">
					<span id="loginTip" style="font-size:12px;color:#F66495;">*账号不存在呢！</span>
				</div>
	
			</div>




			<div class="form-group">
				<div class="col-md-8">
				<div class="input-group">
            <input type="text" class="form-control" placeholder="请输入验证码">
            <span class="input-group-btn">
                <button class="btn btn-default" type="button">发送</button>
             </span>
         </div><!-- /input-group -->
				</div>
			</div>
			
					<div class="form-group" style="margin-top:-20px;">
				<div class="col-md-8">
					<span id="passwordTip" style="font-size:12px;color:#F66495;">*您的密码呢？</span>
				</div>
	
			</div>
			
			<div class="form-group">
				<div class="col-md-8">
					<span style="color: red;"></span>
				</div>
			</div>

			<div class="form-group">
				<div class="col-md-8">
					<div class="btn-group btn-group-justified" role="group"
						aria-label="...">
						<div class="btn-group" role="group">
							<button type="button" id="loginBtn" class="btn btn-success"  data-toggle="modal" data-target="#myModal">
								<span class="glyphicon  glyphicon-remove"></span>&nbsp;取消
							</button>
						</div>
						<div class="btn-group" role="group">
							<button type="button" class="btn btn btn-info">
								<span class="glyphicon  glyphicon-ok"></span>确定
							</button>
						</div>
					</div>
				</div>
			</div>
		</form>
			

		</div>
	</div>
</div>


<!--绑定操作模态框结束-->




<!--头像模态框开始-->
		
<!--头像模态框开始-->
		
			
<div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
						<form id="QueryForm" action="${ctx}/user/manager/fileUpload"
						method="post" enctype="multipart/form-data">
						<div class="row">
							<div class="col-sm-3" style="width: 78%;">
								<div class="box box-primary">
									<div class="box-header with-border">

										<div class="box-body">
											<input id="excel_file" class="form-control" type="file"
												name="filename"  size="80" />
										</div>
									</div>



								</div>
							</div>

						</div>
					</form>
					
					
					
		</div>
	</div>
</div>
<!--头像模态框结束-->	





  </body>
</html>

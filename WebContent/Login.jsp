<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String login = request.getParameter("login");
//是否登录进来的判断
if(login != null && login.trim().equals("true")) {
	String userName = request.getParameter("username");
	//是否以管理员身份进行的登录
	if(userName != null && userName.trim().equals("admin")) {
		session.setAttribute("admin", "true");
	}
	response.sendRedirect("ShowTree.jsp");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8" />
		<title>login</title>		
		<!-- Bootstrap 核心 CSS 文件 -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<!--font-awesome 核心CSS 文件，该文件可以用于显示输入框里面一些小的icon-->
		<link href="css/font-awesome.min.css" rel="stylesheet">
		<!-- 在bootstrap.min.js 之前引入 -->
		<script src="js/jquery-3.2.1.min.js"></script>
		<!-- Bootstrap 核心 JavaScript 文件 -->
		<script src="js/bootstrap.min.js"></script>
		<!--jquery.validate-->
		<script type="text/javascript" src="js/jquery.validate.min.js" ></script>
		<!-- 添加自定义的表单验证，可以参考http://www.runoob.com/jquery/jquery-plugin-validate.html -->
		<script type="text/javascript" src="js/additional-methods.js" ></script>
		<!-- 表单验证的出错的默认消息 -->
		<script type="text/javascript" src="js/messages_zh.js" ></script>
		<!-- 表单验证，以及同一个页面登录注册之间的切换的实现 -->
		<script type="text/javascript" src="js/main.js" ></script>
		<style type="text/css">
			body{background: url(img/car.jpg) no-repeat;background-size: cover;font-size: 16px;}
			.form{background: rgba(255,255,255,0.2);width:400px;margin:100px auto;}
			#login_form{display: block;}
			#register_form{display: none;}
			.fa{display: inline-block;top: 27px;left: 6px;position: relative;color: #ccc;}
			input[type="text"],input[type="password"]{padding-left:26px;}
			.checkbox{padding-left:21px;}
			/* 表单验证不符合时，提示消息字体颜色 */
			.error{	color:red;}
		</style>		
	</head>
	<body>
		<!--
			基础知识：
			网格系统:通过行和列布局
			行必须放在container内
			手机用col-xs-*
			平板用col-sm-*
			笔记本或普通台式电脑用col-md-*
			大型设备台式电脑用col-lg-*
			为了兼容多个设备，可以用多个col-*-*来控制；
		-->
		<!--
			从案例学知识，来做一个登录，注册页面
			用到font-awesome 4.3.0；bootstrap 3.3.0；jQuery Validate
		-->
	<div class="container">
		<div class="form row">
			<form class="form-horizontal col-sm-offset-3 col-md-offset-3" id="login_form" action="Login.jsp" method="post">
				<input type="hidden" name="login" value="true"/>
				<h3 class="form-title">Login to your account</h3>
				<div class="col-sm-9 col-md-9">
					<div class="form-group">
						<i class="fa fa-user fa-lg"></i>
						<input class="form-control required" type="text" placeholder="Username" name="username" autofocus="autofocus" maxlength="20"/>
					</div>
					<div class="form-group">
							<i class="fa fa-lock fa-lg"></i>
							<input class="form-control required" type="password" placeholder="Password" name="password" maxlength="8"/>
					</div>
					<div class="form-group">
						<label class="checkbox">
							<input type="checkbox" name="remember" value="1"/> Remember me
						</label>
						<hr />
						<a href="javascript:;" id="register_btn" class="">Create an account</a>
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-success pull-right" value="Login "/>   
					</div>
				</div>
			</form>
		</div>

		<div class="form row">
			<form class="form-horizontal col-sm-offset-3 col-md-offset-3" id="register_form">
				<h3 class="form-title">Login to your account</h3>
				<div class="col-sm-9 col-md-9">
					<div class="form-group">
						<i class="fa fa-user fa-lg"></i>
						<input class="form-control required" type="text" placeholder="Username" name="username" autofocus="autofocus"/>
					</div>
					<div class="form-group">
							<i class="fa fa-lock fa-lg"></i>
							<input class="form-control required" type="password" placeholder="Password" id="register_password" name="password"/>
					</div>
					<div class="form-group">
							<i class="fa fa-check fa-lg"></i>
							<input class="form-control required" type="password" placeholder="Re-type Your Password" name="rpassword"/>
					</div>
					<div class="form-group">
							<i class="fa fa-envelope fa-lg"></i>
							<input class="form-control eamil" type="text" placeholder="Email" name="email"/>
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-success pull-right" value="Sign Up "/>
						<input type="submit" class="btn btn-info pull-left" id="back_btn" value="Back"/>
					</div>
				</div>
			</form>
		</div>
		</div>	
	</body>
</html>

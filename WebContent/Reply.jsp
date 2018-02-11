<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String isReply = request.getParameter("Rep");
if(isReply != null && isReply.equals("true")) {
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?" +
	        "user=root&password=root");
	
	//创建一个事务
	conn.setAutoCommit(false);
	
	//1.获取request的数据
	int pid, rootid, isleaf;
	String title, cont;
	try {
		pid = Integer.parseInt(request.getParameter("id"));
		rootid = Integer.parseInt(request.getParameter("rootid"));
		isleaf = Integer.parseInt(request.getParameter("isleaf"));
	} catch (NumberFormatException e) {
		out.println("请检查输入的数字格式！");
		return;
	}
	title = request.getParameter("title");
	if(title == null || title.trim().equals("")) {
		out.println("title 不能为空");
		return;
	}
	cont = request.getParameter("cont");
	if(cont == null || cont.trim().equals("")) {
		out.println("cont 不能为空");
		return;
	}
	//2.插入一行记录	
	PreparedStatement preStmt = conn.prepareStatement("insert into article values(null, ?, ?, ?, ?, now(), 0)");
	preStmt.setInt(1, pid);
	preStmt.setInt(2, rootid);
	preStmt.setString(3, title);
	preStmt.setString(4, cont);
	preStmt.execute();
	//3.修改一行记录(将被回复的话题的isleaf做修改)
	Statement stmt = null;
	if(isleaf == 0) {
		stmt = conn.createStatement();
		stmt.executeUpdate("update article set isleaf = 1 where id = " + pid);
	}
	//4.commit并复原场景,事务结束
	conn.commit();
	conn.setAutoCommit(true);
	response.sendRedirect("ShowTree.jsp");
	//关闭与数据库相关的连接及Statement
	if(stmt != null) stmt.close();
	if(preStmt != null) preStmt.close();
	if(conn != null) conn.close();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reply</title>
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
		body{background: url(img/4.jpg) no-repeat;background-size: cover;font-size: 16px;}
		.form{background: rgba(255,255,255,0.2);width:400px;margin:100px auto;}
		#reply_form{display: block;}			
		.fa{display: inline-block;top: 27px;left: 6px;position: relative;color: #ccc;}
		input[type="text"],input[type="password"]{padding-left:26px;}
		.checkbox{padding-left:21px;}
		/* 表单验证不符合时，提示消息字体颜色 */
		.error{	color:red;}
	</style>
</head>
<body>
	<div class="container">
	    <div class="row">
	      <div class="col-md-4 col-md-offset-4">
	        <h2>回复话题</h2>
	      </div>
	    </div>
			<form class="form-horizontal" id="reply_form" role="form" action="Reply.jsp" method="get">
				<input type="hidden" name="Rep" value="true"/>
				<input type="hidden" name="id" value="<%= request.getParameter("id") %>"/>
				<input type="hidden" name="rootid" value="<%= request.getParameter("rootid") %>"/>
				<input type="hidden" name="isleaf" value="<%= request.getParameter("isleaf") %>"/>
		      <fieldset>
		        <legend>Title</legend>
		        <div class="form-group">
		          <label class="col-sm-2 control-label" for="inputUsername">title</label>
		            <div class="col-sm-10">
		              <input class="form-control" id="inputUsername" type="text" name="title" placeholder="title"/>
		            </div>
		        </div>
		      </fieldset>
		      <fieldset>
		        <legend>Content</legend>
		        <div class="form-group">
		          <label class="col-sm-2 control-label" for="introduce">content</label>
		            <div class="col-sm-10">
		              <textarea class="form-control" rows="10" id="introduce" name="cont" placeholder="content"></textarea>              
		            </div>
		        </div>
		      </fieldset>
		      	      
		      <div class="row">
	      		<div class="col-md-4 col-md-offset-2">
	      			<button type="commit" class="btn btn-primary btn-xs">确定</button>	        		
	      		</div>
	      	  </div>
	    </form>
   </div>
</body>
</html>
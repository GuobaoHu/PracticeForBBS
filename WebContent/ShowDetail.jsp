<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%

int id = Integer.parseInt(request.getParameter("id"));

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?" +
        "user=root&password=root");
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select * from article where id = " + id);
rs.next();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Show Detail</title>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<!-- 这一行必须在下面一行前面 -->
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="container">
		<table class="table">
			<tr>
				<td>ID</td>
				<td> <%= rs.getInt("id") %> </td>
			</tr>
			<tr>
				<td>PID</td>
				<td><%= rs.getInt("pid") %></td>
			</tr>
			<tr>
				<td>TITLE</td>
				<td><%= rs.getString("title") %></td>
			</tr>
			<tr>
				<td>CONTENT</td>
				<td><%= rs.getString("cont") %></td>
			</tr>
			<tr>
				<td>ISLEAF</td>
				<td><%= rs.getInt("isleaf") %></td>
			</tr>
		</table>
	</div>
</body>
</html>
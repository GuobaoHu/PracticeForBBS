<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- 递归方法 -->
<%!
String output = "";
private void tree(Connection conn, int id, int level) {
	Statement stmt = null;
	ResultSet rs = null;
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from article where pid = " + id);
		String preStr = "";
		for(int i=0; i<level; i++) {
			preStr = preStr + "====";
		}
		while(rs.next()) {
			output = output + "<tr><td>" + rs.getInt("id") + 
					"</td><td>" + preStr +  "<a href='ShowDetail.jsp?id=" + 
					rs.getInt("id") + "'>" + rs.getString("title") + "</a>" + "</td></tr>";
			if(rs.getInt("isleaf") == 1) {
				tree(conn, rs.getInt("id"), level+1);
			}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(stmt != null) stmt.close();
			if(rs != null) rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
%>

<%
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?" +
        "user=root&password=root");
tree(conn, 0, 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bbs tree</title>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<!-- 这一行必须在下面一行前面 -->
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="container">
		<a href="New.jsp" class="btn btn-primary btn-xs" role="button">创建新话题</a>
		<table class="table">
			<%= output %>
		</table>
	</div>
</body>
<%
output = "";
if(conn != null) conn.close();
%>
</html>
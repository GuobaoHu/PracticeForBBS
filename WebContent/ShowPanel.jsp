<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%! public static final int AVERPAGECOUNT = 5; %>
<%
//1.获取当前pageNo
String pageNoStr = request.getParameter("pageNo");
int pageNo;
if(pageNoStr == null || pageNoStr.trim().equals("")) {
	pageNo = 1;
} else {
	try {
		pageNo = Integer.parseInt(pageNoStr);
	} catch (NumberFormatException e) {
		pageNo = 1;
	}
}

//2.连接数据库
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?" +
        "user=root&password=root");

//3.查询记录总数，确定总页码数
Statement stmt = conn.createStatement();
ResultSet totalRs = stmt.executeQuery("select count(*) from article where pid = 0");
totalRs.next();
int totalRecs = totalRs.getInt(1);
int totalPages = (totalRecs % AVERPAGECOUNT == 0) ? totalRecs/AVERPAGECOUNT : (totalRecs/AVERPAGECOUNT+1);
if(pageNo <= 0 ) {
	pageNo = 1;
} else if(pageNo > totalPages) {
	pageNo = totalPages;
}

//4.分页显示
PreparedStatement preStmt = conn.prepareStatement("select * from article where pid = 0 order by pdate desc limit ?,?");
preStmt.setInt(1, (pageNo-1) * AVERPAGECOUNT);
preStmt.setInt(2, AVERPAGECOUNT);
ResultSet rs = preStmt.executeQuery();


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Panel</title>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<!-- 这一行必须在下面一行前面 -->
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<div class="container">
		<table class="table">
			<%
			while(rs.next()) {
			%>
				<tr>
					<td><%= rs.getInt("id") %></td>
					<td><a href="ShowDetail.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("title") %></a></td>
				</tr>
			<%
			}
			%>
		</table>
		<a href="ShowPanel.jsp?pageNo=1" class="btn btn-primary btn-xs" role="button">首页</a>
		<a href="ShowPanel.jsp?pageNo=<%= pageNo-1 %>" class="btn btn-primary btn-xs <%= pageNo==1?"disabled":"" %>" role="button">上一页</a>
		<label>第<%= pageNo %>页，共<%= totalPages %>页</label>
		<a href="ShowPanel.jsp?pageNo=<%= pageNo+1 %>" class="btn btn-primary btn-xs <%= pageNo==totalPages?"disabled":"" %>" role="button">下一页</a>
		<a href="ShowPanel.jsp?pageNo=<%= totalPages %>" class="btn btn-primary btn-xs" role="button">尾页</a>
	</div>
</body>
</html>
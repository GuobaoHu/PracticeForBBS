<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
/* 防止直接通过url传参数过来进行删除操作 */
String isAdminStr = (String)session.getAttribute("admin");
if(isAdminStr == null || !isAdminStr.trim().equals("true")) {
	out.println("你是谁？！！");
	return;
}
%>

<%
/* 删除操作 */
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?" +
        "user=root&password=root");

//创建一个事务
conn.setAutoCommit(false);

//1.获取传过来的参数id和pid
int id, pid;
try {
	id = Integer.parseInt(request.getParameter("id"));
	pid = Integer.parseInt(request.getParameter("pid"));
} catch (NumberFormatException e) {
	out.println("数字格式不对！");
	return;
}
//2.删除id及id的儿子
del(conn, id);
//3.检查pid还有没有其他儿子，没有把pid的isleaf改为0
Statement stmt = conn.createStatement();
Statement updtStmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select count(*) from article where pid = " + pid);
rs.next();
if(rs.getInt(1) == 0) {
	updtStmt.executeUpdate("update article set isleaf = 0 where id = " + pid);
}

//commit
conn.commit();
conn.setAutoCommit(false);

if(stmt != null) stmt.close();
if(updtStmt != null) updtStmt.close();
if(conn != null) conn.close();

response.sendRedirect("ShowTree.jsp");
%>

<%!
/* 删除的递归方法 */
private void del(Connection conn, int id) {
	Statement stmt = null;
	Statement delStmt = null;
	try {
		//删儿子
		stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from article where pid = " + id);
		while(rs.next()) {
			del(conn, rs.getInt("id"));
		}
		//删自己
		delStmt = conn.createStatement();
		delStmt.executeUpdate("delete from article where id = " +id);
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(delStmt != null) delStmt.close();
			if(stmt != null) stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
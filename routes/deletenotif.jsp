<%@page import="java.sql.*" %>
<%
    String id=request.getParameter("id");
    Connection con;
    PreparedStatement pst;
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","");
    pst = con.prepareStatement("delete from `update` where id = ?");
    pst.setString(1, id);
    pst.executeUpdate();
    response.sendRedirect("./admindashboard.jsp");
%>
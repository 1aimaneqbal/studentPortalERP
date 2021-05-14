<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
    String roll=request.getParameter("roll");
    Connection con;
    PreparedStatement pst, pst2;
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","");
    pst = con.prepareStatement("delete from marks where roll = ?");
    pst.setString(1, roll);
    pst.executeUpdate();
    pst2 = con.prepareStatement("delete from students where roll = ?");
    pst2.setString(1, roll);
    pst2.executeUpdate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../res/styles/admindashboard.css">
    <link rel="stylesheet" href="../res/styles/updatedeletestyle.css">
    <title>Record Deleted</title>
</head>
<body>
    <nav>
        <div class="header">
            <h2><a href="./admindashboard.jsp" style="text-decoration: none; color: #fff;">Admin Dashboard</a></h2>
        </div>
        <div class="name">
            <% 
                String adminname = session.getAttribute("adminname").toString();
            %>
            <h4><% out.println(adminname); %></h4>
            <a href="../index.html">
                Log Out
            </a>
        </div>
    </nav>
    <div class="go">
        <%
            String r = request.getParameter("roll");
        %>  
        <h3><% out.println(r);%> - Record Deleted</h3>
        <h4><a href="./admindashboard.jsp">Go Back</a></h4>
    </div>
</body>
</html>
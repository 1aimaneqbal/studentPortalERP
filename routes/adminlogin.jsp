<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
if(request.getParameter("submit")!=null){
    String name=request.getParameter("name");
    String pass=request.getParameter("pass");
    Connection con;
    ResultSet rs;
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","");
    Statement st = con.createStatement();
    rs = st.executeQuery("select * from admin where Name='"+name+"'");
    if(rs.next()){
        if(rs.getString("Pass").equals(pass)){
            session.setAttribute("adminname", rs.getString("Fulname"));
            response.sendRedirect("admindashboard.jsp");
        }
        else{
            %>
            <script>
                alert("Invalid Password.");
            </script>
            <%
        }
    }
    else{
        %>
        <script>
            alert("Invalid Username or Password.");
        </script>
        <%
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../res/styles/formstyles.css">
    <title>ERP | Admin Login</title>
</head>
<body>
    <nav>
        <a href="../index.html">
            <div class="textcontainer">
                <h2>Student Registration & ERP Portal</h2>
            </div>
         </a>
    </nav>
    <div class="container">
        <h2>Admin Login</h2>
        <form method="POST" action="#">
            <div class="inputBox">
                <input type="text" name="name" required="required">
                <label>Username</label>
            </div>
            <div class="inputBox">
                <input type="password" name="pass" required="required">
                <label>Password</label>
            </div>
            <input type="submit" name="submit" value="Login">
        </form>
    </div>
</body>
</html>

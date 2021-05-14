<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
if(request.getParameter("submit")!=null){
    String name=request.getParameter("name");
    String roll=request.getParameter("roll");
    String mail=request.getParameter("mail");
    String pass=request.getParameter("pass");
    String gender=request.getParameter("gender");
    String sem=request.getParameter("currsem");
    double gpa=0.0;
    Connection con;
    PreparedStatement pst, pst2;
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","");
    pst = con.prepareStatement("insert into students (Name, Roll, Email, Password, Gender) values (?,?,?,?,?)");
    pst.setString(1,name);
    pst.setString(2,roll);
    pst.setString(3,mail);
    pst.setString(4,pass);
    pst.setString(5,gender);
    pst2 = con.prepareStatement("insert into marks (Roll, Sem, GPA) values (?,?,?)");
    pst2.setString(1,roll);
    pst2.setString(2,sem);
    pst2.setDouble(3, gpa);
    pst.executeUpdate();
    pst2.executeUpdate();
    %>
    <script>
        alert("Student Registered.");
    </script>
    <%
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
    <title>ERP | Register</title>
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
        <h2>Sign Up</h2>
        <form method="POST" action="#">
            <div class="inputBox">
                <input type="text" name="name" required="required">
                <label>Fullname</label>
            </div>
            <div class="inputBox">
                <input type="text" name="roll" required="required">
                <label>Roll No.</label>
            </div>
            <div class="inputBox">
                <input type="email" name="mail" required="required">
                <label>Email</label>
            </div>
            <div class="inputBox">
                <input type="password" name="pass" required="required">
                <label>Password</label>
            </div>
            <div class="radioBox">
                <div class="radcontainer">
                    <input type="radio" id="male" name="gender" value="Male">
                    <label for="male">Male</label>
                </div>
                <div class="radcontainer">
                    <input type="radio" id="female" name="gender" value="Female">
                    <label for="female">Female</label>
                </div>
            </div>
            <div class="selBox">
                <label for="">Select your current Sem: </label>
                <select name="currsem" id="currsem" class="select">
                    <option value="1">Sem 1</option>
                    <option value="2">Sem 2</option>
                    <option value="3">Sem 3</option>
                    <option value="4">Sem 4</option>
                    <option value="5">Sem 5</option>
                    <option value="6">Sem 6</option>
                </select>
            </div>
            <input type="submit" name="submit" id="submit" value="Sign up">
        </form>
    <h4>Already registered? Log in <a href="./login.jsp">here!</a></h4>
    </div>
</body>
</html>

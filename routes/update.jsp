<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
if(request.getParameter("submit")!=null){
    String name=request.getParameter("name");
    String mail=request.getParameter("mail");
    String gender=request.getParameter("gender");
    String sem=request.getParameter("currsem");
    String phone=request.getParameter("phone");
    String father=request.getParameter("father");
    double sem1=Double.parseDouble(request.getParameter("sem1"));
    double sem2=Double.parseDouble(request.getParameter("sem2"));
    double sem3=Double.parseDouble(request.getParameter("sem3"));
    double sem4=Double.parseDouble(request.getParameter("sem4"));
    double sem5=Double.parseDouble(request.getParameter("sem5"));
    double sem6=Double.parseDouble(request.getParameter("sem6"));
    String roll=request.getParameter("roll");
    int s = Integer.parseInt(sem);
    double gpa=( sem1 + sem2 + sem3 + sem4 + sem5 + sem6 )/(s-1);
    gpa=Math.round(gpa*100.0)/100.0;
    Connection con;
    PreparedStatement pst, pst2;
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","");
    pst = con.prepareStatement("update marks set Sem = ?, Sem1 = ?, Sem2 = ?, Sem3 = ?, Sem4 = ?, Sem5 = ?, Sem6 = ?, GPA = ? where Roll = ? ");
    pst.setString(1,sem);
    pst.setDouble(2,sem1);
    pst.setDouble(3,sem2);
    pst.setDouble(4,sem3);
    pst.setDouble(5,sem4);
    pst.setDouble(6,sem5);
    pst.setDouble(7,sem6);
    pst.setDouble(8,gpa);
    pst.setString(9,roll);
    pst.executeUpdate();
    pst2 = con.prepareStatement("update students set Name = ?, Email = ?, Gender = ?, Phone = ?, Father = ? where Roll = ? ");
    pst2.setString(1,name);
    pst2.setString(2,mail);
    pst2.setString(3,gender);
    pst2.setString(4,phone);
    pst2.setString(5,father);
    pst2.setString(6,roll);
    pst2.executeUpdate();
    %>
    <script>
        alert("Records Updated.");
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
    <link rel="stylesheet" href="../res/styles/updatedeletestyle.css">
    <title>Update Marks</title>
</head>
<body>
	<div class="u-container">
        <%
            String roll=request.getParameter("roll");
            Connection con;
            ResultSet rs, rs2;
            PreparedStatement pst, pst2;
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","");
            pst = con.prepareStatement("select * from marks where Roll = ?");
            pst.setString(1, roll);
            pst2 = con.prepareStatement("select * from students where Roll = ?");
            pst2.setString(1, roll);
            rs = pst.executeQuery();
            rs2 = pst2.executeQuery();
            if(rs.next() && rs2.next()){
        %>
		<h2>Update - <% out.println(roll); %></h2>
		<form method="POST" action="#">
			<div class="u-inputBox">
				<input type="text" name="name" required="" value="<%= rs2.getString("Name") %>">
				<label>Fullname</label>
			</div>
			<div class="u-inputBox">
				<input type="email" name="mail" required="" value="<%= rs2.getString("Email") %>">
				<label>Email</label>
			</div>
			<div class="u-inputBox">
				<input type="text" name="gender" required="" value="<%= rs2.getString("Gender") %>">
				<label>Gender</label>
			</div>
			<div class="u-inputBox">
				<input type="text" name="phone" required="" value="<%= rs2.getString("Phone") %>">
				<label>Phone</label>
			</div>
			<div class="u-inputBox">
				<input type="text" name="father" required="" value="<%= rs2.getString("Father") %>">
				<label>Father's Name</label>
			</div>
			<div class="u-inputBox">
				<input type="text" name="currsem" required="" value="<%= rs.getString("Sem") %>">
				<label>Current Sem</label>
			</div>
			<div class="u-inputBox">
				<input type="text" name="sem1" required="" value="<%= rs.getString("Sem1") %>">
				<label>Sem 1 Marks</label>
			</div>
			<div class="u-inputBox">
				<input type="text" name="sem2" required="" value="<%= rs.getString("Sem2") %>">
				<label>Sem 2 Marks</label>
			</div>
			<div class="u-inputBox">
				<input type="text" name="sem3" required="" value="<%= rs.getString("Sem3") %>">
				<label>Sem 3 Marks</label>
			</div>
			<div class="u-inputBox">
				<input type="text" name="sem4" required="" value="<%= rs.getString("Sem4") %>">
				<label>Sem 4 Marks</label>
			</div>
			<div class="u-inputBox">
				<input type="text" name="sem5" required="" value="<%= rs.getString("Sem5") %>">
				<label>Sem 5 Marks</label>
			</div>
			<div class="u-inputBox">
				<input type="text" name="sem6" required="" value="<%= rs.getString("Sem6") %>">
				<label>Sem 6 Marks</label>
			</div>
        <%
            }
        %>
			<input type="submit" name="submit" value="Update">
		</form>
        <h4><a href="./admindashboard.jsp">Go Back</a></h4>
	</div>
</body>
</html>
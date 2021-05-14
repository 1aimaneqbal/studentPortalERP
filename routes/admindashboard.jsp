<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
    Connection con;
    ResultSet rs;
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","");
    Statement st = con.createStatement();
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
    <script src="../res/scripts/notification.js" defer></script>
    <title>Dashboard | Admin</title>
</head>
<body>
    <nav>
        <div class="header">
            <h2>Admin Dashboard</h2>
        </div>
        <div class="name">
            <% 
                String adminname = session.getAttribute("adminname").toString();
            %>
            <h4><% out.println(adminname); %></h4>
            <div class="count">
                <img src="../res/icons/bell.png" alt="">
                <%
                    rs = st.executeQuery("select * from `update`");
                    int cnt=0;
                    while(rs.next())
                        cnt++;
                    rs.close();
                %>
                <span><% out.println(cnt); %></span>
            </div>
            <a href="../index.html">
                Log Out
            </a>
        </div>
    </nav>
    <div class="container">
        <h4>Student Records</h4>
        <table>
            <tr>
                <th>Roll No</th>
                <th>Current Sem</th>
                <th>Sem 1 Marks</th>
                <th>Sem 2 Marks</th>
                <th>Sem 3 Marks</th>
                <th>Sem 4 Marks</th>
                <th>Sem 5 Marks</th>
                <th>Sem 6 Marks</th>
                <th>GPA</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
            <%
                rs = st.executeQuery("select * from marks");
                while(rs.next()){
                    String roll = rs.getString("Roll");
            %>
            <tr>
                <td><%= rs.getString("Roll") %></td>
                <td><%= rs.getString("Sem") %></td>
                <td><%= rs.getString("Sem1") %></td>
                <td><%= rs.getString("Sem2") %></td>
                <td><%= rs.getString("Sem3") %></td>
                <td><%= rs.getString("Sem4") %></td>
                <td><%= rs.getString("Sem5") %></td>
                <td><%= rs.getString("Sem6") %></td>
                <td><%= rs.getString("GPA") %></td>
                <td><a href="./update.jsp?roll=<%=roll%>" class="edit">Edit</a></td>
                <td><a href="./delete.jsp?roll=<%=roll%>" class="delete">Delete</a></td>
            </tr>
            <%
                }
                rs.close();
            %>
        </table>
    </div>
    <div class="notifcontainer">
        <div class="notifications">
            <h3>Update Requests</h3>
            <table>
                <tr>
                    <th>Roll</th>
                    <th>Name</th>
                    <th>Father's Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Sem</th>
                    <th>Gender</th>
                    <th>Marks</th>
                    <th>Delete</th>
                </tr>
                <%
                    rs = st.executeQuery("select * from `update`");
                    while(rs.next()){
                        String id = rs.getString("id");
                %>
                <tr>
                    <td><%= rs.getString("Roll") %></td>
                    <td><%= rs.getString("Name") %></td>
                    <td><%= rs.getString("Father") %></td>
                    <td><%= rs.getString("Email") %></td>
                    <td><%= rs.getString("Phone") %></td>
                    <td><%= rs.getString("Sem") %></td>
                    <td><%= rs.getString("Gender") %></td>
                    <td><%= rs.getString("Marks") %></td>
                    <td><a href="./deletenotif.jsp?id=<%=id%>" class="delete">Delete</a></td>
                </tr>
                <%
                    }
                    rs.close();
                %>
            </table>
            <input type="submit" value="close" onclick="closenotif()">
        </div>
    </div>
</body>
</html>
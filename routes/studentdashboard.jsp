<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
    Connection con;
    ResultSet rs, rsMarks, rsSub, rsMarksSorted, rtemp;
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","");
    Statement st, stMarks, stSub, stMarksSorted, stemp;
    st = con.createStatement();
    stMarks = con.createStatement();
    String roll = session.getAttribute("roll").toString();
    rs = st.executeQuery("select * from students where Roll='"+roll+"'");
    rsMarks = stMarks.executeQuery("select * from marks where Roll='"+roll+"'");
    if(request.getParameter("submit")!=null){
        String name=request.getParameter("name");
        String father=request.getParameter("father");
        String mail=request.getParameter("mail");
        String phone=request.getParameter("phone");
        String sem=request.getParameter("sem");
        String gender=request.getParameter("gender");
        String marks=request.getParameter("marks");
        PreparedStatement pst;
        pst = con.prepareStatement("insert into `update` (Roll, Name, Father, Email, Phone, Sem, Gender, Marks) values (?,?,?,?,?,?,?,?)");
        pst.setString(1,roll);
        pst.setString(2,name);
        pst.setString(3,father);
        pst.setString(4,mail);
        pst.setString(5,phone);
        pst.setString(6,sem);
        pst.setString(7,gender);
        pst.setString(8,marks);
        pst.executeUpdate();
    %>
        <script>
            alert("Request Registered.");
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
    <link rel="stylesheet" href="../res/styles/studentdashboard.css">
    <script src="../res/scripts/app.js" defer></script>
    <title>Dashboard | Student</title>
</head>
<body>
    <div class="container">
        <nav>
            <%
                if(rs.next() && rsMarks.next() ){
            %>
            <div class="imgcontainer">
                <%
                    if(rs.getString("Gender").equals("male") || rs.getString("Gender").equals("Male")){
                %> 
                <img src="../res/icons/male.png" alt="">
                <%
                    }
                %>
                <%
                    if(rs.getString("Gender").equals("female") || rs.getString("Gender").equals("Female")){
                %> 
                <img src="../res/icons/female.png" alt="">
                <%
                    }
                %>
            </div>
            <div class="info">
                <h3><%= rs.getString("Name") %></h3>
                <h4><%= rs.getString("Roll") %></h4>
            </div>
            <div class="links">
                <div class="design res">View Results</div>
                <div class="design ldb">Leaderboards</div>
                <div class="design rupdt">Request Update</div>
                <div class="design"><a href="../index.html">Log Out</a></div>
            </div>
        </nav>
        <div class="content">
            <div class="fullinfo">
                <div class="infoheader">
                    <p>Student Complete Details</p>
                </div>
                <div class="line"></div>
                <div class="infocontainer">
                    <div class="col">
                        <label for="">Name: <span><%= rs.getString("Name") %></span></label>
                        <label for="">Roll No.: <span><%= rs.getString("Roll") %></span></label>
                        <label for="">CGPA: <span><%= rsMarks.getString("GPA") %></span></label>
                        <label for="">Phone: <span><%= rs.getString("Phone") %></span></label>
                    </div>
                    <div class="col">
                        <label for="">Father's Name: <span><%= rs.getString("Father") %></span></label>
                        <label for="">Email: <span><%= rs.getString("Email") %></span></label>
                        <label for="">Semester: <span><%= rsMarks.getString("Sem") %></span></label>
                        <label for="">Gender: <span><%= rs.getString("Gender") %></span></label>
                    </div>
               </div>
            </div>
            <div class="subjects">
                <div class="infoheader">
                    <p>Currently Enrolled Courses</p>
                </div>
                <div class="line"></div>
                <div class="coursecontainer">
                    <div class="courses">
                        <%
                            stSub = con.createStatement();
                            String currsem = rsMarks.getString("Sem");
                            rsSub = stSub.executeQuery("select * from subjects where Sem = '"+currsem+"'");
                            if(rsSub.next()){
                        %>   
                        <div class="item"><%= rsSub.getString("Sub1") %></div>
                        <div class="item"><%= rsSub.getString("Sub2") %></div>
                        <div class="item"><%= rsSub.getString("Sub3") %></div>
                    </div>
                    <div class="courses">
                        <div class="item"><%= rsSub.getString("Sub4") %></div>
                        <div class="item"><%= rsSub.getString("Sub5") %></div>
                        <div class="item"><%= rsSub.getString("Sub6") %></div>
                        <%
                            }
                            stSub.close();
                            rsSub.close();
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="linkcontainer result">
        <div class="linkcontent">
            <h3>Your Semester Results</h3>
            <table>
                <tr>
                    <th>Semester</th>
                    <th>Points Earned</th>
                    <th>Total Grade Points</th>
                    <th>SGPA</th>
                </tr>
                <%
                    int icurrsem = Integer.parseInt(rsMarks.getString("Sem")), i=1, tgp[]={21,26,24,24,21,24};
                    while(i<icurrsem){
                        double d = rsMarks.getDouble("Sem"+i);
                %>
                <tr>
                    <td>Semester <% out.println(i); %></td>
                    <td><% out.println(Math.floor(d*tgp[i-1])); %></td>
                    <td><% out.println(tgp[i-1]*10); %></td>
                    <td><%= rsMarks.getDouble("Sem"+i) %></td>
                </tr>
                <%
                    i++;
                    }
                %>
            </table>
            <input type="submit" value="close" onclick="closeRes()">
        </div>
    </div>
    <div class="linkcontainer leader">
        <div class="linkcontent">
            <h3>Leaderboards</h3>
            <table>
                <tr>
                    <th>Name</th>
                    <th>Roll</th>
                    <th>GPA</th>
                </tr>
                <%
                    stMarksSorted = con.createStatement();
                    rsMarksSorted = stMarksSorted.executeQuery("select * from marks order by GPA desc");
                    i=0;
                    while(rsMarksSorted.next()){
                %>  
                <tr>
                    <td>
                    <%
                        stemp = con.createStatement();
                        String temproll = rsMarksSorted.getString("Roll");
                        rtemp = stemp.executeQuery("select Name from students where Roll='"+temproll+"'");
                        if(rtemp.next()){
                    %>
                    <%= rtemp.getString("Name") %>
                    <%
                        rtemp.close();
                        stemp.close();
                        }
                    %>
                    </td>
                    <td><%= rsMarksSorted.getString("Roll") %></td>
                    <td><%= rsMarksSorted.getString("GPA") %></td>
                </tr>
                <%
                    i++;
                    if(i==5)
                        break;
                    }
                %>
            </table>
            <input type="submit" value="close" onclick="closeLead()">
        </div>
    </div>
    <div class="linkcontainer update">
        <div class="linkcontent">
            <h3>Request Information Update</h3>
            <form action="#" method="POST">
                <div class="formchkbx">
                    <div class="formcol">
                        <input type="text" name="name" placeholder="Name">
                        <input type="text" name="mail" placeholder="Email">
                        <input type="text" name="phone" placeholder="Phone">
                    </div>
                    <div class="formcol">
                        <input type="text" name="father" placeholder="Father">
                        <input type="text" name="gender" placeholder="Gender">
                        <input type="text" name="sem" placeholder="Sem">     
                    </div>
                </div>
                <input type="text" name="marks" placeholder="Marks">
                <input type="submit" name="submit" id="submit">
                <p>Incase of password updation mail to erp.admin@bitmesra.ac.in <br>Incase of marks updation entered the marks obtained. Once verified by the ERP cell it will reflect in your dashboard.</p>
            </form>
            <input type="submit" value="Close" onclick="closeReq()">
        </div>
    </div>
            <%
                }
            %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@ page import="java.net.http.HttpRequest" %>
<%@ page import="java.net.http.HttpResponse" %>
<%@ page import="java.net.http.HttpClient" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

</head>
<body>

<% 
	
 %>
 
<div align="center">
<h2>Register here</h2>
    <form action="<%= request.getContextPath() %>/SignUpServet" method="post">
    <table style="width:80%">
            <tr>
            <td>First Name :</td>
              <td><input type="text" name="firstname" id="name" placeholder="Enter Your First Name"/>  </td>
           </tr>
           
            <tr>
            <td>Last Name :</td>
              <td><input type="text" name="lastname" id="name" placeholder="Enter Your Last Name"/>  </td>
            </tr>
            
            <tr>
            <td>User Name :</td>
             <td> <input type="text" name="username" id="name" placeholder="Enter Your User Name"/>  </td>
            </tr>
            
            <tr>
            <td>Email :</td>
             <td> <input type="email" name="email" id="name" placeholder="Enter Your Valid Email"/>  </td>
            </tr>
            
            <tr>
            <td>Mobile Number :</td>
            <td><input type="text" name="phone" id="name" pattern="[0-9]{10}" required placeholder="Enter Your Mobile Number"/> </td>
            </tr>
            
            <tr>
        <td> Password</td>
        <td> <input type="password" id="password" name="password"placeholder="Enter Password"/>  </td>
         </tr>
        
     </table>
    
       
         <button type="submit" class="signupbtn">Sign Up</button>
          
            <tr>
              <td> <a href= "http://localhost:8080/Estore/login.jsp"/> Already an User</a> </td>
           </tr>
    </form>
     </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
 <%
			 response.setHeader("Cache-Control", "no-cache");
			 response.setHeader("Cache-Control", "no-store");
			 response.setHeader("Pragma", "no-cache");
			 response.setDateHeader("Expires", 0);
		%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 <div align="center">
  <h1>Login</h1>
  <form action="<%= request.getContextPath() %>/SignUpServet" method="get">
   <table style="with: 100%">
    <tr>
     <td>UserName:</td>
     <td><input type="text" name="username" /></td>
    </tr>
    <tr>
     <td>Password:</td>
     <td><input type="password" name="password" /></td>
    </tr>
   </table>
   <input type="submit" value="Submit" />
   <tr>
              <td> <a href= "http://localhost:8080/Estore/Index.jsp"/> Don't have an account? </a> </td>
           </tr>
  </form>
 </div>
</body>
</html>
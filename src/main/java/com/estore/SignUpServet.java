package com.estore;

import java.awt.print.Printable;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Response;

/**
 * Servlet implementation class SignUpServet
 */

//HttpRequest req = HttpRequest.newBuilder()
//.uri(URI.create("https://fakestoreapi.com/products"))
//.method("GET", HttpRequest.BodyPublishers.noBody())
//.build();
//PrintWriter o = response.getWriter();
//HttpResponse<String> resp = null;
//resp = HttpClient.newHttpClient().send(req, HttpResponse.BodyHandlers.ofString());
//out.print(resp.body());
@WebServlet("/SignUpServet")
public class SignUpServet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUpServet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		UserActions ua=new UserActions();
		try {
			Connection con=ua.getConnection();
			String uname=request.getParameter("username"),password=request.getParameter("password");
			System.out.println("u:p"+ uname+":"+password);
			if(ua.validate(request.getParameter("username"),request.getParameter("password"))) {
		PreparedStatement preparedStatement=con.prepareStatement("select user_id from user where username=?");
		preparedStatement.setString(1,uname);
		ResultSet rt = preparedStatement.executeQuery();
		rt.next();
		int user_id=rt.getInt("user_id");
		System.out.println(user_id);
				
        HttpSession session=request.getSession();
     	session.setAttribute("username",uname);
		session.setAttribute("user_id",user_id);
				RequestDispatcher dispatcher= request.getRequestDispatcher("/Cart.jsp");
				dispatcher.forward(request, response);
			}
			else {
				PrintWriter out = response.getWriter();
				out.print("incorrect username/ password");
			}
			
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		User user = new User(request.getParameter("firstname"),
	    request.getParameter("lastname"),
		request.getParameter("username"),
		request.getParameter("password"),
		request.getParameter("email"),
		request.getParameter("phone")
		);
		PrintWriter out = response.getWriter();
		UserActions ua = new UserActions();
		if (ua.userExist(user)) {
			
			out.print("user already exists");
			
		}
		else {
			try {
				ua.insertuser(user);
				//out.println("Registered Successfully");
				//console.alert("Registered Successfully");
				RequestDispatcher dispatcher= request.getRequestDispatcher("/login.jsp");
				dispatcher.forward(request, response);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}

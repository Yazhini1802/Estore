package com.estore;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.mysql.cj.util.DnsSrv.SrvRecord;

/**
 * Servlet implementation class savetodb
 */
@WebServlet("/savetodb")
public class savetodb extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public savetodb() {
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
			
			Connection con;
			try {
				con = ua.getConnection();
				HttpSession session=request.getSession();
				int cId;
				try {
					 cId=Integer.parseInt( session.getAttribute("user_id").toString());
					
				} catch (Exception e) {
					 cId=Integer.parseInt( request.getParameter("user_id"));
				}
				//int cId=3;
				int result=0;				
				PreparedStatement preparedStatement=con.prepareStatement("select * from cart where customer_id=?");
				preparedStatement.setInt(1,cId);
				ResultSet rt = preparedStatement.executeQuery();
				System.out.println("Rt"+ rt.next());
				JsonArray jarray = new JsonArray();
				while (rt.next()) {
				int prId=rt.getInt("Product_id");
				int gprice= rt.getInt("price");
				int prqty=rt.getInt("Product_qty");
				int SubT=rt.getInt("Sub_total");
				JsonObject json=new JsonObject();
				json.addProperty("Product_id",prId );
				json.addProperty("price", gprice );
				json.addProperty("Product_qty", prqty );
				json.addProperty("Sub_total", SubT);
				jarray.add(json);
				}
				System.out.println(jarray.toString());
				response.setContentType("application/json");
				
				response.getWriter().write(jarray.toString()); 
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		int cId=Integer.parseInt( session.getAttribute("user_id").toString());
		UserActions ua=new UserActions();
		int result=0;
		System.out.println("this is the dopost method of savetodb.java");
		String qty=request.getParameter("Product_qty");
		System.out.println(cId); 
		String price=request.getParameter("price");
		
		
		//String aa =request.getParameter("Product_id").toString();
		String pId=request.getParameter("Product_id");
		System.out.println("productid:"+pId);
		String subtotal=request.getParameter("Sub_total");
		//PrintWriter out = response.getWriter();
		String INSERT_USER_SQL = "INSERT INTO cart" + "(customer_id,Product_id,price,Product_qty,Sub_total)"
				+ " VALUES"	+"(?,?,?,?,?);";
	Connection con;
	try {
		con = ua.getConnection();
		 PreparedStatement ps=con.prepareStatement(INSERT_USER_SQL);
		 ps.setInt(1, cId);
			ps.setString(2, pId);
			ps.setString(3, price);
			ps.setString(4,qty);
			ps.setString(5, subtotal);
			result =ps.executeUpdate();
			response.setContentType("application/json");
			response.getWriter().write("response:"+result);    
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
   
    }//						
//						System.out.println(ps);
//						
//					}


	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			System.out.println("doPut called");
			HttpSession session=request.getSession();
			String cId;
			try {
			cId= session.getAttribute("user_id").toString();
			}
			catch(Exception e) {
				cId=request.getParameter("cid");
				System.out.println("cid set in cache:"+cId);
			}
			String pId=request.getParameter("Product_id");
			System.out.println("doPut--->calling getQuantity Cid:"+cId +" pId:"+pId);
			float arr[]=getQuantityAndPrice(cId,pId);
			if(arr!=null) {
			float quantity=arr[0],price=arr[1];
				quantity++;
				System.out.println("doPut --->updating existing item in cart  quantity:"+quantity + " price:"+price);
//public int UpdateDB(String customerId,String productId,float quantity, float price				
				UpdateDB(cId,pId,quantity,price);
			}
			else {
				System.out.println("inserting new onject to cart");
				String price = request.getParameter("price");
				insertIntoCart(cId, pId,price, "1", price);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
//		UserActions ua=new UserActions();
//		Connection con;
//		try {
//			con = ua.getConnection();
//			HttpSession session=request.getSession();
//			int cId;
//			try {
//			cId=Integer.parseInt( session.getAttribute("user_id").toString());
//			}
//			catch(Exception e) {
//				cId=Integer.parseInt(request.getParameter("cid"));
//				System.out.println(cId);
//			}
//			String pId=request.getParameter("Product_id");
//			String qty=request.getParameter("Product_qty");
//			String price=request.getParameter("price");
//			  String sql = "UPDATE cart SET Product_qty = ?, Sub_total=? WHERE product_id = ? and customer_id=? ";
//			 PreparedStatement ps=con.prepareStatement(sql);
//			 ps.setString(1, qty);
//			 ps.setString(2 ,price);
//			 ps.setString(3 , pId);
//			 ps.setInt(4 , cId );
//			 System.out.println(ps);
//			 ps.executeUpdate();
//			 System.out.println("updated in table :"+pId);
//			 response.getWriter().write("response:");  
//		} catch (ClassNotFoundException | SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
	}
	public float[] getQuantityAndPrice(String customerId,String productId) {
		try {
			UserActions ua= new UserActions();
			Connection con =ua.getConnection();
			String query = "select Product_qty, price from cart where customer_id=? and Product_id=?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, customerId);
			ps.setString(2, productId);
			System.out.println("getQuantityAndPrice--> query : "+ ps);
			ResultSet rt =ps.executeQuery();
			if(rt.next()) {
				float quans=-1,price=-1;
				quans=rt.getFloat("Product_qty");
				price=rt.getFloat("price");
				float []arr= {quans,price};
				
				return arr;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	public void insertIntoCart(String cId, String pId, String price, String qty, String subtotal) {
		System.out.println("insert into cart clled ");
		String INSERT_USER_SQL = "INSERT INTO cart" + "(customer_id,Product_id,price,Product_qty,Sub_total)"
				+ " VALUES"	+"(?,?,?,?,?);";
	Connection con;
	try {
		UserActions ua= new UserActions();
		con = ua.getConnection();
		 PreparedStatement ps=con.prepareStatement(INSERT_USER_SQL);
		 ps.setString(1, cId);
			ps.setString(2, pId);
			ps.setString(3, price);
			ps.setString(4,qty);
			ps.setString(5, subtotal);
			System.out.println("insertIntoCart--> queryy : "+ps);
			int result =ps.executeUpdate();
		}
	catch (Exception e) {
		// TODO: handle exception
	}
	}
	public int UpdateDB(String customerId,String productId,float quantity, float price) throws IOException{
		float subtotal=quantity*price;
		try {
			UserActions ua= new UserActions();
			Connection con =ua.getConnection();
			String sql="UPDATE cart SET Product_qty=?,price=?,Sub_total=? WHERE customer_id=? and Product_id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setFloat(1, quantity);
			ps.setFloat(2, price);
			ps.setFloat(3, subtotal);
			ps.setString(4, customerId);
			ps.setString(5, productId);
			System.out.println("executing databaase update query :"+ ps);
			int a=ps.executeUpdate();
			return a;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
		
	}

	/**
	 * @see HttpServlet#doDelete(HttpServletRequest, HttpServletResponse)
	 */
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserActions ua=new UserActions();
		Connection con;
		try {
			con = ua.getConnection();
			HttpSession session=request.getSession();
			int cId = 0;
			try {
			cId=Integer.parseInt(session.getAttribute("user_id").toString());
			}
			catch(Exception e) {
				
				//System.out.println(cId);
			}
			String pId=request.getParameter("Product_id");
			String sql = "DELETE FROM cart WHERE product_id = ? and customer_id=?";
			 PreparedStatement ps=con.prepareStatement(sql);
			 ps.setString(1, pId);
			 ps.setInt(2 ,cId);
			 boolean a=ps.execute();
			 System.out.println("deleted fromm table :"+pId);
			 response.getWriter().write("response:"+a);  
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// TODO Auto-generated method stub
	}

}

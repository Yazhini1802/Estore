package com.estore;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import redis.clients.jedis.Jedis;

/**
 * Servlet implementation class RedisFetchData
 */
@WebServlet("/RedisFetchData")
public class RedisFetchData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RedisFetchData() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub Jedis jedis = new Jedis("localhost");
		Jedis jedis = new Jedis("localhost",6379); // Connect to Redis
        String cachedData = jedis.get("cachedData"); // Check if data is cached
        System.out.println( jedis.ping()); 
        if (cachedData != null) { // If data exists in cache
            response.getWriter().write(cachedData); 
            System.out.println("returning data from cache");
            //System.out.println(cachedData);
        } else { // If data doesn't exist in cache or has expired
            URL apiUrl = new URL("https://fakestoreapi.com/products"); // API URL
            BufferedReader reader = new BufferedReader(new InputStreamReader(apiUrl.openStream()));
            StringBuilder data = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                data.append(line);
            }
            reader.close();

            jedis.setex("cachedData", 60, data.toString()); // Cache data in Redis for 60 seconds
            response.getWriter().write(data.toString()); // Display fetched data
        }
        jedis.close(); // Close Redis connection
    }
//      


	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

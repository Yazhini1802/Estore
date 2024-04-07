<%@ page import="java.io.*, java.util.*, javax.servlet.*, java.sql.*" %>
<!DOCTYPE html>
<%
	 response.setHeader("Cache-Control", "no-cache");
	 response.setHeader("Cache-Control", "no-store");
	 response.setHeader("Pragma", "no-cache");
	 response.setDateHeader("Expires", 0);
%>
<html lang="en">
  <head>
    <%@ page import="javax.servlet.http.HttpSession" %>
  <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous"  />
   <meta charset="UTF-8" />
   <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <title>Product List</title>
   <style>
.product-card {
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 10px;
        margin: 10px;
        width: calc(33.33% - 20px); /* 3 products in a row */
        box-sizing: border-box;
        display: inline-block;
        vertical-align: top;
      }
      .product-card img {
        max-width: 100%;
        height: auto;
        margin-bottom: 10px;
      }
      .product-card h2 {
        margin-bottom: 5px;
      }
      .product-card p {
        margin: 0;
      }
      .addToCartButton {
        background-color: #4caf50;
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin-top: 10px;
        cursor: pointer;
        border-radius: 5px;
      }

      .head h1 {
        text-align: center;
      }

      .cart-item {
        margin-bottom: 10px;
        border-bottom: 1px solid #ccc;
        padding-bottom: 10px;
      }
      .removeButton {
        background-color: #ff6347;
        border: none;
        color: white;
        padding: 5px 10px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 12px;
        cursor: pointer;
        border-radius: 5px;
      }
      .decButton {
        background-color: #4caf50;
        border: none;
        color: white;
        padding: 5px 10px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 0 5px;
        cursor: pointer;
        border-radius: 3px;
        width: 30px;
      }
      .incButton {
        background-color: #4caf50;
        border: none;
        color: white;
        padding: 5px 10px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 0 5px;
        cursor: pointer;
        border-radius: 3px;
        width: 30px;
      }
    </style>
  </head>

  <body>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/Estore/Cart.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/Estore/checkout.jsp">Cart</a>
        </li>
        <li class="nav-item justify-content-end" tabindex="-1">
       <form class="d-flex justify-content-end" tabindex="-1">
       <button style="margin-left: 10px" type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">logout</button>
       </form>
       </li>
      </ul>
      
    </div>
  </div>
</nav>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Warning!</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        You will be Logged out of this session.
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
		        <form action="/Estore/LogoutServlet" method="post">
		       		<button class="btn btn-danger" type="submit" >Logout</button>
		     	</form>
		      </div>
		    </div>
		  </div>
		</div>
   
    <h1 id="head">Estore-Products</h1>
    <div id="productList"></div>
    <div id="cart">
     
      <div id="cartItems"></div>
    </div>

    <script>
     
      let cart = [];
      let prodMap = new Map();

     
      function saveToDBviaPostMethod(Product) {
        const url =
          "http://localhost:8080/Estore/savetodb?Product_id=" +
          Product.id +
          "&price=" +
          Product.price +
          "&Product_qty=1&Sub_total=" +
          Product.price;
        //var Params = encodeURI("Product_id="+Product.id+"price="+Product.price+"Product_qty="+"1"+"Sub_total"+Product.price);
        //console.log(Product.id);
        //console.log(Product.price);
        //console.log();
        //console.log(Product.Sub_total);
        // Parameters to be sent in the request body
        const params = {
          mutesksjf: Product.id,
          price: Product.price,
          Product_qty: "1",
          Sub_total: Product.Sub_total,
        };

        // Construct the request options
        const requestOptions = {
          method: "POST",
          headers: {
            "Content-Type": "application/json", // Specify the content type as JSON
          },
          body: JSON.stringify(params), // Convert the parameters to JSON format
        };

        // Send the POST request
        fetch(url, requestOptions)
          .then((response) => {
            if (!response.ok) {
              throw new Error("Network response was not ok");
            }
            return response; // Parse the response JSON
          })
          .then((data) => {
            // Handle the response data
            //console.log('Response:', data);
          })
          .catch((error) => {
            // Handle errors
            console.error("Error:", error);
          });
      }

      function decQuan(product) {
        var item = cart.find((item) => item.id === product.id);
        if (item.quantity > 1) {
          item.quantity--;
          var decquan = item.quantity;
          var pr = product.price;
          var decsub = decquan * pr;
          updateCart(product);
          renderCart();
        }
      }
      function incQuan(product) {
        const existingItem = cart.find(
          (item) => item.product.id === product.id
        );
        existingItem.quantity++;
        var incquan = existingItem.quantity;
        var pr = product.price;
        // console.log("--------------");
        // console.log(product);
        var incsub = incquan * pr;
        updateCart(product);
       renderCart();
      }

      function addToCart(product) {
       
        //console.log("Add to cart fn"+product.id);
       // const existingItem = cart.find(
          //(item) => item.product.id === product.id
        //);
       // if (existingItem) {
         // incQuan(product);
          updateCart(product);
          //existingItem.quantity++;
          // var quan=existingItem.quantity;
          //  var pr=product.price;
          //  console.log("--------------");
          //  console.log(product);
          //  var sub=quan*pr;
          //  updateCart(product,existingItem.quantity,sub);
       // } else {
         // saveToDBviaPostMethod(product);
          cart.push({ product: product, quantity: 1 });
       // }

      //  renderCart();
        alert("Added to cart successfully")
      }
      function updateCart(product) {
        const url =
          "http://localhost:8080/Estore/savetodb?Product_id=" +
          product.id +
          "&price=" +
          product.price;
          
        const requestOptions = {
          method: "PUT",
          headers: {
            "Content-Type": "application/json", // Specify the content type as JSON
          },
        };
        fetch(url, requestOptions)
          .then((response) => {
            if (!response.ok) {
              throw new Error("Network response was not ok");
            }
            return response; // Parse the response JSON
          })
          .then((data) => {
            // Handle the response data
            //  console.log('Response:', data);
          })
          .catch((error) => {
            // Handle errors
            console.error("Error:", error);
          });
      }
      function removeFromCart(product) {
        const url =
          "http://localhost:8080/Estore/savetodb?Product_id=" + product.id;
        const params = {
          mutesksjf: product.id,
          price: product.price,
          Product_qty: "1",
          Sub_total: product.Sub_total,
        };
        const requestOptions = {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json", // Specify the content type as JSON
          },
          body: JSON.stringify(params), // Convert the parameters to JSON format
        };

        // Send the POST request
        fetch(url, requestOptions)
          .then((response) => {
            if (!response.ok) {
              throw new Error("Network response was not ok");
            }
            return response; // Parse the response JSON
          })
          .then((data) => {
            // Handle the response data
            // console.log('Response:', data);
          })
          .catch((error) => {
            // Handle errors
            console.error("Error:", error);
          });
        cart = cart.filter((item) => item.product.id !== product.id);
        renderCart();
      }
     

      function renderCart() {
       
        const cartItemsDiv = document.getElementById("cartItems");
        cartItemsDiv.innerHTML = ""; // Clear previous items

        let totalCost = 0;

        cart.forEach((cartItem) => {
          const product = cartItem.product;
          const quantity = cartItem.quantity;
          const itemTotal = product.price * quantity;
          totalCost += itemTotal;

          // console.log(totalCost);

          const cartItemElement = document.createElement("div");
          cartItemElement.classList.add("cart-item");
          const id = document.createElement("h2");
          id.textContent = product.id;
          const title = document.createElement("h2");
          title.textContent = product.title;
          const price = document.createElement("p");
          price.textContent = "Price: $" + product.price.toFixed(2);

          const quantity1 = document.createElement("p");
          quantity1.textContent = "Quantity: " + quantity;

          const total = document.createElement("p");
          total.textContent = "Sub-Total:" + itemTotal.toFixed(2);

          const decButton = document.createElement("button");
          decButton.textContent = "-";
          decButton.classList.add("decButton");
          decButton.addEventListener("click", () => {
            decQuan(product);
          });
          const incButton = document.createElement("button");
          incButton.textContent = "+";
          incButton.classList.add("incButton");
          incButton.addEventListener("click", () => {
            incQuan(product);
          });
          const removeButton = document.createElement("button");
          removeButton.textContent = "Remove from Cart";
          removeButton.classList.add("removeButton");
          removeButton.addEventListener("click", () => {
            removeFromCart(product);
          });
          cartItemElement.appendChild(id);
          cartItemElement.appendChild(title);
          cartItemElement.appendChild(price);
          cartItemElement.appendChild(quantity1);
          cartItemElement.appendChild(total);
          cartItemElement.appendChild(removeButton);
          cartItemElement.appendChild(decButton);
          cartItemElement.appendChild(incButton);

          cartItemsDiv.appendChild(cartItemElement);
        });
        const subtotal = document.createElement("p");
        subtotal.textContent = "Total:" + totalCost.toFixed(2);
        cartItemsDiv.appendChild(subtotal);
      }

    

      fetch("http://localhost:8080/Estore/RedisFetchData")
        .then((response) => response.json())
        .then((products) => {
          const productList = document.getElementById("productList");

          products.forEach((product) => {
            const productCard = document.createElement("div");
            productCard.classList.add("product-card");
            productCard.id = product.id;

            const id = document.createElement("h5");
            id.textContent = product.id;

            const title = document.createElement("h2");
            title.textContent = product.title;
            title.id = "title";

            const price = document.createElement("p");
            price.textContent = "Price: $" + product.price.toFixed(2);

            const description = document.createElement("p");
            description.textContent = product.description;

            const category = document.createElement("p");
            category.textContent = "Category: " + product.category;

            const image = document.createElement("img");
            image.src = product.image;
            image.alt = product.title;

            const rating = document.createElement("p");
            rating.textContent =
              "Rating: " +
              product.rating.rate +
              " (based on " +
              product.rating.count +
              " reviews)";

            const addToCartButton = document.createElement("button");
            addToCartButton.textContent = "Add to Cart";
            addToCartButton.classList.add("addToCartButton");
            addToCartButton.addEventListener("click", () => {
              addToCart(product);
            });
            productCard.appendChild(id);
            productCard.appendChild(title);
            productCard.appendChild(price);
            productCard.appendChild(description);
            productCard.appendChild(category);
            productCard.appendChild(image);
            productCard.appendChild(rating);
            productCard.appendChild(addToCartButton);

            productList.appendChild(productCard);
            prodMap.set(product.id, product);
            return productList;
          });
        });

      function loadmyCart() {
        const url = "http://localhost:8080/Estore/savetodb";

        const requestOptions = {
          method: "GET",
          headers: {
            "Content-Type": "application/json", // Specify the content type as JSON
          },
          //  body: JSON.stringify(params) // Convert the parameters to JSON format
        };

        // Send the POST request
        fetch(url, requestOptions)
          // .then(response => {

          .then((response) => response.json())
          .then((mycartproducts) => {
            // console.log('resp',mycartproducts);
            mycartproducts.forEach((mcitem) => {
              const mcidyjrr = mcitem.Product_id;
              //	   console.log("mycartitemhi",mcid)	;
              const qty = mcitem.Product_qty;
              // prodMap[mcid];
              //  console.log("my car qty",qty);
              //  		    	  const product=prodMap.get(parseInt(mcid));
              //  		    	  console.log(product);

              var mcid = parseInt(mcitem.Product_id); // Convert to number if necessary
              var product = prodMap.get(mcid);
              console.log("Product ID:", mcid);
              console.log("Product:", product);
              //  console.log("my produt",prodMap.get(mcid));
              cart.push({ product: product, quantity: qty });

              // console.log('product:',prod, 'quantity:', qty);
            });
          })
         // .then(rendercart())
          .catch((error) => {
            // Handle errors
            console.error("Error:", error);
          });
      }

     // console.log("product map", prodMap);
    </script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  
  </body>
</html>

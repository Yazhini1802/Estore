//fetch('https://fakestoreapi.com/products')
  // .then((res) =>  console.log(res.json()))
   //.then(data => {
	//const outputElement=document.getElementById("1");
    //outputElement.textContent (JSON.stringify(data));
     //});
//import fetch from 'node-fetch'; { writeFile } 'fs';
<!DOCTYPE html>
<html lang="en">
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    background-color: #4CAF50;
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
  
  .head h1{
   text-align:center
   }
  
  .cart-item {
    margin-bottom: 10px;
    border-bottom: 1px solid #ccc;
    padding-bottom: 10px;
  }
  
  .removeButton {
    background-color: #FF6347;
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
</style>
</head>
<body>
<ul class="nav justify-content-end">
  <li class="nav-item">
    <a class="nav-link active" href="#" tabindex="-1" aria-disabled="true">CART</a>
  </li>
</ul>
<h1 id="head">Estore-Products</h1>
<div id="productList"></div>
<div id="cart">
  <h2>Cart</h2>
  <div id="cartItems"></div>
  <p id="totalCost">Total Cost: $0.00</p>
</div>

<script>
let cart = [];

function addToCart(product) {
  const existingItem = cart.find(item => item.product.id === product.id);
  if (existingItem) {
    existingItem.quantity++;
  } else {
    cart.push({ product: product, quantity: 1 });
  }
  saveCartToSessionStorage();
  renderCart();
}

function removeFromCart(productId) {
  cart = cart.filter(item => item.product.id !== productId);
  saveCartToSessionStorage();
  renderCart();
}

function renderCart() {
  const cartItemsDiv = document.getElementById("cartItems");
  cartItemsDiv.innerHTML = ""; // Clear previous items

  let totalCost = 0;

  cart.forEach(cartItem => {
    const product = cartItem.product;
    const quantity = cartItem.quantity;
    const itemTotal = product.price * quantity;
    totalCost += itemTotal;

    const cartItemElement = document.createElement("div");
    cartItemElement.classList.add("cart-item");
    cartItemElement.innerHTML = `
      <h3>${product.title}</h3>
      <p>Price: $${product.price.toFixed(2)}</p>
      <p>Quantity: ${quantity}</p>
      <p>Total: $${itemTotal.toFixed(2)}</p>
      <button class="removeButton" onclick="removeFromCart(${product.id})">Remove</button>
    `;
    cartItemsDiv.appendChild(cartItemElement);
  });

  document.getElementById("totalCost").textContent = `Total Cost: $${totalCost.toFixed(2)}`;
}

function saveCartToSessionStorage() {
  sessionStorage.setItem('cart', JSON.stringify(cart));
}

function loadCartFromSessionStorage() {
  const cartData = sessionStorage.getItem('cart');
  if (cartData) {
    cart = JSON.parse(cartData);
    renderCart();
  }
}

loadCartFromSessionStorage();

fetch('https://fakestoreapi.com/products')
  .then(response => response.json())
  .then(products => {
    const productList = document.getElementById("productList");

    products.forEach(product => {
  
      const productCard = document.createElement("div");
      productCard.classList.add("product-card");

      const title = document.createElement("h2");
      title.textContent = product.title;

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
      rating.textContent = "Rating: " + product.rating.rate + " (based on " + product.rating.count + " reviews)";

     
      const addToCartButton = document.createElement("button");
      addToCartButton.textContent = "Add to Cart";
      addToCartButton.classList.add("addToCartButton");
      addToCartButton.addEventListener("click", () => {
        addToCart(product);
      });

      productCard.appendChild(title);
      productCard.appendChild(price);
      productCard.appendChild(description);
      productCard.appendChild(category);
      productCard.appendChild(image);
      productCard.appendChild(rating);
      productCard.appendChild(addToCartButton);

     
      productList.appendChild(productCard);
    });
  })
  .catch(error => {
    console.error('Error fetching data:', error);
  });
</script>
</body>
</html>

/*const url='https://fakestoreapi.com/products';
fetch(url)
 .then(response => {
	if(!response.ok){
		throw new Error("Network response was not ok");
	}
	const contentType= response.headers.get("content-type");
	if(contentType &&  contentType.includes("application/json")){
		return response.json();
	}else{
	throw new TypeError("Response not in JSON format");	
	}
})
 .then((data =>{
	let jsondata=data;
	console.log(jsondata);
	document.getElementById("image").src=jsondata[0].image;
	document.getElementById("title").innerhtml=jsondata[0].title;
	document.getElementById("price").innerhtml=jsondata[0].price;
	document.getElementById("description").innerhtml=jsondata[0].description;
	document.getElementById("category").innerhtml=jsondata[0].category;
	document.getElementById("rating").innerhtml=jsondata[0].rating;
	})
	.catch((error) => {
		console.error("problem with fetch",error);
	}));
	
	function duplicateElement(){
		const originalElement= document.getElementById('maindiv');
		console.log(originalElement+ "hiiiiii");
		const cloneelement= originalElement.cloneNode(true);
		document.body.appendChild(cloneelement);
		}
	
	//outputElement=document.getElementById("image");
	//outputElement.src="https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg";
	//outputElement.textContent(JSON.stringify(data,null,4),err =>{
		/*if(err){
			console.error('Error writing JSON file:',err)
			}else{
				console.log('JSON file saved');
			}
		}
	);
})
    .catch(error => console,error('Error fetching data from API:',error));

//function newFunction() {
    //return require('node-fetch');
////}
 
 
 <% 
//String abc= session.getAttribute("username").toString();

%>
<h1><%= // session.getAttribute("username").toString(); %></h1>
<% void insertCartData(JSONArray cart) throws SQLException, ClassNotFoundException {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/demo","root","Yazhini@2712");
{
    PreparedStatement stmt = connection.prepareStatement("INSERT INTO user (productid, quantity) VALUES (?, ?)");
    for (int i = 0; i < cart.length(); i++) {
        JSONObject item = cart.getJSONObject(i);
        stmt.setInt(1, item.getInt("productId"));
        stmt.setInt(2, item.getInt("quantity"));
        stmt.executeUpdate();
    }

    stmt.close();
    connection.close();
}

if ("POST".equalsIgnoreCase(request.getMethod())) {
    // If it's a POST request, handle cart data insertion
    String jsonData = request.getReader().lines().collect(saveCartToDatabase());
    JSONArray cart = new JSONArray(jsonData);
    insertCartData(cartData);
} %>
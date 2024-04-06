<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Insert title here</title>


</head>
<body>

<ul class="nav justify-content-end">

  <li class="nav-item">
    <a class="nav-link active" href="#" tabindex="-1" aria-disabled="true">CART</a>
  </li>
</ul>

 <div class="container">
 <div class="maindiv">
  <div class="row align-items-start">
    <div class="col">
    <div class="card" style="width: 18rem; 0">
  <img id="image" src="..." 
  class="card-img-top" alt="image">
  <div class="card-body">
    <h5 class="card-title" id="title">Card title</h5>
    <h5 class="card-text" id="price"> price </h5>
    <p class="card-text" id="category"> category</p>
    <p class="card-text" id="rating">rating:  <br> <p class="card-text" id="rate">stars</p>
     <br> <p class="card-text" id="count">count</p> 
    <p class="card-text" id="description">Some quick example text to build on 
    the card title and make up the bulk of the card's content.</p>
    
    <a href="#" class="btn btn-primary">Add to cart</a>
  </div>
</div>
    </div>
  
    <div class="col">
   <div class="card" style="width: 18rem; 0">
  <img src=".."class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">gd3</h5>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <a href="#" class="btn btn-primary">Go somewhere</a>
  </div>
</div>
    </div>
    <div class="col">
     <div class="card" style="width: 18rem; 0">
  <img src=".." class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">gd3</h5>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <a href="#" class="btn btn-primary">Go somewhere</a>
  </div>
</div>
    </div>
  </div>
  </div>
    </div>

  <script>
  
  const url='https://fakestoreapi.com/products';
  res=fetch(url)
   .then(response => {
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
  	 const image= document.getElementById("image").src=jsondata.image;
  	document.getElementById("title").innerHTML=jsondata[0].title;
  	document.getElementById("price").innerHTML=jsondata[0].price;
  	document.getElementById("description").innerHTML=jsondata[0].description;
  	document.getElementById("category").innerHTML=jsondata[0].category;
  	document.getElementById("rating").innerHTML=jsondata[0].rating.rate;
  	document.getElementById("count").innerHTML=jsondata[0].rating.count;
  	
   }));
  	
  	function duplicateElement(){
  		const originalElement= document.getElementById("maindiv");
  		console.log(originalElement+ "hiiiiii");
  		const cloneelement= originalElement.cloneNode(true);
  		document.body.appendChild(cloneelement);
  		}
  	
 	</script>
	  
	  
  </body>
</html>
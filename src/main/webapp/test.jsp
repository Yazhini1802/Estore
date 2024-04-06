<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product List</title>
<style>
  .product {
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    margin-bottom: 20px;
  }
  .product img {
    max-width: 100%;
    height: auto;
    margin-bottom: 10px;
  }
</style>
</head>
<body>
<div id="productList"></div>

<script>
// Fetch data from the link
fetch('https://fakestoreapi.com/products')
  .then(response => response.json())
  .then(products => {
    const productList = document.getElementById("productList");

    // Loop through the products array
    products.forEach(product => {
      // Create elements for product
      const productDiv = document.createElement("div");
      productDiv.classList.add("product");

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

      // Append elements to productDiv
      productDiv.appendChild(title);
      productDiv.appendChild(price);
      productDiv.appendChild(description);
      productDiv.appendChild(category);
      productDiv.appendChild(image);
      productDiv.appendChild(rating);

      // Append productDiv to productList
      productList.appendChild(productDiv);
    });
  })
  .catch(error => {
    console.error('Error fetching data:', error);
  });
</script>
</body>
</html>

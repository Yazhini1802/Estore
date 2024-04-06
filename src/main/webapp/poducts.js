/**
 * 
 */
//HTMLOutputElement outputElement
let parsed=JSON.parse(json6)
   fetch('https://fakestoreapi.com/products')
   .then((res) =>  console.log(res.json()))
   .then((msg)=> console.log(msg.id,msg.title,msg.price,msg.description,msg.category))
   innerhtml
	//return res.json; 

 
   // .then(data => {
	  //data.forEach(user =>{
		  //const markup ='<li> ${user.title}</li>';
	 // });
   //  })
 .catch(error =>  console.log(error));
 
 //const Url = 'https://fakestoreapi.com/products';
	/*fetch(apiUrl)
	 .then(response => {
    if (!response.ok) {
      if (response.status === 404) {
        throw new Error('Data not found');
      } else if (response.status === 500) {
        throw new Error('Server error');
      } else {
        throw new Error('Network response was not ok');
      }
    }
    return response.json();
  })
  
  .then(data => {
	const outputElement=document.getElementById("1");
    outputElement.textContent ('data',JSON.stringify(response));
  })
  .catch(error => {
    console.error('Error:', error);
  });
  
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  </*script>
   //fetch('https://fakestoreapi.com/products')
  // .then(res => {
	//return res.json; 
	   //console.log(res);
   //  })
    //.then(data => {
	 // data.forEach(user =>{
		//  const markup ='<li> ${user.title}</li>';
	// / });
    // })
 //  catch(error =>  console.log(error));
 <*/script> 
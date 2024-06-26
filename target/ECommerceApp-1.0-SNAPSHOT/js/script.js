function add_to_cart(pid,pname,price)
{
    let cart = localStorage.getItem("cart");
    if(cart==null)
    {
        //no cart yet
        let products = [];
        let product = {productId: pid,productName: pname, productQuantity: 1,productPrice:price};
        products.push(product);
        localStorage.setItem("cart",JSON.stringify(products));
        console.log("Product is added for the first time") ;
    }
    else
    {
        //cart is already present
        let pcart=JSON.parse(cart);
        
        let oldProduct = pcart.find((item) => item.productId == pid)
            
        if(oldProduct)
        {
            //we have to increase the Quantity
            oldProduct.productQuantity=oldProduct.productQuantity+1;
            pcart.map((item)=>{
                
                if(item.productId==oldProduct.productId)
                {
                    item.productQuantity = oldProduct.productQuantity;
                }
                
            });
            localStorage.setItem("cart",JSON.stringify(pcart));
            console.log("Product quantity is increased");
        }
        else{
            //we have add the product
            let product = {productId: pid,productName: pname, productQuantity: 1,productPrice:price}
            pcart.push(product);
            localStorage.setItem("cart",JSON.stringify(pcart));
            console.log("Product is added");
            
            
        }
    }
    updateCart();
}

function getOrders(){
    let cart = localStorage.getItem("cart");
    return cart;
}

function saveOrders(){
//    let cart = localStorage.getItem("cart");
//    localStorage.setItem("orders",cart);
//    localStorage.removeItem("cart");
//    cart = localStorage.getItem("orders");
//    cart = JSON.parse(cart);
    // current time
        
    const date = new Date();

    let day = date.getDate();
    let month = date.getMonth() + 1;
    let year = date.getFullYear();

    let currentDate = `${day}-${month}-${year}`;
    console.log(currentDate); // "17-6-2022"

    // end
    
    let cart = JSON.parse(localStorage.getItem("cart"));
    let orders = JSON.parse(localStorage.getItem("orders"));
    
    let nOrders = [];

    if(orders !== null){
        orders.map((item) => { nOrders.push(item); });
    }
    if(cart !== null){
        cart.map((item) => { item.orderTime = currentDate; nOrders.push(item); });
    }
    

    localStorage.setItem("orders",JSON.stringify(nOrders));
    
    localStorage.removeItem("cart");
    
    if(nOrders === null || nOrders.length === 0){
        $(".orders-body").html("<h3>No Historyy</h3>");
    }else{
        let table = `
            <table class='table'>
            <thread class='thread-light'>
                <tr>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Time</th>
                </tr>
            </thread>
        `;

        let totalPrice=0;
        nOrders.map((item) => {
            table += `
                <tr>
                    <td> ${item.productName} </td>
                    <td> ${item.productPrice} </td>
                    <td> ${item.productQuantity} </td>
                    <td> ${item.productQuantity * item.productPrice} </td>
                    <td> ${item.orderTime} </td>
                </tr>
            `;
            totalPrice += item.productQuantity * item.productPrice;
        });
        
        table = table + `
            <tr><td colspan='5'class='text-right font-weight-bold m-5'>Total Price: ${totalPrice}</td></tr>
            </table>`;
        $(".orders-body").html(table);
    }
    updateCart();
}

function updateCart(){
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if(cart===null || cart.length === 0){
        $(".cart-items").html("(0)");
        $(".cart-body").html("<h3>Cart empty</h3>");
//        $(".checkout-btn").addClass("disabled");
        $(".checkout-btn").attr("disabled", true);
    }else{
        $(".cart-items").html(`(${cart.length})`);
        let table = `
            <table class='table'>
            <thread class='thread-light'>
                <tr>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Action</th>
                </tr>
            </thread>
        `;
        
        let totalPrice=0;
        cart.map((item) => {
            table += `
                <tr>
                    <td> ${item.productName} </td>
                    <td> ${item.productPrice} </td>
                    <td> ${item.productQuantity} </td>
                    <td> ${item.productQuantity * item.productPrice} </td>
                    <td> <button onclick='deleteItemFromCart(${item.productId})' class='btn btn-danger btn-sm'>Remove</button> </td>
                </tr>

            `;
            totalPrice += item.productQuantity * item.productPrice;
        });
        
        table = table + `
            <tr><td colspan='5'class='text-right font-weight-bold m-5'>Total Price: ${totalPrice}</td></tr>
            </table>`;
        $(".cart-body").html(table);
        $(".checkout-btn").attr("disabled", false);
    }
}

function deleteItemFromCart(pid){
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    let newCart = cart.filter((item) => item.productId !== pid);
    localStorage.setItem('cart', JSON.stringify(newCart));
    updateCart();
}

function goToCheckout(){
    window.location = "checkout.jsp";
}

function updateOrders(){
    let cart = localStorage.getItem("orders");
    cart = JSON.parse(cart);
    if(cart === null || cart.length === 0){
        $(".orders-body").html("<h3>No History</h3>");
    }else{
        let table = `
            <table class='table'>
            <thread class='thread-light'>
                <tr>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Date</th>
                </tr>
            </thread>
        `;
//        $(".order-body").html(`<h3>Here23 ${cart}</h3>` + table);
//
//
        let totalPrice=0;
        cart.map((item) => {
            table += `
                <tr>
                    <td> ${item.productName} </td>
                    <td> ${item.productPrice} </td>
                    <td> ${item.productQuantity} </td>
                    <td> ${item.productQuantity * item.productPrice} </td>
                    <td> ${item.orderTime} </td>
                </tr>
            `;
            totalPrice += item.productQuantity * item.productPrice;
        });
        
        table = table + `
            <tr><td colspan='5'class='text-right font-weight-bold m-5'>Total Price: ${totalPrice}</td></tr>
            </table>`;
        $(".orders-body").html(table);
    }
}

$(document).ready(function(){
//    saveOrders();
    updateOrders();
    updateCart();
});

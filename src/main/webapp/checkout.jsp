<%
    User user = (User)  session.getAttribute("current-user");
   if(user == null){
        session.setAttribute("message", "Login first to access checkout page");
        response.sendRedirect("login.jsp");
        return;
    }
    
//    let cartString = localStorage.getItem("cart");
//    let cart = JSON.parse(cartString);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Panel</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container">
            <div class="row mt-5">
                <!--card-->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="text-center mb-5">Your Order Items</h3>
                            <div class="cart-body"></div>
                        </div>
                    </div>
                </div>
<!--                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center mb-5">Your Order Items</h3>
                        <div class="orders-body"></div>
                    </div>
                </div>-->
                <!--user-details-->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="text-center mb-5">Your Details</h3>
                            <form>
                                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                                <input type="hidden" name="orders" value="getOrders()">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input value="<%= user.getUserEmail() %>" name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                <div class="form-group">
                                    <label for="name">Your Name</label>
                                    <input value="<%= user.getUserName() %>" name="user_name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter Name">
                                </div>
                                <div class="form-group">
                                    <label for="name">Your Contact Number</label>
                                    <input value="<%= user.getUserPhone() %>" name="user_Phone" type="number" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter Contact Number">
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlTextarea1">Your Shipping Address</label>
                                    <textarea value="<%= user.getUserAddress()%>" name="user_address" class="form-control" id="exampleFormControlTextarea1" placeholder="Enter your address" rows="3"></textarea>
                                </div>
                                
                            </form>
                            <div class="container text-center">
                                <button class="btn btn-outline-success" onclick="saveOrders()">Order Now!</button>
                                <button class="btn btn-primary"><a href="index.jsp" class="text-white">Continue Shopping</a></button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="components/common_modals.jsp" %>
    </body>
</html>

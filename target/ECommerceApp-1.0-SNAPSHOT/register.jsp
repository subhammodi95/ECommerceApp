
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid">
            <div class="row my-5">
                <div class="col-md-4 offset-md-4">
                    <div class="card">
                        <%@include file="components/message.jsp" %>
                        <div class="card-header  custom-bg text-white">
                            <h3 class="text-center">Sign Up here</h3>
                        </div>
                        <div class="card-body px-5">
                            <!--<h3 class="text-center my-3">Sign Up here</h3>-->
                            <form action="RegisterServlet" method="post">
                                <div class="form-group">
                                    <label for="name">User Name</label>
                                    <input type="text" name="user_name" class="form-control" id="name" placeholder="Enter Here">
                                </div>

                                <div class="form-group">
                                    <label for="email">User Email</label>
                                    <input type="email" name="user_email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter Email">
                                </div>

                                <div class="form-group">
                                    <label for="password">User Password</label>
                                    <input type="password" name="user_password" class="form-control" id="password" placeholder="Enter password">
                                </div>

                                <div class="form-group">
                                    <label for="phone">User Phone</label>
                                    <input type="number" name="user_phone" class="form-control" id="phone" placeholder="Enter Here">
                                </div>

                                <div class="form-group">
                                    <label for="address">User Address</label>
                                    <textarea style="height: 100px" name="user_address" class="form-control" placeholder="Enter Your Address">   
                                    </textarea>
                                </div>
                                <a href="login.jsp" class="text-center d-block mb-2">Already Signed In? Login here</a>

                                <div class="container text-center">
                                    <button class="btn btn-outline-success">Register</button>
                                    <button class="btn btn-outline-warning">Reset</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        
    </body>
</html>

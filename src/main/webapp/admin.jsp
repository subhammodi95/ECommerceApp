<%@page import="java.util.Map"%>
<%@page import="com.mycompany.ecommerceapp.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.ecommerceapp.entities.Category"%>
<%@page import="com.mycompany.ecommerceapp.helper.FactoryProvider"%>
<%@page import="com.mycompany.ecommerceapp.dao.CategoryDao"%>
<%@page import="com.mycompany.ecommerceapp.entities.User"%>
<%
   User user = (User)  session.getAttribute("current-user");
   if(user == null){
        session.setAttribute("message", "Login first");
        response.sendRedirect("login.jsp");
        return;
    }else{
        if(user.getUserType().equals("normal")){
            session.setAttribute("message", "You are not admin. You don't have access to this page");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>


<%
    CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cDao.getCategories();
    
    Map<String, Long> m = Helper.getCounts(FactoryProvider.getFactory());
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>
        <style>
            .admin .card{
                border: 1px solid #673ab7;
            }

            .admin .card:hover{
                background: #e2e2e2;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container admin">
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>
            </div>
            <div class="row mt-3">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/users5.png" alt="user_icon"/>
                            </div>
                            <h1><%= m.get("userCount") %></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/download.jpg" alt="user_icon"/>
                            </div>
                            <h1><%= list.size() %></h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/images.png" alt="user_icon"/>
                            </div>
                            <h1><%= m.get("productCount") %></h1>
                            <h1 class="text-uppercase text-muted">Products</h1>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/download (1).jpg" alt="user_icon"/>
                            </div>
                            <!--<h1>1234</h1>-->
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/3180105.png" alt="user_icon"/>
                            </div>
                            <!--<h1>1234</h1>-->
                            <h1 class="text-uppercase text-muted">Add Product</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--add category modal st-->

        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header custom-bg text-white">
                <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                  <form action="ProductOperationServlet" method="post">
                      <input type="hidden" name="operation" value="addCategory">
                      <div class="form-group">
                          <input type="text" class="form-control" name="catTitle" placeholder="Enter Category Title" required />
                      </div>
                      <div class="form-group">
                          <textarea style="height: 300px" class="form-control" placeholder="Enter Category Description" name="catDescription" required></textarea>
                      </div>
                      <div class="container text-center">
                          <button class="btn btn-outline-success">Add Category</button>
                          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                      </div>
                  </form>
              </div>
            </div>
          </div>
        </div>

        <!--add category modal end-->
        
        <!--add product modal st-->

        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header custom-bg text-white">
                <h5 class="modal-title" id="exampleModalLabel">Fill Product Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                  <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                      <input type="hidden" name="operation" value="addProduct">
                      <div class="form-group">
                          <input type="text" class="form-control" name="pName" placeholder="Enter Product Title" required />
                      </div>
                      <div class="form-group">
                          <textarea style="height: 150px" class="form-control" placeholder="Enter Product Description" name="pDesc" required></textarea>
                      </div>
                      <div class="form-group">
                          <input type="number" class="form-control" name="pPrice" placeholder="Enter Product Price" required />
                      </div>
                      <div class="form-group">
                          <input type="number" class="form-control" name="pDiscount" placeholder="Enter Product Discount" required />
                      </div>
                      <div class="form-group">
                          <input type="number" class="form-control" name="pQuantity" placeholder="Enter Product Quantity" required />
                      </div>
                      
                      <!--category drop down-->
                      
                      <div class="form-group">
                          <select name="catId" class="form-control" id="">
                                <%
                                    for(Category c:list){
                                %>
                                <option value="<%= c.getCategoryId() %>"><%= c.getCategoryTitle() %></option>
                                <%} %>
                          </select>
                      </div>
                      
                      
                      <!--product file-->
                      <div class="form-group">
                          <label for="pPic">Select Picture of Product</label>
                          <br>
                          <input type="file" id="pPic" class="form-control" name="pPic" required />
                      </div>
                      
                      <div class="container text-center">
                          <button class="btn btn-outline-success">Add Product</button>
                          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                      </div>
                  </form>
              </div>
            </div>
          </div>
        </div>

        <!--add product modal end-->
        <%@include file="components/common_modals.jsp" %>
    </body>
</html>

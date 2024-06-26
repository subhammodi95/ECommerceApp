<%-- 
    Document   : index
    Created on : 12-May-2023, 11:54:02 PM
    Author     : I527904
--%>

<%@page import="com.mycompany.ecommerceapp.helper.Helper"%>
<%@page import="com.mycompany.ecommerceapp.entities.Category"%>
<%@page import="com.mycompany.ecommerceapp.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.ecommerceapp.entities.Product"%>
<%@page import="com.mycompany.ecommerceapp.dao.ProductDao"%>
<%@page import="com.mycompany.ecommerceapp.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ECommerceApp-Home</title>
        <%@include file="components/common_css_js.jsp" %>
        <style>
            .list-group-item.active{
                background: #673ab7!important;
                border-color: #673ab7!important;
            }
            
            .discount-label{
                font-size: 10px!important;
                font-style: italic!important;
                /*text-decoration: line-through!important;*/ 
            }

            .product-card:hover{
                background: #e2e2e2;
                cursor:pointer; 
            }
        </style>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid" >
            <div class="row mt-3 mx-2" >

                <%               
                    String cat = request.getParameter("category");
                    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
                     List<Product> list = null;
                
                    if(cat == null || cat.trim().equals("all")){
                        list=dao.getAllProducts();
                    }
                    else{
                        int cid = Integer.parseInt(cat.trim());
                        list=dao.getAllProductsById(cid);
                    }
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> clist = cdao.getCategories();
                %>


                <!-- show categories -->
                <div class="col-md-2">
                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">All Products</a>

                        <%
                            for (Category c : clist) {
                        %>
                        <a href="index.jsp?category=<%= c.getCategoryId() %>" class="list-group-item list-group-item-action"><%= c.getCategoryTitle()%></a>
                        <%}%>
                    </div>
                </div>    
                <!-- show products -->
                <div class="col-md-9">
                    <!-- row -->
                    <div class="row mt-4">
                        <!-- col:12 -->
                        <div class="col-md-12">
                            <div class="card-columns">

                                <!-- Traversing products -->
                                <%
                                    for (Product p : list) {
                                %>

                                <div class="card product-card">
                                    <div class="container text-center">
                                        <img src="img/products/<%= p.getpPhoto()%>" style="max-height: 200px;max-width: 100%;width: auto;"  class="card-img-top m-2"   alt="Card image">
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= p.getpName()%></h5>

                                        <p class="card-text">

                                            <%= Helper.get10Words(p.getpDesc())%>
<!--                                            <a href="#">more</a>-->

                                        </p>
                                    </div>
                                    <div class="card-footer text-center">
                                        <button class="btn custom-bg text-white" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName() %>',<%= p.getPriceAfterApplyingDiscount()%>)">Add to Cart</button>
                                        <button class="btn btn-outline-success"> &#8377; <%= p.getPriceAfterApplyingDiscount() %> /- <span class="text-secondary discount-label"> &#8377; <%= p.getpPrice() %> , <%= p.getpDiscount() %> off</span> </button>
                                    </div>
                                </div>

                                <% }
                                    if(list.size()==0)
                                    {
                                    out.println("<h3>No items in this category <h3>");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <%@include file="components/common_modals.jsp" %>
    </body>
</html>

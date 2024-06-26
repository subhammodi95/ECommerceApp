<%
    User user = (User)  session.getAttribute("current-user");
   if(user == null){
        session.setAttribute("message", "Login first to access History page");
        response.sendRedirect("login.jsp");
        return;
    }
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
            <!--card-->
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center mb-5">Your History</h3>
                    <div class="orders-body"></div>
                </div>
            </div>
        </div>
        <%@include file="components/common_modals.jsp" %>
    </body>
</html>


package com.mycompany.ecommerceapp.servlets;

import com.mycompany.ecommerceapp.dao.CategoryDao;
import com.mycompany.ecommerceapp.dao.ProductDao;
import com.mycompany.ecommerceapp.entities.Category;
import com.mycompany.ecommerceapp.entities.Product;
import com.mycompany.ecommerceapp.helper.FactoryProvider;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String op = request.getParameter("operation");
            if(op.trim().equals("addCategory")){
                String title = request.getParameter("catTitle");
                String description = request.getParameter("catDescription");
                
                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(description);
                
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.save(category, null, null);
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", title + " Category Added");
                response.sendRedirect("admin.jsp");
                return;
            }else if(op.trim().equals("addProduct")){
                String pName = request.getParameter("pName");
                String pDesc = request.getParameter("pDesc");
                int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));
                Part part =request.getPart("pPic");

                Product p = new Product();
                p.setpName(pName);
                p.setpDesc(pDesc);
                p.setpPrice(pPrice);
                p.setpDiscount(pDiscount);
                p.setpQuantity(pQuantity);
                p.setpPhoto(part.getSubmittedFileName());
                
                //get category by id
                CategoryDao cdoa = new CategoryDao(FactoryProvider.getFactory());
                Category category= cdoa.getCategoryById(catId);

                p.setCategory(category);
                //product save
                ProductDao pdao= new ProductDao(FactoryProvider.getFactory());
                pdao.save(null, null, p);

                //pic upload

                //find out path to upload photo
                String path = request.getRealPath("img")+ File.separator + "products" + File.separator + part.getSubmittedFileName();
                System.out.println(path);
                //uploading code

                try {


                    FileOutputStream fos = new FileOutputStream(path);
                    InputStream is = part.getInputStream();
                    //reading data

                    byte[] data = new byte[is.available()];

                    is.read(data);

                    //writing the data
                    fos.write(data);
                    fos.close();

                }
                catch (Exception e) {
                    e.printStackTrace();
                }

                System.out.println("Product Added");
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", pName + " Product is Added Successfully");
                response.sendRedirect("admin.jsp");
                return;
                //uploading code
            }
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

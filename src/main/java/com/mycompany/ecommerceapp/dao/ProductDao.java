package com.mycompany.ecommerceapp.dao;

import com.mycompany.ecommerceapp.entities.Category;
import com.mycompany.ecommerceapp.entities.Orders;
import com.mycompany.ecommerceapp.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProductDao implements Components{
    private SessionFactory factory;


    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public int save(Category cat, Orders ord, Product product)
    {
        int f=0;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();


            session.save(product);

            tx.commit();
            session.close();
            f=1;


        } catch (Exception e) {
            e.printStackTrace();
            f=0;
        }
        return f;
    }

    //get all products
    public List<Product> getAllProducts()
    {
        Session s = this.factory.openSession();
        Query query = s.createQuery("From Product");
        List<Product> list = query.list();
        return list;
    }
    
    //get all products of given category
    public List<Product> getAllProductsById(int cid)
    {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product as p where p.category.categoryId =: id");
        query.setParameter("id", cid);
        List<Product> list = query.list();
        return list;
    }


    @Override
    public List<Category> getCategories() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Category getCategoryById(int cid) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    
}

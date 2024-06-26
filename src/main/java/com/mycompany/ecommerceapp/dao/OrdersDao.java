package com.mycompany.ecommerceapp.dao;

//import com.mycompany.ecommerceapp.entities.Category;
import com.mycompany.ecommerceapp.entities.Category;
import com.mycompany.ecommerceapp.entities.Orders;
import com.mycompany.ecommerceapp.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class OrdersDao implements Components{
    private SessionFactory factory;

    public OrdersDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public int save(Category cat, Orders ord, Product p){
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int ordId = (int) session.save(ord);
        tx.commit();
        session.close();
        return ordId;
    }
    
    public Orders getOrdersById(int cid){
        Orders ord = null;
        try{
            Session session = this.factory.openSession();
            ord = session.get(Orders.class, cid);
            session.close();
        }catch(Exception e){ e.printStackTrace(); }
        return ord;
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

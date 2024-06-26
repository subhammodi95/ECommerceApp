
package com.mycompany.ecommerceapp.dao;

import com.mycompany.ecommerceapp.entities.Category;
import com.mycompany.ecommerceapp.entities.Orders;
import com.mycompany.ecommerceapp.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;




public class CategoryDao implements Components{
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    @Override
    public int save(Category cat, Orders ord, Product p){
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId = (int) session.save(cat);
        tx.commit();
        session.close();
        return catId;
    }
    
    @Override
    public List<Category> getCategories(){
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Category");
        List<Category> list = query.list();
        return list;
    }
    
    @Override
    public Category getCategoryById(int cid){
        Category cat = null;
        try{
            Session session = this.factory.openSession();
            cat = session.get(Category.class, cid);
            session.close();
        }catch(Exception e){ e.printStackTrace(); }
        return cat;
    }

    
}

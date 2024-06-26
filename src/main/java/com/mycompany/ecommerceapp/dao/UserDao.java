
package com.mycompany.ecommerceapp.dao;

import com.mycompany.ecommerceapp.entities.User;
//import javax.persistence.TypedQuery;
import org.hibernate.*;

//import org.hibernate.SessionFactory;

public class UserDao {
    private final SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    //get user by email and password
    public User getUserByEmailAndPassword(String email, String password){
        User user = null;
        try{
            String query = "from User where userEmail =: e and userPassword =: p";
            
            
            Session session = this.factory.openSession();
            Query q;
//            Session hbSesion = HibernatePersistenceHandler.getSessionFactory().openSession();
            q = session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p", password);
            
            user = (User) q.uniqueResult();
            session.close();
        }catch(HibernateException e){
            e.printStackTrace();
        }
        System.out.println(user);
        return user;
    }
}

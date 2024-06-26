/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.ecommerceapp.dao;

import com.mycompany.ecommerceapp.entities.Category;
import com.mycompany.ecommerceapp.entities.Orders;
import com.mycompany.ecommerceapp.entities.Product;
import java.util.List;

/**
 *
 * @author I527904
 */
interface Components {
    abstract int save(Category cat, Orders ord, Product p);
    abstract List<Category> getCategories();
    public Category getCategoryById(int cid);
}

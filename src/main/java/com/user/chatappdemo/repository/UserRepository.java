package com.user.chatappdemo.repository;

import com.user.chatappdemo.entity.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<User> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM User", User.class)
                .getResultList();
    }
}

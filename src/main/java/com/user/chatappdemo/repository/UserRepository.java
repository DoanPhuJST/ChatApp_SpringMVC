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

    public User findById(int id) {
        return sessionFactory.getCurrentSession()
                .get(User.class, id);
    }

    public User save(User user) {
        sessionFactory.getCurrentSession().saveOrUpdate(user);
        return user;
    }

    public void deleteById(int id) {
        User user = findById(id);
        if (user != null) {
            sessionFactory.getCurrentSession().delete(user);
        }
    }
}

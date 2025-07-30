package com.user.chatappdemo.repository;

import com.user.chatappdemo.entity.Post;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PostRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<Post> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Post ORDER BY createAt DESC", Post.class)
                .getResultList();
    }

    public Post findById(int id) {
        return sessionFactory.getCurrentSession()
                .get(Post.class, id);
    }

    public List<Post> findByUserId(int userId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Post WHERE user.id = :userId ORDER BY createAt DESC", Post.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    public Post save(Post post) {
        sessionFactory.getCurrentSession().saveOrUpdate(post);
        return post;
    }

    public void deleteById(int id) {
        Post post = findById(id);
        if (post != null) {
            sessionFactory.getCurrentSession().delete(post);
        }
    }
}

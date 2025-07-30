package com.user.chatappdemo.repository;

import com.user.chatappdemo.entity.Follow;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FollowRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public List<Follow> findFollowersByUserId(int userId) {
        try {
            return sessionFactory.getCurrentSession()
                    .createQuery("FROM Follow f WHERE f.followed.id = :userId", Follow.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Error finding followers for user " + userId + ": " + e.getMessage());
            return List.of();
        }
    }

    public List<Follow> findFollowingsByUserId(int userId) {
        try {
            return sessionFactory.getCurrentSession()
                    .createQuery("FROM Follow f WHERE f.follower.id = :userId", Follow.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } catch (Exception e) {
            System.err.println("Error finding followings for user " + userId + ": " + e.getMessage());
            return List.of();
        }
    }

    public Follow save(Follow follow) {
        sessionFactory.getCurrentSession().saveOrUpdate(follow);
        return follow;
    }

    public void delete(Follow follow) {
        sessionFactory.getCurrentSession().delete(follow);
    }

    public Follow findByFollowerAndFollowed(int followerId, int followedId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Follow WHERE follower.id = :followerId AND followed.id = :followedId", Follow.class)
                .setParameter("followerId", followerId)
                .setParameter("followedId", followedId)
                .uniqueResult();
    }
}

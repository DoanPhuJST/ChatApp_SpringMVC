<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Người dùng - Chat App Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .user-card {
            transition: transform 0.2s;
            border: 1px solid #dee2e6;
        }
        .user-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .user-avatar {
            width: 80px;
            height: 80px;
            background-color: #007bff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 32px;
            margin: 0 auto;
        }
        .role-badge {
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky pt-3">
                    <h5 class="text-center mb-4">
                        <i class="fas fa-comments"></i> Chat App Demo
                    </h5>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/web/">
                                <i class="fas fa-home"></i> Trang chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/web/posts">
                                <i class="fas fa-newspaper"></i> Tất cả bài viết
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/web/users">
                                <i class="fas fa-users"></i> Người dùng
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-users"></i> Danh sách người dùng
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <span class="badge bg-primary">Tổng: ${fn:length(users)} người dùng</span>
                        </div>
                    </div>
                </div>

                <!-- Error/Success Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Users List -->
                <div class="row">
                    <c:choose>
                        <c:when test="${empty users}">
                            <div class="col-12">
                                <div class="alert alert-info text-center">
                                    <i class="fas fa-info-circle"></i> Chưa có người dùng nào trong hệ thống.
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${users}" var="user">
                                <div class="col-lg-4 col-md-6 mb-4">
                                    <div class="card user-card h-100">
                                        <div class="card-body text-center">
                                            <div class="user-avatar mb-3">
                                                <c:choose>
                                                    <c:when test="${not empty user.userName}">
                                                        ${fn:toUpperCase(fn:substring(user.userName, 0, 1))}
                                                    </c:when>
                                                    <c:otherwise>U</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <h5 class="card-title">
                                                <c:choose>
                                                    <c:when test="${not empty user.userName}">${user.userName}</c:when>
                                                    <c:otherwise>Người dùng #${user.id}</c:otherwise>
                                                </c:choose>
                                            </h5>
                                            <p class="card-text">
                                                <span class="badge role-badge ${user.role eq 'ADMIN' ? 'bg-danger' : 'bg-primary'}">${user.role}</span>
                                            </p>
                                            <p class="card-text">
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar-alt"></i>
                                                    Tham gia: ${user.createAt}
                                                </small>
                                            </p>
                                            <div class="btn-group" role="group">
                                                <a href="${pageContext.request.contextPath}/web/profile/${user.id}" class="btn btn-outline-primary btn-sm">
                                                    <i class="fas fa-user"></i> Profile
                                                </a>
                                                <a href="${pageContext.request.contextPath}/web/posts/user/${user.id}" class="btn btn-outline-secondary btn-sm">
                                                    <i class="fas fa-newspaper"></i> Bài viết
                                                </a>
                                            </div>
                                        </div>
                                        <div class="card-footer bg-light">
                                            <small class="text-muted d-flex justify-content-between">
                                                <span><i class="fas fa-hashtag"></i> ID: ${user.id}</span>
                                                <span><i class="fas fa-clock"></i> ${user.createAt}</span>
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

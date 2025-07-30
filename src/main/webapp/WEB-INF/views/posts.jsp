<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tất cả bài viết - Chat App Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .post-card {
            border-left: 4px solid #007bff;
            margin-bottom: 20px;
        }
        .user-avatar {
            width: 50px;
            height: 50px;
            background-color: #007bff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 18px;
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/web/posts">
                                <i class="fas fa-newspaper"></i> Tất cả bài viết
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/web/users">
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
                        <i class="fas fa-newspaper"></i> Tất cả bài viết
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <span class="badge bg-primary">Tổng: ${fn:length(posts)} bài viết</span>
                        </div>
                    </div>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Posts List -->
                <div class="row">
                    <div class="col-12">
                        <c:choose>
                            <c:when test="${empty posts}">
                                <div class="alert alert-info text-center">
                                    <i class="fas fa-info-circle"></i> Chưa có bài viết nào được đăng.
                                    <br><br>
                                    <p class="text-muted">Hãy truy cập profile của người dùng để tạo bài viết mới.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${posts}" var="post">
                                    <div class="card post-card">
                                        <div class="card-header">
                                            <div class="d-flex align-items-center justify-content-between">
                                                <div class="d-flex align-items-center">
                                                    <div class="user-avatar me-3">
                                                        <c:choose>
                                                            <c:when test="${not empty post.username}">
                                                                ${fn:toUpperCase(fn:substring(post.username, 0, 1))}
                                                            </c:when>
                                                            <c:otherwise>U</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-0">
                                                            <c:choose>
                                                                <c:when test="${not empty post.username}">${post.username}</c:when>
                                                                <c:otherwise>Người dùng</c:otherwise>
                                                            </c:choose>
                                                        </h6>
                                                        <small class="text-muted">${post.createAt}</small>
                                                    </div>
                                                </div>
                                                <div class="dropdown">
                                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/web/profile/${post.userId}">
                                                            <i class="fas fa-user"></i> Xem profile
                                                        </a></li>
                                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/web/posts/user/${post.userId}">
                                                            <i class="fas fa-newspaper"></i> Bài viết của người này
                                                        </a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <h5 class="card-title">${post.title}</h5>
                                            <p class="card-text">${post.body}</p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="badge ${post.status eq 'PUBLIC' ? 'bg-success' : 'bg-warning text-dark'}">
                                                    <i class="fas fa-${post.status eq 'PUBLIC' ? 'globe' : 'lock'}"></i>
                                                    ${post.status eq 'PUBLIC' ? 'Công khai' : 'Riêng tư'}
                                                </span>
                                                <small class="text-muted">ID: ${post.id}</small>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

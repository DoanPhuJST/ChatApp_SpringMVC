<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Chat App Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            background-color: #007bff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 48px;
            margin: 0 auto;
        }
        .stat-card {
            border: none;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .post-card {
            border-left: 4px solid #007bff;
            margin-bottom: 15px;
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/web/users">
                                <i class="fas fa-users"></i> Người dùng
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <!-- Profile Header -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body text-center">
                                <div class="profile-avatar mb-3">
                                    <c:choose>
                                        <c:when test="${not empty user.userName}">
                                            ${fn:toUpperCase(fn:substring(user.userName, 0, 1))}
                                        </c:when>
                                        <c:otherwise>U</c:otherwise>
                                    </c:choose>
                                </div>
                                <h2>${not empty user.userName ? user.userName : 'Người dùng'}</h2>
                                <p class="text-muted">
                                    <span class="badge ${user.role eq 'ADMIN' ? 'bg-danger' : 'bg-primary'}">${user.role}</span>
                                </p>
                                <p class="text-muted">
                                    <i class="fas fa-calendar-alt"></i> Tham gia từ: ${user.createAt}
                                </p>

                                <!-- Action buttons -->
                                <div class="mt-3">
                                    <a href="${pageContext.request.contextPath}/web/create-post?userId=${user.id}" class="btn btn-primary me-2">
                                        <i class="fas fa-plus"></i> Tạo bài viết
                                    </a>
                                    <a href="${pageContext.request.contextPath}/web/user/edit/${user.id}" class="btn btn-warning me-2">
                                        <i class="fas fa-edit"></i> Chỉnh sửa
                                    </a>
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row mt-4">
                    <div class="col-md-4 mb-3">
                        <div class="card stat-card">
                            <div class="card-body text-center">
                                <i class="fas fa-newspaper fa-2x mb-2"></i>
                                <h3>${fn:length(posts)}</h3>
                                <p class="mb-0">Bài viết</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card stat-card">
                            <div class="card-body text-center">
                                <i class="fas fa-users fa-2x mb-2"></i>
                                <h3>${fn:length(followers)}</h3>
                                <p class="mb-0">Người theo dõi</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card stat-card">
                            <div class="card-body text-center">
                                <i class="fas fa-user-friends fa-2x mb-2"></i>
                                <h3>${fn:length(followings)}</h3>
                                <p class="mb-0">Đang theo dõi</p>
                            </div>
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

                <!-- Posts Section -->
                <div class="row mt-4">
                    <div class="col-12">
                        <h4><i class="fas fa-newspaper"></i> Bài viết của ${user.userName}</h4>
                        <hr>
                        <c:choose>
                            <c:when test="${empty posts}">
                                <div class="alert alert-info text-center">
                                    <i class="fas fa-info-circle"></i> Người dùng này chưa có bài viết nào.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${posts}" var="post">
                                    <div class="card post-card">
                                        <div class="card-body">
                                            <h5 class="card-title">${post.title}</h5>
                                            <p class="card-text">${post.body}</p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="badge ${post.status eq 'PUBLIC' ? 'bg-success' : 'bg-warning text-dark'}">
                                                    <i class="fas fa-${post.status eq 'PUBLIC' ? 'globe' : 'lock'}"></i>
                                                    ${post.status eq 'PUBLIC' ? 'Công khai' : 'Riêng tư'}
                                                </span>
                                                <small class="text-muted">${post.createAt}</small>
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

    <!-- Delete User Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="deleteModalLabel">
                        <i class="fas fa-exclamation-triangle"></i> Xác nhận xóa người dùng
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Cảnh báo:</strong> Bạn có chắc chắn muốn xóa người dùng <strong>${user.userName}</strong>?</p>
                    <p class="text-danger">
                        <i class="fas fa-info-circle"></i>
                        Hành động này sẽ xóa vĩnh viễn tất cả dữ liệu của người dùng bao gồm bài viết và mối quan hệ theo dõi.
                        <strong>Không thể hoàn tác!</strong>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Hủy bỏ
                    </button>
                    <form method="post" action="${pageContext.request.contextPath}/web/user/delete/${user.id}" style="display: inline;">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash"></i> Xóa người dùng
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

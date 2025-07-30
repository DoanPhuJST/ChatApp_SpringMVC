<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa người dùng - Chat App Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #f8f9fa;
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
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-user-edit"></i> Chỉnh sửa người dùng
                    </h1>
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

                <!-- Edit User Form -->
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-edit"></i> Thông tin người dùng
                                </h5>
                            </div>
                            <div class="card-body">
                                <form method="post" action="${pageContext.request.contextPath}/web/user/edit/${user.id}">
                                    <div class="mb-3">
                                        <label for="id" class="form-label">
                                            <i class="fas fa-hashtag"></i> ID
                                        </label>
                                        <input type="number" class="form-control" id="id" name="id" value="${user.id}" readonly>
                                        <div class="form-text">ID không thể thay đổi</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="userName" class="form-label">
                                            <i class="fas fa-user"></i> Tên người dùng
                                        </label>
                                        <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" required>
                                        <div class="form-text">Nhập tên người dùng mới</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="role" class="form-label">
                                            <i class="fas fa-user-tag"></i> Vai trò
                                        </label>
                                        <select class="form-select" id="role" name="role" required>
                                            <option value="">-- Chọn vai trò --</option>
                                            <option value="USER" ${user.role eq 'USER' ? 'selected' : ''}>Người dùng</option>
                                            <option value="ADMIN" ${user.role eq 'ADMIN' ? 'selected' : ''}>Quản trị viên</option>
                                        </select>
                                        <div class="form-text">Chọn vai trò của người dùng</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="createAt" class="form-label">
                                            <i class="fas fa-calendar-alt"></i> Ngày tạo
                                        </label>
                                        <input type="text" class="form-control" id="createAt" value="${user.createAt}" readonly>
                                        <div class="form-text">Ngày tạo tài khoản không thể thay đổi</div>
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/web/profile/${user.id}" class="btn btn-secondary me-md-2">
                                            <i class="fas fa-times"></i> Hủy bỏ
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Lưu thay đổi
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

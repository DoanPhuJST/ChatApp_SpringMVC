<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo bài viết - Chat App Demo</title>
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
                        <i class="fas fa-plus"></i> Tạo bài viết mới
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

                <!-- Create Post Form -->
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-edit"></i> Thông tin bài viết
                                </h5>
                            </div>
                            <div class="card-body">
                                <form method="post" action="${pageContext.request.contextPath}/web/create-post">
                                    <!-- Hidden field for userId -->
                                    <input type="hidden" name="userId" value="${param.userId}">

                                    <div class="mb-3">
                                        <label class="form-label">
                                            <i class="fas fa-user"></i> Người tạo bài viết
                                        </label>
                                        <div class="form-control-plaintext bg-light p-2 rounded">
                                            <strong>User ID: ${param.userId}</strong>
                                            <div class="form-text">Bài viết sẽ được tạo bởi người dùng này</div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="title" class="form-label">
                                            <i class="fas fa-heading"></i> Tiêu đề
                                        </label>
                                        <input type="text" class="form-control" id="title" name="title" required>
                                        <div class="form-text">Nhập tiêu đề cho bài viết của bạn</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="body" class="form-label">
                                            <i class="fas fa-align-left"></i> Nội dung
                                        </label>
                                        <textarea class="form-control" id="body" name="body" rows="6" required></textarea>
                                        <div class="form-text">Viết nội dung chi tiết cho bài viết</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="status" class="form-label">
                                            <i class="fas fa-eye"></i> Trạng thái hiển thị
                                        </label>
                                        <select class="form-select" id="status" name="status" required>
                                            <option value="">-- Chọn trạng thái --</option>
                                            <option value="PUBLIC" selected>Công khai (Public)</option>
                                            <option value="PRIVATE">Riêng tư (Private)</option>
                                        </select>
                                        <div class="form-text">Chọn ai có thể xem bài viết này</div>
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/web/profile/${param.userId}" class="btn btn-secondary me-md-2">
                                            <i class="fas fa-times"></i> Hủy bỏ
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Tạo bài viết
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

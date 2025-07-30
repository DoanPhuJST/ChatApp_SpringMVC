<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi - Chat App Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card border-danger">
                    <div class="card-header bg-danger text-white text-center">
                        <h1 class="display-1">
                            <i class="fas fa-exclamation-triangle"></i>
                        </h1>
                        <h4 class="card-title mb-0">Đã xảy ra lỗi</h4>
                    </div>
                    <div class="card-body text-center">
                        <p class="card-text">Xin lỗi, đã có lỗi xảy ra khi xử lý yêu cầu của bạn.</p>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                <strong>Chi tiết lỗi:</strong><br>
                                ${error}
                            </div>
                        </c:if>

                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/web/" class="btn btn-primary me-2">
                                <i class="fas fa-home"></i> Về trang chủ
                            </a>
                            <a href="${pageContext.request.contextPath}/web/posts" class="btn btn-outline-primary me-2">
                                <i class="fas fa-newspaper"></i> Xem bài viết
                            </a>
                            <a href="${pageContext.request.contextPath}/web/users" class="btn btn-outline-secondary">
                                <i class="fas fa-users"></i> Xem người dùng
                            </a>
                        </div>
                    </div>
                    <div class="card-footer text-muted text-center">
                        <small>
                            <i class="fas fa-clock"></i>
                            Thời gian: <%= new java.util.Date() %>
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

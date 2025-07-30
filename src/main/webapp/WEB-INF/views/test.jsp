<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Page - Chat App Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h4 class="card-title mb-0">
                            <i class="fas fa-check-circle"></i> Spring MVC Test Page
                        </h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty message}">
                            <div class="alert alert-success">
                                <i class="fas fa-info-circle"></i> ${message}
                            </div>
                        </c:if>

                        <h5>Thông tin System:</h5>
                        <table class="table table-striped">
                            <tr>
                                <td><strong>Context Path:</strong></td>
                                <td>${pageContext.request.contextPath}</td>
                            </tr>
                            <tr>
                                <td><strong>Server Info:</strong></td>
                                <td>${pageContext.servletContext.serverInfo}</td>
                            </tr>
                            <tr>
                                <td><strong>Request URL:</strong></td>
                                <td>${pageContext.request.requestURL}</td>
                            </tr>
                            <tr>
                                <td><strong>Session ID:</strong></td>
                                <td>${pageContext.session.id}</td>
                            </tr>
                            <tr>
                                <td><strong>Current Time:</strong></td>
                                <td><%= new java.util.Date() %></td>
                            </tr>
                        </table>

                        <h5>Framework Status:</h5>
                        <ul class="list-group">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-cog"></i> DispatcherServlet</span>
                                <span class="badge bg-success rounded-pill">OK</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-eye"></i> View Resolver</span>
                                <span class="badge bg-success rounded-pill">OK</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-file-code"></i> JSP Rendering</span>
                                <span class="badge bg-success rounded-pill">OK</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-tags"></i> JSTL Tags</span>
                                <span class="badge bg-success rounded-pill">OK</span>
                            </li>
                        </ul>

                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/web/" class="btn btn-primary">
                                <i class="fas fa-home"></i> Về trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

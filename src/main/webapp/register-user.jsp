<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="com.svalero.wdyride.dao.CustomerDao" %>
<%@ page import="com.svalero.wdyride.domain.Customer" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<main class="container my-5">
    <h1>Register new user</h1>

    <form class="row gy-3 gx-3 align-items-center" action="register-user" method="post" enctype="multipart/form-data" novalidate>
        <div class="col-md-6">
            <label class="form-label" for="FIRST_NAME">First Name</label>
            <input type="text" name="FIRST_NAME" class="form-control" id="FIRST_NAME" placeholder="Peter" required>
        </div>
        <div class="col-md-6">
            <label class="form-label" for="LAST_NAME">Last Name</label>
            <input type="text" name="LAST_NAME" class="form-control" id="LAST_NAME" placeholder="Lincoln" required>
        </div>
        <div class="col-md-6">
            <label class="form-label" for="USERNAME">Username</label>
            <input type="text" name="USERNAME" class="form-control" id="USERNAME" placeholder="PeterLiN" required>
        </div>
        <div class="col-md-6">
            <label class="form-label" for="PASSWORD">Password</label>
            <input type="password" name="PASSWORD" class="form-control" id="PASSWORD" placeholder="********" required>
        </div>
        <br>
        <div class="col-md-12">
            <button class="btn btn-primary mt-3" type="submit">Register</button>
        </div>
    </form>
    <div id="result"></div>
</main>

<%@include file="includes/footer.jsp"%>

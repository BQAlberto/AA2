<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>What Do You Ride?</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

</head>

    <%
    HttpSession currentSession = request.getSession();
    String ROLE = "ANONYMOUS";
    int CUSTOMER_ID  ;
    if (currentSession.getAttribute("ROLE") != null) {
        ROLE = currentSession.getAttribute("ROLE").toString();
    }
    if (currentSession.getAttribute("CUSTOMER_ID") != null) {
        CUSTOMER_ID = Integer.parseInt(currentSession.getAttribute("CUSTOMER_ID").toString());
    }else {CUSTOMER_ID=0;}
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="index.jsp">What Do You Ride</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <%
                if (ROLE.equals("ANONYMOUS")) {
            %>
            <li class="nav-item">
                <a class="nav-link" href="login.jsp">Login</a>
            </li>
            <%
                } else {
            %>
            <li class="nav-item">
                <a class="nav-link" href="logout">Logout</a>
            </li>
            <%
                }
            %>
            <li class="nav-item">
                <a class="nav-link" href="register-user.jsp">Register</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Contact</a>
            </li>
        </ul>
    </div>
</nav>


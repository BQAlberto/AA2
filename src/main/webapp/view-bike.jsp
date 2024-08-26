<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="com.svalero.wdyride.dao.BikeDao" %>
<%@ page import="com.svalero.wdyride.domain.Bike" %>

<%@include file="includes/header.jsp"%>

<main>
    <%
        String SERIAL_NUMBER = request.getParameter("SERIAL_NUMBER");

        Database.connect();
        Bike bike = Database.jdbi.withExtension(BikeDao.class, dao -> dao.getBike(SERIAL_NUMBER));
    %>
    <div class="d-flex justify-content-center align-items-center" style="min-height: 50vh;">
        <div class="card border border-3 rounded" style="width: 18rem;">
            <img src="..." class="card-img-top" alt="...">
            <div class="card-body">
                <h5 class="card-title"><%=bike.getBRAND()%></h5>
                <p class="card-text"> <%=bike.getMODEL()%></p>
            </div>
            <ul class="list-group list-group-flush">
                <li class="list-group-item"><%=bike.getSERIAL_NUMBER()%></li>
                <li class="list-group-item"><%=bike.getCONDITION()%></li>
            </ul>
            <div class="card-body">
                <a href="#" class="card-link">Rent!</a>
            </div>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>
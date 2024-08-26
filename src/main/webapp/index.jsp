<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.wdyride.domain.Bike" %>
<%@ page import="com.svalero.wdyride.dao.BikeDao" %>

<%@include file="includes/header.jsp"%>

<header class="bg-secondary text-white text-center py-5">
    <div class="container">
        <h1>What Do You Ride?</h1>
        <p class="lead">Find the best model to ride bike!</p>
        <p>
            <a href="edit-bike.jsp" class="btn btn-primary my-2">Add bike</a>
            <a href="#" class="btn btn-primary my-2">Ver calendario</a>
        </p>
    </div>
</header>

<section class="py-5">
    <div class="container">
        <div class="row">
            <%
                Database.connect();
                List<Bike> bikes = Database.jdbi.withExtension(BikeDao.class, dao -> dao.getBikes());
                for (Bike bike : bikes) {
            %>
            <div class="col-md-4">
                <div class="card mb-4">
                    <img src="../wdyRide_pictures/<%= bike.getPICTURE() %>" class="card-img-top" alt="Location 1"/>
                    <div class="card-body">
                        <h5 class="card-title">Mountain Bike</h5>
                        <p class="card-text"><%= bike.getBRAND()  %></p>
                        <p class="card-text"><%= bike.getMODEL()  %></p>
                        <a href="view-bike.jsp?SERIAL_NUMBER=<%= bike.getSERIAL_NUMBER()%>" class="btn btn-primary">Ver</a>
                        <a href="edit-bike.jsp?SERIAL_NUMBER=<%=bike.getSERIAL_NUMBER()%>" class="btn btn-primary">Editar</a>
                        <a href="remove-bike?SERIAL_NUMBER=<%= bike.getSERIAL_NUMBER()%>" class="btn btn-danger">Eliminar</a>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</section>
<%@include file="includes/footer.jsp"%>

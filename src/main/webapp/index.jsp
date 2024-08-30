<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.wdyride.domain.Bike" %>
<%@ page import="com.svalero.wdyride.dao.BikeDao" %>

<%@include file="includes/header.jsp"%>

<script>
    $(document).ready(function () {
        $("#search-input").focus();
    });
</script>

<header class="bg-secondary text-white text-center py-5">
    <div class="container">
        <h1>What Do You Ride?</h1>
        <p class="lead">Find the best model to ride bike!</p>
        <p>
            <%
                if (ROLE.equals("ADMIN")) {
            %>
            <a href="edit-bike.jsp" class="btn btn-primary my-2">Add bike</a>
            <%
                }
            %>
            <a href="#" class="btn btn-primary my-2">Ver calendario</a>
        </p>
        <form class="row justify-content-center g-2" id="search-form" method="GET">
            <div class="mb-1">
                <input type="text" class="form-control" placeholder="Search" name="search" id="search-input">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary mb-3" id="search-button">Send</button>
            </div>
        </form>
    </div>
</header>

<section class="py-5">
    <div class="container">
        <div class="row">
            <%
                String search = "";
                if (request.getParameter("search") != null)
                    search = request.getParameter("search");

                Database.connect();
                List<Bike> bikes = null;
                if (search.isEmpty()) {
                    bikes = Database.jdbi.withExtension(BikeDao.class, dao -> dao.getBikes());
                } else {
                    final String searchTerm = search;
                    bikes = Database.jdbi.withExtension(BikeDao.class, dao -> dao.getBikessearch(searchTerm));
                }

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
                        <%
                            if (ROLE.equals("ADMIN")) {
                        %>
                        <a href="edit-bike.jsp?SERIAL_NUMBER=<%=bike.getSERIAL_NUMBER()%>" class="btn btn-primary">Editar</a>
                        <a href="remove-bike?SERIAL_NUMBER=<%= bike.getSERIAL_NUMBER()%>" class="btn btn-danger">Eliminar</a>
                        <%
                            }
                        %>
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

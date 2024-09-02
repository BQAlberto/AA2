<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="com.svalero.wdyride.dao.BikeDao" %>
<%@ page import="com.svalero.wdyride.domain.Bike" %>
<%@ page import="com.svalero.wdyride.domain.Customer" %>
<%@ page import="com.svalero.wdyride.dao.CustomerDao" %>
<%@ page import="com.svalero.wdyride.domain.Rent" %>
<%@ page import="com.svalero.wdyride.dao.RentsDao" %>

<%@include file="includes/header.jsp"%>

<main>
    <%
        final int rentId = Integer.parseInt(request.getParameter("id"));

        // Conectar base de datos y obtener detalles del alquiler
        Database.connect();
        Rent rent = Database.jdbi.withExtension(RentsDao.class, dao -> dao.getRent(rentId));

        // Obtener bicicleta asociada al alquiler
        Bike bike = rent.getSERIAL_NUMBER();

        // Obtener rent asociado al alquiler
        Customer customer = rent.getCUSTOMER_ID();
    %>
    <div class="d-flex justify-content-center align-items-center" style="min-height: 50vh;">
        <div class="card border border-3 rounded" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title"><%=bike.getBRAND()%></h5>
                <p class="card-text">Model: <%=bike.getMODEL()%></p>
                <p class="card-text">Serial number: <%=bike.getSERIAL_NUMBER()%></p>
            </div>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">Rent ID: <%=rent.getRENT_ID()%></li>
                <li class="list-group-item">Customer: <%=customer.getFIRST_NAME()%> <%=customer.getLAST_NAME()%></li>
                <a href="edit-rent.jsp?RENT_ID=<%=rent.getRENT_ID()%>" class="btn btn-warning btn-sm me-2">EDIT</a>
                <a href="remove-rent?RENT_ID=<%=rent.getRENT_ID()%>" class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to delete this rent?');">DELETE</a>
            </ul>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>

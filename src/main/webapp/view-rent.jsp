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
        // Obtener el parámetro 'id' de la solicitud y declararlo como final
        final int rentId = Integer.parseInt(request.getParameter("id"));

        // Conectar a la base de datos y obtener los detalles del alquiler
        Database.connect();
        Rent rent = Database.jdbi.withExtension(RentsDao.class, dao -> dao.getRent(rentId));

        // Obtener la bicicleta asociada al alquiler
        Bike bike = rent.getSERIAL_NUMBER();

        // Obtener el cliente asociado al alquiler
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
            </ul>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>

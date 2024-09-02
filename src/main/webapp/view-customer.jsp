<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="com.svalero.wdyride.dao.BikeDao" %>
<%@ page import="com.svalero.wdyride.domain.Bike" %>
<%@ page import="com.svalero.wdyride.domain.Customer" %>
<%@ page import="com.svalero.wdyride.dao.CustomerDao" %>

<%@include file="includes/header.jsp"%>

<main>
    <%
        // Obtener parámetro 'id' de solicitud y declarar como final
        final int customerId = Integer.parseInt(request.getParameter("id"));

        // Conectar base de datos y obtener los detalles del cliente
        Database.connect();
        Customer customer = Database.jdbi.withExtension(CustomerDao.class, dao -> dao.getCustomer(customerId));
    %>
    <div class="d-flex justify-content-center align-items-center" style="min-height: 50vh;">
        <div class="card border border-3 rounded" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title"><%=customer.getUSERNAME()%></h5>
                <p class="card-text"> <%=customer.getCUSTOMER_ID()%></p>
            </div>
            <ul class="list-group list-group-flush">
                <li class="list-group-item"><%=customer.getFIRST_NAME()%></li>
                <li class="list-group-item"><%=customer.getLAST_NAME()%></li>
            </ul>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>
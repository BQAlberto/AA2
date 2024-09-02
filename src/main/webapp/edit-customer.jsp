<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="com.svalero.wdyride.domain.Customer" %>
<%@ page import="com.svalero.wdyride.dao.CustomerDao" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var form = $(this)[0];
            var formData = new FormData(form);

            $("#edit-button").prop("disabled", true);

            $.ajax({
                type: "POST",
                enctype: "multipart/form-data",
                url: "edit-customer",
                data: formData,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function(data) {
                    $("#result").html(data).removeClass("alert-danger").addClass("alert-success").show();
                    $("#edit-button").prop("disabled", false);
                },
                error: function(error) {
                    $("#result").html(error.responseText).removeClass("alert-success").addClass("alert-danger").show();
                    $("#edit-button").prop("disabled", false);
                }
            });
        });
    });
</script>

<%
    if (!ROLE.equals("ADMIN")) {
        response.sendRedirect("/wdyRide");
    }

    int customerId = 0;
    Customer customer = null;

    // Se obtiene ID del cliente desde los parámetros de solicitud
    try {
        customerId = Integer.parseInt(request.getParameter("CUSTOMER_ID"));
    } catch (NumberFormatException e) {
        // Manejar error si CUSTOMER_ID no es número válido
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Customer ID");
        return;
    }

    Database.connect();

    // Obtiene detalles de cliente usando el ID
    int finalCustomerId = customerId;
    customer = Database.jdbi.withExtension(CustomerDao.class, dao -> dao.getCustomer(finalCustomerId));

    if (customer == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Customer not found");
        return;
    }
%>

<main class="container my-5">
    <h1>Modify Customer</h1>

    <form class="row gy-2 gx-3 align-items-center" action="edit-customer.jsp" method="post" enctype="multipart/form-data" id="edit-form" novalidate>
        <div class="col-auto">
            <label class="visually-hidden" for="CUSTOMER_ID">Customer ID</label>
            <input type="text" name="CUSTOMER_ID" class="form-control" id="CUSTOMER_ID" placeholder="XXXXXX" required title="Please enter Customer ID"
                   value="<%= customer.getCUSTOMER_ID() %>" readonly>
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="FIRST_NAME">First name</label>
            <input type="text" name="FIRST_NAME" class="form-control" id="FIRST_NAME" placeholder="Peter"
                   value="<%= customer.getFIRST_NAME() %>" required>
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="LAST_NAME">Last name</label>
            <input type="text" name="LAST_NAME" class="form-control" id="LAST_NAME" placeholder="Robinson"
                   value="<%= customer.getLAST_NAME() %>" required>
        </div>
        <div class="col-auto">
            <button class="btn btn-primary" type="submit" id="edit-button">Modify</button>
        </div>
    </form>
    <br/>
    <div id="result"></div>
</main>

<%@include file="includes/footer.jsp"%>

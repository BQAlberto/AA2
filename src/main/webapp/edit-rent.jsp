<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="com.svalero.wdyride.dao.BikeDao" %>
<%@ page import="com.svalero.wdyride.domain.Bike" %>
<%@ page import="com.svalero.wdyride.domain.Rent" %>
<%@ page import="com.svalero.wdyride.dao.RentsDao" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var form = $(this)[0];
            var formData = new FormData(form);

            $("#edit-button").prop("disabled", true); // Desactiva el botón para evitar múltiples envíos

            $.ajax({
                type: "POST",
                enctype: "multipart/form-data",
                url: "edit-rent",
                data: formData,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function(data) {
                    $("#result").html(data).removeClass("alert-danger").addClass("alert-success").show();
                    $("#edit-button").prop("disabled", false); // Reactiva el botón después de la respuesta
                },
                error: function(error) {
                    $("#result").html(error.responseText).removeClass("alert-success").addClass("alert-danger").show();
                    $("#edit-button").prop("disabled", false); // Reactiva el botón en caso de error
                }
            });
        });
    });
</script>

<%
    if (!ROLE.equals("USER")) {
        response.sendRedirect("/wdyRide");
    }
    int rentId;
    Rent rent = null;

    // Se obtiene ID del cliente desde parámetros de la solicitud
    try {
        rentId = Integer.parseInt(request.getParameter("RENT_ID"));
    } catch (NumberFormatException e) {
        // Manejar el error si CUSTOMER_ID no es número válido
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Rent ID");
        return;
    }

    Database.connect();

    // Obtiene detalles del cliente usando el ID
    int finalRentId = rentId;
    rent = Database.jdbi.withExtension(RentsDao.class, dao -> dao.getRent(finalRentId));

    if (rent == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Rent not found");
        return;
    }
    Bike bike = rent.getSERIAL_NUMBER();   // Obtener bicicleta asociada al alquiler
%>

<main class="container my-5">
    <h1>Modify Rent</h1>

    <form class="row gy-2 gx-3 align-items-center" action="edit-rent.jsp" method="post" enctype="multipart/form-data" id="edit-form" novalidate>
        <div class="col-auto">
            <label class="visually-hidden" for="RENT_ID">Rent ID</label>
            <input type="text" name="RENT_ID" class="form-control" id="RENT_ID" placeholder="XXXXXX" required title="Please enter Rent ID"
                   value="<%= rent.getRENT_ID() %>" required>
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="FIRST_NAME">Serial number</label>
            <input type="text" name="SERIAL_NUMBER" class="form-control" id="FIRST_NAME" placeholder="Peter" required title="Please enter SERIAL_NUMBER"
                   value="<%= bike.getSERIAL_NUMBER() %>" required>
        </div>
        <div class="col-auto">
            <button class="btn btn-primary" type="submit" id="edit-button">Modify</button>
        </div>
    </form>
    <br/>
    <div id="result"></div>
</main>

<%@include file="includes/footer.jsp"%>
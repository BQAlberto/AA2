<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="com.svalero.wdyride.dao.BikeDao" %>
<%@ page import="com.svalero.wdyride.domain.Bike" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<!--<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("edit-bike", formValue, function(data) {
                $("#result").html(data);
            });
        });
    });
</script>-->

<%
    if (!ROLE.equals("ADMIN")) {
        response.sendRedirect("/wdyRide");
    }
    String SERIAL_NUMBER;
    Bike bike = null;
    if (request.getParameter("SERIAL_NUMBER") == null) {
        //Se accede al formulario para registrar nueva bici
        SERIAL_NUMBER = null;
    } else {
        //Se accede al formulario para editar la bici con el numero de serie que indique.
        SERIAL_NUMBER = request.getParameter("SERIAL_NUMBER");
        Database.connect();
        bike = Database.jdbi.withExtension(BikeDao.class, dao -> dao.getBike(SERIAL_NUMBER));
    }
%>

<main class="container my-5">
    <% if (SERIAL_NUMBER == null) { %>
      <h1>Register new bike</h1>
    <% } else { %>
        <h1>Modify bike</h1>
    <% } %>

        <form class="row gy-2 gx-3 align-items-center" action="edit-bike" method="post" enctype="multipart/form-data" novalidate>
        <div class="col-auto">
            <label class="visually-hidden" for="SERIAL_NUMBER">Serial number</label>
            <input type="text" name="SERIAL_NUMBER" class="form-control" id="SERIAL_NUMBER" placeholder="XXXXXX"
                <% if (SERIAL_NUMBER != null) { %> value="<%= bike.getSERIAL_NUMBER() %>"<% } %>>
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="CONDITION">Condition</label>
            <input type="text" name="CONDITION" class="form-control" id="CONDITION" placeholder="??"
                <% if (SERIAL_NUMBER != null) { %> value="<%= bike.getCONDITION() %>"<% } %>>
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="BRAND">Brand</label>
            <input type="text" name="BRAND" class="form-control" id="BRAND" placeholder="Trek"
                <% if (SERIAL_NUMBER != null) { %> value="<%= bike.getBRAND() %>"<% } %>>
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="MODEL">Model</label>
            <input type="text" name="MODEL" class="form-control" id="MODEL" placeholder="Emonda"
                <% if (SERIAL_NUMBER != null) { %> value="<%= bike.getMODEL() %>"<% } %>>
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="PICTURE">Picture</label>
            <input type="file" name="PICTURE" class="form-control" id="picture">
        </div>
        <div class="col-auto">
            <button class="btn btn-primary" type="submit" >Add</button>
        </div>
        <input type="hidden" name="SERIAL_NUMBER" value="<%= SERIAL_NUMBER %>"/>
    </form>
    <div id="result"></div>
</main>

<%@include file="includes/footer.jsp"%>
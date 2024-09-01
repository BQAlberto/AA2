<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="com.svalero.wdyride.domain.Rent" %>
<%@ page import="com.svalero.wdyride.dao.RentsDao" %>
<%@ page import="java.util.List" %>

<%@include file="includes/header.jsp"%>

<script>
    $(document).ready(function () {
        $("#search-input").focus();
    });
</script>

<main>
    <h1 CLASS="p-3">My Rents</h1>
    <%
        // Verificar si el usuario está autenticado
        if (request.getSession().getAttribute("CUSTOMER_ID") == null) {
            response.sendRedirect("index.jsp");
            return;  // Asegura que el resto del código no se ejecuta si se redirige
        }

        // Obtener el ID del usuario desde la sesión
        int theUserId = (Integer) request.getSession().getAttribute("CUSTOMER_ID");

        // Obtener el término de búsqueda
        String search;
        if (request.getParameter("search") != null) {
            search = request.getParameter("search").trim();  // Elimina espacios innecesarios
        } else {
            search = "";
        }

        // Conectar a la base de datos y obtener los resultados de reservas
        Database.connect();
        List<Rent> rents;
        if (search.isEmpty()) {
            rents = Database.jdbi.withExtension(RentsDao.class, dao -> dao.getRentsByCustomer(theUserId));
        } else {
            rents = Database.jdbi.withExtension(RentsDao.class, dao -> dao.getRentsearch(search));
        }
    %>
    <div class="container">
        <form class="row justify-content-center g-2" id="search-form" method="GET">
            <div class="mb-1">
                <input type="text" class="form-control" placeholder="Search" name="search" id="search-input" value="<%= search %>">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary mb-3" id="search-button">Send</button>
            </div>
        </form>
        <div class="list-group">
            <%
                // Renderizar las reservas solo si la lista no está vacía
                if (!rents.isEmpty()) {
                    for (Rent rent : rents) {
            %>
            <a href="view-rent.jsp?id=<%=rent.getRENT_ID()%>" class="list-group-item list-group-item-action active" aria-current="true">
                <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1"><%=rent.getSERIAL_NUMBER().getMODEL()%></h5>
                    <small><%=rent.getSERIAL_NUMBER().getSERIAL_NUMBER()%></small>
                    <small><%=rent.getRENT_ID()%></small>
                </div>
                <p class="mb-1"><%=rent.getSERIAL_NUMBER().getBRAND()%></p>
            </a>
            <%
                    }
                }
            %>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>

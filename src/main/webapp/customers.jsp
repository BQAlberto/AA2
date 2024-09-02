<%@ page import="com.svalero.wdyride.dao.Database" %>
<%@ page import="com.svalero.wdyride.domain.Customer" %>
<%@ page import="com.svalero.wdyride.dao.CustomerDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@include file="includes/header.jsp"%>

<script>
    $(document).ready(function () {
        $("#search-input").focus();
    });
</script>

<main>
    <h2 class="p-3">Customers</h2>
    <%
        if (!ROLE.equals("ADMIN")) {
            response.sendRedirect("/wdyRide");
        }

        // Verificar si hay un término de búsqueda
        String search;
        if (request.getParameter("search") != null) {
            search = request.getParameter("search").trim();  // Trim para eliminar espacios innecesarios
        } else {
            search = "";
        }

        // Verificar si el usuario está autenticado
        if (request.getSession().getAttribute("CUSTOMER_ID") == null) {
            response.sendRedirect("index.jsp");
            return;  // Asegura que el resto del código no se ejecuta si se redirige
        }

        // Inicializar la lista de clientes
        List<Customer> customers = new ArrayList<>();
        Database.connect();

        // Buscar clientes basados en el término de búsqueda
        if (search.isEmpty()) {
            customers = Database.jdbi.withExtension(CustomerDao.class, dao -> dao.getAllCustomers());
        } else {
            customers = Database.jdbi.withExtension(CustomerDao.class, dao -> dao.getCustomersearch(search));
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
                // Renderizar los clientes solo si la lista no está vacía
                if (!customers.isEmpty()) {
                    for (Customer customer : customers) {
            %>
            <a href="view-customer.jsp?id=<%=customer.getCUSTOMER_ID()%>" class="list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-between align-items-center">
                    <div>
                        <h5 class="mb-0"><%=customer.getFIRST_NAME()%> <%=customer.getLAST_NAME()%></h5>
                        <p class="mb-0 text-muted"><small>ID: <%=customer.getCUSTOMER_ID()%></small></p>
                    </div>
                    <div>
                        <p class="mb-0 text-primary"><strong><%=customer.getUSERNAME()%></strong></p>
                    </div>
                    <div class="ms-2 d-flex">
                        <!-- Contenedor para alinear los botones -->
                        <a href="edit-customer.jsp?CUSTOMER_ID=<%=customer.getCUSTOMER_ID()%>" class="btn btn-warning btn-sm me-2">EDIT</a>
                        <a href="remove-customer?CUSTOMER_ID=<%=customer.getCUSTOMER_ID()%>" class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this customer?');">DELETE</a>
                    </div>
                </div>
            </a>
            <%
                    }
                }
            %>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>

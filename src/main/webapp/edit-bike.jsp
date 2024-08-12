<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("edit-bike", formValue, function(data) {
                $("#result").html(data);
            });
        });
    });
</script>

<main class="container my-5">
    <h1>Register new bike</h1>
    <form class="row gy-2 gx-3 align-items-center" action="edit-bike" method="post" novalidate>
        <div class="col-auto">
            <label class="visually-hidden" for="autoSizingInput">Serial number</label>
            <input type="text" name="SERIAL_NUMBER" class="form-control" id="autoSizingInput" placeholder="XXXXXX">
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="autoSizingInput">Condition</label>
            <input type="text" name="CONDITION" class="form-control" id="autoSizingInput2" placeholder="XXXXXX">
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="autoSizingInput">Brand</label>
            <input type="text" name="BRAND" class="form-control" id="init date" placeholder="Trek">
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="autoSizingInput">Model</label>
            <input type="text" name="MODEL" class="form-control" id="return date" placeholder="Emonda">
        </div>
        <div class="col-auto">
            <label class="visually-hidden" for="autoSizingInput">Picture</label>
            <input type="file" name="PICTURE" class="form-control" id="picture">
        </div>
        <div class="col-auto">
            <button class="btn btn-primary" type="submit" >Submit</button>
        </div>
    </form>
    <div id="result"></div>
</main>

<%@include file="includes/footer.jsp"%>
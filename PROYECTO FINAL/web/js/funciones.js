$(document).ready(function () {
    $("tr #btnDelete").click(function () {
        var idp = $(this).parent().find("#idp").val();
        swal({
            title: "Are you sure?",
            text: "Once deleted, you will not be able to recover this item!",
            icon: "warning",
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                eliminar(idp);
            }
        });
    });

    function eliminar(idp) {
        var url = "Controlador?accion=Delete&idp=" + idp;
        $.ajax({
            type: 'POST',
            url: url,
            success: function (data, textStatus, jqXHR) {
                swal("Poof! Your item has been deleted!", {
                    icon: "success",
                }).then(() => {
                    location.reload(); // Recarga la página para reflejar los cambios
                });
            }
        })
    }
});

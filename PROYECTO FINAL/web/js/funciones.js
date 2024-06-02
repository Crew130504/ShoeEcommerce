$(document).ready(function () {
    $("tr #btnDelete").click(function () {
        console.log("Clicked!"); // Esto debería aparecer en la consola cuando hagas clic en el botón.
        var idp = $(this).parent().find("#idp").val();
        swal({
            title: "Are you sure?",
            text: "Once deleted, you will not be able to recover this imaginary file!",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        }).then((willDelete) => {
                    if (willDelete) {
                        eliminar(idp);
                        swal("Poof! Your imaginary file has been deleted!", {
                            icon: "success",
                        }).then((willDelete) => {
                            if (willDelete) {
                                parent.location.href = "Controlador?accion=Carrito";

                            }
                        });
                    } else {
                        swal("Your imaginary file is safe!");
                    }
                });
    });


    function eliminar(idp) {
        var url = "Controlador?accion=Delete&idp=" + idp;
        $.ajax({
            type: 'POST',
            url: url,
            success: function (data, textStatus, jqXHR) {
            }
        });
    }
    $("tr #Cantidad").click(function(){
        var idp=$(this).parent().find("#idpro").val();
        var cantidad =$(this).parent().find("#Cantidad").val();
        var url="Controlador?accion=ActualizarCantidad";
        $.ajax({
            typr: 'POST',
            url: url,
            data: "idp="+idp+"&Cantidad="+cantidad,
            success: function (data, textStatus, jqXHR) {
                location.href = "Controlador?accion=Carrito";
            }
            
        });
        
    })

});

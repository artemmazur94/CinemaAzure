$(document).ready(function () {
    $("#submit-btn").click(function () {
        if (validateInputs()) {
            $("#email-provide-form").submit();
        }
    });

    $("#Email").focus(function () {
        $(this).parent().removeClass("has-error");
        $("#email-label").addClass("hidden");
    });
});

function validateInputs() {
    if (validateEmail($("#Email").val())) {
        return true;
    }
    $("#Email").parent().addClass("has-error");
    $("#email-label").removeClass("hidden");
    return false;
}
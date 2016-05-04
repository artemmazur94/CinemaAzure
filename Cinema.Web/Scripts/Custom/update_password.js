$(document).ready(function () {
    $("#submit-btn").click(function () {
        if (validateInputs()) {
            $("#update-password-form").submit();
        }
    });

    $("#Password").focus(function () {
        $(this).parent().removeClass("has-error");
        $("#password-label").addClass("hidden");
    });

    $("#ConfirmPassword").focus(function () {
        $(this).parent().removeClass("has-error");
        $("#confirm-password-label").addClass("hidden");
    });
});

function validateInputs() {
    var valid = true;
    if ($("#Password").val().length < 8) {
        $("#Password").parent().addClass("has-error");
        $("#password-label").removeClass("hidden");
        valid = false;
    }
    if ($("#ConfirmPassword").val() !== $("#Password").val()) {
        $("#ConfirmPassword").parent().addClass("has-error");
        $("#Password").parent().addClass("has-error");
        $("#confirm-password-label").removeClass("hidden");
        valid = false;
    }
    return valid;
}
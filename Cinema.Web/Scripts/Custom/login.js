$(document).ready(function() {
    $("#submit-btn").click(function() {
        if (validateInputs()) {
            $("#login-form").submit();
        }
    });

    $("#Username").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#username-label").addClass("hidden");
    });

    $("#Password").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#password-label").addClass("hidden");
    });
});

function validateInputs() {
    var valid = true;
    if ($("#Username").val().length < 1) {
        $("#Username").parent().addClass("has-error");
        $("#username-label").removeClass("hidden");
        valid = false;
    }
    if ($("#Password").val().length < 1) {
        $("#Password").parent().addClass("has-error");
        $("#password-label").removeClass("hidden");
        valid = false;
    }
    return valid;
}
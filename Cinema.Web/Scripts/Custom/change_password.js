$(document).ready(function() {
    $("#submit-btn").click(function () {
        if (validateInputs()) {
            $("#change-password-form").submit();
        }
    });

    $("#OldPassword").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#old-password-label").addClass("hidden");
    });

    $("#NewPassword").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#new-password-label").addClass("hidden");
    });

    $("#NewPasswordConfirm").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#new-password-confirm-label").addClass("hidden");
    });
});

function validateInputs() {
    var valid = true;
    if($("#OldPassword").val().length < 1) {
        $("#OldPassword").parent().addClass("has-error");
        $("#old-password-label").removeClass("hidden");
        valid = false;
    }
    if ($("#NewPassword").val().length < 8) {
        $("#NewPassword").parent().addClass("has-error");
        $("#new-password-label").removeClass("hidden");
        valid = false;
    }
    if ($("#NewPasswordConfirm").val() !== $("#NewPassword").val()) {
        $("#NewPasswordConfirm").parent().addClass("has-error");
        $("#NewPassword").parent().addClass("has-error");
        $("#new-password-confirm-label").removeClass("hidden");
        valid = false;
    }
    return valid;
}
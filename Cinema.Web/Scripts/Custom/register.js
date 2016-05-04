$(document).ready(function() {
    $("#submit-btn").click(function() {
        if (validateInputs()) {
            $("#register-form").submit();
        }
    });

    $("#Username").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#username-label").addClass("hidden");
    });

    $("#Email").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#email-label").addClass("hidden");
    });

    $("#Name").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#name-label").addClass("hidden");
    });

    $("#Surname").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#surname-label").addClass("hidden");
    });

    $("#Password").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#password-label").addClass("hidden");
    });

    $("#PasswordConfirm").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#password-confirm-label").addClass("hidden");
    });
});

function validateInputs() {
    var valid = true;
    if ($("#Username").val().length < 4 || validateTrim($("#Username").val())) {
        $("#Username").parent().addClass("has-error");
        $("#username-label").removeClass("hidden");
        valid = false;
    }
    if (!validateEmail($("#Email").val())) {
        $("#Email").parent().addClass("has-error");
        $("#email-label").removeClass("hidden");
        valid = false;
    }
    if ($("#Name").val().length < 1 || validateTrim($("#Name").val())) {
        $("#Name").parent().addClass("has-error");
        $("#name-label").removeClass("hidden");
        valid = false;
    }
    if ($("#Surname").val().length < 1 || validateTrim($("#Surname").val())) {
        $("#Surname").parent().addClass("has-error");
        $("#surname-label").removeClass("hidden");
        valid = false;
    }
    if ($("#Password").val().length < 8) {
        $("#Password").parent().addClass("has-error");
        $("#password-label").removeClass("hidden");
        valid = false;
    }
    if ($("#PasswordConfirm").val() !== $("#Password").val()) {
        $("#PasswordConfirm").parent().addClass("has-error");
        $("#Password").parent().addClass("has-error");
        $("#password-confirm-label").removeClass("hidden");
        valid = false;
    }
    return valid;
}
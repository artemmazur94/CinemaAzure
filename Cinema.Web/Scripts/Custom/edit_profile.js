$(document).ready(function() {
    $("#submit-btn").click(function() {
        if (validateInputs()) {
            $("#edit-profile-form").submit();
        }
    });

    $("#Name").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#name-label").addClass("hidden");
    });

    $("#Surname").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#surname-label").addClass("hidden");
    });

    $("#Photo").focus(function() {
        $(this).parent().removeClass("has-error");
        $("#file-label").addClass("hidden");
    });
});

function validateInputs() {
    var valid = true;
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
    if (!validatePostedFile($("#Photo"))) {
        $("#Photo").parent().addClass("has-error");
        $("#file-label").removeClass("hidden");
        valid = false;
    }
    return valid;
}
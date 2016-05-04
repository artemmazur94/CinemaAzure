$(document).ready(function() {
    $("#submit-btn").click(function() {
        if (validateInputs()) {
            $("#person-create-edit-form").submit();
        }
    });

    $("#Name").focus(function() {
        $("#Name").parent().removeClass("has-error");
        $("#name-label").addClass("hidden");
    });

    $("#Photo").focus(function() {
        $("#Photo").parent().removeClass("has-error");
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
    if (!validatePostedFile($("#Photo"))) {
        $("#Photo").parent().addClass("has-error");
        $("#file-label").removeClass("hidden");
        valid = false;
    }
    return valid;
}
$(document).ready(function() {
    $("#submit-btn").click(function() {
        if (validateInputs()) {
            $("#genre-create-edit-form").submit();
        }
    });

    $("#Name").focus(function() {
        $("#Name").parent().removeClass("has-error");
        $("#name-label").addClass("hidden");
    });
});

function validateInputs(parameters) {
    if ($("#Name").val().length > 0 && !validateTrim($("#Name").val())) {
        return true;
    }
    $("#Name").parent().addClass("has-error");
    $("#name-label").removeClass("hidden");
    return false;
}
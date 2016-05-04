$(document).ready(function() {
    $("#ActorIds").select2({
        closeOnSelect: false,
        placeholder: "Please, select actors"
    });

    $("#DirectorId").select2({
        allowClear: true,
        placeholder: "Select director"
    });

    $("#submit-btn").click(function() {
        if (validateInputs()) {
            $("#movie-create-edit-form").submit();
        }
    });

    $("#Name").focus(function() {
        $("#Name").parent().removeClass("has-error");
        $("#name-label").addClass("hidden");
    });

    $("#Length").focus(function() {
        $("#Length").parent().removeClass("has-error");
        $("#length-label").addClass("hidden");
    });

    $("#ReleaseDate").focus(function() {
        $("#ReleaseDate").parent().removeClass("has-error");
        $("#date-label").addClass("hidden");
    });

    $("#Poster").focus(function() {
        $("#Poster").parent().removeClass("has-error");
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
    if ($("#Length").val() < 1) {
        $("#Length").parent().addClass("has-error");
        $("#length-label").removeClass("hidden");
        valid = false;
    }
    if (!validateDate($("#ReleaseDate").val())) {
        $("#ReleaseDate").parent().addClass("has-error");
        $("#date-label").removeClass("hidden");
        valid = false;
    }
    if (!validatePostedFile($("#Poster"))) {
        $("#Poster").parent().addClass("has-error");
        $("#file-label").removeClass("hidden");
        valid = false;
    }
    return valid;
}
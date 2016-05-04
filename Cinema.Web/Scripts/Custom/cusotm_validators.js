function validateDate(date) {
    var pattern = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
    return pattern.test(date);
}

function validateEmail(email) {
    var emailReg = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
    return emailReg.test(email);
}

function validateTrim(data) {
    var pattern = /^\s+|\s+$/g;
    return pattern.test(data);
}

function validatePostedFile(input) {
    if ($(input)[0].files[0] != null && $(input)[0].files[0].size > 5 * 1024 * 1024) {
        return false;
    }
    return true;
}
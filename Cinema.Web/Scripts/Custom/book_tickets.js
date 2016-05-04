$(document).ready(function() {
    $(".selected-seat").click(function () {
        var $this = $(this);
        $.ajax({
            url: window.ActionUrl,
            type: 'POST',
            data: {
                'row': $this.data('row'),
                'place': $this.data('place'),
                'seanceId': seanceId
            },
            accept: 'application/json',
            success: function(data) {
                if (!data.Success) {
                    alert("Sorry, this seat is already reserved!");
                } else {
                    if (data.Status === "Free") {
                        $this.removeClass('btn-success');
                        $this.addClass(getSeatTypeClass($this));
                    } else {
                        $this.removeClass(getSeatTypeClass($this));
                        $this.addClass('btn-success');
                    }
                }
            }
        });
        $this.blur();
    });

    //var expiresTime = new Date();
    //expiresTime.setMinutes(expiresTime.getMinutes() + 15);

    //$('#clock').countdown(expiresTime)
    //    .on('update.countdown', function (event) {
    //        var format = '%M:%S';
    //        $(this).html(event.strftime(format));
    //    }).on('finish.countdown', function() {
    //        $(this).html('Time to book tickets have expired!')
    //            .parent().addClass('disabled');
    //        $('.seat').attr('disabled', true);
    //    });
});

function getSeatTypeClass(button) {
    var type = button.data('type');
    if (type === 1) {
        return 'btn-primary';
    }
    if (type === 2) {
        return 'btn-info';
    } else {
        return 'btn-danger';
    }
}

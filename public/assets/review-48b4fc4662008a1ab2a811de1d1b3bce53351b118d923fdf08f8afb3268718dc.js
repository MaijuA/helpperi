var set_stars = function(form_id, stars) {
    for(i=1; i<=5; i++) {
        if(i <= stars) {
            $('#' + form_id + '_' + i).addClass('on');
        } else {
            $('#' + form_id + '_' + i).removeClass('on');
        }
    }
};

$(function() {
    $('.rating_star').click(function() {
        var star = $(this);
        var form_id = $(this).attr('data-form-id');
        var score = $(this).attr('data-score');

        set_stars(form_id, score);

        document.getElementById(form_id + '_score').value = score;
    });
});

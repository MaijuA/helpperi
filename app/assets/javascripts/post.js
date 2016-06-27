function defaultDescription() {
    var description = document.getElementById("description");
    var label = document.getElementById("label");
    var message = document.getElementById("desc_error")
    var desc = document.getElementById("post_description");
    description.className = "";
    label.className = "";
    message.className = "hidden";
    if (desc.value == "") {
        var categories = document.getElementById("post_category_ids");
        var categoryIds = [];
        for (var i = 0; i < categories.options.length; i++) {
            if(categories.options[i].selected ==true){
                categoryIds.push(categories.options[i].value);
            }
        }
        if (categoryIds.length == 1) {
            desc.value = gon.descriptions[categoryIds[0]];
        } else {
            description.value = gon.default_description;
        }
    } else {
        description.className = "field_with_errors";
        label.className = "field_with_errors";
        message.className = "alert alert-danger";
    }
}

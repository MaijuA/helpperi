function defaultDescription() {
    var description = document.getElementById("post_description");
    var label = document.getElementById("description_label");
    description.className = "form-control";
    label.className = "control-label";
    if (description.value == "") {
        var categories = document.getElementById("post_category_ids");
        var categoryIds = [];
        for (var i = 0; i < categories.options.length; i++) {
            if(categories.options[i].selected ==true){
                categoryIds.push(categories.options[i].value);
            }
        }
        if (categoryIds.length == 1) {
            description.value = gon.descriptions[categoryIds[0]];
        } else {
            description.value = gon.default_description;
        }
    } else {
        //description.className.replace("field_with_errors");
        //label.className.replace("field_with_errors");
        //alert(description.className);
        alert("Kuvaus-kenttä ei ole tyhjä!");
    }
}
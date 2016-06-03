function defaultDescription() {
    var description = document.getElementById("post_description");
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
        alert("Kuvaus-kenttä ei ole tyhjä!")
    }
}
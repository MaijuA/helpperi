function change_order() {
    document.getElementById("search").submit();
}

function change_interests() {
    var element = document.getElementById("only_interests")
    if (element.value == true || element.value == "true") {
        element.value = false
    } else {
        element.value = true
    }

    document.getElementById("search").submit();
}

function long_search() {
    document.getElementById("size").value = "long";
    document.getElementById("search").submit();
}

function short_search() {
    document.getElementById("size").value = "short";
    document.getElementById("word").value = "";
    document.getElementById("min").value = "";
    document.getElementById("max").value = "";
    document.getElementById("max").value = "";
    var categories = document.getElementById("category_ids").options;
    for(var i = 0; i < categories.length; i++){
        categories[i].selected = false;
    }
    document.getElementById("search").submit();
}

function set_buying() {
    document.getElementById("post_type_buying").value = true;
    document.getElementById("search").submit();
}

function not_buying() {
    document.getElementById("post_type_buying").value = false;
    document.getElementById("search").submit();
}

function set_selling() {
    document.getElementById("post_type_selling").value = true;
    document.getElementById("search").submit();
}

function not_selling() {
    document.getElementById("post_type_selling").value = false;
    document.getElementById("search").submit();
}

function interests() {
    
}

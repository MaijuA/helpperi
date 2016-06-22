function changeOrder() {
    document.getElementById("search").submit();
}

function long_search() {
    document.getElementById("short").className = "hidden";
    document.getElementById("long").className = "";
    document.getElementById("size").value = "long";
}

function short_search() {
    document.getElementById("short").className = "";
    document.getElementById("long").className = "hidden";
    document.getElementById("size").value = "short";
}

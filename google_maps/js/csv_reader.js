$(document).ready(function() {
    $.ajax({
        type: "GET",
        url: "data.csv",
        dataType: "text",
        async:false,
        success: function(data) { processData(data); }
     });
});

var mapping = {};

function processData(csv_content) {
    var allTextLines = csv_content.split(/\r\n|\n/);
    var headers = allTextLines[0].split(';');
    for (var i=1; i<allTextLines.length; i++) {
        var data = allTextLines[i].split(';');
        var tarr = [];
        for (var j=0; j<headers.length; j++) {
            tarr.push(data[j]);
        }
        mapping[tarr[0]] = [tarr[3],tarr[2]]
    }
}

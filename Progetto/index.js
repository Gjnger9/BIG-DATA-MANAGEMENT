window.onload = function() {

    var textarea =document.getElementById("textarea");
    var button = document.getElementById("button");
    button.onclick= toggleStartStop;



    var recognizing;
    var recognition = new webkitSpeechRecognition();
    recognition.continuous = true;
    reset();
    recognition.onend = reset;
    var result;
    recognition.onresult = function (event) {
        for (var i = event.resultIndex; i < event.results.length; ++i) {
            if (event.results[i].isFinal) {
                textarea.value += event.results[i][0].transcript;
            }
        }
        const text = textarea.value;

         result = text.toLowerCase().split(" ").reduce((hash, word) => {
            hash[word] = hash[word] || 0;
            hash[word]++;
            return hash;
        }, {});

        console.log(result);
        resetDiv();
        cloud();
    }

    function reset() {
        recognizing = false;
        button.innerHTML = "Click to Speak";
        // document.getElementById("container").innerHTML = "";

    }

    function toggleStartStop() {
        if (recognizing) {
            recognition.stop();
            reset();
        } else {
            recognition.start();
            recognizing = true;
            button.innerHTML = "Click to Stop";
        }
    }

function cloud() {
    anychart.onDocumentReady(function () {

        var data = [];
        for (obj in result) {

            let row = {"x": obj,"value":result[obj]};
            data.push(row)

        }
        console.log(data);


// create a tag (word) cloud chart
        var chart = anychart.tagCloud(data);
// set a chart title
        chart.title('15 most spoken languages')
        // set an array of angles at which the words will be laid out
        chart.angles([0])
        // enable a color range
        chart.colorRange(true);
        // set the color range length
        chart.colorRange().length('80%');
// display the word cloud chart
        chart.container("container");
        chart.draw();
    });
}
function resetDiv(){
    document.body.removeChild(document.getElementById("container"));
    let div = document.createElement("div");
    div.id = "container";
    document.body.appendChild(div);
}

}
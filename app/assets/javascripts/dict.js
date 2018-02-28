$(document).ready(function() {
  var recognition = new webkitSpeechRecognition();
  recognition.lang = 'ro-RO';
  recognition.onresult = function(event) {
    console.log(event.results[0][0].transcript);
    $(".word").val(event.results[0][0].transcript);
    $(".search-form").submit();
  }
  $("#search").click(function() {
    recognition.start();
  })
})

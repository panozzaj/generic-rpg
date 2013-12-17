var canvas = document.getElementById("game");
var context = canvas.getContext("2d");

context.save();
context.fillStyle = "#f00";
context.fillRect(100, 100, 200, 200);
context.restore();

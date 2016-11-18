window.Game = require("./game.js");


g = new Game();
g.draw(document.getElementById("canvas").getContext("2d"));

setInterval(() => {
  g.draw(document.getElementById("canvas").getContext("2d"));
  g.moveObjects(document.getElementById("canvas").getContext("2d"));
}, 25);
// document.addEventListener("DOMContentLoaded", function(){
//   const canvasEl = document.getElementsByTagName("canvas")[0];
//   canvasEl.width = Game.DIM_X;
//   canvasEl.height = Game.DIM_Y;
//
//   const ctx = canvasEl.getContext("2d");
//   const game = new Game();
//   // new GameView(game, ctx).start();
//
//
//   game.draw(ctx);
//
//   setInterval(() => {
//     game.draw(ctx);
//     game.moveObjects(ctx);
//   }, 100);
// });

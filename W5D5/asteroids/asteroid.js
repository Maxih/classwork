const MovingObject = require("./moving_object.js");
const Util = require("./util.js");



function Asteroid(options = {}) {
  this.COLOR = "#000";
  this.RADIUS = 5;

  options.pos = options.pos;
  options.vel = Util.randomVec(1000);
  options.color = this.COLOR;
  options.radius = this.RADIUS;
  MovingObject.call(this, options);
}
Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;

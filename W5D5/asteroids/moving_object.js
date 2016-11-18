function MovingObject(options) {
  this.pos = options.pos;
  this.vel = options.vel;
  this.radius = options.radius;
  this.color = options.color;
}

MovingObject.prototype.draw = function (ctx) {
  ctx.beginPath();
  ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2*Math.PI, true);
  ctx.fillStyle = this.color;
  ctx.fill();
};

MovingObject.prototype.move = function () {
  // this.pos[0] = (this.pos[0] + (this.vel[0] * 0.1));
  // this.pos[1] = (this.pos[1] + (this.vel[1] * 0.1));
  // console.log(this.DIM_X);

  this.pos[0] = (this.pos[0] + (this.vel[0] * 0.025)) % 1000;

  if(this.pos[0] < 0)
    this.pos[0] += 1000;

  this.pos[1] = (this.pos[1] + (this.vel[1] * 0.025)) % 500;

  if(this.pos[1] < 0)
    this.pos[1] += 500;

};

MovingObject.prototype.isCollidedWith = function (otherObject) {
  let x_dist = this.pos[0] - otherObject.pos[0];
  let y_dist = this.pos[1] - otherObject.pos[1];

  let distance = Math.sqrt((x_dist * x_dist) + (y_dist * y_dist));

  return distance < (this.radius + otherObject.radius);
};

module.exports = MovingObject;

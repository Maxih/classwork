const Asteroid = require("./asteroid.js");

function Game() {
  this.DIM_X = 1000;
  this.DIM_Y = 500;
  this.NUM_ASTEROIDS = 100;

  this.asteroids = [];

  for(let i = 0; i < this.NUM_ASTEROIDS; i++) {
    this.addAsteroids();
  }
}

Game.prototype.addAsteroids = function () {
  newAsteroid = new Asteroid({pos: this.randomPosition()});
  this.asteroids.push(newAsteroid);
};

Game.prototype.randomPosition = function () {
  return [Math.random() * this.DIM_X, Math.random() * this.DIM_Y];
};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
  this.asteroids.forEach((asteroid) => {
    asteroid.draw(ctx);
  });
};

Game.prototype.moveObjects = function(ctx) {
  this.asteroids.forEach((asteroid) => {
    asteroid.move();
    this.asteroids.forEach((asteroid2) => {
      if (asteroid.isCollidedWith(asteroid2)) {
        let avg_x = (asteroid.vel[0] + asteroid2.vel[0]) / 2;
        let avg_y = (asteroid.vel[1] + asteroid2.vel[1]) / 2;

        asteroid.vel[0] = avg_x;
        asteroid.vel[1] = avg_y;

        asteroid2.vel[0] = avg_x;
        asteroid2.vel[1] = avg_y;



      }
    });
  });
};

Game.prototype.checkCollisions = function () {
  this.asteroids.forEach((asteroid1) => {
    this.asteroids.splice(asteroid1).forEach((asteroid2) => {
      if (asteroid1.isCollidedWith(asteroid2)) {



      }
    });
  });
};

Game.prototype.bounce = function () {

};

Game.prototype.step = function () {

};

module.exports = Game;

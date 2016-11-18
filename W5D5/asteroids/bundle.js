/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	window.Game = __webpack_require__(1);


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


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Asteroid = __webpack_require__(2);

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


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const MovingObject = __webpack_require__(3);
	const Util = __webpack_require__(4);



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


/***/ },
/* 3 */
/***/ function(module, exports) {

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


/***/ },
/* 4 */
/***/ function(module, exports) {

	const Util = {
	  inherits (childClass, parentClass) {
	    function Surrogate() {}
	    Surrogate.prototype = parentClass.prototype;
	    childClass.prototype = new Surrogate();
	    childClass.prototype.constructor = childClass;
	  },
	  randomVec (length) {
	    const deg = 2 * Math.PI * Math.random();
	    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
	  },
	  // Scale the length of a vector by the given amount.
	  scale (vec, m) {
	    return [vec[0] * m, vec[1] * m];
	  }
	};

	module.exports = Util;


/***/ }
/******/ ]);
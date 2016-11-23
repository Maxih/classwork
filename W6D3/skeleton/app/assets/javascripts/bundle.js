/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const FollowToggle = __webpack_require__(1);
	const UsersSearch = __webpack_require__(3);
	const TweetCompose = __webpack_require__(4);
	
	$(() => {
	  $("button.follow-toggle").each((index, el) => {
	    const button = new FollowToggle($(el));
	  });
	
	  $("nav.users-search").each((index, el) => {
	    // console.log("here");
	    const searchBar = new UsersSearch($(el));
	  });
	
	  $("form.tweet-compose").each((index, el) => {
	    // console.log("here");
	    const tweet = new TweetCompose($(el), $("#feed"));
	  });
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	
	class FollowToggle {
	  constructor($el) {
	    this.userId = $el.attr("data-user-id");
	    this.followedState = $el.attr("data-initial-follow-state");
	    this.$el = $el;
	
	    this.addClickEvent();
	
	    this.render();
	  }
	
	  render() {
	    if(this.followedState === "followed") {
	      this.$el.removeAttr("disabled");
	      this.$el.text("Unfollow!");
	    } else if (this.followedState === "unfollowed") {
	      this.$el.removeAttr("disabled");
	      this.$el.text("Follow!");
	    } else if (this.followedState === "unfollowing") {
	      this.$el.attr("disabled", "disabled");
	      this.$el.text("Unfollowing!");
	    } else if (this.followedState === "following") {
	      this.$el.attr("disabled", "disabled");
	      this.$el.text("Following!");
	    }
	  }
	
	  handleClick(e) {
	    e.preventDefault();
	
	    if(this.followedState === "followed") {
	      APIUtil.unFollowUser(this.userId, this.toggleFollow.bind(this));
	      this.followedState = "unfollowing";
	    } else {
	      APIUtil.followUser(this.userId, this.toggleFollow.bind(this));
	      this.followedState = "following";
	    }
	
	    this.render();
	
	  }
	
	  addClickEvent() {
	    this.$el.on("click", this.handleClick.bind(this));
	  }
	
	  toggleFollow(data, status, jqXHR) {
	    this.followedState = this.followedState === "following" ? "followed" : "unfollowed";
	
	    this.render();
	  }
	}
	
	module.exports = FollowToggle;


/***/ },
/* 2 */
/***/ function(module, exports) {

	const APIUtil = {
	  followUser(id, success) {
	
	    $.ajax({
	      method: "POST",
	      url: `/users/${id}/follow.json`,
	      dataType: "json",
	      success: success
	    });
	  },
	
	  unFollowUser(id, success) {
	
	    $.ajax({
	      method: "DELETE",
	      url: `/users/${id}/follow.json`,
	      dataType: "json",
	      success: success
	    });
	  },
	
	  searchUsers(queryVal, success) {
	    $.ajax({
	      method: "GET",
	      url: `/users/search.json`,
	      dataType: "json",
	      data: queryVal,
	      success: success
	    });
	  },
	
	  createTweet(queryVal) {
	    return $.ajax({
	      method: "POST",
	      url: "/tweets",
	      dataType: "json",
	      data: queryVal
	    });
	  }
	};
	
	module.exports = APIUtil;


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	const FollowsController = __webpack_require__(1);
	
	class UsersSearch {
	  constructor($el) {
	    this.$el = $el;
	    this.$input = $el.children("input");
	    this.$ul = $el.children("ul");
	    this.typeEventHandler();
	  }
	
	  typeEventHandler() {
	    this.$input.on("keyup", this.searchQuery.bind(this));
	  }
	
	  searchQuery(e) {
	    // console.log("keypress");
	    const queryString = this.$input.val();
	    const queryParams = {
	      query: queryString
	    };
	
	    APIUtil.searchUsers(queryParams, this.searchResults.bind(this));
	  }
	
	  searchResults(data, status, jqXHR) {
	    this.$ul.empty();
	    data.forEach((user, index) => {
	      const $li = $("<li>");
	      const $a = $("<a>");
	      const $button = $("<button>");
	
	      $a.attr("href", `${user.id}`);
	
	      $button.attr("data-user-id", user.id);
	
	      if(user.followed)
	        $button.attr("data-initial-follow-state", "followed");
	      else
	        $button.attr("data-initial-follow-state", "unfollowed");
	
	      const button = new FollowsController($button);
	
	      $a.text(user.username);
	      $li.append($a);
	      $li.append($button);
	      this.$ul.append($li);
	    } );
	  }
	}
	
	module.exports = UsersSearch;


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	
	
	class TweetCompose {
	  constructor($el, $feed) {
	    this.$el = $el;
	    this.$ul = $feed;
	
	    this.submitEventHandler();
	  }
	
	  submitEventHandler() {
	    this.$el.on("submit", this.submitForm.bind(this));
	  }
	
	  submitForm(e) {
	    e.preventDefault();
	
	    const queryVal = this.$el.find(":input").serializeJSON();
	
	    APIUtil.createTweet(queryVal).then(this.handleResponse.bind(this));
	  }
	
	  handleResponse(tweet, status, jqXHR) {
	    console.log(tweet);
	
	    const $li = $("<li>");
	
	    $li.append(`${tweet.content}`);
	    this.$ul.prepend($li);
	
	  }
	}
	
	module.exports = TweetCompose;


/***/ }
/******/ ]);
//# sourceMappingURL=bundle.js.map
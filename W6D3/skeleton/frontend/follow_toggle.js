const APIUtil = require("./api_util.js");

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

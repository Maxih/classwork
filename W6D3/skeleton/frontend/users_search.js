const APIUtil = require("./api_util.js");
const FollowsController = require("./follow_toggle.js");

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

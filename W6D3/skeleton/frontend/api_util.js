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

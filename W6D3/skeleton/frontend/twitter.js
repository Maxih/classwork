const FollowToggle = require("./follow_toggle.js");
const UsersSearch = require("./users_search.js");
const TweetCompose = require("./tweet_compose.js");

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

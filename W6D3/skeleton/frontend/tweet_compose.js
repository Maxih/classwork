const APIUtil = require("./api_util.js");


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

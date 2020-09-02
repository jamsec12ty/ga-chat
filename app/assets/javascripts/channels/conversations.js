App.messages = App.cable.subscriptions.create('FriendsChannel', {

  received: function (data) {
    console.log("friends received", data);

  }
});

App.conversations = App.cable.subscriptions.create('ConversationsChannel', {
  received: function (data) {
    console.log("message received", data);
    $('.message_list').prepend(`
      <div class=class="message_list_item" id=${data.user.id}>
      <li>
        <h3>${data.user.name}</h3>
      </li>
      </div>
    `)
  }
});

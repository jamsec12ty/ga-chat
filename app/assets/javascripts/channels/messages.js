console.log("messages.js loaded");
App.messages = App.cable.subscriptions.create('MessagesChannel', {
  // This function runs whenever actioncable broadcasts a message to
  // this channel. Each user has their own channel whose name is of
  // the form "messages_#{user_id}", which is created in
  // app/channels/messages_channel.rb
  received: function(data) {
    console.log("message received", data);
    if (data.type === "message"){
      $('.message_window').append(`
        <li>
          <p><strong>${data.user.name}</strong></p>
          <div class="data_item">
            <p>${data.message.content}</p>
          </div>
          <p>${data.message.created_at.split('T').join(' ').substring(0, data.message.created_at.length - 5)}</p>
        </li>
      `);
    }else if (data.type === "friend_request"){

      if (data.status === "pending"){
        console.log("friend request pending");
      }else if (data.status === "confirmed"){
        console.log("friend request confirmed");
      }

    }else {
      console.warn("invalid message type:", data.type);
    }

  }
});

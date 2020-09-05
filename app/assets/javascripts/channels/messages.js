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
      $('.message_window').append($.cloudinary.image(data.message.attachment, { width: 200 }));
      $('.notification').show();
      $('.notification').empty();
      $('.notification').append(`You have a new message from ${data.user.name}!`);
    }else if (data.type === "friend_request"){
      $('.notification').show();

      if (data.status === "pending"){
        console.log("friend request pending");
        $('.notification').empty();
        $('.notification').append(`<p>You have a new friend request from ${data.user_name}!</p><a href="/requests">Please check requests page.</a>`);

      }else if (data.status === "confirmed"){
        console.log("friend request confirmed");
        $('.notification').empty();
        $('.notification').append(`<p>Your friend request has been accepted by ${data.user_name}!</p><a href="/messages">You can now message each other :)</a>`);
      }

    }else {
      console.warn("invalid message type:", data.type);
    }

  }
});

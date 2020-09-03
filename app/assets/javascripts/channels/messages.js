
App.messages = App.cable.subscriptions.create('MessagesChannel', {
  // This function runs whenever actioncable broadcasts a message to
  // this channel. Each user has their own channel whose name is of
  // the form "messages_#{user_id}", which is created in
  // app/channels/messages_channel.rb
  received: function(data) {
    console.log("message received", data);
    $('.message_window').append(`
    <li>
      <p><strong>${data.user.name}</strong></p>
      <div class="data_item">
        <p>${data.message.content}</p>
      </div>
      <p>${data.message.created_at.split('T').join(' ').substring(0, data.message.created_at.length - 5)}</p>
    </li>
    `);

    $('.message_window').append($.cloudinary.image(message.attachment, { width: 200 }));

  }

});

let cloudinaryUploadPublicId = null;

$(document).ready(function () {
  console.log('Testing');
  /* ------------------- Message Search ------------------- */

  $('.show_friends').on('click', function(){
    $('.message_friends_list').show();
  });

  $('.hide_friends').on('click', function(){
    $('.message_friends_list').hide();
  });

  $('.message_search_form').on('submit', (e) => {
    e.preventDefault();
    $('.message_results').empty();

    const query = $('.message_search_text').val().toLowerCase();

    if (query === '') {
      $('.message_results').append(
        `<h4>Please enter keywords and then search.</h4>`
      )
    } else {
      const searchURL = `/messages/search`;
      const string = query.replace(/(\s+)/, "(<[^>]+>)*$1(<[^>]+>)*");
      const pattern = new RegExp("(" + string + ")", "gi");

      $.getJSON(searchURL)
      .done(data => {
        $('.message_search_text').val('');
        console.log(data);
        data.forEach(message => {
          let index = message.content.toLowerCase().indexOf(query);
          if (index >= 0) {
            let keyWords = message.content.substr(index, query.length);
            let results = message.content.replace(pattern, `<mark>${keyWords}</mark>`);
            $('.message_results').append(
              `<p>${results}</p>
              <p>${message.sender.name} to ${message.recipient.name}</p>
              <p>${message.created_at.split('T').join(' ').substring(0, message.created_at.length - 5)}</p>`)
          }
        });
        if ($('.message_results').html() === '') {
          $('.message_results').append(
            `<h4>No matching results.</h4>`
          )
        }
          $('.message_results').prepend(`<button class="message_search_back">Back</button>`)
      })
      .fail(error => console.log(error))
    }
  });

  $(document).on('click', '.message_search_back', function(){
    $('.message_results').empty();
    $('.message_search_text').val('');
    $('.message_search_text').focus()
  });

  // Show message window
  let recipientId;
  $(".message_list_item").on('click', (e) => {
    $(".message_window").empty();
    const query = e.currentTarget.id;
    recipientId = query; // Save the last clicked user id, for using when sending message
    console.log(e.currentTarget.id);
    $.getJSON(`messages/show/${query}`)
    .done( data => {
      console.log(data);
      data.forEach(message => {
        $('.message_window').append(`
        <li>
          <p><strong>${message.sender.name}</strong></p>
          <div class="message_item">
            <p>${message.content}</p>
          </div>
          <p>${message.created_at.split('T').join(' ').substring(0, message.created_at.length - 5)}</p>
        </li>
        `);
        if (message.attachment !== null) {
          $('.message_window').append($.cloudinary.image(message.attachment, { width: 200 }));
        }
      })
    }).fail(error => console.log(error));
  });

  // TODO : Unsigned Name, the owner of the heroku config keys will have to enable unsigned upload under their account settings in cloudinary
  // This attaches the <input type=file> file chooser to the form.
  $('.message_send_text').after($.cloudinary.unsigned_upload_tag("rruzhrqp",
  { cloud_name: 'sarop-bajra' }));

  $('.cloudinary_fileupload').unsigned_cloudinary_upload(
    "rruzhrqp",
    { cloud_name: 'sarop-bajra', tags: 'browser_uploads' },
    { multiple: true }
  )
  .bind('fileuploadchange', function(e, data){

    // We disable the message send button while the file is uploading
    // Otherwise the user might send a message before the file has uploaded and
    // the public_id won't be attached
    $('.message_send_button').prop("disabled", true).text("Uploading... Please Wait");

    // We hide the file chooser to prevent the user from uploading another image to
    // the same message, since only the last image upload will be saved in the database.
    $(".cloudinary_fileupload").hide();
  })
  .bind('cloudinaryprogress', function(e, data) {

    // Update Progress Bar size while uploading
    $('.progress_bar').css('width',
      Math.round((data.loaded * 100.0) / data.total) + '%');

  })
  .bind('cloudinarydone', function(e, data) {
    // When the upload is finished cloudinary give us the response in the 'data' variable
    // We save the public_id to a global variable 'cloudinaryUploadPublicId', so we can
    // submit it to our MessagesController in the AJAX request which is triggered by
    // clicking send
    cloudinaryUploadPublicId = data.result.public_id;
    console.log("cloudinary response", data);
    $('.progress_bar').hide();

    // We re-enable the send button now that the file has finished uploading
    $('.message_send_button').prop("disabled", false).text("Send");

    // Show a preview of the uploaded image, to give feedback to the user
    $('.thumbnails').append(
      $.cloudinary.image(
        data.result.public_id,
        { width: 100, height: 100, crop: 'thumb', gravity: 'face' }
      )
    );

})

  $('.message_send_button').on('click', (e) => {
    e.preventDefault();

    const message = $('.message_send_text').val();
    // console.log(message);
    // console.log("Recipient ID:", recipientId);
    // console.log("cloudinaryUploadPublicId:", cloudinaryUploadPublicId);
    $.post(`/messages`, {
      recipient_id: recipientId,
      content: message,
      attachment: cloudinaryUploadPublicId
    })
    .done(message => {
      $(".cloudinary_fileupload").val("").show(); // Shown for the next upload
      $('.thumbnails').empty(); // Clear for the next upload

      $('.message_window').append(`
        <li>
          <p><strong>${message.sender.name}</strong></p>
          <div class="message_item">
            <p>${message.content}</p>
          </div>
          <p>${message.created_at.split('T').join(' ').substring(0, message.created_at.length - 5)}</p>
        </li>`
      );

      if (cloudinaryUploadPublicId !== null) {
        $('.message_window').append($.cloudinary.image(message.attachment, { width: 200 }));
        // Clearing this so that we do not attach an old upload to a new message
        cloudinaryUploadPublicId = null;
      }
    })
    .fail(error => console.log(error))
    $('.message_send_text').val('');
  }); // End Of Send Click Handler

  /* --------------------- User Search -------------------- */

  $('.user_search_form').on('submit', function(ev){
    ev.preventDefault(); // stop form from submitting
    const query = $('.user_search_text').val();
    getSearchResults(query);
    console.log(query);
  });

  const getSearchResults = function(queryText) {
    // Perform AJAX request
    $.getJSON(`/users/search/${queryText}`, {
      name: queryText
      })
      .done(function (data) {
        $(".user_search_text").val("");
        console.log(data);
        displaySearchResults(data);
      }).fail(function (err) {
        return console.warn(err);
    });
  };

  const displaySearchResults = (results) => {
    // Save a reference to the results div DOM node
    // so we're not querying the DOM in each iteration
    // of the loop (there are 100 iterations!)
    const $results = $('.user_results');
    $results.empty();
    // Display each result on the page:
    results.forEach( user => {
      $results.append(`
      <p><a href = '/users/${user.id}'>${user.name}</a></p>
      `);
    });

    if ($('.user_results').html() === '') {
      $('.user_results').append(
        `<h4>No matching results.</h4>`
      )
    }
      $('.user_results').prepend(`<button class="user_search_back">Back</button>`)
  }; // displaySearchResults()

  $(document).on('click', '.user_search_back', function(){
    $('.user_results').empty();
    $('.user_search_text').val('');
    $('.user_search_text').focus()
  });

  /* -------------------- Requests Tab -------------------- */

  $('.pending_requests_tab').on('click', function(){
    console.log("clicked");
    $('.pending_requests').show();
    $('.received_requests').hide();
  });

  $('.received_requests_tab').on('click', function(){
    console.log("clicked");
    $('.pending_requests').hide();
    $('.received_requests').show();
  });

});

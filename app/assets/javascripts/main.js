// Check if Local Storage can be used
let localStorageSaved = true;
// If not available change to false
if (localStorage === undefined) {
  localStorageSaved = false;
}

$(document).ready(function () {

  let recipientId;

  /* -------------------- Local Storage ------------------- */

  if (localStorageSaved) {
    if (localStorage.id !== undefined) {
      console.log('localStorage', localStorage.id);
      let query = JSON.parse(localStorage.getItem('id'));
      console.log(query);
      recipientId = query;
      $(`#${query}`).addClass('selected');
      $.getJSON(`messages/show/${query}`)
        .done(data => {
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
        `)
          })
        }).fail(error => console.log(error));
      $('.message_send_wrapper').show();
    }
  }

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
  $('.message_list_item').on('click', (e) => {
    $('.message_window').empty();
    $('.message_send_wrapper').show();
    $(e.currentTarget).addClass('selected');
    $(e.currentTarget).siblings().removeClass('selected');
    const query = e.currentTarget.id;
    // Save the last clicked user id, for using when sending message
    recipientId = query; 
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
        `)
      })
    }).fail(error => console.log(error));
  });

  // Send message form
  $('.message_send_form').on('submit', (e) => {
    e.preventDefault();
    const message = $('.message_send_text').val();
    console.log(message);
    console.log("Recipient ID:", recipientId);
    $.post(`/messages`, {
      recipient_id: recipientId,
      content: message
    })
    .done(message => {
      $('.message_window').append(`
      <li>
        <p><strong>${message.sender.name}</strong></p>
        <div class="message_item">
          <p>${message.content}</p>
        </div>
        <p>${message.created_at.split('T').join(' ').substring(0, message.created_at.length - 5)}</p>
      </li>
      `)
      $(`.last_message_${recipientId}`).html(`
        <p>${message.created_at.split('T').join(' ').substring(0, message.created_at.length - 5)}</p>        
        <p>${message.content}</p>
      `)
    })
    .fail(error => console.log(error))
    $('.message_send_text').val('');
  });


  /* --------------------- User Search -------------------- */

  $('.user_search_form').on('submit', function(ev){
    ev.preventDefault(); // stop form from submitting
    const query = $('.user_search_text').val();
    getSearchResults(query);
    console.log(query);
  });

  const getSearchResults = function(queryText) {
    if (queryText.trim() === '') {
      $('.user_results').empty();
      return;
    }

    // Perform AJAX request
    $.getJSON(`/users/search/${queryText}`, {
      name: queryText
      })
      .done(function (data) {
        console.log(data);
        displaySearchResults(data);
      }).fail(function (err) {
        return console.warn(err);
    });
  };


  $('.user_search_text').on('input', function() {
    getSearchResults($(this).val());
  });

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
      <p class="view_profile" id=${user.id}>View Profile</p>
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

  /* -------------------- Friends -------------------- */

  $('.message_friends').on('click', (e) => {
    console.log(e.currentTarget.id);
    let id = e.currentTarget.id;
    localStorage.setItem('id', JSON.stringify(id));
    $.post(`/messages/conversations`, {
        friendId: id,
      })
      .done(friend => {
        $('.message_list').prepend(`
          <div class = "message_list_item" id=${friend.id} >
          <li>
            <h3>${user.name}</h3>
          </li>
          </div>
        `)
      })
      .fail(error => console.log(error))
  })

  // Show user profile
  $(document).on('click', '.view_profile', (e) => {
    $('.user_profile').empty();
    const query = e.currentTarget.id;
    console.log(query);
    $.get(`/users/profile/${query}`)
    .done(data => {
      console.log("Template:", data);
      $('.user_profile').append(data)
      })
    .fail(error => console.log(error));
  });

  /* -------------------- Requests Tab -------------------- */

  $('.pending_requests_tab').on('click', function(){
    console.log("clicked");
    $('.pending_requests').show();
    $('.received_requests').hide();
    $('.pending_requests_tab').attr('id', 'link_current');
    $('.received_requests_tab').attr('id', '');
  });

  $('.received_requests_tab').on('click', function(){
    console.log("clicked");
    $('.pending_requests').hide();
    $('.received_requests').show();
    $('.pending_requests_tab').attr('id', '');
    $('.received_requests_tab').attr('id', 'link_current');
  });

});

$(document).ready(function () {
  console.log('Testing');

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
        } else {
          $('.message_results').prepend(`<button class="message_search_back">Back</button>`)
        }
      })
      .fail(error => console.log(error))
    }

  });

  $(document).on('click', '.message_search_back', function(){
    $('.message_results').empty();
  });


  $('.user_search_form').on('submit', function(ev){
    ev.preventDefault(); // stop form from submitting

    const query = $('.user_search_text').val();
    getSearchResults(query);
    console.log(query);
  });

  const getSearchResults = function(queryText) {
    console.log('getSearchResults():',queryText);

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

  const displaySearchResults = (results) => {
    console.log('displaySearchResults():', results);

    // Save a reference to the results div DOM node
    // so we're not querying the DOM in each iteration
    // of the loop (there are 100 iterations!)
    const $results = $('.user_results');
    $results.empty();
    // Display each result on the page:
    results.forEach( user => {
      $results.append(`<a href = '/users/${user.id}'>${user.name}</a>`);

    });

  }; // displaySearchResults()

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

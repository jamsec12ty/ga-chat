$(document).ready(function () {
  console.log('Testing');



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

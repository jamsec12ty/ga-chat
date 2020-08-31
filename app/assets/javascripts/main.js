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
    $('.message_results').append(`<button class="message_search_back">Back</button>`)

    const query = $('.message_search_text').val();
    const searchURL = `/messages/search/0`;
    
    $.getJSON(searchURL)
    .done(data => {
      $('.message_search_text').val('');
      console.log(data);
      data.forEach(message => {
        if (message.content.toLowerCase().includes(query)) {
          $('.message_results').append(
            `<h4>${message.content}</h4>
             <p>${message.created_at.split('T').join(' ').substring(0, message.created_at.length - 5)}</p>
             `
          )
        }
      })
    })
    .fail(error => console.log(error))
  });

  $(document).on('click', '.message_search_back', function(){
    $('.message_results').empty();
  });

});
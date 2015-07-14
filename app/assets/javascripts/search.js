$(function () {
  function displaySearchResults (data) {
    $('#contents').html(JST['templates/search'](data));
  }

  function waiting () {
    var html = "<br /><div class='row'><div class='col-md-2'></div><div class='col-md-8 image-responsive'><img src='/assets/waiting.gif' /></div><div class='col-md-2'></div></div>";

    $("#contents").html(html);
  }

  $("#search").on("submit", function () {
    waiting();
  });

  $('#search').on('ajax:success', function (e, data, status, xhr) {
    displaySearchResults(data)
  });
})

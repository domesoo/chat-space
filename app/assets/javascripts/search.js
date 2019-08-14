$(function() {

  function buildUser(user) {
    var html =`<div class="chat-group-user clearfix">
                <p class="chat-group-user__name">${user.name}</p>
                <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
              </div>`
    return html;
  }

  function changeUser(userName, userId) {
    var html = `<div class='chat-group-user'>
                  <input name='group[user_ids][]' type='hidden' value='${userId}'>
                  <p class='chat-group-user__name'>${userName}</p>
                  <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
                </div>`
    $("#chat-group-users").append(html);
  };

  $(document).on("keyup",".chat__user_name", function() {
    var input = $(".chat__user_name").val();    

    $.ajax({
      type: 'GET',
      url: '/users',
      data: { keyword: input},
      dataType: 'json'
    })
    
    .done(function(users) {      
      $("#user-search-result").empty();
      users.forEach(function(user){
        var html = buildUser(user);
        $("#user-search-result").append(html);
      });
    })
    .fail(function(){
      alert('error');
    });
  });
  
  $(document).on('click', '.user-search-add', function(){
    $(this).parent().remove();
    var userName = $(this).data('userName');
    var userId = $(this).data('userId');
    changeUser(userName, userId);
  });

  $(document).on('click', '.user-search-remove', function(){
    $(this).parent().remove();
  })
});
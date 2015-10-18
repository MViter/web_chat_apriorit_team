var baseDomain = "http://localhost:53791";

$(function () {

    //var AppKey = GetAppKey();
    create_webchat_compact_window();
});

function GetAppKey() {
    var key = undefined;
    $.ajax({
        type: "GET",
        url: 'http://localhost:53791/api/CustomerAppAPI/GetKey',
        data: "",
        async: true,
        dataType: "text",
        success: function (data) {
            key = data;
        }
    });

    return key;
}


function create_webchat_compact_window() {
    $('<div id="webchat-compact-container"</div>').appendTo('body');
    $('#webchat-compact-container').attr('style', 'position: fixed; bottom: 0px; left: 15px; width: 250px; height: 53px; overflow: hidden; visibility: visible; z-index: 2147483639; border: 0px; backface-visibility: hidden; opacity: 1; background: transparent;');

    $('<iframe id="webchat-compact"/>').appendTo('#webchat-compact-container');
    $('#webchat-compact').attr('style', 'position: relative; top: 20px; left: 0; width: 100%; border: 0; padding: 0; margin: 0; float: none; background: none');
    $('#webchat-compact').attr('scrolling', 'no');
    $('#webchat-compact').attr('frameborder', '0');
    $('#webchat-compact').attr('allowtransparency', 'true');
    $('#webchat-compact').attr('src', baseDomain + '/ChatStartPage/CompactStartPage');
}


function open_chat_window() {
    $('<div id="webchat-full-container" </div>').appendTo('body');
    $('#webchat-full-container').attr('style', 'position: fixed; bottom: 0px; left: 15px; width: 350px; height: 450px; overflow: hidden; visibility: visible; z-index: 2147483639; border: 0px; backface-visibility: hidden; opacity: 1; background: transparent;');

    $('<iframe id="webchat-full"/>').appendTo('#webchat-full-container');
    $('#webchat-full').attr('style', 'position: absolute; top: 0px; right: 0px; bottom: 0px; left: 0px; width: 100%; height: 100%; border: 1px black solid; padding: 0px; margin: 0px; float: none; background: none;');
    $('#webchat-full').attr('scrolling', 'no');
    $('#webchat-full').attr('frameborder', '0');
    $('#webchat-full').attr('allowtransparency', 'true');
    $('#webchat-full').attr('src', baseDomain + '/ChatStartPage/StartPageFull');

    $('#webchat-compact-container').hide(null);
}





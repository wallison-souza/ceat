function send_form_with_ajax(id, res_type){
    let data = {};
    let $form = $(id);
    let arr = $form.serializeArray(); // an array of all form items
    for (let i=0; i<arr.length; i++) { // transforming the array to object
        data[arr[i].name] = arr[i].value;
    }
    data.return_type = res_type; // optional identifier - you can handle it on server and respond with JSON instead of HTML output

    return new Promise(resolve => {
        $.ajax({
            url: $form.attr('action'), // server script from form action attribute or document URL (if action is empty or not specified)
            type: $form.attr('method'), // method by form method or GET if not specified
            dataType: res_type, // we expect res_type in response
            async: false,
            data: data, // object with all form items

            success: function (respond) {
                resolve(respond)
            },
            error: function (respond) {
                alert("Erro na requisição. Contate o suporlklkte!");
                resolve(respond)
            }
        });
    })


}
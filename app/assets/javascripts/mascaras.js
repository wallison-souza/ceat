//= require jquery.mask-1.14.16.min


function mask_agencia_bancaria(){
  jQuery('input[mask=agencia_bancaria]').mask("9999-9");
}
function mask_cep(){
  jQuery('input[mask=cep]').mask("99999-999");
}
function mask_rg() {
  jQuery('input[mask=rg]').mask("99.999.999-w",{
      translation: {
          "w": {
              pattern: /[X0-9]/
          }
      },
      reverse: true
  });
}
function mask_celular(){
  jQuery('input[mask=celular]').mask("(99)9 9999-9999");
}
function mask_certidao(){
  jQuery('input[mask=certidao]').mask("999999 99 99 9999 9 99999 999 9999999-99");
}
function mask_cnh(){
  jQuery('input[mask=cnh]').mask("99 999 999 999");
}
function mask_cpf(){
  jQuery('input[mask=cpf]').mask("999.999.999-99");
}
function mask_cnpj(){
  jQuery('input[mask=cnpj]').mask("99.999.999/9999-99");
}
function mask_conta_bancaria(){
  jQuery('input[mask=conta_bancaria]').mask("99.999-9");
}
function mask_data(){
  jQuery('input[mask=data]').mask("99/99/9999");
}
function mask_horas() {
  jQuery('input[mask=horas]').mask('9?9');
  jQuery('input[mask=horas]').on('change', function (elem) {
    let input = jQuery(elem.currentTarget);
    let values = input.val();
    if(parseInt(input.val() > 23)){
      input.val('23');
    }
  })
}
function mask_horas_minutos() {
  let pattern = {
    translation: {
      "A": { pattern: /[0-2]/, optional: true},
      "B": { pattern: /[0-9]/, optional: false},
      "C": { pattern: /[0-5]/, optional: false},
      "D": { pattern: /[0-9]/, optional: false}
    }
  };
  jQuery('input[mask=horas_minutos]').mask('AB:CD', pattern);
  jQuery('input[mask=horas_minutos]').on('change', function (elem) {
    let input = jQuery(elem.currentTarget);
    let values = input.val().split(':');
    if(values.length === 1){
      if(values[0] !== ''){
        input.val(values[0] + ':00');
        values[1] = '00';
      }
    }else{
      if(values[1].length === 1){
        input.val(values[0] + ':' + values[1] + '0');
      }else if(values[1].length === 0){
        input.val(values[0] + ':00');
      }
    }
    if(values[0].length === 1){
      input.val('0' + values[0] + ':' + values[1]);
    }
    if(parseInt(values[0]) > 23){
      input.val('23:' + values[1]);
    }
  })
}
function mask_horas_minutos_segundos() {
  jQuery('input[mask=horas_minutos_segundos]').mask('99:99:99');
}
function mask_moeda(){
  jQuery('input[mask=moeda]').mask('#.##0,00', {reverse: true});
}
function mask_pis_pasep(){
  jQuery('input[mask=pis_pasep]').mask('999.99999.99-9');
}
function mask_telefone(){
  jQuery('input[mask=telefone]').mask("(99) 9999-9999");
}
function mask_titulo_eleitor_com_dv(){
  jQuery('input[mask=titulo_eleitor_com_dv]').mask("9999 9999 9999");
}
function mask_titulo_eleitor_sem_dv(){
  jQuery('input[mask=titulo_eleitor_sem_dv]').mask("9999 9999 99");
}
function mask_titulo_eleitor_zona(){
  jQuery('input[mask=titulo_eleitor_zona]').mask("9999");
}
function mask_titulo_eleitor_secao(){
  jQuery('input[mask=titulo_eleitor_secao]').mask("9999");
}


function all_masks(){
  mask_certidao();
  mask_cnh();
  mask_cpf();
  mask_rg();
  mask_cep();
  mask_celular();
  mask_telefone();
  mask_data();
  mask_cnpj();
  mask_agencia_bancaria();
  mask_conta_bancaria();
  mask_titulo_eleitor_com_dv();
  mask_titulo_eleitor_sem_dv();
  mask_moeda();
  mask_titulo_eleitor_secao();
  mask_titulo_eleitor_zona();
  mask_pis_pasep();
  mask_horas();
  mask_horas_minutos();
  mask_horas_minutos_segundos();
}

jQuery(document).ready(function () {
  all_masks();
});


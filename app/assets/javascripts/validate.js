var validate = validate || {};

validate.methods = (function() {
  'use strict';

  function translateValidate() {
    $.extend($.validator.messages, {
      required: "Campo obrigatório",
      remote: "Por favor, corrija este campo",
      email: "Preencha com um e-mail v&aacute;lido",
      url: "O campo deve ser uma url v&aacute;lida",
      complete_url: "O campo deve ser uma url v&aacute;lida",
      date: "O campo deve ser uma data v&aacute;lida",
      datePT: "O campo deve ser uma data v&aacute;lida",
      dateISO: "O campo deve ser uma data v&aacute;lida (ISO)",
      number: "O campo deve ser um n&uacute;mero v&aacute;lido",
      digits: "O campo deve ser somente d&iacute;gitos",
      creditcard: "O campo deve ser um cart&atilde;o de cr&eacute;dito v&aacute;lido",
      equalTo: "O campo est&aacute; diferente da senha informada",
      accept: "O campo Por favor, forne&ccedil;a um arquivo com uma extens&atilde;o v&aacute;lida",
      maxlength: $.validator.format("O campo deve ser menor que {0} caracteres"),
      minlength: $.validator.format("O campo deve ser maior que {0} caracteres"),
      rangelength: $.validator.format("O campo deve ter entre {0} e {1} caracteres"),
      range: $.validator.format("Use um valor entre {0} e {1}"),
      max: $.validator.format("O campo deve ser menor do que {0}"),
      min: $.validator.format("O campo deve ser maior do que {0}"),
      maxValue: $.validator.format("O campo deve ser menor ou igual a {0}"),
      minValue: $.validator.format("O campo deve ser maior ou igual a {0}")
    });
  }

  function genericValidate(obj) {
    obj.validate({
      errorClass: 'ls-help-message',
      errorElement: 'small',
      submitHandler: function(form) {
        $(form).ajaxSubmit();
      },
      errorPlacement: function(error, element) {
        var prefixGroup = element.closest('.ls-prefix-group');

        if (prefixGroup.length) {
          element.attr('aria-label', error.text());
          prefixGroup.after(error);
        } else {
          element.attr('aria-label', error.text()).after(error);
        }
      },
      highlight: function(element, errorClass) {
        $(element).attr('aria-invalid', true).closest('.ls-label').addClass('ls-error');
      },
      unhighlight: function(element, errorClass) {
        $(element).removeAttr('aria-invalid').removeAttr('aria-label').closest('.ls-label').removeClass('ls-error');
      }
    });
    translateValidate();
  }

  function formValidate() {
    $('.validate').each(function() {
      genericValidate($(this));
    })
  }

  function init() {
    formValidate();
  }

  return {
    init: init
  };

}());

$(document).ready(validate.methods.init);

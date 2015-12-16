// Todos os elementos botão switch
$('.ls-switch-btn').on('switchButton:deactivated switchButton:activated', function() {
	$(this).next().trigger('click');
});

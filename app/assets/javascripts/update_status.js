// Update all swicth button elements
$('.ls-switch-btn').on('switchButton:deactivated switchButton:activated', function() {
	$(this).next().trigger('click');
});

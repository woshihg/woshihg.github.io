function calculateSettingAsThemeString({ localStorageTheme, systemSettingDark }) {
	if (localStorageTheme !== null) {
		return localStorageTheme;
	}

	if (systemSettingDark.matches) {
		return '1';
	}

	return '0';
}

function initTheme() {
	const localStorageTheme = localStorage.getItem("dark_mode");
	const systemSettingDark = window.matchMedia("(prefers-color-scheme: dark)");
	let currentThemeSetting = calculateSettingAsThemeString({ localStorageTheme, systemSettingDark });
	localStorage.setItem('dark_mode', currentThemeSetting);
	if (parseInt(currentThemeSetting)) {
		$('body').addClass('dark');
		$('.js-dark-toggle i').removeClass('fa-sun').addClass('fa-moon');
	}
}

function toggleDarkMode() {
	if ($('body').hasClass('dark')) {
	   $('body').css({
			opacity: 0,
			visibility: 'visible'
		}).animate({
			opacity: 1
		}, 400);
		$('body').removeClass('dark');
		$('.js-dark-toggle i').removeClass('fa-moon').addClass('fa-sun');
		localStorage.setItem('dark_mode', '0');
	} else {
	   $('body').css({
			opacity: 0,
			visibility: 'visible'
		}).animate({
			opacity: 1
		}, 400);
		$('body').addClass('dark');
		$('.js-dark-toggle i').removeClass('fa-sun').addClass('fa-moon');
		localStorage.setItem('dark_mode', '1');
	}
}

$(document).ready(function() {
	// get current URL path and assign 'active' class
	var pathname = window.location.pathname;
	$('.nav > a[href="'+pathname+'"]').addClass('active');
	// For Dark Mode
	initTheme();
});

window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
    toggleDarkMode();
});


$('.js-dark-toggle').click(function(e) {
	e.preventDefault();
	toggleDarkMode();
});

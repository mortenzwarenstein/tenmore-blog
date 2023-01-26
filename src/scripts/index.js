let menuOpen = false;
let toggle = false;

const clock = anime({
    targets: '#_js-button-clock',
    autoplay: false,
    translateX: -10,
    opacity: 0,
    loop: false,
    direction: 'reverse',
    easing: 'linear'
});

const arrow = anime({
    targets: '#_js-button-arrow',
    autoplay: false,
    translateX: 10,
    opacity: 0,
    loop: false,
    direction: 'normal',
});

const submitEmail = () => {
    if(!validateEmail()) return;
    clock.play();
    arrow.play();
    const emailInput = document.querySelector('#_js-email-input');
    // axios.post('http://localhost:8055/items/contacts', {
    //     email: emailInput.value
    // });
}

const validateEmail = () => {
    const emailInput = document.querySelector('#_js-email-input');
    const button = document.querySelector('#_js-submit-email');
    const errorMessage = document.querySelector('#_js-error-message')

    const BUTTON_CLASSES = ['bg-red-700', 'border-red-700'];
    const INPUT_CLASSES = ['border-red-700'];

    const valid = emailInput.value && /.+\@.+\..+/.test(emailInput.value);

    if(valid) {
        button.classList.remove(...BUTTON_CLASSES);
        button.disabled = false;
        emailInput.classList.remove(...INPUT_CLASSES);
        errorMessage.classList.add('hidden');
    } else {
        button.classList.add(...BUTTON_CLASSES);
        button.disabled = true
        emailInput.classList.add(...INPUT_CLASSES);
        errorMessage.classList.remove('hidden');
    }

    return valid;
}
const toggleLogo = (show) => {
    const logo = document.querySelector('#_js-logo');
    const navbar = document.querySelector('#_js-navbar');
    if(show) {
        logo.classList.remove('opacity-0')
        navbar.classList.add('shadow-xl');
    } else { 
        logo.classList.add('opacity-0');
        navbar.classList.remove('shadow-xl');
    };
}

const toggleMenu = () => {
    const navbarContent = document.querySelector('#_js-navbar-content');

    menuOpen = !menuOpen
    if(menuOpen) {
        navbarContent.classList.remove('h-0', 'overflow-hidden', 'opacity-0');
    } else {
        navbarContent.classList.add('h-0', 'overflow-hidden', 'opacity-0');
    }
}

const initObserver = () => {
    var observer = new IntersectionObserver((entries) => toggleLogo(entries[0].isIntersecting === false), { threshold: [0] });
    observer.observe(document.querySelector('#_js-total'));
}

const initListeners = () => {
    document.querySelector('#_js-toggle-menu')?.addEventListener('click', toggleMenu);
    document.querySelector('#_js-submit-email')?.addEventListener('click', submitEmail)
    document.querySelector('#_js-email-input')?.addEventListener('keyup', debounce(validateEmail, 500));
}

const initAnim = () => {
    const leftPart = document.querySelector('#_js-left-part');
    const rightPart = document.querySelector('#_js-right-part');
    const e = document.querySelector("#_js-e");
    const DELAY = 4000;
    const END_DELAY = 2000;
    // Letter E fadeout
    anime({
        targets: e,
        opacity: 0,
        loop: true,
        direction: 'alternate',
        delay: DELAY,
        endDelay: END_DELAY
    });

    // LEFT part transition
    anime({
        targets: leftPart,
        translateX: rightPart.offsetWidth - e.offsetWidth,
        loop: true,
        direction: 'alternate',
        delay: DELAY,
        endDelay: END_DELAY
    });

    // RIGHT part transition
    anime({
        targets: rightPart,
        translateX: - leftPart.offsetWidth,
        loop: true,
        direction: 'alternate',
        delay: DELAY,
        endDelay: END_DELAY
    });
}

const debounce = (callback, delay) => {
    let timeout;
    return function() {
        clearTimeout( timeout );
        timeout = setTimeout( callback, delay );
    }
}

const init = () => {
    initObserver();
    initAnim();
    initListeners();
}

document.addEventListener('DOMContentLoaded', () => {
    document.fonts.load('1rem "Oswald"').finally(init)
});
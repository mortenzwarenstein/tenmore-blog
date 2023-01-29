const emailInput = document.querySelector('#_js-email-input');
const button = document.querySelector('#_js-submit-email');
const errorMessage = document.querySelector('#_js-error-message');
const successMessage = document.querySelector('#_js-success-message');
const sections = document.querySelectorAll('section');
const links = document.querySelectorAll('.link-item');

const BUTTON_CLASSES = ['bg-red-700', 'border-red-700'];
const INPUT_CLASSES = ['border-red-700'];
const VALID_BUTTON_CLASSES = ['bg-green-700', 'border-green-700'];
const VALID_INPUT_CLASSES = ['border-green-700'];

let menuOpen = false;
let toggle = false;

const success = anime({
    targets: '#_js-button-success',
    autoplay: false,
    opacity: 1,
    loop: false,
});


const arrow = anime({
    autoplay: false,
    targets: '#_js-button-arrow',
    opacity: 0,
    loop: false,
});

const submitEmail = () => {
    if(!validateEmail()) return;
    // TODO: Make this dynamic
    axios.post('http://api.tenmore.tech/items/contacts', {
        email: emailInput.value
    }).then(val => {
        const saved = val.status === 200 || val.status === 204;
        if(saved) {
            arrow.play();
            success.play();
            displayFeedback(true);
        }
    }).catch(err => {
        displayFeedback(false, 'E-mail already exists in our system.');
    });
}

const resetFeedback = () => {
    button.disabled = false;
    emailInput.disabled = false;
    button.classList.remove(...VALID_BUTTON_CLASSES, ...BUTTON_CLASSES);
    emailInput.classList.remove(...VALID_INPUT_CLASSES, ...INPUT_CLASSES);
    errorMessage.classList.add('hidden')
    errorMessage.textContent = '';
}

const displayFeedback = (valid, message) => {
    if(valid) {
        button.disabled = false;
        emailInput.classList.add(...VALID_INPUT_CLASSES);
        button.classList.add(...VALID_BUTTON_CLASSES);
        emailInput.disabled = true;
        successMessage.classList.remove('hidden');
        button.disabled = true;
    } else {
        button.disabled = true;
        button.classList.add(...BUTTON_CLASSES);
        emailInput.classList.add(...INPUT_CLASSES);
        errorMessage.classList.remove('hidden');
        errorMessage.textContent = message;
    }

}

const validateEmail = (e) => {
    if(e?.key === 'Enter') submitEmail();
    const validInput = emailInput.value && /.+\@.+\..+/.test(emailInput.value);
    if(!validInput) displayFeedback(false, 'E-mail is required and needs to be valid!');
    else resetFeedback();

    return validInput;
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

const activateNav = () => {
    let current = '';
    sections.forEach((section) => {
        const sectionTop = section.offsetTop;
        if (window.scrollY >= sectionTop - 60) {
            current = section.getAttribute("id"); 
        }
        if(window.scrollY + window.innerHeight === document.documentElement.scrollHeight) current = sections[sections.length - 1].getAttribute('id');
      });
    
      links.forEach((li) => {
        li.classList.remove("text-blue-500");
        if (li.getAttribute("href").replace('#','') === current) {
          li.classList.add("text-blue-500");
        }
      });

}

const initObserver = () => {
    var observer = new IntersectionObserver((entries) => toggleLogo(entries[0].isIntersecting === false), { threshold: [0] });
    observer.observe(document.querySelector('#_js-total'));
}

const initListeners = () => {
    document.querySelector('#_js-toggle-menu')?.addEventListener('click', toggleMenu);
    button?.addEventListener('click', submitEmail);
    emailInput?.addEventListener('keyup', validateEmail);
    window.addEventListener('scroll', activateNav)
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
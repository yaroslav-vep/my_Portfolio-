// ─── NAVBAR: scroll effect + burger ───────────────
const navbar   = document.getElementById('navbar');
const burger   = document.getElementById('burger');
const navLinks = document.getElementById('navLinks');

window.addEventListener('scroll', () => {
  navbar.classList.toggle('scrolled', window.scrollY > 20);
  updateActiveLink();
});

burger.addEventListener('click', () => {
  navLinks.classList.toggle('open');
});

// Close mobile menu on link click
document.querySelectorAll('.nav-link').forEach(link => {
  link.addEventListener('click', () => navLinks.classList.remove('open'));
});

// Active link highlight based on scroll position
function updateActiveLink() {
  const sections = ['hero','about','skills','metrics','projects','contact'];
  const scrollY = window.scrollY + 100;
  let current = 'hero';
  sections.forEach(id => {
    const el = document.getElementById(id);
    if (el && el.offsetTop <= scrollY) current = id;
  });
  document.querySelectorAll('.nav-link').forEach(link => {
    link.classList.toggle('active', link.getAttribute('href') === `#${current}`);
  });
}

// ─── PARTICLES ────────────────────────────────────
(function createParticles() {
  const container = document.getElementById('heroParticles');
  const count = 40;
  for (let i = 0; i < count; i++) {
    const p = document.createElement('div');
    p.classList.add('particle');
    const isAlt = Math.random() > 0.6;
    p.style.cssText = `
      left: ${Math.random() * 100}%;
      bottom: ${Math.random() * -20}%;
      --dur: ${6 + Math.random() * 10}s;
      --delay: ${Math.random() * 8}s;
      --drift: ${(Math.random() - 0.5) * 120}px;
      background: ${isAlt ? '#a855f7' : '#00d4ff'};
      width: ${1.5 + Math.random() * 2.5}px;
      height: ${1.5 + Math.random() * 2.5}px;
      opacity: 0;
    `;
    container.appendChild(p);
  }
})();

// ─── COUNT-UP ANIMATION ───────────────────────────
function countUp(el, target, duration = 1800) {
  let start = 0;
  const step = Math.ceil(target / (duration / 16));
  const timer = setInterval(() => {
    start = Math.min(start + step, target);
    el.textContent = start;
    if (start >= target) clearInterval(timer);
  }, 16);
}

const statsObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      document.querySelectorAll('.stat-num').forEach(el => {
        countUp(el, parseInt(el.dataset.target));
      });
      statsObserver.disconnect();
    }
  });
}, { threshold: 0.5 });
const statsEl = document.querySelector('.hero-stats');
if (statsEl) statsObserver.observe(statsEl);

// ─── SKILL BAR ANIMATION ──────────────────────────
const skillBarsObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.querySelectorAll('.skill-bar').forEach(bar => {
        const w = bar.dataset.width;
        setTimeout(() => { bar.style.width = w + '%'; }, 150);
      });
    }
  });
}, { threshold: 0.3 });
document.querySelectorAll('.skill-card').forEach(card => skillBarsObserver.observe(card));

// ─── REVEAL ON SCROLL ─────────────────────────────
const revealObserver = new IntersectionObserver((entries) => {
  entries.forEach((entry, i) => {
    if (entry.isIntersecting) {
      // Staggered delay for grid items
      const siblings = Array.from(entry.target.parentElement.children);
      const idx = siblings.indexOf(entry.target);
      const delay = (idx % 4) * 80;
      setTimeout(() => {
        entry.target.classList.add('visible');
      }, delay);
      revealObserver.unobserve(entry.target);
    }
  });
}, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

document.querySelectorAll('.reveal').forEach(el => revealObserver.observe(el));

// ─── METRICS TABS ─────────────────────────────────
const tabs   = document.querySelectorAll('.metrics-tab');
const panels = document.querySelectorAll('.metrics-panel');

tabs.forEach(tab => {
  tab.addEventListener('click', () => {
    tabs.forEach(t => t.classList.remove('active'));
    panels.forEach(p => p.classList.remove('active'));
    tab.classList.add('active');
    const target = tab.dataset.tab;
    const panel = document.getElementById(`panel-${target}`);
    if (panel) panel.classList.add('active');
  });
});

// ─── CURSOR GLOW EFFECT ───────────────────────────
const glow = document.createElement('div');
glow.style.cssText = `
  position: fixed;
  width: 400px;
  height: 400px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(0,212,255,0.06) 0%, transparent 70%);
  pointer-events: none;
  z-index: 0;
  transform: translate(-50%, -50%);
  transition: opacity 0.3s;
`;
document.body.appendChild(glow);

let mouseX = 0, mouseY = 0;
let glowX = 0, glowY = 0;

document.addEventListener('mousemove', e => {
  mouseX = e.clientX;
  mouseY = e.clientY;
  glow.style.opacity = '1';
});

document.addEventListener('mouseleave', () => { glow.style.opacity = '0'; });

function animateGlow() {
  glowX += (mouseX - glowX) * 0.08;
  glowY += (mouseY - glowY) * 0.08;
  glow.style.left = glowX + 'px';
  glow.style.top  = glowY + 'px';
  requestAnimationFrame(animateGlow);
}
animateGlow();

// ─── NAVBAR CTA SHOW ON SCROLL ────────────────────
const navCta = document.getElementById('navCta');
window.addEventListener('scroll', () => {
  navCta.style.opacity = window.scrollY > 200 ? '1' : '0';
  navCta.style.pointerEvents = window.scrollY > 200 ? 'auto' : 'none';
});
navCta.style.opacity = '0';
navCta.style.transition = 'opacity 0.4s';

// ─── INIT ─────────────────────────────────────────
updateActiveLink();

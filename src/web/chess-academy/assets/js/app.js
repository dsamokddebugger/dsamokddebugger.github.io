// app.js - Chess Academy Interactivity Engine

// 20 AI Personas Database (from calibration.md & technical specs)
const personas = [
  { id: 0, name: "Sparky", elo: "400 - 500", style: "Absolute Beginner", category: "beginner", avatar: "⚡", depth: "1 / 1", skill: 0, multipv: 45, contempt: "N/A (0)", jitter: "80%", blunderGate: "9999.0 pawns", rules: ["Random moves, constant blunders, zero board vision.", "Adds massive evaluation noise to all legal moves, causing chaotic woodpushing."] },
  { id: 1, name: "Pawzy", elo: "600 - 750", style: "Novice / Pawn Obsessed", category: "beginner", avatar: "♟️", depth: "2 / 1", skill: 1, multipv: 30, contempt: "N/A (0)", jitter: "30%", blunderGate: "5.0 pawns", rules: ["Erratic novice obsessed with pawn promotions. Plays only pawns hoping one will queen.", "Pushing pawns gets +2.0 weight bonus.", "Moving non-king, non-pawn units triggers a -1.5 weight penalty."] },
  { id: 2, name: "Timorous", elo: "800 - 900", style: "Cowardly Defender", category: "beginner", avatar: "🐢", depth: "3 / 2", skill: 2, multipv: 20, contempt: "-100", jitter: "10%", blunderGate: "3.0 pawns", rules: ["Retreats pieces at first threat; plays extremely passive.", "Castling gets +1.5 weight bonus. Supported target squares get +1.0.", "Capturing opponent units gets a -0.5 penalty. Deep advances get a -1.0 penalty."] },
  { id: 3, name: "Rookie", elo: "900 - 1000", style: "Casual Woodpusher", category: "beginner", avatar: "🧱", depth: "5 / 3", skill: 3, multipv: 15, contempt: "N/A (0)", jitter: "6%", blunderGate: "2.0 pawns", rules: ["Captures undefended pieces immediately with no safety checks.", "General captures get a +0.5 weight bonus."] },
  { id: 4, name: "Scholar", elo: "1000 - 1100", style: "Tactical Trickster", category: "intermediate", avatar: "🎓", depth: "6 / 3", skill: 4, multipv: 12, contempt: "N/A (0)", jitter: "2%", blunderGate: "1.2 pawns", rules: ["Attempts cheap tactical traps and fast scholar mates.", "Before move 15, moves targeting weak F-pawns (F2/F7) get +2.0 weight.", "Moves giving check get a +1.0 weight bonus."] },
  { id: 5, name: "Molly", elo: "1100 - 1200", style: "Conservative Defender", category: "intermediate", avatar: "🍀", depth: "7 / 4", skill: 5, multipv: 10, contempt: "-50", jitter: "1.25%", blunderGate: "1.0 pawns", rules: ["Ultra-conservative. Locks positions with deep pawn walls.", "Pawn steps <= 1 rank get +0.6 weight. Moving beyond 4th rank gets a -0.3 penalty.", "Captures get a -1.5 weight penalty (unless in endgame or eval is >= 5.0)."] },
  { id: 6, name: "Berkserker", elo: "1200 - 1350", style: "Reckless Attacker", category: "intermediate", avatar: "🔥", depth: "8 / 4", skill: 6, multipv: 10, contempt: "+100", jitter: "0.8%", blunderGate: "0.9 pawns", rules: ["Highly aggressive, sacrifices units early to attack the king.", "Proximity to the opponent's king gives distance-based weight up to +1.5.", "Suboptimal captures get a +1.8 weight bonus."] },
  { id: 7, name: "Blaire", elo: "1350 - 1500", style: "Tactical Blitzer", category: "intermediate", avatar: "⚡", depth: "9 / 5", skill: 7, multipv: 8, contempt: "+50", jitter: "0.5%", blunderGate: "0.6 pawns", rules: ["Tactical rapid attacker targeting the king; leaves loose gaps.", "Knight or Bishop moves get +0.8 weight. Attacks on high-value units get +0.5.", "Retreating moves get a -0.4 weight penalty."] },
  { id: 8, name: "Python", elo: "1500 - 1600", style: "Positional Squeezer", category: "intermediate", avatar: "🐍", depth: "10 / 6", skill: 8, multipv: 4, contempt: "N/A (0)", jitter: "0.2%", blunderGate: "0.4 pawns", rules: ["Positional squeezer, loves closed positions and maneuvers.", "Restricting opponent mobility (leaving them with < 20 moves) gets +1.0 weight.", "Placing pieces on open files gets a -0.5 penalty (prefers closed files)."] },
  { id: 9, name: "Gambit", elo: "1600 - 1700", style: "Dynamic Imbalances", category: "intermediate", avatar: "🃏", depth: "11 / 7", skill: 9, multipv: 4, contempt: "+80", jitter: "0.15%", blunderGate: "0.5 pawns", rules: ["Chaos lover, makes wild sacrifices for dynamic imbalances.", "Evaluated moves dropping 0.5-4.0 pawns get +2.5 weight if they involve a capture or pawn push."] },
  { id: 10, name: "Trapper", elo: "1700 - 1800", style: "Opening Trap Specialist", category: "intermediate", avatar: "🕸️", depth: "12 / 8", skill: 10, multipv: 4, contempt: "N/A (0)", jitter: "0.1%", blunderGate: "0.4 pawns", rules: ["Lays opening traps, tricky lines, and poisoned pawns.", "Tricky captures dropping 0.3-1.5 pawns get +1.5 weight.", "Forks attacking >= 2 pieces get +1.2 weight (Queen) or +0.8 (minor pieces)."] },
  { id: 11, name: "Assassin", elo: "1800 - 1900", style: "Relentless Attacking Hunter", category: "advanced", avatar: "🎯", depth: "13 / 9", skill: 11, multipv: 4, contempt: "+100", jitter: "0.08%", blunderGate: "0.35 pawns", rules: ["Relentlessly hunts the king, sacrificing pieces to open files.", "Landing adjacent to opponent king gets +1.0 weight. Center pawn moves get +0.8.", "Attacking moves near the king dropping 0.5-2.5 pawns get +1.5 weight."] },
  { id: 12, name: "Vala", elo: "1900 - 2000", style: "Seasoned Tactician", category: "advanced", avatar: "🗡️", depth: "14 / 10", skill: 12, multipv: 4, contempt: "N/A (0)", jitter: "0.06%", blunderGate: "0.3 pawns", rules: ["Seasoned tactician, exploits uncoordinated units instantly.", "Moves giving check get +0.7. Fork moves targeting >= 2 units get +1.0.", "Captures maintaining positive evaluation get +0.5 weight."] },
  { id: 13, name: "Magician", elo: "2000 - 2150", style: "Creative Attacker", category: "advanced", avatar: "🔮", depth: "15 / 12", skill: 13, multipv: 3, contempt: "+100", jitter: "0.05%", blunderGate: "0.25 pawns", rules: ["Imaginative attacker, finds brilliant sacrifices and compensation.", "Creative sacrifices dropping 0.5-3.5 pawns that check or fork get +2.5 weight.", "Checks get a +1.0 weight bonus."] },
  { id: 14, name: "Sentinel", elo: "2150 - 2300", style: "Candidate Master", category: "advanced", avatar: "🏰", depth: "16 / 14", skill: 14, multipv: 2, contempt: "N/A (0)", jitter: "0.03%", blunderGate: "0.2 pawns", rules: ["Positional trap specialist, lulls opponents with solid play.", "Placing pieces on center ranks (4/5) and files (C/D/E/F) gets +0.8 weight.", "Supported Knights on central squares get +1.5 weight. Restricting opponent mobility gets +0.8."] },
  { id: 15, name: "Murphy", elo: "2300 - 2450", style: "Sea Storm Tactician", category: "advanced", avatar: "🌀", depth: "17 / 15", skill: 16, multipv: 2, contempt: "+80", jitter: "0.02%", blunderGate: "0.15 pawns", rules: ["Board-wide pawn storms, opens files for rapid rook attacks.", "Rooks or Queens occupying open files get +1.0 weight. Doubling on same file gets +1.5.", "Early minor piece development (move < 20) gets +1.0 weight."] },
  { id: 16, name: "Titan", elo: "2450 - 2600", style: "Grandmaster (Positional)", category: "advanced", avatar: "⛰️", depth: "18 / 18", skill: 18, multipv: 1, contempt: "N/A (0)", jitter: "0%", blunderGate: "0.1 pawns", rules: ["Grandmaster precision, strong relentless positional squeeze.", "Placing pieces on center squares (D/E files, 4/5 ranks) gets +0.3 weight.", "No random jitter noise applied to evaluation."] },
  { id: 17, name: "Alien", elo: "2600 - 2750", style: "Algorithmic Entity (AlphaZero)", category: "apex", avatar: "👽", depth: "19 / 19", skill: 18, multipv: 12, contempt: "N/A (0)", jitter: "0.5%", blunderGate: "0.3 pawns", rules: ["AlphaZero-style bot, highly complex and unintuitive moves.", "Only evaluates moves dropping < 0.3 pawns. Flank pawn moves get +1.5 weight.", "King moves between plies 10 and 35 get +1.2 weight. Backrank bishop retreats get +1.0."] },
  { id: 18, name: "Champ", elo: "2750 - 2900", style: "Universal Legend", category: "apex", avatar: "🏆", depth: "20 / 20", skill: 18, multipv: 1, contempt: "N/A (0)", jitter: "0%", blunderGate: "0.05 pawns", rules: ["Complete universal player, flawless openings/endgame book.", "Moves maintaining near-flawless evaluations (eval drop <= 0.05) get a +0.1 weight bonus."] },
  { id: 19, name: "King", elo: "2850 - 3200+", style: "The Ultimate Apex", category: "apex", avatar: "👑", depth: "22 / 22", skill: 20, multipv: 1, contempt: "N/A (0)", jitter: "0%", blunderGate: "0.0 pawns", rules: ["Ultimate apex, near-perfect computational engine, zero error.", "Bypasses persona weights completely. Plays the absolute top engine move calculated by Stockfish."] }
];

// Initialize DOM Components
document.addEventListener('DOMContentLoaded', () => {
  renderPersonas('all');
  setupFilters();
  setupModal();
  setupSidebarNavigation();
});

// Render Persona Cards
function renderPersonas(filter) {
  const container = document.getElementById('personas-container');
  if (!container) return;
  
  container.innerHTML = '';
  
  const filteredPersonas = filter === 'all' 
    ? personas 
    : personas.filter(p => p.category === filter);
    
  filteredPersonas.forEach(persona => {
    const card = document.createElement('div');
    card.className = 'glass-panel persona-card';
    card.innerHTML = `
      <div class="persona-avatar">${persona.avatar}</div>
      <div class="persona-name">${persona.name}</div>
      <div class="persona-elo">ELO ${persona.elo}</div>
      <div class="persona-style">${persona.style}</div>
    `;
    card.addEventListener('click', () => showPersonaDetails(persona));
    container.appendChild(card);
  });
}

// Setup Filters
function setupFilters() {
  const buttons = document.querySelectorAll('.filter-btn');
  buttons.forEach(btn => {
    btn.addEventListener('click', (e) => {
      buttons.forEach(b => b.classList.remove('active'));
      e.target.classList.add('active');
      const filter = e.target.getAttribute('data-filter');
      renderPersonas(filter);
    });
  });
}

// Show Modal Details
function showPersonaDetails(persona) {
  const modal = document.getElementById('personaModal');
  const body = document.getElementById('modalBody');
  if (!modal || !body) return;

  let rulesHtml = persona.rules.map(rule => `<li>${rule}</li>`).join('');

  body.innerHTML = `
    <div class="modal-avatar-wrapper">
      <div class="modal-avatar-icon">${persona.avatar}</div>
      <div>
        <h2>${persona.name}</h2>
        <p style="color: var(--accent-cyan); font-weight: 600;">FIDE Target: ${persona.elo} ELO</p>
        <p style="color: var(--text-secondary); font-size: 0.9rem;">Playstyle: ${persona.style}</p>
      </div>
    </div>
    
    <div class="modal-stats">
      <div class="modal-stat-row">
        <span class="modal-stat-label">Stockfish Skill Level:</span>
        <span class="modal-stat-value">${persona.skill}</span>
      </div>
      <div class="modal-stat-row">
        <span class="modal-stat-label">Contempt Value:</span>
        <span class="modal-stat-value">${persona.contempt}</span>
      </div>
      <div class="modal-stat-row">
        <span class="modal-stat-label">MultiPV / Depth (Rust):</span>
        <span class="modal-stat-value">${persona.multipv} PV / Depth ${persona.depth.split(' / ')[0]}</span>
      </div>
      <div class="modal-stat-row">
        <span class="modal-stat-label">Heuristic Jitter:</span>
        <span class="modal-stat-value">${persona.jitter}</span>
      </div>
      <div class="modal-stat-row">
        <span class="modal-stat-label">Blunder Gate Threshold:</span>
        <span class="modal-stat-value">${persona.blunderGate}</span>
      </div>
    </div>
    
    <h3 style="margin-top: 24px; font-size: 1.1rem; border-bottom: 1px solid var(--panel-border); padding-bottom: 8px;">Core Calibration Rules:</h3>
    <ul class="rules-list">
      ${rulesHtml}
    </ul>
  `;

  modal.style.display = 'flex';
}

// Setup Modal Close Triggers
function setupModal() {
  const modal = document.getElementById('personaModal');
  const close = document.getElementById('closeModal');
  if (!modal || !close) return;

  close.addEventListener('click', () => {
    modal.style.display = 'none';
  });

  window.addEventListener('click', (e) => {
    if (e.target === modal) {
      modal.style.display = 'none';
    }
  });
}

// Active Sidebar Navigation Highlights
function setupSidebarNavigation() {
  const sections = document.querySelectorAll('.manual-section');
  const navLinks = document.querySelectorAll('.sidebar-nav a');
  if (sections.length === 0 || navLinks.length === 0) return;

  const observerOptions = {
    root: null,
    rootMargin: '-20% 0px -60% 0px',
    threshold: 0
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const id = entry.target.getAttribute('id');
        navLinks.forEach(link => {
          link.classList.remove('active');
          if (link.getAttribute('href') === `#${id}`) {
            link.classList.add('active');
          }
        });
      }
    });
  }, observerOptions);

  sections.forEach(section => observer.observe(section));

  // Smooth Scroll
  navLinks.forEach(link => {
    link.addEventListener('click', (e) => {
      e.preventDefault();
      const targetId = link.getAttribute('href');
      const targetSection = document.querySelector(targetId);
      if (targetSection) {
        targetSection.scrollIntoView({ behavior: 'smooth' });
      }
    });
  });
}

import './style.css'
import { UserObject } from './UserObject'

const user = new UserObject()

// DOM Elements
const btnImperial = document.querySelector<HTMLButtonElement>('#btn-imperial')!
const btnMetric = document.querySelector<HTMLButtonElement>('#btn-metric')!
const inputGender = document.querySelector<HTMLSelectElement>('#gender')!
const inputAge = document.querySelector<HTMLInputElement>('#age')!
const inputWeight = document.querySelector<HTMLInputElement>('#weight')!
const unitWeight = document.querySelector<HTMLElement>('#unit-weight')!
const inputHeightFt = document.querySelector<HTMLInputElement>('#height-ft')!
const inputHeightIn = document.querySelector<HTMLInputElement>('#height-in')!
const inputHeightCm = document.querySelector<HTMLInputElement>('#height-cm')!
const divHeightImperial = document.querySelector<HTMLElement>('#height-imperial')!
const divHeightMetric = document.querySelector<HTMLElement>('#height-metric')!
const inputActivity = document.querySelector<HTMLSelectElement>('#activity')!

// New Inputs
const inputWaist = document.querySelector<HTMLInputElement>('#waist')!
const unitWaist = document.querySelector<HTMLElement>('#unit-waist')!
const inputBf = document.querySelector<HTMLInputElement>('#bfpct')!
const inputCycle = document.querySelector<HTMLSelectElement>('#cycle-split')!

// Advanced Inputs
const inputBmrMethod = document.querySelector<HTMLSelectElement>('#bmr-method')!
const inputProteinMethod = document.querySelector<HTMLSelectElement>('#protein-method')!
const inputWorkoutsWeek = document.querySelector<HTMLInputElement>('#workouts-week')!

// Sliders and TDEE %
const inputRestTdeePct = document.querySelector<HTMLInputElement>('#rest-tdee-pct')!
const spanRestCalsDisplay = document.querySelector<HTMLElement>('#rest-cals-display')!

const inputRestPSlider = document.querySelector<HTMLInputElement>('#rest-p-slider')!
const inputRestCSlider = document.querySelector<HTMLInputElement>('#rest-c-slider')!
const inputRestFSlider = document.querySelector<HTMLInputElement>('#rest-f-slider')!
const spanRestPVal = document.querySelector<HTMLElement>('#rest-p-val')!
const spanRestCVal = document.querySelector<HTMLElement>('#rest-c-val')!
const spanRestFVal = document.querySelector<HTMLElement>('#rest-f-val')!

const inputWorkoutTdeePct = document.querySelector<HTMLInputElement>('#workout-tdee-pct')!
const spanWorkoutCalsDisplay = document.querySelector<HTMLElement>('#workout-cals-display')!

const inputWorkoutPSlider = document.querySelector<HTMLInputElement>('#workout-p-slider')!
const inputWorkoutCSlider = document.querySelector<HTMLInputElement>('#workout-c-slider')!
const inputWorkoutFSlider = document.querySelector<HTMLInputElement>('#workout-f-slider')!
const spanWorkoutPVal = document.querySelector<HTMLElement>('#workout-p-val')!
const spanWorkoutCVal = document.querySelector<HTMLElement>('#workout-c-val')!
const spanWorkoutFVal = document.querySelector<HTMLElement>('#workout-f-val')!

// Results
const resBmr = document.querySelector<HTMLElement>('#res-bmr')!
const resTdee = document.querySelector<HTMLElement>('#res-tdee')!
const resBmi = document.querySelector<HTMLElement>('#res-bmi')!
const resBf = document.querySelector<HTMLElement>('#res-bf')!
const resLbm = document.querySelector<HTMLElement>('#res-lbm')!

// Summary
const sumTee = document.querySelector<HTMLElement>('#sum-tee')!
const sumTdee = document.querySelector<HTMLElement>('#sum-tdee')!
const sumCals = document.querySelector<HTMLElement>('#sum-cals')!
const sumOver = document.querySelector<HTMLElement>('#sum-over')!
const sumChange = document.querySelector<HTMLElement>('#sum-change')!

// Macro Areas
const divRestMacros = document.querySelector<HTMLElement>('#rest-macros')!
const divWorkoutMacros = document.querySelector<HTMLElement>('#workout-macros')!

// Pie Charts
const restPieChart = document.querySelector<HTMLElement>('#rest-pie-chart')!
const workoutPieChart = document.querySelector<HTMLElement>('#workout-pie-chart')!

// Tabs
const tabBtns = document.querySelectorAll('.tab-btn')
const tabContents = document.querySelectorAll('.tab-content')

// State to track if we are manually editing sliders (to prevent overwrite by calculate())
let isManualEdit = false;

function init() {
  // Set defaults
  user.age = 25
  user.weight = 150 
  user.height = 5   
  user.heightin = 10 
  user.activity = 1.2
  user.waist = 32
  
  // Tab Logic
  setupTabs()

  updateInputsFromState()
  calculate()
  
  setupListeners()
}

function setupTabs() {
    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const target = (btn as HTMLElement).dataset.tab;
            
            // Toggle Buttons
            tabBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            // Toggle Content
            tabContents.forEach(c => {
                c.classList.add('hidden');
                c.classList.remove('active');
                if (c.id === `tab-${target}`) {
                    c.classList.remove('hidden');
                    c.classList.add('active');
                }
            });
        });
    });
}

function setupListeners() {
  // Unit Toggle
  btnImperial.addEventListener('click', () => setUnit('imperial'))
  btnMetric.addEventListener('click', () => setUnit('metric'))

  // Inputs
  const inputs = [
      inputAge, inputWeight, inputHeightFt, inputHeightIn, inputHeightCm, 
      inputGender, inputActivity, inputWaist, inputBf, inputCycle,
      inputBmrMethod, inputProteinMethod, inputWorkoutsWeek,
      inputRestTdeePct, inputWorkoutTdeePct
  ]
  
  inputs.forEach(input => {
    input.addEventListener('input', (e) => handleInput(e))
  })

  // Sliders separate handling
  const sliders = [
      inputRestPSlider, inputRestCSlider, inputRestFSlider,
      inputWorkoutPSlider, inputWorkoutCSlider, inputWorkoutFSlider
  ];
  sliders.forEach(s => s.addEventListener('input', (e) => handleSliderChange(e)));
}

function setUnit(unit: 'imperial' | 'metric') {
  if (unit === 'metric' && !user.metric) {
    user.toMetric()
    btnMetric.classList.add('active')
    btnImperial.classList.remove('active')
    divHeightMetric.classList.remove('hidden')
    divHeightImperial.classList.add('hidden')
    unitWeight.textContent = '(kg)'
    unitWaist.textContent = '(cm)'
  } else if (unit === 'imperial' && user.metric) {
    user.toImperial()
    btnImperial.classList.add('active')
    btnMetric.classList.remove('active')
    divHeightImperial.classList.remove('hidden')
    divHeightMetric.classList.add('hidden')
    unitWeight.textContent = '(lbs)'
    unitWaist.textContent = '(in)'
  }
  updateInputsFromState()
  calculate()
}

function updateInputsFromState() {
  inputAge.value = user.age.toString()
  inputWeight.value = user.weight.toString()
  inputGender.value = user.genderMale ? 'male' : 'female'
  inputActivity.value = user.activity.toString()
  inputWaist.value = user.waist.toString()
  inputBf.value = user.bfpct > 0 ? user.bfpct.toString() : ''
  inputBmrMethod.value = user.bmrformula;

  if (user.metric) {
    inputHeightCm.value = user.height.toString()
  } else {
    inputHeightFt.value = user.height.toString()
    inputHeightIn.value = user.heightin.toString()
  }
}

function handleInput(e: Event) {
  isManualEdit = false;
  const target = e.target as HTMLElement;

  // Update State from Inputs
  user.age = parseFloat(inputAge.value) || 0
  user.genderMale = inputGender.value === 'male'
  user.activity = parseFloat(inputActivity.value) || 1.2
  
  user.weight = parseFloat(inputWeight.value) || 0
  user.waist = parseFloat(inputWaist.value) || 0
  
  // Set BMR Formula
  user.bmrformula = inputBmrMethod.value;

  // Handle Manual BF Override vs Auto Calc
  if (target === inputBf) {
      if (inputBf.value) {
          user.bfpct = parseFloat(inputBf.value);
          // Recalc LBM/Fat manually based on this
          user.fat = (user.bfpct / 100) * user.weight;
          user.lbm = user.weight - user.fat;
      } else {
          user.bfpct = 0; 
      }
  }

  if (user.metric) {
    user.height = parseFloat(inputHeightCm.value) || 0
  } else {
    user.height = parseFloat(inputHeightFt.value) || 0
    user.heightin = parseFloat(inputHeightIn.value) || 0
  }

  // Workouts
  user.cycleworkouts = parseInt(inputWorkoutsWeek.value) || 3;

  // Logic for Cycle Strategy vs Custom inputs
  if (target === inputCycle) {
      const cycle = inputCycle.value;
      if (cycle !== 'custom') {
        updateCycleSplit(cycle);
      }
  } else if (target === inputRestTdeePct || target === inputWorkoutTdeePct) {
      // If manually changing percentages, switch to custom
      inputCycle.value = 'custom';
  }

  calculate()
}

function handleSliderChange(e: Event) {
    e.preventDefault();
    isManualEdit = true;
    inputCycle.value = 'custom';
    
    // Update Grams directly from Sliders
    const rP = parseInt(inputRestPSlider.value);
    const rC = parseInt(inputRestCSlider.value);
    const rF = parseInt(inputRestFSlider.value);
    
    const wP = parseInt(inputWorkoutPSlider.value);
    const wC = parseInt(inputWorkoutCSlider.value);
    const wF = parseInt(inputWorkoutFSlider.value);
    
    // Update Displays
    spanRestPVal.textContent = rP + 'g';
    spanRestCVal.textContent = rC + 'g';
    spanRestFVal.textContent = rF + 'g';
    spanWorkoutPVal.textContent = wP + 'g';
    spanWorkoutCVal.textContent = wC + 'g';
    spanWorkoutFVal.textContent = wF + 'g';

    // Update User Object Manually
    user.restCollection[0].grams = rP;
    user.restCollection[1].grams = rC;
    user.restCollection[2].grams = rF;
    
    user.workoutCollection[0].grams = wP;
    user.workoutCollection[1].grams = wC;
    user.workoutCollection[2].grams = wF;
    
    // Recalc Calories from Grams
    const restCals = (rP * 4) + (rC * 4) + (rF * 9);
    const workCals = (wP * 4) + (wC * 4) + (wF * 9);
    
    user.restcals = restCals;
    user.workoutcals = workCals;
    
    // Update PCT/Cals on object
    user.restCollection[0].cals = rP * 4; user.restCollection[0].pct = (rP * 4 / restCals) * 100;
    user.restCollection[1].cals = rC * 4; user.restCollection[1].pct = (rC * 4 / restCals) * 100;
    user.restCollection[2].cals = rF * 9; user.restCollection[2].pct = (rF * 9 / restCals) * 100;
    
    user.workoutCollection[0].cals = wP * 4; user.workoutCollection[0].pct = (wP * 4 / workCals) * 100;
    user.workoutCollection[1].cals = wC * 4; user.workoutCollection[1].pct = (wC * 4 / workCals) * 100;
    user.workoutCollection[2].cals = wF * 9; user.workoutCollection[2].pct = (wF * 9 / workCals) * 100;

    // Recalc TDEE % based on new calories
    if (user.tdee > 0) {
        user.restDayTdeePct = ((restCals / user.tdee) * 100) - 100;
        user.workoutDayTdeePct = ((workCals / user.tdee) * 100) - 100;
        
        // Update UI for %
        inputRestTdeePct.value = Math.round(user.restDayTdeePct).toString();
        inputWorkoutTdeePct.value = Math.round(user.workoutDayTdeePct).toString();
    }
    
    // Re-render
    renderMacros()
    renderSummary()
}

function updateCycleSplit(cycle: string) {
    let r = -20, w = 20;
    switch(cycle) {
        case 'recomp': r=-20; w=20; break;
        case 'cut': r=-20; w=0; break;
        case 'hardcut': r=-30; w=-10; break;
        case 'leanbulk': r=-10; w=20; break;
        case 'maintain': r=0; w=0; break;
    }
    inputRestTdeePct.value = r.toString();
    inputWorkoutTdeePct.value = w.toString();
}

function calculate() {
  // 1. Basic Calcs
  user.calcBmr()
  user.calcBmi()
  
  if (!isManualEdit) {
      // 2. Macro Calcs (AUTO MODE)
      // Handle Protein Method
      user.proteinFormula = inputProteinMethod.value;
      
      // Handle Percents
      const restPct = parseFloat(inputRestTdeePct.value) || 0;
      const workPct = parseFloat(inputWorkoutTdeePct.value) || 0;
      user.setDaySplit(restPct, workPct);

      // Handle Sliders Sync with Auto
      // We rely on user.restCollection populated by setDaySplit -> calcMacros
      user.setMacroSplit(50, 50, 50, 50); // Default split if not manual? Or should we remove this if custom?
      // Actually we probably want to support the old Split logic OR the new Slider logic.
      // For now, let's say "Standard Recomp" sets default 50/50 split. 
      // If we want detailed split control without sliders, we'd keep the Split Dropdown, but user said remove it.
      // So detailed split control is now MANUAL ONLY via sliders.
      
      // So here, we just run standard calcMacros which sets P/C/F based on defaults/old logic
      // And then we update the sliders to match the calculated grams.
      updateSlidersFromCalculated();
  }

  // Render Basics
  resBmr.textContent = Math.round(user.bmr).toLocaleString()
  resTdee.textContent = Math.round(user.tdee).toLocaleString()
  resBmi.textContent = user.bmi.toString()
  
  resBf.textContent = user.bfpct > 0 ? user.bfpct + '%' : '--';
  resLbm.textContent = user.lbm > 0 ? Math.round(user.lbm) + (user.metric ? ' kg' : ' lbs') : '--';

  // Render Macros
  if (user.tdee > 0) {
      renderMacros()
      renderSummary()
  }
}

function updateSlidersFromCalculated() {
    // Rest
    const rP = Math.round(user.restCollection[0].grams);
    const rC = Math.round(user.restCollection[1].grams);
    const rF = Math.round(user.restCollection[2].grams);
    inputRestPSlider.value = rP.toString();
    inputRestCSlider.value = rC.toString();
    inputRestFSlider.value = rF.toString();
    spanRestPVal.textContent = rP + 'g';
    spanRestCVal.textContent = rC + 'g';
    spanRestFVal.textContent = rF + 'g';

    // Workout
    const wP = Math.round(user.workoutCollection[0].grams);
    const wC = Math.round(user.workoutCollection[1].grams);
    const wF = Math.round(user.workoutCollection[2].grams);
    inputWorkoutPSlider.value = wP.toString();
    inputWorkoutCSlider.value = wC.toString();
    inputWorkoutFSlider.value = wF.toString();
    spanWorkoutPVal.textContent = wP + 'g';
    spanWorkoutCVal.textContent = wC + 'g';
    spanWorkoutFVal.textContent = wF + 'g';
}

function updatePieChart(element: HTMLElement, pPct: number, cPct: number, fPct: number) {
    // Create conic gradient based on percentages
    // Start at -90deg to start from top
    const pEnd = pPct * 3.6; // Convert % to degrees
    const cEnd = pEnd + (cPct * 3.6);
    const fEnd = cEnd + (fPct * 3.6);
    
    element.style.background = `conic-gradient(
        from -90deg,
        #ef4444 0deg,
        #ef4444 ${pEnd}deg,
        #10b981 ${pEnd}deg,
        #10b981 ${cEnd}deg,
        #f59e0b ${cEnd}deg,
        #f59e0b ${fEnd}deg
    )`;
}

function renderMacros() {
    spanRestCalsDisplay.textContent = Math.round(user.restcals).toLocaleString() + ' kcal';
    spanWorkoutCalsDisplay.textContent = Math.round(user.workoutcals).toLocaleString() + ' kcal';

    renderMacroList(divRestMacros, user.restCollection);
    renderMacroList(divWorkoutMacros, user.workoutCollection);
    
    // Update pie charts
    updatePieChart(
        restPieChart,
        user.restCollection[0].pct,
        user.restCollection[1].pct,
        user.restCollection[2].pct
    );
    
    updatePieChart(
        workoutPieChart,
        user.workoutCollection[0].pct,
        user.workoutCollection[1].pct,
        user.workoutCollection[2].pct
    );
}

function renderMacroList(container: HTMLElement, collection: any[]) {
    container.innerHTML = '';
    collection.forEach(item => {
        const row = document.createElement('div');
        row.className = 'macro-row';
        row.innerHTML = `
            <span class="macro-name">${item.name}</span>
            <span class="macro-val">
                ${Math.round(item.pct)}% 
                <span class="macro-grams">${Math.round(item.grams)}g</span>
            </span>
        `;
        container.appendChild(row);
    });
}

function renderSummary() {
    const workouts = user.cycleworkouts;
    const rests = 7 - workouts;

    const tdeeDaily = user.tdee;
    const weekCals = (user.restcals * rests) + (user.workoutcals * workouts);
    const weekDiff = weekCals - (tdeeDaily * 7);
    const weekChange = weekDiff / 3500;

    sumTee.textContent = Math.round(tdeeDaily * 7).toLocaleString(); 
    sumTdee.textContent = Math.round(tdeeDaily * 7).toLocaleString(); 
    sumCals.textContent = Math.round(weekCals).toLocaleString();
    
    const sign = weekDiff > 0 ? '+' : '';
    sumOver.textContent = `${sign}${Math.round(weekDiff)}`;
    sumOver.style.color = weekDiff < 0 ? 'var(--success)' : 'var(--warning)';

    sumChange.textContent = `${sign}${weekChange.toFixed(2)}`;
    sumChange.style.color = weekChange < 0 ? 'var(--success)' : 'var(--warning)';
}

init()

export class UserObject {
    public metric: boolean = false;
    public height: number = 0; // Feet if imperial, CM if metric
    public heightin: number = 0;
    public weight: number = 0; // Lbs if imperial, KG if metric
    public age: number = 0;
    public activity: number = 1.2;
    public genderMale: boolean = true;
    public waist: number = 0;
    public bfpct: number = 0;
    public waistToHeight: number = 0;
    public fat: number = 0;
    public lbm: number = 0;
    public bmrformula: string = "msj";
    public tdeeformula: string = "";
    public bmr: number = 0;
    public tdee: number = 0;
    public bmi: number = 0;
    public mincals: number = 0;
    public cycledays: number = 7;
    public cycleworkouts: number = 3;
    public restcals: number = 0;
    public workoutcals: number = 0;
    public proteinFormula: string = "1glb";

    // Collections for Macros (simulating ArrayCollection structures)
    public restCollection = [
        { name: "Protein", cals: 0, grams: 0, pct: 0, split: 0 },
        { name: "Carbs", cals: 0, grams: 0, pct: 0, split: 0 },
        { name: "Fat", cals: 0, grams: 0, pct: 0, split: 0 }
    ];
    public workoutCollection = [
        { name: "Protein", cals: 0, grams: 0, pct: 0, split: 0 },
        { name: "Carbs", cals: 0, grams: 0, pct: 0, split: 0 },
        { name: "Fat", cals: 0, grams: 0, pct: 0, split: 0 }
    ];

    public restDayTdeePct: number = -20;
    public workoutDayTdeePct: number = 20;

    constructor() {}

    // ... existing conversion methods (toMetric, toImperial, etc.) ...
    
    // Helper to round like ActionScript
    private round(num: number, precision: number): number {
        const factor = Math.pow(10, precision);
        return Math.round(num * factor) / factor;
    }

    public toMetric(): void {
        this.height = Math.round((this.height * 12 + this.heightin) * 2.54 * 10) / 10;
        this.weight = Math.round(this.weight / 2.2 * 10) / 10;
        this.waist = Math.round(this.waist * 2.54 * 100) / 100;
        this.metric = true;
    }

    public toImperial(): void {
        const totalInches = this.height / 2.54;
        this.heightin = Math.round(totalInches) % 12;
        this.height = Math.floor(totalInches / 12);
        this.weight = Math.round(this.weight * 2.2);
        this.waist = Math.round(this.waist / 2.54 * 100) / 100;
        this.metric = false;
    }

    // getters for conversions
    public pounds(): number { return this.metric ? this.weight * 2.2 : this.weight; }
    public fatpounds(): number { return this.metric ? this.fat * 2.2 : this.fat; }
    public kg(): number { return this.metric ? this.weight : this.weight / 2.2; }
    public cm(): number { return this.metric ? this.height : (this.height * 12 + this.heightin) * 2.54; }
    public inches(): number { return this.metric ? this.height / 2.54 : (this.height * 12 + this.heightin); }
    public waistinches(): number { return this.metric ? this.waist / 2.54 : this.waist; }

    // Logic from calcBasics to calculate Body Fat from Waist
    public calcBodyFatFromWaist(): void {
        if (this.waist > 0 && this.age > 0 && this.weight > 0) {
           let calculatedBf = 0;
           if (this.genderMale) {
                // 100 * (-98.42 + 4.15 * waistinches - 0.082 * pounds) / pounds
                calculatedBf = 100 * (-98.42 + 4.15 * this.waistinches() - 0.082 * this.pounds()) / this.pounds();
           } else {
                // 100 * (-76.76 + 4.15 * waistinches - 0.082 * pounds) / pounds
                calculatedBf = 100 * (-76.76 + 4.15 * this.waistinches() - 0.082 * this.pounds()) / this.pounds();
           }
           this.bfpct = this.round(calculatedBf, 1);
           
           if (this.bfpct > 0) {
               this.fat = (this.bfpct / 100) * this.weight;
               this.lbm = this.weight - this.fat;
           }
        }
    }

    // BMR Calculations
    private calcBmrMSJ(): number {
        if (this.genderMale) {
            return 9.99 * this.kg() + 6.25 * this.cm() - 4.92 * this.age + 5;
        }
        return 9.99 * this.kg() + 6.25 * this.cm() - 4.92 * this.age - 161;
    }

    private calcBmrHB(): number {
        if (this.genderMale) {
            return 66 + 6.23 * this.pounds() + 12.7 * this.inches() - 6.8 * this.age;
        }
        return 655 + 4.35 * this.pounds() + 4.7 * this.inches() - 4.7 * this.age;
    }

    private calcBmrKM(): number {
         let leanMass = this.metric ? this.lbm : this.lbm / 2.2;
         // If LBM is not set, try to derive it if BF% is present, otherwise fallback
         if (leanMass === 0 && this.bfpct > 0) {
             leanMass = this.kg() * (1 - (this.bfpct/100));
         }
         return 370 + 21.6 * leanMass;
    }

    public calcBmr(): void {
        // Auto-calculate BF/LBM if waist is present
        this.calcBodyFatFromWaist();

        switch (this.bmrformula) {
            case "msj": this.bmr = this.calcBmrMSJ(); break;
            case "hb": this.bmr = this.calcBmrHB(); break;
            case "km": this.bmr = this.calcBmrKM(); break;
            case "average": this.bmr = (this.calcBmrHB() + this.calcBmrKM() + this.calcBmrMSJ()) / 3; break;
        }
        
        if (this.tdeeformula === "") {
            this.tdee = this.bmr * this.activity;
        }
        
        this.bmr = Math.round(this.bmr);
        this.tdee = Math.round(this.tdee);
    }

    public calcBmi(): void {
        const inches = this.inches();
        if (inches > 0) {
            this.bmi = (this.pounds() / Math.pow(inches, 2)) * 703;
            this.bmi = this.round(this.bmi, 1);
        }
    }

    // --- New Macro Logic ---

    public setDaySplit(restPct: number, workoutPct: number): void {
        this.restDayTdeePct = restPct;
        this.workoutDayTdeePct = workoutPct;
        this.calcDayCalories();
    }
    
    public calcDayCalories(): void {
        // Rest Days
        this.restcals = this.tdee * ((100 + this.restDayTdeePct) / 100);
        
        // Workout Days
        this.workoutcals = this.tdee * ((100 + this.workoutDayTdeePct) / 100);
        
        this.restcals = Math.round(this.restcals);
        this.workoutcals = Math.round(this.workoutcals);
    }

    public setMacroSplit(rC: number, rF: number, wC: number, wF: number): void {
        // Inputs are % split for Carbs/Fat. Protein is fixed/calculated first usually.
        // Actually looking at AS code: 
        // 50/50 - 50/50 means Rest(Carb/Fat split) - Workout(Carb/Fat split)
        // AFTER protein is deducted.
        
        // Set splits in collections
        this.restCollection[1].split = rC; // Carbs
        this.restCollection[2].split = rF; // Fat
        
        this.workoutCollection[1].split = wC;
        this.workoutCollection[2].split = wF;
        
        this.calcMacros();
    }

    public calcMacros(): void {
        this.calcRestMacros();
        this.calcWorkoutMacros();
    }



    // ...

    private getProteinGrams(): number {
        switch(this.proteinFormula) {
            case "1.5glbm":
                // 1.5g per lb LBM
                const lbmLbs = this.metric ? this.lbm * 2.20462 : this.lbm;
                return this.lbm > 0 ? lbmLbs * 1.5 : this.pounds();
            case "3gkg":
                // 3g per kg bodyweight
                return this.kg() * 3;
            case "1glb":
            default:
                // 1g per lb bodyweight
                return this.pounds();
        }
    }

    private calcRestMacros(): void {
        const proteinGrams = this.getProteinGrams();
        
        const proteinRow = this.restCollection[0];
        const carbRow = this.restCollection[1];
        const fatRow = this.restCollection[2];

        // Protein
        proteinRow.grams = proteinGrams;
        proteinRow.cals = proteinRow.grams * 4;
        proteinRow.pct = (proteinRow.cals / this.restcals) * 100;

        // Remaining calories for Carbs/Fats
        let remainingPct = 100 - proteinRow.pct;
        if (remainingPct < 0) remainingPct = 0;
        
        // Carbs
        carbRow.pct = remainingPct * (carbRow.split / 100);
        carbRow.cals = this.restcals * (carbRow.pct / 100);
        carbRow.grams = carbRow.cals / 4;

        // Fat
        fatRow.pct = remainingPct * (fatRow.split / 100);
        fatRow.cals = this.restcals * (fatRow.pct / 100);
        fatRow.grams = fatRow.cals / 9;
    }

    private calcWorkoutMacros(): void {
        const proteinGrams = this.getProteinGrams();

        const proteinRow = this.workoutCollection[0];
        const carbRow = this.workoutCollection[1];
        const fatRow = this.workoutCollection[2];

        // Protein
        proteinRow.grams = proteinGrams;
        proteinRow.cals = proteinRow.grams * 4;
        proteinRow.pct = (proteinRow.cals / this.workoutcals) * 100;

        // Remaining
        let remainingPct = 100 - proteinRow.pct;
        if (remainingPct < 0) remainingPct = 0;

        // Carbs
        carbRow.pct = remainingPct * (carbRow.split / 100);
        carbRow.cals = this.workoutcals * (carbRow.pct / 100);
        carbRow.grams = carbRow.cals / 4;

        // Fat
        fatRow.pct = remainingPct * (fatRow.split / 100);
        fatRow.cals = this.workoutcals * (fatRow.pct / 100);
        fatRow.grams = fatRow.cals / 9;
    }
}

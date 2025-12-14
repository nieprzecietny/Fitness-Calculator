package IFComponents
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class UserObject implements IEventDispatcher
   {
       
      
      private var _1077545552metric:Boolean = false;
      
      private var _1221029593height:Number = 0;
      
      private var _883363700heightin:int = 0;
      
      private var _791592328weight:Number = 0;
      
      private var _96511age:Number = 0;
      
      private var _1655966961activity:Number = 1.2;
      
      private var _939449234genderMale:Boolean = true;
      
      private var _112893312waist:Number = 0;
      
      private var _93654557bfpct:Number = 0;
      
      private var _1297679650waistToHeight:Number = 0;
      
      private var _101145fat:Number = 0;
      
      private var _106935lbm:Number = 0;
      
      private var _1088037377bmrformula:String = "msj";
      
      private var _919011414tdeeformula:String = "";
      
      private var _97671bmr:Number = 0;
      
      private var _3555088tdee:Number = 0;
      
      private var _97662bmi:Number = 0;
      
      private var _1064347575mincals:Number = 0;
      
      private var _1560828355cycledays:int = 7;
      
      private var _70214748cycleworkouts:int = 3;
      
      private var _336999367restcals:Number = 0;
      
      private var _1372202626workoutcals:Number = 0;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function UserObject()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public function toMetric() : void
      {
         this.height = Math.round((this.height * 12 + this.heightin) * 2.54 * 10) / 10;
         this.weight = Math.round(this.weight / 2.2 * 10) / 10;
         this.waist = Math.round(this.waist * 2.54 * 100) / 100;
      }
      
      public function toImperial() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         _loc1_ = this.height / 2.54;
         this.heightin = _loc1_ % 12;
         this.height = Math.round((_loc1_ - this.heightin) / 12);
         this.weight = Math.round(this.weight * 2.2);
         this.waist = Math.round(this.waist / 2.54 * 100) / 100;
      }
      
      public function pounds() : Number
      {
         return !!this.metric?Number(this.weight * 2.2):Number(this.weight);
      }
      
      public function fatpounds() : Number
      {
         return !!this.metric?Number(this.fat * 2.2):Number(this.fat);
      }
      
      public function kg() : Number
      {
         return !!this.metric?Number(this.weight):Number(this.weight / 2.2);
      }
      
      public function cm() : Number
      {
         return !!this.metric?Number(this.height):Number((this.height * 12 + this.heightin) * 2.54);
      }
      
      public function inches() : Number
      {
         return !!this.metric?Number(this.height / 2.54):Number(this.height * 12 + this.heightin);
      }
      
      public function waistinches() : Number
      {
         return !!this.metric?Number(this.waist / 2.54):Number(this.waist);
      }
      
      private function calcBmrMSJ() : Number
      {
         if(this.genderMale)
         {
            return 9.99 * this.kg() + 6.25 * this.cm() - 4.92 * this.age + 5;
         }
         return 9.99 * this.kg() + 6.25 * this.cm() - 4.92 * this.age - 161;
      }
      
      private function calcBmrHB() : Number
      {
         if(this.genderMale)
         {
            return 66 + 6.23 * this.pounds() + 12.7 * this.inches() - 6.8 * this.age;
         }
         return 655 + 4.35 * this.pounds() + 4.7 * this.inches() - 4.7 * this.age;
      }
      
      private function calcBmrKM() : Number
      {
         if(this.metric)
         {
            return 370 + 21.6 * this.lbm;
         }
         return 370 + 21.6 * (this.lbm / 2.2);
      }
      
      public function calcBmr() : void
      {
         switch(this.bmrformula)
         {
            case "msj":
               this.bmr = this.calcBmrMSJ();
               break;
            case "hb":
               this.bmr = this.calcBmrHB();
               break;
            case "km":
               this.bmr = this.calcBmrKM();
               break;
            case "average":
               this.bmr = (this.calcBmrHB() + this.calcBmrKM() + this.calcBmrMSJ()) / 3;
         }
         if(this.tdeeformula == "")
         {
            this.tdee = this.bmr * this.activity;
         }
      }
      
      public function calcBmi() : void
      {
         this.bmi = this.pounds() / Math.pow(this.inches(),2) * 703;
      }
      
      [Bindable(event="propertyChange")]
      public function get metric() : Boolean
      {
         return this._1077545552metric;
      }
      
      public function set metric(param1:Boolean) : void
      {
         var _loc2_:Object = this._1077545552metric;
         if(_loc2_ !== param1)
         {
            this._1077545552metric = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"metric",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get height() : Number
      {
         return this._1221029593height;
      }
      
      public function set height(param1:Number) : void
      {
         var _loc2_:Object = this._1221029593height;
         if(_loc2_ !== param1)
         {
            this._1221029593height = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"height",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get heightin() : int
      {
         return this._883363700heightin;
      }
      
      public function set heightin(param1:int) : void
      {
         var _loc2_:Object = this._883363700heightin;
         if(_loc2_ !== param1)
         {
            this._883363700heightin = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heightin",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get weight() : Number
      {
         return this._791592328weight;
      }
      
      public function set weight(param1:Number) : void
      {
         var _loc2_:Object = this._791592328weight;
         if(_loc2_ !== param1)
         {
            this._791592328weight = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weight",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get age() : Number
      {
         return this._96511age;
      }
      
      public function set age(param1:Number) : void
      {
         var _loc2_:Object = this._96511age;
         if(_loc2_ !== param1)
         {
            this._96511age = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"age",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get activity() : Number
      {
         return this._1655966961activity;
      }
      
      public function set activity(param1:Number) : void
      {
         var _loc2_:Object = this._1655966961activity;
         if(_loc2_ !== param1)
         {
            this._1655966961activity = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"activity",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get genderMale() : Boolean
      {
         return this._939449234genderMale;
      }
      
      public function set genderMale(param1:Boolean) : void
      {
         var _loc2_:Object = this._939449234genderMale;
         if(_loc2_ !== param1)
         {
            this._939449234genderMale = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"genderMale",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get waist() : Number
      {
         return this._112893312waist;
      }
      
      public function set waist(param1:Number) : void
      {
         var _loc2_:Object = this._112893312waist;
         if(_loc2_ !== param1)
         {
            this._112893312waist = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"waist",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bfpct() : Number
      {
         return this._93654557bfpct;
      }
      
      public function set bfpct(param1:Number) : void
      {
         var _loc2_:Object = this._93654557bfpct;
         if(_loc2_ !== param1)
         {
            this._93654557bfpct = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bfpct",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get waistToHeight() : Number
      {
         return this._1297679650waistToHeight;
      }
      
      public function set waistToHeight(param1:Number) : void
      {
         var _loc2_:Object = this._1297679650waistToHeight;
         if(_loc2_ !== param1)
         {
            this._1297679650waistToHeight = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"waistToHeight",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fat() : Number
      {
         return this._101145fat;
      }
      
      public function set fat(param1:Number) : void
      {
         var _loc2_:Object = this._101145fat;
         if(_loc2_ !== param1)
         {
            this._101145fat = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fat",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbm() : Number
      {
         return this._106935lbm;
      }
      
      public function set lbm(param1:Number) : void
      {
         var _loc2_:Object = this._106935lbm;
         if(_loc2_ !== param1)
         {
            this._106935lbm = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbm",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrformula() : String
      {
         return this._1088037377bmrformula;
      }
      
      public function set bmrformula(param1:String) : void
      {
         var _loc2_:Object = this._1088037377bmrformula;
         if(_loc2_ !== param1)
         {
            this._1088037377bmrformula = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrformula",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeformula() : String
      {
         return this._919011414tdeeformula;
      }
      
      public function set tdeeformula(param1:String) : void
      {
         var _loc2_:Object = this._919011414tdeeformula;
         if(_loc2_ !== param1)
         {
            this._919011414tdeeformula = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeformula",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmr() : Number
      {
         return this._97671bmr;
      }
      
      public function set bmr(param1:Number) : void
      {
         var _loc2_:Object = this._97671bmr;
         if(_loc2_ !== param1)
         {
            this._97671bmr = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmr",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdee() : Number
      {
         return this._3555088tdee;
      }
      
      public function set tdee(param1:Number) : void
      {
         var _loc2_:Object = this._3555088tdee;
         if(_loc2_ !== param1)
         {
            this._3555088tdee = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdee",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmi() : Number
      {
         return this._97662bmi;
      }
      
      public function set bmi(param1:Number) : void
      {
         var _loc2_:Object = this._97662bmi;
         if(_loc2_ !== param1)
         {
            this._97662bmi = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmi",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mincals() : Number
      {
         return this._1064347575mincals;
      }
      
      public function set mincals(param1:Number) : void
      {
         var _loc2_:Object = this._1064347575mincals;
         if(_loc2_ !== param1)
         {
            this._1064347575mincals = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mincals",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cycledays() : int
      {
         return this._1560828355cycledays;
      }
      
      public function set cycledays(param1:int) : void
      {
         var _loc2_:Object = this._1560828355cycledays;
         if(_loc2_ !== param1)
         {
            this._1560828355cycledays = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cycledays",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cycleworkouts() : int
      {
         return this._70214748cycleworkouts;
      }
      
      public function set cycleworkouts(param1:int) : void
      {
         var _loc2_:Object = this._70214748cycleworkouts;
         if(_loc2_ !== param1)
         {
            this._70214748cycleworkouts = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cycleworkouts",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restcals() : Number
      {
         return this._336999367restcals;
      }
      
      public function set restcals(param1:Number) : void
      {
         var _loc2_:Object = this._336999367restcals;
         if(_loc2_ !== param1)
         {
            this._336999367restcals = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restcals",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutcals() : Number
      {
         return this._1372202626workoutcals;
      }
      
      public function set workoutcals(param1:Number) : void
      {
         var _loc2_:Object = this._1372202626workoutcals;
         if(_loc2_ !== param1)
         {
            this._1372202626workoutcals = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutcals",_loc2_,param1));
            }
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
   }
}

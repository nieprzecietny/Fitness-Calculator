package
{
   import IFComponents.UserObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.charts.CategoryAxis;
   import mx.charts.Legend;
   import mx.charts.LineChart;
   import mx.charts.LinearAxis;
   import mx.charts.PieChart;
   import mx.charts.series.LineSeries;
   import mx.charts.series.PieSeries;
   import mx.collections.ArrayCollection;
   import mx.collections.ArrayList;
   import mx.collections.XMLListCollection;
   import mx.containers.TabNavigator;
   import mx.controls.AdvancedDataGrid;
   import mx.controls.Alert;
   import mx.controls.DateField;
   import mx.controls.HRule;
   import mx.controls.VRule;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.CalendarLayoutChangeEvent;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSCondition;
   import mx.styles.CSSSelector;
   import mx.styles.CSSStyleDeclaration;
   import spark.components.Application;
   import spark.components.BorderContainer;
   import spark.components.Button;
   import spark.components.CheckBox;
   import spark.components.ComboBox;
   import spark.components.HSlider;
   import spark.components.Label;
   import spark.components.NavigatorContent;
   import spark.components.NumericStepper;
   import spark.components.RadioButton;
   import spark.components.RadioButtonGroup;
   import spark.components.TextArea;
   import spark.components.TextInput;
   import spark.components.ToggleButton;
   import spark.events.IndexChangeEvent;
   import spark.events.TextOperationEvent;
   
   use namespace mx_internal;
   
   public class IFCalc extends Application implements IBindingClient
   {
      
      public static const millisecondsPerDay:int = 1000 * 60 * 60 * 24;
      
      public static const ver:String = "1.0.5";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _IFCalc_AdvancedDataGridColumn13:AdvancedDataGridColumn;
      
      public var _IFCalc_AdvancedDataGridColumn2:AdvancedDataGridColumn;
      
      public var _IFCalc_CategoryAxis1:CategoryAxis;
      
      public var _IFCalc_Label105:Label;
      
      public var _IFCalc_Label123:Label;
      
      public var _IFCalc_Label131:Label;
      
      public var _IFCalc_Label4:Label;
      
      public var _IFCalc_Label86:Label;
      
      public var _IFCalc_Label90:Label;
      
      public var _IFCalc_Label93:Label;
      
      public var _IFCalc_Label95:Label;
      
      public var _IFCalc_Label97:Label;
      
      public var _IFCalc_Label99:Label;
      
      private var _1628271015activityCMB0:ComboBox;
      
      private var _1628293664activityDESC:String;
      
      private var _1628528873activityLBL0:Label;
      
      private var _1062283248ageDESC:String;
      
      private var _1062048039ageLBL0:Label;
      
      private var _1062048038ageLBL1:Label;
      
      private var _1061788321ageTXT0:TextInput;
      
      private var _229805604bfGoals:BorderContainer;
      
      private var _1936696189bfcalcCHK0:CheckBox;
      
      private var _1936669014bfcalcDESC:String;
      
      private var _995820223bfpDifLBL:Label;
      
      private var _1679761425bfpToLBL:Label;
      
      private var _1663291442bfpfield:AdvancedDataGridColumn;
      
      private var _689423bmiDESC:String;
      
      private var _924632bmiLBL0:Label;
      
      private var _924633bmiLBL1:Label;
      
      private var _924634bmiLBL2:Label;
      
      private var _958811415bmiTwinDESC:String;
      
      private var _959046624bmiTwinLBL0:Label;
      
      private var _959046625bmiTwinLBL1:Label;
      
      private var _959046626bmiTwinLBL2:Label;
      
      private var _9001112bmrDESC:String;
      
      private var _625422053bmrFormulaAVDESC:String;
      
      private var _625834740bmrFormulaAVRAB3:RadioButton;
      
      private var _326564493bmrFormulaCUSDESC:String;
      
      private var _326151804bmrFormulaCUSRAB5:RadioButton;
      
      private var _807355690bmrFormulaHBDESC:String;
      
      private var _807768375bmrFormulaHBRAB1:RadioButton;
      
      private var _903401874bmrFormulaKMDESC:String;
      
      private var _903814560bmrFormulaKMRAB2:RadioButton;
      
      private var _107032266bmrFormulaMSJDESC:String;
      
      private var _106619582bmrFormulaMSJRAB0:RadioButton;
      
      private var _47926922bmrFormulaMULDESC:String;
      
      private var _47514234bmrFormulaMULRAB4:RadioButton;
      
      private var _283174200bmrGroup:RadioButtonGroup;
      
      private var _9236321bmrLBL0:Label;
      
      private var _9236322bmrLBL1:Label;
      
      private var _9236323bmrLBL2:Label;
      
      private var _1353557688bodyfatDESC:String;
      
      private var _1353322479bodyfatLBL0:Label;
      
      private var _1353322478bodyfatLBL1:Label;
      
      private var _1353322477bodyfatLBL2:Label;
      
      private var _1353062761bodyfatTXT0:TextInput;
      
      private var _1611527254customBMR:TextInput;
      
      private var _185177658customProteinRest:TextInput;
      
      private var _1461840021customProteinWorkout:TextInput;
      
      private var _1581735423customTDEE:TextInput;
      
      private var _556358325cycleCalsLBL:Label;
      
      private var _235560352cycleChangeLBL:Label;
      
      private var _1149838520cycleOverUnderLBL:Label;
      
      private var _1725308096cycleTdeeLBL:Label;
      
      private var _1944943472cycleTdeeLBL0:Label;
      
      private var _694512816daySplitCombo:ComboBox;
      
      private var _1725616320daysPerCycle:NumericStepper;
      
      private var _82654112daysPerCycleGoals:NumericStepper;
      
      private var _1103199430disclaimerCB:CheckBox;
      
      private var _160573434disclaimerTab:NavigatorContent;
      
      private var _504773138fatDifLBL:Label;
      
      private var _968478114fatToLBL:Label;
      
      private var _984948097fatfield:AdvancedDataGridColumn;
      
      private var _1055489726fbmDESC:String;
      
      private var _1055254517fbmLBL0:Label;
      
      private var _1055254516fbmLBL1:Label;
      
      private var _1055254515fbmLBL2:Label;
      
      private var _1659999732gainLoseAmt:NumericStepper;
      
      private var _79089055gainLoseTEXT:Label;
      
      private var _939745070genderDESC:String;
      
      private var _936813630genderGroup:RadioButtonGroup;
      
      private var _939509861genderLBL0:Label;
      
      private var _939332386genderRAB0:RadioButton;
      
      private var _939332385genderRAB1:RadioButton;
      
      private var _1065868775goalCSVBTN0:ToggleButton;
      
      private var _1826232809goalChangeRateDisplayLBL:Label;
      
      private var _2039733387goalChart:BorderContainer;
      
      private var _1402641770goalChartFieldFat:RadioButton;
      
      private var _854311559goalChartFieldWeight:RadioButton;
      
      private var _1628498363goalChartFieldsGroup:RadioButtonGroup;
      
      private var _625936264goalChartLegend:Legend;
      
      private var _1994360134goalExportTXA0:spark.components.TextArea;
      
      private var _835701151goalGraphBTN:ToggleButton;
      
      private var _784992649goalLineChart:LineChart;
      
      private var _467686223goalSeriesFat:LineSeries;
      
      private var _467690989goalSeriesLBM:LineSeries;
      
      private var _456525442goalSeriesWeight:LineSeries;
      
      private var _2055225467goalTable:BorderContainer;
      
      private var _1373284517goalVertAxis:LinearAxis;
      
      private var _1952400520goalXMLBTN0:ToggleButton;
      
      private var _1338328289goalsCyclesToComplete:Label;
      
      private var _43276011goalsCyclesToCompleteLBL:Label;
      
      private var _1215112299goalsDaysToComplete:Label;
      
      private var _1395850945goalsFinishDate:Label;
      
      private var _1729776565goalsTab:NavigatorContent;
      
      private var _1489869880heightDESC:String;
      
      private var _1490105089heightLBL0:Label;
      
      private var _1490105090heightLBL1:Label;
      
      private var _1490364807heightTXT0:TextInput;
      
      private var _1139981515ifTabNav:TabNavigator;
      
      private var _1139900681inchesDESC:String;
      
      private var _1140135890inchesLBL0:Label;
      
      private var _1140395608inchesTXT0:TextInput;
      
      private var _1945402375infoTab:NavigatorContent;
      
      private var _25434936lbmDESC:String;
      
      private var _1360653836lbmDifLBL:Label;
      
      private var _25199727lbmLBL0:Label;
      
      private var _25199726lbmLBL1:Label;
      
      private var _25199725lbmLBL2:Label;
      
      private var _772462140lbmToLBL:Label;
      
      private var _755992157lbmfield:AdvancedDataGridColumn;
      
      private var _1676184800lifestyleTab:NavigatorContent;
      
      private var _1095397484macroCalcTab:NavigatorContent;
      
      private var _1902784384macroSplitCombo:ComboBox;
      
      private var _900294779maintainChangerate:RadioButton;
      
      private var _529403582maintainSchedule:RadioButtonGroup;
      
      private var _1870244667maintainTdee:RadioButton;
      
      private var _983365531mealsTab:NavigatorContent;
      
      private var _396948543measureGroup:RadioButtonGroup;
      
      private var _1908007353measureImperial:RadioButton;
      
      private var _739412142measureMetric:RadioButton;
      
      private var _976585349mfmDESC:String;
      
      private var _976820558mfmLBL0:Label;
      
      private var _976820559mfmLBL1:Label;
      
      private var _976820560mfmLBL2:Label;
      
      private var _1188187880minCalsDESC:String;
      
      private var _1188423089minCalsLBL0:Label;
      
      private var _1188423090minCalsLBL1:Label;
      
      private var _1188423091minCalsLBL2:Label;
      
      private var _1847045737nextBTN:Button;
      
      private var _318222551prevBTN:Button;
      
      private var _877175755proteinCombo:ComboBox;
      
      private var _156503411recalcFatLossPct:NumericStepper;
      
      private var _1276575840recalcWeight:NumericStepper;
      
      private var _931755218restCalsDifLBL:Label;
      
      private var _544843107restCalsLBL:Label;
      
      private var _282516961restCarbSliderMax:Label;
      
      private var _1797127154restCarbsSlider:HSlider;
      
      private var _1933708906restDayChart:PieChart;
      
      private var _776967319restDayTdeePct:NumericStepper;
      
      private var _1184058342restFatSlider:HSlider;
      
      private var _284258402restFatSliderMax:Label;
      
      private var _1877254756restMeals:AdvancedDataGrid;
      
      private var _1934644756restMeals0:AdvancedDataGrid;
      
      private var _1934644757restMeals1:AdvancedDataGrid;
      
      private var _1715774297restPctTdeeLBL:Label;
      
      private var _1070463696restProteinSlider:HSlider;
      
      private var _687058598scheduleDG:AdvancedDataGrid;
      
      private var _1548967051simpleMulBMR:TextInput;
      
      private var _772811070simpleMulTDEE:TextInput;
      
      private var _2129778896startDate:DateField;
      
      private var _1154359211superToolTipTA:mx.controls.TextArea;
      
      private var _1845505441tdeeDESC:String;
      
      private var _524266935tdeeFormulaCALDESC:String;
      
      private var _523854251tdeeFormulaCALRAB0:RadioButton;
      
      private var _54780732tdeeFormulaCUSDESC:String;
      
      private var _55193418tdeeFormulaCUSRAB2:RadioButton;
      
      private var _333418303tdeeFormulaMULDESC:String;
      
      private var _333830988tdeeFormulaMULRAB1:RadioButton;
      
      private var _1380233551tdeeGroup:RadioButtonGroup;
      
      private var _1845740650tdeeLBL0:Label;
      
      private var _1845740651tdeeLBL1:Label;
      
      private var _1845740652tdeeLBL2:Label;
      
      private var _984624111waistDESC:String;
      
      private var _984388902waistLBL0:Label;
      
      private var _984388901waistLBL1:Label;
      
      private var _984388900waistLBL2:Label;
      
      private var _984129184waistTXT0:TextInput;
      
      private var _1457832695weightDESC:String;
      
      private var _784057843weightDifLBL:Label;
      
      private var _1457597486weightLBL0:Label;
      
      private var _1457597485weightLBL1:Label;
      
      private var _1457337768weightTXT0:TextInput;
      
      private var _2067847587weightToLBL:Label;
      
      private var _1288850103workoutCalsDifLBL:Label;
      
      private var _1454436276workoutCalsLBL:Label;
      
      private var _1045625416workoutCarbSliderMax:Label;
      
      private var _1916415369workoutCarbsSlider:HSlider;
      
      private var _85590177workoutDayChart:PieChart;
      
      private var _1443638002workoutDayTdeePct:NumericStepper;
      
      private var _1653803203workoutFatSlider:HSlider;
      
      private var _881291033workoutFatSliderMax:Label;
      
      private var _358587678workoutPctTdeeLBL:Label;
      
      private var _257678681workoutProteinSlider:HSlider;
      
      private var _525418145workoutsPerCycle:NumericStepper;
      
      private var _1503311265workoutsPerCycleGoals:NumericStepper;
      
      private var _721142735wthRatioDESC:String;
      
      private var _720907526wthRatioLBL0:Label;
      
      private var _720907525wthRatioLBL1:Label;
      
      private var _720907524wthRatioLBL2:Label;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _1444205166restCollection:ArrayCollection;
      
      private var _776400155workoutCollection:ArrayCollection;
      
      private var _3599307user:UserObject;
      
      private var _344075095weightString:String = "lbs";
      
      private var _2014651416heightString:String = "ft";
      
      private var _1970315494heightString2:String = "in";
      
      private var _1561301197cycleText:String = "Week";
      
      private var _1684251937restOverUnderString:String = "under";
      
      private var _944714552workoutOverUnderString:String = "under";
      
      private var _350129681goalCollection:XMLListCollection;
      
      private var cycleTeeCals:Number = 0;
      
      private var cycleCals:Number = 0;
      
      private var cycleCalDif:Number = 0;
      
      private var cycleChange:Number = 0;
      
      private var goalFlag:Boolean = true;
      
      mx_internal var _IFCalc_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function IFCalc()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._1444205166restCollection = new ArrayCollection();
         this._776400155workoutCollection = new ArrayCollection();
         this._3599307user = new UserObject();
         this._350129681goalCollection = new XMLListCollection(XMLList(<cycles></cycles>));
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         var bindings:Array = this._IFCalc_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_IFCalcWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return IFCalc[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.minWidth = 960;
         this.minHeight = 700;
         this.width = 960;
         this.height = 700;
         this.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array1_c);
         this._IFCalc_String5_i();
         this._IFCalc_String4_i();
         this._IFCalc_String8_i();
         this._IFCalc_String23_i();
         this._IFCalc_String24_i();
         this._IFCalc_String10_i();
         this._IFCalc_String14_i();
         this._IFCalc_String16_i();
         this._IFCalc_String12_i();
         this._IFCalc_String13_i();
         this._IFCalc_String11_i();
         this._IFCalc_String15_i();
         this._IFCalc_RadioButtonGroup3_i();
         this._IFCalc_String7_i();
         this._IFCalc_String18_i();
         this._IFCalc_String6_i();
         this._IFCalc_RadioButtonGroup2_i();
         this._IFCalc_RadioButtonGroup5_i();
         this._IFCalc_String1_i();
         this._IFCalc_String2_i();
         this._IFCalc_String17_i();
         this._IFCalc_RadioButtonGroup4_i();
         this._IFCalc_RadioButtonGroup1_i();
         this._IFCalc_String26_i();
         this._IFCalc_String27_i();
         this._IFCalc_String19_i();
         this._IFCalc_String20_i();
         this._IFCalc_String22_i();
         this._IFCalc_String21_i();
         this._IFCalc_RadioButtonGroup6_i();
         this._IFCalc_String9_i();
         this._IFCalc_String3_i();
         this._IFCalc_String25_i();
         this.addEventListener("creationComplete",this.___IFCalc_Application1_creationComplete);
         this.addEventListener("initialize",this.___IFCalc_Application1_initialize);
         this.addEventListener("applicationComplete",this.___IFCalc_Application1_applicationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         IFCalc._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_IFCalc_StylesInit();
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      protected function round(param1:Number, param2:int) : Number
      {
         param2 = Math.pow(10,param2);
         return Math.round(param1 * param2) / param2;
      }
      
      protected function init(param1:FlexEvent) : void
      {
         this.restCollection.addItem({
            "name":"Protein",
            "cals":Number(0),
            "grams":Number(0),
            "pct":Number(0),
            "split":Number(0)
         });
         this.restCollection.addItem({
            "name":"Carbs",
            "cals":Number(0),
            "grams":Number(0),
            "pct":Number(0),
            "split":Number(0)
         });
         this.restCollection.addItem({
            "name":"Fat",
            "cals":Number(0),
            "grams":Number(0),
            "pct":Number(0),
            "split":Number(0)
         });
         this.workoutCollection.addItem({
            "name":"Protein",
            "cals":Number(0),
            "grams":Number(0),
            "pct":Number(0),
            "split":Number(0)
         });
         this.workoutCollection.addItem({
            "name":"Carbs",
            "cals":Number(0),
            "grams":Number(0),
            "pct":Number(0),
            "split":Number(0)
         });
         this.workoutCollection.addItem({
            "name":"Fat",
            "cals":Number(0),
            "grams":Number(0),
            "pct":Number(0),
            "split":Number(0)
         });
      }
      
      protected function cc(param1:FlexEvent) : void
      {
         var _loc2_:int = 1;
         while(_loc2_ < 6)
         {
            this.ifTabNav.getTabAt(_loc2_).enabled = false;
            _loc2_++;
         }
         this.ifTabNav.getTabAt(4).visible = false;
         this.ifTabNav.getTabAt(4).includeInLayout = false;
         this.ifTabNav.getTabAt(5).visible = false;
         this.ifTabNav.getTabAt(5).includeInLayout = false;
      }
      
      protected function application1_applicationCompleteHandler(param1:FlexEvent) : void
      {
      }
      
      protected function ifTabNav_changeHandler(param1:IndexChangedEvent) : void
      {
         callLater(this.tabSwitch);
      }
      
      protected function tabSwitch() : void
      {
         switch(this.ifTabNav.selectedIndex)
         {
            case 0:
               this.nextBTN.enabled = true;
               this.prevBTN.enabled = false;
               break;
            case 1:
               this.prevBTN.enabled = true;
               this.calcBasics();
               break;
            case 2:
               this.nextBTN.enabled = true;
               this.calcBasics();
               this.calcDayCalories();
               this.calcMacros();
               this.calcSummary();
               break;
            case 3:
               this.nextBTN.enabled = false;
               this.goalChartFieldsGroup.selectedValue = "weight";
               this.goalGraphBTN.selected = false;
               this.goalTable.visible = true;
               this.goalChart.visible = false;
               if(this.user.metric)
               {
                  this.gainLoseAmt.stepSize = 0.5;
               }
               else
               {
                  this.gainLoseAmt.stepSize = 1;
               }
               if(this.goalFlag)
               {
                  if(this.cycleCalDif > 0)
                  {
                     this.recalcFatLossPct.value = 50;
                  }
                  else
                  {
                     this.recalcFatLossPct.value = 90;
                  }
                  this.goalFlag = false;
               }
               this.calcBasics();
               this.calcDayCalories();
               this.calcMacros();
               this.calcSummary();
               this.calcGoals();
               break;
            case 4:
               break;
            case 5:
               this.nextBTN.enabled = false;
         }
      }
      
      protected function prevBTN_clickHandler(param1:MouseEvent) : void
      {
         this.ifTabNav.selectedIndex = this.ifTabNav.selectedIndex - 1;
      }
      
      protected function nextBTN_clickHandler(param1:MouseEvent) : void
      {
         this.ifTabNav.selectedIndex = this.ifTabNav.selectedIndex + 1;
      }
      
      protected function disclaimerCB_clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         this.infoTab.enabled = this.disclaimerCB.selected;
         if(this.disclaimerCB.selected)
         {
            this.ifTabNav.selectedIndex = 1;
         }
         else
         {
            _loc2_ = 1;
            while(_loc2_ < 6)
            {
               this.ifTabNav.getTabAt(_loc2_).enabled = false;
               this.nextBTN.enabled = false;
               this.prevBTN.enabled = false;
               _loc2_++;
            }
         }
      }
      
      protected function calcBasics() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         if(this.user.height > 0 && this.user.weight > 0 && this.user.age > 0)
         {
            _loc1_ = true;
            if(this.bfcalcCHK0.selected)
            {
               if(this.user.genderMale)
               {
                  this.user.bfpct = this.round(100 * (-98.42 + 4.15 * this.user.waistinches() - 0.082 * this.user.pounds()) / this.user.pounds(),1);
               }
               else
               {
                  this.user.bfpct = this.round(100 * (-76.76 + 4.15 * this.user.waistinches() - 0.082 * this.user.pounds()) / this.user.pounds(),1);
               }
            }
            if(this.user.bfpct > 0)
            {
               this.user.fat = this.user.bfpct / 100 * this.user.weight;
               this.user.lbm = this.user.weight - this.user.fat;
               this.lbmLBL1.text = this.user.lbm.toFixed(1);
               this.fbmLBL1.text = this.user.fat.toFixed(1);
               this.bmrFormulaKMRAB2.enabled = true;
               this.bmrFormulaAVRAB3.enabled = true;
               this.mfmLBL1.text = Math.round(this.user.fatpounds() * 30).toString();
               this.user.mincals = Math.round(this.user.tdee - this.user.fatpounds() * 30);
               this.minCalsLBL1.text = this.user.mincals.toString();
            }
            else
            {
               this.user.fat = 0;
               this.user.lbm = 0;
               this.lbmLBL1.text = "---";
               this.fbmLBL1.text = "---";
               this.mfmLBL1.text = "---";
               this.minCalsLBL1.text = "---";
               this.bmrFormulaKMRAB2.enabled = false;
               this.bmrFormulaAVRAB3.enabled = false;
            }
            this.user.bmrformula = this.bmrGroup.selectedValue.toString();
            this.user.calcBmr();
            this.bmrLBL1.text = this.user.bmr.toFixed(0);
            this.tdeeLBL1.text = this.user.tdee.toFixed(0);
            if(this.user.waist > 0)
            {
               this.user.waistToHeight = this.round(this.user.waistinches() / this.user.inches() * 100,1);
               this.wthRatioLBL1.text = this.user.waistToHeight.toString();
               this.wthRatioLBL1.styleName = this.user.waistToHeight < 50?"good":"bad";
               this.wthRatioLBL2.styleName = this.wthRatioLBL1.styleName;
            }
            else
            {
               this.wthRatioLBL1.text = "---";
               this.wthRatioLBL1.styleName = "calclbl";
               this.wthRatioLBL2.styleName = this.wthRatioLBL1.styleName;
            }
            this.user.calcBmi();
            this.bmiLBL1.text = this.user.bmi.toFixed(1);
            if(this.user.metric)
            {
               this.bmiTwinLBL1.text = this.round(Math.pow(this.user.inches(),2) * 22 / 703 / 2.2,1).toString();
            }
            else
            {
               this.bmiTwinLBL1.text = this.round(Math.pow(this.user.inches(),2) * 22 / 703,1).toString();
            }
            if(this.user.bmi < 16)
            {
               this.bmiLBL2.styleName = "severeunderweight";
               this.bmiLBL2.text = "(Severely Underweight)";
            }
            else if(this.user.bmi < 18.5)
            {
               this.bmiLBL2.styleName = "underweight";
               this.bmiLBL2.text = "(Underweight)";
            }
            else if(this.user.bmi < 25.1)
            {
               this.bmiLBL2.styleName = "normal";
               this.bmiLBL2.text = "(Normal)";
            }
            else if(this.user.bmi < 30.1)
            {
               this.bmiLBL2.styleName = "overweight";
               this.bmiLBL2.text = "(Overweight)";
            }
            else if(this.user.bmi < 35.1)
            {
               this.bmiLBL2.styleName = "obesei";
               this.bmiLBL2.text = "(Obese I)";
            }
            else if(this.user.bmi < 40)
            {
               this.bmiLBL2.styleName = "obeseii";
               this.bmiLBL2.text = "(Obese II)";
            }
            else
            {
               this.bmiLBL2.styleName = "obeseiii";
               this.bmiLBL2.text = "(Obese III)";
            }
            this.bmiLBL1.styleName = this.bmiLBL2.styleName;
         }
         else
         {
            _loc1_ = false;
            this.nextBTN.enabled = false;
         }
         if(this.ifTabNav.selectedIndex == 1)
         {
            _loc2_ = 2;
            while(_loc2_ < 6)
            {
               this.ifTabNav.getTabAt(_loc2_).enabled = _loc1_;
               this.nextBTN.enabled = _loc1_;
               _loc2_++;
            }
            if(this.cycleCalDif == 0)
            {
               this.goalsTab.enabled = false;
            }
         }
      }
      
      protected function heightTEXT_changeHandler(param1:TextOperationEvent) : void
      {
         this.user.height = Number(this.heightTXT0.text);
         this.calcBasics();
      }
      
      protected function inchesTEXT_changeHandler(param1:TextOperationEvent) : void
      {
         this.user.heightin = Number(this.inchesTXT0.text);
         this.calcBasics();
      }
      
      protected function weightTEXT_changeHandler(param1:TextOperationEvent) : void
      {
         this.user.weight = Number(this.weightTXT0.text);
         this.calcBasics();
      }
      
      protected function ageTEXT_changeHandler(param1:TextOperationEvent) : void
      {
         this.user.age = Number(this.ageTXT0.text);
         this.calcBasics();
      }
      
      protected function activityCOMBO_changeHandler(param1:IndexChangeEvent) : void
      {
         switch(this.activityCMB0.selectedItem)
         {
            case "Sedentary":
               this.user.activity = 1.2;
               break;
            case "Lightly Active":
               this.user.activity = 1.375;
               break;
            case "Moderately Active":
               this.user.activity = 1.55;
               break;
            case "Very Active":
               this.user.activity = 1.725;
               break;
            case "Extra Active":
               this.user.activity = 1.9;
         }
         this.calcBasics();
      }
      
      protected function genderGroup_changeHandler(param1:Event) : void
      {
         this.user.genderMale = this.genderRAB0.selected;
         this.calcBasics();
      }
      
      protected function bodyfatTEXT_changeHandler(param1:TextOperationEvent) : void
      {
         var _loc2_:Number = Number(this.bodyfatTXT0.text);
         if(this.user.bfpct > 0 && _loc2_ == 0)
         {
            this.bmrGroup.selectedValue = "msj";
         }
         else if(this.user.bfpct == 0 && _loc2_ > 0)
         {
            this.bmrGroup.selectedValue = "km";
         }
         this.bfcalcCHK0.selected = false;
         this.user.bfpct = _loc2_;
         this.calcBasics();
      }
      
      protected function bmrGroup_changeHandler(param1:Event) : void
      {
         this.simpleMulBMR.visible = this.bmrFormulaMULRAB4.selected;
         this.customBMR.visible = this.bmrFormulaCUSRAB5.selected;
         if(this.customBMR.visible && Number(this.customBMR.text) > 0)
         {
            this.user.bmr = Number(this.customBMR.text);
         }
         if(this.simpleMulBMR.visible && Number(this.simpleMulBMR.text) > 0)
         {
            this.user.bmr = Number(this.simpleMulBMR.text) * this.user.pounds();
         }
         this.calcBasics();
      }
      
      protected function calcBfCB_clickHandler(param1:MouseEvent) : void
      {
         if(this.bfcalcCHK0.selected)
         {
            this.bmrGroup.selectedValue = "km";
         }
         else
         {
            this.user.bfpct = 0;
            this.bmrGroup.selectedValue = "msj";
         }
         this.calcBasics();
      }
      
      protected function waistTEXT_changeHandler(param1:TextOperationEvent) : void
      {
         this.user.waist = Number(this.waistTXT0.text);
         this.bfcalcCHK0.enabled = this.user.waist > 0?true:false;
         this.calcBasics();
      }
      
      protected function tdeeGroup_changeHandler(param1:Event) : void
      {
         this.simpleMulTDEE.visible = this.tdeeFormulaMULRAB1.selected;
         this.customTDEE.visible = this.tdeeFormulaCUSRAB2.selected;
         this.user.tdeeformula = this.tdeeGroup.selectedValue.toString();
         if(this.tdeeGroup.selectedValue == "mul" && Number(this.simpleMulTDEE.text) > 0)
         {
            this.user.tdee = Number(this.simpleMulTDEE.text) * this.user.weight;
         }
         if(this.tdeeGroup.selectedValue == "custom" && Number(this.customTDEE.text) > 0)
         {
            this.user.tdee = Number(this.customTDEE.text);
         }
         this.calcBasics();
      }
      
      protected function simpleMulBMR_changeHandler(param1:TextOperationEvent) : void
      {
         this.user.bmr = Number(this.simpleMulBMR.text) * this.user.pounds();
         this.calcBasics();
      }
      
      protected function simpleMulTDEE_changeHandler(param1:TextOperationEvent) : void
      {
         this.user.tdee = Number(this.simpleMulTDEE.text) * this.user.weight;
         this.calcBasics();
      }
      
      protected function customTDEE_changeHandler(param1:TextOperationEvent) : void
      {
         this.user.tdee = Number(this.customTDEE.text);
         this.calcBasics();
      }
      
      protected function customBMR_changeHandler(param1:TextOperationEvent) : void
      {
         this.user.bmr = Number(this.customBMR.text);
         this.calcBasics();
      }
      
      protected function measureGroup_changeHandler(param1:Event) : void
      {
         this.user.metric = this.measureMetric.selected;
         this.inchesTXT0.visible = !this.user.metric;
         this.inchesLBL0.visible = !this.user.metric;
         this.weightString = !!this.user.metric?"kg":"lbs";
         this.heightString = !!this.user.metric?"cm":"ft";
         this.heightString2 = !!this.user.metric?"cm":"in";
         if(this.user.metric)
         {
            this.user.toMetric();
         }
         else
         {
            this.user.toImperial();
         }
         this.calcBasics();
      }
      
      protected function superToolTip(param1:String) : void
      {
         var _loc2_:String = null;
         _loc2_ = this[param1.substr(0,param1.length - 4) + "DESC"] as String;
         this.superToolTipTA.htmlText = _loc2_;
      }
      
      protected function superToolTipM(param1:MouseEvent) : void
      {
         this.superToolTip(param1.currentTarget.id);
      }
      
      protected function superToolTipF(param1:FocusEvent) : void
      {
         this.superToolTip(param1.currentTarget.id);
      }
      
      protected function macroCalcTab_contentCreationCompleteHandler(param1:FlexEvent) : void
      {
         this.calcBasics();
         this.calcDayCalories();
         this.setDaySplit(-20,20);
         this.setProtein(this.user.pounds());
         this.setMacroSplit(50,50,50,50);
         this.calcMacros();
         this.calcSummary();
      }
      
      protected function proteinCombo_changeHandler(param1:IndexChangeEvent) : void
      {
         var _loc2_:Number = !!this.user.metric?Number(this.user.lbm * 2.2):Number(this.user.lbm);
         switch(this.proteinCombo.selectedItem)
         {
            case "1g / lb. Bodyweight":
               this.setProtein(this.user.pounds());
               this.customProteinRest.enabled = false;
               this.customProteinWorkout.enabled = false;
               break;
            case "1.5g / lb. LBM":
               if(this.user.bfpct > 0)
               {
                  this.setProtein(_loc2_ * 1.5);
               }
               else
               {
                  this.setProtein(this.user.pounds());
                  this.proteinCombo.selectedItem = "1g / lb. Bodyweight";
               }
               this.customProteinRest.enabled = false;
               this.customProteinWorkout.enabled = false;
               break;
            case "3g / kg. Bodyweight":
               this.setProtein(this.user.kg() * 3);
               this.customProteinRest.enabled = false;
               this.customProteinWorkout.enabled = false;
               break;
            case "Custom":
               this.customProteinRest.enabled = true;
               this.customProteinWorkout.enabled = true;
         }
         this.calcMacros();
      }
      
      protected function updateCustomProteinRest() : void
      {
         this.restCollection.getItemAt(0).grams = Number(this.customProteinRest.text);
         this.calcRestMacros();
      }
      
      protected function updateCustomProteinWorkout() : void
      {
         this.workoutCollection.getItemAt(0).grams = Number(this.customProteinWorkout.text);
         this.calcWorkoutMacros();
      }
      
      protected function daySplitCombo_changeHandler(param1:IndexChangeEvent) : void
      {
         switch(this.daySplitCombo.selectedItem)
         {
            case "Standard Recomp (-20/+20)":
               this.setDaySplit(-20,20);
               break;
            case "Weight Loss (-20/0)":
               this.setDaySplit(-20,0);
               break;
            case "Weight Loss #2 (-40/+20)":
               this.setDaySplit(-40,20);
               break;
            case "Faster Weight Loss (-30/-10)":
               this.setDaySplit(-30,-10);
               break;
            case "Lean Massing (-10/+20)":
               this.setDaySplit(-10,20);
               break;
            case "Weight Gain (+10/+20)":
               this.setDaySplit(10,20);
               break;
            case "Weight Gain #2 (-10/+30)":
               this.setDaySplit(-10,30);
               break;
            case "Maintain (0/0)":
               this.setDaySplit(0,0);
         }
         this.calcMacros();
         this.calcSummary();
      }
      
      protected function macroSplitCombo_changeHandler(param1:IndexChangeEvent) : void
      {
         switch(this.macroSplitCombo.selectedItem)
         {
            case "50/50 - 50/50":
               this.setMacroSplit(50,50,50,50);
               break;
            case "50/50 - 75/25":
               this.setMacroSplit(50,50,75,25);
               break;
            case "25/75 - 75/25":
               this.setMacroSplit(25,75,75,25);
               break;
            case "20/80 - 80/20":
               this.setMacroSplit(20,80,80,20);
               break;
            case "15/85 - 85/15":
               this.setMacroSplit(15,85,85,15);
               break;
            case "10/90 - 90/10":
               this.setMacroSplit(10,90,90,10);
         }
         this.calcMacros();
      }
      
      protected function restProteinSlider_changeHandler(param1:Event) : void
      {
         this.restCollection.getItemAt(0).grams = this.user.restcals * (this.restProteinSlider.value / 100) / 4;
         this.calcRestMacros();
      }
      
      protected function proteinSliders_changeEndHandler(param1:FlexEvent) : void
      {
         this.proteinCombo.selectedItem = "Custom";
         this.customProteinRest.enabled = true;
         this.customProteinWorkout.enabled = true;
      }
      
      protected function restCarbsSlider_changeHandler(param1:Event) : void
      {
         this.restCollection.getItemAt(1).split = this.restCarbsSlider.value / (100 - this.restCollection.getItemAt(0).pct) * 100;
         this.restCollection.getItemAt(2).split = 100 - this.restCollection.getItemAt(1).split;
         this.calcRestMacros();
      }
      
      protected function restFatSlider_changeHandler(param1:Event) : void
      {
         this.restCollection.getItemAt(2).split = this.restFatSlider.value / (100 - this.restCollection.getItemAt(0).pct) * 100;
         this.restCollection.getItemAt(1).split = 100 - this.restCollection.getItemAt(2).split;
         this.calcRestMacros();
      }
      
      protected function workoutProteinSlider_changeHandler(param1:Event) : void
      {
         this.workoutCollection.getItemAt(0).grams = this.user.workoutcals * (this.workoutProteinSlider.value / 100) / 4;
         this.calcWorkoutMacros();
      }
      
      protected function workoutCarbsSlider_changeHandler(param1:Event) : void
      {
         this.workoutCollection.getItemAt(1).split = this.workoutCarbsSlider.value / (100 - this.workoutCollection.getItemAt(0).pct) * 100;
         this.workoutCollection.getItemAt(2).split = 100 - this.workoutCollection.getItemAt(1).split;
         this.calcWorkoutMacros();
      }
      
      protected function workoutFatSlider_changeHandler(param1:Event) : void
      {
         this.workoutCollection.getItemAt(2).split = this.workoutFatSlider.value / (100 - this.workoutCollection.getItemAt(0).pct) * 100;
         this.workoutCollection.getItemAt(1).split = 100 - this.workoutCollection.getItemAt(2).split;
         this.calcWorkoutMacros();
      }
      
      protected function restChartLabels(param1:Object, param2:String, param3:Number, param4:Number) : String
      {
         return this.restCollection.getItemAt(param3).name + "\n(" + this.restCollection.getItemAt(param3).pct.toFixed(1) + "%)\n" + this.restCollection.getItemAt(param3).grams.toFixed(1) + "g\n" + this.restCollection.getItemAt(param3).cals.toFixed(1) + " cals";
      }
      
      protected function workoutChartLabels(param1:Object, param2:String, param3:Number, param4:Number) : String
      {
         return this.workoutCollection.getItemAt(param3).name + "\n(" + this.workoutCollection.getItemAt(param3).pct.toFixed(1) + "%)\n" + this.workoutCollection.getItemAt(param3).grams.toFixed(1) + "g\n" + this.workoutCollection.getItemAt(param3).cals.toFixed(1) + " cals";
      }
      
      protected function setProtein(param1:Number) : void
      {
         this.restCollection.getItemAt(0).grams = param1;
         this.workoutCollection.getItemAt(0).grams = param1;
      }
      
      protected function setDaySplit(param1:int, param2:int) : void
      {
         this.setRestDay(param1);
         this.setWorkoutDay(param2);
      }
      
      protected function setRestDay(param1:int) : void
      {
         this.restDayTdeePct.value = param1;
         this.calcRestDayCalories();
      }
      
      protected function setWorkoutDay(param1:int) : void
      {
         this.workoutDayTdeePct.value = param1;
         this.calcWorkoutDayCalories();
      }
      
      protected function setMacroSplit(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.restCollection.getItemAt(1).split = param1;
         this.restCollection.getItemAt(2).split = param2;
         this.workoutCollection.getItemAt(1).split = param3;
         this.workoutCollection.getItemAt(2).split = param4;
      }
      
      protected function calcDayCalories() : void
      {
         this.calcRestDayCalories();
         this.calcWorkoutDayCalories();
      }
      
      protected function calcRestDayCalories() : void
      {
         var _loc1_:String = "";
         this.user.restcals = Number(this.user.tdee * ((100 + this.restDayTdeePct.value) / 100));
         this.restCalsLBL.text = this.user.restcals.toFixed(0) + " calories";
         if(this.user.restcals < this.user.tdee)
         {
            this.restCalsLBL.styleName = "negative";
            this.restDayTdeePct.styleName = "negative";
            this.restOverUnderString = "under";
            this.restPctTdeeLBL.styleName = "negative";
            this.restCalsDifLBL.styleName = "negative";
         }
         else if(this.user.restcals > this.user.tdee)
         {
            _loc1_ = "+";
            this.restCalsLBL.styleName = "positive";
            this.restDayTdeePct.styleName = "positive";
            this.restOverUnderString = "over";
            this.restPctTdeeLBL.styleName = "positive";
            this.restCalsDifLBL.styleName = "positive";
         }
         else
         {
            this.restCalsLBL.styleName = "zero";
            this.restDayTdeePct.styleName = "zero";
            this.restPctTdeeLBL.styleName = "zero";
            this.restCalsDifLBL.styleName = "zero";
         }
         this.restCalsDifLBL.text = this.user.restcals - this.user.tdee == 0?"":"( " + _loc1_ + Math.round(this.user.restcals - this.user.tdee).toString() + " )";
         if(this.user.mincals > 0 && this.ifTabNav.selectedIndex == 2)
         {
            if(this.user.restcals < this.user.mincals)
            {
               Alert.show("Your Rest Day Calories (" + Math.round(this.user.restcals).toString() + ") are less than your\nMinimum Recommended Daily Calories (" + this.user.mincals.toString() + ") !");
            }
         }
      }
      
      protected function calcWorkoutDayCalories() : void
      {
         var _loc1_:String = "";
         this.user.workoutcals = Number(this.user.tdee * ((100 + this.workoutDayTdeePct.value) / 100));
         this.workoutCalsLBL.text = this.user.workoutcals.toFixed(0) + " calories";
         if(this.user.workoutcals < this.user.tdee)
         {
            this.workoutCalsLBL.styleName = "negative";
            this.workoutDayTdeePct.styleName = "negative";
            this.workoutOverUnderString = "under";
            this.workoutPctTdeeLBL.styleName = "negative";
            this.workoutCalsDifLBL.styleName = "negative";
         }
         else if(this.user.workoutcals > this.user.tdee)
         {
            _loc1_ = "+";
            this.workoutCalsLBL.styleName = "positive";
            this.workoutDayTdeePct.styleName = "positive";
            this.workoutOverUnderString = "over";
            this.workoutPctTdeeLBL.styleName = "positive";
            this.workoutCalsDifLBL.styleName = "positive";
         }
         else
         {
            this.workoutCalsLBL.styleName = "zero";
            this.workoutDayTdeePct.styleName = "zero";
            this.workoutPctTdeeLBL.styleName = "zero";
            this.workoutCalsDifLBL.styleName = "zero";
         }
         this.workoutCalsDifLBL.text = this.user.workoutcals - this.user.tdee == 0?"":"( " + _loc1_ + Math.round(this.user.workoutcals - this.user.tdee).toString() + " )";
         if(this.user.mincals > 0 && this.ifTabNav.selectedIndex == 2)
         {
            if(this.user.workoutcals < this.user.mincals)
            {
               Alert.show("Your Workout Day Calories (" + Math.round(this.user.workoutcals).toString() + ") are less than your\nMinimum Recommended Daily Calories (" + this.user.mincals.toString() + ") !");
            }
         }
      }
      
      protected function calcMacros() : void
      {
         this.calcRestMacros();
         this.calcWorkoutMacros();
      }
      
      protected function calcRestMacros() : void
      {
         this.restCollection.getItemAt(0).cals = this.restCollection.getItemAt(0).grams * 4;
         this.restCollection.getItemAt(0).pct = this.restCollection.getItemAt(0).cals / this.user.restcals * 100;
         this.restProteinSlider.value = this.restCollection.getItemAt(0).pct;
         this.restCarbsSlider.maximum = 100 - this.restCollection.getItemAt(0).pct;
         this.restCarbSliderMax.text = this.restCarbsSlider.maximum.toFixed(0);
         this.restFatSlider.maximum = 100 - this.restCollection.getItemAt(0).pct;
         this.restFatSliderMax.text = this.restFatSlider.maximum.toFixed(0);
         this.restCollection.getItemAt(1).pct = (100 - this.restCollection.getItemAt(0).pct) * (this.restCollection.getItemAt(1).split / 100);
         this.restCarbsSlider.value = this.restCollection.getItemAt(1).pct;
         this.restCollection.getItemAt(1).cals = this.user.restcals * (this.restCollection.getItemAt(1).pct / 100);
         this.restCollection.getItemAt(1).grams = this.restCollection.getItemAt(1).cals / 4;
         this.restCollection.getItemAt(2).pct = 100 - (this.restCollection.getItemAt(0).pct + this.restCollection.getItemAt(1).pct);
         this.restFatSlider.value = this.restCollection.getItemAt(2).pct;
         this.restCollection.getItemAt(2).cals = this.user.restcals * (this.restCollection.getItemAt(2).pct / 100);
         this.restCollection.getItemAt(2).grams = this.restCollection.getItemAt(2).cals / 9;
         this.restCollection.refresh();
         this.restDayChart.dataProvider = this.restCollection;
      }
      
      protected function calcWorkoutMacros() : void
      {
         this.workoutCollection.getItemAt(0).cals = this.workoutCollection.getItemAt(0).grams * 4;
         this.workoutCollection.getItemAt(0).pct = this.workoutCollection.getItemAt(0).cals / this.user.workoutcals * 100;
         this.workoutProteinSlider.value = this.workoutCollection.getItemAt(0).pct;
         this.workoutCarbsSlider.maximum = 100 - this.workoutCollection.getItemAt(0).pct;
         this.workoutCarbSliderMax.text = this.workoutCarbsSlider.maximum.toFixed(0);
         this.workoutFatSlider.maximum = 100 - this.workoutCollection.getItemAt(0).pct;
         this.workoutFatSliderMax.text = this.workoutFatSlider.maximum.toFixed(0);
         this.workoutCollection.getItemAt(1).pct = (100 - this.workoutCollection.getItemAt(0).pct) * (this.workoutCollection.getItemAt(1).split / 100);
         this.workoutCarbsSlider.value = this.workoutCollection.getItemAt(1).pct;
         this.workoutCollection.getItemAt(1).cals = this.user.workoutcals * (this.workoutCollection.getItemAt(1).pct / 100);
         this.workoutCollection.getItemAt(1).grams = this.workoutCollection.getItemAt(1).cals / 4;
         this.workoutCollection.getItemAt(2).pct = 100 - (this.workoutCollection.getItemAt(0).pct + this.workoutCollection.getItemAt(1).pct);
         this.workoutFatSlider.value = this.workoutCollection.getItemAt(2).pct;
         this.workoutCollection.getItemAt(2).cals = this.user.workoutcals * (this.workoutCollection.getItemAt(2).pct / 100);
         this.workoutCollection.getItemAt(2).grams = this.workoutCollection.getItemAt(2).cals / 9;
         this.workoutCollection.refresh();
         this.workoutDayChart.dataProvider = this.workoutCollection;
      }
      
      protected function calcSummary() : void
      {
         var _loc1_:Number = this.cycleCalDif;
         this.cycleTeeCals = this.round(this.user.tdee * this.user.cycledays,2);
         this.cycleCals = this.round((this.user.cycledays - this.user.cycleworkouts) * this.user.restcals + this.user.cycleworkouts * this.user.workoutcals,2);
         this.cycleCalDif = this.cycleCals - this.cycleTeeCals;
         if(_loc1_ > 0 && this.cycleCalDif < 0 || _loc1_ < 0 && this.cycleCalDif > 0)
         {
            this.goalFlag = true;
         }
         this.cycleChange = !!this.user.metric?Number(this.round(this.cycleCalDif / 3500 / 2.2,2)):Number(this.round(this.cycleCalDif / 3500,2));
         this.cycleTdeeLBL.text = this.cycleTeeCals.toFixed(0);
         this.cycleCalsLBL.text = this.cycleCals.toFixed(0);
         this.cycleOverUnderLBL.text = this.cycleCalDif.toFixed(0);
         this.cycleChangeLBL.text = this.cycleChange.toFixed(2);
         if(this.cycleCalDif < 0)
         {
            this.cycleOverUnderLBL.styleName = "negative";
            this.cycleChangeLBL.styleName = "negative";
            this.goalsTab.enabled = true;
         }
         else if(this.cycleCalDif > 0)
         {
            this.cycleOverUnderLBL.styleName = "positive";
            this.cycleChangeLBL.styleName = "positive";
            this.goalsTab.enabled = true;
         }
         else
         {
            this.cycleOverUnderLBL.styleName = "zero";
            this.cycleChangeLBL.styleName = "zero";
            this.goalsTab.enabled = false;
         }
         if(this.cycleCals < this.cycleTeeCals)
         {
            this.cycleCalsLBL.styleName = "negative";
         }
         else if(this.cycleCals > this.cycleTeeCals)
         {
            this.cycleCalsLBL.styleName = "positive";
         }
         else
         {
            this.cycleCalsLBL.styleName = "zero";
         }
      }
      
      protected function restDayTdeePct_changeHandler(param1:Event) : void
      {
         this.daySplitCombo.selectedItem = "Custom";
         this.setRestDay(this.restDayTdeePct.value);
         this.calcRestMacros();
         this.calcSummary();
      }
      
      protected function workoutDayTdeePct_changeHandler(param1:Event) : void
      {
         this.daySplitCombo.selectedItem = "Custom";
         this.calcWorkoutMacros();
         this.setWorkoutDay(this.workoutDayTdeePct.value);
         this.calcSummary();
      }
      
      protected function daysPerCycle_changeHandler(param1:Event) : void
      {
         this.user.cycledays = this.daysPerCycle.value;
         this.cycleText = this.user.cycledays == 7?"Week":"Cycle";
         this.calcSummary();
      }
      
      protected function workoutsPerCycle_changeHandler(param1:Event) : void
      {
         this.user.cycleworkouts = this.workoutsPerCycle.value;
         this.calcSummary();
      }
      
      protected function daysPerCycleGoals_changeHandler(param1:Event) : void
      {
         this.user.cycledays = this.daysPerCycle.value;
         this.cycleText = this.user.cycledays == 7?"Week":"Cycle";
         this.calcSummary();
         this.calcGoals();
      }
      
      protected function workoutsPerCycleGoals_changeHandler(param1:Event) : void
      {
         this.user.cycleworkouts = this.workoutsPerCycle.value;
         this.calcSummary();
         this.calcGoals();
      }
      
      protected function calcGoals() : void
      {
         var _loc3_:String = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc1_:UserObject = new UserObject();
         var _loc2_:Date = new Date(this.startDate.selectedDate.getTime());
         var _loc4_:int = 0;
         var _loc5_:Number = this.cycleChange;
         var _loc6_:Number = this.cycleCalDif;
         var _loc7_:Number = this.cycleCals;
         var _loc8_:Number = this.cycleTeeCals;
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         if(this.cycleCalDif != 0)
         {
            _loc1_.metric = this.user.metric;
            _loc1_.activity = this.user.activity;
            _loc1_.bmr = this.user.bmr;
            _loc1_.bmrformula = this.user.bmrformula;
            _loc1_.height = this.user.height;
            _loc1_.heightin = this.user.heightin;
            _loc1_.weight = this.user.weight;
            _loc1_.bfpct = this.user.bfpct;
            _loc1_.fat = this.user.fat;
            _loc1_.lbm = this.user.lbm;
            _loc1_.tdee = this.user.tdee;
            _loc1_.cycledays = this.user.cycledays;
            _loc1_.cycleworkouts = this.user.cycleworkouts;
            _loc1_.restcals = this.user.restcals;
            _loc1_.workoutcals = this.user.workoutcals;
            _loc1_.genderMale = this.user.genderMale;
            this.goalCollection.removeAll();
            this.goalChangeRateDisplayLBL.text = "(" + this.cycleChange.toFixed(2) + " " + this.weightString + ")";
            if(_loc6_ < 0)
            {
               this.gainLoseTEXT.text = "Lose";
               this.gainLoseTEXT.styleName = "negative";
               this.gainLoseAmt.styleName = "negative";
               this.goalChangeRateDisplayLBL.styleName = "negative";
            }
            else if(_loc6_ > 0)
            {
               this.gainLoseTEXT.text = "Gain";
               this.gainLoseTEXT.styleName = "positive";
               this.gainLoseAmt.styleName = "positive";
               this.goalChangeRateDisplayLBL.styleName = "positive";
            }
            else
            {
               this.gainLoseTEXT.text = "Maintain";
               this.gainLoseTEXT.styleName = "zero";
               this.gainLoseAmt.styleName = "zero";
               this.goalChangeRateDisplayLBL.styleName = "zero";
            }
            if(this.user.bfpct > 0)
            {
               this.lbmfield.visible = true;
               this.fatfield.visible = true;
               this.bfpfield.visible = true;
            }
            else
            {
               this.lbmfield.visible = false;
               this.fatfield.visible = false;
               this.bfpfield.visible = false;
            }
            _loc3_ = (_loc2_.getMonth() + 1).toString() + "/" + _loc2_.getDate().toString() + "/" + _loc2_.getFullYear().toString();
            this.goalCollection.addItem(<cycle><date>{_loc3_}</date><cycleno>{_loc4_}</cycleno><days>{_loc4_ * this.user.cycledays}</days><weight>{_loc1_.weight.toFixed(1)}</weight>
						<lbm>{_loc1_.lbm.toFixed(2)}</lbm><fat>{_loc1_.fat.toFixed(2)}</fat><bfp>{_loc1_.bfpct.toFixed(1)}</bfp><change>0</change><total>{_loc9_.toFixed(2)}</total>
						<tdee>{_loc1_.tdee.toFixed(0)}</tdee><restcals>{_loc1_.restcals.toFixed(0)}</restcals><workoutcals>{_loc1_.workoutcals.toFixed(0)}</workoutcals><cyclecals>{_loc7_.toFixed(0)}</cyclecals></cycle>);
            while(Math.abs(_loc9_) < this.gainLoseAmt.value)
            {
               _loc4_++;
               _loc2_.setTime(_loc2_.getTime() + this.user.cycledays * millisecondsPerDay);
               _loc3_ = (_loc2_.getMonth() + 1).toString() + "/" + _loc2_.getDate().toString() + "/" + _loc2_.getFullYear().toString();
               if(this.recalcWeight.value > 0)
               {
                  if(Math.abs(_loc10_) >= this.recalcWeight.value)
                  {
                     _loc1_.calcBmr();
                     _loc8_ = this.round(_loc1_.tdee * _loc1_.cycledays,2);
                     _loc1_.restcals = (100 + this.restDayTdeePct.value) / 100 * _loc1_.tdee;
                     _loc1_.workoutcals = (100 + this.workoutDayTdeePct.value) / 100 * _loc1_.tdee;
                     _loc7_ = this.round((_loc1_.cycledays - _loc1_.cycleworkouts) * _loc1_.restcals + _loc1_.workoutcals * _loc1_.cycleworkouts,2);
                     if(this.maintainChangerate.selected)
                     {
                        _loc11_ = _loc8_ + _loc6_;
                        _loc12_ = _loc7_ - _loc11_;
                        _loc13_ = _loc1_.restcals / _loc1_.workoutcals;
                        _loc14_ = _loc12_ * _loc13_;
                        _loc15_ = _loc12_ - _loc14_;
                        _loc14_ = _loc14_ / (_loc1_.cycledays - _loc1_.cycleworkouts);
                        _loc15_ = _loc15_ / _loc1_.cycleworkouts;
                        _loc1_.restcals = _loc1_.restcals - _loc14_;
                        _loc1_.workoutcals = _loc1_.workoutcals - _loc15_;
                        _loc7_ = this.round((_loc1_.cycledays - _loc1_.cycleworkouts) * _loc1_.restcals + _loc1_.workoutcals * _loc1_.cycleworkouts,2);
                     }
                     _loc6_ = _loc7_ - _loc8_;
                     _loc5_ = !!_loc1_.metric?Number(this.round(_loc6_ / 3500 / 2.2,2)):Number(this.round(_loc6_ / 3500,2));
                     _loc10_ = _loc6_ > 0?Number(_loc10_ - this.recalcWeight.value):Number(_loc10_ + this.recalcWeight.value);
                  }
               }
               _loc9_ = _loc9_ + _loc5_;
               _loc1_.weight = _loc1_.weight + _loc5_;
               _loc10_ = _loc10_ + _loc5_;
               if(this.user.bfpct > 0)
               {
                  _loc1_.lbm = _loc1_.lbm + _loc5_ * ((100 - this.recalcFatLossPct.value) / 100);
                  _loc1_.fat = _loc1_.weight - _loc1_.lbm;
                  _loc1_.bfpct = _loc1_.fat / _loc1_.weight * 100;
               }
               this.goalCollection.addItem(<cycle><date>{_loc3_}</date><cycleno>{_loc4_}</cycleno><days>{_loc4_ * this.user.cycledays}</days><weight>{_loc1_.weight.toFixed(1)}</weight>
							<lbm>{_loc1_.lbm.toFixed(2)}</lbm><fat>{_loc1_.fat.toFixed(2)}</fat><bfp>{_loc1_.bfpct.toFixed(1)}</bfp><change>{_loc5_}</change><total>{_loc9_.toFixed(2)}</total>
							<tdee>{_loc1_.tdee.toFixed(0)}</tdee><restcals>{_loc1_.restcals.toFixed(0)}</restcals><workoutcals>{_loc1_.workoutcals.toFixed(0)}</workoutcals><cyclecals>{_loc7_.toFixed(0)}</cyclecals></cycle>);
            }
            this.goalsCyclesToComplete.text = _loc4_.toString();
            this.goalsDaysToComplete.text = "(" + (_loc4_ * this.user.cycledays).toString() + " days)";
            this.goalsFinishDate.text = _loc2_.toDateString();
            this.weightToLBL.text = this.user.weight.toFixed(1) + " " + this.weightString + " to " + _loc1_.weight.toFixed(1) + " " + this.weightString;
            this.weightDifLBL.text = (_loc1_.weight - this.user.weight).toFixed(2) + " " + this.weightString + " / " + ((this.user.weight - _loc1_.weight) / this.user.weight * 100).toFixed(2) + "%";
            if(this.user.weight > _loc1_.weight)
            {
               this.weightDifLBL.styleName = "negative";
            }
            else if(this.user.weight < _loc1_.weight)
            {
               this.weightDifLBL.styleName = "positive";
            }
            else
            {
               this.weightDifLBL.styleName = "zero";
            }
            if(this.user.bfpct > 0)
            {
               this.bfGoals.visible = true;
               this.recalcFatLossPct.enabled = true;
               this.lbmToLBL.text = this.user.lbm.toFixed(1) + " " + this.weightString + " to " + _loc1_.lbm.toFixed(1) + " " + this.weightString;
               this.lbmDifLBL.text = (_loc1_.lbm - this.user.lbm).toFixed(2) + " " + this.weightString + " / " + ((this.user.lbm - _loc1_.lbm) / this.user.lbm * 100).toFixed(2) + "%";
               if(this.user.lbm > _loc1_.lbm)
               {
                  this.lbmDifLBL.styleName = "negative";
               }
               else if(this.user.lbm < _loc1_.lbm)
               {
                  this.lbmDifLBL.styleName = "positive";
               }
               else
               {
                  this.lbmDifLBL.styleName = "zero";
               }
               this.fatToLBL.text = this.user.fat.toFixed(1) + " " + this.weightString + " to " + _loc1_.fat.toFixed(1) + " " + this.weightString;
               this.fatDifLBL.text = (_loc1_.fat - this.user.fat).toFixed(2) + " " + this.weightString + " / " + ((this.user.fat - _loc1_.fat) / this.user.fat * 100).toFixed(2) + "%";
               if(this.user.fat > _loc1_.fat)
               {
                  this.fatDifLBL.styleName = "negative";
               }
               else if(this.user.fat < _loc1_.fat)
               {
                  this.fatDifLBL.styleName = "positive";
               }
               else
               {
                  this.fatDifLBL.styleName = "zero";
               }
               this.bfpToLBL.text = this.user.bfpct.toFixed(2) + "% to " + _loc1_.bfpct.toFixed(2) + "%";
               this.bfpDifLBL.text = (_loc1_.bfpct - this.user.bfpct).toFixed(2) + "% / " + ((this.user.bfpct - _loc1_.bfpct) / this.user.bfpct * 100).toFixed(2) + "%";
               if(this.user.fat > _loc1_.fat)
               {
                  this.bfpDifLBL.styleName = "negative";
               }
               else if(this.user.fat < _loc1_.fat)
               {
                  this.bfpDifLBL.styleName = "positive";
               }
               else
               {
                  this.bfpDifLBL.styleName = "zero";
               }
            }
            else
            {
               this.bfGoals.visible = false;
               this.recalcFatLossPct.enabled = false;
            }
         }
      }
      
      protected function goalGraphBTN_clickHandler(param1:MouseEvent) : void
      {
         if(this.goalGraphBTN.selected)
         {
            this.goalSetAxis();
            if(this.user.bfpct > 0)
            {
               this.goalChartFieldFat.enabled = true;
            }
            else
            {
               this.goalChartFieldFat.enabled = false;
            }
         }
         this.goalChart.visible = this.goalGraphBTN.selected;
         this.goalTable.visible = !this.goalGraphBTN.selected;
      }
      
      protected function goalChartFieldsGroup_changeHandler(param1:Event) : void
      {
         this.goalSetAxis();
         if(this.goalChartFieldsGroup.selectedValue == "weight")
         {
            this.goalSeriesLBM.visible = false;
            this.goalSeriesFat.visible = false;
            this.goalChartLegend.visible = false;
         }
         else
         {
            this.goalSeriesLBM.visible = true;
            this.goalSeriesFat.visible = true;
            this.goalChartLegend.visible = true;
         }
      }
      
      protected function goalSetAxis() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = Number(this.goalCollection.getItemAt(0).weight);
         var _loc2_:Number = Number(this.goalCollection.getItemAt(this.goalCollection.length - 1).weight);
         this.goalVertAxis.maximum = _loc1_ > _loc2_?Number(_loc1_):Number(_loc2_);
         if(this.goalChartFieldsGroup.selectedValue == "weight")
         {
            this.goalVertAxis.minimum = _loc1_ > _loc2_?Number(_loc2_):Number(_loc1_);
         }
         else
         {
            if(Number(this.goalCollection.getItemAt(0).lbm) > Number(this.goalCollection.getItemAt(this.goalCollection.length - 1).lbm))
            {
               _loc3_ = Number(this.goalCollection.getItemAt(this.goalCollection.length - 1).lbm);
            }
            else
            {
               _loc3_ = Number(this.goalCollection.getItemAt(0).lbm);
            }
            if(_loc3_ > Number(this.goalCollection.getItemAt(this.goalCollection.length - 1).fat))
            {
               _loc3_ = Number(this.goalCollection.getItemAt(this.goalCollection.length - 1).fat);
            }
            if(_loc3_ > Number(this.goalCollection.getItemAt(0).fat))
            {
               _loc3_ = Number(this.goalCollection.getItemAt(0).fat);
            }
            this.goalVertAxis.minimum = _loc3_;
         }
      }
      
      protected function goalXMLBTN0_clickHandler(param1:MouseEvent) : void
      {
         this.goalCSVBTN0.selected = false;
         this.goalExportTXA0.visible = this.goalXMLBTN0.selected;
         if(this.goalXMLBTN0.selected)
         {
            this.goalExportTXA0.text = this.goalCollection.toXMLString();
         }
      }
      
      protected function goalCSVBTN0_clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:XMLList = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:XMLList = null;
         var _loc7_:int = 0;
         this.goalXMLBTN0.selected = false;
         this.goalExportTXA0.visible = this.goalCSVBTN0.selected;
         if(this.goalCSVBTN0.selected)
         {
            _loc2_ = "";
            _loc3_ = this.goalCollection[0].@*;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length())
            {
               _loc2_ = _loc2_ + (_loc3_[_loc4_].name() + ",");
               _loc4_++;
            }
            _loc2_ = _loc2_ + "\n";
            _loc5_ = 0;
            while(_loc5_ < this.goalCollection.length)
            {
               _loc6_ = this.goalCollection[_loc5_].@*;
               _loc7_ = 0;
               while(_loc7_ < _loc6_.length())
               {
                  _loc2_ = _loc2_ + (_loc6_[_loc7_] + ",");
                  _loc7_++;
               }
               _loc2_ = _loc2_ + "\n";
               _loc5_++;
            }
            this.goalExportTXA0.text = _loc2_;
         }
      }
      
      private function _IFCalc_String5_i() : String
      {
         var _loc1_:String = "<b><u>Activty Level</u></b><br/>This is your activity level, estimated as:<br/><br/><ul><li><b>Sedentary:</b> little or no exercise, x1.2</li><li><b>Lightly Active:</b> light exercise/sports 1-3 days/week, x1.375</li><li><b>Moderately Active:</b> moderate exercise/sports 3-5 days/week, x1.55</li><li><b>Very Active:</b> hard exercise/sports 6-7 days a week, x1.725</li><li><b>Extra Active:</b> very hard exercise/sports and physical job, x1.9</li></ul>";
         this.activityDESC = _loc1_;
         BindingManager.executeBindings(this,"activityDESC",this.activityDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String4_i() : String
      {
         var _loc1_:String = "<b><u>Age</u></b><br/>This is your age in years, used for calculating BMR (some formulas) and (indirectly) TDEE.";
         this.ageDESC = _loc1_;
         BindingManager.executeBindings(this,"ageDESC",this.ageDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String8_i() : String
      {
         var _loc1_:String = "<b><u>Calculate Bodyfat</u></b><br/><b>USE AS A LAST RESORT!</b> This uses a <u>very inaccurate</u> formula to attempt to calculate your bodyfat percent. It is dependant on and very sensitive to your waist size measurement as well as your weight, and tends to under-estimate bf%. Formulas used are:<br/><br/><b>Male:</b> 100 x (-98.42 + 4.15 x waist - 0.082 x weight) / weight<br/><br/><b>Female:</b> 100 x (-76.76 + 4.15 x waist - 0.082 x weight) / weight";
         this.bfcalcDESC = _loc1_;
         BindingManager.executeBindings(this,"bfcalcDESC",this.bfcalcDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String23_i() : String
      {
         var _loc1_:String = "<b><u>Body Mass Index (BMI)</u></b><br/>BMI is a calculation based on a persons weight and height that attempts to give a heuristic proxy for human body fat. While considered reliable by the CDC, it is often inaccurate for muscular athletes and shorter people and children. BMI values fall into the following categories:<br/><br/><ul><li><b>Severely Underweight, </b>under 16</li><li><b>Underweight, </b>16.0 to 18.5</li><li><b>Normal, </b>18.5 to 25</li><li><b>Overweight, </b>25 to 30</li><li><b>Obese I, </b>30 to 35</li><li><b>Obese II, </b>35 to 40</li><li><b>Obese III, </b>over 40</li></ul>";
         this.bmiDESC = _loc1_;
         BindingManager.executeBindings(this,"bmiDESC",this.bmiDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String24_i() : String
      {
         var _loc1_:String = "<b><u>\"Perfect Twin\" BMI</u></b><br/>The weight of someone at your height with a \"perfect\" BMI of 22.";
         this.bmiTwinDESC = _loc1_;
         BindingManager.executeBindings(this,"bmiTwinDESC",this.bmiTwinDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String10_i() : String
      {
         var _loc1_:String = "<b><u>Basal Metabolic Rate (BMR)</u></b><br/>Your Basal Metabolic Rate is your daily energy expenditure in calories without any contribution from exercise or digestion. Think of BMR as the amount of calories you would need to consume daily to maintain your body if you were comatose.";
         this.bmrDESC = _loc1_;
         BindingManager.executeBindings(this,"bmrDESC",this.bmrDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String14_i() : String
      {
         var _loc1_:String = "<b><u>Average BMR</u></b><br/>This is an average of the Mifflin-St Jeor, Harris-Benedict and Katch-McArdle formulas.";
         this.bmrFormulaAVDESC = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaAVDESC",this.bmrFormulaAVDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String16_i() : String
      {
         var _loc1_:String = "<b><u>Custom BMR</u></b><br/>Allows you to enter a custom BMR value, useful if you have had your actual BMR measured by gas analysis calorimetry or some other method.";
         this.bmrFormulaCUSDESC = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaCUSDESC",this.bmrFormulaCUSDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String12_i() : String
      {
         var _loc1_:String = "<b><u>Harris-Benedict BMR formula</u></b><br/>An older BMR formula used when bodyfat % is not known. The formulas used are:<br/><br/><b>Male:</b> 66+(6.23 x weight in pounds)+(12.7 x height in inches)-(6.76 x age in years)<br/><br/><b>Female:</b> 655+(4.35 x weight in pounds)+(4.7 x height in inches)-(4.7 x age in years)";
         this.bmrFormulaHBDESC = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaHBDESC",this.bmrFormulaHBDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String13_i() : String
      {
         var _loc1_:String = "<b><u>Katch-McArdle BMR formula</u></b><br/>A BMR formula based on lean body mass, the formula is:<br/><br/>370+(21.6 x lean body mass in kg)";
         this.bmrFormulaKMDESC = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaKMDESC",this.bmrFormulaKMDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String11_i() : String
      {
         var _loc1_:String = "<b><u>Mifflin-St Jeor BMR formula</u></b><br/>Generally the most reliable of the BMR formulas when bodyfat % is unknown. The formulas used are:<br/><br/><b>Male:</b> (10 × weight)+(6.25 × height)-(5 × age)+5<br/><br/><b>Female:</b> (10 × weight)+(6.25 × height)-(5 × age)-161";
         this.bmrFormulaMSJDESC = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaMSJDESC",this.bmrFormulaMSJDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String15_i() : String
      {
         var _loc1_:String = "<b><u>Simple Multiplier BMR</u></b><br/>A quick method for determining your BMR is to multiply your total body weight by a simpler multiplier, often-used values are 10, 11 or 12.";
         this.bmrFormulaMULDESC = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaMULDESC",this.bmrFormulaMULDESC);
         return _loc1_;
      }
      
      private function _IFCalc_RadioButtonGroup3_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.__bmrGroup_change);
         _loc1_.initialized(this,"bmrGroup");
         this.bmrGroup = _loc1_;
         BindingManager.executeBindings(this,"bmrGroup",this.bmrGroup);
         return _loc1_;
      }
      
      public function __bmrGroup_change(param1:Event) : void
      {
         this.bmrGroup_changeHandler(param1);
      }
      
      private function _IFCalc_String7_i() : String
      {
         var _loc1_:String = "<b><u>Bodyfat</u></b><br/>If you have a relatively accurate bodyfat percent estimation you should enter it here. This will enable more accurate BMR/TDEE calculations as well as fat loss/gain calculations on the Goals tab.";
         this.bodyfatDESC = _loc1_;
         BindingManager.executeBindings(this,"bodyfatDESC",this.bodyfatDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String18_i() : String
      {
         var _loc1_:String = "<b><u>Fat Body Mass</u></b><br/>Total weight of the fat in your body. Simply your total weight x bodyfat %.";
         this.fbmDESC = _loc1_;
         BindingManager.executeBindings(this,"fbmDESC",this.fbmDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String6_i() : String
      {
         var _loc1_:String = "<b><u>Gender</u></b><br/>Some calculations require different formulas depending on your gender, please select Male (default) or Female.";
         this.genderDESC = _loc1_;
         BindingManager.executeBindings(this,"genderDESC",this.genderDESC);
         return _loc1_;
      }
      
      private function _IFCalc_RadioButtonGroup2_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.__genderGroup_change);
         _loc1_.initialized(this,"genderGroup");
         this.genderGroup = _loc1_;
         BindingManager.executeBindings(this,"genderGroup",this.genderGroup);
         return _loc1_;
      }
      
      public function __genderGroup_change(param1:Event) : void
      {
         this.genderGroup_changeHandler(param1);
      }
      
      private function _IFCalc_RadioButtonGroup5_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.__goalChartFieldsGroup_change);
         _loc1_.initialized(this,"goalChartFieldsGroup");
         this.goalChartFieldsGroup = _loc1_;
         BindingManager.executeBindings(this,"goalChartFieldsGroup",this.goalChartFieldsGroup);
         return _loc1_;
      }
      
      public function __goalChartFieldsGroup_change(param1:Event) : void
      {
         this.goalChartFieldsGroup_changeHandler(param1);
      }
      
      private function _IFCalc_String1_i() : String
      {
         var _loc1_:String = "<b><u>Height</u></b><br/>This is your height in feet or centimeters, used for calculating BMR (some formulas), BMI, Waist-to-Height Ratio and (indirectly) TDEE.";
         this.heightDESC = _loc1_;
         BindingManager.executeBindings(this,"heightDESC",this.heightDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String2_i() : String
      {
         var _loc1_:String = "<b><u>Inches</u></b><br/>This is the inches component of your height for imperial (non-metric) measurements, used for calculating BMR (some formulas), BMI, Waist-to-Height Ratio and (indirectly) TDEE.";
         this.inchesDESC = _loc1_;
         BindingManager.executeBindings(this,"inchesDESC",this.inchesDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String17_i() : String
      {
         var _loc1_:String = "<b><u>Lean Body Mass</u></b><br/>The total weight of your bones, muscles, organs, connective tissue, skin, water, etc. - everything but the fat.";
         this.lbmDESC = _loc1_;
         BindingManager.executeBindings(this,"lbmDESC",this.lbmDESC);
         return _loc1_;
      }
      
      private function _IFCalc_RadioButtonGroup4_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.__maintainSchedule_change);
         _loc1_.initialized(this,"maintainSchedule");
         this.maintainSchedule = _loc1_;
         BindingManager.executeBindings(this,"maintainSchedule",this.maintainSchedule);
         return _loc1_;
      }
      
      public function __maintainSchedule_change(param1:Event) : void
      {
         this.calcGoals();
      }
      
      private function _IFCalc_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.__measureGroup_change);
         _loc1_.initialized(this,"measureGroup");
         this.measureGroup = _loc1_;
         BindingManager.executeBindings(this,"measureGroup",this.measureGroup);
         return _loc1_;
      }
      
      public function __measureGroup_change(param1:Event) : void
      {
         this.measureGroup_changeHandler(param1);
      }
      
      private function _IFCalc_String26_i() : String
      {
         var _loc1_:String = "<b><u>Maximum Fat Metabolism</u></b><br/>Assuming 1 lb of fat contributes 30 calories per day to metabolism, this is the number of daily calories that your body can supply you with from it\'s fat stores. Theoretically this is the number of calories you could eat below your TDEE without losing muscle mass, assuming no muscle atrophy takes place.";
         this.mfmDESC = _loc1_;
         BindingManager.executeBindings(this,"mfmDESC",this.mfmDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String27_i() : String
      {
         var _loc1_:String = "<b><u>Minimum Recommended Calories</u></b><br/>This is the difference between your TDEE and your Maximum Fat Metabolism. Consuming fewer than this number of calories risks your body using lean body mass (LBM) for fuel in addition to your consumed calories.";
         this.minCalsDESC = _loc1_;
         BindingManager.executeBindings(this,"minCalsDESC",this.minCalsDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String19_i() : String
      {
         var _loc1_:String = "<b><u>Total Daily Energy Expenditure (TDEE)</u></b><br/>The total calories you require on a daily basis, including:<br/><br/><ul><li><b>Basal Metabolic Rate (BMR)</b></li><li><b>Non-Exercise Associated Thermogenesis (NEAT)</b> which is calorie requirements from normal daily activity (<i>NOT</i> from exercise) likewalking, working, chores, etc.</li><li><b>Exercise Associated Thermogenesis (EAT)</b> which is calorie requirements from planned exercise and sports</li><li><b>Thermic Effect of Feeding (TEF)</b> which are calories associated with eating and digestion</li></ul><br/>TEF varies according to macronutrient and fiber content of your diet, with Protein having a TEF of up to 30% of the consumed calories, while Carbs is around 6% and Fat a mere 3%.";
         this.tdeeDESC = _loc1_;
         BindingManager.executeBindings(this,"tdeeDESC",this.tdeeDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String20_i() : String
      {
         var _loc1_:String = "<b><u>Calculated TDEE</u></b><br/>Your Total Daily Energy Expenditure, calculated as:<br/><br/>BMR x Activity Level Factor<br/><br/>Activity Level starts at 1.2 for Sedentary and ranges to 1.9 for Extra Active.";
         this.tdeeFormulaCALDESC = _loc1_;
         BindingManager.executeBindings(this,"tdeeFormulaCALDESC",this.tdeeFormulaCALDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String22_i() : String
      {
         var _loc1_:String = "<b><u>Custom TDEE</u></b><br/>Allows you to enter a custom TDEE value.";
         this.tdeeFormulaCUSDESC = _loc1_;
         BindingManager.executeBindings(this,"tdeeFormulaCUSDESC",this.tdeeFormulaCUSDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String21_i() : String
      {
         var _loc1_:String = "<b><u>Simple Multiplier TDEE</u></b><br/>A quick method for determining your TDEE is to multiply your total body weight by a simple multipler, often-used values are 14, 15 or 16.";
         this.tdeeFormulaMULDESC = _loc1_;
         BindingManager.executeBindings(this,"tdeeFormulaMULDESC",this.tdeeFormulaMULDESC);
         return _loc1_;
      }
      
      private function _IFCalc_RadioButtonGroup6_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.__tdeeGroup_change);
         _loc1_.initialized(this,"tdeeGroup");
         this.tdeeGroup = _loc1_;
         BindingManager.executeBindings(this,"tdeeGroup",this.tdeeGroup);
         return _loc1_;
      }
      
      public function __tdeeGroup_change(param1:Event) : void
      {
         this.tdeeGroup_changeHandler(param1);
      }
      
      private function _IFCalc_String9_i() : String
      {
         var _loc1_:String = "<b><u>Waist Measurement</u></b><br/>This is your waist measurement, measured in either inches or cm. This is used for the Waist-to-Height ratio calculation as well as the \"Calculate\" bodyfat % formula. Measurement is usually taken 1/2-1\" below your navel.";
         this.waistDESC = _loc1_;
         BindingManager.executeBindings(this,"waistDESC",this.waistDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String3_i() : String
      {
         var _loc1_:String = "<b><u>Weight</u></b><br/>This is your weight in pounds or kilograms, used for calculating BMR, BMI, Waist-to-Height Ratio and (indirectly) TDEE.";
         this.weightDESC = _loc1_;
         BindingManager.executeBindings(this,"weightDESC",this.weightDESC);
         return _loc1_;
      }
      
      private function _IFCalc_String25_i() : String
      {
         var _loc1_:String = "<b><u>Waist-to-Height Ratio</u></b><br/>General health indicator that may be more accurate than BMI for serious athletes who have a higher percentage of muscle and lower percentage of body fat, and women who have a \"pear\" rather than \"apple\" shape.<br/><br/>A value under 50% is generally considered heathly.";
         this.wthRatioDESC = _loc1_;
         BindingManager.executeBindings(this,"wthRatioDESC",this.wthRatioDESC);
         return _loc1_;
      }
      
      private function _IFCalc_Array1_c() : Array
      {
         var _loc1_:Array = [this._IFCalc_BorderContainer1_c(),this._IFCalc_TabNavigator1_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer1_c() : BorderContainer
      {
         var _loc1_:BorderContainer = new BorderContainer();
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.width = 960;
         _loc1_.height = 700;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array2_c);
         _loc1_.setStyle("contentBackgroundAlpha",0);
         _loc1_.setStyle("backgroundAlpha",0);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array2_c() : Array
      {
         var _loc1_:Array = [this._IFCalc_Label1_c(),this._IFCalc_Label2_c(),this._IFCalc_Button1_i(),this._IFCalc_Button2_i(),this._IFCalc_Label3_c(),this._IFCalc_Label4_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label1_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 208;
         _loc1_.y = 12;
         _loc1_.text = "Intermittent Fasting Calculator";
         _loc1_.setStyle("fontSize",30);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontFamily","Georgia");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("color",13158600);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label2_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 206;
         _loc1_.y = 10;
         _loc1_.text = "Intermittent Fasting Calculator";
         _loc1_.setStyle("fontSize",30);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontFamily","Georgia");
         _loc1_.setStyle("fontStyle","italic");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Button1_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.x = 403;
         _loc1_.y = 667;
         _loc1_.label = "Prev Step";
         _loc1_.enabled = false;
         _loc1_.addEventListener("click",this.__prevBTN_click);
         _loc1_.id = "prevBTN";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.prevBTN = _loc1_;
         BindingManager.executeBindings(this,"prevBTN",this.prevBTN);
         return _loc1_;
      }
      
      public function __prevBTN_click(param1:MouseEvent) : void
      {
         this.prevBTN_clickHandler(param1);
      }
      
      private function _IFCalc_Button2_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.x = 486;
         _loc1_.y = 667;
         _loc1_.label = "Next Step";
         _loc1_.enabled = false;
         _loc1_.addEventListener("click",this.__nextBTN_click);
         _loc1_.id = "nextBTN";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.nextBTN = _loc1_;
         BindingManager.executeBindings(this,"nextBTN",this.nextBTN);
         return _loc1_;
      }
      
      public function __nextBTN_click(param1:MouseEvent) : void
      {
         this.nextBTN_clickHandler(param1);
      }
      
      private function _IFCalc_Label3_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 708;
         _loc1_.y = 24.300003;
         _loc1_.text = "ver.";
         _loc1_.setStyle("fontFamily","Times New Roman");
         _loc1_.setStyle("fontStyle","italic");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label4_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 727;
         _loc1_.y = 24.25;
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textAlign","left");
         _loc1_.id = "_IFCalc_Label4";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._IFCalc_Label4 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_Label4",this._IFCalc_Label4);
         return _loc1_;
      }
      
      private function _IFCalc_TabNavigator1_i() : TabNavigator
      {
         var temp:TabNavigator = new TabNavigator();
         temp.x = 10;
         temp.y = 50;
         temp.width = 940;
         temp.height = 610;
         temp.setStyle("backgroundColor",14609407);
         temp.addEventListener("change",this.__ifTabNav_change);
         temp.id = "ifTabNav";
         if(!temp.document)
         {
            temp.document = this;
         }
         temp.mx_internal::_documentDescriptor = new UIComponentDescriptor({
            "type":TabNavigator,
            "id":"ifTabNav",
            "events":{"change":"__ifTabNav_change"},
            "stylesFactory":function():void
            {
               this.backgroundColor = 14609407;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":NavigatorContent,
                  "id":"disclaimerTab",
                  "stylesFactory":function():void
                  {
                     this.contentBackgroundAlpha = 1;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"1. Disclaimer",
                        "percentWidth":100,
                        "percentHeight":100,
                        "mxmlContentFactory":new DeferredInstanceFromFunction(_IFCalc_Array3_c)
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":NavigatorContent,
                  "id":"infoTab",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"2. Basic Info",
                        "percentWidth":100,
                        "percentHeight":100,
                        "mxmlContentFactory":new DeferredInstanceFromFunction(_IFCalc_Array4_c)
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":NavigatorContent,
                  "id":"macroCalcTab",
                  "events":{"contentCreationComplete":"__macroCalcTab_contentCreationComplete"},
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 14609407;
                     this.backgroundAlpha = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"3. Macro Calculator",
                        "percentWidth":100,
                        "percentHeight":100,
                        "mxmlContentFactory":new DeferredInstanceFromFunction(_IFCalc_Array12_c)
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":NavigatorContent,
                  "id":"goalsTab",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"4. Goals",
                        "percentWidth":100,
                        "percentHeight":100,
                        "creationPolicy":"all",
                        "mxmlContentFactory":new DeferredInstanceFromFunction(_IFCalc_Array24_c)
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":NavigatorContent,
                  "id":"lifestyleTab",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"5. Lifestyle",
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":NavigatorContent,
                  "id":"mealsTab",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"6. Meal Planner",
                        "percentWidth":100,
                        "percentHeight":100,
                        "mxmlContentFactory":new DeferredInstanceFromFunction(_IFCalc_Array34_c)
                     };
                  }
               })]};
            }
         });
         temp.mx_internal::_documentDescriptor.document = this;
         this.ifTabNav = temp;
         BindingManager.executeBindings(this,"ifTabNav",this.ifTabNav);
         return temp;
      }
      
      public function __ifTabNav_change(param1:IndexChangedEvent) : void
      {
         this.ifTabNav_changeHandler(param1);
      }
      
      private function _IFCalc_Array3_c() : Array
      {
         var _loc1_:Array = [this._IFCalc_TextArea1_c(),this._IFCalc_CheckBox1_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_TextArea1_c() : mx.controls.TextArea
      {
         var _loc1_:mx.controls.TextArea = new mx.controls.TextArea();
         _loc1_.x = 150;
         _loc1_.y = 44;
         _loc1_.width = 640;
         _loc1_.height = 440;
         _loc1_.editable = false;
         _loc1_.htmlText = "<b>IF Calculator Terms and Conditions of Use</b><br>PLEASE READ THESE TERMS AND CONDITIONS OF USE CAREFULLY BEFORE USING THIS PROGRAM.<br>By using the Program, you signify your assent to these Terms and Conditions. If you do not agree to all of these Terms and Conditions of use, do not use the Program!<br>Creator/Programmer of the IF Calculator (‘Program’) may revise and update these Terms and Conditions at any time. Your continued usage of this program will mean you accept those changes.<br><br><b>THE PROGRAM DOES NOT PROVIDE MEDICAL ADVICE.</b><br>The full contents of the Program, such as text, comments, graphics, images, and other material contained in the Program are for informational purposes only. This Program has not been evaluated by the Food and Drug Administration. and is not intended to diagnose, treat, cure or prevent any disease. Always consult you physician before starting any exercise program or changing dietary habits. The Program is not intended to be a substitute for professional medical advice, diagnosis, or treatment. It is not a substitute for a medical exam, nor does it replace the need for services provided by medical professional. Always seek the advice of your doctor before making any changes to your exercise habits, dietary regiment or taking any supplements. If you think you may have a medical emergency, call your doctor or 911 immediately.<br><br><b>RELEASE OF LIABILITY OF PROGRAM AND PROGRAM CREATORS/OWNERS</b><br>The use of the Program is at your own risk. In no event shall the Program, its owners, creators and/or programmers, or any third parties mentioned in the Program be liable for any damages in the future including, but not limited to, heart attacks, muscle strains, pulls or tears, broken bones, shin splints, heat prostration, knee/ lower back/ foot injuries, and other illness/disease, or injury/damage (mental, physical, financial), however caused, occurring during or after altering any personal nutritional/fitness/lifestyle habits or actions. The Program and Owners/Programmers/Creators do not assume any responsibility for any aspect of healthcare administered with the aid of content available in the Program. User understands that any and all advice/programs concerning exercise not done under supervision of a qualified trainer and nutrition is for educational purposes only. User understands nutritional advice is not intended as a substitute for professional medical advice, diagnosis or treatment. User has been advised to seek medical advice from a physician before altering their nutritional daily diet or beginning an exercise program.<br><br><b>COMPLETE AGREEMENT.</b><br>These Terms and Conditions constitute the agreement between you and this Program with respect to the use of the Program. User, for themself, their heirs and assigns, hereby release the Program and its Owner(s)/ Programmers(s)/ Creators(s) from any claims, demands and causes of action arising from use of this “Program”. Use of anything in this “Program” is at your own Risk!<br></b>";
         _loc1_.setStyle("fontSize",16);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_CheckBox1_i() : CheckBox
      {
         var _loc1_:CheckBox = new CheckBox();
         _loc1_.x = 289;
         _loc1_.y = 500;
         _loc1_.label = "I agree to the terms and conditions described in this disclaimer";
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__disclaimerCB_click);
         _loc1_.id = "disclaimerCB";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.disclaimerCB = _loc1_;
         BindingManager.executeBindings(this,"disclaimerCB",this.disclaimerCB);
         return _loc1_;
      }
      
      public function __disclaimerCB_click(param1:MouseEvent) : void
      {
         this.disclaimerCB_clickHandler(param1);
      }
      
      private function _IFCalc_Array4_c() : Array
      {
         var _loc1_:Array = [this._IFCalc_BorderContainer2_c(),this._IFCalc_RadioButton3_i(),this._IFCalc_RadioButton4_i(),this._IFCalc_Label20_c(),this._IFCalc_BorderContainer3_c(),this._IFCalc_BorderContainer4_c(),this._IFCalc_BorderContainer5_c(),this._IFCalc_BorderContainer6_c(),this._IFCalc_Label39_c(),this._IFCalc_TextArea2_i(),this._IFCalc_BorderContainer7_c(),this._IFCalc_Label49_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer2_c() : BorderContainer
      {
         var _loc1_:BorderContainer = new BorderContainer();
         _loc1_.x = 51;
         _loc1_.y = 30;
         _loc1_.width = 300;
         _loc1_.height = 350;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array5_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array5_c() : Array
      {
         var _loc1_:Array = [this._IFCalc_Label5_i(),this._IFCalc_TextInput1_i(),this._IFCalc_Label6_i(),this._IFCalc_TextInput2_i(),this._IFCalc_Label7_i(),this._IFCalc_Label8_i(),this._IFCalc_TextInput3_i(),this._IFCalc_Label9_i(),this._IFCalc_Label10_i(),this._IFCalc_TextInput4_i(),this._IFCalc_Label11_i(),this._IFCalc_Label12_i(),this._IFCalc_ComboBox1_i(),this._IFCalc_Label13_i(),this._IFCalc_RadioButton1_i(),this._IFCalc_RadioButton2_i(),this._IFCalc_Label14_i(),this._IFCalc_Label15_i(),this._IFCalc_TextInput5_i(),this._IFCalc_Label16_i(),this._IFCalc_Label17_i(),this._IFCalc_TextInput6_i(),this._IFCalc_Label18_i(),this._IFCalc_Label19_i(),this._IFCalc_HRule1_c(),this._IFCalc_CheckBox2_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label5_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 50;
         _loc1_.y = 31;
         _loc1_.text = "Height:";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("focusIn",this.__heightLBL0_focusIn);
         _loc1_.addEventListener("mouseOver",this.__heightLBL0_mouseOver);
         _loc1_.id = "heightLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.heightLBL0 = _loc1_;
         BindingManager.executeBindings(this,"heightLBL0",this.heightLBL0);
         return _loc1_;
      }
      
      public function __heightLBL0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      public function __heightLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_TextInput1_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 114;
         _loc1_.y = 28;
         _loc1_.width = 40;
         _loc1_.addEventListener("change",this.__heightTXT0_change);
         _loc1_.addEventListener("mouseOver",this.__heightTXT0_mouseOver);
         _loc1_.addEventListener("focusIn",this.__heightTXT0_focusIn);
         _loc1_.id = "heightTXT0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.heightTXT0 = _loc1_;
         BindingManager.executeBindings(this,"heightTXT0",this.heightTXT0);
         return _loc1_;
      }
      
      public function __heightTXT0_change(param1:TextOperationEvent) : void
      {
         this.heightTEXT_changeHandler(param1);
      }
      
      public function __heightTXT0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __heightTXT0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_Label6_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 155;
         _loc1_.y = 37;
         _loc1_.width = 25;
         _loc1_.height = 12;
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__heightLBL1_mouseOver);
         _loc1_.addEventListener("focusIn",this.__heightLBL1_focusIn);
         _loc1_.id = "heightLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.heightLBL1 = _loc1_;
         BindingManager.executeBindings(this,"heightLBL1",this.heightLBL1);
         return _loc1_;
      }
      
      public function __heightLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __heightLBL1_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_TextInput2_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 184;
         _loc1_.y = 28;
         _loc1_.width = 40;
         _loc1_.addEventListener("change",this.__inchesTXT0_change);
         _loc1_.addEventListener("mouseOver",this.__inchesTXT0_mouseOver);
         _loc1_.addEventListener("focusIn",this.__inchesTXT0_focusIn);
         _loc1_.id = "inchesTXT0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.inchesTXT0 = _loc1_;
         BindingManager.executeBindings(this,"inchesTXT0",this.inchesTXT0);
         return _loc1_;
      }
      
      public function __inchesTXT0_change(param1:TextOperationEvent) : void
      {
         this.inchesTEXT_changeHandler(param1);
      }
      
      public function __inchesTXT0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __inchesTXT0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_Label7_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 225;
         _loc1_.y = 38;
         _loc1_.text = "in";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__inchesLBL0_mouseOver);
         _loc1_.addEventListener("focusIn",this.__inchesLBL0_focusIn);
         _loc1_.id = "inchesLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.inchesLBL0 = _loc1_;
         BindingManager.executeBindings(this,"inchesLBL0",this.inchesLBL0);
         return _loc1_;
      }
      
      public function __inchesLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __inchesLBL0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_Label8_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 47;
         _loc1_.y = 68;
         _loc1_.text = "Weight:";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("mouseOver",this.__weightLBL0_mouseOver);
         _loc1_.id = "weightLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.weightLBL0 = _loc1_;
         BindingManager.executeBindings(this,"weightLBL0",this.weightLBL0);
         return _loc1_;
      }
      
      public function __weightLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_TextInput3_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 114;
         _loc1_.y = 66;
         _loc1_.width = 40;
         _loc1_.addEventListener("change",this.__weightTXT0_change);
         _loc1_.addEventListener("focusIn",this.__weightTXT0_focusIn);
         _loc1_.addEventListener("mouseOver",this.__weightTXT0_mouseOver);
         _loc1_.id = "weightTXT0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.weightTXT0 = _loc1_;
         BindingManager.executeBindings(this,"weightTXT0",this.weightTXT0);
         return _loc1_;
      }
      
      public function __weightTXT0_change(param1:TextOperationEvent) : void
      {
         this.weightTEXT_changeHandler(param1);
      }
      
      public function __weightTXT0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      public function __weightTXT0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label9_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 155;
         _loc1_.y = 75;
         _loc1_.width = 25;
         _loc1_.height = 13;
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__weightLBL1_mouseOver);
         _loc1_.id = "weightLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.weightLBL1 = _loc1_;
         BindingManager.executeBindings(this,"weightLBL1",this.weightLBL1);
         return _loc1_;
      }
      
      public function __weightLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label10_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 70;
         _loc1_.y = 109;
         _loc1_.text = "Age:";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("mouseOver",this.__ageLBL0_mouseOver);
         _loc1_.id = "ageLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.ageLBL0 = _loc1_;
         BindingManager.executeBindings(this,"ageLBL0",this.ageLBL0);
         return _loc1_;
      }
      
      public function __ageLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_TextInput4_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 114;
         _loc1_.y = 104;
         _loc1_.width = 40;
         _loc1_.addEventListener("change",this.__ageTXT0_change);
         _loc1_.addEventListener("focusIn",this.__ageTXT0_focusIn);
         _loc1_.addEventListener("mouseOver",this.__ageTXT0_mouseOver);
         _loc1_.id = "ageTXT0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.ageTXT0 = _loc1_;
         BindingManager.executeBindings(this,"ageTXT0",this.ageTXT0);
         return _loc1_;
      }
      
      public function __ageTXT0_change(param1:TextOperationEvent) : void
      {
         this.ageTEXT_changeHandler(param1);
      }
      
      public function __ageTXT0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      public function __ageTXT0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label11_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 157;
         _loc1_.y = 113;
         _loc1_.text = "years";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__ageLBL1_mouseOver);
         _loc1_.id = "ageLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.ageLBL1 = _loc1_;
         BindingManager.executeBindings(this,"ageLBL1",this.ageLBL1);
         return _loc1_;
      }
      
      public function __ageLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label12_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 42;
         _loc1_.y = 146;
         _loc1_.text = "Activity:";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("mouseOver",this.__activityLBL0_mouseOver);
         _loc1_.id = "activityLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.activityLBL0 = _loc1_;
         BindingManager.executeBindings(this,"activityLBL0",this.activityLBL0);
         return _loc1_;
      }
      
      public function __activityLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_ComboBox1_i() : ComboBox
      {
         var _loc1_:ComboBox = new ComboBox();
         _loc1_.x = 114;
         _loc1_.y = 142;
         _loc1_.selectedIndex = 0;
         _loc1_.dataProvider = this._IFCalc_ArrayList1_c();
         _loc1_.addEventListener("change",this.__activityCMB0_change);
         _loc1_.addEventListener("mouseOver",this.__activityCMB0_mouseOver);
         _loc1_.addEventListener("focusIn",this.__activityCMB0_focusIn);
         _loc1_.id = "activityCMB0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.activityCMB0 = _loc1_;
         BindingManager.executeBindings(this,"activityCMB0",this.activityCMB0);
         return _loc1_;
      }
      
      private function _IFCalc_ArrayList1_c() : ArrayList
      {
         var _loc1_:ArrayList = new ArrayList();
         _loc1_.source = ["Sedentary","Lightly Active","Moderately Active","Very Active","Extra Active"];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function __activityCMB0_change(param1:IndexChangeEvent) : void
      {
         this.activityCOMBO_changeHandler(param1);
      }
      
      public function __activityCMB0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __activityCMB0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_Label13_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 45;
         _loc1_.y = 181;
         _loc1_.text = "Gender:";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("mouseOver",this.__genderLBL0_mouseOver);
         _loc1_.id = "genderLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.genderLBL0 = _loc1_;
         BindingManager.executeBindings(this,"genderLBL0",this.genderLBL0);
         return _loc1_;
      }
      
      public function __genderLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_RadioButton1_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 114;
         _loc1_.y = 180;
         _loc1_.label = "Male";
         _loc1_.groupName = "genderGroup";
         _loc1_.selected = true;
         _loc1_.addEventListener("focusIn",this.__genderRAB0_focusIn);
         _loc1_.addEventListener("mouseOver",this.__genderRAB0_mouseOver);
         _loc1_.id = "genderRAB0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.genderRAB0 = _loc1_;
         BindingManager.executeBindings(this,"genderRAB0",this.genderRAB0);
         return _loc1_;
      }
      
      public function __genderRAB0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      public function __genderRAB0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_RadioButton2_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 114;
         _loc1_.y = 201;
         _loc1_.label = "Female";
         _loc1_.groupName = "genderGroup";
         _loc1_.addEventListener("focusIn",this.__genderRAB1_focusIn);
         _loc1_.addEventListener("mouseOver",this.__genderRAB1_mouseOver);
         _loc1_.id = "genderRAB1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.genderRAB1 = _loc1_;
         BindingManager.executeBindings(this,"genderRAB1",this.genderRAB1);
         return _loc1_;
      }
      
      public function __genderRAB1_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      public function __genderRAB1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label14_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 42;
         _loc1_.y = 258;
         _loc1_.text = "Bodyfat:";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("mouseOver",this.__bodyfatLBL0_mouseOver);
         _loc1_.id = "bodyfatLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bodyfatLBL0 = _loc1_;
         BindingManager.executeBindings(this,"bodyfatLBL0",this.bodyfatLBL0);
         return _loc1_;
      }
      
      public function __bodyfatLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label15_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 48;
         _loc1_.y = 274;
         _loc1_.text = "(optional)";
         _loc1_.setStyle("fontSize",12);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.addEventListener("mouseOver",this.__bodyfatLBL1_mouseOver);
         _loc1_.id = "bodyfatLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bodyfatLBL1 = _loc1_;
         BindingManager.executeBindings(this,"bodyfatLBL1",this.bodyfatLBL1);
         return _loc1_;
      }
      
      public function __bodyfatLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_TextInput5_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 114;
         _loc1_.y = 254;
         _loc1_.width = 40;
         _loc1_.addEventListener("change",this.__bodyfatTXT0_change);
         _loc1_.addEventListener("mouseOver",this.__bodyfatTXT0_mouseOver);
         _loc1_.addEventListener("focusIn",this.__bodyfatTXT0_focusIn);
         _loc1_.id = "bodyfatTXT0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bodyfatTXT0 = _loc1_;
         BindingManager.executeBindings(this,"bodyfatTXT0",this.bodyfatTXT0);
         return _loc1_;
      }
      
      public function __bodyfatTXT0_change(param1:TextOperationEvent) : void
      {
         this.bodyfatTEXT_changeHandler(param1);
      }
      
      public function __bodyfatTXT0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __bodyfatTXT0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_Label16_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 156;
         _loc1_.y = 262;
         _loc1_.text = "%";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__bodyfatLBL2_mouseOver);
         _loc1_.id = "bodyfatLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bodyfatLBL2 = _loc1_;
         BindingManager.executeBindings(this,"bodyfatLBL2",this.bodyfatLBL2);
         return _loc1_;
      }
      
      public function __bodyfatLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label17_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 57;
         _loc1_.y = 298;
         _loc1_.text = "Waist:";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("mouseOver",this.__waistLBL0_mouseOver);
         _loc1_.id = "waistLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.waistLBL0 = _loc1_;
         BindingManager.executeBindings(this,"waistLBL0",this.waistLBL0);
         return _loc1_;
      }
      
      public function __waistLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_TextInput6_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 114;
         _loc1_.y = 295;
         _loc1_.width = 40;
         _loc1_.addEventListener("change",this.__waistTXT0_change);
         _loc1_.addEventListener("mouseOver",this.__waistTXT0_mouseOver);
         _loc1_.addEventListener("focusIn",this.__waistTXT0_focusIn);
         _loc1_.id = "waistTXT0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.waistTXT0 = _loc1_;
         BindingManager.executeBindings(this,"waistTXT0",this.waistTXT0);
         return _loc1_;
      }
      
      public function __waistTXT0_change(param1:TextOperationEvent) : void
      {
         this.waistTEXT_changeHandler(param1);
      }
      
      public function __waistTXT0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __waistTXT0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_Label18_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 155;
         _loc1_.y = 304;
         _loc1_.width = 25;
         _loc1_.height = 12;
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__waistLBL2_mouseOver);
         _loc1_.id = "waistLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.waistLBL2 = _loc1_;
         BindingManager.executeBindings(this,"waistLBL2",this.waistLBL2);
         return _loc1_;
      }
      
      public function __waistLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label19_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 54;
         _loc1_.y = 313;
         _loc1_.text = "(optional)";
         _loc1_.setStyle("fontSize",12);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.addEventListener("mouseOver",this.__waistLBL1_mouseOver);
         _loc1_.id = "waistLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.waistLBL1 = _loc1_;
         BindingManager.executeBindings(this,"waistLBL1",this.waistLBL1);
         return _loc1_;
      }
      
      public function __waistLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_HRule1_c() : HRule
      {
         var _loc1_:HRule = new HRule();
         _loc1_.x = 20;
         _loc1_.y = 237;
         _loc1_.width = 260;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_CheckBox2_i() : CheckBox
      {
         var _loc1_:CheckBox = new CheckBox();
         _loc1_.x = 179;
         _loc1_.y = 257;
         _loc1_.label = "Calculate";
         _loc1_.enabled = false;
         _loc1_.addEventListener("click",this.__bfcalcCHK0_click);
         _loc1_.addEventListener("mouseOver",this.__bfcalcCHK0_mouseOver);
         _loc1_.addEventListener("focusOut",this.__bfcalcCHK0_focusOut);
         _loc1_.id = "bfcalcCHK0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bfcalcCHK0 = _loc1_;
         BindingManager.executeBindings(this,"bfcalcCHK0",this.bfcalcCHK0);
         return _loc1_;
      }
      
      public function __bfcalcCHK0_click(param1:MouseEvent) : void
      {
         this.calcBfCB_clickHandler(param1);
      }
      
      public function __bfcalcCHK0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __bfcalcCHK0_focusOut(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_RadioButton3_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 322;
         _loc1_.y = 551;
         _loc1_.label = "Imperial (ft/in/lbs)";
         _loc1_.groupName = "measureGroup";
         _loc1_.selected = true;
         _loc1_.setStyle("fontSize",16);
         _loc1_.id = "measureImperial";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.measureImperial = _loc1_;
         BindingManager.executeBindings(this,"measureImperial",this.measureImperial);
         return _loc1_;
      }
      
      private function _IFCalc_RadioButton4_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 482;
         _loc1_.y = 551;
         _loc1_.label = "Metric (cm/kg)";
         _loc1_.groupName = "measureGroup";
         _loc1_.setStyle("fontSize",16);
         _loc1_.id = "measureMetric";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.measureMetric = _loc1_;
         BindingManager.executeBindings(this,"measureMetric",this.measureMetric);
         return _loc1_;
      }
      
      private function _IFCalc_Label20_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 118;
         _loc1_.y = 6;
         _loc1_.text = "Your Information";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer3_c() : BorderContainer
      {
         var _loc1_:BorderContainer = new BorderContainer();
         _loc1_.x = 387;
         _loc1_.y = 30;
         _loc1_.width = 500;
         _loc1_.height = 160;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array7_c);
         _loc1_.setStyle("cornerRadius",10);
         _loc1_.setStyle("backgroundAlpha",1);
         _loc1_.setStyle("backgroundColor",127);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array7_c() : Array
      {
         var _loc1_:Array = [this._IFCalc_Label21_i(),this._IFCalc_Label22_i(),this._IFCalc_RadioButton5_i(),this._IFCalc_RadioButton6_i(),this._IFCalc_RadioButton7_i(),this._IFCalc_RadioButton8_i(),this._IFCalc_RadioButton9_i(),this._IFCalc_TextInput7_i(),this._IFCalc_RadioButton10_i(),this._IFCalc_TextInput8_i(),this._IFCalc_TextInput9_i(),this._IFCalc_TextInput10_i(),this._IFCalc_Label23_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label21_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 20;
         _loc1_.y = 10;
         _loc1_.text = "Basal Metabolic Rate (BMR):";
         _loc1_.setStyle("color",16777215);
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("mouseOver",this.__bmrLBL0_mouseOver);
         _loc1_.id = "bmrLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmrLBL0 = _loc1_;
         BindingManager.executeBindings(this,"bmrLBL0",this.bmrLBL0);
         return _loc1_;
      }
      
      public function __bmrLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label22_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 396;
         _loc1_.y = 10;
         _loc1_.text = "---";
         _loc1_.width = 60;
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.addEventListener("mouseOver",this.__bmrLBL1_mouseOver);
         _loc1_.id = "bmrLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmrLBL1 = _loc1_;
         BindingManager.executeBindings(this,"bmrLBL1",this.bmrLBL1);
         return _loc1_;
      }
      
      public function __bmrLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_RadioButton5_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 43;
         _loc1_.y = 28;
         _loc1_.label = "Mifflin-St Jeor formula";
         _loc1_.groupName = "bmrGroup";
         _loc1_.selected = true;
         _loc1_.value = "msj";
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__bmrFormulaMSJRAB0_mouseOver);
         _loc1_.addEventListener("focusIn",this.__bmrFormulaMSJRAB0_focusIn);
         _loc1_.id = "bmrFormulaMSJRAB0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmrFormulaMSJRAB0 = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaMSJRAB0",this.bmrFormulaMSJRAB0);
         return _loc1_;
      }
      
      public function __bmrFormulaMSJRAB0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __bmrFormulaMSJRAB0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_RadioButton6_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 43;
         _loc1_.y = 49;
         _loc1_.label = "Harris-Benedict formula";
         _loc1_.groupName = "bmrGroup";
         _loc1_.selected = false;
         _loc1_.value = "hb";
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__bmrFormulaHBRAB1_mouseOver);
         _loc1_.addEventListener("focusIn",this.__bmrFormulaHBRAB1_focusIn);
         _loc1_.id = "bmrFormulaHBRAB1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmrFormulaHBRAB1 = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaHBRAB1",this.bmrFormulaHBRAB1);
         return _loc1_;
      }
      
      public function __bmrFormulaHBRAB1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __bmrFormulaHBRAB1_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_RadioButton7_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 43;
         _loc1_.y = 70;
         _loc1_.label = "Katch-McArdle formula";
         _loc1_.groupName = "bmrGroup";
         _loc1_.enabled = false;
         _loc1_.value = "km";
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__bmrFormulaKMRAB2_mouseOver);
         _loc1_.addEventListener("focusIn",this.__bmrFormulaKMRAB2_focusIn);
         _loc1_.id = "bmrFormulaKMRAB2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmrFormulaKMRAB2 = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaKMRAB2",this.bmrFormulaKMRAB2);
         return _loc1_;
      }
      
      public function __bmrFormulaKMRAB2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __bmrFormulaKMRAB2_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_RadioButton8_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 43;
         _loc1_.y = 91;
         _loc1_.label = "Average";
         _loc1_.groupName = "bmrGroup";
         _loc1_.enabled = false;
         _loc1_.value = "average";
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__bmrFormulaAVRAB3_mouseOver);
         _loc1_.addEventListener("focusIn",this.__bmrFormulaAVRAB3_focusIn);
         _loc1_.id = "bmrFormulaAVRAB3";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmrFormulaAVRAB3 = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaAVRAB3",this.bmrFormulaAVRAB3);
         return _loc1_;
      }
      
      public function __bmrFormulaAVRAB3_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __bmrFormulaAVRAB3_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_RadioButton9_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 43;
         _loc1_.y = 112;
         _loc1_.label = "Simple Multiplier";
         _loc1_.groupName = "bmrGroup";
         _loc1_.enabled = true;
         _loc1_.value = "";
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__bmrFormulaMULRAB4_mouseOver);
         _loc1_.addEventListener("focusIn",this.__bmrFormulaMULRAB4_focusIn);
         _loc1_.id = "bmrFormulaMULRAB4";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmrFormulaMULRAB4 = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaMULRAB4",this.bmrFormulaMULRAB4);
         return _loc1_;
      }
      
      public function __bmrFormulaMULRAB4_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __bmrFormulaMULRAB4_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_TextInput7_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 152;
         _loc1_.y = 110;
         _loc1_.width = 60;
         _loc1_.enabled = true;
         _loc1_.visible = false;
         _loc1_.addEventListener("change",this.__simpleMulBMR_change);
         _loc1_.id = "simpleMulBMR";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.simpleMulBMR = _loc1_;
         BindingManager.executeBindings(this,"simpleMulBMR",this.simpleMulBMR);
         return _loc1_;
      }
      
      public function __simpleMulBMR_change(param1:TextOperationEvent) : void
      {
         this.simpleMulBMR_changeHandler(param1);
      }
      
      private function _IFCalc_RadioButton10_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 43;
         _loc1_.y = 133;
         _loc1_.label = "Custom";
         _loc1_.groupName = "bmrGroup";
         _loc1_.value = "";
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__bmrFormulaCUSRAB5_mouseOver);
         _loc1_.addEventListener("focusIn",this.__bmrFormulaCUSRAB5_focusIn);
         _loc1_.id = "bmrFormulaCUSRAB5";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmrFormulaCUSRAB5 = _loc1_;
         BindingManager.executeBindings(this,"bmrFormulaCUSRAB5",this.bmrFormulaCUSRAB5);
         return _loc1_;
      }
      
      public function __bmrFormulaCUSRAB5_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __bmrFormulaCUSRAB5_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_TextInput8_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 103;
         _loc1_.y = 131;
         _loc1_.width = 60;
         _loc1_.enabled = true;
         _loc1_.visible = false;
         _loc1_.addEventListener("change",this.__customBMR_change);
         _loc1_.id = "customBMR";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.customBMR = _loc1_;
         BindingManager.executeBindings(this,"customBMR",this.customBMR);
         return _loc1_;
      }
      
      public function __customBMR_change(param1:TextOperationEvent) : void
      {
         this.customBMR_changeHandler(param1);
      }
      
      private function _IFCalc_TextInput9_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 160;
         _loc1_.y = 255;
         _loc1_.width = 60;
         _loc1_.enabled = true;
         _loc1_.visible = false;
         _loc1_.addEventListener("change",this.__simpleMulTDEE_change);
         _loc1_.id = "simpleMulTDEE";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.simpleMulTDEE = _loc1_;
         BindingManager.executeBindings(this,"simpleMulTDEE",this.simpleMulTDEE);
         return _loc1_;
      }
      
      public function __simpleMulTDEE_change(param1:TextOperationEvent) : void
      {
         this.simpleMulTDEE_changeHandler(param1);
      }
      
      private function _IFCalc_TextInput10_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.x = 111;
         _loc1_.y = 276;
         _loc1_.width = 60;
         _loc1_.enabled = true;
         _loc1_.visible = false;
         _loc1_.addEventListener("change",this.__customTDEE_change);
         _loc1_.id = "customTDEE";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.customTDEE = _loc1_;
         BindingManager.executeBindings(this,"customTDEE",this.customTDEE);
         return _loc1_;
      }
      
      public function __customTDEE_change(param1:TextOperationEvent) : void
      {
         this.customTDEE_changeHandler(param1);
      }
      
      private function _IFCalc_Label23_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 460;
         _loc1_.y = 15;
         _loc1_.text = "cals";
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__bmrLBL2_mouseOver);
         _loc1_.id = "bmrLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmrLBL2 = _loc1_;
         BindingManager.executeBindings(this,"bmrLBL2",this.bmrLBL2);
         return _loc1_;
      }
      
      public function __bmrLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_BorderContainer4_c() : BorderContainer
      {
         var _loc1_:BorderContainer = new BorderContainer();
         _loc1_.x = 387;
         _loc1_.y = 196;
         _loc1_.width = 500;
         _loc1_.height = 100;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array8_c);
         _loc1_.setStyle("cornerRadius",10);
         _loc1_.setStyle("backgroundAlpha",1);
         _loc1_.setStyle("backgroundColor",127);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array8_c() : Array
      {
         var _loc1_:Array = [this._IFCalc_Label24_i(),this._IFCalc_Label25_i(),this._IFCalc_RadioButton11_i(),this._IFCalc_RadioButton12_i(),this._IFCalc_RadioButton13_i(),this._IFCalc_Label26_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label24_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 20;
         _loc1_.y = 11;
         _loc1_.text = "Total Daily Energy Expenditure (TDEE):";
         _loc1_.setStyle("color",16777215);
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("mouseOver",this.__tdeeLBL0_mouseOver);
         _loc1_.id = "tdeeLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.tdeeLBL0 = _loc1_;
         BindingManager.executeBindings(this,"tdeeLBL0",this.tdeeLBL0);
         return _loc1_;
      }
      
      public function __tdeeLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label25_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 396;
         _loc1_.y = 10;
         _loc1_.text = "---";
         _loc1_.width = 60;
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.addEventListener("mouseOver",this.__tdeeLBL1_mouseOver);
         _loc1_.id = "tdeeLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.tdeeLBL1 = _loc1_;
         BindingManager.executeBindings(this,"tdeeLBL1",this.tdeeLBL1);
         return _loc1_;
      }
      
      public function __tdeeLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_RadioButton11_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 43;
         _loc1_.y = 32;
         _loc1_.label = "Calculated";
         _loc1_.groupName = "tdeeGroup";
         _loc1_.value = "";
         _loc1_.selected = true;
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__tdeeFormulaCALRAB0_mouseOver);
         _loc1_.addEventListener("focusIn",this.__tdeeFormulaCALRAB0_focusIn);
         _loc1_.id = "tdeeFormulaCALRAB0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.tdeeFormulaCALRAB0 = _loc1_;
         BindingManager.executeBindings(this,"tdeeFormulaCALRAB0",this.tdeeFormulaCALRAB0);
         return _loc1_;
      }
      
      public function __tdeeFormulaCALRAB0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __tdeeFormulaCALRAB0_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_RadioButton12_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 43;
         _loc1_.y = 53;
         _loc1_.label = "Simple Multiplier";
         _loc1_.groupName = "tdeeGroup";
         _loc1_.value = "mul";
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__tdeeFormulaMULRAB1_mouseOver);
         _loc1_.addEventListener("focusIn",this.__tdeeFormulaMULRAB1_focusIn);
         _loc1_.id = "tdeeFormulaMULRAB1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.tdeeFormulaMULRAB1 = _loc1_;
         BindingManager.executeBindings(this,"tdeeFormulaMULRAB1",this.tdeeFormulaMULRAB1);
         return _loc1_;
      }
      
      public function __tdeeFormulaMULRAB1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __tdeeFormulaMULRAB1_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_RadioButton13_i() : RadioButton
      {
         var _loc1_:RadioButton = new RadioButton();
         _loc1_.x = 43;
         _loc1_.y = 74;
         _loc1_.label = "Custom";
         _loc1_.groupName = "tdeeGroup";
         _loc1_.value = "custom";
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__tdeeFormulaCUSRAB2_mouseOver);
         _loc1_.addEventListener("focusIn",this.__tdeeFormulaCUSRAB2_focusIn);
         _loc1_.id = "tdeeFormulaCUSRAB2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.tdeeFormulaCUSRAB2 = _loc1_;
         BindingManager.executeBindings(this,"tdeeFormulaCUSRAB2",this.tdeeFormulaCUSRAB2);
         return _loc1_;
      }
      
      public function __tdeeFormulaCUSRAB2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      public function __tdeeFormulaCUSRAB2_focusIn(param1:FocusEvent) : void
      {
         this.superToolTipF(param1);
      }
      
      private function _IFCalc_Label26_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 460;
         _loc1_.y = 15;
         _loc1_.text = "cals";
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__tdeeLBL2_mouseOver);
         _loc1_.id = "tdeeLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.tdeeLBL2 = _loc1_;
         BindingManager.executeBindings(this,"tdeeLBL2",this.tdeeLBL2);
         return _loc1_;
      }
      
      public function __tdeeLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_BorderContainer5_c() : BorderContainer
      {
         var _loc1_:BorderContainer = new BorderContainer();
         _loc1_.x = 387;
         _loc1_.y = 303;
         _loc1_.width = 500;
         _loc1_.height = 60;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array9_c);
         _loc1_.setStyle("cornerRadius",10);
         _loc1_.setStyle("backgroundColor",30847);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array9_c() : Array
      {
         var _loc1_:Array = [this._IFCalc_Label27_i(),this._IFCalc_Label28_i(),this._IFCalc_Label29_i(),this._IFCalc_Label30_i(),this._IFCalc_Label31_i(),this._IFCalc_Label32_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label27_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 20;
         _loc1_.y = 7;
         _loc1_.text = "Lean Body Mass (LBM):";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__lbmLBL0_mouseOver);
         _loc1_.id = "lbmLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.lbmLBL0 = _loc1_;
         BindingManager.executeBindings(this,"lbmLBL0",this.lbmLBL0);
         return _loc1_;
      }
      
      public function __lbmLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label28_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 20;
         _loc1_.y = 33;
         _loc1_.text = "Fat Body Mass:";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__fbmLBL0_mouseOver);
         _loc1_.id = "fbmLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.fbmLBL0 = _loc1_;
         BindingManager.executeBindings(this,"fbmLBL0",this.fbmLBL0);
         return _loc1_;
      }
      
      public function __fbmLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label29_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 386;
         _loc1_.y = 8;
         _loc1_.text = "---";
         _loc1_.width = 70;
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.addEventListener("mouseOver",this.__lbmLBL1_mouseOver);
         _loc1_.id = "lbmLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.lbmLBL1 = _loc1_;
         BindingManager.executeBindings(this,"lbmLBL1",this.lbmLBL1);
         return _loc1_;
      }
      
      public function __lbmLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label30_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 386;
         _loc1_.y = 34;
         _loc1_.text = "---";
         _loc1_.width = 70;
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.addEventListener("mouseOver",this.__fbmLBL1_mouseOver);
         _loc1_.id = "fbmLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.fbmLBL1 = _loc1_;
         BindingManager.executeBindings(this,"fbmLBL1",this.fbmLBL1);
         return _loc1_;
      }
      
      public function __fbmLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label31_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 460;
         _loc1_.y = 11.75;
         _loc1_.width = 25;
         _loc1_.height = 13;
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__lbmLBL2_mouseOver);
         _loc1_.id = "lbmLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.lbmLBL2 = _loc1_;
         BindingManager.executeBindings(this,"lbmLBL2",this.lbmLBL2);
         return _loc1_;
      }
      
      public function __lbmLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label32_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 460;
         _loc1_.y = 37.8;
         _loc1_.width = 25;
         _loc1_.height = 13;
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__fbmLBL2_mouseOver);
         _loc1_.id = "fbmLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.fbmLBL2 = _loc1_;
         BindingManager.executeBindings(this,"fbmLBL2",this.fbmLBL2);
         return _loc1_;
      }
      
      public function __fbmLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_BorderContainer6_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 387;
         _loc1_.y = 371;
         _loc1_.width = 500;
         _loc1_.height = 75;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array10_c);
         _loc1_.setStyle("cornerRadius",10);
         _loc1_.setStyle("backgroundColor",32512);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array10_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label33_i(),this._IFCalc_Label34_i(),this._IFCalc_Label35_i(),this._IFCalc_Label36_i(),this._IFCalc_Label37_i(),this._IFCalc_Label38_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label33_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 20;
         _loc1_.y = 7;
         _loc1_.text = "Body Mass Index (BMI):";
         _loc1_.setStyle("color",16777215);
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("mouseOver",this.__bmiLBL0_mouseOver);
         _loc1_.id = "bmiLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmiLBL0 = _loc1_;
         BindingManager.executeBindings(this,"bmiLBL0",this.bmiLBL0);
         return _loc1_;
      }
      
      public function __bmiLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label34_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 396;
         _loc1_.y = 7;
         _loc1_.text = "---";
         _loc1_.width = 60;
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.addEventListener("mouseOver",this.__bmiLBL1_mouseOver);
         _loc1_.id = "bmiLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmiLBL1 = _loc1_;
         BindingManager.executeBindings(this,"bmiLBL1",this.bmiLBL1);
         return _loc1_;
      }
      
      public function __bmiLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label35_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 56;
         _loc1_.y = 30;
         _loc1_.text = "\"Perfect\" (BMI 22) Control Twin:";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__bmiTwinLBL0_mouseOver);
         _loc1_.id = "bmiTwinLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmiTwinLBL0 = _loc1_;
         BindingManager.executeBindings(this,"bmiTwinLBL0",this.bmiTwinLBL0);
         return _loc1_;
      }
      
      public function __bmiTwinLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label36_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 276;
         _loc1_.y = 30;
         _loc1_.text = "---";
         _loc1_.width = 40;
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("mouseOver",this.__bmiTwinLBL1_mouseOver);
         _loc1_.id = "bmiTwinLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmiTwinLBL1 = _loc1_;
         BindingManager.executeBindings(this,"bmiTwinLBL1",this.bmiTwinLBL1);
         return _loc1_;
      }
      
      public function __bmiTwinLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label37_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 318;
         _loc1_.y = 31;
         _loc1_.width = 25;
         _loc1_.height = 13;
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",16777215);
         _loc1_.addEventListener("mouseOver",this.__bmiTwinLBL2_mouseOver);
         _loc1_.id = "bmiTwinLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmiTwinLBL2 = _loc1_;
         BindingManager.executeBindings(this,"bmiTwinLBL2",this.bmiTwinLBL2);
         return _loc1_;
      }
      
      public function __bmiTwinLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label38_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 143;
         _loc1_.y = 51;
         _loc1_.width = 213;
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","center");
         _loc1_.addEventListener("mouseOver",this.__bmiLBL2_mouseOver);
         _loc1_.id = "bmiLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bmiLBL2 = _loc1_;
         BindingManager.executeBindings(this,"bmiLBL2",this.bmiLBL2);
         return _loc1_;
      }
      
      public function __bmiLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label39_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 542.5;
         _loc1_.y = 6;
         _loc1_.text = "Calculated For You";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_TextArea2_i() : mx.controls.TextArea
      {
         var _loc1_:mx.controls.TextArea = null;
         _loc1_ = new mx.controls.TextArea();
         _loc1_.x = 51;
         _loc1_.y = 416;
         _loc1_.height = 128;
         _loc1_.width = 300;
         _loc1_.editable = false;
         _loc1_.id = "superToolTipTA";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.superToolTipTA = _loc1_;
         BindingManager.executeBindings(this,"superToolTipTA",this.superToolTipTA);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer7_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 387;
         _loc1_.y = 454;
         _loc1_.width = 500;
         _loc1_.height = 90;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array11_c);
         _loc1_.setStyle("cornerRadius",10);
         _loc1_.setStyle("backgroundColor",5701759);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array11_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label40_i(),this._IFCalc_Label41_i(),this._IFCalc_Label42_i(),this._IFCalc_Label43_i(),this._IFCalc_Label44_i(),this._IFCalc_Label45_i(),this._IFCalc_Label46_i(),this._IFCalc_Label47_i(),this._IFCalc_Label48_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label40_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 20;
         _loc1_.y = 7;
         _loc1_.text = "Waist-to-Height Ratio:";
         _loc1_.setStyle("color",16777215);
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.addEventListener("mouseOver",this.__wthRatioLBL0_mouseOver);
         _loc1_.id = "wthRatioLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.wthRatioLBL0 = _loc1_;
         BindingManager.executeBindings(this,"wthRatioLBL0",this.wthRatioLBL0);
         return _loc1_;
      }
      
      public function __wthRatioLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label41_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 396;
         _loc1_.y = 7;
         _loc1_.text = "---";
         _loc1_.width = 60;
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.addEventListener("mouseOver",this.__wthRatioLBL1_mouseOver);
         _loc1_.id = "wthRatioLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.wthRatioLBL1 = _loc1_;
         BindingManager.executeBindings(this,"wthRatioLBL1",this.wthRatioLBL1);
         return _loc1_;
      }
      
      public function __wthRatioLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label42_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 460;
         _loc1_.y = 12;
         _loc1_.text = "%";
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__wthRatioLBL2_mouseOver);
         _loc1_.id = "wthRatioLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.wthRatioLBL2 = _loc1_;
         BindingManager.executeBindings(this,"wthRatioLBL2",this.wthRatioLBL2);
         return _loc1_;
      }
      
      public function __wthRatioLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label43_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 20;
         _loc1_.y = 35;
         _loc1_.text = "Maximum Fat Metabolism:";
         _loc1_.setStyle("color",16777215);
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.addEventListener("mouseOver",this.__mfmLBL0_mouseOver);
         _loc1_.id = "mfmLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.mfmLBL0 = _loc1_;
         BindingManager.executeBindings(this,"mfmLBL0",this.mfmLBL0);
         return _loc1_;
      }
      
      public function __mfmLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label44_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 396;
         _loc1_.y = 35;
         _loc1_.text = "---";
         _loc1_.width = 60;
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.addEventListener("mouseOver",this.__mfmLBL1_mouseOver);
         _loc1_.id = "mfmLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.mfmLBL1 = _loc1_;
         BindingManager.executeBindings(this,"mfmLBL1",this.mfmLBL1);
         return _loc1_;
      }
      
      public function __mfmLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label45_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 460;
         _loc1_.y = 40;
         _loc1_.text = "cals";
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__mfmLBL2_mouseOver);
         _loc1_.id = "mfmLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.mfmLBL2 = _loc1_;
         BindingManager.executeBindings(this,"mfmLBL2",this.mfmLBL2);
         return _loc1_;
      }
      
      public function __mfmLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label46_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 20;
         _loc1_.y = 63;
         _loc1_.text = "Minimum Recommended Daily Calories:";
         _loc1_.setStyle("color",16777215);
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.addEventListener("mouseOver",this.__minCalsLBL0_mouseOver);
         _loc1_.id = "minCalsLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.minCalsLBL0 = _loc1_;
         BindingManager.executeBindings(this,"minCalsLBL0",this.minCalsLBL0);
         return _loc1_;
      }
      
      public function __minCalsLBL0_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label47_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 396;
         _loc1_.y = 63;
         _loc1_.text = "---";
         _loc1_.width = 60;
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.addEventListener("mouseOver",this.__minCalsLBL1_mouseOver);
         _loc1_.id = "minCalsLBL1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.minCalsLBL1 = _loc1_;
         BindingManager.executeBindings(this,"minCalsLBL1",this.minCalsLBL1);
         return _loc1_;
      }
      
      public function __minCalsLBL1_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label48_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 460;
         _loc1_.y = 66.79999;
         _loc1_.text = "cals";
         _loc1_.styleName = "calclbl";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.addEventListener("mouseOver",this.__minCalsLBL2_mouseOver);
         _loc1_.id = "minCalsLBL2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.minCalsLBL2 = _loc1_;
         BindingManager.executeBindings(this,"minCalsLBL2",this.minCalsLBL2);
         return _loc1_;
      }
      
      public function __minCalsLBL2_mouseOver(param1:MouseEvent) : void
      {
         this.superToolTipM(param1);
      }
      
      private function _IFCalc_Label49_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 147.5;
         _loc1_.y = 391;
         _loc1_.text = "Definitions";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array12_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label50_c(),this._IFCalc_Label51_c(),this._IFCalc_BorderContainer8_c(),this._IFCalc_BorderContainer9_c(),this._IFCalc_BorderContainer10_c(),this._IFCalc_BorderContainer11_c(),this._IFCalc_BorderContainer12_c(),this._IFCalc_Label87_c(),this._IFCalc_Label88_c(),this._IFCalc_Label89_c(),this._IFCalc_BorderContainer13_c(),this._IFCalc_Label103_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label50_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 361;
         _loc1_.y = 5;
         _loc1_.text = "Rest Day";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label51_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 696.5;
         _loc1_.y = 6;
         _loc1_.text = "Workout Day";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer8_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 235;
         _loc1_.y = 26;
         _loc1_.width = 342;
         _loc1_.height = 460;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array13_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array13_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_PieChart1_i(),this._IFCalc_Label52_c(),this._IFCalc_HSlider1_i(),this._IFCalc_Label53_c(),this._IFCalc_HSlider2_i(),this._IFCalc_Label54_c(),this._IFCalc_HSlider3_i(),this._IFCalc_NumericStepper1_i(),this._IFCalc_Label55_i(),this._IFCalc_Label56_i(),this._IFCalc_HRule2_c(),this._IFCalc_Label57_c(),this._IFCalc_Label58_c(),this._IFCalc_Label59_c(),this._IFCalc_Label60_c(),this._IFCalc_Label61_i(),this._IFCalc_Label62_i(),this._IFCalc_Label63_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_PieChart1_i() : PieChart
      {
         var _loc1_:PieChart = null;
         _loc1_ = new PieChart();
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.width = 340;
         _loc1_.height = 340;
         _loc1_.showDataTips = false;
         _loc1_.series = [this._IFCalc_PieSeries1_c()];
         _loc1_.setStyle("fontSize",14);
         _loc1_.id = "restDayChart";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restDayChart = _loc1_;
         BindingManager.executeBindings(this,"restDayChart",this.restDayChart);
         return _loc1_;
      }
      
      private function _IFCalc_PieSeries1_c() : PieSeries
      {
         var _loc1_:PieSeries = null;
         _loc1_ = new PieSeries();
         _loc1_.displayName = "Rest Day";
         _loc1_.field = "pct";
         _loc1_.labelFunction = this.restChartLabels;
         _loc1_.nameField = "name";
         _loc1_.setStyle("labelPosition","inside");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label52_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 23;
         _loc1_.y = 391;
         _loc1_.text = "Protein";
         _loc1_.setStyle("fontSize",16);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_HSlider1_i() : HSlider
      {
         var _loc1_:HSlider = null;
         _loc1_ = new HSlider();
         _loc1_.x = 90;
         _loc1_.y = 393;
         _loc1_.minimum = 0;
         _loc1_.maximum = 100;
         _loc1_.stepSize = 1;
         _loc1_.width = 210;
         _loc1_.addEventListener("change",this.__restProteinSlider_change);
         _loc1_.addEventListener("changeEnd",this.__restProteinSlider_changeEnd);
         _loc1_.id = "restProteinSlider";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restProteinSlider = _loc1_;
         BindingManager.executeBindings(this,"restProteinSlider",this.restProteinSlider);
         return _loc1_;
      }
      
      public function __restProteinSlider_change(param1:Event) : void
      {
         this.restProteinSlider_changeHandler(param1);
      }
      
      public function __restProteinSlider_changeEnd(param1:FlexEvent) : void
      {
         this.proteinSliders_changeEndHandler(param1);
      }
      
      private function _IFCalc_Label53_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 32;
         _loc1_.y = 415;
         _loc1_.text = "Carbs";
         _loc1_.setStyle("fontSize",16);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_HSlider2_i() : HSlider
      {
         var _loc1_:HSlider = null;
         _loc1_ = new HSlider();
         _loc1_.x = 90;
         _loc1_.y = 417;
         _loc1_.minimum = 0;
         _loc1_.maximum = 100;
         _loc1_.stepSize = 1;
         _loc1_.width = 210;
         _loc1_.addEventListener("change",this.__restCarbsSlider_change);
         _loc1_.addEventListener("creationComplete",this.__restCarbsSlider_creationComplete);
         _loc1_.addEventListener("changeEnd",this.__restCarbsSlider_changeEnd);
         _loc1_.id = "restCarbsSlider";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restCarbsSlider = _loc1_;
         BindingManager.executeBindings(this,"restCarbsSlider",this.restCarbsSlider);
         return _loc1_;
      }
      
      public function __restCarbsSlider_change(param1:Event) : void
      {
         this.restCarbsSlider_changeHandler(param1);
      }
      
      public function __restCarbsSlider_creationComplete(param1:FlexEvent) : void
      {
         this.restCarbsSlider.maximum = 100 - this.restCollection.getItemAt(0).pct;
      }
      
      public function __restCarbsSlider_changeEnd(param1:FlexEvent) : void
      {
         this.macroSplitCombo.selectedItem = "Custom";
      }
      
      private function _IFCalc_Label54_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 49;
         _loc1_.y = 439;
         _loc1_.text = "Fat";
         _loc1_.setStyle("fontSize",16);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_HSlider3_i() : HSlider
      {
         var _loc1_:HSlider = null;
         _loc1_ = new HSlider();
         _loc1_.x = 90;
         _loc1_.y = 441;
         _loc1_.minimum = 0;
         _loc1_.maximum = 100;
         _loc1_.stepSize = 1;
         _loc1_.width = 210;
         _loc1_.addEventListener("change",this.__restFatSlider_change);
         _loc1_.addEventListener("creationComplete",this.__restFatSlider_creationComplete);
         _loc1_.addEventListener("changeEnd",this.__restFatSlider_changeEnd);
         _loc1_.id = "restFatSlider";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restFatSlider = _loc1_;
         BindingManager.executeBindings(this,"restFatSlider",this.restFatSlider);
         return _loc1_;
      }
      
      public function __restFatSlider_change(param1:Event) : void
      {
         this.restFatSlider_changeHandler(param1);
      }
      
      public function __restFatSlider_creationComplete(param1:FlexEvent) : void
      {
         this.restFatSlider.maximum = 100 - this.restCollection.getItemAt(0).pct;
      }
      
      public function __restFatSlider_changeEnd(param1:FlexEvent) : void
      {
         this.macroSplitCombo.selectedItem = "Custom";
      }
      
      private function _IFCalc_NumericStepper1_i() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 19;
         _loc1_.y = 340;
         _loc1_.minimum = -100;
         _loc1_.maximum = 300;
         _loc1_.stepSize = 1;
         _loc1_.value = -20;
         _loc1_.addEventListener("change",this.__restDayTdeePct_change);
         _loc1_.id = "restDayTdeePct";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restDayTdeePct = _loc1_;
         BindingManager.executeBindings(this,"restDayTdeePct",this.restDayTdeePct);
         return _loc1_;
      }
      
      public function __restDayTdeePct_change(param1:Event) : void
      {
         this.restDayTdeePct_changeHandler(param1);
      }
      
      private function _IFCalc_Label55_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 89;
         _loc1_.y = 352;
         _loc1_.width = 80;
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "restPctTdeeLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restPctTdeeLBL = _loc1_;
         BindingManager.executeBindings(this,"restPctTdeeLBL",this.restPctTdeeLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label56_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 163;
         _loc1_.y = 340;
         _loc1_.text = "1000 Calories";
         _loc1_.width = 160;
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "restCalsLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restCalsLBL = _loc1_;
         BindingManager.executeBindings(this,"restCalsLBL",this.restCalsLBL);
         return _loc1_;
      }
      
      private function _IFCalc_HRule2_c() : HRule
      {
         var _loc1_:HRule = null;
         _loc1_ = new HRule();
         _loc1_.x = 15;
         _loc1_.y = 381;
         _loc1_.width = 312;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label57_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 302;
         _loc1_.y = 393;
         _loc1_.text = "100";
         _loc1_.width = 20;
         _loc1_.setStyle("textAlign","right");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label58_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 80;
         _loc1_.y = 393;
         _loc1_.text = "0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label59_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 80;
         _loc1_.y = 417;
         _loc1_.text = "0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label60_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 80;
         _loc1_.y = 441;
         _loc1_.text = "0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label61_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 302;
         _loc1_.y = 417;
         _loc1_.text = "25";
         _loc1_.width = 20;
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "restCarbSliderMax";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restCarbSliderMax = _loc1_;
         BindingManager.executeBindings(this,"restCarbSliderMax",this.restCarbSliderMax);
         return _loc1_;
      }
      
      private function _IFCalc_Label62_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 302;
         _loc1_.y = 441;
         _loc1_.text = "25";
         _loc1_.width = 20;
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "restFatSliderMax";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restFatSliderMax = _loc1_;
         BindingManager.executeBindings(this,"restFatSliderMax",this.restFatSliderMax);
         return _loc1_;
      }
      
      private function _IFCalc_Label63_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 163;
         _loc1_.y = 363;
         _loc1_.text = "(1000 cals)";
         _loc1_.width = 160;
         _loc1_.setStyle("textAlign","center");
         _loc1_.id = "restCalsDifLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restCalsDifLBL = _loc1_;
         BindingManager.executeBindings(this,"restCalsDifLBL",this.restCalsDifLBL);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer9_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 589;
         _loc1_.y = 26;
         _loc1_.width = 342;
         _loc1_.height = 460;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array15_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array15_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_PieChart2_i(),this._IFCalc_Label64_c(),this._IFCalc_HSlider4_i(),this._IFCalc_Label65_c(),this._IFCalc_HSlider5_i(),this._IFCalc_Label66_c(),this._IFCalc_HSlider6_i(),this._IFCalc_NumericStepper2_i(),this._IFCalc_Label67_i(),this._IFCalc_Label68_i(),this._IFCalc_HRule3_c(),this._IFCalc_Label69_c(),this._IFCalc_Label70_c(),this._IFCalc_Label71_c(),this._IFCalc_Label72_c(),this._IFCalc_Label73_i(),this._IFCalc_Label74_i(),this._IFCalc_Label75_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_PieChart2_i() : PieChart
      {
         var _loc1_:PieChart = null;
         _loc1_ = new PieChart();
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.width = 340;
         _loc1_.height = 340;
         _loc1_.showDataTips = false;
         _loc1_.series = [this._IFCalc_PieSeries2_c()];
         _loc1_.setStyle("fontSize",14);
         _loc1_.id = "workoutDayChart";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutDayChart = _loc1_;
         BindingManager.executeBindings(this,"workoutDayChart",this.workoutDayChart);
         return _loc1_;
      }
      
      private function _IFCalc_PieSeries2_c() : PieSeries
      {
         var _loc1_:PieSeries = null;
         _loc1_ = new PieSeries();
         _loc1_.displayName = "Workout Day";
         _loc1_.field = "pct";
         _loc1_.labelFunction = this.workoutChartLabels;
         _loc1_.nameField = "name";
         _loc1_.setStyle("labelPosition","inside");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label64_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 23;
         _loc1_.y = 391;
         _loc1_.text = "Protein";
         _loc1_.setStyle("fontSize",16);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_HSlider4_i() : HSlider
      {
         var _loc1_:HSlider = null;
         _loc1_ = new HSlider();
         _loc1_.x = 90;
         _loc1_.y = 393;
         _loc1_.minimum = 0;
         _loc1_.maximum = 100;
         _loc1_.stepSize = 1;
         _loc1_.width = 210;
         _loc1_.addEventListener("change",this.__workoutProteinSlider_change);
         _loc1_.addEventListener("changeEnd",this.__workoutProteinSlider_changeEnd);
         _loc1_.id = "workoutProteinSlider";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutProteinSlider = _loc1_;
         BindingManager.executeBindings(this,"workoutProteinSlider",this.workoutProteinSlider);
         return _loc1_;
      }
      
      public function __workoutProteinSlider_change(param1:Event) : void
      {
         this.workoutProteinSlider_changeHandler(param1);
      }
      
      public function __workoutProteinSlider_changeEnd(param1:FlexEvent) : void
      {
         this.proteinSliders_changeEndHandler(param1);
      }
      
      private function _IFCalc_Label65_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 31;
         _loc1_.y = 415;
         _loc1_.text = "Carbs";
         _loc1_.setStyle("fontSize",16);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_HSlider5_i() : HSlider
      {
         var _loc1_:HSlider = null;
         _loc1_ = new HSlider();
         _loc1_.x = 90;
         _loc1_.y = 417;
         _loc1_.minimum = 0;
         _loc1_.maximum = 100;
         _loc1_.stepSize = 1;
         _loc1_.width = 210;
         _loc1_.addEventListener("change",this.__workoutCarbsSlider_change);
         _loc1_.addEventListener("creationComplete",this.__workoutCarbsSlider_creationComplete);
         _loc1_.addEventListener("changeEnd",this.__workoutCarbsSlider_changeEnd);
         _loc1_.id = "workoutCarbsSlider";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutCarbsSlider = _loc1_;
         BindingManager.executeBindings(this,"workoutCarbsSlider",this.workoutCarbsSlider);
         return _loc1_;
      }
      
      public function __workoutCarbsSlider_change(param1:Event) : void
      {
         this.workoutCarbsSlider_changeHandler(param1);
      }
      
      public function __workoutCarbsSlider_creationComplete(param1:FlexEvent) : void
      {
         this.workoutCarbsSlider.maximum = 100 - this.workoutCollection.getItemAt(0).pct;
      }
      
      public function __workoutCarbsSlider_changeEnd(param1:FlexEvent) : void
      {
         this.macroSplitCombo.selectedItem = "Custom";
      }
      
      private function _IFCalc_Label66_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 48;
         _loc1_.y = 439;
         _loc1_.text = "Fat";
         _loc1_.setStyle("fontSize",16);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_HSlider6_i() : HSlider
      {
         var _loc1_:HSlider = null;
         _loc1_ = new HSlider();
         _loc1_.x = 90;
         _loc1_.y = 441;
         _loc1_.minimum = 0;
         _loc1_.maximum = 100;
         _loc1_.stepSize = 1;
         _loc1_.width = 210;
         _loc1_.addEventListener("change",this.__workoutFatSlider_change);
         _loc1_.addEventListener("creationComplete",this.__workoutFatSlider_creationComplete);
         _loc1_.addEventListener("changeEnd",this.__workoutFatSlider_changeEnd);
         _loc1_.id = "workoutFatSlider";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutFatSlider = _loc1_;
         BindingManager.executeBindings(this,"workoutFatSlider",this.workoutFatSlider);
         return _loc1_;
      }
      
      public function __workoutFatSlider_change(param1:Event) : void
      {
         this.workoutFatSlider_changeHandler(param1);
      }
      
      public function __workoutFatSlider_creationComplete(param1:FlexEvent) : void
      {
         this.workoutFatSlider.maximum = 100 - this.workoutCollection.getItemAt(0).pct;
      }
      
      public function __workoutFatSlider_changeEnd(param1:FlexEvent) : void
      {
         this.macroSplitCombo.selectedItem = "Custom";
      }
      
      private function _IFCalc_NumericStepper2_i() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 19;
         _loc1_.y = 340;
         _loc1_.minimum = -100;
         _loc1_.maximum = 300;
         _loc1_.stepSize = 1;
         _loc1_.value = 20;
         _loc1_.addEventListener("change",this.__workoutDayTdeePct_change);
         _loc1_.id = "workoutDayTdeePct";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutDayTdeePct = _loc1_;
         BindingManager.executeBindings(this,"workoutDayTdeePct",this.workoutDayTdeePct);
         return _loc1_;
      }
      
      public function __workoutDayTdeePct_change(param1:Event) : void
      {
         this.workoutDayTdeePct_changeHandler(param1);
      }
      
      private function _IFCalc_Label67_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 89;
         _loc1_.y = 352;
         _loc1_.width = 80;
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "workoutPctTdeeLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutPctTdeeLBL = _loc1_;
         BindingManager.executeBindings(this,"workoutPctTdeeLBL",this.workoutPctTdeeLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label68_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 163;
         _loc1_.y = 340;
         _loc1_.text = "1000 Calories";
         _loc1_.width = 160;
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "workoutCalsLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutCalsLBL = _loc1_;
         BindingManager.executeBindings(this,"workoutCalsLBL",this.workoutCalsLBL);
         return _loc1_;
      }
      
      private function _IFCalc_HRule3_c() : HRule
      {
         var _loc1_:HRule = null;
         _loc1_ = new HRule();
         _loc1_.x = 15;
         _loc1_.y = 381;
         _loc1_.width = 312;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label69_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 80;
         _loc1_.y = 393;
         _loc1_.text = "0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label70_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 80;
         _loc1_.y = 417;
         _loc1_.text = "0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label71_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 80;
         _loc1_.y = 441;
         _loc1_.text = "0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label72_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 302;
         _loc1_.y = 393;
         _loc1_.text = "100";
         _loc1_.width = 20;
         _loc1_.setStyle("textAlign","right");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label73_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 302;
         _loc1_.y = 417;
         _loc1_.text = "25";
         _loc1_.width = 20;
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "workoutCarbSliderMax";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutCarbSliderMax = _loc1_;
         BindingManager.executeBindings(this,"workoutCarbSliderMax",this.workoutCarbSliderMax);
         return _loc1_;
      }
      
      private function _IFCalc_Label74_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 302;
         _loc1_.y = 441;
         _loc1_.text = "25";
         _loc1_.width = 20;
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "workoutFatSliderMax";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutFatSliderMax = _loc1_;
         BindingManager.executeBindings(this,"workoutFatSliderMax",this.workoutFatSliderMax);
         return _loc1_;
      }
      
      private function _IFCalc_Label75_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 163;
         _loc1_.y = 363;
         _loc1_.text = "(1000 cals)";
         _loc1_.width = 160;
         _loc1_.setStyle("textAlign","center");
         _loc1_.id = "workoutCalsDifLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutCalsDifLBL = _loc1_;
         BindingManager.executeBindings(this,"workoutCalsDifLBL",this.workoutCalsDifLBL);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer10_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 8;
         _loc1_.y = 26;
         _loc1_.width = 210;
         _loc1_.height = 61;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array17_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array17_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label76_c(),this._IFCalc_ComboBox2_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label76_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 35.5;
         _loc1_.y = 6;
         _loc1_.text = "Rest / Workout Split";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_ComboBox2_i() : ComboBox
      {
         var _loc1_:ComboBox = null;
         _loc1_ = new ComboBox();
         _loc1_.x = 12;
         _loc1_.y = 26;
         _loc1_.width = 180;
         _loc1_.selectedIndex = 0;
         _loc1_.dataProvider = this._IFCalc_ArrayList2_c();
         _loc1_.setStyle("textAlign","center");
         _loc1_.addEventListener("change",this.__daySplitCombo_change);
         _loc1_.id = "daySplitCombo";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.daySplitCombo = _loc1_;
         BindingManager.executeBindings(this,"daySplitCombo",this.daySplitCombo);
         return _loc1_;
      }
      
      private function _IFCalc_ArrayList2_c() : ArrayList
      {
         var _loc1_:ArrayList = null;
         _loc1_ = new ArrayList();
         _loc1_.source = ["Standard Recomp (-20/+20)","Weight Loss (-20/0)","Weight Loss #2 (-40/+20)","Faster Weight Loss (-30/-10)","Lean Massing (-10/+20)","Weight Gain (+10/+20)","Weight Gain #2 (-10/+30)","Maintain (0/0)","Custom"];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function __daySplitCombo_change(param1:IndexChangeEvent) : void
      {
         this.daySplitCombo_changeHandler(param1);
      }
      
      private function _IFCalc_BorderContainer11_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 11;
         _loc1_.y = 117;
         _loc1_.width = 210;
         _loc1_.height = 162;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array19_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array19_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label77_c(),this._IFCalc_ComboBox3_i(),this._IFCalc_Label78_c(),this._IFCalc_TextInput11_i(),this._IFCalc_Label79_c(),this._IFCalc_Label80_c(),this._IFCalc_TextInput12_i(),this._IFCalc_Label81_c(),this._IFCalc_Label82_c(),this._IFCalc_ComboBox4_i(),this._IFCalc_Label83_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label77_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 76.5;
         _loc1_.y = 6;
         _loc1_.text = "Protein";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_ComboBox3_i() : ComboBox
      {
         var _loc1_:ComboBox = null;
         _loc1_ = new ComboBox();
         _loc1_.x = 12;
         _loc1_.y = 23;
         _loc1_.width = 180;
         _loc1_.selectedIndex = 0;
         _loc1_.dataProvider = this._IFCalc_ArrayList3_c();
         _loc1_.setStyle("textAlign","center");
         _loc1_.addEventListener("change",this.__proteinCombo_change);
         _loc1_.id = "proteinCombo";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.proteinCombo = _loc1_;
         BindingManager.executeBindings(this,"proteinCombo",this.proteinCombo);
         return _loc1_;
      }
      
      private function _IFCalc_ArrayList3_c() : ArrayList
      {
         var _loc1_:ArrayList = null;
         _loc1_ = new ArrayList();
         _loc1_.source = ["1g / lb. Bodyweight","1.5g / lb. LBM","3g / kg. Bodyweight","Custom"];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function __proteinCombo_change(param1:IndexChangeEvent) : void
      {
         this.proteinCombo_changeHandler(param1);
      }
      
      private function _IFCalc_Label78_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 36.5;
         _loc1_.y = 49;
         _loc1_.text = "Rest";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",4473924);
         _loc1_.setStyle("fontStyle","italic");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_TextInput11_i() : TextInput
      {
         var _loc1_:TextInput = null;
         _loc1_ = new TextInput();
         _loc1_.x = 19;
         _loc1_.y = 64;
         _loc1_.enabled = false;
         _loc1_.width = 60;
         _loc1_.addEventListener("focusOut",this.__customProteinRest_focusOut);
         _loc1_.addEventListener("enter",this.__customProteinRest_enter);
         _loc1_.id = "customProteinRest";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.customProteinRest = _loc1_;
         BindingManager.executeBindings(this,"customProteinRest",this.customProteinRest);
         return _loc1_;
      }
      
      public function __customProteinRest_focusOut(param1:FocusEvent) : void
      {
         this.updateCustomProteinRest();
      }
      
      public function __customProteinRest_enter(param1:FlexEvent) : void
      {
         this.updateCustomProteinRest();
      }
      
      private function _IFCalc_Label79_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 82;
         _loc1_.y = 71.95;
         _loc1_.text = "g";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",4473924);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label80_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 123.5;
         _loc1_.y = 49;
         _loc1_.text = "Workout";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",4473924);
         _loc1_.setStyle("fontStyle","italic");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_TextInput12_i() : TextInput
      {
         var _loc1_:TextInput = null;
         _loc1_ = new TextInput();
         _loc1_.x = 117;
         _loc1_.y = 64;
         _loc1_.enabled = false;
         _loc1_.width = 60;
         _loc1_.addEventListener("focusOut",this.__customProteinWorkout_focusOut);
         _loc1_.addEventListener("enter",this.__customProteinWorkout_enter);
         _loc1_.id = "customProteinWorkout";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.customProteinWorkout = _loc1_;
         BindingManager.executeBindings(this,"customProteinWorkout",this.customProteinWorkout);
         return _loc1_;
      }
      
      public function __customProteinWorkout_focusOut(param1:FocusEvent) : void
      {
         this.updateCustomProteinWorkout();
      }
      
      public function __customProteinWorkout_enter(param1:FlexEvent) : void
      {
         this.updateCustomProteinWorkout();
      }
      
      private function _IFCalc_Label81_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 180;
         _loc1_.y = 71.95;
         _loc1_.text = "g";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",4473924);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label82_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 49;
         _loc1_.y = 99;
         _loc1_.text = "Carbs / Fat Split";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_ComboBox4_i() : ComboBox
      {
         var _loc1_:ComboBox = null;
         _loc1_ = new ComboBox();
         _loc1_.x = 12;
         _loc1_.y = 128;
         _loc1_.width = 180;
         _loc1_.selectedIndex = 0;
         _loc1_.dataProvider = this._IFCalc_ArrayList4_c();
         _loc1_.setStyle("textAlign","center");
         _loc1_.addEventListener("change",this.__macroSplitCombo_change);
         _loc1_.id = "macroSplitCombo";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.macroSplitCombo = _loc1_;
         BindingManager.executeBindings(this,"macroSplitCombo",this.macroSplitCombo);
         return _loc1_;
      }
      
      private function _IFCalc_ArrayList4_c() : ArrayList
      {
         var _loc1_:ArrayList = null;
         _loc1_ = new ArrayList();
         _loc1_.source = ["50/50 - 50/50","50/50 - 75/25","25/75 - 75/25","20/80 - 80/20","15/85 - 85/15","10/90 - 90/10","Custom"];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function __macroSplitCombo_change(param1:IndexChangeEvent) : void
      {
         this.macroSplitCombo_changeHandler(param1);
      }
      
      private function _IFCalc_Label83_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 66.5;
         _loc1_.y = 114;
         _loc1_.text = "(Rest / Workout)";
         _loc1_.setStyle("fontSize",12);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",4473924);
         _loc1_.setStyle("fontStyle","italic");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer12_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 10;
         _loc1_.y = 310;
         _loc1_.width = 210;
         _loc1_.height = 94;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array22_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array22_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_NumericStepper3_i(),this._IFCalc_Label84_c(),this._IFCalc_NumericStepper4_i(),this._IFCalc_Label85_c(),this._IFCalc_Label86_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_NumericStepper3_i() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 134.5;
         _loc1_.y = 10;
         _loc1_.minimum = 2;
         _loc1_.maximum = 15;
         _loc1_.stepSize = 1;
         _loc1_.width = 54;
         _loc1_.addEventListener("change",this.__daysPerCycle_change);
         _loc1_.id = "daysPerCycle";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.daysPerCycle = _loc1_;
         BindingManager.executeBindings(this,"daysPerCycle",this.daysPerCycle);
         return _loc1_;
      }
      
      public function __daysPerCycle_change(param1:Event) : void
      {
         this.daysPerCycle_changeHandler(param1);
      }
      
      private function _IFCalc_Label84_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 17.5;
         _loc1_.y = 14.5;
         _loc1_.text = "Days per Cycle:";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_NumericStepper4_i() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 134.5;
         _loc1_.y = 57;
         _loc1_.minimum = 0;
         _loc1_.maximum = 7;
         _loc1_.stepSize = 1;
         _loc1_.width = 54;
         _loc1_.addEventListener("change",this.__workoutsPerCycle_change);
         _loc1_.id = "workoutsPerCycle";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutsPerCycle = _loc1_;
         BindingManager.executeBindings(this,"workoutsPerCycle",this.workoutsPerCycle);
         return _loc1_;
      }
      
      public function __workoutsPerCycle_change(param1:Event) : void
      {
         this.workoutsPerCycle_changeHandler(param1);
      }
      
      private function _IFCalc_Label85_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 17.5;
         _loc1_.y = 47;
         _loc1_.text = "Workouts per";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","left");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label86_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 17.5;
         _loc1_.y = 65;
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","left");
         _loc1_.id = "_IFCalc_Label86";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._IFCalc_Label86 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_Label86",this._IFCalc_Label86);
         return _loc1_;
      }
      
      private function _IFCalc_Label87_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 78;
         _loc1_.y = 5;
         _loc1_.text = "Presets";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label88_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 71.5;
         _loc1_.y = 289;
         _loc1_.text = "Schedule";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label89_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 67.5;
         _loc1_.y = 477;
         _loc1_.text = "Summary";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer13_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 8;
         _loc1_.y = 500;
         _loc1_.width = 922;
         _loc1_.height = 70;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array23_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array23_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label90_i(),this._IFCalc_Label91_i(),this._IFCalc_Label92_i(),this._IFCalc_Label93_i(),this._IFCalc_Label94_i(),this._IFCalc_Label95_i(),this._IFCalc_Label96_i(),this._IFCalc_Label97_i(),this._IFCalc_Label98_i(),this._IFCalc_Label99_i(),this._IFCalc_Label100_c(),this._IFCalc_Label101_c(),this._IFCalc_Label102_c(),this._IFCalc_VRule1_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label90_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 18;
         _loc1_.y = 13;
         _loc1_.width = 100;
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "_IFCalc_Label90";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._IFCalc_Label90 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_Label90",this._IFCalc_Label90);
         return _loc1_;
      }
      
      private function _IFCalc_Label91_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 125;
         _loc1_.y = 9.2;
         _loc1_.text = "15000";
         _loc1_.width = 60;
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","left");
         _loc1_.id = "cycleTdeeLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.cycleTdeeLBL = _loc1_;
         BindingManager.executeBindings(this,"cycleTdeeLBL",this.cycleTdeeLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label92_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 125;
         _loc1_.y = 39;
         _loc1_.width = 60;
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "cycleTdeeLBL0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.cycleTdeeLBL0 = _loc1_;
         BindingManager.executeBindings(this,"cycleTdeeLBL0",this.cycleTdeeLBL0);
         return _loc1_;
      }
      
      private function _IFCalc_Label93_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 247;
         _loc1_.y = 27;
         _loc1_.width = 114;
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "_IFCalc_Label93";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._IFCalc_Label93 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_Label93",this._IFCalc_Label93);
         return _loc1_;
      }
      
      private function _IFCalc_Label94_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 368;
         _loc1_.y = 23.2;
         _loc1_.text = "15000";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","left");
         _loc1_.id = "cycleCalsLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.cycleCalsLBL = _loc1_;
         BindingManager.executeBindings(this,"cycleCalsLBL",this.cycleCalsLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label95_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 458;
         _loc1_.y = 27;
         _loc1_.width = 140;
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "_IFCalc_Label95";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._IFCalc_Label95 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_Label95",this._IFCalc_Label95);
         return _loc1_;
      }
      
      private function _IFCalc_Label96_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 605;
         _loc1_.y = 23.2;
         _loc1_.text = "15000";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","left");
         _loc1_.id = "cycleOverUnderLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.cycleOverUnderLBL = _loc1_;
         BindingManager.executeBindings(this,"cycleOverUnderLBL",this.cycleOverUnderLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label97_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 688;
         _loc1_.y = 27;
         _loc1_.width = 110;
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "_IFCalc_Label97";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._IFCalc_Label97 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_Label97",this._IFCalc_Label97);
         return _loc1_;
      }
      
      private function _IFCalc_Label98_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 806;
         _loc1_.y = 23.2;
         _loc1_.text = "-25.25";
         _loc1_.width = 62;
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "cycleChangeLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.cycleChangeLBL = _loc1_;
         BindingManager.executeBindings(this,"cycleChangeLBL",this.cycleChangeLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label99_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 872;
         _loc1_.y = 29.749989;
         _loc1_.width = 25;
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",4473924);
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "_IFCalc_Label99";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._IFCalc_Label99 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_Label99",this._IFCalc_Label99);
         return _loc1_;
      }
      
      private function _IFCalc_Label100_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 67;
         _loc1_.y = 41;
         _loc1_.text = "TDEE:";
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label101_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 187;
         _loc1_.y = 15.7;
         _loc1_.text = "cals";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",4473924);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label102_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 187;
         _loc1_.y = 45.549976;
         _loc1_.text = "cals";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("color",4473924);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_VRule1_c() : VRule
      {
         var _loc1_:VRule = null;
         _loc1_ = new VRule();
         _loc1_.x = 232;
         _loc1_.y = 9;
         _loc1_.height = 50;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label103_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 38.5;
         _loc1_.y = 96;
         _loc1_.text = "Macronutrients";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function __macroCalcTab_contentCreationComplete(param1:FlexEvent) : void
      {
         this.macroCalcTab_contentCreationCompleteHandler(param1);
      }
      
      private function _IFCalc_Array24_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_BorderContainer14_i(),this._IFCalc_BorderContainer20_i(),this._IFCalc_ToggleButton3_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer14_i() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         _loc1_.visible = true;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array25_c);
         _loc1_.setStyle("borderVisible",false);
         _loc1_.setStyle("backgroundAlpha",0);
         _loc1_.id = "goalTable";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalTable = _loc1_;
         BindingManager.executeBindings(this,"goalTable",this.goalTable);
         return _loc1_;
      }
      
      private function _IFCalc_Array25_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_BorderContainer15_c(),this._IFCalc_Label106_c(),this._IFCalc_BorderContainer16_c(),this._IFCalc_BorderContainer18_c(),this._IFCalc_Label129_c(),this._IFCalc_BorderContainer19_c(),this._IFCalc_Label135_c(),this._IFCalc_AdvancedDataGrid1_i(),this._IFCalc_ToggleButton1_i(),this._IFCalc_TextArea3_i(),this._IFCalc_ToggleButton2_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer15_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 358;
         _loc1_.y = 25;
         _loc1_.width = 210;
         _loc1_.height = 134;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array26_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array26_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_NumericStepper5_i(),this._IFCalc_Label104_c(),this._IFCalc_NumericStepper6_i(),this._IFCalc_Label105_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_NumericStepper5_i() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 81.5;
         _loc1_.y = 29;
         _loc1_.minimum = 2;
         _loc1_.maximum = 15;
         _loc1_.stepSize = 1;
         _loc1_.addEventListener("change",this.__daysPerCycleGoals_change);
         _loc1_.id = "daysPerCycleGoals";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.daysPerCycleGoals = _loc1_;
         BindingManager.executeBindings(this,"daysPerCycleGoals",this.daysPerCycleGoals);
         return _loc1_;
      }
      
      public function __daysPerCycleGoals_change(param1:Event) : void
      {
         this.daysPerCycleGoals_changeHandler(param1);
      }
      
      private function _IFCalc_Label104_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 56.5;
         _loc1_.y = 9;
         _loc1_.text = "Days per Cycle";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_NumericStepper6_i() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 87.5;
         _loc1_.y = 89;
         _loc1_.minimum = 0;
         _loc1_.maximum = 7;
         _loc1_.stepSize = 1;
         _loc1_.addEventListener("change",this.__workoutsPerCycleGoals_change);
         _loc1_.id = "workoutsPerCycleGoals";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.workoutsPerCycleGoals = _loc1_;
         BindingManager.executeBindings(this,"workoutsPerCycleGoals",this.workoutsPerCycleGoals);
         return _loc1_;
      }
      
      public function __workoutsPerCycleGoals_change(param1:Event) : void
      {
         this.workoutsPerCycleGoals_changeHandler(param1);
      }
      
      private function _IFCalc_Label105_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 20;
         _loc1_.y = 71;
         _loc1_.width = 175;
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","center");
         _loc1_.id = "_IFCalc_Label105";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._IFCalc_Label105 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_Label105",this._IFCalc_Label105);
         return _loc1_;
      }
      
      private function _IFCalc_Label106_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 419;
         _loc1_.y = 2;
         _loc1_.text = "Schedule";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer16_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 10;
         _loc1_.y = 490;
         _loc1_.width = 840;
         _loc1_.height = 80;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array27_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array27_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label107_c(),this._IFCalc_Label108_i(),this._IFCalc_Label109_i(),this._IFCalc_Label110_c(),this._IFCalc_Label111_c(),this._IFCalc_BorderContainer17_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label107_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 90;
         _loc1_.y = 4;
         _loc1_.text = "Weight:";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","underline");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label108_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 52;
         _loc1_.y = 35;
         _loc1_.text = "195.0 lbs to 195.0 lbs";
         _loc1_.width = 150;
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "weightToLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.weightToLBL = _loc1_;
         BindingManager.executeBindings(this,"weightToLBL",this.weightToLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label109_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 52;
         _loc1_.y = 55;
         _loc1_.text = "-150.0 lbs / 66.56%";
         _loc1_.width = 150;
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.setStyle("fontStyle","normal");
         _loc1_.id = "weightDifLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.weightDifLBL = _loc1_;
         BindingManager.executeBindings(this,"weightDifLBL",this.weightDifLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label110_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 339;
         _loc1_.y = 19;
         _loc1_.text = "Body fat calculations are not available.";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("color",16711680);
         _loc1_.setStyle("fontWeight","normal");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label111_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 368.5;
         _loc1_.y = 44;
         _loc1_.text = "Enter your Body Fat % on the \"Basic Info\" tab to enable";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("color",16711680);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer17_i() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 214;
         _loc1_.y = 0;
         _loc1_.width = 614;
         _loc1_.height = 78;
         _loc1_.visible = true;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array28_c);
         _loc1_.setStyle("borderVisible",false);
         _loc1_.id = "bfGoals";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bfGoals = _loc1_;
         BindingManager.executeBindings(this,"bfGoals",this.bfGoals);
         return _loc1_;
      }
      
      private function _IFCalc_Array28_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label112_i(),this._IFCalc_Label113_i(),this._IFCalc_Label114_c(),this._IFCalc_Label115_i(),this._IFCalc_Label116_i(),this._IFCalc_Label117_c(),this._IFCalc_Label118_i(),this._IFCalc_Label119_i(),this._IFCalc_Label120_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label112_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 51;
         _loc1_.y = 35;
         _loc1_.text = "195.0 lbs to 195.0 lbs";
         _loc1_.width = 150;
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "lbmToLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.lbmToLBL = _loc1_;
         BindingManager.executeBindings(this,"lbmToLBL",this.lbmToLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label113_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 51;
         _loc1_.y = 55;
         _loc1_.text = "-150.0 lbs / 66.56%";
         _loc1_.width = 150;
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.setStyle("fontStyle","normal");
         _loc1_.id = "lbmDifLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.lbmDifLBL = _loc1_;
         BindingManager.executeBindings(this,"lbmDifLBL",this.lbmDifLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label114_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 98;
         _loc1_.y = 4;
         _loc1_.text = "LBM:";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","underline");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label115_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 238;
         _loc1_.y = 35;
         _loc1_.text = "195.0 lbs to 195.0 lbs";
         _loc1_.width = 150;
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "fatToLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.fatToLBL = _loc1_;
         BindingManager.executeBindings(this,"fatToLBL",this.fatToLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label116_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 238;
         _loc1_.y = 55;
         _loc1_.text = "-150.0 lbs / 66.56%";
         _loc1_.width = 150;
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.setStyle("fontStyle","normal");
         _loc1_.id = "fatDifLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.fatDifLBL = _loc1_;
         BindingManager.executeBindings(this,"fatDifLBL",this.fatDifLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label117_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 292;
         _loc1_.y = 4;
         _loc1_.text = "Fat:";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","underline");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label118_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 425.5;
         _loc1_.y = 55;
         _loc1_.text = "-5.5 lbs. / -6.02%";
         _loc1_.width = 150;
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "bfpDifLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bfpDifLBL = _loc1_;
         BindingManager.executeBindings(this,"bfpDifLBL",this.bfpDifLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label119_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 425.5;
         _loc1_.y = 35;
         _loc1_.text = "195.0 lbs to 195.0 lbs";
         _loc1_.width = 150;
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "bfpToLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bfpToLBL = _loc1_;
         BindingManager.executeBindings(this,"bfpToLBL",this.bfpToLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label120_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 439;
         _loc1_.y = 4;
         _loc1_.text = "Body Fat %:";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","underline");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer18_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 131;
         _loc1_.y = 25;
         _loc1_.width = 210;
         _loc1_.height = 134;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array29_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array29_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label121_i(),this._IFCalc_NumericStepper7_i(),this._IFCalc_DateField1_i(),this._IFCalc_Label122_c(),this._IFCalc_Label123_i(),this._IFCalc_Label124_i(),this._IFCalc_Label125_i(),this._IFCalc_Label126_i(),this._IFCalc_Label127_c(),this._IFCalc_Label128_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label121_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 18.5;
         _loc1_.y = 10.6;
         _loc1_.text = "Lose";
         _loc1_.width = 58;
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "gainLoseTEXT";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.gainLoseTEXT = _loc1_;
         BindingManager.executeBindings(this,"gainLoseTEXT",this.gainLoseTEXT);
         return _loc1_;
      }
      
      private function _IFCalc_NumericStepper7_i() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 84;
         _loc1_.y = 4;
         _loc1_.minimum = 0;
         _loc1_.maximum = 300;
         _loc1_.width = 71;
         _loc1_.value = 10;
         _loc1_.stepSize = 1;
         _loc1_.setStyle("fontSize",20);
         _loc1_.addEventListener("change",this.__gainLoseAmt_change);
         _loc1_.id = "gainLoseAmt";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.gainLoseAmt = _loc1_;
         BindingManager.executeBindings(this,"gainLoseAmt",this.gainLoseAmt);
         return _loc1_;
      }
      
      public function __gainLoseAmt_change(param1:Event) : void
      {
         this.calcGoals();
      }
      
      private function _IFCalc_DateField1_i() : DateField
      {
         var _loc1_:DateField = null;
         _loc1_ = new DateField();
         _loc1_.x = 84;
         _loc1_.y = 40;
         _loc1_.width = 95;
         _loc1_.addEventListener("creationComplete",this.__startDate_creationComplete);
         _loc1_.addEventListener("change",this.__startDate_change);
         _loc1_.id = "startDate";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.startDate = _loc1_;
         BindingManager.executeBindings(this,"startDate",this.startDate);
         return _loc1_;
      }
      
      public function __startDate_creationComplete(param1:FlexEvent) : void
      {
         this.startDate.selectedDate = new Date();
      }
      
      public function __startDate_change(param1:CalendarLayoutChangeEvent) : void
      {
         this.calcGoals();
      }
      
      private function _IFCalc_Label122_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 13.5;
         _loc1_.y = 47;
         _loc1_.text = "Start Date";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label123_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 156.5;
         _loc1_.y = 19;
         _loc1_.width = 25;
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "_IFCalc_Label123";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._IFCalc_Label123 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_Label123",this._IFCalc_Label123);
         return _loc1_;
      }
      
      private function _IFCalc_Label124_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 24.5;
         _loc1_.y = 73.5;
         _loc1_.width = 135;
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "goalsCyclesToCompleteLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalsCyclesToCompleteLBL = _loc1_;
         BindingManager.executeBindings(this,"goalsCyclesToCompleteLBL",this.goalsCyclesToCompleteLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label125_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 165;
         _loc1_.y = 72;
         _loc1_.text = "555";
         _loc1_.styleName = "greentext";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "goalsCyclesToComplete";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalsCyclesToComplete = _loc1_;
         BindingManager.executeBindings(this,"goalsCyclesToComplete",this.goalsCyclesToComplete);
         return _loc1_;
      }
      
      private function _IFCalc_Label126_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 0;
         _loc1_.y = 91.75;
         _loc1_.text = "(10000 days)";
         _loc1_.percentWidth = 100;
         _loc1_.styleName = "greentext";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.id = "goalsDaysToComplete";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalsDaysToComplete = _loc1_;
         BindingManager.executeBindings(this,"goalsDaysToComplete",this.goalsDaysToComplete);
         return _loc1_;
      }
      
      private function _IFCalc_Label127_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 8.5;
         _loc1_.y = 111.5;
         _loc1_.text = "Finish:";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","right");
         _loc1_.setStyle("lineBreak","explicit");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label128_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 59;
         _loc1_.y = 110;
         _loc1_.text = "Finish Date";
         _loc1_.styleName = "greentext";
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "goalsFinishDate";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalsFinishDate = _loc1_;
         BindingManager.executeBindings(this,"goalsFinishDate",this.goalsFinishDate);
         return _loc1_;
      }
      
      private function _IFCalc_Label129_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 212;
         _loc1_.y = 2;
         _loc1_.text = "Goal";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer19_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 586;
         _loc1_.y = 25;
         _loc1_.width = 230;
         _loc1_.height = 134;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array30_c);
         _loc1_.setStyle("cornerRadius",10);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Array30_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label130_c(),this._IFCalc_NumericStepper8_i(),this._IFCalc_Label131_i(),this._IFCalc_RadioButton14_i(),this._IFCalc_RadioButton15_i(),this._IFCalc_Label132_c(),this._IFCalc_NumericStepper9_i(),this._IFCalc_Label133_c(),this._IFCalc_Label134_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label130_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 15;
         _loc1_.y = 18;
         _loc1_.text = "Recalculate every\r";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_NumericStepper8_i() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 135;
         _loc1_.y = 10;
         _loc1_.minimum = 0;
         _loc1_.maximum = 25;
         _loc1_.width = 53;
         _loc1_.stepSize = 0.5;
         _loc1_.value = 5;
         _loc1_.addEventListener("change",this.__recalcWeight_change);
         _loc1_.id = "recalcWeight";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.recalcWeight = _loc1_;
         BindingManager.executeBindings(this,"recalcWeight",this.recalcWeight);
         return _loc1_;
      }
      
      public function __recalcWeight_change(param1:Event) : void
      {
         this.calcGoals();
      }
      
      private function _IFCalc_Label131_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 189.5;
         _loc1_.y = 18;
         _loc1_.width = 25;
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("lineBreak","explicit");
         _loc1_.id = "_IFCalc_Label131";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._IFCalc_Label131 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_Label131",this._IFCalc_Label131);
         return _loc1_;
      }
      
      private function _IFCalc_RadioButton14_i() : RadioButton
      {
         var _loc1_:RadioButton = null;
         _loc1_ = new RadioButton();
         _loc1_.x = 30;
         _loc1_.y = 38;
         _loc1_.label = "Maintain TDEE %s";
         _loc1_.groupName = "maintainSchedule";
         _loc1_.selected = true;
         _loc1_.id = "maintainTdee";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.maintainTdee = _loc1_;
         BindingManager.executeBindings(this,"maintainTdee",this.maintainTdee);
         return _loc1_;
      }
      
      private function _IFCalc_RadioButton15_i() : RadioButton
      {
         var _loc1_:RadioButton = null;
         _loc1_ = new RadioButton();
         _loc1_.x = 30;
         _loc1_.y = 59;
         _loc1_.label = "Maintain Change Rate";
         _loc1_.groupName = "maintainSchedule";
         _loc1_.id = "maintainChangerate";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.maintainChangerate = _loc1_;
         BindingManager.executeBindings(this,"maintainChangerate",this.maintainChangerate);
         return _loc1_;
      }
      
      private function _IFCalc_Label132_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 10;
         _loc1_.y = 99;
         _loc1_.text = "Weight change is";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_NumericStepper9_i() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 126;
         _loc1_.y = 91;
         _loc1_.minimum = 0;
         _loc1_.width = 53;
         _loc1_.maximum = 100;
         _loc1_.stepSize = 1;
         _loc1_.value = 85;
         _loc1_.addEventListener("change",this.__recalcFatLossPct_change);
         _loc1_.id = "recalcFatLossPct";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.recalcFatLossPct = _loc1_;
         BindingManager.executeBindings(this,"recalcFatLossPct",this.recalcFatLossPct);
         return _loc1_;
      }
      
      public function __recalcFatLossPct_change(param1:Event) : void
      {
         this.calcGoals();
      }
      
      private function _IFCalc_Label133_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 182;
         _loc1_.y = 99;
         _loc1_.text = "% fat";
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","normal");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label134_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 160;
         _loc1_.y = 64;
         _loc1_.text = "(0.72 lbs)";
         _loc1_.setStyle("fontSize",12);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("textAlign","left");
         _loc1_.id = "goalChangeRateDisplayLBL";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalChangeRateDisplayLBL = _loc1_;
         BindingManager.executeBindings(this,"goalChangeRateDisplayLBL",this.goalChangeRateDisplayLBL);
         return _loc1_;
      }
      
      private function _IFCalc_Label135_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 616.5;
         _loc1_.y = 2;
         _loc1_.text = "Schedule Options";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGrid1_i() : AdvancedDataGrid
      {
         var _loc1_:AdvancedDataGrid = null;
         _loc1_ = new AdvancedDataGrid();
         _loc1_.x = 10;
         _loc1_.y = 166;
         _loc1_.designViewDataType = "flat";
         _loc1_.width = 918;
         _loc1_.height = 316;
         _loc1_.editable = "false";
         _loc1_.sortableColumns = false;
         _loc1_.sortExpertMode = true;
         _loc1_.draggableColumns = true;
         _loc1_.headerWordWrap = true;
         _loc1_.columns = [this._IFCalc_AdvancedDataGridColumn1_c(),this._IFCalc_AdvancedDataGridColumn2_i(),this._IFCalc_AdvancedDataGridColumn3_c(),this._IFCalc_AdvancedDataGridColumn4_c(),this._IFCalc_AdvancedDataGridColumn5_i(),this._IFCalc_AdvancedDataGridColumn6_i(),this._IFCalc_AdvancedDataGridColumn7_i(),this._IFCalc_AdvancedDataGridColumn8_c(),this._IFCalc_AdvancedDataGridColumn9_c(),this._IFCalc_AdvancedDataGridColumn10_c(),this._IFCalc_AdvancedDataGridColumn11_c(),this._IFCalc_AdvancedDataGridColumn12_c(),this._IFCalc_AdvancedDataGridColumn13_i()];
         _loc1_.id = "scheduleDG";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.scheduleDG = _loc1_;
         BindingManager.executeBindings(this,"scheduleDG",this.scheduleDG);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn1_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Date";
         _loc1_.dataField = "date";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn2_i() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.dataField = "cycleno";
         this._IFCalc_AdvancedDataGridColumn2 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_AdvancedDataGridColumn2",this._IFCalc_AdvancedDataGridColumn2);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn3_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Days";
         _loc1_.dataField = "days";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn4_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Weight";
         _loc1_.dataField = "weight";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn5_i() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "LBM";
         _loc1_.dataField = "lbm";
         this.lbmfield = _loc1_;
         BindingManager.executeBindings(this,"lbmfield",this.lbmfield);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn6_i() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Fat";
         _loc1_.dataField = "fat";
         this.fatfield = _loc1_;
         BindingManager.executeBindings(this,"fatfield",this.fatfield);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn7_i() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "BF %";
         _loc1_.dataField = "bfp";
         this.bfpfield = _loc1_;
         BindingManager.executeBindings(this,"bfpfield",this.bfpfield);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn8_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Change";
         _loc1_.dataField = "change";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn9_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Total";
         _loc1_.dataField = "total";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn10_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "TDEE";
         _loc1_.dataField = "tdee";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn11_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Rest Calories";
         _loc1_.headerWordWrap = true;
         _loc1_.dataField = "restcals";
         _loc1_.setStyle("headerStyleName","headeralign");
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn12_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Workout Calories";
         _loc1_.headerWordWrap = true;
         _loc1_.dataField = "workoutcals";
         _loc1_.setStyle("headerStyleName","headeralign");
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn13_i() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerWordWrap = true;
         _loc1_.dataField = "cyclecals";
         _loc1_.setStyle("headerStyleName","headeralign");
         this._IFCalc_AdvancedDataGridColumn13 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_AdvancedDataGridColumn13",this._IFCalc_AdvancedDataGridColumn13);
         return _loc1_;
      }
      
      private function _IFCalc_ToggleButton1_i() : ToggleButton
      {
         var _loc1_:ToggleButton = null;
         _loc1_ = new ToggleButton();
         _loc1_.x = 858;
         _loc1_.y = 519.5;
         _loc1_.label = "XML";
         _loc1_.width = 70;
         _loc1_.addEventListener("click",this.__goalXMLBTN0_click);
         _loc1_.id = "goalXMLBTN0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalXMLBTN0 = _loc1_;
         BindingManager.executeBindings(this,"goalXMLBTN0",this.goalXMLBTN0);
         return _loc1_;
      }
      
      public function __goalXMLBTN0_click(param1:MouseEvent) : void
      {
         this.goalXMLBTN0_clickHandler(param1);
      }
      
      private function _IFCalc_TextArea3_i() : spark.components.TextArea
      {
         var _loc1_:spark.components.TextArea = null;
         _loc1_ = new spark.components.TextArea();
         _loc1_.x = 10;
         _loc1_.y = 166;
         _loc1_.width = 918;
         _loc1_.height = 316;
         _loc1_.editable = false;
         _loc1_.visible = false;
         _loc1_.id = "goalExportTXA0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalExportTXA0 = _loc1_;
         BindingManager.executeBindings(this,"goalExportTXA0",this.goalExportTXA0);
         return _loc1_;
      }
      
      private function _IFCalc_ToggleButton2_i() : ToggleButton
      {
         var _loc1_:ToggleButton = null;
         _loc1_ = new ToggleButton();
         _loc1_.x = 859;
         _loc1_.y = 549;
         _loc1_.label = "CSV";
         _loc1_.width = 70;
         _loc1_.enabled = false;
         _loc1_.toolTip = "Not working yet :(";
         _loc1_.addEventListener("click",this.__goalCSVBTN0_click);
         _loc1_.id = "goalCSVBTN0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalCSVBTN0 = _loc1_;
         BindingManager.executeBindings(this,"goalCSVBTN0",this.goalCSVBTN0);
         return _loc1_;
      }
      
      public function __goalCSVBTN0_click(param1:MouseEvent) : void
      {
         this.goalCSVBTN0_clickHandler(param1);
      }
      
      private function _IFCalc_BorderContainer20_i() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         _loc1_.visible = false;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._IFCalc_Array32_c);
         _loc1_.setStyle("borderVisible",false);
         _loc1_.setStyle("backgroundAlpha",0);
         _loc1_.id = "goalChart";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalChart = _loc1_;
         BindingManager.executeBindings(this,"goalChart",this.goalChart);
         return _loc1_;
      }
      
      private function _IFCalc_Array32_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_BorderContainer21_c(),this._IFCalc_LineChart1_i(),this._IFCalc_Legend1_i(),this._IFCalc_RadioButton16_i(),this._IFCalc_RadioButton17_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_BorderContainer21_c() : BorderContainer
      {
         var _loc1_:BorderContainer = null;
         _loc1_ = new BorderContainer();
         _loc1_.x = 189;
         _loc1_.y = 10;
         _loc1_.width = 560;
         _loc1_.height = 560;
         _loc1_.setStyle("borderVisible",false);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_LineChart1_i() : LineChart
      {
         var _loc1_:LineChart = null;
         _loc1_ = new LineChart();
         _loc1_.x = 189;
         _loc1_.y = 10;
         _loc1_.height = 560;
         _loc1_.width = 560;
         _loc1_.showDataTips = true;
         _loc1_.horizontalAxis = this._IFCalc_CategoryAxis1_i();
         _loc1_.verticalAxis = this._IFCalc_LinearAxis1_i();
         _loc1_.series = [this._IFCalc_LineSeries1_i(),this._IFCalc_LineSeries2_i(),this._IFCalc_LineSeries3_i()];
         _loc1_.id = "goalLineChart";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalLineChart = _loc1_;
         BindingManager.executeBindings(this,"goalLineChart",this.goalLineChart);
         return _loc1_;
      }
      
      private function _IFCalc_CategoryAxis1_i() : CategoryAxis
      {
         var _loc1_:CategoryAxis = null;
         _loc1_ = new CategoryAxis();
         _loc1_.categoryField = "date";
         this._IFCalc_CategoryAxis1 = _loc1_;
         BindingManager.executeBindings(this,"_IFCalc_CategoryAxis1",this._IFCalc_CategoryAxis1);
         return _loc1_;
      }
      
      private function _IFCalc_LinearAxis1_i() : LinearAxis
      {
         var _loc1_:LinearAxis = null;
         _loc1_ = new LinearAxis();
         this.goalVertAxis = _loc1_;
         BindingManager.executeBindings(this,"goalVertAxis",this.goalVertAxis);
         return _loc1_;
      }
      
      private function _IFCalc_LineSeries1_i() : LineSeries
      {
         var _loc1_:LineSeries = null;
         _loc1_ = new LineSeries();
         _loc1_.displayName = "Weight";
         _loc1_.yField = "weight";
         _loc1_.visible = true;
         _loc1_.id = "goalSeriesWeight";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalSeriesWeight = _loc1_;
         BindingManager.executeBindings(this,"goalSeriesWeight",this.goalSeriesWeight);
         return _loc1_;
      }
      
      private function _IFCalc_LineSeries2_i() : LineSeries
      {
         var _loc1_:LineSeries = null;
         _loc1_ = new LineSeries();
         _loc1_.displayName = "LBM";
         _loc1_.yField = "lbm";
         _loc1_.visible = false;
         _loc1_.id = "goalSeriesLBM";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalSeriesLBM = _loc1_;
         BindingManager.executeBindings(this,"goalSeriesLBM",this.goalSeriesLBM);
         return _loc1_;
      }
      
      private function _IFCalc_LineSeries3_i() : LineSeries
      {
         var _loc1_:LineSeries = null;
         _loc1_ = new LineSeries();
         _loc1_.displayName = "Fat";
         _loc1_.yField = "fat";
         _loc1_.visible = false;
         _loc1_.id = "goalSeriesFat";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalSeriesFat = _loc1_;
         BindingManager.executeBindings(this,"goalSeriesFat",this.goalSeriesFat);
         return _loc1_;
      }
      
      private function _IFCalc_Legend1_i() : Legend
      {
         var _loc1_:Legend = null;
         _loc1_ = new Legend();
         _loc1_.x = 803;
         _loc1_.y = 215;
         _loc1_.visible = false;
         _loc1_.setStyle("backgroundColor",16777215);
         _loc1_.id = "goalChartLegend";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalChartLegend = _loc1_;
         BindingManager.executeBindings(this,"goalChartLegend",this.goalChartLegend);
         return _loc1_;
      }
      
      private function _IFCalc_RadioButton16_i() : RadioButton
      {
         var _loc1_:RadioButton = null;
         _loc1_ = new RadioButton();
         _loc1_.x = 791;
         _loc1_.y = 157;
         _loc1_.label = "Weight Only";
         _loc1_.groupName = "goalChartFieldsGroup";
         _loc1_.selected = true;
         _loc1_.value = "weight";
         _loc1_.id = "goalChartFieldWeight";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalChartFieldWeight = _loc1_;
         BindingManager.executeBindings(this,"goalChartFieldWeight",this.goalChartFieldWeight);
         return _loc1_;
      }
      
      private function _IFCalc_RadioButton17_i() : RadioButton
      {
         var _loc1_:RadioButton = null;
         _loc1_ = new RadioButton();
         _loc1_.x = 791;
         _loc1_.y = 178;
         _loc1_.label = "Weight, LBM, BF";
         _loc1_.groupName = "goalChartFieldsGroup";
         _loc1_.enabled = false;
         _loc1_.value = "bf";
         _loc1_.id = "goalChartFieldFat";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalChartFieldFat = _loc1_;
         BindingManager.executeBindings(this,"goalChartFieldFat",this.goalChartFieldFat);
         return _loc1_;
      }
      
      private function _IFCalc_ToggleButton3_i() : ToggleButton
      {
         var _loc1_:ToggleButton = null;
         _loc1_ = new ToggleButton();
         _loc1_.x = 858;
         _loc1_.y = 490;
         _loc1_.label = "Graph";
         _loc1_.selected = false;
         _loc1_.width = 70;
         _loc1_.addEventListener("click",this.__goalGraphBTN_click);
         _loc1_.id = "goalGraphBTN";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.goalGraphBTN = _loc1_;
         BindingManager.executeBindings(this,"goalGraphBTN",this.goalGraphBTN);
         return _loc1_;
      }
      
      public function __goalGraphBTN_click(param1:MouseEvent) : void
      {
         this.goalGraphBTN_clickHandler(param1);
      }
      
      private function _IFCalc_Array34_c() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [this._IFCalc_Label136_c(),this._IFCalc_ComboBox5_c(),this._IFCalc_VRule2_c(),this._IFCalc_Label137_c(),this._IFCalc_Label138_c(),this._IFCalc_HRule4_c(),this._IFCalc_HRule5_c(),this._IFCalc_AdvancedDataGrid2_i(),this._IFCalc_NumericStepper10_c(),this._IFCalc_Label139_c(),this._IFCalc_AdvancedDataGrid3_i(),this._IFCalc_AdvancedDataGrid4_i(),this._IFCalc_NumericStepper11_c(),this._IFCalc_Label140_c(),this._IFCalc_NumericStepper12_c(),this._IFCalc_Label141_c(),this._IFCalc_Label142_c(),this._IFCalc_Label143_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label136_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 305;
         _loc1_.y = 25;
         _loc1_.text = "Protocol Preset";
         _loc1_.setStyle("fontSize",18);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_ComboBox5_c() : ComboBox
      {
         var _loc1_:ComboBox = null;
         _loc1_ = new ComboBox();
         _loc1_.x = 420;
         _loc1_.y = 22;
         _loc1_.width = 200;
         _loc1_.dataProvider = this._IFCalc_ArrayList5_c();
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_ArrayList5_c() : ArrayList
      {
         var _loc1_:ArrayList = null;
         _loc1_ = new ArrayList();
         _loc1_.source = ["Fasted training","Early morning fasted training","One pre-workout meal","Two pre-workout meals","Custom"];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_VRule2_c() : VRule
      {
         var _loc1_:VRule = null;
         _loc1_ = new VRule();
         _loc1_.x = 468;
         _loc1_.y = 60;
         _loc1_.height = 500;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label137_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 183.5;
         _loc1_.y = 68;
         _loc1_.text = "Rest Days";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label138_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 636;
         _loc1_.y = 68;
         _loc1_.text = "Workout Days";
         _loc1_.setStyle("fontSize",24);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textDecoration","none");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_HRule4_c() : HRule
      {
         var _loc1_:HRule = null;
         _loc1_ = new HRule();
         _loc1_.x = 10;
         _loc1_.y = 95;
         _loc1_.width = 450;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_HRule5_c() : HRule
      {
         var _loc1_:HRule = null;
         _loc1_ = new HRule();
         _loc1_.x = 480;
         _loc1_.y = 95;
         _loc1_.width = 450;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGrid2_i() : AdvancedDataGrid
      {
         var _loc1_:AdvancedDataGrid = null;
         _loc1_ = new AdvancedDataGrid();
         _loc1_.x = 22;
         _loc1_.y = 162;
         _loc1_.designViewDataType = "flat";
         _loc1_.width = 420;
         _loc1_.sortableColumns = false;
         _loc1_.sortExpertMode = true;
         _loc1_.height = 200;
         _loc1_.headerWordWrap = true;
         _loc1_.columns = [this._IFCalc_AdvancedDataGridColumn14_c(),this._IFCalc_AdvancedDataGridColumn15_c(),this._IFCalc_AdvancedDataGridColumn16_c(),this._IFCalc_AdvancedDataGridColumn17_c(),this._IFCalc_AdvancedDataGridColumn18_c()];
         _loc1_.id = "restMeals";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restMeals = _loc1_;
         BindingManager.executeBindings(this,"restMeals",this.restMeals);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn14_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Time";
         _loc1_.dataField = "col1";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn15_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Calories";
         _loc1_.dataField = "col2";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn16_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Protein";
         _loc1_.dataField = "col3";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn17_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Carbs";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn18_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Fat";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_NumericStepper10_c() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 170;
         _loc1_.y = 123;
         _loc1_.minimum = 1;
         _loc1_.maximum = 10;
         _loc1_.stepSize = 1;
         _loc1_.value = 3;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label139_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 226;
         _loc1_.y = 131;
         _loc1_.text = "Total Meals";
         _loc1_.setStyle("fontSize",16);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGrid3_i() : AdvancedDataGrid
      {
         var _loc1_:AdvancedDataGrid = null;
         _loc1_ = new AdvancedDataGrid();
         _loc1_.x = 495;
         _loc1_.y = 162;
         _loc1_.designViewDataType = "flat";
         _loc1_.width = 420;
         _loc1_.height = 170;
         _loc1_.sortableColumns = false;
         _loc1_.sortExpertMode = true;
         _loc1_.headerWordWrap = true;
         _loc1_.columns = [this._IFCalc_AdvancedDataGridColumn19_c(),this._IFCalc_AdvancedDataGridColumn20_c(),this._IFCalc_AdvancedDataGridColumn21_c(),this._IFCalc_AdvancedDataGridColumn22_c(),this._IFCalc_AdvancedDataGridColumn23_c()];
         _loc1_.id = "restMeals0";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restMeals0 = _loc1_;
         BindingManager.executeBindings(this,"restMeals0",this.restMeals0);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn19_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Time";
         _loc1_.dataField = "col1";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn20_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Calories";
         _loc1_.dataField = "col2";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn21_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Protein";
         _loc1_.dataField = "col3";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn22_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Carbs";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn23_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Fat";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGrid4_i() : AdvancedDataGrid
      {
         var _loc1_:AdvancedDataGrid = null;
         _loc1_ = new AdvancedDataGrid();
         _loc1_.x = 495;
         _loc1_.y = 370;
         _loc1_.designViewDataType = "flat";
         _loc1_.width = 420;
         _loc1_.sortableColumns = false;
         _loc1_.sortExpertMode = true;
         _loc1_.height = 170;
         _loc1_.headerWordWrap = true;
         _loc1_.columns = [this._IFCalc_AdvancedDataGridColumn24_c(),this._IFCalc_AdvancedDataGridColumn25_c(),this._IFCalc_AdvancedDataGridColumn26_c(),this._IFCalc_AdvancedDataGridColumn27_c(),this._IFCalc_AdvancedDataGridColumn28_c()];
         _loc1_.id = "restMeals1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.restMeals1 = _loc1_;
         BindingManager.executeBindings(this,"restMeals1",this.restMeals1);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn24_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Time";
         _loc1_.dataField = "col1";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn25_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Calories";
         _loc1_.dataField = "col2";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn26_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Protein";
         _loc1_.dataField = "col3";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn27_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Carbs";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_AdvancedDataGridColumn28_c() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = null;
         _loc1_ = new AdvancedDataGridColumn();
         _loc1_.headerText = "Fat";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_NumericStepper11_c() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 523;
         _loc1_.y = 123;
         _loc1_.minimum = 1;
         _loc1_.maximum = 10;
         _loc1_.stepSize = 1;
         _loc1_.value = 3;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label140_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 579;
         _loc1_.y = 131;
         _loc1_.text = "Total Meals";
         _loc1_.setStyle("fontSize",16);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_NumericStepper12_c() : NumericStepper
      {
         var _loc1_:NumericStepper = null;
         _loc1_ = new NumericStepper();
         _loc1_.x = 712;
         _loc1_.y = 123;
         _loc1_.minimum = 0;
         _loc1_.maximum = 10;
         _loc1_.stepSize = 1;
         _loc1_.value = 0;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label141_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 768;
         _loc1_.y = 131;
         _loc1_.text = "Pre-workout Meals";
         _loc1_.setStyle("fontSize",16);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label142_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 675;
         _loc1_.y = 128;
         _loc1_.text = "/";
         _loc1_.setStyle("fontSize",24);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _IFCalc_Label143_c() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 660;
         _loc1_.y = 345;
         _loc1_.text = "- Workout -";
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("fontWeight","bold");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function ___IFCalc_Application1_creationComplete(param1:FlexEvent) : void
      {
         this.cc(param1);
      }
      
      public function ___IFCalc_Application1_initialize(param1:FlexEvent) : void
      {
         this.init(param1);
      }
      
      public function ___IFCalc_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.application1_applicationCompleteHandler(param1);
      }
      
      private function _IFCalc_bindingsSetup() : Array
      {
         var result:Array = null;
         result = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = ver;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_Label4.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = user.height;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"heightTXT0.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = heightString;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"heightLBL1.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = user.heightin;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"inchesTXT0.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = user.weight;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"weightTXT0.text");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = weightString;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"weightLBL1.text");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = user.age;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"ageTXT0.text");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = user.bfpct;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"bodyfatTXT0.text");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = user.waist;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"waistTXT0.text");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = heightString2;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"waistLBL2.text");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = weightString;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"lbmLBL2.text");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = weightString;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"fbmLBL2.text");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = weightString;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"bmiTwinLBL2.text");
         result[13] = new Binding(this,function():Object
         {
            return restCollection;
         },null,"restDayChart.dataProvider");
         result[14] = new Binding(this,function():Number
         {
            return restCollection.getItemAt(0).pct;
         },null,"restProteinSlider.value");
         result[15] = new Binding(this,function():Number
         {
            return restCollection.getItemAt(1).pct;
         },null,"restCarbsSlider.value");
         result[16] = new Binding(this,function():Number
         {
            return restCollection.getItemAt(2).pct;
         },null,"restFatSlider.value");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = "% " + restOverUnderString + " TDEE";
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"restPctTdeeLBL.text");
         result[18] = new Binding(this,function():Object
         {
            return workoutCollection;
         },null,"workoutDayChart.dataProvider");
         result[19] = new Binding(this,function():Number
         {
            return workoutCollection.getItemAt(0).pct;
         },null,"workoutProteinSlider.value");
         result[20] = new Binding(this,function():Number
         {
            return workoutCollection.getItemAt(1).pct;
         },null,"workoutCarbsSlider.value");
         result[21] = new Binding(this,function():Number
         {
            return workoutCollection.getItemAt(2).pct;
         },null,"workoutFatSlider.value");
         result[22] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = "% " + workoutOverUnderString + " TDEE";
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"workoutPctTdeeLBL.text");
         result[23] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = restCollection.getItemAt(0).grams.toFixed(1);
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"customProteinRest.text");
         result[24] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = workoutCollection.getItemAt(0).grams.toFixed(1);
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"customProteinWorkout.text");
         result[25] = new Binding(this,function():Number
         {
            return user.cycledays;
         },null,"daysPerCycle.value");
         result[26] = new Binding(this,function():Number
         {
            return user.cycleworkouts;
         },null,"workoutsPerCycle.value");
         result[27] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = cycleText + ":";
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_Label86.text");
         result[28] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = cycleText + " TEE:";
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_Label90.text");
         result[29] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = Math.round(user.tdee).toString();
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"cycleTdeeLBL0.text");
         result[30] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = cycleText + " Calories:";
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_Label93.text");
         result[31] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = cycleText + " Over/Under:";
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_Label95.text");
         result[32] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = cycleText + " Change:";
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_Label97.text");
         result[33] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = weightString;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_Label99.text");
         result[34] = new Binding(this,function():Number
         {
            return user.cycledays;
         },null,"daysPerCycleGoals.value");
         result[35] = new Binding(this,function():Number
         {
            return user.cycleworkouts;
         },null,"workoutsPerCycleGoals.value");
         result[36] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = "Workouts per " + cycleText;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_Label105.text");
         result[37] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = weightString;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_Label123.text");
         result[38] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = cycleText + "s to Complete:";
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"goalsCyclesToCompleteLBL.text");
         result[39] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = weightString;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_Label131.text");
         result[40] = new Binding(this,function():Object
         {
            return goalCollection;
         },null,"scheduleDG.dataProvider");
         result[41] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = cycleText;
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_AdvancedDataGridColumn2.headerText");
         result[42] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = cycleText + " Calories";
            return _loc1_ == undefined?null:String(_loc1_);
         },null,"_IFCalc_AdvancedDataGridColumn13.headerText");
         result[43] = new Binding(this,function():Object
         {
            return goalCollection;
         },null,"goalLineChart.dataProvider");
         result[44] = new Binding(this,function():Object
         {
            return goalCollection;
         },null,"_IFCalc_CategoryAxis1.dataProvider");
         result[45] = new Binding(this,null,null,"goalChartLegend.dataProvider","goalLineChart");
         result[46] = new Binding(this,function():*
         {
            return daysPerCycle.value;
         },function(param1:*):void
         {
            user.cycledays = param1;
         },"user.cycledays");
         result[46].twoWayCounterpart = result[25];
         result[25].isTwoWayPrimary = true;
         result[25].twoWayCounterpart = result[46];
         result[47] = new Binding(this,function():*
         {
            return workoutsPerCycle.value;
         },function(param1:*):void
         {
            user.cycleworkouts = param1;
         },"user.cycleworkouts");
         result[47].twoWayCounterpart = result[26];
         result[26].isTwoWayPrimary = true;
         result[26].twoWayCounterpart = result[47];
         result[48] = new Binding(this,function():*
         {
            return daysPerCycleGoals.value;
         },function(param1:*):void
         {
            user.cycledays = param1;
         },"user.cycledays");
         result[48].twoWayCounterpart = result[34];
         result[34].isTwoWayPrimary = true;
         result[34].twoWayCounterpart = result[48];
         result[49] = new Binding(this,function():*
         {
            return workoutsPerCycleGoals.value;
         },function(param1:*):void
         {
            user.cycleworkouts = param1;
         },"user.cycleworkouts");
         result[49].twoWayCounterpart = result[35];
         result[35].isTwoWayPrimary = true;
         result[35].twoWayCounterpart = result[49];
         return result;
      }
      
      private function _IFCalc_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         this.user.cycledays = this.daysPerCycle.value;
         this.user.cycleworkouts = this.workoutsPerCycle.value;
         this.user.cycledays = this.daysPerCycleGoals.value;
         this.user.cycleworkouts = this.workoutsPerCycleGoals.value;
      }
      
      mx_internal function _IFCalc_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         var conditions:Array = null;
         var condition:CSSCondition = null;
         var selector:CSSSelector = null;
         if(mx_internal::_IFCalc_StylesInit_done)
         {
            return;
         }
         mx_internal::_IFCalc_StylesInit_done = true;
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","severeunderweight");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".severeunderweight");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 3394815;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","underweight");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".underweight");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 3394815;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","normal");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".normal");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 2805034;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","overweight");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".overweight");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16770048;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","obesei");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".obesei");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16746496;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","obeseii");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".obeseii");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16724736;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","obeseiii");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".obeseiii");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16711680;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","positive");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".positive");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 255;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","zero");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".zero");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 0;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","negative");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".negative");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16711680;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","greentext");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".greentext");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 30720;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","good");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".good");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 65280;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","bad");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".bad");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16711680;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","calclbl");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".calclbl");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16776960;
            };
         }
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","headeralign");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".headeralign");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.textAlign = "center";
            };
         }
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("global",conditions,selector);
         style = styleManager.getStyleDeclaration("global");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontFamily = "Times New Roman";
            };
         }
         styleManager.initProtoChainRoots();
      }
      
      [Bindable(event="propertyChange")]
      public function get activityCMB0() : ComboBox
      {
         return this._1628271015activityCMB0;
      }
      
      public function set activityCMB0(param1:ComboBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1628271015activityCMB0;
         if(_loc2_ !== param1)
         {
            this._1628271015activityCMB0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"activityCMB0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get activityDESC() : String
      {
         return this._1628293664activityDESC;
      }
      
      public function set activityDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1628293664activityDESC;
         if(_loc2_ !== param1)
         {
            this._1628293664activityDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"activityDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get activityLBL0() : Label
      {
         return this._1628528873activityLBL0;
      }
      
      public function set activityLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1628528873activityLBL0;
         if(_loc2_ !== param1)
         {
            this._1628528873activityLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"activityLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ageDESC() : String
      {
         return this._1062283248ageDESC;
      }
      
      public function set ageDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1062283248ageDESC;
         if(_loc2_ !== param1)
         {
            this._1062283248ageDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ageDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ageLBL0() : Label
      {
         return this._1062048039ageLBL0;
      }
      
      public function set ageLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1062048039ageLBL0;
         if(_loc2_ !== param1)
         {
            this._1062048039ageLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ageLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ageLBL1() : Label
      {
         return this._1062048038ageLBL1;
      }
      
      public function set ageLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1062048038ageLBL1;
         if(_loc2_ !== param1)
         {
            this._1062048038ageLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ageLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ageTXT0() : TextInput
      {
         return this._1061788321ageTXT0;
      }
      
      public function set ageTXT0(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1061788321ageTXT0;
         if(_loc2_ !== param1)
         {
            this._1061788321ageTXT0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ageTXT0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bfGoals() : BorderContainer
      {
         return this._229805604bfGoals;
      }
      
      public function set bfGoals(param1:BorderContainer) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._229805604bfGoals;
         if(_loc2_ !== param1)
         {
            this._229805604bfGoals = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bfGoals",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bfcalcCHK0() : CheckBox
      {
         return this._1936696189bfcalcCHK0;
      }
      
      public function set bfcalcCHK0(param1:CheckBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1936696189bfcalcCHK0;
         if(_loc2_ !== param1)
         {
            this._1936696189bfcalcCHK0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bfcalcCHK0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bfcalcDESC() : String
      {
         return this._1936669014bfcalcDESC;
      }
      
      public function set bfcalcDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1936669014bfcalcDESC;
         if(_loc2_ !== param1)
         {
            this._1936669014bfcalcDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bfcalcDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bfpDifLBL() : Label
      {
         return this._995820223bfpDifLBL;
      }
      
      public function set bfpDifLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._995820223bfpDifLBL;
         if(_loc2_ !== param1)
         {
            this._995820223bfpDifLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bfpDifLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bfpToLBL() : Label
      {
         return this._1679761425bfpToLBL;
      }
      
      public function set bfpToLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1679761425bfpToLBL;
         if(_loc2_ !== param1)
         {
            this._1679761425bfpToLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bfpToLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bfpfield() : AdvancedDataGridColumn
      {
         return this._1663291442bfpfield;
      }
      
      public function set bfpfield(param1:AdvancedDataGridColumn) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1663291442bfpfield;
         if(_loc2_ !== param1)
         {
            this._1663291442bfpfield = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bfpfield",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmiDESC() : String
      {
         return this._689423bmiDESC;
      }
      
      public function set bmiDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._689423bmiDESC;
         if(_loc2_ !== param1)
         {
            this._689423bmiDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmiDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmiLBL0() : Label
      {
         return this._924632bmiLBL0;
      }
      
      public function set bmiLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._924632bmiLBL0;
         if(_loc2_ !== param1)
         {
            this._924632bmiLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmiLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmiLBL1() : Label
      {
         return this._924633bmiLBL1;
      }
      
      public function set bmiLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._924633bmiLBL1;
         if(_loc2_ !== param1)
         {
            this._924633bmiLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmiLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmiLBL2() : Label
      {
         return this._924634bmiLBL2;
      }
      
      public function set bmiLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._924634bmiLBL2;
         if(_loc2_ !== param1)
         {
            this._924634bmiLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmiLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmiTwinDESC() : String
      {
         return this._958811415bmiTwinDESC;
      }
      
      public function set bmiTwinDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._958811415bmiTwinDESC;
         if(_loc2_ !== param1)
         {
            this._958811415bmiTwinDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmiTwinDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmiTwinLBL0() : Label
      {
         return this._959046624bmiTwinLBL0;
      }
      
      public function set bmiTwinLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._959046624bmiTwinLBL0;
         if(_loc2_ !== param1)
         {
            this._959046624bmiTwinLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmiTwinLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmiTwinLBL1() : Label
      {
         return this._959046625bmiTwinLBL1;
      }
      
      public function set bmiTwinLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._959046625bmiTwinLBL1;
         if(_loc2_ !== param1)
         {
            this._959046625bmiTwinLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmiTwinLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmiTwinLBL2() : Label
      {
         return this._959046626bmiTwinLBL2;
      }
      
      public function set bmiTwinLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._959046626bmiTwinLBL2;
         if(_loc2_ !== param1)
         {
            this._959046626bmiTwinLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmiTwinLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrDESC() : String
      {
         return this._9001112bmrDESC;
      }
      
      public function set bmrDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._9001112bmrDESC;
         if(_loc2_ !== param1)
         {
            this._9001112bmrDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaAVDESC() : String
      {
         return this._625422053bmrFormulaAVDESC;
      }
      
      public function set bmrFormulaAVDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._625422053bmrFormulaAVDESC;
         if(_loc2_ !== param1)
         {
            this._625422053bmrFormulaAVDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaAVDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaAVRAB3() : RadioButton
      {
         return this._625834740bmrFormulaAVRAB3;
      }
      
      public function set bmrFormulaAVRAB3(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._625834740bmrFormulaAVRAB3;
         if(_loc2_ !== param1)
         {
            this._625834740bmrFormulaAVRAB3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaAVRAB3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaCUSDESC() : String
      {
         return this._326564493bmrFormulaCUSDESC;
      }
      
      public function set bmrFormulaCUSDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._326564493bmrFormulaCUSDESC;
         if(_loc2_ !== param1)
         {
            this._326564493bmrFormulaCUSDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaCUSDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaCUSRAB5() : RadioButton
      {
         return this._326151804bmrFormulaCUSRAB5;
      }
      
      public function set bmrFormulaCUSRAB5(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._326151804bmrFormulaCUSRAB5;
         if(_loc2_ !== param1)
         {
            this._326151804bmrFormulaCUSRAB5 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaCUSRAB5",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaHBDESC() : String
      {
         return this._807355690bmrFormulaHBDESC;
      }
      
      public function set bmrFormulaHBDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._807355690bmrFormulaHBDESC;
         if(_loc2_ !== param1)
         {
            this._807355690bmrFormulaHBDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaHBDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaHBRAB1() : RadioButton
      {
         return this._807768375bmrFormulaHBRAB1;
      }
      
      public function set bmrFormulaHBRAB1(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._807768375bmrFormulaHBRAB1;
         if(_loc2_ !== param1)
         {
            this._807768375bmrFormulaHBRAB1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaHBRAB1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaKMDESC() : String
      {
         return this._903401874bmrFormulaKMDESC;
      }
      
      public function set bmrFormulaKMDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._903401874bmrFormulaKMDESC;
         if(_loc2_ !== param1)
         {
            this._903401874bmrFormulaKMDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaKMDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaKMRAB2() : RadioButton
      {
         return this._903814560bmrFormulaKMRAB2;
      }
      
      public function set bmrFormulaKMRAB2(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._903814560bmrFormulaKMRAB2;
         if(_loc2_ !== param1)
         {
            this._903814560bmrFormulaKMRAB2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaKMRAB2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaMSJDESC() : String
      {
         return this._107032266bmrFormulaMSJDESC;
      }
      
      public function set bmrFormulaMSJDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._107032266bmrFormulaMSJDESC;
         if(_loc2_ !== param1)
         {
            this._107032266bmrFormulaMSJDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaMSJDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaMSJRAB0() : RadioButton
      {
         return this._106619582bmrFormulaMSJRAB0;
      }
      
      public function set bmrFormulaMSJRAB0(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._106619582bmrFormulaMSJRAB0;
         if(_loc2_ !== param1)
         {
            this._106619582bmrFormulaMSJRAB0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaMSJRAB0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaMULDESC() : String
      {
         return this._47926922bmrFormulaMULDESC;
      }
      
      public function set bmrFormulaMULDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._47926922bmrFormulaMULDESC;
         if(_loc2_ !== param1)
         {
            this._47926922bmrFormulaMULDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaMULDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrFormulaMULRAB4() : RadioButton
      {
         return this._47514234bmrFormulaMULRAB4;
      }
      
      public function set bmrFormulaMULRAB4(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._47514234bmrFormulaMULRAB4;
         if(_loc2_ !== param1)
         {
            this._47514234bmrFormulaMULRAB4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrFormulaMULRAB4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrGroup() : RadioButtonGroup
      {
         return this._283174200bmrGroup;
      }
      
      public function set bmrGroup(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._283174200bmrGroup;
         if(_loc2_ !== param1)
         {
            this._283174200bmrGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrLBL0() : Label
      {
         return this._9236321bmrLBL0;
      }
      
      public function set bmrLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._9236321bmrLBL0;
         if(_loc2_ !== param1)
         {
            this._9236321bmrLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrLBL1() : Label
      {
         return this._9236322bmrLBL1;
      }
      
      public function set bmrLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._9236322bmrLBL1;
         if(_loc2_ !== param1)
         {
            this._9236322bmrLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bmrLBL2() : Label
      {
         return this._9236323bmrLBL2;
      }
      
      public function set bmrLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._9236323bmrLBL2;
         if(_loc2_ !== param1)
         {
            this._9236323bmrLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bmrLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bodyfatDESC() : String
      {
         return this._1353557688bodyfatDESC;
      }
      
      public function set bodyfatDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1353557688bodyfatDESC;
         if(_loc2_ !== param1)
         {
            this._1353557688bodyfatDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bodyfatDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bodyfatLBL0() : Label
      {
         return this._1353322479bodyfatLBL0;
      }
      
      public function set bodyfatLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1353322479bodyfatLBL0;
         if(_loc2_ !== param1)
         {
            this._1353322479bodyfatLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bodyfatLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bodyfatLBL1() : Label
      {
         return this._1353322478bodyfatLBL1;
      }
      
      public function set bodyfatLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1353322478bodyfatLBL1;
         if(_loc2_ !== param1)
         {
            this._1353322478bodyfatLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bodyfatLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bodyfatLBL2() : Label
      {
         return this._1353322477bodyfatLBL2;
      }
      
      public function set bodyfatLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1353322477bodyfatLBL2;
         if(_loc2_ !== param1)
         {
            this._1353322477bodyfatLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bodyfatLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bodyfatTXT0() : TextInput
      {
         return this._1353062761bodyfatTXT0;
      }
      
      public function set bodyfatTXT0(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1353062761bodyfatTXT0;
         if(_loc2_ !== param1)
         {
            this._1353062761bodyfatTXT0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bodyfatTXT0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get customBMR() : TextInput
      {
         return this._1611527254customBMR;
      }
      
      public function set customBMR(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1611527254customBMR;
         if(_loc2_ !== param1)
         {
            this._1611527254customBMR = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"customBMR",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get customProteinRest() : TextInput
      {
         return this._185177658customProteinRest;
      }
      
      public function set customProteinRest(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._185177658customProteinRest;
         if(_loc2_ !== param1)
         {
            this._185177658customProteinRest = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"customProteinRest",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get customProteinWorkout() : TextInput
      {
         return this._1461840021customProteinWorkout;
      }
      
      public function set customProteinWorkout(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1461840021customProteinWorkout;
         if(_loc2_ !== param1)
         {
            this._1461840021customProteinWorkout = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"customProteinWorkout",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get customTDEE() : TextInput
      {
         return this._1581735423customTDEE;
      }
      
      public function set customTDEE(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1581735423customTDEE;
         if(_loc2_ !== param1)
         {
            this._1581735423customTDEE = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"customTDEE",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cycleCalsLBL() : Label
      {
         return this._556358325cycleCalsLBL;
      }
      
      public function set cycleCalsLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._556358325cycleCalsLBL;
         if(_loc2_ !== param1)
         {
            this._556358325cycleCalsLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cycleCalsLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cycleChangeLBL() : Label
      {
         return this._235560352cycleChangeLBL;
      }
      
      public function set cycleChangeLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._235560352cycleChangeLBL;
         if(_loc2_ !== param1)
         {
            this._235560352cycleChangeLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cycleChangeLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cycleOverUnderLBL() : Label
      {
         return this._1149838520cycleOverUnderLBL;
      }
      
      public function set cycleOverUnderLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1149838520cycleOverUnderLBL;
         if(_loc2_ !== param1)
         {
            this._1149838520cycleOverUnderLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cycleOverUnderLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cycleTdeeLBL() : Label
      {
         return this._1725308096cycleTdeeLBL;
      }
      
      public function set cycleTdeeLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1725308096cycleTdeeLBL;
         if(_loc2_ !== param1)
         {
            this._1725308096cycleTdeeLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cycleTdeeLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cycleTdeeLBL0() : Label
      {
         return this._1944943472cycleTdeeLBL0;
      }
      
      public function set cycleTdeeLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1944943472cycleTdeeLBL0;
         if(_loc2_ !== param1)
         {
            this._1944943472cycleTdeeLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cycleTdeeLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get daySplitCombo() : ComboBox
      {
         return this._694512816daySplitCombo;
      }
      
      public function set daySplitCombo(param1:ComboBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._694512816daySplitCombo;
         if(_loc2_ !== param1)
         {
            this._694512816daySplitCombo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"daySplitCombo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get daysPerCycle() : NumericStepper
      {
         return this._1725616320daysPerCycle;
      }
      
      public function set daysPerCycle(param1:NumericStepper) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1725616320daysPerCycle;
         if(_loc2_ !== param1)
         {
            this._1725616320daysPerCycle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"daysPerCycle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get daysPerCycleGoals() : NumericStepper
      {
         return this._82654112daysPerCycleGoals;
      }
      
      public function set daysPerCycleGoals(param1:NumericStepper) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._82654112daysPerCycleGoals;
         if(_loc2_ !== param1)
         {
            this._82654112daysPerCycleGoals = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"daysPerCycleGoals",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get disclaimerCB() : CheckBox
      {
         return this._1103199430disclaimerCB;
      }
      
      public function set disclaimerCB(param1:CheckBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1103199430disclaimerCB;
         if(_loc2_ !== param1)
         {
            this._1103199430disclaimerCB = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"disclaimerCB",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get disclaimerTab() : NavigatorContent
      {
         return this._160573434disclaimerTab;
      }
      
      public function set disclaimerTab(param1:NavigatorContent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._160573434disclaimerTab;
         if(_loc2_ !== param1)
         {
            this._160573434disclaimerTab = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"disclaimerTab",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fatDifLBL() : Label
      {
         return this._504773138fatDifLBL;
      }
      
      public function set fatDifLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._504773138fatDifLBL;
         if(_loc2_ !== param1)
         {
            this._504773138fatDifLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fatDifLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fatToLBL() : Label
      {
         return this._968478114fatToLBL;
      }
      
      public function set fatToLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._968478114fatToLBL;
         if(_loc2_ !== param1)
         {
            this._968478114fatToLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fatToLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fatfield() : AdvancedDataGridColumn
      {
         return this._984948097fatfield;
      }
      
      public function set fatfield(param1:AdvancedDataGridColumn) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._984948097fatfield;
         if(_loc2_ !== param1)
         {
            this._984948097fatfield = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fatfield",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fbmDESC() : String
      {
         return this._1055489726fbmDESC;
      }
      
      public function set fbmDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1055489726fbmDESC;
         if(_loc2_ !== param1)
         {
            this._1055489726fbmDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fbmDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fbmLBL0() : Label
      {
         return this._1055254517fbmLBL0;
      }
      
      public function set fbmLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1055254517fbmLBL0;
         if(_loc2_ !== param1)
         {
            this._1055254517fbmLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fbmLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fbmLBL1() : Label
      {
         return this._1055254516fbmLBL1;
      }
      
      public function set fbmLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1055254516fbmLBL1;
         if(_loc2_ !== param1)
         {
            this._1055254516fbmLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fbmLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fbmLBL2() : Label
      {
         return this._1055254515fbmLBL2;
      }
      
      public function set fbmLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1055254515fbmLBL2;
         if(_loc2_ !== param1)
         {
            this._1055254515fbmLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fbmLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gainLoseAmt() : NumericStepper
      {
         return this._1659999732gainLoseAmt;
      }
      
      public function set gainLoseAmt(param1:NumericStepper) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1659999732gainLoseAmt;
         if(_loc2_ !== param1)
         {
            this._1659999732gainLoseAmt = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gainLoseAmt",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gainLoseTEXT() : Label
      {
         return this._79089055gainLoseTEXT;
      }
      
      public function set gainLoseTEXT(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._79089055gainLoseTEXT;
         if(_loc2_ !== param1)
         {
            this._79089055gainLoseTEXT = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gainLoseTEXT",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get genderDESC() : String
      {
         return this._939745070genderDESC;
      }
      
      public function set genderDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._939745070genderDESC;
         if(_loc2_ !== param1)
         {
            this._939745070genderDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"genderDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get genderGroup() : RadioButtonGroup
      {
         return this._936813630genderGroup;
      }
      
      public function set genderGroup(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._936813630genderGroup;
         if(_loc2_ !== param1)
         {
            this._936813630genderGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"genderGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get genderLBL0() : Label
      {
         return this._939509861genderLBL0;
      }
      
      public function set genderLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._939509861genderLBL0;
         if(_loc2_ !== param1)
         {
            this._939509861genderLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"genderLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get genderRAB0() : RadioButton
      {
         return this._939332386genderRAB0;
      }
      
      public function set genderRAB0(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._939332386genderRAB0;
         if(_loc2_ !== param1)
         {
            this._939332386genderRAB0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"genderRAB0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get genderRAB1() : RadioButton
      {
         return this._939332385genderRAB1;
      }
      
      public function set genderRAB1(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._939332385genderRAB1;
         if(_loc2_ !== param1)
         {
            this._939332385genderRAB1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"genderRAB1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalCSVBTN0() : ToggleButton
      {
         return this._1065868775goalCSVBTN0;
      }
      
      public function set goalCSVBTN0(param1:ToggleButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1065868775goalCSVBTN0;
         if(_loc2_ !== param1)
         {
            this._1065868775goalCSVBTN0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalCSVBTN0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalChangeRateDisplayLBL() : Label
      {
         return this._1826232809goalChangeRateDisplayLBL;
      }
      
      public function set goalChangeRateDisplayLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1826232809goalChangeRateDisplayLBL;
         if(_loc2_ !== param1)
         {
            this._1826232809goalChangeRateDisplayLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalChangeRateDisplayLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalChart() : BorderContainer
      {
         return this._2039733387goalChart;
      }
      
      public function set goalChart(param1:BorderContainer) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2039733387goalChart;
         if(_loc2_ !== param1)
         {
            this._2039733387goalChart = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalChart",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalChartFieldFat() : RadioButton
      {
         return this._1402641770goalChartFieldFat;
      }
      
      public function set goalChartFieldFat(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1402641770goalChartFieldFat;
         if(_loc2_ !== param1)
         {
            this._1402641770goalChartFieldFat = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalChartFieldFat",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalChartFieldWeight() : RadioButton
      {
         return this._854311559goalChartFieldWeight;
      }
      
      public function set goalChartFieldWeight(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._854311559goalChartFieldWeight;
         if(_loc2_ !== param1)
         {
            this._854311559goalChartFieldWeight = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalChartFieldWeight",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalChartFieldsGroup() : RadioButtonGroup
      {
         return this._1628498363goalChartFieldsGroup;
      }
      
      public function set goalChartFieldsGroup(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1628498363goalChartFieldsGroup;
         if(_loc2_ !== param1)
         {
            this._1628498363goalChartFieldsGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalChartFieldsGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalChartLegend() : Legend
      {
         return this._625936264goalChartLegend;
      }
      
      public function set goalChartLegend(param1:Legend) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._625936264goalChartLegend;
         if(_loc2_ !== param1)
         {
            this._625936264goalChartLegend = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalChartLegend",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalExportTXA0() : spark.components.TextArea
      {
         return this._1994360134goalExportTXA0;
      }
      
      public function set goalExportTXA0(param1:spark.components.TextArea) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1994360134goalExportTXA0;
         if(_loc2_ !== param1)
         {
            this._1994360134goalExportTXA0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalExportTXA0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalGraphBTN() : ToggleButton
      {
         return this._835701151goalGraphBTN;
      }
      
      public function set goalGraphBTN(param1:ToggleButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._835701151goalGraphBTN;
         if(_loc2_ !== param1)
         {
            this._835701151goalGraphBTN = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalGraphBTN",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalLineChart() : LineChart
      {
         return this._784992649goalLineChart;
      }
      
      public function set goalLineChart(param1:LineChart) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._784992649goalLineChart;
         if(_loc2_ !== param1)
         {
            this._784992649goalLineChart = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalLineChart",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalSeriesFat() : LineSeries
      {
         return this._467686223goalSeriesFat;
      }
      
      public function set goalSeriesFat(param1:LineSeries) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._467686223goalSeriesFat;
         if(_loc2_ !== param1)
         {
            this._467686223goalSeriesFat = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalSeriesFat",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalSeriesLBM() : LineSeries
      {
         return this._467690989goalSeriesLBM;
      }
      
      public function set goalSeriesLBM(param1:LineSeries) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._467690989goalSeriesLBM;
         if(_loc2_ !== param1)
         {
            this._467690989goalSeriesLBM = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalSeriesLBM",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalSeriesWeight() : LineSeries
      {
         return this._456525442goalSeriesWeight;
      }
      
      public function set goalSeriesWeight(param1:LineSeries) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._456525442goalSeriesWeight;
         if(_loc2_ !== param1)
         {
            this._456525442goalSeriesWeight = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalSeriesWeight",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalTable() : BorderContainer
      {
         return this._2055225467goalTable;
      }
      
      public function set goalTable(param1:BorderContainer) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2055225467goalTable;
         if(_loc2_ !== param1)
         {
            this._2055225467goalTable = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalTable",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalVertAxis() : LinearAxis
      {
         return this._1373284517goalVertAxis;
      }
      
      public function set goalVertAxis(param1:LinearAxis) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1373284517goalVertAxis;
         if(_loc2_ !== param1)
         {
            this._1373284517goalVertAxis = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalVertAxis",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalXMLBTN0() : ToggleButton
      {
         return this._1952400520goalXMLBTN0;
      }
      
      public function set goalXMLBTN0(param1:ToggleButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1952400520goalXMLBTN0;
         if(_loc2_ !== param1)
         {
            this._1952400520goalXMLBTN0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalXMLBTN0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalsCyclesToComplete() : Label
      {
         return this._1338328289goalsCyclesToComplete;
      }
      
      public function set goalsCyclesToComplete(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1338328289goalsCyclesToComplete;
         if(_loc2_ !== param1)
         {
            this._1338328289goalsCyclesToComplete = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalsCyclesToComplete",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalsCyclesToCompleteLBL() : Label
      {
         return this._43276011goalsCyclesToCompleteLBL;
      }
      
      public function set goalsCyclesToCompleteLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._43276011goalsCyclesToCompleteLBL;
         if(_loc2_ !== param1)
         {
            this._43276011goalsCyclesToCompleteLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalsCyclesToCompleteLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalsDaysToComplete() : Label
      {
         return this._1215112299goalsDaysToComplete;
      }
      
      public function set goalsDaysToComplete(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1215112299goalsDaysToComplete;
         if(_loc2_ !== param1)
         {
            this._1215112299goalsDaysToComplete = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalsDaysToComplete",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalsFinishDate() : Label
      {
         return this._1395850945goalsFinishDate;
      }
      
      public function set goalsFinishDate(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1395850945goalsFinishDate;
         if(_loc2_ !== param1)
         {
            this._1395850945goalsFinishDate = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalsFinishDate",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goalsTab() : NavigatorContent
      {
         return this._1729776565goalsTab;
      }
      
      public function set goalsTab(param1:NavigatorContent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1729776565goalsTab;
         if(_loc2_ !== param1)
         {
            this._1729776565goalsTab = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalsTab",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get heightDESC() : String
      {
         return this._1489869880heightDESC;
      }
      
      public function set heightDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1489869880heightDESC;
         if(_loc2_ !== param1)
         {
            this._1489869880heightDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heightDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get heightLBL0() : Label
      {
         return this._1490105089heightLBL0;
      }
      
      public function set heightLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1490105089heightLBL0;
         if(_loc2_ !== param1)
         {
            this._1490105089heightLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heightLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get heightLBL1() : Label
      {
         return this._1490105090heightLBL1;
      }
      
      public function set heightLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1490105090heightLBL1;
         if(_loc2_ !== param1)
         {
            this._1490105090heightLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heightLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get heightTXT0() : TextInput
      {
         return this._1490364807heightTXT0;
      }
      
      public function set heightTXT0(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1490364807heightTXT0;
         if(_loc2_ !== param1)
         {
            this._1490364807heightTXT0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heightTXT0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ifTabNav() : TabNavigator
      {
         return this._1139981515ifTabNav;
      }
      
      public function set ifTabNav(param1:TabNavigator) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1139981515ifTabNav;
         if(_loc2_ !== param1)
         {
            this._1139981515ifTabNav = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ifTabNav",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get inchesDESC() : String
      {
         return this._1139900681inchesDESC;
      }
      
      public function set inchesDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1139900681inchesDESC;
         if(_loc2_ !== param1)
         {
            this._1139900681inchesDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"inchesDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get inchesLBL0() : Label
      {
         return this._1140135890inchesLBL0;
      }
      
      public function set inchesLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1140135890inchesLBL0;
         if(_loc2_ !== param1)
         {
            this._1140135890inchesLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"inchesLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get inchesTXT0() : TextInput
      {
         return this._1140395608inchesTXT0;
      }
      
      public function set inchesTXT0(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1140395608inchesTXT0;
         if(_loc2_ !== param1)
         {
            this._1140395608inchesTXT0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"inchesTXT0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get infoTab() : NavigatorContent
      {
         return this._1945402375infoTab;
      }
      
      public function set infoTab(param1:NavigatorContent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1945402375infoTab;
         if(_loc2_ !== param1)
         {
            this._1945402375infoTab = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"infoTab",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbmDESC() : String
      {
         return this._25434936lbmDESC;
      }
      
      public function set lbmDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._25434936lbmDESC;
         if(_loc2_ !== param1)
         {
            this._25434936lbmDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbmDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbmDifLBL() : Label
      {
         return this._1360653836lbmDifLBL;
      }
      
      public function set lbmDifLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1360653836lbmDifLBL;
         if(_loc2_ !== param1)
         {
            this._1360653836lbmDifLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbmDifLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbmLBL0() : Label
      {
         return this._25199727lbmLBL0;
      }
      
      public function set lbmLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._25199727lbmLBL0;
         if(_loc2_ !== param1)
         {
            this._25199727lbmLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbmLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbmLBL1() : Label
      {
         return this._25199726lbmLBL1;
      }
      
      public function set lbmLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._25199726lbmLBL1;
         if(_loc2_ !== param1)
         {
            this._25199726lbmLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbmLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbmLBL2() : Label
      {
         return this._25199725lbmLBL2;
      }
      
      public function set lbmLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._25199725lbmLBL2;
         if(_loc2_ !== param1)
         {
            this._25199725lbmLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbmLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbmToLBL() : Label
      {
         return this._772462140lbmToLBL;
      }
      
      public function set lbmToLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._772462140lbmToLBL;
         if(_loc2_ !== param1)
         {
            this._772462140lbmToLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbmToLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbmfield() : AdvancedDataGridColumn
      {
         return this._755992157lbmfield;
      }
      
      public function set lbmfield(param1:AdvancedDataGridColumn) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._755992157lbmfield;
         if(_loc2_ !== param1)
         {
            this._755992157lbmfield = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbmfield",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lifestyleTab() : NavigatorContent
      {
         return this._1676184800lifestyleTab;
      }
      
      public function set lifestyleTab(param1:NavigatorContent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1676184800lifestyleTab;
         if(_loc2_ !== param1)
         {
            this._1676184800lifestyleTab = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lifestyleTab",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get macroCalcTab() : NavigatorContent
      {
         return this._1095397484macroCalcTab;
      }
      
      public function set macroCalcTab(param1:NavigatorContent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1095397484macroCalcTab;
         if(_loc2_ !== param1)
         {
            this._1095397484macroCalcTab = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"macroCalcTab",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get macroSplitCombo() : ComboBox
      {
         return this._1902784384macroSplitCombo;
      }
      
      public function set macroSplitCombo(param1:ComboBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1902784384macroSplitCombo;
         if(_loc2_ !== param1)
         {
            this._1902784384macroSplitCombo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"macroSplitCombo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get maintainChangerate() : RadioButton
      {
         return this._900294779maintainChangerate;
      }
      
      public function set maintainChangerate(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._900294779maintainChangerate;
         if(_loc2_ !== param1)
         {
            this._900294779maintainChangerate = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maintainChangerate",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get maintainSchedule() : RadioButtonGroup
      {
         return this._529403582maintainSchedule;
      }
      
      public function set maintainSchedule(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._529403582maintainSchedule;
         if(_loc2_ !== param1)
         {
            this._529403582maintainSchedule = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maintainSchedule",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get maintainTdee() : RadioButton
      {
         return this._1870244667maintainTdee;
      }
      
      public function set maintainTdee(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1870244667maintainTdee;
         if(_loc2_ !== param1)
         {
            this._1870244667maintainTdee = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maintainTdee",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mealsTab() : NavigatorContent
      {
         return this._983365531mealsTab;
      }
      
      public function set mealsTab(param1:NavigatorContent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._983365531mealsTab;
         if(_loc2_ !== param1)
         {
            this._983365531mealsTab = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mealsTab",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get measureGroup() : RadioButtonGroup
      {
         return this._396948543measureGroup;
      }
      
      public function set measureGroup(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._396948543measureGroup;
         if(_loc2_ !== param1)
         {
            this._396948543measureGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"measureGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get measureImperial() : RadioButton
      {
         return this._1908007353measureImperial;
      }
      
      public function set measureImperial(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1908007353measureImperial;
         if(_loc2_ !== param1)
         {
            this._1908007353measureImperial = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"measureImperial",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get measureMetric() : RadioButton
      {
         return this._739412142measureMetric;
      }
      
      public function set measureMetric(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._739412142measureMetric;
         if(_loc2_ !== param1)
         {
            this._739412142measureMetric = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"measureMetric",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mfmDESC() : String
      {
         return this._976585349mfmDESC;
      }
      
      public function set mfmDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._976585349mfmDESC;
         if(_loc2_ !== param1)
         {
            this._976585349mfmDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mfmDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mfmLBL0() : Label
      {
         return this._976820558mfmLBL0;
      }
      
      public function set mfmLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._976820558mfmLBL0;
         if(_loc2_ !== param1)
         {
            this._976820558mfmLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mfmLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mfmLBL1() : Label
      {
         return this._976820559mfmLBL1;
      }
      
      public function set mfmLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._976820559mfmLBL1;
         if(_loc2_ !== param1)
         {
            this._976820559mfmLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mfmLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mfmLBL2() : Label
      {
         return this._976820560mfmLBL2;
      }
      
      public function set mfmLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._976820560mfmLBL2;
         if(_loc2_ !== param1)
         {
            this._976820560mfmLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mfmLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get minCalsDESC() : String
      {
         return this._1188187880minCalsDESC;
      }
      
      public function set minCalsDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1188187880minCalsDESC;
         if(_loc2_ !== param1)
         {
            this._1188187880minCalsDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"minCalsDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get minCalsLBL0() : Label
      {
         return this._1188423089minCalsLBL0;
      }
      
      public function set minCalsLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1188423089minCalsLBL0;
         if(_loc2_ !== param1)
         {
            this._1188423089minCalsLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"minCalsLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get minCalsLBL1() : Label
      {
         return this._1188423090minCalsLBL1;
      }
      
      public function set minCalsLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1188423090minCalsLBL1;
         if(_loc2_ !== param1)
         {
            this._1188423090minCalsLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"minCalsLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get minCalsLBL2() : Label
      {
         return this._1188423091minCalsLBL2;
      }
      
      public function set minCalsLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1188423091minCalsLBL2;
         if(_loc2_ !== param1)
         {
            this._1188423091minCalsLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"minCalsLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get nextBTN() : Button
      {
         return this._1847045737nextBTN;
      }
      
      public function set nextBTN(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1847045737nextBTN;
         if(_loc2_ !== param1)
         {
            this._1847045737nextBTN = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"nextBTN",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get prevBTN() : Button
      {
         return this._318222551prevBTN;
      }
      
      public function set prevBTN(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._318222551prevBTN;
         if(_loc2_ !== param1)
         {
            this._318222551prevBTN = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"prevBTN",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get proteinCombo() : ComboBox
      {
         return this._877175755proteinCombo;
      }
      
      public function set proteinCombo(param1:ComboBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._877175755proteinCombo;
         if(_loc2_ !== param1)
         {
            this._877175755proteinCombo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"proteinCombo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get recalcFatLossPct() : NumericStepper
      {
         return this._156503411recalcFatLossPct;
      }
      
      public function set recalcFatLossPct(param1:NumericStepper) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._156503411recalcFatLossPct;
         if(_loc2_ !== param1)
         {
            this._156503411recalcFatLossPct = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"recalcFatLossPct",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get recalcWeight() : NumericStepper
      {
         return this._1276575840recalcWeight;
      }
      
      public function set recalcWeight(param1:NumericStepper) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1276575840recalcWeight;
         if(_loc2_ !== param1)
         {
            this._1276575840recalcWeight = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"recalcWeight",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restCalsDifLBL() : Label
      {
         return this._931755218restCalsDifLBL;
      }
      
      public function set restCalsDifLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._931755218restCalsDifLBL;
         if(_loc2_ !== param1)
         {
            this._931755218restCalsDifLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restCalsDifLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restCalsLBL() : Label
      {
         return this._544843107restCalsLBL;
      }
      
      public function set restCalsLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._544843107restCalsLBL;
         if(_loc2_ !== param1)
         {
            this._544843107restCalsLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restCalsLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restCarbSliderMax() : Label
      {
         return this._282516961restCarbSliderMax;
      }
      
      public function set restCarbSliderMax(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._282516961restCarbSliderMax;
         if(_loc2_ !== param1)
         {
            this._282516961restCarbSliderMax = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restCarbSliderMax",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restCarbsSlider() : HSlider
      {
         return this._1797127154restCarbsSlider;
      }
      
      public function set restCarbsSlider(param1:HSlider) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1797127154restCarbsSlider;
         if(_loc2_ !== param1)
         {
            this._1797127154restCarbsSlider = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restCarbsSlider",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restDayChart() : PieChart
      {
         return this._1933708906restDayChart;
      }
      
      public function set restDayChart(param1:PieChart) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1933708906restDayChart;
         if(_loc2_ !== param1)
         {
            this._1933708906restDayChart = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restDayChart",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restDayTdeePct() : NumericStepper
      {
         return this._776967319restDayTdeePct;
      }
      
      public function set restDayTdeePct(param1:NumericStepper) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._776967319restDayTdeePct;
         if(_loc2_ !== param1)
         {
            this._776967319restDayTdeePct = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restDayTdeePct",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restFatSlider() : HSlider
      {
         return this._1184058342restFatSlider;
      }
      
      public function set restFatSlider(param1:HSlider) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1184058342restFatSlider;
         if(_loc2_ !== param1)
         {
            this._1184058342restFatSlider = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restFatSlider",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restFatSliderMax() : Label
      {
         return this._284258402restFatSliderMax;
      }
      
      public function set restFatSliderMax(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._284258402restFatSliderMax;
         if(_loc2_ !== param1)
         {
            this._284258402restFatSliderMax = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restFatSliderMax",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restMeals() : AdvancedDataGrid
      {
         return this._1877254756restMeals;
      }
      
      public function set restMeals(param1:AdvancedDataGrid) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1877254756restMeals;
         if(_loc2_ !== param1)
         {
            this._1877254756restMeals = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restMeals",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restMeals0() : AdvancedDataGrid
      {
         return this._1934644756restMeals0;
      }
      
      public function set restMeals0(param1:AdvancedDataGrid) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1934644756restMeals0;
         if(_loc2_ !== param1)
         {
            this._1934644756restMeals0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restMeals0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restMeals1() : AdvancedDataGrid
      {
         return this._1934644757restMeals1;
      }
      
      public function set restMeals1(param1:AdvancedDataGrid) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1934644757restMeals1;
         if(_loc2_ !== param1)
         {
            this._1934644757restMeals1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restMeals1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restPctTdeeLBL() : Label
      {
         return this._1715774297restPctTdeeLBL;
      }
      
      public function set restPctTdeeLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1715774297restPctTdeeLBL;
         if(_loc2_ !== param1)
         {
            this._1715774297restPctTdeeLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restPctTdeeLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get restProteinSlider() : HSlider
      {
         return this._1070463696restProteinSlider;
      }
      
      public function set restProteinSlider(param1:HSlider) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1070463696restProteinSlider;
         if(_loc2_ !== param1)
         {
            this._1070463696restProteinSlider = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restProteinSlider",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scheduleDG() : AdvancedDataGrid
      {
         return this._687058598scheduleDG;
      }
      
      public function set scheduleDG(param1:AdvancedDataGrid) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._687058598scheduleDG;
         if(_loc2_ !== param1)
         {
            this._687058598scheduleDG = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scheduleDG",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get simpleMulBMR() : TextInput
      {
         return this._1548967051simpleMulBMR;
      }
      
      public function set simpleMulBMR(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1548967051simpleMulBMR;
         if(_loc2_ !== param1)
         {
            this._1548967051simpleMulBMR = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"simpleMulBMR",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get simpleMulTDEE() : TextInput
      {
         return this._772811070simpleMulTDEE;
      }
      
      public function set simpleMulTDEE(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._772811070simpleMulTDEE;
         if(_loc2_ !== param1)
         {
            this._772811070simpleMulTDEE = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"simpleMulTDEE",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get startDate() : DateField
      {
         return this._2129778896startDate;
      }
      
      public function set startDate(param1:DateField) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2129778896startDate;
         if(_loc2_ !== param1)
         {
            this._2129778896startDate = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startDate",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get superToolTipTA() : mx.controls.TextArea
      {
         return this._1154359211superToolTipTA;
      }
      
      public function set superToolTipTA(param1:mx.controls.TextArea) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1154359211superToolTipTA;
         if(_loc2_ !== param1)
         {
            this._1154359211superToolTipTA = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"superToolTipTA",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeDESC() : String
      {
         return this._1845505441tdeeDESC;
      }
      
      public function set tdeeDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1845505441tdeeDESC;
         if(_loc2_ !== param1)
         {
            this._1845505441tdeeDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeFormulaCALDESC() : String
      {
         return this._524266935tdeeFormulaCALDESC;
      }
      
      public function set tdeeFormulaCALDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._524266935tdeeFormulaCALDESC;
         if(_loc2_ !== param1)
         {
            this._524266935tdeeFormulaCALDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeFormulaCALDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeFormulaCALRAB0() : RadioButton
      {
         return this._523854251tdeeFormulaCALRAB0;
      }
      
      public function set tdeeFormulaCALRAB0(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._523854251tdeeFormulaCALRAB0;
         if(_loc2_ !== param1)
         {
            this._523854251tdeeFormulaCALRAB0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeFormulaCALRAB0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeFormulaCUSDESC() : String
      {
         return this._54780732tdeeFormulaCUSDESC;
      }
      
      public function set tdeeFormulaCUSDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._54780732tdeeFormulaCUSDESC;
         if(_loc2_ !== param1)
         {
            this._54780732tdeeFormulaCUSDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeFormulaCUSDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeFormulaCUSRAB2() : RadioButton
      {
         return this._55193418tdeeFormulaCUSRAB2;
      }
      
      public function set tdeeFormulaCUSRAB2(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._55193418tdeeFormulaCUSRAB2;
         if(_loc2_ !== param1)
         {
            this._55193418tdeeFormulaCUSRAB2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeFormulaCUSRAB2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeFormulaMULDESC() : String
      {
         return this._333418303tdeeFormulaMULDESC;
      }
      
      public function set tdeeFormulaMULDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._333418303tdeeFormulaMULDESC;
         if(_loc2_ !== param1)
         {
            this._333418303tdeeFormulaMULDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeFormulaMULDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeFormulaMULRAB1() : RadioButton
      {
         return this._333830988tdeeFormulaMULRAB1;
      }
      
      public function set tdeeFormulaMULRAB1(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._333830988tdeeFormulaMULRAB1;
         if(_loc2_ !== param1)
         {
            this._333830988tdeeFormulaMULRAB1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeFormulaMULRAB1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeGroup() : RadioButtonGroup
      {
         return this._1380233551tdeeGroup;
      }
      
      public function set tdeeGroup(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1380233551tdeeGroup;
         if(_loc2_ !== param1)
         {
            this._1380233551tdeeGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeLBL0() : Label
      {
         return this._1845740650tdeeLBL0;
      }
      
      public function set tdeeLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1845740650tdeeLBL0;
         if(_loc2_ !== param1)
         {
            this._1845740650tdeeLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeLBL1() : Label
      {
         return this._1845740651tdeeLBL1;
      }
      
      public function set tdeeLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1845740651tdeeLBL1;
         if(_loc2_ !== param1)
         {
            this._1845740651tdeeLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tdeeLBL2() : Label
      {
         return this._1845740652tdeeLBL2;
      }
      
      public function set tdeeLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1845740652tdeeLBL2;
         if(_loc2_ !== param1)
         {
            this._1845740652tdeeLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tdeeLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get waistDESC() : String
      {
         return this._984624111waistDESC;
      }
      
      public function set waistDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._984624111waistDESC;
         if(_loc2_ !== param1)
         {
            this._984624111waistDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"waistDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get waistLBL0() : Label
      {
         return this._984388902waistLBL0;
      }
      
      public function set waistLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._984388902waistLBL0;
         if(_loc2_ !== param1)
         {
            this._984388902waistLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"waistLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get waistLBL1() : Label
      {
         return this._984388901waistLBL1;
      }
      
      public function set waistLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._984388901waistLBL1;
         if(_loc2_ !== param1)
         {
            this._984388901waistLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"waistLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get waistLBL2() : Label
      {
         return this._984388900waistLBL2;
      }
      
      public function set waistLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._984388900waistLBL2;
         if(_loc2_ !== param1)
         {
            this._984388900waistLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"waistLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get waistTXT0() : TextInput
      {
         return this._984129184waistTXT0;
      }
      
      public function set waistTXT0(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._984129184waistTXT0;
         if(_loc2_ !== param1)
         {
            this._984129184waistTXT0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"waistTXT0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get weightDESC() : String
      {
         return this._1457832695weightDESC;
      }
      
      public function set weightDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1457832695weightDESC;
         if(_loc2_ !== param1)
         {
            this._1457832695weightDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get weightDifLBL() : Label
      {
         return this._784057843weightDifLBL;
      }
      
      public function set weightDifLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._784057843weightDifLBL;
         if(_loc2_ !== param1)
         {
            this._784057843weightDifLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightDifLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get weightLBL0() : Label
      {
         return this._1457597486weightLBL0;
      }
      
      public function set weightLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1457597486weightLBL0;
         if(_loc2_ !== param1)
         {
            this._1457597486weightLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get weightLBL1() : Label
      {
         return this._1457597485weightLBL1;
      }
      
      public function set weightLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1457597485weightLBL1;
         if(_loc2_ !== param1)
         {
            this._1457597485weightLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get weightTXT0() : TextInput
      {
         return this._1457337768weightTXT0;
      }
      
      public function set weightTXT0(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1457337768weightTXT0;
         if(_loc2_ !== param1)
         {
            this._1457337768weightTXT0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightTXT0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get weightToLBL() : Label
      {
         return this._2067847587weightToLBL;
      }
      
      public function set weightToLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2067847587weightToLBL;
         if(_loc2_ !== param1)
         {
            this._2067847587weightToLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightToLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutCalsDifLBL() : Label
      {
         return this._1288850103workoutCalsDifLBL;
      }
      
      public function set workoutCalsDifLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1288850103workoutCalsDifLBL;
         if(_loc2_ !== param1)
         {
            this._1288850103workoutCalsDifLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutCalsDifLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutCalsLBL() : Label
      {
         return this._1454436276workoutCalsLBL;
      }
      
      public function set workoutCalsLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1454436276workoutCalsLBL;
         if(_loc2_ !== param1)
         {
            this._1454436276workoutCalsLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutCalsLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutCarbSliderMax() : Label
      {
         return this._1045625416workoutCarbSliderMax;
      }
      
      public function set workoutCarbSliderMax(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1045625416workoutCarbSliderMax;
         if(_loc2_ !== param1)
         {
            this._1045625416workoutCarbSliderMax = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutCarbSliderMax",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutCarbsSlider() : HSlider
      {
         return this._1916415369workoutCarbsSlider;
      }
      
      public function set workoutCarbsSlider(param1:HSlider) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1916415369workoutCarbsSlider;
         if(_loc2_ !== param1)
         {
            this._1916415369workoutCarbsSlider = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutCarbsSlider",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutDayChart() : PieChart
      {
         return this._85590177workoutDayChart;
      }
      
      public function set workoutDayChart(param1:PieChart) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._85590177workoutDayChart;
         if(_loc2_ !== param1)
         {
            this._85590177workoutDayChart = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutDayChart",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutDayTdeePct() : NumericStepper
      {
         return this._1443638002workoutDayTdeePct;
      }
      
      public function set workoutDayTdeePct(param1:NumericStepper) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1443638002workoutDayTdeePct;
         if(_loc2_ !== param1)
         {
            this._1443638002workoutDayTdeePct = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutDayTdeePct",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutFatSlider() : HSlider
      {
         return this._1653803203workoutFatSlider;
      }
      
      public function set workoutFatSlider(param1:HSlider) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1653803203workoutFatSlider;
         if(_loc2_ !== param1)
         {
            this._1653803203workoutFatSlider = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutFatSlider",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutFatSliderMax() : Label
      {
         return this._881291033workoutFatSliderMax;
      }
      
      public function set workoutFatSliderMax(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._881291033workoutFatSliderMax;
         if(_loc2_ !== param1)
         {
            this._881291033workoutFatSliderMax = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutFatSliderMax",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutPctTdeeLBL() : Label
      {
         return this._358587678workoutPctTdeeLBL;
      }
      
      public function set workoutPctTdeeLBL(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._358587678workoutPctTdeeLBL;
         if(_loc2_ !== param1)
         {
            this._358587678workoutPctTdeeLBL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutPctTdeeLBL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutProteinSlider() : HSlider
      {
         return this._257678681workoutProteinSlider;
      }
      
      public function set workoutProteinSlider(param1:HSlider) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._257678681workoutProteinSlider;
         if(_loc2_ !== param1)
         {
            this._257678681workoutProteinSlider = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutProteinSlider",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutsPerCycle() : NumericStepper
      {
         return this._525418145workoutsPerCycle;
      }
      
      public function set workoutsPerCycle(param1:NumericStepper) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._525418145workoutsPerCycle;
         if(_loc2_ !== param1)
         {
            this._525418145workoutsPerCycle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutsPerCycle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get workoutsPerCycleGoals() : NumericStepper
      {
         return this._1503311265workoutsPerCycleGoals;
      }
      
      public function set workoutsPerCycleGoals(param1:NumericStepper) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1503311265workoutsPerCycleGoals;
         if(_loc2_ !== param1)
         {
            this._1503311265workoutsPerCycleGoals = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutsPerCycleGoals",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wthRatioDESC() : String
      {
         return this._721142735wthRatioDESC;
      }
      
      public function set wthRatioDESC(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._721142735wthRatioDESC;
         if(_loc2_ !== param1)
         {
            this._721142735wthRatioDESC = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wthRatioDESC",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wthRatioLBL0() : Label
      {
         return this._720907526wthRatioLBL0;
      }
      
      public function set wthRatioLBL0(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._720907526wthRatioLBL0;
         if(_loc2_ !== param1)
         {
            this._720907526wthRatioLBL0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wthRatioLBL0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wthRatioLBL1() : Label
      {
         return this._720907525wthRatioLBL1;
      }
      
      public function set wthRatioLBL1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._720907525wthRatioLBL1;
         if(_loc2_ !== param1)
         {
            this._720907525wthRatioLBL1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wthRatioLBL1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wthRatioLBL2() : Label
      {
         return this._720907524wthRatioLBL2;
      }
      
      public function set wthRatioLBL2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._720907524wthRatioLBL2;
         if(_loc2_ !== param1)
         {
            this._720907524wthRatioLBL2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wthRatioLBL2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get restCollection() : ArrayCollection
      {
         return this._1444205166restCollection;
      }
      
      private function set restCollection(param1:ArrayCollection) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1444205166restCollection;
         if(_loc2_ !== param1)
         {
            this._1444205166restCollection = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restCollection",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get workoutCollection() : ArrayCollection
      {
         return this._776400155workoutCollection;
      }
      
      private function set workoutCollection(param1:ArrayCollection) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._776400155workoutCollection;
         if(_loc2_ !== param1)
         {
            this._776400155workoutCollection = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutCollection",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get user() : UserObject
      {
         return this._3599307user;
      }
      
      private function set user(param1:UserObject) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._3599307user;
         if(_loc2_ !== param1)
         {
            this._3599307user = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"user",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get weightString() : String
      {
         return this._344075095weightString;
      }
      
      private function set weightString(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._344075095weightString;
         if(_loc2_ !== param1)
         {
            this._344075095weightString = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightString",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get heightString() : String
      {
         return this._2014651416heightString;
      }
      
      private function set heightString(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2014651416heightString;
         if(_loc2_ !== param1)
         {
            this._2014651416heightString = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heightString",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get heightString2() : String
      {
         return this._1970315494heightString2;
      }
      
      private function set heightString2(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1970315494heightString2;
         if(_loc2_ !== param1)
         {
            this._1970315494heightString2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heightString2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get cycleText() : String
      {
         return this._1561301197cycleText;
      }
      
      private function set cycleText(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1561301197cycleText;
         if(_loc2_ !== param1)
         {
            this._1561301197cycleText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cycleText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get restOverUnderString() : String
      {
         return this._1684251937restOverUnderString;
      }
      
      private function set restOverUnderString(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1684251937restOverUnderString;
         if(_loc2_ !== param1)
         {
            this._1684251937restOverUnderString = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"restOverUnderString",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get workoutOverUnderString() : String
      {
         return this._944714552workoutOverUnderString;
      }
      
      private function set workoutOverUnderString(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._944714552workoutOverUnderString;
         if(_loc2_ !== param1)
         {
            this._944714552workoutOverUnderString = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"workoutOverUnderString",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get goalCollection() : XMLListCollection
      {
         return this._350129681goalCollection;
      }
      
      private function set goalCollection(param1:XMLListCollection) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._350129681goalCollection;
         if(_loc2_ !== param1)
         {
            this._350129681goalCollection = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goalCollection",_loc2_,param1));
            }
         }
      }
   }
}

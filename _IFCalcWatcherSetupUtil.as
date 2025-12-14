package
{
   import mx.binding.FunctionReturnWatcher;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _IFCalcWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _IFCalcWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         IFCalc.watcherSetupUtil = new _IFCalcWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         var target:Object = param1;
         var propertyGetter:Function = param2;
         var staticPropertyGetter:Function = param3;
         var bindings:Array = param4;
         var watchers:Array = param5;
         watchers[41] = new PropertyWatcher("daysPerCycle",{"propertyChange":true},[bindings[46]],propertyGetter);
         watchers[42] = new PropertyWatcher("value",{"valueCommit":true},[bindings[46]],null);
         watchers[3] = new PropertyWatcher("heightString",{"propertyChange":true},[bindings[2]],propertyGetter);
         watchers[18] = new PropertyWatcher("restOverUnderString",{"propertyChange":true},[bindings[17]],propertyGetter);
         watchers[26] = new PropertyWatcher("workoutOverUnderString",{"propertyChange":true},[bindings[22]],propertyGetter);
         watchers[6] = new PropertyWatcher("weightString",{"propertyChange":true},[bindings[5],bindings[10],bindings[11],bindings[12],bindings[33],bindings[37],bindings[39]],propertyGetter);
         watchers[40] = new PropertyWatcher("goalLineChart",{"propertyChange":true},[bindings[45]],propertyGetter);
         watchers[43] = new PropertyWatcher("workoutsPerCycle",{"propertyChange":true},[bindings[47]],propertyGetter);
         watchers[44] = new PropertyWatcher("value",{"valueCommit":true},[bindings[47]],null);
         watchers[10] = new PropertyWatcher("heightString2",{"propertyChange":true},[bindings[9]],propertyGetter);
         watchers[35] = new PropertyWatcher("cycleText",{"propertyChange":true},[bindings[27],bindings[28],bindings[30],bindings[31],bindings[32],bindings[36],bindings[38],bindings[41],bindings[42]],propertyGetter);
         watchers[36] = new FunctionReturnWatcher("round",target,function():Array
         {
            return [target.user.tdee];
         },null,[bindings[29]],null);
         watchers[11] = new PropertyWatcher("restCollection",{"propertyChange":true},[bindings[13],bindings[14],bindings[15],bindings[16],bindings[23]],propertyGetter);
         watchers[16] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [2];
         },{"collectionChange":true},[bindings[16]],null);
         watchers[17] = new PropertyWatcher("pct",null,[bindings[16]],null);
         watchers[27] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [0];
         },{"collectionChange":true},[bindings[23]],null);
         watchers[28] = new PropertyWatcher("grams",null,[bindings[23]],null);
         watchers[12] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [0];
         },{"collectionChange":true},[bindings[14]],null);
         watchers[13] = new PropertyWatcher("pct",null,[bindings[14]],null);
         watchers[14] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [1];
         },{"collectionChange":true},[bindings[15]],null);
         watchers[15] = new PropertyWatcher("pct",null,[bindings[15]],null);
         watchers[45] = new PropertyWatcher("daysPerCycleGoals",{"propertyChange":true},[bindings[48]],propertyGetter);
         watchers[46] = new PropertyWatcher("value",{"valueCommit":true},[bindings[48]],null);
         watchers[47] = new PropertyWatcher("workoutsPerCycleGoals",{"propertyChange":true},[bindings[49]],propertyGetter);
         watchers[48] = new PropertyWatcher("value",{"valueCommit":true},[bindings[49]],null);
         watchers[39] = new PropertyWatcher("goalCollection",{"propertyChange":true},[bindings[40],bindings[43],bindings[44]],propertyGetter);
         watchers[1] = new PropertyWatcher("user",{"propertyChange":true},[bindings[1],bindings[3],bindings[4],bindings[6],bindings[7],bindings[8],bindings[25],bindings[26],bindings[29],bindings[34],bindings[35]],propertyGetter);
         watchers[5] = new PropertyWatcher("weight",{"propertyChange":true},[bindings[4]],null);
         watchers[2] = new PropertyWatcher("height",{"propertyChange":true},[bindings[1]],null);
         watchers[7] = new PropertyWatcher("age",{"propertyChange":true},[bindings[6]],null);
         watchers[33] = new PropertyWatcher("cycledays",{"propertyChange":true},[bindings[25],bindings[34]],null);
         watchers[9] = new PropertyWatcher("waist",{"propertyChange":true},[bindings[8]],null);
         watchers[34] = new PropertyWatcher("cycleworkouts",{"propertyChange":true},[bindings[26],bindings[35]],null);
         watchers[8] = new PropertyWatcher("bfpct",{"propertyChange":true},[bindings[7]],null);
         watchers[4] = new PropertyWatcher("heightin",{"propertyChange":true},[bindings[3]],null);
         watchers[37] = new PropertyWatcher("tdee",{"propertyChange":true},[bindings[29]],null);
         watchers[19] = new PropertyWatcher("workoutCollection",{"propertyChange":true},[bindings[18],bindings[19],bindings[20],bindings[21],bindings[24]],propertyGetter);
         watchers[20] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [0];
         },{"collectionChange":true},[bindings[19]],null);
         watchers[21] = new PropertyWatcher("pct",null,[bindings[19]],null);
         watchers[22] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [1];
         },{"collectionChange":true},[bindings[20]],null);
         watchers[23] = new PropertyWatcher("pct",null,[bindings[20]],null);
         watchers[24] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [2];
         },{"collectionChange":true},[bindings[21]],null);
         watchers[25] = new PropertyWatcher("pct",null,[bindings[21]],null);
         watchers[30] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [0];
         },{"collectionChange":true},[bindings[24]],null);
         watchers[31] = new PropertyWatcher("grams",null,[bindings[24]],null);
         watchers[41].updateParent(target);
         watchers[41].addChild(watchers[42]);
         watchers[3].updateParent(target);
         watchers[18].updateParent(target);
         watchers[26].updateParent(target);
         watchers[6].updateParent(target);
         watchers[40].updateParent(target);
         watchers[43].updateParent(target);
         watchers[43].addChild(watchers[44]);
         watchers[10].updateParent(target);
         watchers[35].updateParent(target);
         watchers[36].updateParent(Math);
         watchers[11].updateParent(target);
         watchers[16].parentWatcher = watchers[11];
         watchers[11].addChild(watchers[16]);
         watchers[16].addChild(watchers[17]);
         watchers[27].parentWatcher = watchers[11];
         watchers[11].addChild(watchers[27]);
         watchers[27].addChild(watchers[28]);
         watchers[12].parentWatcher = watchers[11];
         watchers[11].addChild(watchers[12]);
         watchers[12].addChild(watchers[13]);
         watchers[14].parentWatcher = watchers[11];
         watchers[11].addChild(watchers[14]);
         watchers[14].addChild(watchers[15]);
         watchers[45].updateParent(target);
         watchers[45].addChild(watchers[46]);
         watchers[47].updateParent(target);
         watchers[47].addChild(watchers[48]);
         watchers[39].updateParent(target);
         watchers[1].updateParent(target);
         watchers[1].addChild(watchers[5]);
         watchers[1].addChild(watchers[2]);
         watchers[1].addChild(watchers[7]);
         watchers[1].addChild(watchers[33]);
         watchers[1].addChild(watchers[9]);
         watchers[1].addChild(watchers[34]);
         watchers[1].addChild(watchers[8]);
         watchers[1].addChild(watchers[4]);
         watchers[1].addChild(watchers[37]);
         watchers[19].updateParent(target);
         watchers[20].parentWatcher = watchers[19];
         watchers[19].addChild(watchers[20]);
         watchers[20].addChild(watchers[21]);
         watchers[22].parentWatcher = watchers[19];
         watchers[19].addChild(watchers[22]);
         watchers[22].addChild(watchers[23]);
         watchers[24].parentWatcher = watchers[19];
         watchers[19].addChild(watchers[24]);
         watchers[24].addChild(watchers[25]);
         watchers[30].parentWatcher = watchers[19];
         watchers[19].addChild(watchers[30]);
         watchers[30].addChild(watchers[31]);
      }
   }
}

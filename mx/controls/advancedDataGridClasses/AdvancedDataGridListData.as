package mx.controls.advancedDataGridClasses
{
   import mx.controls.dataGridClasses.DataGridListData;
   import mx.core.IUIComponent;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridListData extends DataGridListData
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      [Bindable("__NoChangeEvent__")]
      public var depth:int;
      
      [Bindable("__NoChangeEvent__")]
      public var disclosureIcon:Class;
      
      [Bindable("__NoChangeEvent__")]
      public var hasChildren:Boolean;
      
      [Bindable("__NoChangeEvent__")]
      public var icon:Class;
      
      [Bindable("__NoChangeEvent__")]
      public var indent:int;
      
      [Bindable("__NoChangeEvent__")]
      public var item:Object;
      
      [Bindable("__NoChangeEvent__")]
      public var open:Boolean;
      
      public function AdvancedDataGridListData(param1:String, param2:String, param3:int, param4:String, param5:IUIComponent, param6:int = 0)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
   }
}

package mx.charts.series.items
{
   import flash.geom.Point;
   import mx.charts.ChartItem;
   import mx.charts.series.PieSeries;
   import mx.core.IUITextField;
   import mx.core.mx_internal;
   import mx.graphics.IFill;
   
   use namespace mx_internal;
   
   public class PieSeriesItem extends ChartItem
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      mx_internal var labelText:String;
      
      mx_internal var labelCos:Number;
      
      mx_internal var labelSin:Number;
      
      mx_internal var label:IUITextField;
      
      mx_internal var labelX:Number;
      
      mx_internal var labelY:Number;
      
      mx_internal var labelWidth:Number;
      
      mx_internal var labelHeight:Number;
      
      mx_internal var next:PieSeriesItem;
      
      mx_internal var prev:PieSeriesItem;
      
      public var angle:Number;
      
      public var fill:IFill;
      
      public var innerRadius:Number;
      
      public var labelAngle:Number;
      
      public var number:Number;
      
      public var origin:Point;
      
      public var outerRadius:Number;
      
      public var percentValue:Number;
      
      public var startAngle:Number;
      
      public var value:Object;
      
      public function PieSeriesItem(param1:PieSeries = null, param2:Object = null, param3:uint = 0)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : ChartItem
      {
         var _loc1_:PieSeriesItem = new PieSeriesItem(PieSeries(element),item,index);
         _loc1_.itemRenderer = itemRenderer;
         return _loc1_;
      }
   }
}

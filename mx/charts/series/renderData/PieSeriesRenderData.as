package mx.charts.series.renderData
{
   import mx.charts.chartClasses.RenderData;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class PieSeriesRenderData extends RenderData
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      public var itemSum:Number;
      
      public var labelData:Object;
      
      public var labelScale:Number;
      
      public function PieSeriesRenderData(param1:Array = null, param2:Array = null, param3:Number = 1, param4:Object = null)
      {
         super(param1,param2);
         this.labelScale = param3;
         this.labelData = param4;
      }
      
      override public function clone() : RenderData
      {
         return new PieSeriesRenderData(cache,filteredCache,this.labelScale,this.labelData);
      }
   }
}

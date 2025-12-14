package mx.charts
{
   import mx.charts.chartClasses.DataTip;
   import mx.charts.chartClasses.DataTransform;
   import mx.charts.chartClasses.PolarChart;
   import mx.charts.chartClasses.Series;
   import mx.charts.series.PieSeries;
   import mx.charts.styles.HaloDefaults;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.graphics.SolidColor;
   import mx.graphics.Stroke;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class PieChart extends PolarChart
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      private var _moduleFactoryInitialized:Boolean = false;
      
      private var _seriesWidth:Number;
      
      private var _innerRadius:Number;
      
      public function PieChart()
      {
         super();
         dataTipMode = "single";
         var _loc1_:LinearAxis = new LinearAxis();
         _loc1_.minimum = 0;
         _loc1_.maximum = 100;
         angularAxis = _loc1_;
      }
      
      override public function get legendData() : Array
      {
         var _loc1_:Array = [];
         if(series.length > 0)
         {
            _loc1_ = [series[0].legendData];
         }
         return _loc1_;
      }
      
      private function initStyles() : Boolean
      {
         HaloDefaults.init(styleManager);
         var pieChartStyle:CSSStyleDeclaration = HaloDefaults.createSelector("mx.charts.PieChart",styleManager);
         pieChartStyle.defaultFactory = function():void
         {
            this.dataTipRenderer = DataTip;
            this.fill = new SolidColor(16777215,0);
            this.calloutStroke = new Stroke(8947848,2);
            this.fontSize = 10;
            this.innerRadius = 0;
            this.textAlign = "left";
         };
         return true;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this._moduleFactoryInitialized)
         {
            return;
         }
         this._moduleFactoryInitialized = true;
         this.initStyles();
      }
      
      override public function styleChanged(param1:String) : void
      {
         if(param1 == null || param1 == "innerRadius")
         {
            invalidateSeries();
         }
         super.styleChanged(param1);
      }
      
      override protected function customizeSeries(param1:Series, param2:uint) : void
      {
         if(param1 is PieSeries)
         {
            PieSeries(param1).setStyle("innerRadius",this._innerRadius + param2 * this._seriesWidth);
            PieSeries(param1).outerRadius = this._innerRadius + (param2 + 1) * this._seriesWidth;
         }
      }
      
      override protected function applySeriesSet(param1:Array, param2:DataTransform) : Array
      {
         this._innerRadius = getStyle("innerRadius");
         this._innerRadius = !!isNaN(this._innerRadius)?Number(0):Number(this._innerRadius);
         this._seriesWidth = (1 - this._innerRadius) / param1.length;
         return super.applySeriesSet(param1,param2);
      }
   }
}

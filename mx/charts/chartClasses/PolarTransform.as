package mx.charts.chartClasses
{
   import flash.geom.Point;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class PolarTransform extends DataTransform
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public static const RADIAL_AXIS:String = "r";
      
      public static const ANGULAR_AXIS:String = "a";
      
      private static const TWO_PI:Number = 2 * Math.PI;
       
      
      private var _origin:Point;
      
      private var _radius:Number;
      
      public function PolarTransform()
      {
         super();
      }
      
      public function get origin() : Point
      {
         return this._origin;
      }
      
      public function get radius() : Number
      {
         return this._radius;
      }
      
      override public function invertTransform(... rest) : Array
      {
         var _loc2_:Array = [];
         if(rest.length > 0 && rest[0] != null)
         {
            _loc2_[0] = getAxis(ANGULAR_AXIS).invertTransform(rest[0] / TWO_PI);
         }
         if(rest.length > 1 && rest[1] != null)
         {
            _loc2_[1] = getAxis(RADIAL_AXIS).invertTransform(rest[1] / this._radius);
         }
         return _loc2_;
      }
      
      override public function transformCache(param1:Array, param2:String, param3:String, param4:String, param5:String) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         if(param2 != null)
         {
            getAxis(ANGULAR_AXIS).transformCache(param1,param2,param3);
            _loc8_ = param1.length;
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               _loc7_ = param1[_loc6_][param3];
               if(_loc7_ != null)
               {
                  param1[_loc6_][param3] = Number(_loc7_) * TWO_PI;
               }
               _loc6_++;
            }
         }
         if(param4 != null)
         {
            getAxis(RADIAL_AXIS).transformCache(param1,param4,param5);
            _loc8_ = param1.length;
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               _loc7_ = param1[_loc6_][param5];
               if(_loc7_ != null)
               {
                  param1[_loc6_][param5] = Number(_loc7_) * this._radius;
               }
               _loc6_++;
            }
         }
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this._radius = Math.min(param1 / 2,param2 / 2);
         this._origin = new Point(param1 / 2,param2 / 2);
      }
   }
}

package mx.collections
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class Grouping
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      public var label:String = "GroupLabel";
      
      private var _compareFunction:Function;
      
      private var _fields:Array;
      
      public var groupingObjectFunction:Function;
      
      public function Grouping()
      {
         super();
      }
      
      public function get compareFunction() : Function
      {
         return this._compareFunction;
      }
      
      public function set compareFunction(param1:Function) : void
      {
         this._compareFunction = param1;
      }
      
      public function get fields() : Array
      {
         return this._fields;
      }
      
      public function set fields(param1:Array) : void
      {
         this._fields = param1;
      }
   }
}

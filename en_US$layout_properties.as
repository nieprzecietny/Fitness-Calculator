package
{
   import mx.resources.ResourceBundle;
   
   public class en_US$layout_properties extends ResourceBundle
   {
       
      
      public function en_US$layout_properties()
      {
         super("en_US","layout");
      }
      
      override protected function getContent() : Object
      {
         var _loc1_:Object = {
            "basicLayoutNotVirtualized":"BasicLayout doesn\'t support virtualization.",
            "invalidIndex":"invalidIndex"
         };
         return _loc1_;
      }
   }
}

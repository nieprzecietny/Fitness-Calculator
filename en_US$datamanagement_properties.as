package
{
   import mx.resources.ResourceBundle;
   
   public class en_US$datamanagement_properties extends ResourceBundle
   {
       
      
      public function en_US$datamanagement_properties()
      {
         super("en_US","datamanagement");
      }
      
      override protected function getContent() : Object
      {
         var _loc1_:Object = {
            "Branch":"Branch {0}",
            "repeatColumnsNotAllowed":"Same column object cannot be used more than once"
         };
         return _loc1_;
      }
   }
}

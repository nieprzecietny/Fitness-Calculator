package mx.events
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public final class AdvancedDataGridEventReason
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public static const CANCELLED:String = "cancelled";
      
      public static const OTHER:String = "other";
      
      public static const NEW_COLUMN:String = "newColumn";
      
      public static const NEW_ROW:String = "newRow";
       
      
      public function AdvancedDataGridEventReason()
      {
         super();
      }
   }
}

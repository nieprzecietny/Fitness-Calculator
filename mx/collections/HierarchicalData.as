package mx.collections
{
   import flash.events.EventDispatcher;
   import mx.core.mx_internal;
   import mx.events.CollectionEvent;
   import mx.events.CollectionEventKind;
   
   use namespace mx_internal;
   
   public class HierarchicalData extends EventDispatcher implements IHierarchicalData
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      private var _childrenField:String = "children";
      
      private var _source:Object;
      
      public function HierarchicalData(param1:Object = null)
      {
         super();
         this.source = param1;
      }
      
      public function get childrenField() : String
      {
         return this._childrenField;
      }
      
      public function set childrenField(param1:String) : void
      {
         this._childrenField = param1;
      }
      
      public function get source() : Object
      {
         return this._source;
      }
      
      public function set source(param1:Object) : void
      {
         this._source = param1;
         var _loc2_:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
         _loc2_.kind = CollectionEventKind.RESET;
         dispatchEvent(_loc2_);
      }
      
      public function canHaveChildren(param1:Object) : Boolean
      {
         var childList:XMLList = null;
         var branchFlag:XMLList = null;
         var node:Object = param1;
         if(node == null)
         {
            return false;
         }
         var branch:Boolean = false;
         if(node is XML)
         {
            childList = this.childrenField == "children"?node.children():node.child(this.childrenField).children();
            branchFlag = node.@isBranch;
            if(branchFlag.length() == 1)
            {
               if(branchFlag[0] == "true")
               {
                  branch = true;
               }
            }
            else if(childList.length() != 0)
            {
               branch = true;
            }
         }
         else if(node is Object)
         {
            try
            {
               if(node[this.childrenField] != undefined)
               {
                  branch = true;
               }
            }
            catch(e:Error)
            {
            }
         }
         return branch;
      }
      
      public function getChildren(param1:Object) : Object
      {
         var children:* = undefined;
         var node:Object = param1;
         if(node == null)
         {
            return null;
         }
         if(node is XML)
         {
            children = this.childrenField == "children"?node.*:node.child(this.childrenField).*;
         }
         else if(node is Object)
         {
            try
            {
               children = node[this.childrenField];
            }
            catch(e:Error)
            {
            }
         }
         if(children === undefined)
         {
            return null;
         }
         return children;
      }
      
      public function hasChildren(param1:Object) : Boolean
      {
         var node:Object = param1;
         if(node == null)
         {
            return false;
         }
         var children:Object = this.getChildren(node);
         try
         {
            if(children is XMLList || children is XML)
            {
               if(children.length() > 0)
               {
                  return true;
               }
            }
            if(children.length > 0)
            {
               return true;
            }
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function getData(param1:Object) : Object
      {
         return Object(param1);
      }
      
      public function getRoot() : Object
      {
         return this.source;
      }
   }
}

package
{
   import flash.system.ApplicationDomain;
   import flash.system.Security;
   import flash.utils.Dictionary;
   import flashx.textLayout.compose.ISWFContext;
   import mx.core.IFlexModule;
   import mx.core.IFlexModuleFactory;
   import mx.managers.SystemManager;
   import mx.preloaders.SparkDownloadProgressBar;
   
   public class _IFCalc_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory, ISWFContext
   {
       
      
      private var _preloadedRSLs:Dictionary;
      
      public function _IFCalc_mx_managers_SystemManager()
      {
         super();
      }
      
      override public function callInContext(param1:Function, param2:Object, param3:Array, param4:Boolean = true) : *
      {
         if(param4)
         {
            return param1.apply(param2,param3);
         }
         param1.apply(param2,param3);
      }
      
      override public function create(... rest) : Object
      {
         if(rest.length > 0 && !(rest[0] is String))
         {
            return super.create.apply(this,rest);
         }
         var _loc2_:String = rest.length == 0?"IFCalc":String(rest[0]);
         var _loc3_:Class = Class(getDefinitionByName(_loc2_));
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:Object = new _loc3_();
         if(_loc4_ is IFlexModule)
         {
            IFlexModule(_loc4_).moduleFactory = this;
         }
         return _loc4_;
      }
      
      override public function info() : Object
      {
         return {
            "applicationComplete":"application1_applicationCompleteHandler(event)",
            "cdRsls":[{
               "rsls":["http://fpdownload.adobe.com/pub/swz/flex/4.1.0.16076/framework_4.1.0.16076.swz","framework_4.1.0.16076.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["871f12af0853c06e4eb80a1ccab295ceadbb817ad3332c20b5d986d3db5bfe6d","871f12af0853c06e4eb80a1ccab295ceadbb817ad3332c20b5d986d3db5bfe6d"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            },{
               "rsls":["http://fpdownload.adobe.com/pub/swz/tlf/1.1.0.604/textLayout_1.1.0.604.swz","textLayout_1.1.0.604.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["381814f6f5270ffbb27e244d6138bc023af911d585b0476fe4bd7961bdde72b6","381814f6f5270ffbb27e244d6138bc023af911d585b0476fe4bd7961bdde72b6"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            },{
               "rsls":["http://fpdownload.adobe.com/pub/swz/flex/4.1.0.16076/osmf_flex.4.0.0.13495.swz","osmf_flex.4.0.0.13495.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["c3306b26751d6a80eb1fcb651912469ae18819aba42869379acb17e49ec1f9f0","c3306b26751d6a80eb1fcb651912469ae18819aba42869379acb17e49ec1f9f0"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            },{
               "rsls":["http://fpdownload.adobe.com/pub/swz/flex/4.1.0.16076/rpc_4.1.0.16076.swz","rpc_4.1.0.16076.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["6ddb94ae3365798230849fa0f931ac132fe417d1cab1d2f47d334f8a47d097a7","6ddb94ae3365798230849fa0f931ac132fe417d1cab1d2f47d334f8a47d097a7"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            },{
               "rsls":["http://fpdownload.adobe.com/pub/swz/flex/4.1.0.16076/spark_4.1.0.16076.swz","spark_4.1.0.16076.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["6344dcc80a9a6a3676dcea0c92c8c45efd2f3220b095897b0918285bbaef761d","6344dcc80a9a6a3676dcea0c92c8c45efd2f3220b095897b0918285bbaef761d"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            },{
               "rsls":["http://fpdownload.adobe.com/pub/swz/flex/4.1.0.16076/sparkskins_4.1.0.16076.swz","sparkskins_4.1.0.16076.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["440ae73b017a477382deff7c0dbe4896fed21079000f6af154062c592a0c4dff","440ae73b017a477382deff7c0dbe4896fed21079000f6af154062c592a0c4dff"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            }],
            "compiledLocales":["en_US"],
            "compiledResourceBundleNames":["SharedResources","charts","collections","components","containers","controls","core","datamanagement","effects","formatters","layout","skins","sparkEffects","styles","textLayout"],
            "creationComplete":"cc(event)",
            "currentDomain":ApplicationDomain.currentDomain,
            "height":"700",
            "initialize":"init(event)",
            "mainClassName":"IFCalc",
            "minHeight":"700",
            "minWidth":"960",
            "mixins":["_IFCalc_FlexInit","_IFCalc_Styles","mx.managers.systemClasses.ActiveWindowManager"],
            "pageTitle":"IF Calculator",
            "preloader":SparkDownloadProgressBar,
            "width":"960"
         };
      }
      
      override public function get preloadedRSLs() : Dictionary
      {
         if(this._preloadedRSLs == null)
         {
            this._preloadedRSLs = new Dictionary(true);
         }
         return this._preloadedRSLs;
      }
      
      override public function allowDomain(... rest) : void
      {
         var _loc2_:* = null;
         Security.allowDomain(rest);
         for(_loc2_ in this._preloadedRSLs)
         {
            if(_loc2_.content && "allowDomainInRSL" in _loc2_.content)
            {
               _loc2_.content["allowDomainInRSL"](rest);
            }
         }
      }
      
      override public function allowInsecureDomain(... rest) : void
      {
         var _loc2_:* = null;
         Security.allowInsecureDomain(rest);
         for(_loc2_ in this._preloadedRSLs)
         {
            if(_loc2_.content && "allowInsecureDomainInRSL" in _loc2_.content)
            {
               _loc2_.content["allowInsecureDomainInRSL"](rest);
            }
         }
      }
   }
}

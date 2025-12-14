package
{
   import flash.net.getClassByAlias;
   import flash.net.registerClassAlias;
   import flash.system.Capabilities;
   import mx.accessibility.AdvancedDataGridAccImpl;
   import mx.accessibility.AlertAccImpl;
   import mx.accessibility.ButtonAccImpl;
   import mx.accessibility.ComboBaseAccImpl;
   import mx.accessibility.DateChooserAccImpl;
   import mx.accessibility.DateFieldAccImpl;
   import mx.accessibility.LabelAccImpl;
   import mx.accessibility.ListBaseAccImpl;
   import mx.accessibility.PanelAccImpl;
   import mx.accessibility.TabBarAccImpl;
   import mx.accessibility.UIComponentAccProps;
   import mx.collections.ArrayCollection;
   import mx.collections.ArrayList;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.effects.EffectManager;
   import mx.managers.systemClasses.ChildManager;
   import mx.styles.IStyleManager2;
   import mx.styles.StyleManagerImpl;
   import mx.utils.ObjectProxy;
   import spark.accessibility.ButtonBaseAccImpl;
   import spark.accessibility.CheckBoxAccImpl;
   import spark.accessibility.ComboBoxAccImpl;
   import spark.accessibility.DropDownListBaseAccImpl;
   import spark.accessibility.ListAccImpl;
   import spark.accessibility.NumericStepperAccImpl;
   import spark.accessibility.RadioButtonAccImpl;
   import spark.accessibility.RichEditableTextAccImpl;
   import spark.accessibility.SliderBaseAccImpl;
   import spark.accessibility.SpinnerAccImpl;
   import spark.accessibility.TextBaseAccImpl;
   import spark.accessibility.ToggleButtonAccImpl;
   
   public class _IFCalc_FlexInit
   {
       
      
      public function _IFCalc_FlexInit()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var styleManager:IStyleManager2 = null;
         var fbs:IFlexModuleFactory = param1;
         new ChildManager(fbs);
         styleManager = new StyleManagerImpl(fbs);
         EffectManager.mx_internal::registerEffectTrigger("addedEffect","added");
         EffectManager.mx_internal::registerEffectTrigger("creationCompleteEffect","creationComplete");
         EffectManager.mx_internal::registerEffectTrigger("focusInEffect","focusIn");
         EffectManager.mx_internal::registerEffectTrigger("focusOutEffect","focusOut");
         EffectManager.mx_internal::registerEffectTrigger("hideDataEffect","hideData");
         EffectManager.mx_internal::registerEffectTrigger("hideEffect","hide");
         EffectManager.mx_internal::registerEffectTrigger("mouseDownEffect","mouseDown");
         EffectManager.mx_internal::registerEffectTrigger("mouseUpEffect","mouseUp");
         EffectManager.mx_internal::registerEffectTrigger("moveEffect","move");
         EffectManager.mx_internal::registerEffectTrigger("removedEffect","removed");
         EffectManager.mx_internal::registerEffectTrigger("resizeEffect","resize");
         EffectManager.mx_internal::registerEffectTrigger("resizeEndEffect","resizeEnd");
         EffectManager.mx_internal::registerEffectTrigger("resizeStartEffect","resizeStart");
         EffectManager.mx_internal::registerEffectTrigger("rollOutEffect","rollOut");
         EffectManager.mx_internal::registerEffectTrigger("rollOverEffect","rollOver");
         EffectManager.mx_internal::registerEffectTrigger("showDataEffect","showData");
         EffectManager.mx_internal::registerEffectTrigger("showEffect","show");
         if(Capabilities.hasAccessibility)
         {
            PanelAccImpl.enableAccessibility();
            TabBarAccImpl.enableAccessibility();
            SliderBaseAccImpl.enableAccessibility();
            AdvancedDataGridAccImpl.enableAccessibility();
            mx.accessibility.ListBaseAccImpl.enableAccessibility();
            SpinnerAccImpl.enableAccessibility();
            NumericStepperAccImpl.enableAccessibility();
            DateFieldAccImpl.enableAccessibility();
            ButtonBaseAccImpl.enableAccessibility();
            spark.accessibility.ListBaseAccImpl.enableAccessibility();
            RadioButtonAccImpl.enableAccessibility();
            ToggleButtonAccImpl.enableAccessibility();
            DateChooserAccImpl.enableAccessibility();
            ComboBoxAccImpl.enableAccessibility();
            AlertAccImpl.enableAccessibility();
            LabelAccImpl.enableAccessibility();
            RichEditableTextAccImpl.enableAccessibility();
            TextBaseAccImpl.enableAccessibility();
            ListAccImpl.enableAccessibility();
            CheckBoxAccImpl.enableAccessibility();
            ButtonAccImpl.enableAccessibility();
            DropDownListBaseAccImpl.enableAccessibility();
            UIComponentAccProps.enableAccessibility();
            ComboBaseAccImpl.enableAccessibility();
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ArrayCollection") == null)
            {
               registerClassAlias("flex.messaging.io.ArrayCollection",ArrayCollection);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ArrayCollection",ArrayCollection);
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ArrayList") == null)
            {
               registerClassAlias("flex.messaging.io.ArrayList",ArrayList);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ArrayList",ArrayList);
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ObjectProxy") == null)
            {
               registerClassAlias("flex.messaging.io.ObjectProxy",ObjectProxy);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ObjectProxy",ObjectProxy);
         }
         var styleNames:Array = ["sortFontSize","lineHeight","unfocusedTextSelectionColor","kerning","iconColor","markerWidth","textDecoration","dominantBaseline","adjustedRadius","fontThickness","depthColors","blockProgression","textAlignLast","textAlpha","chromeColor","rollOverColor","itemRollOverColor","fontSize","shadowColor","paragraphEndIndent","fontWeight","breakOpportunity","leading","renderingMode","symbolColor","paragraphStartIndent","layoutDirection","footerColors","contentBackgroundColor","paragraphSpaceAfter","digitWidth","ligatureLevel","firstBaselineOffset","itemDisabledColor","fontLookup","todayColor","paragraphSpaceBefore","fontFamily","labelPlacement","strokeWidth","lineThrough","alignmentBaseline","trackingLeft","separatorColor","fontStyle","dropShadowColor","accentColor","selectionColor","disabledIconColor","textJustify","focusColor","alternatingItemColors","typographicCase","textRollOverColor","digitCase","inactiveTextSelectionColor","justificationRule","trackingRight","leadingModel","itemSelectionColor","selectionDisabledColor","letterSpacing","focusedTextSelectionColor","baselineShift","strokeColor","fontSharpness","sortFontStyle","axisTitleStyleName","barColor","modalTransparencyDuration","justificationStyle","contentBackgroundAlpha","textRotation","fontAntiAliasType","direction","cffHinting","errorColor","locale","horizontalGridLineColor","backgroundDisabledColor","modalTransparencyColor","textIndent","themeColor","verticalGridLineColor","tabStops","modalTransparency","markerHeight","textAlign","headerColors","sortFontWeight","textSelectedColor","whiteSpaceCollapse","fontGridFitType","proposedColor","disabledColor","modalTransparencyBlur","color","sortFontFamily"];
         var i:int = 0;
         while(i < styleNames.length)
         {
            styleManager.registerInheritingStyle(styleNames[i]);
            i++;
         }
      }
   }
}

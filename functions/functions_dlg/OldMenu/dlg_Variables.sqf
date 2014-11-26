#include "Macros\GearMenuMacros.sqf"
#include "Macros\UnitMenuMacros.sqf"
#include "Macros\VehMenuMacros.sqf"
#include "macros.sqf"

//Generelle Variablen Kaufen
CT_DLG_OverallCost=			0;
CT_DLG_CurrentLB=			[];
CT_DLG_CartList=			[];									//Einkaufswagen //format [[ID,anzahl],[ID anzahl],...]
CT_DLG_DistanceToBase=		50;									//welche Entfernung der spieler zum MHQ haben darf um zu kaufen															//Variable des MHQs
																	
//Alle verfügbaren IDs
CT_DLG_AllGear= 			[TW_Weapon_Shop_West,TW_Weapon_Shop_East];								//Gear
CT_DLG_AllVehicles=			[TW_Vehicle_Shop_West,TW_Vehicle_Shop_East,TW_Vehicle_Shop_Town];		//Fahrzeuge
CT_DLG_AllUnits=			[TW_AI_Shop_West,TW_AI_Shop_East];										//Einheiten

//Typen Arrays für zuordnung in Dialog
//TW_dlg_TypeArray_Gear= 			["wep","mag","item","wear","bp"];									//Gear
TW_dlg_TypeArray_Gear= 			["wep","mag","item"];
TW_dlg_TypeArray_Vehicle= 		["Bike","Boat","Car","Truck","Tank","Air"];							//Vehicles

//Prefix zum erfassen aus stringtable.csv
TW_dlg_Menu_LocPrefix= 			"STRS_dlg_Menu";

//Gear Menu spezifische Variablen																
//IDCs der Controls
TW_dlg_GearMenu_button_idc= 	[
							[IDC_GEARMENU_BUTTON_GEARMENU_ADD1,"STRS_GearMenu_BSelect1","call CT_DLG_GearMenu_Add1ToCart",""],
							[IDC_GEARMENU_BUTTON_GEARMENU_REMOVE1,"STRS_GearMenu_BDisselect1","call CT_DLG_GearMenu_Remove1FromCart",""],
							[IDC_GEARMENU_BUTTON_GEARMENU_ADDALL,"STRS_GearMenu_BSelectAll","call CT_DLG_GearMenu_AddAllToCart",""],
							[IDC_GEARMENU_BUTTON_GEARMENU_REMOVEALL,"STRS_GearMenu_BDisselectAll","call CT_DLG_GearMenu_RemoveAllFromCart",""],					
							[IDC_GEARMENU_BUTTON_GEARMENU_BUYTOCRATE,"STRS_GearMenu_BBuyToCrate","closedialog 0","false"],
							[IDC_GEARMENU_BUTTON_GEARMENU_BUYTOINVENTORY,"STRS_GearMenu_BBuyToInventory","call CT_DLG_GearMenu_BuyToInventory",""]
							];
TW_dlg_GearMenu_text_idc=	[
							[IDC_GEARMENU_TEXT_GEARMENU_TITLE,"STRS_GearMenu_TTitle"],
							[IDC_GEARMENU_TEXT_GEARMENU_MONEYTEXT,"STRS_GearMenu_TInfoFunds"],
							[IDC_GEARMENU_TEXT_GEARMENU_MONEYCOUNT,{format ["%1 $",Tee_Konto]}],
//							[IDC_GEARMENU_TEXT_GEARMENU_NAMETEXT,"STRS_GearMenu_TInfoName"],
//							[IDC_GEARMENU_TEXT_GEARMENU_COSTTEXT,"STRS_GearMenu_TInfoCost"],
//							[IDC_GEARMENU_TEXT_GEARMENU_NAMEWEAPONVALUE,"STRING"],
//							[IDC_GEARMENU_TEXT_GEARMENU_COSTVALUE,"SCALAR"],
							[IDC_GEARMENU_TEXT_GEARMENU_OVERALLCOSTTEXT,"STRS_GearMenu_TInfoCost"],
//							[IDC_GEARMENU_TEXT_GEARMENU_NAMETEXT2,"STRS_GearMenu_TInfoName"],
							[IDC_GEARMENU_TEXT_GEARMENU_OVERALLCOSTVALUE,"SCALAR"],
//							[IDC_GEARMENU_TEXT_GEARMENU_COSTTEXT2,"STRS_GearMenu_TInfoCost"],
//							[IDC_GEARMENU_TEXT_GEARMENU_NAMEVALUE2,"STRING"],
//							[IDC_GEARMENU_TEXT_GEARMENU_COSTVALUE2,"SCALAR"],
							[IDC_GEARMENU_TEXT_GEARMENU_YOURGEARTEXT,"STRS_GearMenu_TSelected"]
							];
TW_dlg_GearMenu_frames_idc=	[
							[IDC_GEARMENU_FRAME_GEARMENU_ACCOUNTDATA,"STRS_GearMenu_FAccInfo"],
//							[IDC_GEARMENU_FRAME_GEARMENU_GEARINFO1,"STRS_GearMenu_FGearInfo"],
//							[IDC_GEARMENU_FRAME_GEARMENU_GEARINFO2,"STRS_GearMenu_FGearInfo"],							
							[IDC_GEARMENU_FRAME_GEARMENU_COSTS,"STRS_GearMenu_FCostInfo"]
							];
TW_dlg_GearMenu_combos_idc=	[
							[IDC_GEARMENU_COMBO_GEARMENU_SELTYPE,TW_dlg_TypeArray_Gear]
							];

							
//UNIT MENU IDCs
TW_dlg_UnitMenu_button_idc= [
							[IDC_UNITMENU_BUTTON_UNITMENU_BUYUNIT,"STRS_UnitMenu_BBuyUnit","call CT_DLG_UnitMenu_BuySelected",""],
							[IDC_UNITMENU_BUTTON_UNITMENU_SELECT1,"STRS_UnitMenu_BSelect1","call CT_DLG_UnitMenu_Add1ToCart",""],
							[IDC_UNITMENU_BUTTON_UNITMENU_DISSELECT1,"STRS_UnitMenu_BDisselect1","call CT_DLG_UnitMenu_Remove1FromCart",""],
							[IDC_UNITMENU_BUTTON_UNITMENU_SELECTALL,"STRS_UnitMenu_BSelectAll","call CT_DLG_UnitMenu_AddAllToCart",""],
							[IDC_UNITMENU_BUTTON_UNITMENU_DISSELECTALL,"STRS_UnitMenu_BDisselectAll","call CT_DLG_UnitMenu_RemoveAllFromCart",""]
							];
TW_dlg_UnitMenu_text_idc=	[
							[IDC_UNITMENU_TEXT_UNITMENU_TITLE,"STRS_UnitMenu_TTitle"],
							[IDC_UNITMENU_TEXT_UNITMENU_FUNDSTEXT,"STRS_UnitMenu_TInfoFunds"],
							[IDC_UNITMENU_TEXT_UNITMENU_COSTSTEXT,"STRS_UnitMenu_TInfoCost"],
							[IDC_UNITMENU_TEXT_UNITMENU_ALLUNITSAVAILABLE,"STRS_UnitMenu_TUnitsAvailable"],
							[IDC_UNITMENU_TEXT_UNITMENU_ALLUNITSSELECTED,"STRS_UnitMenu_TUnitsSelected"]	
							];
TW_dlg_UnitMenu_frames_idc=	[
								[IDC_UNITMENU_FRAME_UNITMENU_ACCOUNTDATA,"STRS_UnitMenu_FAccInfo"],
								[IDC_UNITMENU_FRAME_UNITMENU_COSTDATA,"STRS_UnitMenu_FCostInfo"]
							];
//VEH MENU							
TW_dlg_VehMenu_button_idc=  [
							[IDC_VEHICE_BUTTON_VEHMENU_BUYUNIT,"STRS_VehMenu_BBuyVehicle","call CT_DLG_VehMenu_BuySelected;closedialog 0;",""]
							];
							
TW_dlg_VehMenu_text_idc=	[
							[IDC_VEHICE_TEXT_VEHMENU_TITLE,"STRS_VehMenu_TTitle"],
							[IDC_VEHICE_TEXT_VEHMENU_FUNDSTEXT,"STRS_VehMenu_TInfoFunds"],
							[IDC_VEHICE_TEXT_VEHMENU_ALLVEHICLESAVAILABLE,"STRS_VehMenu_TVehiclesAvailable"]	
							];
							
TW_dlg_VehMenu_frames_idc=	[
							[IDC_VEHICE_FRAME_VEHMENU_ACCOUNTDATA,"STRS_VehMenu_FAccInfo"]
							];
							
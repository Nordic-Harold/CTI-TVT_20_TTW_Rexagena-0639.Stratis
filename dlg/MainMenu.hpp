#include "macros.sqf"
#include "Macros\UnitMenuMacros.sqf"
#include "Macros\VehMenuMacros.sqf"
#include "Macros\GearMenuMacros.sqf"

#define ALIGN_X 		(-7)
#define ALIGN_Y 		(4)
#define DLG_W			(13)
#define DLG_H			(0.9)
#define TITLE_L_W		(5)
#define TITLE_R_W		(DLG_W - TITLE_L_W)
#define TITLE_R_ALIGN	(ALIGN_X + TITLE_L_W)
#define BUTTON_DY(nr)	(1.0 * nr)
#define ALIGN_DY(nr) 	(ALIGN_Y + BUTTON_DY(nr))

class TTW_dlg_MainMenu { 
	idd = 1100;
	movingEnabled = false;
	enableSimulation = true;
	class controlsBackground {};
	class controls {
		class Text_MainMenuText: TextBase
		{
			idc = 1000;
			text = ""; //--- ToDo: Localize;
			x = ALIGN_X * GUI_GRID_W + GUI_GRID_X;
			y = ALIGN_Y * GUI_GRID_H + GUI_GRID_Y;
			w = (TITLE_L_W +0.01) * GUI_GRID_W;
			h = DLG_H * GUI_GRID_H;
			colorBackground[] = {0.48,0.5,0.35,1};
		};
		class Text_MainMenuName: TextBase
		{
			idc = 1001;
			text = ""; //--- ToDo: Localize;
			style = 0x01;
			colorBackground[] = {0.48,0.5,0.35,1};			
			x = (TITLE_R_ALIGN - 0.01) * GUI_GRID_W + GUI_GRID_X;
			y = ALIGN_Y * GUI_GRID_H + GUI_GRID_Y;
			w = TITLE_R_W * GUI_GRID_W;
			h = DLG_H * GUI_GRID_H;
		};
		class Button_BuyUnits: ButtonBase
		{
			idc = 1700;
			x = ALIGN_X * GUI_GRID_W + GUI_GRID_X;
			y = ALIGN_DY(1) * GUI_GRID_H + GUI_GRID_Y;
			w = DLG_W * GUI_GRID_W;
			h = DLG_H * GUI_GRID_H;
			colorBackground[] = {0,0,0,1};
			colorFocused[] = { 1, 1, 1, 1 };
			colorBackgroundFocused[] = { 1, 1, 1, 0 };
		};
		class Button_BuyGear: ButtonBase
		{
			idc = 1701;
			text = ""; //--- ToDo: Localize;
			x = ALIGN_X * GUI_GRID_W + GUI_GRID_X;
			y = ALIGN_DY(2) * GUI_GRID_H + GUI_GRID_Y;
			w = DLG_W * GUI_GRID_W;
			h = DLG_H * GUI_GRID_H;
			colorBackground[] = {0,0,0,1};
			colorFocused[] = { 1, 1, 1, 1 };
			colorBackgroundFocused[] = { 1, 1, 1, 0 };
		};
		class Button_BuyVehicles: ButtonBase
		{
			idc = 1702;
			text = ""; //--- ToDo: Localize;
			x = ALIGN_X * GUI_GRID_W + GUI_GRID_X;
			y = ALIGN_DY(3) * GUI_GRID_H + GUI_GRID_Y;
			w = DLG_W * GUI_GRID_W;
			h = DLG_H * GUI_GRID_H;
			colorBackground[] = {0,0,0,1};
			colorFocused[] = { 1, 1, 1, 1 };
			colorBackgroundFocused[] = { 1, 1, 1, 0 };
		};
		class Button_Intel: ButtonBase
		{
			idc = 1703;
			text = ""; //--- ToDo: Localize;
			x = ALIGN_X * GUI_GRID_W + GUI_GRID_X;
			y = ALIGN_DY(4) * GUI_GRID_H + GUI_GRID_Y;
			w = DLG_W * GUI_GRID_W;
			h = DLG_H * GUI_GRID_H;
			colorBackground[] = {0,0,0,1};
			colorFocused[] = { 1, 1, 1, 1 };
			colorBackgroundFocused[] = { 1, 1, 1, 0 };
		};
		class Button_Commander: ButtonBase
		{
			idc = 1704;
			text = ""; //--- ToDo: Localize;
			x = ALIGN_X * GUI_GRID_W + GUI_GRID_X;
			y = ALIGN_DY(5) * GUI_GRID_H + GUI_GRID_Y;
			w = DLG_W * GUI_GRID_W;
			h = DLG_H * GUI_GRID_H;
			colorFocused[] = { 1, 1, 1, 1 };
			colorBackgroundFocused[] = { 1, 1, 1, 0 };
			colorBackground[] = {0,0,0,1};
		};
		class Button_Return: ButtonBase
		{
			idc = 1705;
			text = ""; //--- ToDo: Localize;
			x = ALIGN_X * GUI_GRID_W + GUI_GRID_X;
			y = ALIGN_DY(6) * GUI_GRID_H + GUI_GRID_Y;
			w = DLG_W * GUI_GRID_W;
			h = DLG_H * GUI_GRID_H;
			colorFocused[] = { 1, 1, 1, 1 };
			colorBackgroundFocused[] = { 1, 1, 1, 0 };
			colorBackground[] = {0,0,0,1};
		};
	};
};

class TTW_dlg_UnitMenu { 
	idd = 1102;
	movingEnabled = false;
	enableSimulation = true;
	class controlsBackground {
		class Text_UnitMenu_BG: TextBase {
			idc = IDC_UNITMENU_TEXT_UNITMENU_BG;
			x = 3 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 34 * GUI_GRID_W;
			h = 15 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.8};
		};
	};
	class controls {
		class Text_UnitMenu_Title: TextBase {
			idc = IDC_UNITMENU_TEXT_UNITMENU_TITLE;
			text = "Unit Menu"; //--- ToDo: Localize;
			x = 3 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 34 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.48,0.5,0.35,1};
		};
		class Text_UnitMenu_FundsText: TextBase {
			idc = IDC_UNITMENU_TEXT_UNITMENU_FUNDSTEXT;
			text = "Money:"; //--- ToDo: Localize;
			x = 27.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Text_UnitMenu_FundsValue: TextBase {
			idc = IDC_UNITMENU_TEXT_UNITMENU_FUNDSVALUE;
			text = "5000 $"; //--- ToDo: Localize;
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Text_UnitMenu_AllUnitsAvailable: TextBase {
			idc = IDC_UNITMENU_TEXT_UNITMENU_ALLUNITSAVAILABLE;
			text = "Units Available"; //--- ToDo: Localize;
			x = 3.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.48,0.5,0.35,1};
		};
		class Text_UnitMenu_AllUnitsSelected: TextBase {
			idc = IDC_UNITMENU_TEXT_UNITMENU_ALLUNITSSELECTED;
			text = "Selected Units"; //--- ToDo: Localize;
			x = 15.7 * GUI_GRID_W + GUI_GRID_X;
			y = 4.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.48,0.5,0.35,1};
		};
		class Text_UnitMenu_CostsText: TextBase {
			idc = IDC_UNITMENU_TEXT_UNITMENU_COSTSTEXT;
			text = "Costs:"; //--- ToDo: Localize;
			x = 27.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Text_UnitMenu_CostsValue: TextBase {
			idc = IDC_UNITMENU_TEXT_UNITMENU_COSTSVALUE;
			text = "5000 $"; //--- ToDo: Localize;
			x = 30 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Frame_UnitMenu_AccountData:  FrameBase {
			idc = IDC_UNITMENU_FRAME_UNITMENU_ACCOUNTDATA;
			text = "AccountData"; //--- ToDo: Localize;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		class Frame_UnitMenu_CostData:  FrameBase {
			idc = IDC_UNITMENU_FRAME_UNITMENU_COSTDATA;
			text = "CostData"; //--- ToDo: Localize;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 5 * GUI_GRID_H;
		};
		class LB_UnitMenu_SelectedUnits: LBBase {
			idc = IDC_UNITMENU_LB_UNITMENU_SELECTEDUNITS;
			x = 15.7 * GUI_GRID_W + GUI_GRID_X;
			y = 5.8 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 12 * GUI_GRID_H;
		};
		class LB_UnitMenu_SelectUnit: LBBase {
			idc = IDC_UNITMENU_LB_UNITMENU_SELECTUNIT;
			x = 3.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.8 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 12 * GUI_GRID_H;
		};
		class Button_UnitMenu_BuyUnit: ButtonMenuBase {
			idc = IDC_UNITMENU_BUTTON_UNITMENU_BUYUNIT;
			x = 27.7 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_UnitMenu_Select1: ButtonMenuBase {
			idc = IDC_UNITMENU_BUTTON_UNITMENU_SELECT1;
			text = ">"; //--- ToDo: Localize;
			x = 13.8 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_UnitMenu_Disselect1: ButtonMenuBase {
			idc = IDC_UNITMENU_BUTTON_UNITMENU_DISSELECT1;
			text = "<"; //--- ToDo: Localize;
			x = 13.8 * GUI_GRID_W + GUI_GRID_X;
			y = 10.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_UnitMenu_SelectAll: ButtonMenuBase {
			idc = IDC_UNITMENU_BUTTON_UNITMENU_SELECTALL;
			text = ">>"; //--- ToDo: Localize;
			x = 13.8 * GUI_GRID_W + GUI_GRID_X;
			y = 11.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_UnitMenu_DisselectAll: ButtonMenuBase {
			idc = IDC_UNITMENU_BUTTON_UNITMENU_DISSELECTALL;
			text = "<<"; //--- ToDo: Localize;
			x = 13.8 * GUI_GRID_W + GUI_GRID_X;
			y = 12.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};

class TTW_dlg_VehMenu { 
	idd = 1103;
	movingEnabled = false;
	enableSimulation = true;
	class controlsBackground {
		class Text_VehMenu_BG: TextBase
		{
			idc = IDC_VEHICE_TEXT_VEHMENU_BG;
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 15 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.8};
		};
	};

	class controls {
		class Text_VehMenu_Title: TextBase
		{
			idc = IDC_VEHICE_TEXT_VEHMENU_TITLE;
			text = ""; //--- ToDo: Localize;
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.48,0.5,0.35,1};
		};
	
		class LB_VehMenu_SelectVehicle: LBBase
		{
			idc = IDC_VEHICE_LB_VEHMENU_SELECTVEHICLE;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 13 * GUI_GRID_H;
		};
		class Frame_VehMenu_AccountData: FrameBase
		{
			idc = IDC_VEHICE_FRAME_VEHMENU_ACCOUNTDATA;
			text = ""; //--- ToDo: Localize;
			x = 21.6 * GUI_GRID_W + GUI_GRID_X;
			y = 5.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		class Text_VehMenu_FundsText: TextBase
		{
			idc = IDC_VEHICE_TEXT_VEHMENU_FUNDSTEXT;
			text = ""; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 5.8 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Text_VehMenu_FundsValue: TextBase
		{
			idc = IDC_VEHICE_TEXT_VEHMENU_FUNDSVALUE;
			text = ""; //--- ToDo: Localize;
			x = 25 * GUI_GRID_W + GUI_GRID_X;
			y = 5.8 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Text_VehMenu_AllVehiclesAvailable: TextBase
		{
			idc = IDC_VEHICE_TEXT_VEHMENU_ALLVEHICLESAVAILABLE;
			text = ""; //--- ToDo: Localize;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.48,0.5,0.35,1};
		};
		class Button_VehMenu_BuyUnit: ButtonMenuBase
		{
			idc = IDC_VEHICE_BUTTON_VEHMENU_BUYUNIT;
			x = 22.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};

class TTW_dlg_GearMenu { 
	idd = IDD_GEARMENU;
	movingEnabled = false;
	enableSimulation = true;
	class controlsBackground {
		class Text_GearMenu_BG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_BG;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 25.5 * GUI_GRID_W;
			h = 18 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.8};
		};
	};
	class controls {
		class Text_GearMenu_Title: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_TITLE;
			text = "Gear Menu"; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 25.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.48,0.5,0.35,1};
		};
		class Text_GearMenu_MoneyText: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_MONEYTEXT;
			text = "Money:"; //--- ToDo: Localize;
			x = 22.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Text_GearMenu_MoneyCount: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_MONEYCOUNT;
			text = "5000 $"; //--- ToDo: Localize;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Text_GearMenu_OverallCostText: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_OVERALLCOSTTEXT;
			text = "Cost:"; //--- ToDo: Localize;
			x = 23 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class Text_GearMenu_OverallCostValue: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_OVERALLCOSTVALUE;
			text = "500$"; //--- ToDo: Localize;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 5.5 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class Text_GearMenu_YourGearText: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_YOURGEARTEXT;
			text = "Your Gear"; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.48,0.5,0.35,0.8};
		};
		class Combo_GearMenu_SelType: ComboBase
		{
			idc = IDC_GEARMENU_COMBO_GEARMENU_SELTYPE;
			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class LB_GearMenu_SelGear: LBBase
		{
			idc = IDC_GEARMENU_LB_GEARMENU_SELGEAR;
			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 15.5 * GUI_GRID_H;
		};
		class LB_GearMenu_ViewGear: LBBase
		{
			idc = IDC_GEARMENU_LB_GEARMENU_VIEWGEAR;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 8 * GUI_GRID_H;
		};
		class Frame_GearMenu_AccountData: FrameBase
		{
			idc = IDC_GEARMENU_FRAME_GEARMENU_ACCOUNTDATA;
			text = "AccountData"; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		class Frame_GearMenu_Costs: FrameBase
		{
			idc = IDC_GEARMENU_FRAME_GEARMENU_COSTS;
			text = "Cost Information"; //--- ToDo: Localize;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 10.5 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;
		};
		class Button_GearMenu_Add1: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_ADD1;
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_GearMenu_BuyToCrate: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_BUYTOCRATE;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_GearMenu_BuyToInventory: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_BUYTOINVENTORY;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 7.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_GearMenu_Remove1: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_REMOVE1;
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_GearMenu_AddAll: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_ADDALL;
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_GearMenu_RemoveAll: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_REMOVEALL;
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 1.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};
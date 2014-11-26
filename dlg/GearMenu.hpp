#include "macros.sqf"
#include "GearMenuMacros.sqf"

class CT_DLG_GearMenu { 
	idd = 1101;
	movingEnabled = false;
	enableSimulation = true;
	class controlsBackground {
		class Text_GearMenu_BGMain: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_BGMAIN;
			x = 3 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 34 * GUI_GRID_W;
			h = 24 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.8};
		};
	};
	class controls {
		class Text_GearMenu_Title: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_TITLE;
			text = "Gear Menu"; //--- ToDo: Localize;
			x = 3 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 34 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.48,0.5,0.35,1};
		};
	
		class Picture_GearMenu_Binocular: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_BINOCULAR;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_binocular_gs.paa";
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class Picture_GearMenu_Glasses: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_GLASSES;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_glasses_gs.paa";
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class Picture_GearMenu_Helmet: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_HELMET;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_helmet_gs.paa";
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class Picture_GearMenu_NVG: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_NVG;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_nvg_gs.paa";
			x = 32.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class Picture_GearMenu_ItemGPS: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_ITEMGPS;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_gps_gs.paa";
			x = 6.8 * GUI_GRID_W + GUI_GRID_X;
			y = 7.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_ItemMap: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_ITEMMAP;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_map_gs.paa";
			x = 4.2 * GUI_GRID_W + GUI_GRID_X;
			y = 7.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_ItemRadio: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_ITEMRADIO;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_radio_gs.paa";
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 7.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_ItemWatch: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_ITEMWATCH;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_watch_gs.paa";
			x = 14.6 * GUI_GRID_W + GUI_GRID_X;
			y = 7.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_ItemCompass: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_ITEMCOMPASS;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_compass_gs.paa";
			x = 9.4 * GUI_GRID_W + GUI_GRID_X;
			y = 7.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_Uniform: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_UNIFORM;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_uniform_gs.paa";
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class Picture_GearMenu_Vest: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_VEST;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_vest_gs.paa";
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class Picture_GearMenu_Backpack: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_BACKPACK;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_backpack_gs.paa";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class Picture_GearMenu_PrimaryWeapon: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_PRIMARYWEAPON;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_primary_gs.paa";
			x = 24.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class Picture_GearMenu_PWMag: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_PWMAG;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_magazine_gs.paa";
			x = 32.7 * GUI_GRID_W + GUI_GRID_X;
			y = 9.8 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_PWTop: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_PWTOP;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_top_gs.paa";
			x = 28.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_PWSide: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_PWSIDE;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_side_gs.paa";
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 10.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_PWMuzzle: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_PWMUZZLE;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_muzzle_gs.paa";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.3 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_SecondaryWeapon: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_SECONDARYWEAPON;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_secondary_gs.paa";
			x = 24.7 * GUI_GRID_W + GUI_GRID_X;
			y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class Picture_GearMenu_SWMag: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_SWMAG;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_magazine_gs.paa";
			x = 32.7 * GUI_GRID_W + GUI_GRID_X;
			y = 16.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_SWTop: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_SWTOP;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_top_gs.paa";
			x = 28.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_SWSide: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_SWSIDE;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_side_gs.paa";
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 16.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_SWMuzzle: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_SWMUZZLE;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_muzzle_gs.paa";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_Backup: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_BACKUP;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_hgun_gs.paa";
			x = 25 * GUI_GRID_W + GUI_GRID_X;
			y = 20.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
		class Picture_GearMenu_BUMag: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_BUMAG;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_magazine_gs.paa";
			x = 32.7 * GUI_GRID_W + GUI_GRID_X;
			y = 22.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_BUTop: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_BUTOP;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_top_gs.paa";
			x = 28.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_BUSide: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_BUSIDE;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_side_gs.paa";
			x = 24 * GUI_GRID_W + GUI_GRID_X;
			y = 23.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class Picture_GearMenu_BUMuzzle: PictureBase
		{
			idc = IDC_GEARMENU_PICTURE_GEARMENU_BUMUZZLE;
			text = "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_muzzle_gs.paa";
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
		};
		class Text_GearMenu_UniformBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_UNIFORMBG;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_VestBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_VESTBG;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_BackpackBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_BACKPACKBG;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_HelmetBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_HELMETBG;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_GlassesBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_GLASSESBG;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_BinocularBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_BINOCULARBG;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_NVGBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_NVGBG;
			x = 32.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_PrimaryWeaponBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_PRIMARYWEAPONBG;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_PWMuzzleBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_PWMUZZLEBG;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 10.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_PWSideBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_PWSIDEBG;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_PWTopBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_PWTOPBG;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 10.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_PWMagBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_PWMAGBG;
			x = 32.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_SecondaryWeaponBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_SECONDARYWEAPONBG;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 4 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_SWMuzzleBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_SWMUZZLEBG;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_SWSideBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_SWSIDEBG;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_SWTopBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_SWTOPBG;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_SWMagBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_SWMAGBG;
			x = 32.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_BackUpBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_BACKUPBG;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 4 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_BUMuzzleBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_BUMUZZLEBG;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 23.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_BUSideBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_BUSIDEBG;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_BUTopBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_BUTOPBG;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 23.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_BUMagBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_BUMAGBG;
			x = 32.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_ItemMapBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_ITEMMAPBG;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_ItemGPSBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_ITEMGPSBG;
			x = 6.6 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_ItemCompassBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_ITEMCOMPASSBG;
			x = 9.2 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_ItemRadioBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_ITEMRADIOBG;
			x = 11.8 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_ItemWatchBG: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_ITEMWATCHBG;
			x = 14.4 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {0.3,0.3,0.3,0.2};
		};
		class Text_GearMenu_UniformUtilizationBar: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_UNIFORMUTILIZATIONBAR;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
		};
		class Text_GearMenu_VestUtilizationBar: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_VESTUTILIZATIONBAR;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
		};
		class Text_GearMenu_BackpackUtilizationBar: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_BACKPACKUTILIZATIONBAR;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
		};
		class Text_GearMenu_StaminaBar: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_STAMINABAR;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 24 * GUI_GRID_H + GUI_GRID_Y;
			w = 0 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {1,1,1,1};
		};
		class Text_GearMenu_FundsText: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_FUNDSTEXT;
			text = "Funds:"; //--- ToDo: Localize;
			x = 4.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class Text_GearMenu_FundsValue: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_FUNDSVALUE;
			text = "5000 $"; //--- ToDo: Localize;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 8.5 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class Text_GearMenu_CostsText: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_COSTSTEXT;
			text = "Costs:"; //--- ToDo: Localize;
			x = 4.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class Text_GearMenu_CostsValue: TextBase
		{
			idc = IDC_GEARMENU_TEXT_GEARMENU_COSTSVALUE;
			text = " 5000 $"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 9 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class Frame_GearMenu_UniformUtilizationFrame: FrameBase
		{
			idc = IDC_GEARMENU_FRAME_GEARMENU_UNIFORMUTILIZATIONFRAME;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class Frame_GearMenu_BackpackUtilizationFrame: FrameBase
		{
			idc = IDC_GEARMENU_FRAME_GEARMENU_BACKPACKUTILIZATIONFRAME;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class Frame_GearMenu_VestUtilizationFrame: FrameBase
		{
			idc = IDC_GEARMENU_FRAME_GEARMENU_VESTUTILIZATIONFRAME;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
		};
		class Frame_GearMenu_AccountInformation: FrameBase
		{
			idc = IDC_GEARMENU_FRAME_GEARMENU_ACCOUNTINFORMATION;
			text = "Account Information"; //--- ToDo: Localize;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
		};
		class Frame_GearMenu_CostInformation: FrameBase
		{
			idc = IDC_GEARMENU_FRAME_GEARMENU_COSTINFORMATION;
			text = "Cost Information"; //--- ToDo: Localize;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 5 * GUI_GRID_H;
		};
		class Frame_GearMenu_Options: FrameBase
		{
			idc = IDC_GEARMENU_FRAME_GEARMENU_OPTIONS;
			text = "Options"; //--- ToDo: Localize;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 4.5 * GUI_GRID_H;
		};
		class Frame_GearMenu_StaminaFrame: FrameBase
		{
			idc = IDC_GEARMENU_FRAME_GEARMENU_STAMINAFRAME;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 24 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_GearMenu_BuyGear: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_BUYGEAR;
			text = "Buy Gear"; //--- ToDo: Localize;
			x = 4.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 5.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_GearMenu_BuyAndSave: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_BUYANDSAVE;
			text = "Buy and Save"; //--- ToDo: Localize;
			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_GearMenu_RemoveAllGear: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_REMOVEALLGEAR;
			text = "Remove all Gear"; //--- ToDo: Localize;
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_GearMenu_ResetGear: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_RESETGEAR;
			text = "Reset Gear"; //--- ToDo: Localize;
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			w = 8.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Button_GearMenu_MenuUniform: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUUNIFORM;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuVest: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUVEST;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuBackpack: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUBACKPACK;
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuHelmet: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUHELMET;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuGlasses: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUGLASSES;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuBinocular: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUBINOCULAR;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuNVG: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUNVG;
			x = 32.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuItems: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUITEMS;
			x = 4 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuPrimaryWeapon: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUPRIMARYWEAPON;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuSecondaryWeapon: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUSECONDARYWEAPON;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 4 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuBackup: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUBACKUP;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.5 * GUI_GRID_W;
			h = 4 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuPWMuzzle: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUPWMUZZLE;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 10.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuPWSide: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUPWSIDE;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuPWTop: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUPWTOP;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 10.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuPWMag: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUPWMAG;
			x = 32.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuSWMuzzle: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUSWMUZZLE;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuSWSide: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUSWSIDE;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuSWTop: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUSWTOP;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuSWMag: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUSWMAG;
			x = 32.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuBUMuzzle: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUBUMUZZLE;
			x = 19 * GUI_GRID_W + GUI_GRID_X;
			y = 23.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuBUSide: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUBUSIDE;
			x = 23.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuBUTop: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUBUTOP;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 23.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
		class Button_GearMenu_MenuBUMag: ButtonMenuBase
		{
			idc = IDC_GEARMENU_BUTTON_GEARMENU_MENUBUMAG;
			x = 32.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};	
	};
};
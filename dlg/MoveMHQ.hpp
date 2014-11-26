#include "macros.sqf"

class TTW_dlg_MobHQ { 
	idd = 1001;
	movingEnabled = false;
	enableSimulation = true;
	
	class controlsBackground {
		class BgMiddle: BackgroundMiddle
		{
			idc = 1100;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 4 * GUI_GRID_H;
		};
		class BGTop: BackgroundTop
		{
			idc = 1101;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;	
		};
	};
	class controls {
		//Controls
		class ButtonYes: ButtonBase
		{
			idc = 1700;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorFocused[] = { 1, 1, 1, 1 };
			colorBackgroundFocused[] = { 1, 1, 1, 0 };
		};
		class ButtonNo: ButtonBase
		{
			idc = 1701;
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorFocused[] = { 1, 1, 1, 1 };
			colorBackgroundFocused[] = { 1, 1, 1, 0 };
		};
		class InfoText: StructuredTextBase
		{
			idc = 1300;
			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {-1,-1,-1,0};
		};
	};
};


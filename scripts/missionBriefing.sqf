/****************************************************************
ARMA Mission Development Framework
ADF version: 1.10 / JUN 2014

Script: Mission Briefing
Author: Whiztler
Script version: 1.0

Game type: COOP
File: ADF_Briefing.sqf
****************************************************************
Instructions:

Note the reverse order of topics. Start from the bottom.
Change the "Text goes here..." line with your info. Use a <br/> to
start a new line.
****************************************************************/

player createDiarySubject ["TeeTime's Warfare","TeeTime's Warfare"];
player createDiaryRecord ["TeeTime's Warfare",["TeeTime's Warfare","
<img image='images\arma3pro_logo.paa'/><br/>
TeeTime's Warfare TVT mission ArmA 3 Pro Edit<br/>
ArmA 3 Pro Steam Community<br/>
version: 0654 / DEC 2014
<br/><br/>
"]];

///// CREDITS

player createDiaryRecord ["Diary",["Credits","
<font color='#6C7169'>ArmA 3 Pro Mission Framework Modification by Gentoo, GunnyTomHighway, ths</font><br/><br/>
<font color='#6C7169'>TcB AIS Wounding System by psycho</font><br/><br/>
<font color='#6C7169'>Core Mission framework by TeeTime</font><br/><br/>
<font color='#6C7169'>Briefing script and inspiration from Wolfpack missions by Whiztler</font><br/><br/>

<font color='#6C7169'>Numerous scripts and code snippets from the talented mission makers. I've tried my best to include all your work credits. If I've forgot to give proper credits, let me know, and I'll include you immediately.</font><br/><br/>
"]];

///// SUPPORT & LOGISTICS

player createDiaryRecord ["Diary",["M.O.B. & Logistics","

<font color='#9da698' size='14'>PLAYER RESPAWN / PLAYER JIP</font><br/>
<font color='#6C7169'>Respawn is available at the Mobile HQ, or in captured towns.<br/>
<font color='#6C7169'>Only Combat Life Saver trained unit can try and revive injured soldiers, and the possibility of revive action depends on the severity of wounds; ie. player dies instantly and cannot be revived if shot in the head, or the unit has been injured by multiple gun wounds, high-calibre rounds and explosions.<br/>
JIP is enabled. New players join and spawn at the Mobile HQ.</font>

<br/><br/><font color='#9da698' size='14'>PLAYER LOADOUT</font><br/>
<font color='#6C7169'>Pre-defined, role-specific loadout</font>

<br/><br/><font color='#9da698' size='14'>VEHICLE RESPAWN</font><br/>
<font color='#6C7169'>Vehicle spawn system is tied to the mission income dynamics.</font><br/>
<font color='#6C7169'>Depending on player and your side income, players can purchase vehicles from Mobile HQ, and some vehicles can be bought at captured towns.</font>

<br/><br/><font color='#9da698' size='14'>VEHICLE SUPPLY CARGO</font><br/>
<font color='#6C7169'>Players can store and swap Gear, Ammo, Weapons and other purchased/owned items in the vehicles.</font>

<br/><br/><font color='#9da698' size='14'>TRANSPORT ARRANGEMENTS</font><br/>
<font color='#6C7169'>Your team units will spawn at the Mobile HQ at random position on the mission start. Squad and Team leaders can move the Mobile HQ at their discretion to another strategic position, no closer than 300m from non-captured objective markers.<br/>
The Mobile HQ has a single seat enabled just for driver.</font><br/>
<font color='#6C7169'>Other units must purchase a vehicle such as transport truck or off-road etc. vehicles to move to objective.</font>
"]];


///// SIGNAL & COMMS

player createDiaryRecord ["Diary",["Comms & Signal","
<font color='#9da698' size='14'>COMMS</font><br/>
<font color='#6C7169'>SQUAD NET - Long Range Radio Channel 1<br/>
<font color='#6C7169'>ALPHA - Short Range Radio Channel 1<br/>
<font color='#6C7169'>BRAVO - Short Range Radio Channel 2<br/>
<font color='#6C7169'>Make sure to switch and sync your Squad/Team Channel Frequency once your unit has fallen near enemy, as there is a great possibility of enemy taking your radio and eavesdrop on your transmissions!<br/><br/>
<font color='#9da698' size='14'>SIGNALS</font><br/>
<font color='#6C7169'>White smoke - smoke concealment. No signal<br/>
Green Smoke - safe area signal<br/>
Red Smoke - hostiles area signal (position known)<br/>
Orange smoke -  hostiles area signal (position unknown)<br/><br/>
Green chemlight - Safe/Searched (in buildings)<br/>
Red chemlight - Not Safe/Not searched (in buildings)</font>
"]];


///// TACTICAL PLAN & EXECUTION

player createDiaryRecord ["Diary",["Tactical / Execution","

<font color='#9da698' size='14'>CONCEPT OF OPERATIONS</font><br/>
<font color='#6C7169'>The mission is meant to be played with Tactical teamplay, emphasis on raw infantry engagement in mind.<br/>
<br/>A strategic objective element is hard-coded in the mission. That means that your team can chose your first objective target and capture it, but further objectives must be captured in strategic order, which is shown with connection link on the map. If your team loses an already captured objective, you have to capture it back before you can move to next objective.
<br/>You can choose objective number in the mission parameters, as well with the other mission parameters at the mission load.<br/>
The mission ends once a Side had captured all objectives.</font>
<br/><br/><font color='#9da698' size='14'>FIG. 1 - SAMPLE STRATEGIC OBJECTIVES</font><br/>
<img image='images\strategic_links.jpg'/>

<br/><br/><font color='#9da698' size='14'>TACTICAL MOVEMENT</font><br/>
<font color='#6C7169'>Squad teams will relocate in a bounding fashion unless otherwise ordered. Your teams are best to follow your Squad leader orders and tactical deployment to minimize your side unit losses and maximize your tactical objective gains and eventual Victory.</font>

<font color='#6C7169'><br/><br/><font color='#9da698' size='14'>WEAPONS/FIRE SUPPORT</font><br/>
No support available.</font>

<br/><br/><font color='#9da698' size='14'>SPECIAL OPERATIONS</font><br/>
<font color='#6C7169'>No other operations available.</font>

<br/><br/><font color='#9da698' size='14'>CALL SIGN</font><br/>
<font color='#6C7169'>ALPHA 1-1 : ALPHA</font><br/>
<font color='#6C7169'>ALPHA 1-2 : BRAVO</font>
"]];


///// OBJECTIVES

player createDiaryRecord ["Diary",["Objectives","

<font color='#9da698' size='14'>MISSION OBJECTIVES</font><br/>
<font color='#6C7169'>Due to the sensitivity of the mission, objectives will be given on a need to know basis once you have reached the first objective. Make sure to send a Scout team to an non-captured objective to get the current status of the objective capture status. If you haven't scouted an objective, you won't be able to see whether the opposing side is capturing the objective, until it has been captured by the opposing side.</font>
"]];


///// SITUATION

player createDiaryRecord ["Diary",["Situation","

<font color='#9da698' size='14'>SUMMARY</font><br/>
<font color='#6C7169'>June 2034, Altis is in turmoil. The island has been cut off from the outside world due to economical and physical blockades. Since then the local populous has grown impatient with the government and the AAF in particular. Several demonstrations have resulted in the deaths of tens of civilians.<br/>
The government felt like they were losing control rapidly and called in the help from CSAT. A mistake that would cost them dearly. CSAT saw a golden opportunity to get a much needed foothold in the Mediterranean area. The AAF asked for a single battalion of CSAT forces. Instead CSAT send the entire 2nd brigade. CSAT outnumbered AAF by 1:11. Altis government realized that they had lost control completely and stepped down. CSAT General Tehrani has since been in power and controls all of Altis and Stratis.<br/><br/>
CSAT is now proven a serious threat to the European region. As diplomatic efforts have not lead to the anticipated result, NATO has decided to send a rapid task force to free both islands from the CSAT oppression.</font>

<br/><br/><font color='#9da698' size='14'>INTEL ON ENEMY FORCES</font><br/>
<font color='#6C7169'>Our first area of operation covers Stratis. Signit has confirmed the presence of 1 infantry Guard Team at each non-captured objective.</font>

<br/><br/><font color='#9da698' size='14'>YOUR SQUAD FORCES</font><br/>
<font color='#6C7169'>Two Teams:<br/>
Two assault teams (AT) - each with it's Team Leader, and 4 Assault Specialists<br/><br/>
Both side Team elements comprised of Team Leader, Rifleman, Automatic Rifleman, Rifleman AT, and Combat Life Saver.<br/><br/></font>
"]];
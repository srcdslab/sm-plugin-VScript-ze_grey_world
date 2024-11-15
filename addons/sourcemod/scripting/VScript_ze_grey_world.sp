#pragma semicolon 1
#pragma newdecls required

#include <vscripts>

#define MAP_NAME "ze_grey_world_css"

bool g_bValidMap = false;

public Plugin myinfo =
{
	name = "ze_grey_world vscripts",
	author = "koen",
	description = "",
	version = "",
	url = "https://github.com/notkoen" // with code taken from https://github.com/srcdslab/sm-plugin-VScript-Geometric
};

//----------------------------------------------------------------------------------------------------
// Purpose: Global Functions
//----------------------------------------------------------------------------------------------------
void RandomSpawn(int entity, int _x1, int _x2, int _y1, int _y2, int _z1, int _z2, float _c1, float _c2, float _c3)
{
	float orig[3], buf[3];
	Vscripts_GetOrigin(entity, orig);
	buf[0] = GetRandomInt(_x1, _x2) * _c1;
	buf[1] = GetRandomInt(_y1, _y2) * _c2;
	buf[2] = GetRandomInt(_z1, _z2) * _c3;
	AddVectors(orig, buf, buf);
	Vscripts_SetOrigin(entity, buf);
	AcceptEntityInput(entity, "ForceSpawn");
	Vscripts_SetOrigin(entity, orig);
}

//----------------------------------------------------------------------------------------------------
// Purpose: Events
//----------------------------------------------------------------------------------------------------
public void OnMapStart()
{
	char sBuffer[256];
	GetCurrentMap(sBuffer, sizeof(sBuffer));
	g_bValidMap = (strcmp(sBuffer, MAP_NAME, false) == 0);
	if (g_bValidMap)
	{
		HookEvent("round_start", OnRoundStart, EventHookMode_PostNoCopy);
	}
	else
	{
		GetPluginFilename(INVALID_HANDLE, sBuffer, sizeof(sBuffer));
		ServerCommand("sm plugins unload %s", sBuffer);
	}
}

public void OnMapEnd()
{
	if (g_bValidMap)
		UnhookEvent("round_start", OnRoundStart, EventHookMode_PostNoCopy);
	g_bValidMap = false;
}

public void OnRoundStart(Event event, const char[] name, bool dontBroadcast)
{
	// Level 1
	int index = Vscripts_GetEntityIndexByName("lvl1_cube_line_maker");
	HookSingleEntityOutput(index, "OnUser1", Level1_CubeLine);
	index = Vscripts_GetEntityIndexByName("lvl1_final_push_maker");
	HookSingleEntityOutput(index, "OnUser1", Level1_FinalPush);

	// Level 2
	index = Vscripts_GetEntityIndexByName("lvl2_boss_skill1_maker");
	HookSingleEntityOutput(index, "OnUser1", Level2_BossSkill1);
	index = Vscripts_GetEntityIndexByName("lvl2_boss_skill2_maker");
	HookSingleEntityOutput(index, "OnUser1", Level2_BossSkill2);
	index = Vscripts_GetEntityIndexByName("lvl2_final_cube_line_maker1");
	HookSingleEntityOutput(index, "OnUser1", Level2_CubeLineMaker);
	index = Vscripts_GetEntityIndexByName("lvl2_final_cube_line_maker2");
	HookSingleEntityOutput(index, "OnUser1", Level2_CubeLineMaker);

	// Level 3
	index = Vscripts_GetEntityIndexByName("lvl3_push_line_maker1");
	HookSingleEntityOutput(index, "OnUser1", Level3_PushLine);
	index = Vscripts_GetEntityIndexByName("lvl3_push_line_maker2");
	HookSingleEntityOutput(index, "OnUser1", Level3_PushLine);
	index = Vscripts_GetEntityIndexByName("lvl3_boss_skill1_maker");
	HookSingleEntityOutput(index, "OnUser1", Level3_BossSkill1);
	index = Vscripts_GetEntityIndexByName("lvl3_ending_beam_maker");
	HookSingleEntityOutput(index, "OnUser1", Level3_EndingBeam);
	index = Vscripts_GetEntityIndexByName("lvl3_ending_maker");
	HookSingleEntityOutput(index, "OnUser1", Level3_Ending);

	// Level 4
	index = Vscripts_GetEntityIndexByName("lvl4_cube1_beam_maker");
	HookSingleEntityOutput(index, "OnUser1", Level4_Cube1Beam);
	index = Vscripts_GetEntityIndexByName("lvl4_cube3_danmaku_maker");
	HookSingleEntityOutput(index, "OnUser1", Level4_Cube3Danmaku);
	index = Vscripts_GetEntityIndexByName("lvl4_boss_skill3_maker");
	HookSingleEntityOutput(index, "OnUser1", Level4_BossSkill3_1);
	index = Vscripts_GetEntityIndexByName("lvl4_boss_skill3_maker2");
	HookSingleEntityOutput(index, "OnUser1", Level4_BossSkill3_2);
	index = Vscripts_GetEntityIndexByName("lvl4_boss_skill6_maker");
	HookSingleEntityOutput(index, "OnUser1", Level4_BossSkill6);
	index = Vscripts_GetEntityIndexByName("lvl4_boss_skill7_maker");
	HookSingleEntityOutput(index, "OnUser1", Level4_BossSkill7);
	index = Vscripts_GetEntityIndexByName("lvl4_final_push_maker");
	HookSingleEntityOutput(index, "OnUser1", Level4_FinalPush);
	index = Vscripts_GetEntityIndexByName("lvl4_final_boss_danmaku_maker");
	HookSingleEntityOutput(index, "OnUser1", Level4_FinalBossDanmaku);
	index = Vscripts_GetEntityIndexByName("lvl4_final_boss_beam_maker");
	HookSingleEntityOutput(index, "OnUser1", Level4_FinalBossBeam);

	// RTV
	index = Vscripts_GetEntityIndexByName("rtv_beam_maker");
	HookSingleEntityOutput(index, "OnUser1", RTV_Beam);
}

//----------------------------------------------------------------------------------------------------
// Purpose: EntityOutput RandomSpawn Callback
//----------------------------------------------------------------------------------------------------
// Level 1
public void Level1_CubeLine(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, 0, 0, -864, 864, -864, 864, 1.0, 1.0, 1.0);
}

public void Level1_FinalPush(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -128, 128, -128, 128, 0, 0, 1.0, 1.0, 1.0);
}

// Level 2
public void Level2_BossSkill1(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, 0, 0, -192, 192, 0, 0, 1.0, 1.0, 1.0);
}

public void Level2_BossSkill2(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -640, 640, -256, 256, 0, 0, 1.0, 1.0, 1.0);
}

public void Level2_CubeLineMaker(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, 0, 0, -256, 256, -768, 768, 1.0, 1.0, 1.0);
}

// Level 3
public void Level3_PushLine(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -192, 192, -96, 96, 0, 0, 1.0, 1.0, 1.0);
}

public void Level3_BossSkill1(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, 0, 0, -128, 128, 0, 0, 1.0, 1.0, 1.0);
}

public void Level3_EndingBeam(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -128, 128, -128, 128, 0, 0, 1.0, 1.0, 1.0);
}

public void Level3_Ending(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -256, 256, -256, 256, 0, 0, 1.0, 1.0, 1.0);
}

// Level 4
public void Level4_Cube1Beam(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -768, 768, -768, 768, 0, 0, 1.0, 1.0, 1.0);
}

public void Level4_Cube3Danmaku(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, 0, 0, -416, 416, -32, 32, 1.0, 1.0, 1.0);
}

public void Level4_BossSkill3_1(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -576, 576, 0, 0, 0, 0, 1.0, 1.0, 1.0);
}

public void Level4_BossSkill3_2(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -608, 608, 0, 0, 0, 0, 1.0, 1.0, 1.0);
}

public void Level4_BossSkill6(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -576, 576, 0, 0, 0, 0, 1.0, 1.0, 1.0);
}

public void Level4_BossSkill7(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -576, 576, 0, 0, 0, 0, 1.0, 1.0, 1.0);
}

public void Level4_FinalPush(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -128, 128, -256, 256, 0, 0, 1.0, 1.0, 1.0);
}

public void Level4_FinalBossDanmaku(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, 0, 0, -256, 256, 0, 0, 1.0, 1.0, 1.0);
}

public void Level4_FinalBossBeam(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, 0, 0, -192, 192, 0, 0, 1.0, 1.0, 1.0);
}

// RTV
public void RTV_Beam(const char[] output, int caller, int activator, float delay)
{
	RandomSpawn(caller, -540, 540, -540, 540, 0, 0, 1.0, 1.0, 1.0);
}

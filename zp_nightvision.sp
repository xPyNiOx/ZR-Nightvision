/*
	Simply tell all players to bind themselfs command "nightvision" to to the selected key.
*/

#define PLUGIN_AUTHOR "PyNiO"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <sdkhooks>
#include <zombiereloaded>
#include <franug_zp>

EngineVersion g_Game;

public Plugin myinfo = 
{
	name = "Zombie Plague - NightVision",
	author = PLUGIN_AUTHOR,
	description = "Give humans night vision goggles",
	version = PLUGIN_VERSION,
	url = ""
};

public void OnPluginStart()
{
	g_Game = GetEngineVersion();
	if(g_Game != Engine_CSGO && g_Game != Engine_CSS)
	{
		SetFailState("This plugin is for CSGO/CSS only.");	
	}
	
	HookEvent("player_spawn", OnPlayerSpawn);
}

public Action OnPlayerSpawn(Event eEvent, const char[] sName, bool bDontBroadcast)
{
	new client = GetClientOfUserId(eEvent.GetInt("userid"));
	
	if(IsValidPlayer(client) && ZR_IsClientHuman(client))
	{
		CreateTimer(5.0, Timer_NVGS, client);
	}	
}

public Action Timer_NVGS(Handle timer, int client)
{
	if(IsValidPlayer(client))
		GivePlayerItem(client, "item_nvgs");
}

stock bool IsValidPlayer(int client)
{
	if (client >= 1 && client <= MaxClients && IsClientConnected(client) && !IsFakeClient(client) && IsClientInGame(client))
		return true;
	
	return false;
}
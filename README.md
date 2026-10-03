# I Remember You — WotLK 3.3.5a port for DragonUI

Remember the players you meet. Leave a note and a mood (good, neutral, bad) on anyone, and the game
reminds you the next time you run into them.

This is an **unofficial port** of *I Remember You* by **Bettiold** (published on CurseForge) to the Wrath of the Lich King 3.3.5a client (build 12340), restyled to sit alongside
[DragonUI](https://github.com/NeticSoul/DragonUI). All credit for the original addon goes to Bettiold.

## Requirements

- WoW 3.3.5a (12340)
- [DragonUI](https://github.com/NeticSoul/DragonUI) — required; the window art, red buttons and shared
  libraries (LibStub, CallbackHandler) come from it.

## Install

Copy the `IRememberYou` folder into `Interface\AddOns\`.

## What it does

- **Notes on players:** `/memory` (or `/remember`, or the minimap button) opens the list. Add,
  search, edit and delete notes; sort by name or by mood.
- **Remember from the right-click menu** of a player (target, party, raid, chat names). The entry is
  never added in combat, so the menu's protected actions keep working.
- **Reminders:** the note is added to the player's tooltip, printed and announced on screen when they
  join your group, and a tag on the target frame shows their mood — red for bad, green for good,
  white for neutral. The tag updates the moment you edit a note.
- **Class:** filled in automatically when the game can tell (target, focus, mouseover, group,
  friends list, guild); otherwise pick it from the class dropdown.
- **Remember the whole group** after a dungeon's final boss: a chat link offers to note everyone at
  once.

## Port notes

What changed from the retail/classic original to run on 3.3.5a:

- Stand-ins for APIs the client lacks (`GetNumGroupMembers`, `IsInRaid`, `GetServerTime`,
  `C_Timer.After`, …); 3.3.5 party/raid events instead of `GROUP_ROSTER_UPDATE`.
- 3.3.5 has no `BOSS_KILL`: the end-of-dungeon prompt watches the combat log for each dungeon's last
  encounter (creature and credit-spell IDs from TrinityCore's `instance_encounters`).
- Dragonflight-style window and dialog built from DragonUI's art; the 3.3.5 popup's edit box
  could not be widened cleanly.
- Textures converted to power-of-two, uncompressed TGA.
- Uses DragonUI's copy of CallbackHandler: the modern one bundled with the original would replace
  DragonUI's in memory with a version that calls functions 3.3.5 does not have.

## Tests

`lua5.1 qa/test_load.lua` (from the repository root) loads the addon on a stub 3.3.5a client and
drives its flows: login, group join and leave, tooltip, target tag, right-click menu, the
end-of-dungeon prompt, the Remember dialog and its class dropdown. It expects DragonUI's libraries at
`/root/DOWNPORTPT2/DragonUI` (change the `dragon` path in the test to point elsewhere).

-- qa/test_load.lua — loads IRememberYou under plain Lua 5.1 with a 3.3.5a-shaped stub client and drives
-- its flows. Reading any global the 3.3.5 client does not have is an error, so a modern-only API left in
-- the port fails here instead of in game.   lua5.1 qa/test_load.lua   (from the repo root)
local ADDON = "IRememberYou/"
local fails = 0
local function ok(c, what) if c then print("ok    "..what) else fails = fails + 1; print("FAIL  "..what) end end

-- widgets: any method exists (returns nil) unless given; scripts are recorded so tests can fire them
local frames, named = {}, {}
local function widget(kind, name)
  local o = { _kind = kind, _scripts = {}, _shown = true, _name = name }
  local mt = {}
  mt.__index = function(t, k)
    local real = {
      SetScript = function(self, s, f) self._scripts[s] = f end,
      HookScript = function(self, s, f) local old = self._scripts[s]; self._scripts[s] = function(...) if old then old(...) end f(...) end end,
      GetScript = function(self, s) return self._scripts[s] end,
      Show = function(self) self._shown = true end, Hide = function(self) self._shown = false end,
      IsVisible = function(self) return self._shown end, IsShown = function(self) return self._shown end,
      GetName = function(self) return self._name end,
      CreateTexture = function(self) return widget("Texture") end,
      CreateFontString = function(self) return widget("FontString") end,
      GetFrameLevel = function() return 1 end, GetFrameStrata = function() return "MEDIUM" end,
      GetObjectType = function(self) return self._kind end, GetRegions = function() return widget("Texture") end,
      GetThumbTexture = function() return widget("Texture") end,
      GetText = function(self) return self._text or "" end, SetText = function(self, v) self._text = v end,
      GetUnit = function() return "Bob", "mouseover" end, GetEffectiveScale = function() return 1 end,
      GetCenter = function() return 0, 0 end, IsMouseOver = function() return false end,
      GetTexture = function() return "Interface\\Minimap\\MiniMap-TrackingBorder" end,
      GetPoint = function() return "TOPLEFT", nil, "TOPLEFT", 0, 0 end, GetChildren = function() end,
      GetNormalTexture = function(self) local k = "_nt" if not rawget(self, k) then rawset(self, k, widget("Texture")) end return rawget(self, k) end,
      GetPushedTexture = function(self) local k = "_pt" if not rawget(self, k) then rawset(self, k, widget("Texture")) end return rawget(self, k) end,
      GetHighlightTexture = function(self) local k = "_ht" if not rawget(self, k) then rawset(self, k, widget("Texture")) end return rawget(self, k) end,
      GetDisabledTexture = function(self) local k = "_dt" if not rawget(self, k) then rawset(self, k, widget("Texture")) end return rawget(self, k) end,
      EnableMouse = function(self, on) self._mouse = on end,
      SetVertexColor = function(self, r, g, b) rawset(self, "_color", { r, g, b }) end,
      AddLine = function(self, l) if not rawget(self, "_lines") then rawset(self, "_lines", {}) end; self._lines[#self._lines + 1] = l end,
    }
    if real[k] then return real[k] end
    if kind == "FontString" and k == "SetScript" then return nil end
    -- 3.3.5 has none of these; touching one is the bug this harness exists for
    if k == "SetClipsChildren" or k == "SetShown" or k == "SetColorTexture" or k == "SetFixedFrameStrata" or k == "SetFixedFrameLevel" then
      error("3.3.5 widget has no method "..k, 2)
    end
    if kind == "FontString" and (k == "SetScript" or k == "HookScript") then error("FontString:"..k.." does not exist on 3.3.5", 2) end
    return function() end
  end
  setmetatable(o, mt)
  if name then named[name] = o end
  frames[#frames + 1] = o
  return o
end

local env = {}
local G = {
  print = function(...) local t = {} for i = 1, select("#", ...) do t[#t + 1] = tostring((select(i, ...))) end env._printed[#env._printed + 1] = table.concat(t, " ") end,
  pairs = pairs, ipairs = ipairs, select = select, type = type, tostring = tostring, tonumber = tonumber,
  unpack = unpack, next = next, error = error, assert = assert, xpcall = xpcall, rawset = rawset, geterrorhandler = function() return print end, debugstack = function() return "" end, pcall = pcall, setmetatable = setmetatable, rawget = rawget,
  string = string, table = table, math = math, loadstring = loadstring, setfenv = setfenv, getmetatable = getmetatable,
  floor = math.floor, min = math.min, max = math.max, abs = math.abs, time = os.time,
  strsplit = function(d, s) local t = {} for p in (s..d):gmatch("(.-)"..d:gsub("%p","%%%0")) do t[#t+1] = p end return unpack(t) end,
  strtrim = function(s) return (s:gsub("^%s+",""):gsub("%s+$","")) end,
  tinsert = table.insert, tremove = table.remove, sort = table.sort, format = string.format, wipe = function(t) for k in pairs(t) do t[k] = nil end return t end,
  strmatch = string.match, strfind = string.find, strsub = string.sub, strlen = string.len, strlower = string.lower, strupper = string.upper, gsub = string.gsub, strrep = string.rep, strjoin = function(d, ...) return table.concat({...}, d) end, ceil = math.ceil, mod = math.fmod, random = math.random,
  GetBuildInfo = function() return "3.3.5", "12340", "Jun 24 2010", 30300 end,
  GetLocale = function() return "enUS" end, GetTime = function() return env.now end,
  GetRealmName = function() return "TSWoW" end,
  GetNumRaidMembers = function() return 0 end, GetNumPartyMembers = function() return env.party end,
  UnitName = function(u) return env.units[u] and env.units[u].name end,
  UnitClass = function(u) local x = env.units[u] if x then return x.class, x.class end end,
  UnitExists = function(u) return env.units[u] ~= nil end, UnitIsPlayer = function(u) return env.units[u] ~= nil end,
  GetCursorPosition = function() return 0, 0 end, PlaySound = function(s) assert(type(s) == "string", "PlaySound wants a name on 3.3.5") end,
  CreateFrame = function(kind, name, parent, template)
    local w = widget(kind, name)
    rawset(w, "_parent", parent)
    if name and template == "OptionsSliderTemplate" then for _, c in ipairs({ "Low", "High", "Text" }) do widget("FontString", name .. c) end end
    return w
  end,
  CreateFont = function(name) local f = widget("Font", name) return f end,
  hooksecurefunc = function(a, b, c)
    if type(a) == "string" then local orig = env.G[a]; assert(orig, "hooksecurefunc on missing "..a)
      env.G[a] = function(...) local r = { orig(...) } b(...) return unpack(r) end
    else local orig = a[b]; a[b] = function(...) orig(...) c(...) end end
  end,
  ChatFrame_AddMessageEventFilter = function(ev, f) env.filters[ev] = f end,
  ChatEdit_FocusActiveWindow = function() end,
  StaticPopup_Show = function(which, a, b, data) env.popup = { which = which, data = data } local p = named.StaticPopup1 return p end,
  UIDropDownMenu_CreateInfo = function() return {} end,
  UIDropDownMenu_Initialize = function(f, fn) rawset(f, "_init", fn) end,
  UIDropDownMenu_SetText = function(f, t) rawset(f, "_dtext", t) end,
  UIDropDownMenu_SetWidth = function() end, CloseDropDownMenus = function() end,
  UIDropDownMenu_DisableDropDown = function(f) rawset(f, "_disabled", true) end,
  UIDropDownMenu_EnableDropDown = function(f) rawset(f, "_disabled", false) end,
  CLASS = "Class",
  UIDropDownMenu_AddButton = function(info) env.menu[#env.menu + 1] = info end,
  UnitPopup_ShowMenu = function() end,
  SetItemRef = function(link) env.itemref = link end,
  SendChatMessage = function() end,
  UISpecialFrames = {}, StaticPopupDialogs = {}, SlashCmdList = {},
  CLASS_ICON_TCOORDS = { WARRIOR = {0,0.25,0,0.25}, MAGE = {0.25,0.5,0,0.25}, ROGUE = {0,1,0,1}, DRUID = {0,1,0,1}, HUNTER = {0,1,0,1}, SHAMAN = {0,1,0,1}, PRIEST = {0,1,0,1}, WARLOCK = {0,1,0,1}, PALADIN = {0,1,0,1}, DEATHKNIGHT = {0,1,0,1} },
  UNKNOWN = "Unknown",
  LOCALIZED_CLASS_NAMES_MALE = { WARRIOR = "Warrior", DRUID = "Druid", MAGE = "Mage" }, LOCALIZED_CLASS_NAMES_FEMALE = { WARRIOR = "Warrior" },
  RAID_CLASS_COLORS = { WARRIOR = { r = 1, g = 0.5, b = 0.3 }, MAGE = { r = 0.4, g = 0.8, b = 1 }, DRUID = { r = 1, g = 0.49, b = 0.04 }, ROGUE = { r = 1, g = 0.96, b = 0.41 }, HUNTER = { r = 0.67, g = 0.83, b = 0.45 }, SHAMAN = { r = 0, g = 0.44, b = 0.87 }, PRIEST = { r = 1, g = 1, b = 1 }, WARLOCK = { r = 0.58, g = 0.51, b = 0.79 }, PALADIN = { r = 0.96, g = 0.55, b = 0.73 }, DEATHKNIGHT = { r = 0.77, g = 0.12, b = 0.23 } },
  SETTINGS = "Settings", GameFontNormal = {}, GameFontHighlight = {}, GameFontDisable = {},
  GetNumFriends = function() return 1 end, GetFriendInfo = function(i) return "Alice", 80, "Warrior" end,
  IsInGuild = function() return false end, GetNumGuildMembers = function() return 0 end,
  YES = "Yes", NO = "No", DONE = "Done", CANCEL = "Cancel", STANDARD_TEXT_FONT = "Fonts\\FRIZQT__.TTF",
  UIDROPDOWNMENU_MENU_LEVEL = 1,
  InCombatLockdown = function() return env.combat end,
  UnitIsUnit = function(a, b) return a == b end,
  GameFontHighlightMedium = {}, ChatFontNormal = {},
  IsAddOnLoaded = function() return false end,
  GetMinimapShape = function() return "ROUND" end,
}
env.G = G
env.addonTable = {}
env.unknown = {}
env.now, env.party, env.units, env.filters, env.menu, env._printed = 100, 0, { player = { name = "Me", class = "MAGE" } }, {}, {}, {}
G.UIParent, G.Minimap = widget("Frame", "UIParent"), widget("Frame", "Minimap")
G.TargetFrame, G.TargetFramePortrait = widget("Frame", "TargetFrame"), widget("Texture", "TargetFramePortrait")
G.StaticPopup1, G.StaticPopup1EditBox, G.StaticPopup1Text = widget("Frame", "StaticPopup1"), widget("EditBox", "StaticPopup1EditBox"), widget("FontString", "StaticPopup1Text")
G.StaticPopup1Button1, G.StaticPopup1Button2 = widget("Button", "StaticPopup1Button1"), widget("Button", "StaticPopup1Button2")
G.GameTooltip = widget("GameTooltip", "GameTooltip")
setmetatable(G, { __index = function(_, k)
  if named[k] then return named[k] end
  -- an unset name reads as nil, as in the client: probes like `if C_Timer then` are fine, and a modern API
  -- that is actually CALLED fails with "attempt to call a nil value". Every such read is listed at the end.
  env.unknown[k] = true
  return nil
end })
G._G = G
local function run(path)
  local chunk = assert(loadfile(path)); setfenv(chunk, G); chunk("IRememberYou", env.addonTable)
end
-- DragonUI's libraries come first in the real load order
local dragon = "/root/DOWNPORTPT2/DragonUI/DragonUI/libs/"
run(dragon .. "LibStub/LibStub.lua"); run(dragon .. "CallbackHandler-1.0/CallbackHandler-1.0.lua")
for line in io.lines(ADDON .. "IRememberYou.toc") do
  if line:match("%.lua%s*$") and not line:match("^#") then run(ADDON .. line:gsub("\\", "/"):gsub("%s+$", "")) end
end
ok(true, "every file in the toc loads")

local main
for _, f in ipairs(frames) do if f._scripts.OnEvent == G.Main_OnEvent then main = f end end
local function fire(ev, ...) main._scripts.OnEvent(main, ev, ...) end
-- saved variables as a returning player has them: one remembered player
G.memory = { { name = "Bob", text = "great tank", class = "WARRIOR", mood = 1, time = 1 } }
fire("ADDON_LOADED", "IRememberYou")
ok(type(G.memory) == "table" and G.settgsIRY ~= nil, "ADDON_LOADED creates the saved tables")
ok(named.LibDBIcon10_IRememberYou ~= nil, "minimap button registered with the 3.3.5 LibDBIcon")
fire("PLAYER_ENTERING_WORLD")

-- remember someone, then group with them
env.party, env.units.party1 = 1, { name = "Bob", class = "WARRIOR" }
env._printed = {}
fire("PARTY_MEMBERS_CHANGED")
local saw = false for _, l in ipairs(env._printed) do if l:find("Bob") and l:find("great tank") then saw = true end end
ok(saw, "joining a group with a remembered player prints the note")

-- tooltip note
G.GameTooltip._lines = {}
env.units.mouseover = { name = "Bob", class = "WARRIOR" }
G.GameTooltip._scripts.OnTooltipSetUnit(G.GameTooltip)
ok(G.GameTooltip._lines[1] and G.GameTooltip._lines[1]:find("great tank"), "unit tooltip gets the note line")

-- target mark
env.units.target = { name = "Bob", class = "WARRIOR" }
fire("PLAYER_TARGET_CHANGED")
ok(named.IRememberYouTargetMark._shown, "targeting a remembered player shows the mark on the target frame")

local function markColor() for _, f in ipairs(frames) do local c = rawget(f, "_color") if f._kind == "Texture" and c and rawget(f, "_isMark") then return c end end end
-- Bob's note is positive (mood 1): the tag is green
local tagTex
for _, f in ipairs(frames) do if f._kind == "Texture" and rawget(f, "_color") and rawget(f, "_color")[2] == 1 and rawget(f, "_color")[1] == 0 then tagTex = f end end
ok(tagTex ~= nil, "a positive note tints the tag green")
env.units.target = { name = "Stranger", class = "ROGUE" }
fire("PLAYER_TARGET_CHANGED")
ok(not named.IRememberYouTargetMark._shown, "targeting a player with no note hides the mark")
env.units.target = { name = "Bob", class = "WARRIOR" }
fire("PLAYER_TARGET_CHANGED")
ok(named.IRememberYouTargetMark._shown, "targeting a remembered player again shows it again")

-- right-click menu entry
env.menu = {}
G.UnitPopup_ShowMenu({}, "PLAYER", "target", "Bob")
local found = false for _, b in ipairs(env.menu) do if b.text == "Remember" then found = true end end
ok(found, "unit menu gains a Remember entry")
env.menu = {}; G.UnitPopup_ShowMenu({}, "PB4_PLAYER", "target", "Bob")
ok(#env.menu == 1, "PitBull4 player menus (PB4_ prefix) get it too")
env.menu, env.combat = {}, true; G.UnitPopup_ShowMenu({}, "PLAYER", "target", "Bob"); env.combat = false
ok(#env.menu == 0, "nothing is added to a menu opened in combat")
env.menu = {}; G.UnitPopup_ShowMenu({}, "SELF", "player", "Me")
ok(#env.menu == 0, "your own menu is left alone")

-- dungeon end: Ingvar (23980) dies in a 5-man -> group prompt after 2 s
env._printed = {}
local cleu
for _, f in ipairs(frames) do if f ~= main and f._scripts.OnEvent and f ~= named.IRememberYouTargetMark then cleu = cleu or f end end
for _, f in ipairs(frames) do
  if f._scripts.OnEvent and f ~= main then pcall(f._scripts.OnEvent, f, "COMBAT_LOG_EVENT_UNFILTERED", 1, "UNIT_DIED", "0x0", "", 0, "0xF130005DAC000123", "Ingvar the Plunderer", 0) end
end
for _ = 1, 30 do env.now = env.now + 0.1; for _, f in ipairs(frames) do if f._scripts.OnUpdate then f._scripts.OnUpdate(f, 0.1) end end end
local mass = false for _, l in ipairs(env._printed) do if l:find("Haddon:IRememberYou:Mass") then mass = true end end
ok(mass, "killing a final boss (Ingvar, 23980) prints the remember-the-group link")

-- clicking that link opens the popup instead of reaching the stock handler
env.popup, env.itemref = nil, nil
G.SetItemRef('addon:IRememberYou:Leaver:{name="Bob",class="WARRIOR"}', "x", "LeftButton")
ok(named.IRememberYouDialog._shown and env.itemref == nil, "addon link opens the Remember dialog and stops there")
named.IRememberYouDialog._shown = false
G.SetItemRef("item:6948", "x", "LeftButton")
ok(env.itemref == "item:6948", "other links still reach the stock SetItemRef")

-- leaving the group resets the roster
env.party, env.units.party1 = 0, nil
fire("PARTY_MEMBERS_CHANGED")
ok(true, "leaving the group runs without error")

-- every piece of the window hangs off the window (a frame parented to nil floats loose on screen)
local function under(f, anc) local n = 0 while f and n < 20 do if f == anc then return true end f = rawget(f, "_parent"); n = n + 1 end return false end
local loose = 0
for _, f in ipairs(frames) do
  local p = rawget(f, "_parent")
  if f._kind ~= "Texture" and f._kind ~= "FontString" and f ~= named.IRememberYouMainFrame and p == nil and rawget(f, "_created") then loose = loose + 1 end
end
ok(under(named.IRememberYouInput1, named.IRememberYouDialog), "dialog note box lives in the dialog")
local mainChildren = 0
for _, f in ipairs(frames) do if f ~= named.IRememberYouMainFrame and under(f, named.IRememberYouMainFrame) then mainChildren = mainChildren + 1 end end
ok(mainChildren > 20, "the list, header and scrollbar all hang off the window (" .. mainChildren .. " frames)")
-- the window takes the mouse (clicks no longer fall through it)
ok(named.IRememberYouMainFrame._mouse == true, "the window captures mouse clicks")

-- remember a friend by typed name: class comes from the friends list
G.addPopup("UNKNOWN", "Alice")
local dlg = named.IRememberYouDialog
ok(dlg._shown, "Remember dialog opens")
dlg.note:SetText("healer, very kind"); named.IRYNameBox:SetText("Alice")
dlg.ok._scripts.OnClick(dlg.ok)
local alice
for _, m in ipairs(G.memory) do if m.name == "Alice" then alice = m end end
ok(alice and alice.text == "healer, very kind", "accepting the dialog saves the note")
ok(alice and alice.class == "WARRIOR", "a typed name gets its class from the friends list")

-- someone stored without a class learns it when targeted
G.memory[#G.memory + 1] = { name = "Carl", text = "x", class = "UNKNOWN", mood = 0, time = 5 }
G.addPopup("UNKNOWN", "Carl"); dlg.ok._scripts.OnClick(dlg.ok) -- edit path, rebuilds the note index
env.units.target = { name = "Carl", class = "MAGE" }
fire("PLAYER_TARGET_CHANGED")
local carl for _, m in ipairs(G.memory) do if m.name == "Carl" then carl = m end end
ok(carl and carl.class == "MAGE", "an unknown class is learned when the player is targeted")

-- the target mark appears only when the remembered player is the target
named.IRememberYouTargetMark._shown = false
env.units.target = { name = "Zed", class = "MAGE" }
G.addPopup("UNKNOWN", "Dora"); named.IRYNameBox:SetText("Dora"); dlg.ok._scripts.OnClick(dlg.ok)
ok(not named.IRememberYouTargetMark._shown, "remembering someone else does not flash the mark on your target")

-- class dropdown: free for a name the game cannot see, locked to the live class when it can
local drop = named.IRememberYouClassDropDown
local function choose(class) env.menu = {}; rawget(drop, "_init")(drop, 1); for _, i in ipairs(env.menu) do if i.value == class then i.func() end end end
G.addPopup("UNKNOWN", "Eve")
ok(rawget(drop, "_disabled") == false and rawget(drop, "_dtext"):find("Unknown"), "a player the game cannot see: dropdown free, on ?")
choose("DRUID"); named.IRYNameBox:SetText("Eve"); dlg.note:SetText("tree"); dlg.ok._scripts.OnClick(dlg.ok)
local eve for _, m in ipairs(G.memory) do if m.name == "Eve" then eve = m end end
ok(eve and eve.class == "DRUID", "the class chosen in the dropdown is saved")
G.addPopup("DRUID", "Eve")
ok(rawget(drop, "_dtext"):find("Druid") ~= nil, "editing shows the stored class")
G.addPopup("UNKNOWN", "Alice")
ok(rawget(drop, "_disabled") == true and rawget(drop, "_dtext"):find("Warrior"), "a friend's class is filled in and the dropdown greyed out")
dlg.cancel._scripts.OnClick(dlg.cancel)
G.addPopup("UNKNOWN", "Nobody")
named.IRYNameBox:SetText("Alice"); named.IRYNameBox._scripts.OnTextChanged(named.IRYNameBox)
ok(rawget(drop, "_disabled") == true, "typing a name the game knows locks the dropdown to their class")
named.IRYNameBox:SetText("Nobody"); named.IRYNameBox._scripts.OnTextChanged(named.IRYNameBox)
ok(rawget(drop, "_disabled") == false, "...and an unknown name frees it again")
dlg.cancel._scripts.OnClick(dlg.cancel)

-- editing the targeted player's note recolours the tag at once
env.units.target = { name = "Bob", class = "WARRIOR" }
fire("PLAYER_TARGET_CHANGED")
local tag for _, f in ipairs(frames) do local c = rawget(f, "_color") if f._kind == "Texture" and c and c[1] == 0 and c[2] == 1 then tag = f end end
G.addPopup("WARRIOR", "Bob")
named.SliderAddonSlider._scripts.OnValueChanged(named.SliderAddonSlider, -1)
named.IRYNameBox:SetText("Bob"); dlg.ok._scripts.OnClick(dlg.ok)
local c = tag and rawget(tag, "_color")
ok(c and c[1] == 1 and c[2] == 0, "making Bob's note negative turns his visible tag red immediately")

-- delete asks through the same dialog
G.memory = G.memory
-- slash command opens the window
G.SlashCmdList.MEMORY("")
ok(named.IRememberYouMainFrame._shown, "/memory opens the window")

local u = {} for k in pairs(env.unknown) do u[#u + 1] = k end table.sort(u)
print("globals read but absent (probes, or defined later by the addon): " .. table.concat(u, " "))
print(fails == 0 and "ALL PASS" or (fails .. " FAILED"))
os.exit(fails == 0 and 0 or 1)

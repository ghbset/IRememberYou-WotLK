local tocVersion = select(4,GetBuildInfo())
local forever = tocVersion >= 16001 and tocVersion <= 16999

local function stripRealm(n)
  if forever and type(n) == "string" then return (n:gsub("%-.*$","")) end
  return n
end

local T = {}
T["POPUP"] = "What do you want to remember?"
T["REMEMBER"] = "Remember"
T["EDITED"] = "Edited!"
T["ADD1"] = "You remember |cffFCC000"
T["ADD2"] = " |cffFFFFFFnow!"
T["NOTE1"] = "You remember about |cffFCC000"
T["NOTE2"] = " |cffFFFFFFthat: "
T["DELETE1"] = "Do you want to delete |cffFCC000"
T["DELETE2"] = "|cffFFFFFF?"
T["SEARCH"] = "Search"
T["ADD"] = "Add"
T["BACK"] = "Back"
T["MASS1"] = "Do you want to |cffFCC000"
T["MASS2"] = "remember the whole group"
T["MASS3"] = "|cffFFFFFF?"
T["ERROR"] = "You already remember everyone from this group!"
T["ANNOUNCE1"] = "remembered"
T["ANNOUNCE2"] = ""
T["ANNOUNCER"] = {"Enable announcer","Disable announcer"}
T["FRAMETITLE"] = "Memory"
T["SORTNAME"] = "Character Name"
T["SORTDESC"] = "Description"
T["LEAVER1"] = " |cffFFFFFFhas left the group. Do you want to "
T["LEAVER2"] = "remember them"
T["LEAVER3"] = "|cffFFFFFF?"
T["NAME"] = "Name:"
if GetLocale() == "frFR" then --French
  T["POPUP"] = "De quoi veux-tu te souvenir?"
  T["REMEMBER"] = "Souviens-toi"
  T["EDITED"] = "Édité!"
  T["ADD1"] = "Vous vous souvenez de |cffFCC000"
  T["ADD2"] = " |cffFFFFFFmaintenant!"
  T["NOTE1"] = "Vous vous souvenez de |cffFCC000"
  T["NOTE2"] = " |cffFFFFFFque: "
  T["DELETE1"] = "Voulez-vous supprimer |cffFCC000"
  T["DELETE2"] = "|cffFFFFFF?"
  T["SEARCH"] = "Recherche"
  T["ADD"] = "Ajouter"
  T["BACK"] = "Dos"
  T["MASS1"] = "Voulez-vous |cffFCC000"
  T["MASS2"] = "se souvenir de tout le groupe"
  T["MASS3"] = "|cffFFFFFF?"
  T["ERROR"] = "Vous vous souvenez déjà de tous les membres de ce groupe!"
  T["ANNOUNCE1"] = "s'est souvenu de"
  T["ANNOUNCER"] = {"Activer l'annonceur","Désactivez l'annonceur"}
  T["FRAMETITLE"] = "Mémoire"
  T["SORTNAME"] = "Le Nom du Personnage"
  T["SORTDESC"] = "Description"
  T["LEAVER1"] = " |cffFFFFFFa quitté le groupe. Voulez-vous "
  T["LEAVER2"] = "vous souvenir d'eux"
  T["LEAVER3"] = "|cffFFFFFF?"
  T["NAME"] = "Nom:"
elseif GetLocale() == "deDE" then --German
  T["POPUP"] = "Woran möchten Sie sich erinnern?"
  T["REMEMBER"] = "Erinnern"
  T["EDITED"] = "Bearbeitet!"
  T["ADD1"] = "Du erinnerst dich jetzt an |cffFCC000"
  T["ADD2"] = "|cffFFFFFF!"
  T["NOTE1"] = "Sie erinnern sich an |cffFCC000"
  T["NOTE2"] = "|cffFFFFFF, dass: "
  T["DELETE1"] = "Möchten Sie |cffFCC000"
  T["DELETE2"] = " |cffFFFFFFlöschen?"
  T["SEARCH"] = "Suchen"
  T["ADD"] = "Hinzufügen"
  T["BACK"] = "Zurück"
  T["MASS1"] = "Möchten Sie sich |cffFCC000"
  T["MASS2"] = "an die ganze Gruppe erinnern"
  T["MASS3"] = "|cffFFFFFF?"
  T["ERROR"] = "Du erinnerst dich bereits an alle aus dieser Gruppe!"
  T["ANNOUNCE1"] = "erinnerte sich an"
  T["ANNOUNCER"] = {"Ansager aktivieren","Ansager deaktivieren"}
  T["FRAMETITLE"] = "Erinnerung"
  T["SORTNAME"] = "Charaktername"
  T["SORTDESC"] = "Beschreibung"
  T["LEAVER1"] = " |cffFFFFFFhat die Gruppe verlassen. Möchtest du "
  T["LEAVER2"] = "dich an sie erinnern"
  T["LEAVER3"] = "|cffFFFFFF?"
  T["NAME"] = "Name:"
elseif GetLocale() == "itIT" then --Italian
  T["POPUP"] = "Cosa vuoi ricordare?"
  T["REMEMBER"] = "Ricordare"
  T["EDITED"] = "Modificato!"
  T["ADD1"] = "Ti ricordi |cffFCC000"
  T["ADD2"] = " |cffFFFFFFadesso!"
  T["NOTE1"] = "Ti ricordi di |cffFCC000"
  T["NOTE2"] = " |cffFFFFFFche: "
  T["DELETE1"] = "Vuoi eliminare |cffFCC000"
  T["DELETE2"] = "|cffFFFFFF?"
  T["SEARCH"] = "Ricerca"
  T["ADD"] = "Aggiungere"
  T["BACK"] = "Indietro"
  T["MASS1"] = "Vuoi |cffFCC000"
  T["MASS2"] = "ricordare l'intero gruppo"
  T["MASS3"] = "|cffFFFFFF?"
  T["ERROR"] = "Ricordi già tutti quelli di questo gruppo!"
  T["ANNOUNCE1"] = "si è ricordato di"
  T["ANNOUNCER"] = {"Abilita l'annunciatore","Disattiva l'annunciatore"}
  T["FRAMETITLE"] = "Memoria"
  T["SORTNAME"] = "Nome del Personaggio"
  T["SORTDESC"] = "Descrizione"
  T["LEAVER1"] = " |cffFFFFFFha lasciato il gruppo. Vuoi "
  T["LEAVER2"] = "ricordarli"
  T["LEAVER3"] = "|cffFFFFFF?"
  T["NAME"] = "Nome:"
elseif GetLocale() == "koKR" then --Korean
  T["POPUP"] = "무엇을 기억하고 싶나요?"
  T["REMEMBER"] = "기억하다"
  T["EDITED"] = "수정되었습니다!"
  T["ADD1"] = "이제 |cffFCC000"
  T["ADD2"] = "|cffFFFFFF를 기억하시나요?"
  T["NOTE1"] = "|cffFCC000"
  T["NOTE2"] = "|cffFFFFFF에 대해 다음과 같은 사실을 기억합니다. "
  T["DELETE1"] = "|cffFCC000"
  T["DELETE2"] = "|cffFFFFFF를 삭제하시겠습니까?"
  T["SEARCH"] = "찾다"
  T["ADD"] = "추가하다"
  T["BACK"] = "뒤쪽에"
  T["MASS1"] = "|cffFCC000"
  T["MASS2"] = "그룹 전체를 기억"
  T["MASS3"] = "|cffFFFFFF하시겠습니까?"
  T["ERROR"] = "당신은 이미 이 그룹의 모든 사람을 기억하고 있습니다!"
  T["ANNOUNCE1"] = "가"
  T["ANNOUNCE2"] = "를 기억했어요"
  T["ANNOUNCER"] = {"아나운서 활성화","아나운서 비활성화"}
  T["FRAMETITLE"] = "메모리"
  T["SORTNAME"] = "캐릭터 이름"
  T["SORTDESC"] = "설명"
  T["LEAVER1"] = "|cffFFFFFF가 그룹을 떠났습니다. 그들을 "
  T["LEAVER2"] = "기억하고"
  T["LEAVER3"] = " |cffFFFFFF싶으신가요?"
  T["NAME"] = "이름:"
elseif GetLocale() == "zhCN" then --Chinese (simplified)
  T["POPUP"] = "你想记住什么?"
  T["REMEMBER"] = "记住"
  T["EDITED"] = "已编辑!"
  T["ADD1"] = "你现在还记得|cffFCC000"
  T["ADD2"] = "|cffFFFFFF吧!"
  T["NOTE1"] = "关于 |cffFCC000"
  T["NOTE2"] = "|cffFFFFFF, 你还记得: "
  T["DELETE1"] = "您想删除 |cffFCC000"
  T["DELETE2"] = " |cffFFFFFF吗?"
  T["SEARCH"] = "搜索"
  T["ADD"] = "添加"
  T["BACK"] = "后退"
  T["MASS1"] = "你想|cffFCC000"
  T["MASS2"] = "记住整个小组"
  T["MASS3"] = "|cffFFFFFF吗?"
  T["ERROR"] = "您已经记住了这个小组中的每个人!"
  T["ANNOUNCE1"] = "记住了"
  T["ANNOUNCER"] = {"启用播音员","禁用播音员"}
  T["FRAMETITLE"] = "记忆"
  T["SORTNAME"] = "角色名字"
  T["SORTDESC"] = "描述"
  T["LEAVER1"] = "|cffFFFFFF已离开队伍. 你想"
  T["LEAVER2"] = "记住他们"
  T["LEAVER3"] = "|cffFFFFFF吗?"
  T["NAME"] = "名字:"
elseif GetLocale() == "zhTW" then --Chinese (traditional)
  T["POPUP"] = "你想記住什麼?"
  T["REMEMBER"] = "記住"
  T["EDITED"] = "已編輯!"
  T["ADD1"] = "你現在還記得|cffFCC000"
  T["ADD2"] = "|cffFFFFFF吧!"
  T["NOTE1"] = "關於 |cffFCC000"
  T["NOTE2"] = "|cffFFFFFF, 你還記得: "
  T["DELETE1"] = "您想刪除 |cffFCC000"
  T["DELETE2"] = " |cffFFFFFF嗎?"
  T["SEARCH"] = "搜尋"
  T["ADD"] = "添加"
  T["BACK"] = "後退"
  T["MASS1"] = "你想|cffFCC000"
  T["MASS2"] = "記住整個團體"
  T["MASS3"] = "|cffFFFFFF嗎?"
  T["ERROR"] = "您已經記住了這個小組中的每個人!"
  T["ANNOUNCE1"] = "記住了"
  T["ANNOUNCER"] = {"啟用播音員","禁用播音員"}
  T["FRAMETITLE"] = "記憶"
  T["SORTNAME"] = "角色名字"
  T["SORTDESC"] = "描述"
  T["LEAVER1"] = "|cffFFFFFF已離開隊伍. 你想"
  T["LEAVER2"] = "記住他們"
  T["LEAVER3"] = "|cffFFFFFF嗎?"
  T["NAME"] = "名字:"
elseif GetLocale() == "ruRU" then --Russian
  T["POPUP"] = "Что ты хочешь запомнить?"
  T["REMEMBER"] = "Помнить"
  T["EDITED"] = "Отредактировано!"
  T["ADD1"] = "Теперь вы помните |cffFCC000"
  T["ADD2"] = "|cffFFFFFF!"
  T["NOTE1"] = "Вы помните об |cffFCC000"
  T["NOTE2"] = "|cffFFFFFF, что: "
  T["DELETE1"] = "Вы хотите удалить |cffFCC000"
  T["DELETE2"] = "|cffFFFFFF?"
  T["SEARCH"] = "Поиск"
  T["ADD"] = "Добавлять"
  T["BACK"] = "Назад"
  T["MASS1"] = "Хотите |cffFCC000"
  T["MASS2"] = "запомнить всю группу"
  T["MASS3"] = "|cffFFFFFF?"
  T["ERROR"] = "Вы уже помните всех из этой группы!"
  T["ANNOUNCE1"] = "вспомнил"
  T["ANNOUNCER"] = {"Включите диктора","Отключите диктора"}
  T["FRAMETITLE"] = "Память"
  T["SORTNAME"] = "Название Характера"
  T["SORTDESC"] = "Описание"
  T["LEAVER1"] = " |cffFFFFFFпокинул группу. Хотите "
  T["LEAVER2"] = "запомнить их"
  T["LEAVER3"] = "|cffFFFFFF?"
  T["NAME"] = "Имя:"
elseif GetLocale() == "esES" or GetLocale() == "esMX" then --Spanish
  T["POPUP"] = "¿Qué quieres recordar?"
  T["REMEMBER"] = "Recordar"
  T["EDITED"] = "¡Editada!"
  T["ADD1"] = "¡Recuerdas |cffFCC000"
  T["ADD2"] = " |cffFFFFFFahora!"
  T["NOTE1"] = "Recuerdas sobre |cffFCC000"
  T["NOTE2"] = " |cffFFFFFFque: "
  T["DELETE1"] = "¿Quieres eliminar |cffFCC000"
  T["DELETE2"] = "|cffFFFFFF?"
  T["SEARCH"] = "Buscar"
  T["ADD"] = "Agregar"
  T["BACK"] = "Atrás"
  T["MASS1"] = "¿Quieres |cffFCC000"
  T["MASS2"] = "recordar a todo el grupo"
  T["MASS3"] = "|cffFFFFFF?"
  T["ERROR"] = "¡Ya te acuerdas de todos los de este grupo!"
  T["ANNOUNCE1"] = "recordó a"
  T["ANNOUNCER"] = {"¡Habilitar locutor","¡Desactivar locutor"}
  T["FRAMETITLE"] = "Memoria"
  T["SORTNAME"] = "Nombre del Personaje"
  T["SORTDESC"] = "Descripción"
  T["LEAVER1"] = " |cffFFFFFFha abandonado el grupo. ¿Quieres "
  T["LEAVER2"] = "recordarlos"
  T["LEAVER3"] = "|cffFFFFFF?"
  T["NAME"] = "Nombre:"
elseif GetLocale() == "ptBR" then --Portuguese
  T["POPUP"] = "O que você quer lembrar?"
  T["REMEMBER"] = "Lembrar"
  T["EDITED"] = "Editada!"
  T["ADD1"] = "Você se lembra de |cffFCC000"
  T["ADD2"] = " |cffFFFFFFagora!"
  T["NOTE1"] = "Você se lembra de |cffFCC000"
  T["NOTE2"] = " |cffFFFFFFque: "
  T["DELETE1"] = "Você deseja excluir |cffFCC000"
  T["DELETE2"] = "|cffFFFFFF?"
  T["SEARCH"] = "Procurar"
  T["ADD"] = "Adicionar"
  T["BACK"] = "Voltar"
  T["MASS1"] = "Você quer |cffFCC000"
  T["MASS2"] = "lembrar de todo o grupo"
  T["MASS3"] = "|cffFFFFFF?"
  T["ERROR"] = "Você já se lembra de todos desse grupo!"
  T["ANNOUNCE1"] = "lembrou de"
  T["ANNOUNCER"] = {"Habilite o locutor","Desative o locutor"}
  T["FRAMETITLE"] = "Memória"
  T["SORTNAME"] = "Nome do Personagem"
  T["SORTDESC"] = "Descrição"
  T["LEAVER1"] = " |cffFFFFFFdeixou o grupo. Você quer "
  T["LEAVER2"] = "lembrar-se deles"
  T["LEAVER3"] = "|cffFFFFFF?"
  T["NAME"] = "Nome:"
end

local function tn(arg) return arg and 1 or 0 end

local userFrames = {}
local lastUserFrameSelected = nil
local moodIcons = {
	[-1] = {0.5, 0.625, 0, 0.5},
	[0] = {0.625, 0.75, 0, 0.5},
	[1]	= {0.75, 0.875, 0, 0.5}
}
local scroll = 0
local snapValue = 0
local selectedName = ""
local selectedText = ""
local selectedMood = 0
local editingName = ""
local editingText = ""
local editingMood = 0
local deletePopup
local dbNotes = {}

dbIRY = {minimap = {hide = false}}
local buttonIRY
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("IRememberYou",{
  icon = "Interface\\AddOns\\IRememberYou\\icon",
  OnClick = function(self,button) if button == "LeftButton" then SlashCmdList["MEMORY"]() end end,
  OnTooltipShow = function(tooltip)
    tooltip:AddLine("|cffffffffI Remember You")
    tooltip:AddLine("|cff1eff00<Left Click to toggle>")
    tooltip:SetScale(GameTooltip:GetScale())
  end
})

local bigFrame = CreateFrame("Frame","IRememberYouMainFrame",UIParent)
tinsert(UISpecialFrames, "IRememberYouMainFrame")
bigFrame:SetSize(640+16+8,320+34 +30)
bigFrame:SetPoint("CENTER",0,0)
bigFrame:SetMovable(true)
bigFrame:SetScript("OnMouseDown",bigFrame.StartMoving)
bigFrame:SetScript("OnMouseUp",bigFrame.StopMovingOrSizing)
bigFrame:Hide()

local mainFrame = CreateFrame("Frame",nil,bigFrame,"BackdropTemplate")
mainFrame:SetSize(640+16+8,320)
mainFrame:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
mainFrame:SetBackdropColor(0,0,0)
mainFrame:SetPoint("TOPLEFT",0,-34 -30)
mainFrame:SetClipsChildren(true)

local mainFrameHeader = CreateFrame("Frame",nil,bigFrame,"BackdropTemplate")
mainFrameHeader:SetSize(640+16+8,34 +30)
mainFrameHeader:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
mainFrameHeader:SetBackdropColor(0,0,0)
mainFrameHeader:SetPoint("TOPLEFT",0,0)

local mainFrameHeaderLine = CreateFrame("Frame",nil,mainFrameHeader,"BackdropTemplate")
mainFrameHeaderLine:SetSize(640+16+8,2)
mainFrameHeaderLine:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
mainFrameHeaderLine:SetBackdropColor(1,0.7529,0)
mainFrameHeaderLine:SetPoint("TOPLEFT",0,-34+2)

local mainFrameHeaderLineBot = CreateFrame("Frame",nil,mainFrameHeader,"BackdropTemplate")
mainFrameHeaderLineBot:SetSize(640+16+8,2)
mainFrameHeaderLineBot:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
mainFrameHeaderLineBot:SetBackdropColor(1,0.7529,0)
mainFrameHeaderLineBot:SetPoint("TOPLEFT",0,-34-28)

local sortName = CreateFrame("Button",nil,mainFrameHeader,"BackdropTemplate")
sortName:SetSize(200,28)
sortName:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
sortName:SetBackdropColor(0,0,0)
sortName:SetPoint("TOPLEFT",0,-34)
local sortNameText = sortName:CreateFontString(nil,"OVERLAY","GameFontHighlight")
sortNameText:SetSize(194,28)
sortNameText:SetPoint("TOPLEFT",6,0)
sortNameText:SetJustifyH("LEFT")
sortNameText:SetJustifyV("MIDDLE")
sortNameText:SetText(T["SORTNAME"])
sortName:SetScript("OnEnter",function()
  sortName:SetBackdropColor(0.125,0.125,0.125)
  sortNameText:SetTextColor(1,0.7529,0)
end)
sortName:SetScript("OnLeave",function()
  sortName:SetBackdropColor(0,0,0)
  sortNameText:SetTextColor(1,1,1)
end)

local sortDescription = CreateFrame("Button",nil,mainFrameHeader,"BackdropTemplate")
sortDescription:SetSize(255,28)
sortDescription:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
sortDescription:SetBackdropColor(0,0,0)
sortDescription:SetPoint("TOPLEFT",200,-34)
local sortDescriptionText = sortDescription:CreateFontString(nil,"OVERLAY","GameFontHighlight")
sortDescriptionText:SetSize(249,28)
sortDescriptionText:SetPoint("TOPLEFT",6,0)
sortDescriptionText:SetJustifyH("LEFT")
sortDescriptionText:SetJustifyV("MIDDLE")
sortDescriptionText:SetText(T["SORTDESC"])
sortDescription:SetScript("OnEnter",function()
  sortDescription:SetBackdropColor(0.125,0.125,0.125)
  sortDescriptionText:SetTextColor(1,0.7529,0)
end)
sortDescription:SetScript("OnLeave",function()
  sortDescription:SetBackdropColor(0,0,0)
  sortDescriptionText:SetTextColor(1,1,1)
end)

local searchName = nil
local smemory = nil

local isSorted = true
local sortByNameAZ = true
local sortByDescriptionAZ = true
local function sortByName(a, b)
  if sortByNameAZ then return a["name"] > b["name"]
  else return a["name"] < b["name"] end
end
local function sortByTime(a,b)
  return a["time"] < b["time"]
end
local function sortByDescription(a,b)
  if sortByDescriptionAZ then
    if a["mood"] == b["mood"] then
      return a["time"] < b["time"]
    end
    return a["mood"] < b["mood"]
  else
    if a["mood"] == b["mood"] then
      return a["time"] < b["time"]
    end
    return a["mood"] > b["mood"]
  end
end
sortName:SetScript("OnClick",function()
  --print("sort")
  isSorted = true
  sortByDescriptionAZ = true
  table.sort(memory,sortByName)
  
  local maxUsers = #memory - 10
  if (smemory ~= nil) then
    maxUsers = #smemory - 10
    table.sort(smemory,sortByName)
  end
  sortByNameAZ = not sortByNameAZ

  local maxScroll = maxUsers * 32
  local adjustedValue = scroll / maxScroll * maxUsers
  local firstItem = floor(adjustedValue)
  local shift = adjustedValue - firstItem
  for i = 1,min(maxUsers + 10,11) do
    local userFrame = userFrames[i]
    if (smemory ~= nil) then
      if smemory[#smemory - (firstItem + (i-1))] ~= nil then
        userFrame.userFrameUpdate(firstItem + (i-1))
      end
    else
      if memory[#memory - (firstItem + (i-1))] ~= nil then
        userFrame.userFrameUpdate(firstItem + (i-1))
      end
    end
  end
end)
sortDescription:SetScript("OnClick",function()
  --print("sort_desc")
  isSorted = true
  sortByNameAZ = true
  table.sort(memory,sortByDescription)
  
  local maxUsers = #memory - 10
  if (smemory ~= nil) then
    maxUsers = #smemory - 10
    table.sort(smemory,sortByDescription)
  end
  sortByDescriptionAZ = not sortByDescriptionAZ

  local maxScroll = maxUsers * 32
  local adjustedValue = scroll / maxScroll * maxUsers
  local firstItem = floor(adjustedValue)
  local shift = adjustedValue - firstItem
  for i = 1,min(maxUsers + 10,11) do
    local userFrame = userFrames[i]
    if (smemory ~= nil) then
      if smemory[#smemory - (firstItem + (i-1))] ~= nil then
        userFrame.userFrameUpdate(firstItem + (i-1))
      end
    else
      if memory[#memory - (firstItem + (i-1))] ~= nil then
        userFrame.userFrameUpdate(firstItem + (i-1))
      end
    end
  end
end)

local mainFrameHeaderTitle = mainFrameHeader:CreateFontString(nil,"OVERLAY","GameFontHighlightMedium")
mainFrameHeaderTitle:SetSize(160,32)
mainFrameHeaderTitle:SetPoint("TOPLEFT",6,0)
mainFrameHeaderTitle:SetJustifyH("LEFT")
mainFrameHeaderTitle:SetJustifyV("MIDDLE")
mainFrameHeaderTitle:SetText(T["FRAMETITLE"])

local mainFrameEditBg = CreateFrame("Frame",nil,mainFrameHeader,"BackdropTemplate")
local mainFrameHeaderInfo = mainFrameEditBg:CreateFontString(nil,"OVERLAY","GameFontHighlightMedium")
mainFrameHeaderInfo:SetSize(160,32)
mainFrameHeaderInfo:SetPoint("TOPLEFT",-160-6,0)
mainFrameHeaderInfo:SetJustifyH("RIGHT")
mainFrameHeaderInfo:SetJustifyV("MIDDLE")
mainFrameHeaderInfo:SetText("Search")

mainFrameEditBg:SetSize(160,32)
mainFrameEditBg:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
mainFrameEditBg:SetBackdropColor(0.2,0.2,0.2)
mainFrameEditBg:SetPoint("TOPLEFT",640+16+8-28-2-2-160-28,0)
local mainFrameEdit = CreateFrame("EditBox",nil,mainFrameEditBg)
mainFrameEdit:SetAllPoints()
mainFrameEdit:SetAutoFocus(false)
mainFrameEdit:SetMaxLetters(200)
mainFrameEdit:SetFontObject(GameFontHighlightMedium)
mainFrameEdit:SetTextInsets(4,4,0,0)
mainFrameEdit:SetScript("OnEscapePressed",function()
  mainFrameEdit:ClearFocus()
end)
mainFrameEditBg:Hide()

local function newButton(x,y,path,color,coords)
  local button = CreateFrame("Button",nil,mainFrameHeader)
  button:SetSize(28,28)
  button:SetPoint("TOPLEFT",x,y)
  button.tex = button:CreateTexture(nil,"OVERLAY")
  button.tex:SetTexture("Interface\\AddOns\\IRememberYou\\"..path)
  if coords then button.tex:SetTexCoord(unpack(coords)) end
  button.tex:SetVertexColor(unpack(color))
  button.tex:SetAllPoints()

  button:SetScript("OnEnter",function() button.tex:SetVertexColor(1,1,1) end)
  button:SetScript("OnLeave",function() button.tex:SetVertexColor(unpack(color)) end)
  return button
end

local toolSelected = -1
local btnExit = newButton(634,-2,"tools",{0.9569,0.2627,0.2118},{0.5,1,0.5,1})
local btnAdd = newButton(606,-2,"tools",{1,0.7529,0},{0,0.5,0,0.5})
local btnSearch = newButton(578,-2,"tools",{1,0.7529,0},{0,0.5,0.5,1})
local btnSettings = newButton(550,-2,"toggle",{1,0.7529,0})

local function resetAddIcon(clear)
  btnSearch:Show()
  btnSettings:Show()
  if clear then
    mainFrameEdit:ClearFocus()
    mainFrameEdit:SetText("")
    mainFrameEditBg:Hide()
  end
  btnAdd.tex:SetTexCoord(0,0.5,0,0.5)
  toolSelected = -1
end

btnExit:SetScript("OnClick",function() bigFrame:Hide() end)
btnSearch:SetScript("OnClick",function()
  btnSearch:Hide()
  btnSettings:Hide()
  mainFrameEditBg:Show()
  mainFrameEdit:SetFocus()
  btnAdd.tex:SetTexCoord(0.5,1,0,0.5)
  mainFrameHeaderInfo:SetText(T["SEARCH"])
  toolSelected = 2
end)

local mainFrameScrollHit = CreateFrame("Frame",nil,bigFrame,"BackdropTemplate")
mainFrameScrollHit:SetSize(24,320)
mainFrameScrollHit:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
local lastScrollPos = -1
local register = false
local mainFrameScrollHand,mainFrameScrollHandTexture
local function scrollDown()
  if (smemory ~= nil and #smemory > 10) or (smemory == nil and #memory > 10) then
    register = true
    mainFrameScrollHandTexture:SetVertexColor(1,1,1)
  end
end
local function scrollUp()
  register = false
  lastScrollPos = -1
  if not mainFrameScrollHand:IsMouseOver() then
    mainFrameScrollHandTexture:SetVertexColor(1,0.7529,0)
  end
end
mainFrameScrollHit:SetPoint("TOPLEFT",640,-34 -30)
mainFrameScrollHit:SetScript("OnMouseDown",scrollDown)
mainFrameScrollHit:SetScript("OnMouseUp",scrollUp)
mainFrameScrollHit:SetAlpha(0)

local mainFrameScrollBackground = CreateFrame("Frame",nil,bigFrame,"BackdropTemplate")
mainFrameScrollBackground:SetSize(4,320-8-8)
mainFrameScrollBackground:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
mainFrameScrollBackground:SetBackdropColor(0.3,0.3,0.3)
mainFrameScrollBackground:SetPoint("TOPLEFT",640+8+2,-8-34-30)

mainFrameScrollHand = CreateFrame("Button",nil,bigFrame)
mainFrameScrollHand:SetSize(12.25,21)
mainFrameScrollHand:SetPoint("TOPLEFT",640+5.875,-5.875-34-30)
mainFrameScrollHandTexture = mainFrameScrollHand:CreateTexture(nil,"OVERLAY")
mainFrameScrollHandTexture:SetTexture("Interface\\AddOns\\IRememberYou\\hand")
mainFrameScrollHandTexture:SetTexCoord(0,0.875,0,0.75)
mainFrameScrollHandTexture:SetVertexColor(1,0.7529,0)
mainFrameScrollHandTexture:SetAllPoints()
mainFrameScrollHand:SetFrameLevel(mainFrameScrollBackground:GetFrameLevel() + 1)
mainFrameScrollHand:SetScript("OnEnter",function()
  if (smemory ~= nil and #smemory > 10) or (smemory == nil and #memory > 10) then
    mainFrameScrollHandTexture:SetVertexColor(1,1,1)
  end
end)
mainFrameScrollHand:SetScript("OnLeave",function()
  if not register then
    mainFrameScrollHandTexture:SetVertexColor(1,0.7529,0)
  end
end)
mainFrameScrollHand:SetScript("OnMouseDown",scrollDown)
mainFrameScrollHand:SetScript("OnMouseUp",scrollUp)

local function mainFrameScroll(adjustedValue,setScroll,update)
  local firstItem = floor(adjustedValue)
  local shift = adjustedValue - firstItem
  for i = 1,11 do
    local userFrame = userFrames[i]
    local offset = (shift * 32) + ((i - 1) * -32)
    userFrame:SetPoint("TOPLEFT",0,offset)
    
    if (smemory ~= nil) then
      if update and smemory[#smemory - (firstItem + (i-1))] ~= nil then
        userFrame.userFrameUpdate(firstItem + (i-1))
      end
    else
      if update and memory[#memory - (firstItem + (i-1))] ~= nil then
        userFrame.userFrameUpdate(firstItem + (i-1))
      end
    end
  end
  if setScroll then scroll = firstItem * 32 + shift * 32 end
  local newHandPos
  if (smemory ~= nil and #smemory < 11) or (smemory == nil and #memory < 11) then
    newHandPos = -5.875-34-30
  else
    local adjustedMemory = #memory
    if (smemory ~= nil) then adjustedMemory = #smemory end
    newHandPos = -5.875-34-30 + ((adjustedValue / (adjustedMemory - 10)) * (-293.125 - (-5.875)))
  end
  mainFrameScrollHand:SetPoint("TOPLEFT",645.875,newHandPos)
end

local state = {[false] = "Disabled",[true] = "Enabled"}
local settgParent = CreateFrame("Frame",nil,mainFrameHeader)
settgParent:SetAllPoints()
settgParent:Hide()
local settgOffset = -6
local function newSetting(id,label,settg)
  local button = CreateFrame("Frame",nil,settgParent,"BackdropTemplate")
  button:SetSize(664,28)
  button:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8"})
  button:SetBackdropColor(0,0,0)
  settgOffset = settgOffset - 28
  button:SetPoint("TOPLEFT",0,settgOffset)

  button.font = button:CreateFontString(nil,"OVERLAY","GameFontHighlight")
  button.font:SetSize(240,28)
  button.font:SetPoint("TOPLEFT",6,0)
  button.font:SetJustifyH("LEFT")
  button.font:SetJustifyV("MIDDLE")
  button.font:SetText(label..": "..state[settg])

  button:SetScript("OnEnter",function()
    button.font:SetTextColor(1,0.7529,0)
    button:SetBackdropColor(0.125,0.125,0.125)
  end)
  button:SetScript("OnLeave",function()
    button.font:SetTextColor(1,1,1)
    button:SetBackdropColor(0,0,0)
  end)
  button:SetScript("OnMouseDown",function()
    settg = not settg
    button.font:SetText(label..": "..state[settg])
    if id == 1 then
      dbIRY.minimap.hide = settg
      buttonIRY:SetShown(not settg)
    elseif id == 2 then settgsIRY.sound = settg
    elseif id == 3 then settgsIRY.chat = settg 
    elseif id == 4 then
      settgsIRY.classColor = settg
      for i = 1,11 do
        if userFrames[i] then userFrames[i].updateColor() end
      end
    end
  end)
  return button
end

btnAdd:SetScript("OnClick",function()
  if toolSelected == -1 then
    btnSearch:Hide()
    btnSettings:Hide()
    mainFrameEditBg:Show()
    mainFrameEdit:SetFocus()
    btnAdd.tex:SetTexCoord(0.5,1,0,0.5)
    mainFrameHeaderInfo:SetText(T["ADD"])
    toolSelected = 1
  elseif toolSelected == 1 then
    resetAddIcon(true)
  elseif toolSelected == 2 then
    resetAddIcon(true)
    if smemory ~= nil then
      searchName = nil
      smemory = nil
      scroll = 0
      mainFrameScroll(0,false,false)
      for i = 1,11 do
        local userFrame = userFrames[i]
        if i == min(#memory,i) then
          userFrame.userFrameUpdate(i - 1)
          userFrame:Show()
        else userFrame:Hide() end
      end
    end
  elseif toolSelected == 3 then
    resetAddIcon()
    mainFrameHeaderTitle:SetText(T["FRAMETITLE"])
    mainFrame:Show()--todo
    mainFrameHeader:SetHeight(34 +30)
    mainFrameScrollHit:EnableMouse(true)
    mainFrameScrollHand:Show()
    sortName:Show()
    sortDescription:Show()
    mainFrameHeaderLineBot:Show()
    settgParent:Hide()
  end
end)
btnSettings:SetScript("OnClick",function()
  btnSearch:Hide()
  btnSettings:Hide()
  btnAdd.tex:SetTexCoord(0.5,1,0,0.5)
  mainFrameHeaderTitle:SetText("Settings")--todo
  mainFrame:Hide()
  mainFrameHeader:SetHeight(34 +30+320)
  mainFrameScrollHit:EnableMouse(false)
  mainFrameScrollHand:Hide()
  sortName:Hide()
  sortDescription:Hide()
  mainFrameHeaderLineBot:Hide()
  settgParent:Show()
  toolSelected = 3
end)

local function searchResult(item)
  local searchNameLower = searchName:lower():gsub("+","%%+")
  return string.find(item.name:lower(), searchNameLower) ~= nil
  or string.find(item.text:lower(), searchNameLower) ~= nil
end

local region = 0
if not forever and GetCurrentRegion then region = GetCurrentRegion() end
local realmsUS = {"Aegwynn","AeriePeak","Agamaggan","Aggramar","Akama","Alexstrasza","Alleria","AltarofStorms","AlteracMountains","Aman'Thul","Andorhal","Anetheron","Antonidas","Anub'arak","Anvilmar","Arathor","Archimonde","Area52","ArgentDawn","Arthas","Arygos","Auchindoun","Azgalor","AzjolNerub","Azralon","Azshara","Azuremyst","Baelgun","Balnazzar","Barthilas","BlackDragonflight","Blackhand","Blackrock","BlackwaterRaiders","BlackwingLair","Blade'sEdge","Bladefist","BleedingHollow","BloodFurnace","Bloodhoof","Bloodscalp","Bonechewer","BoreanTundra","Boulderfist","Bronzebeard","BurningBlade","BurningLegion","Caelestrasz","Cairne","CenarionCircle","Cenarius","Cho'gall","Chromaggus","Coilfang","Crushridge","Daggerspine","Dalaran","Dalvengyr","DarkIron","Darkspear","Darrowmere","Dath'Remar","Dawnbringer","Deathwing","DemonSoul","Dentarg","Destromath","Dethecus","Detheroc","Doomhammer","Draenor","Dragonblight","Dragonmaw","Drak'Tharon","Drak'thul","Draka","Drakkari","Dreadmaul","Drenden","Dunemaul","Durotan","Duskwood","EarthenRing","EchoIsles","Eitrigg","Eldre'Thalas","Elune","EmeraldDream","Eonar","Eredar","Executus","Exodar","Farstriders","Feathermoon","Fenris","Firetree","Fizzcrank","Frostmane","Frostmourne","Frostwolf","Galakrond","Gallywix","Garithos","Garona","Garrosh","Ghostlands","Gilneas","Gnomeregan","Goldrinn","Gorefiend","Gorgonnash","Greymane","GrizzlyHills","Gul'dan","Gundrak","Gurubashi","Hakkar","Haomarush","Hellscream","Hydraxis","Hyjal","Icecrown","Illidan","Jaedenar","Jubei'Thos","Kael'thas","Kalecgos","Kargath","Kel'Thuzad","Khadgar","KhazModan","Khaz'goroth","Kil'jaeden","Kilrogg","KirinTor","Korgath","Korialstrasz","KulTiras","LaughingSkull","Lethon","Lightbringer","Lightning'sBlade","Lightninghoof","Llane","Lothar","Madoran","Maelstrom","Magtheridon","Maiev","Mal'Ganis","Malfurion","Malorne","Malygos","Mannoroth","Medivh","Misha","Mok'Nathal","MoonGuard","Moonrunner","Mug'thol","Muradin","Nagrand","Nathrezim","Nazgrel","Nazjatar","Nemesis","Ner'zhul","Nesingwary","Nordrassil","Norgannon","Onyxia","Perenolde","Proudmoore","Quel'Thalas","Quel'dorei","Ragnaros","Ravencrest","Ravenholdt","Rexxar","Rivendare","Runetotem","Sargeras","Saurfang","ScarletCrusade","Scilla","Sen'jin","Sentinels","ShadowCouncil","Shadowmoon","Shadowsong","Shandris","ShatteredHalls","ShatteredHand","Shu'halo","SilverHand","Silvermoon","SistersofElune","Skullcrusher","Skywall","Smolderthorn","Spinebreaker","Spirestone","Staghelm","SteamwheedleCartel","Stonemaul","Stormrage","Stormreaver","Stormscale","Suramar","Tanaris","Terenas","Terokkar","Thaurissan","TheForgottenCoast","TheScryers","TheUnderbog","TheVentureCo","ThoriumBrotherhood","Thrall","Thunderhorn","Thunderlord","Tichondrius","TolBarad","Tortheldrin","Trollbane","Turalyon","TwistingNether","Uldaman","Uldum","Undermine","Ursin","Uther","Vashj","Vek'nilash","Velen","Warsong","Whisperwind","Wildhammer","Windrunner","Winterhoof","WyrmrestAccord","Ysera","Ysondre","Zangarmarsh","Zul'jin","Zuluhed"}
local realmsEU = {"Aegwynn","AeriePeak","Agamaggan","Aggra","Aggramar","Ahn'Qiraj","Al'Akir","Alexstrasza","Alleria","Alonsus","Aman'Thul","Ambossar","Anachronos","Anetheron","Antonidas","Anub'arak","Arakarahm","Arathi","Arathor","Archimonde","Area52","ArgentDawn","Arthas","Arygos","Ashenvale","Aszune","Auchindoun","AzjolNerub","Azshara","Azuregos","Azuremyst","Baelgun","Balnazzar","Blackhand","Blackmoore","Blackrock","Blackscar","Blade'sEdge","Bladefist","Bloodfeather","Bloodhoof","Bloodscalp","Blutkessel","BootyBay","BoreanTundra","Boulderfist","BronzeDragonflight","Bronzebeard","BurningBlade","BurningLegion","BurningSteppes","C'Thun","ChamberofAspects","Chantséternels","Cho'gall","Chromaggus","ColinasPardas","ConfrérieduThorium","ConseildesOmbres","Crushridge","CultedelaRivenoire","Daggerspine","Dalaran","Dalvengyr","DarkmoonFaire","Darksorrow","Darkspear","DasKonsortium","DasSyndikat","Deathguard","Deathweaver","Deathwing","Deepholm","DefiasBrotherhood","Dentarg","DerMithrilorden","DerRatvonDalaran","DerabyssischeRat","Destromath","Dethecus","DieAldor","DieArguswacht","DieNachtwache","DieSilberneHand","DieTodeskrallen","DieewigeWacht","Doomhammer","Draenor","Dragonblight","Dragonmaw","Drak'thul","Drek'Thar","DunModr","DunMorogh","Dunemaul","Durotan","EarthenRing","Echsenkessel","Eitrigg","Eldre'Thalas","Elune","EmeraldDream","Emeriss","Eonar","Eredar","Eversong","Executus","Exodar","FestungderStürme","Fordragon","Forscherliga","Frostmane","Frostmourne","Frostwhisper","Frostwolf","Galakrond","Garona","Garrosh","Genjuros","Ghostlands","Gilneas","Goldrinn","Gordunni","Gorgonnash","Greymane","GrimBatol","Grom","Gul'dan","Hakkar","Haomarush","Hellfire","Hellscream","HowlingFjord","Hyjal","Illidan","Jaedenar","Kael'thas","Karazhan","Kargath","Kazzak","Kel'Thuzad","Khadgar","KhazModan","Khaz'goroth","Kil'jaeden","Kilrogg","KirinTor","Kor'gall","Krag'jin","Krasus","KulTiras","KultderVerdammten","LaCroisadeécarlate","LaughingSkull","LesClairvoyants","LesSentinelles","LichKing","Lightbringer","Lightning'sBlade","Lordaeron","LosErrantes","Lothar","Madmortem","Magtheridon","Mal'Ganis","Malfurion","Malorne","Malygos","Mannoroth","MarécagedeZangar","Mazrigos","Medivh","Minahonda","Moonglade","Mug'thol","Nagrand","Nathrezim","Naxxramas","Nazjatar","Nefarian","Nemesis","Neptulon","Ner'zhul","Nera'thor","Nethersturm","Nordrassil","Norgannon","Nozdormu","Onyxia","Outland","Perenolde","Pozzodell'Eternità","Proudmoore","Quel'Thalas","Ragnaros","Rajaxx","Rashgarroth","Ravencrest","Ravenholdt","Razuvious","Rexxar","Runetotem","Sanguino","Sargeras","Saurfang","ScarshieldLegion","Sen'jin","Shadowsong","ShatteredHalls","ShatteredHand","Shattrath","Shen'dralar","Silvermoon","Sinstralis","Skullcrusher","Soulflayer","Spinebreaker","Sporeggar","SteamwheedleCartel","Stormrage","Stormreaver","Stormscale","Sunstrider","Suramar","Sylvanas","Taerar","Talnivarr","TarrenMill","Teldrassil","Templenoir","Terenas","Terokkar","Terrordar","TheMaelstrom","TheSha'tar","TheVentureCo","Theradras","Thermaplugg","Thrall","Throk'Feroth","Thunderhorn","Tichondrius","Tirion","Todeswache","Trollbane","Turalyon","Twilight'sHammer","TwistingNether","Tyrande","Uldaman","Ulduar","Uldum","Un'Goro","Varimathras","Vashj","Vek'lor","Vek'nilash","Vol'jin","Wildhammer","Wrathbringer","Xavius","Ysera","Ysondre","Zenedar","ZirkeldesCenarius","Zul'jin","Zuluhed"}
local realms
if region == 1 then realms = realmsUS
elseif region == 3 then realms = realmsEU
else realms = {} end

local function find_first_word(str, l)
  if str == "" then return nil end
  for _, word in ipairs(l) do
    if word:sub(1, #str):lower() == str:lower() then
      return word
    end
  end
  return nil
end

local ignore = nil
local prevsize = 0
mainFrameEdit:SetScript("OnTextChanged",function(self)
  local t = self:GetText()
  if ignore and t == ignore then
    ignore = nil
    return
  end
  if forever then
    local cap = t:gsub("(%a)(%S*)",function(a,b) return a:upper()..b end)
    if cap ~= t then self:SetText(cap) end
    prevsize = #cap
    return
  end
  self:SetText(t:gsub("^%l", string.upper))
  local now = prevsize
  prevsize = #t
  if #t <= now then return end
  local name = string.match(t, "^(.-)-")
  local realmStart = t:find("-", 1, true);
  if (realmStart) then
    realmStart = t:sub(realmStart + 1)
    --print("realm "..realmStart)
    local found = find_first_word(realmStart,realms)
    if found then
      --print("found "..found)
      self:SetText(name.."-"..found)
      local cut = string.gsub(found:lower(), realmStart:lower(), "", 1)
      --print("cut"..cut)
      --print(#realmStart)
      mainFrameEdit:HighlightText(#name+1+#realmStart,-1)
      mainFrameEdit:SetCursorPosition(#name+1+#realmStart)
      ignore = name.."-"..found
    end
  end
end)

mainFrameEdit:SetScript("OnEnterPressed",function()
  mainFrameEdit:ClearFocus()
  if toolSelected == 1 then
    addPopup("UNKNOWN",mainFrameEdit:GetText())
    resetAddIcon(true)
  elseif toolSelected == 2 then
    smemory = {}
    searchName = mainFrameEdit:GetText()
    for i = 1,#memory do
      local item = memory[i]
      if searchResult(item) then
        smemory[#smemory + 1] = item
        --print(item.name)
      end
    end
    scroll = 0
    mainFrameScroll(0,false,false)
    for i = 1,11 do
      local userFrame = userFrames[i]
      if (smemory ~= nil and i == min(#smemory,i)) or (smemory == nil and i == min(#memory,i)) then
        userFrame.userFrameUpdate(i - 1)
        userFrame:Show()
      else userFrame:Hide() end
    end
  end
end)

mainFrame:SetScript("OnMouseWheel",function(_,delta)
  local maxUsers = #memory - 10
  if (smemory ~= nil) then maxUsers = #smemory - 10 end
  if maxUsers > 0 then
    local maxScroll = maxUsers * 32
    scroll = scroll + delta * -48
    if scroll < 0 then
      scroll = 0
    elseif scroll > maxScroll then
      scroll = maxScroll
    end
    local adjustedValue = scroll / maxScroll * maxUsers
    mainFrameScroll(adjustedValue,false,true)
  end
end)

local function GetClassColorRGB(class)
  local color
  if CUSTOM_CLASS_COLORS then
    color = CUSTOM_CLASS_COLORS[class]
  elseif C_ClassColor and C_ClassColor.GetClassColor then
    color = C_ClassColor.GetClassColor(class)
  elseif RAID_CLASS_COLORS then
    color = RAID_CLASS_COLORS[class]
  end
  if color then return color.r, color.g, color.b end
  return 1, 1, 1
end

local function getClassCoords(class)
  return unpack(CLASS_ICON_TCOORDS[class] or CLASS_ICON_TCOORDS["WARRIOR"])
end

local function createUserFrame(offset)
local userFrame = CreateFrame("Frame",nil,mainFrame,"BackdropTemplate")
userFrame:SetSize(640,32)
userFrame:SetBackdrop({
  bgFile = "Interface\\Buttons\\WHITE8x8"
})
userFrame:SetBackdropColor(0,0,0)
userFrame:SetPoint("TOPLEFT",0,offset)
if #userFrames > 0 then
  userFrame:SetFrameLevel(userFrames[#userFrames]:GetFrameLevel() + 1)
end

local userClass,userName,userMood,userNote,userEdit,userDelete
userFrame.id = nil
userFrame.class = "UNKNOWN"
userFrame.rawClass = "UNKNOWN"
userFrame.name = ""
userFrame.mood = 0
userFrame.text = ""

userFrame.updateColor = function()
  if settgsIRY and settgsIRY.classColor and userFrame.rawClass ~= "UNKNOWN" then
    local r, g, b = GetClassColorRGB(userFrame.rawClass)
    userName:SetTextColor(r, g, b)
  else
    userName:SetTextColor(1, 1, 1)
  end
end

userFrame.userFrameUpdateIcon = function()
  local memoryItem = memory[#memory - userFrame.id]
  if (smemory ~= nil) then
    memoryItem = smemory[#smemory - userFrame.id]
  end
  
  userFrame.rawClass = memoryItem.class
  userFrame.class = memoryItem.class
  
  if userFrame.class == "UNKNOWN" then
    userClass:SetTexture("Interface\\AddOns\\IRememberYou\\unknown")
    userClass:SetTexCoord(0, 1, 0, 1)
  else
    userClass:SetTexture("Interface\\TARGETINGFRAME\\UI-CLASSES-CIRCLES")
    userClass:SetTexCoord(getClassCoords(userFrame.class))
  end
  
  userFrame.updateColor()
end

userFrame.userFrameUpdate = function(shift)
  userFrame.id = shift
  local memoryItem = memory[#memory - shift]
  if (smemory ~= nil) then
    memoryItem = smemory[#smemory - shift]
  end
  
  userFrame.rawClass = memoryItem.class
  userFrame.class = memoryItem.class
  userFrame.name = memoryItem.name
  userFrame.mood = memoryItem.mood
  userFrame.text = memoryItem.text

  if userFrame.class == "UNKNOWN" then
    userClass:SetTexture("Interface\\AddOns\\IRememberYou\\unknown")
    userClass:SetTexCoord(0, 1, 0, 1)
  else
    userClass:SetTexture("Interface\\TARGETINGFRAME\\UI-CLASSES-CIRCLES")
    userClass:SetTexCoord(getClassCoords(userFrame.class))
  end
  
  userName:SetText(userFrame.name)
  userNote:SetText(userFrame.text)
  userMood:SetTexCoord(unpack(moodIcons[userFrame.mood]))
  
  userFrame.updateColor()
end

userFrame.userFrameEdit = function(newMood,newNote)
  userFrame.mood = newMood
  userFrame.text = newNote
  userNote:SetText(userFrame.text)
  userMood:SetTexCoord(unpack(moodIcons[userFrame.mood]))
end

local userBlockFrame = CreateFrame("Frame",nil,userFrame)
userBlockFrame:SetAllPoints()
userBlockFrame:EnableMouse(true)
userBlockFrame:SetScript("OnEnter",function(self,motion)
  if lastUserFrameSelected ~= nil then
    lastUserFrameSelected.userFrameOnLeave()
  end
  lastUserFrameSelected = userFrame
  userEdit:Show()
  userDelete:Show()
  userName:SetTextColor(1,0.7529,0)
  userNote:SetTextColor(1,0.7529,0)
  userFrame:SetBackdropColor(0.125,0.125,0.125)
  userBlockFrame:EnableMouse(false)
end)
userFrame.userFrameOnLeave = function()
  userEdit:Hide()
  userDelete:Hide()
  userFrame.updateColor()
  userNote:SetTextColor(1,1,1)
  userFrame:SetBackdropColor(0,0,0)
  userBlockFrame:EnableMouse(true)
end
userFrame.userFrameOnLeaveAsk = function()
  if not userFrame:IsMouseOver() then
    userFrame.userFrameOnLeave()
  end
end
userFrame:SetScript("OnLeave",userFrame.userFrameOnLeaveAsk)

local function createText(parent,w,h,x,y)
  local t = parent:CreateFontString(nil,"OVERLAY","GameFontHighlight");
  t:SetSize(w,h)
  t:SetPoint("TOPLEFT",x,y)
  t:SetJustifyH("LEFT")
  t:SetJustifyV("MIDDLE")
  t:SetWordWrap(false)

  t:SetScript("OnEnter",function()
    t:SetWordWrap(true)
  end)

  t:SetScript("OnLeave",function()
    userFrame.userFrameOnLeaveAsk()
    t:SetWordWrap(false)
  end)
  return t
end

userClass = userFrame:CreateTexture(nil,"ARTWORK")
userClass:SetSize(28,28)
if userFrame.class == "UNKNOWN" then
  userClass:SetTexture("Interface\\AddOns\\IRememberYou\\unknown")
  userClass:SetTexCoord(0, 1, 0, 1)
else
  userClass:SetTexture("Interface\\TARGETINGFRAME\\UI-CLASSES-CIRCLES")
  userClass:SetTexCoord(getClassCoords(userFrame.class))
end
userClass:SetPoint("TOPLEFT",2+4,-2)

local userClassOutline = userFrame:CreateTexture(nil,"OVERLAY")
userClassOutline:SetSize(28,28)
userClassOutline:SetTexture("Interface\\AddOns\\IRememberYou\\user")
userClassOutline:SetTexCoord(0,0.5,0,0.5)
userClassOutline:SetPoint("TOPLEFT",2+4,-2)

userName = createText(userFrame,160,32,36+4,0)
userName:SetText("Wiciregord-Silvermoongfbgbffgbgbf")

userMood = userFrame:CreateTexture(nil,"OVERLAY")
userMood:SetSize(7,28)
userMood:SetTexture("Interface\\AddOns\\IRememberYou\\user")
userMood:SetTexCoord(unpack(moodIcons[userFrame.mood]))
userMood:SetPoint("TOPLEFT",200+4,-2)

userNote = createText(userFrame,240,32,211+4,0)
userNote:SetText("good group, did df megadung m0 with them erioerifj")

userEdit = CreateFrame("Button",nil,userFrame)
userEdit:SetSize(28,28)
userEdit:SetPoint("TOPLEFT",582,-2)
local userEditTexture = userEdit:CreateTexture(nil,"OVERLAY")
userEditTexture:SetTexture("Interface\\AddOns\\IRememberYou\\user")
userEditTexture:SetTexCoord(0.5,1,0.5,1)
userEditTexture:SetVertexColor(1,0.7529,0)
userEditTexture:SetAllPoints()
userEdit:SetScript("OnEnter",function()
  userEditTexture:SetVertexColor(1,1,1)
end)
userEdit:SetScript("OnLeave",function()
  userFrame.userFrameOnLeaveAsk()
  userEditTexture:SetVertexColor(1,0.7529,0)
end)
userEdit:Hide()
userEdit:SetScript("OnClick",function()
  editingName = userFrame.name
  editingMood = userFrame.mood
  editingText = userFrame.text
  
  local data = {}
  data.playerName = userFrame.name
  data.callback = function(argNote, argName)
    if not argName or strtrim(argName) == "" then argName = userFrame.name end
    argName = stripRealm(argName)
    local oldName = userFrame.name
    local nameChanged = (oldName ~= argName)
    for i, item in ipairs(memory) do
      if item.name == oldName then
        memory[i].name = argName
        memory[i].mood = snapValue
        memory[i].text = argNote
        
        if nameChanged then
          dbNotes[argName] = dbNotes[oldName]
          dbNotes[oldName] = nil
        end
        dbNotes[argName] = {mood = snapValue,text = argNote}
        print(T["EDITED"]);
        break
      end
    end
    userFrame.name = argName
    userName:SetText(argName)
    userFrame.userFrameEdit(snapValue,argNote)
  end
  local popup = StaticPopup_Show("REMEMBER",nil,nil,data)
  if popup ~= nil then popup:SetHeight(190) end
end)

userDelete = CreateFrame("Button",nil,userFrame)
userDelete:SetSize(28,28)
userDelete:SetPoint("TOPLEFT",610,-2)
local userDeleteTexture = userDelete:CreateTexture(nil,"OVERLAY")
userDeleteTexture:SetTexture("Interface\\AddOns\\IRememberYou\\user")
userDeleteTexture:SetTexCoord(0,0.5,0.5,1)
userDeleteTexture:SetVertexColor(1,0.7529,0)
userDeleteTexture:SetAllPoints()
userDelete:SetScript("OnEnter",function()
  userDeleteTexture:SetVertexColor(1,1,1)
end)
userDelete:SetScript("OnLeave",function()
  userFrame.userFrameOnLeaveAsk()
  userDeleteTexture:SetVertexColor(1,0.7529,0)
end)
userDelete:Hide()
userDelete:SetScript("OnClick",function()
  --print("delete")
  local data = {}
  data.selectedName = userFrame.name
  data.callback = function()
    local new_memory = {}
    for i, item in ipairs(memory) do
      if item.name ~= userFrame.name then
        new_memory[#new_memory + 1] = item
      end
    end
    memory = new_memory
    dbNotes[userFrame.name] = nil
    --UPDATE SMEMORY IF NEEDED
    local maxUsers = #memory - 10
    if (smemory ~= nil) then
      smemory = {}
      for i = 1,#memory do
        local item = memory[i]
        if searchResult(item) then
          smemory[#smemory + 1] = item
        end
      end
      maxUsers = #smemory - 10
    end
    --print("Button clicked! Deleted!");
    local maxScroll = maxUsers * 32
    local continue = true
    if maxUsers <= 0 then
      scroll = 0
      mainFrameScroll(0,false,false)
      for i = 1,11 do
        local userFrame = userFrames[i]
        if (smemory ~= nil and i == min(#smemory,i)) or (smemory == nil and i == min(#memory,i)) then
          userFrame.userFrameUpdate(i - 1)
          userFrame:Show()
        else userFrame:Hide() end
      end
    else
      continue = false
      scroll = max(0,scroll - 32)
      local adjustedValue = scroll / maxScroll * maxUsers
      mainFrameScroll(adjustedValue,true,true)
    end
    --
    --PopulateList()
    --selectedName = ""
    --closeButton:Hide()
  end
  if deletePopup ~= nil and deletePopup:IsVisible() then deletePopup:Hide() end
  deletePopup = StaticPopup_Show("DELETE", nil, nil, data);
  if deletePopup ~= nil then
    _G[deletePopup:GetName().."Text"]:SetPoint("TOP",0,-16)
  end
end)

userFrames[#userFrames + 1] = userFrame
return userFrame
end
--MYTESTPLACEEND

T["FONT"] = "SystemFont22_Shadow_Outline"
local classicEra = tocVersion < 40402
local classic = false
if tocVersion < 100200 then
  --T["FONT"] = "SystemFont_Shadow_Outline_Huge2"
  radius = 76
  classic = true
end
local modernUI = (not classic) or forever

StaticPopupDialogs["DELETE"] = {
	text = "",
	button1 = YES,
	button2 = NO,
  OnShow = function(self, data)
    _G[self:GetName() .. "Text"]:SetText(T["DELETE1"]..data.selectedName..T["DELETE2"])
    --self.AlertIcon:Show();
  end,
	OnAccept = function(self, data)
		data.callback();
	end,
	hideOnEscape = 1,
	timeout = 0,
	multiple = 1,
	whileDead = 1,
  wide = 1,
  showAlert = 1
}

local framee = CreateFrame("Frame", "CenterTextFrame", UIParent)
framee:SetPoint("CENTER", 0, 160)
framee:SetSize(400, 120)
framee:Hide()

local text = framee:CreateFontString(nil, "OVERLAY", T["FONT"])
text:SetPoint("CENTER", 0, 0)
--text:SetText("demo")
text:SetText("Nuvuvuua-Sylvanas")
--text:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
--text:SetScale(2)

local clock = 0
local running = false
local to_announce = {}
local animating = false
local animating2 = false
local animating3 = false
local mark_clock = 0
local mark_animating = false
function test()
  clock = GetTime()
  animating = true
  running = true
  if not settgsIRY.sound then PlaySound(236275,"Master") end
  framee:Show()
  text:SetText(to_announce[1])
end

function inQuad(t, b, c, d) return c * math.pow(t / d, 2) + b end
function outQuint(t, b, c, d) return c * (math.pow(t / d - 1, 5) + 1) + b end
function inOutQuad(t, b, c, d)
  t = t / (d / 2)
  if t < 1 then
      return c / 2 * t * t + b
  else
      t = t - 1
      return -c / 2 * (t * (t - 2) - 1) + b
  end
end
function bounce(t, b, c, d)
  t = t / d
  if t < (1 / 2.75) then
      return c * (7.5625 * t * t) + b
  elseif t < (2 / 2.75) then
      t = t - (1.5 / 2.75)
      return c * (7.5625 * t * t + 0.75) + b
  elseif t < (2.5 / 2.75) then
      t = t - (2.25 / 2.75)
      return c * (7.5625 * t * t + 0.9375) + b
  else
      t = t - (2.625 / 2.75)
      return c * (7.5625 * t * t + 0.984375) + b
  end
end

local testframe = CreateFrame("Frame","TestFrame",TargetFrame);
local posMark = {x=-45,y=0}
if not modernUI then
  posMark = {x=-64,y=2}
end
testframe:SetPoint("BOTTOMRIGHT", -45, 0);
testframe:SetSize(16, 32);
testframe:SetFrameStrata("MEDIUM")
testframe:SetFrameLevel(2)
local texturee = testframe:CreateTexture(nil, "OVERLAY");
--texturee:SetTexture("Interface\\Buttons\\UI-StopButton");
texturee:SetTexture("Interface\\AddOns\\IRememberYou\\mark")
texturee:SetAllPoints();

local sliderTextureFrame = CreateFrame("Frame","sliderTextureFrame",StaticPopup1);
--sliderTextureFrame:SetFrameStrata("TOOLTIP")
--sliderTextureFrame:SetFrameLevel(4)
sliderTextureFrame:SetAlpha(1)
sliderTextureFrame:SetSize(436*0.35,88*0.35)
sliderTextureFrame:SetPoint("TOP",0,-78);

local sliderTexture = sliderTextureFrame:CreateTexture(nil, "OVERLAY");
sliderTexture:SetTexture("Interface\\AddOns\\IRememberYou\\bar")
sliderTexture:SetTexCoord(0,0.8515625,0.171875,0.34375)

sliderTexture:SetAlpha(1)
sliderTexture:SetAllPoints();

--local Slider = CreateFrame("Slider", "SliderAddonSlider", UIFrame, "MinimalSliderWithSteppersTemplate");
local Slider = CreateFrame("Slider", "SliderAddonSlider", sliderTextureFrame, "OptionsSliderTemplate");
Slider:SetPoint("TOP", 0, 5);
Slider:SetWidth(160);
Slider:SetHeight(32);
Slider.Thumb:Hide()

Slider:SetMinMaxValues(-1,1);
Slider:SetValue(0);
Slider:SetValueStep(0.1);
Slider.Low:Hide();
Slider.High:Hide();
Slider:SetAlpha(0)
--Slider.Low:SetText("Poor");
--Slider.High:SetText("Great");
Slider:SetFrameStrata("TOOLTIP")
Slider:SetFrameLevel(4)

local moodFrame = CreateFrame("Frame","moodFrame",sliderTextureFrame);
moodFrame:SetPoint("TOP", 0, -3);
moodFrame:SetSize(24, 24);

Slider:SetScript("OnValueChanged",function(_,value)
  snapValue = math.floor(value + 0.5)
  --print(value.." "..snapValue)
  moodFrame:SetPoint("TOP",58*snapValue,-3)
  sliderTexture:SetTexCoord(0,0.8515625,0.171875*(snapValue+1),0.171875*(snapValue+2))
end)

--[[local testframe2 = CreateFrame("Frame","TestFrame2",PartyFrame.MemberFrame2);
testframe2:SetPoint("TOPLEFT", 8, -7);
testframe2:SetSize(52, 52);
testframe2:SetFrameStrata("MEDIUM")
testframe2:SetFrameLevel(2)
local texturee2 = testframe2:CreateTexture(nil, "OVERLAY");
--texturee:SetTexture("Interface\\Buttons\\UI-StopButton");
texturee2:SetTexture("Interface\\AddOns\\IRememberYou\\circle")
texturee2:SetAllPoints();]]--

function add(name,text)
  to_announce[#to_announce+1] = name.." |cffFCC000| |cffFFFFFF"..text
  if running == false then
    test()
  end
  for _,n in ipairs(to_announce) do
    --print(n)
  end
end

local function updateLFG()
  local ScrollTarget = LFGListFrame.SearchPanel.ScrollBox.ScrollTarget
  if not ScrollTarget then return end
  for _,button in ipairs({ScrollTarget:GetChildren()}) do
    if button and button.resultID then
      local resultInfo = C_LFGList.GetSearchResultInfo(button.resultID)
      if resultInfo and resultInfo.leaderName and dbNotes[resultInfo.leaderName] then
        if not button.noteIcon then
          button.noteIcon = button:CreateTexture(nil,"BACKGROUND")
          button.noteIcon:SetTexture("Interface\\AddOns\\IRememberYou\\note")
          button.noteIcon:SetSize(6,32)
          button.noteIcon:SetTexCoord(0,0.75,0,1)
          button.noteIcon:SetPoint("RIGHT")
        end
        button.noteIcon:Show()
      elseif button.noteIcon then button.noteIcon:Hide() end
    end
  end
end

function fupdate()
  if not classicEra and not forever and LFGListFrame and LFGListFrame:IsVisible() then updateLFG() end
  if register then
    local x,y = GetCursorPosition()
    x = x / UIParent:GetEffectiveScale()
    y = y / UIParent:GetEffectiveScale()
    local cursorPosX,cursorPosY = mainFrameScrollHit:GetCenter()
    cursorPosX = x - cursorPosX
    cursorPosY = y - cursorPosY
    local scrollPos = abs(min(max(cursorPosY,-143.625),143.625) / 287.25 - 0.5)
    if scrollPos ~= lastScrollPos then
      lastScrollPos = scrollPos
      local newHandPos = -5.875-34-30 + (scrollPos * (-293.125 - (-5.875)))
      mainFrameScrollHand:SetPoint("TOPLEFT",645.875,newHandPos)

      local maxUsers = #memory - 10
      if smemory ~= nil then maxUsers = #smemory - 10 end
      if maxUsers > 0 then
        local adjustedValue = maxUsers * scrollPos
        mainFrameScroll(adjustedValue,true,true)
      end
    end
  end
  if animating == true then
    if clock > GetTime() - 0.5 then
      local num2 = (GetTime()-clock)/0.5
      num2 = inOutQuad(num2,0,1,1)
      --print(num2)
      framee:SetPoint("CENTER",0,20 * num2 + 140)
      framee:SetAlpha(num2)
    else
      framee:SetPoint("CENTER",0,160)
      framee:SetAlpha(1)
      animating = false
      animating2 = true
      clock = GetTime()
    end
  elseif animating2 == true then
    if clock > GetTime() - 3 then
      local num2 = (GetTime()-clock)/0.5
      num2 = inOutQuad(num2,0,1,1)
      --print(num2)
    else
      animating2 = false
      animating3 = true
      clock = GetTime()
    end
  elseif animating3 == true then
    if clock > GetTime() - 0.5 then
      local num2 = (GetTime()-clock)/0.5
      num2 = inOutQuad(num2,0,1,1)
      --print(num2)
      framee:SetPoint("CENTER",0,20 * num2 + 160)
      framee:SetAlpha(1-num2)
    else
      for i = 1, #to_announce - 1 do
        to_announce[i] = to_announce[i + 1]
      end
      to_announce[#to_announce] = nil
      framee:SetAlpha(0)
      animating3 = false
      --print(#to_announce)
      if #to_announce > 0 then
        test()
      else
        running = false
        framee:Hide()
      end
    end
  end
  if mark_animating then
    if mark_clock > GetTime() - 0.5 then
      local num = (GetTime()-mark_clock)/0.5
      local num_alpha = outQuint(num,0,1,1)
      num = bounce(num,0,1,1)
      --print(num2)
      testframe:SetAlpha(num_alpha)
      testframe:SetPoint("BOTTOMRIGHT", posMark.x, 12*(1-num) + posMark.y);
    else
      testframe:SetAlpha(1)
      testframe:SetPoint("BOTTOMRIGHT", posMark.x, posMark.y);
      mark_animating = false
    end
  end
end

function addMark()
  testframe:Show()
  if not settgsIRY.sound then PlaySound(73,"Master") end
  mark_clock = GetTime()
  mark_animating = true
end

function locToEngClass(arg)
  local reversedMale = {}
  for i,n in pairs(LOCALIZED_CLASS_NAMES_MALE) do reversedMale[n] = i end
  if reversedMale[arg] ~= nil then return reversedMale[arg] end
  local reversedFemale = {}
  for i,n in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do reversedFemale[n] = i end
  if reversedFemale[arg] ~= nil then return reversedFemale[arg] end
  return "UNKNOWN"
end

local lastBosses = {}
for _,n in ipairs({
  2901,2930,2909,2788,2848,2839,2836,2883, --The War Within
  2565,2569,2618,2611,2623,2584,2580,2559,2673, --Dragonflight
  2396,2381,2393,2386,2363,2359,2442,2390,2404, --Shadowlands
  2087,2096,2143,2260,2133,2100,2127,2108,2123,2104,2117, --Battle for Azeroth
  1851,1856,1835,2053,1870,1839,1814,1809,1824,1793,2017,2068,1829,1818, --Legion
  1968,1973,1975,1981,1986,1990,1998,2000,2005,2007,527,534,2020,2021,2025,2028, --Wrath of the Lich King
  2735,2747,592,2755,2767,2759, --Classic Era (Bazzalan/Edwin VanCleef/Mutanus the Devourer/Archmage Arugal/Aku'mai/Dextren Ward/
  2778,2779,2772,447,448,2785, --Charlga Razorflank/Bloodmage Thalnos/Mekgineer Thermaplugg/Arcanist Doan/Herod/Amnennar the Coldbringer/
  450,554,429,2790,275,478, --High Inquisitor Whitemane/Archaedas/?/Princess Theradras/?/Emperor Dagran Thaurissan/Overlord Wyrmthalak/Balnazzar/
  484,2801,346,361,368 --Baron Rivendare/Darkmaster Gandling/Alzzin the Wildshaper/Prince Tortheldrin/King Gordok/?)
  --do more + classic
}) do lastBosses[n] = true end

local lastBossesLFD = {}
for _,n in ipairs({
  2669 --Dragonflight
}) do lastBossesLFD[n] = true end

local mythicPlus = {}
--for _,n in ipairs({463,464,244,248,199,198,168,456}) do mythicPlus[n] = true end --season3 DF
--for _,n in ipairs({402,405,406,404,399,401,400,403}) do mythicPlus[n] = true end --season4 DF
--for _,n in ipairs({353,375,501,376,505,507,502,503}) do mythicPlus[n] = true end --season1 TWW
--for _,n in ipairs({506,504,499,500,525,382,370,247}) do mythicPlus[n] = true end --season2 TWW
--for _,n in ipairs({505,391,392,499,525,378,542,503}) do mythicPlus[n] = true end --season3 TWW
--for _,n in ipairs({558,560,559,557,402,239,161,556}) do mythicPlus[n] = true end --season1 MN
for _,n in ipairs({588,586,587,584,585,399,250,249}) do mythicPlus[n] = true end --season2 MN

local function myRealm(name)
  if forever then return name end
  local realm = string.match(name,"-(.*)")
  if realm == GetNormalizedRealmName() then return string.match(name,"^(.-)-") end
  return name
end

local chatMoodTex = {[-1] = "0:8",[0] = "8:16",[1] = "16:24"}
local function chatMood(_,_,msg,name,...)
  if settgsIRY.chat then return false end
  local note = dbNotes[myRealm(name)]
  if note then return false,"|TInterface\\AddOns\\IRememberYou\\mood:10:4:0:-1:24:20:"..chatMoodTex[note.mood]..":0:20|t "..msg,name,... end
  return false
end

local chatEvents = {
  "CHAT_MSG_INSTANCE_CHAT",
  "CHAT_MSG_PARTY",
  "CHAT_MSG_RAID",
  "CHAT_MSG_SAY",
  "CHAT_MSG_YELL",
  "CHAT_MSG_WHISPER",
  "CHAT_MSG_PARTY_LEADER",
  "CHAT_MSG_CHANNEL"
}
for _,event in ipairs(chatEvents) do
  ChatFrame_AddMessageEventFilter(event,chatMood)
end

function addMassPopup(party)
  local data = {}
  data.isMassAdd = true
  data.callback = function(argNote, argName)
    local added = false
    local serverTime = GetServerTime()
    local addTime = 0
    for _,n in ipairs(party) do
      local edit = false
      for _,m in ipairs(memory) do
        if m.name == n.name then
          edit = true
          break
        end
      end
      if not edit then
        memory[#memory+1] = {name = n.name,text = argNote,class = n.class,mood = snapValue,time = serverTime + addTime}
        dbNotes[n.name] = {mood = snapValue,text = argNote}
        addTime = addTime + 0.01
        --print("You remember |cffFCC000"..name.." |cffFFFFFFnow!");
        if smemory ~= nil then
          local item = memory[#memory]
          if searchResult(item) then
            smemory[#smemory + 1] = item
          end
        end
        print(T["ADD1"]..n.name..T["ADD2"])
        --[[if announce == true then
          SendChatMessage(T["ANNOUNCE1"].." "..n.name..T["ANNOUNCE2"].."!","EMOTE")
        end]]--
        added = true
      end
    end
    if added then
      local maxUsers = #memory - 10
      isSorted = false
      sortByNameAZ = true
      sortByDescriptionAZ = true
      table.sort(memory,sortByTime)
      if smemory ~= nil then
        maxUsers = #smemory - 10
        table.sort(smemory,sortByTime)
      end
      if maxUsers > 0 then
        scroll = 0
        mainFrameScroll(0,false,false)
      end
      for i = 1,11 do
        local userFrame = userFrames[i]
        if (smemory ~= nil and i == min(#smemory,i)) or (smemory == nil and i == min(#memory,i)) then
          userFrame.userFrameUpdate(i - 1)
          userFrame:Show()
        else userFrame:Hide() end
      end
    else
      print(T["ERROR"])
    end
  end
  --[[if not isElvUIInstalled and not isShadowedUnitFrames then
    addMark()
  end]]--
  if editingName ~= "" then
    editingName = ""
    editingText = ""
    editingMood = 0
  end
  local popup = StaticPopup_Show("REMEMBER",nil,nil,data);
  if popup ~= nil then popup:SetHeight(156) end
end

hooksecurefunc("SetItemRef", function(link)
	local linkType,addon,action,param1 = strsplit(":", link)
	if linkType == "addon" and addon == "IRememberYou" then
	  local getData = loadstring("return "..param1)()
    if action == "Mass" then addMassPopup(getData)
    else addPopup(getData.class,getData.name) end
	end
end)

function bts(bool)
  if bool then
      return "true"
  else
      return "false"
  end
end

local function printMass()
  local link = T["MASS1"].."|Haddon:IRememberYou:Mass:{"
  for i=1,math.min(GetNumGroupMembers()-1,4) do
    if UnitName("party"..i) ~= nil then
      local memberName = getName("party"..i)
      if memberName then
        link = link .. '{name="'..memberName..'"'..',class="'..(select(2,UnitClass("party"..i)) or "UNKNOWN")..'"},'
      end
    end
  end
  link = link .. "}|h["..T["MASS2"].."]|h|r"..T["MASS3"]
  C_Timer.After(2, function() print(link) end)
end

local function printLeaver(name,class)
  print("|cffFCC000"..name..T["LEAVER1"]..'|cffFCC000|Haddon:IRememberYou:Leaver:{name="'..name..'",class="'..class..'"}|h['..T["LEAVER2"].."]|h|r"..T["LEAVER3"])
end

local firstload = true
local myParty = {}
local isElvUIInstalled, isShadowedUnitFrames, isRaiderIO, istotalRP3
local moodColors = {"|cffFF0000","|cffFCC000","|cff00FF00"}
local isAddOnLoaded = (C_AddOns and C_AddOns.IsAddOnLoaded) or IsAddOnLoaded

local modernTooltip = (not classic) or (forever and TooltipDataProcessor ~= nil and Enum and Enum.TooltipDataType ~= nil)

if modernTooltip then TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit,function(tooltip)
  local tooltipData = tooltip.GetPrimaryTooltipData and tooltip:GetPrimaryTooltipData()
  local guid = tooltipData and tooltipData.guid
  if issecretvalue and issecretvalue(guid) then return end
  local _,unit = tooltip:GetUnit()
  if issecretvalue and issecretvalue(unit) then return end
	if unit then
    local isPlayer = UnitIsPlayer(unit)
    if isPlayer then
      local name = getName(unit)
      local note = name and dbNotes[name]
      if note then tooltip:AddLine("\n" .. moodColors[note.mood+2] .. "[NOTE] |cffFFFFFF> " .. note.text) end
    end
	end
end) else hooksecurefunc("GameTooltip_HideBattlePetTooltip",function()
  local _,unit = GameTooltip:GetUnit()
	if unit then
    local isPlayer = UnitIsPlayer(unit)
    if isPlayer then
      local name = getName(unit)
      local note = dbNotes[name]
      if note then GameTooltip:AddLine("\n" .. moodColors[note.mood+2] .. "[NOTE] |cffFFFFFF> " .. note.text) end
    end
	end
end) end

function Main_OnEvent(self, event, arg1)
  if event == "BOSS_KILL" then
    if GetNumGroupMembers() > 1 and (lastBosses[arg1] ~= nil or (not forever and IsLFGModeActive(LE_LFG_CATEGORY_LFD) and lastBossesLFD[arg1] ~= nil)) and (classic or not C_ChallengeMode.IsChallengeModeActive()) then
      printMass()
    end
  elseif event == "CHALLENGE_MODE_COMPLETED" then
    local mapID = C_ChallengeMode.GetChallengeCompletionInfo().mapChallengeModeID
    if GetNumGroupMembers() > 1 and mythicPlus[mapID] ~= nil then printMass() end
  elseif event == "PLAYER_TARGET_CHANGED" then
    if (isElvUIInstalled and TargetFrame:IsVisible() == false) or isShadowedUnitFrames then
      --print("returned")
      return
    end
    --print("changed target")
    local target_name = getName("target")
    testframe:Hide()
    if target_name and dbNotes[target_name] then addMark() end
  elseif event == "PLAYER_ENTERING_WORLD" then
    isElvUIInstalled = isAddOnLoaded("ElvUI")
    isShadowedUnitFrames = isAddOnLoaded("ShadowedUnitFrames")
    isRaiderIO = isAddOnLoaded("RaiderIO")
    istotalRP3 = isAddOnLoaded("totalRP3")
    --ToggleAchievementFrame()
    --ToggleAchievementFrame()
    --[[AchievementFrame:HookScript("OnShow", function()
      if firstload then
        firstload = false
        hooksecurefunc(AchievementTemplateMixin,"Init", function(data)
          local index = data.index;
          local id = data.id;
          local category = data.category;
          local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy = GetAchievementInfo(id);
          
          --print(name .. " " .. id)
        end)

        hooksecurefunc(AchievementTemplateMixin,"OnEnter", function(data)
          GameTooltip:Hide()
          GameTooltip_SetBasicTooltip(GameTooltip,data.id)
          GameTooltip:SetPoint("BOTTOMLEFT", data, "TOPLEFT",8,-42);
        end)

        hooksecurefunc(AchievementTemplateMixin,"OnLeave", function(data)
          GameTooltip:Hide()
        end)
      end
    end)]]--
  elseif event == "ADDON_LOADED" and arg1 == "IRememberYou" then
    if memory == nil then
      memory = {}
    end
    if not settgsIRY then
      settgsIRY = {
        sound = false,
        chat = false,
        classColor = true
      }
    end
    if settgsIRY.classColor == nil then settgsIRY.classColor = true end
    local serverTime = GetServerTime()
    --for i, item in ipairs(memory) do
    for i = #memory,1,-1 do
      local item = memory[i]
      if item.mood == nil then
        memory[i].mood = 0
      end
      if item.time == nil then
        memory[i].time = serverTime
        serverTime = serverTime - 1
      end
    end
    myParty[getName("player")] = {value = 1,class = select(2,UnitClass("player"))}
    for i = 1,11 do
      local userFrame = createUserFrame((i - 1) * -32)
      if i <= #memory then
        userFrame.userFrameUpdate(i - 1)
      else
        userFrame:Hide()
      end
    end
    local LibDBIcon = LibStub("LibDBIcon-1.0")
    LibDBIcon:Register("IRememberYou",LDB,dbIRY.minimap)
    buttonIRY = LibDBIcon:GetMinimapButton("IRememberYou")
    for _,region in ipairs({buttonIRY:GetRegions()}) do
      if region:GetObjectType() == "Texture" and region:GetTexture() ~= 136477 then region:Hide() end
    end
    buttonIRY.texture = buttonIRY:CreateTexture(nil,"BACKGROUND")
    buttonIRY.texture:SetTexture("Interface\\AddOns\\IRememberYou\\icon")
    buttonIRY.texture:SetSize(34,34)
    buttonIRY.texture:SetTexCoord(0,0.625,0,0.625)
    buttonIRY.texture:SetPoint("CENTER")
    local settgMinimap = newSetting(1,"Hide minimap button",dbIRY.minimap.hide)
    local settgSound = newSetting(2,"Mute sound effects",settgsIRY.sound)
    local settgChat = newSetting(3,"Hide mood of the note in chat",settgsIRY.chat)
    local settgClassColor = newSetting(4,"Color names by class",settgsIRY.classColor)
    for _,note in ipairs(memory) do dbNotes[note.name] = {mood = note.mood,text = note.text} end
  elseif event == "GROUP_ROSTER_UPDATE" then
    local numGroupMembers = GetNumGroupMembers()
    if numGroupMembers > 0 then
      local updateIcons = false
      for key in pairs(myParty) do myParty[key].value = 2 end
      for i = 1,numGroupMembers do
        local nameMember,_,_,_,classMember
        if forever then
          local unit
          if IsInRaid() then unit = "raid"..i
          elseif i < numGroupMembers then unit = "party"..i
          else unit = "player" end
          nameMember = getName(unit)
          classMember = select(2,UnitClass(unit))
        else
          nameMember,_,_,_,classMember = GetRaidRosterInfo(i)
        end
        if nameMember ~= nil then
          if not myParty[nameMember] then
            if not forever then classMember = locToEngClass(classMember) end
            classMember = classMember or "UNKNOWN"
            myParty[nameMember] = {value = 1,class = classMember}
            for _,n in ipairs(memory) do if n.name == nameMember then
              add(n.name,n.text)
              print(T["NOTE1"]..n.name..T["NOTE2"]..n.text)
              if n.class == "UNKNOWN" then
                n.class = classMember
                if bigFrame:IsVisible() and n.class ~= "UNKNOWN" then updateIcons = true end
              end
              break
            end end
          else myParty[nameMember].value = 1 end
        end
      end
      for key,member in pairs(myParty) do if member.value ~= 1 then
        if not classic and C_ChallengeMode.IsChallengeModeActive() then printLeaver(key,member.class) end
        myParty[key] = nil
      end end
      if updateIcons then
        for i = 1,11 do
          local userFrame = userFrames[i]
          if userFrame:IsVisible() then userFrame.userFrameUpdateIcon() end
        end
      end
    end
  elseif event == "GROUP_LEFT" then
    myParty = {}
    myParty[getName("player")] = {value = 1,class = select(2,UnitClass("player"))}
  end
end

local main = CreateFrame("Frame")
main:SetScript('OnUpdate',fupdate)
main:RegisterEvent("ADDON_LOADED")
main:RegisterEvent("GROUP_ROSTER_UPDATE")
main:RegisterEvent("GROUP_LEFT")
main:RegisterEvent("PLAYER_ENTERING_WORLD")
main:RegisterEvent("PLAYER_TARGET_CHANGED")
if not classic then main:RegisterEvent("CHALLENGE_MODE_COMPLETED") end
main:RegisterEvent("BOSS_KILL")
main:SetScript("OnEvent", Main_OnEvent)

function printMemory()
  for i, v in ipairs(memory) do
    --print(i, v.name.." "..v.text)
  end
  PopulateList()
end

function clearMemory()
  memory = {}
end

function getName(id)
  if forever then
    local firstName, lastName = UnitName(id)
    if issecretvalue and issecretvalue(firstName) then return end
    if firstName == nil then return end
    if lastName ~= nil and lastName ~= "" then return firstName.." "..lastName end
    return firstName
  end
  local name, realm = UnitName(id)
  if issecretvalue and issecretvalue(name) then return end
  if realm == nil or realm == "" then return name end
  return name.."-"..realm
end

function fixName(name,realm)
  if forever then return name end
  if realm == "" then return name end
  return name.."-"..realm
end

SLASH_MEMORY1 = "/memory"
SLASH_MEMORY2 = "/irememberyou"
SLASH_MEMORY3 = "/remember"
SlashCmdList["MEMORY"] = function(arg)
  if bigFrame:IsVisible() then bigFrame:Hide()
  else
    if isSorted then
      isSorted = false
      sortByNameAZ = true
      sortByDescriptionAZ = true
      table.sort(memory,sortByTime)
      local maxUsers = #memory - 10
      if smemory ~= nil then
        table.sort(smemory,sortByTime)
        maxUsers = #smemory - 10
      end
      if maxUsers > 0 then
        scroll = 0
        mainFrameScroll(0,false,false)
      end
      for i = 1,11 do
        local userFrame = userFrames[i]
        if (smemory ~= nil and i == min(#smemory,i)) or (smemory == nil and i == min(#memory,i)) then
          userFrame.userFrameUpdate(i - 1)
        end
      end
    end
    bigFrame:Show()
  end
end

SLASH_IRYMAP1 = "/irymap"
SlashCmdList["IRYMAP"] = function(arg)
  buttonIRY:SetShown(dbIRY.minimap.hide)
  dbIRY.minimap.hide = not dbIRY.minimap.hide
end

sliderTextureFrame:Hide()

local IRYNameEditFrame = CreateFrame("Frame", "IRYNameEditFrame", UIParent)
IRYNameEditFrame:SetSize(240, 24)
IRYNameEditFrame:Hide()

local IRYNameLabel = IRYNameEditFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
IRYNameLabel:SetText("Name:")
IRYNameLabel:SetPoint("LEFT", 0, 0)
IRYNameLabel:SetSize(45, 24)
IRYNameLabel:SetJustifyH("LEFT")

local IRYNameBox = CreateFrame("EditBox", "IRYNameBox", IRYNameEditFrame, "InputBoxTemplate")
IRYNameBox:SetSize(185, 20)
IRYNameBox:SetPoint("RIGHT", 0, 0)
IRYNameBox:SetAutoFocus(false)
IRYNameBox:SetMaxLetters(100)
IRYNameBox:SetFontObject(ChatFontNormal)

IRYNameBox:SetScript("OnTabPressed", function()
    local popup = IRYNameEditFrame:GetParent()
    if popup then
        local editBox = _G[popup:GetName() .. "EditBox"]
        if editBox then editBox:SetFocus() end
    end
end)
IRYNameBox:SetScript("OnEnterPressed", function()
    local popup = IRYNameEditFrame:GetParent()
    if popup then
        local editBox = _G[popup:GetName() .. "EditBox"]
        if editBox then editBox:SetFocus() end
    end
end)

local function getEditBox(parent)
  return _G[parent:GetName() .. "EditBox"]
end
StaticPopupDialogs["REMEMBER"] = {
	text = T["POPUP"],
	button1 = DONE,
	button2 = CANCEL,
	hasEditBox = 1,
	maxLetters = 50,
	OnAccept = function(self,data)
    local editBox = getEditBox(self)
		local text = editBox:GetText();
		local nameText = IRYNameBox:GetText();
    data.callback(text, nameText);
	end,
	EditBoxOnEnterPressed = function(self,data)
    local editBox = getEditBox(self:GetParent())
		local text = editBox:GetText();
		local nameText = IRYNameBox:GetText();
    data.callback(text, nameText);
		self:GetParent():Hide();
	end,
  EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide();
  end,
	OnHide = function(self)
    sliderTextureFrame:Hide()
    IRYNameEditFrame:Hide()
		ChatEdit_FocusActiveWindow();
	end,
  OnShow = function(self, data)
    local editBox = getEditBox(self)
    editBox:SetText("")
    
    if data and data.isMassAdd then
      IRYNameEditFrame:Hide()
    else
      IRYNameEditFrame:Show()
      IRYNameBox:SetText((data and data.playerName) or "")
    end

    if editingName ~= "" then
      Slider:SetValue(0.1)
      Slider:SetValue(editingMood)
      editBox:SetText(editingText)
    else
      Slider:SetValue(0.1)
      Slider:SetValue(0)
    end
    
    sliderTextureFrame:Show()
    
    local topText = _G[self:GetName().."Text"]
    topText:ClearAllPoints()
    topText:SetPoint("TOP", self, "TOP", 0, -16)
    
    if data and data.isMassAdd then
        sliderTextureFrame:SetParent(self)
        sliderTextureFrame:ClearAllPoints()
        sliderTextureFrame:SetPoint("TOP", self, "TOP", 0, -42)

        editBox:ClearAllPoints()
        editBox:SetPoint("TOP", self, "TOP", 0, -82)
    else
        IRYNameEditFrame:SetParent(self)
        IRYNameEditFrame:ClearAllPoints()
        IRYNameEditFrame:SetPoint("TOP", self, "TOP", 0, -42)

        sliderTextureFrame:SetParent(self)
        sliderTextureFrame:ClearAllPoints()
        sliderTextureFrame:SetPoint("TOP", self, "TOP", 0, -76)

        editBox:ClearAllPoints()
        editBox:SetPoint("TOP", self, "TOP", 0, -116)
    end
    
    editBox:SetWidth(240)
    editBox:EnableMouse(true)
    
    local doneButton = _G[self:GetName() .. "Button1"]
    local cancelButton = _G[self:GetName() .. "Button2"]
    doneButton:ClearAllPoints()
    doneButton:SetPoint("BOTTOMRIGHT", self, "BOTTOM", -6, 16)
    cancelButton:ClearAllPoints()
    cancelButton:SetPoint("BOTTOMLEFT", self, "BOTTOM", 6, 16)

		editBox:SetFocus();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = true
};

--[[hooksecurefunc("LFGListSearchPanel_UpdateResults",function(self)
  if not self.searching then
    local results = self.results;
		for index = 1, #results do
			local id = results[index];
      print(C_LFGList.GetSearchResultMemberInfo(id, 1))
		end
  end
end)]]--

function addPopup(class,name)
  name = stripRealm(name)
  local data = {}
  data.playerName = name
  data.callback = function(argNote, argName)
    if not argName or strtrim(argName) == "" then argName = name end
    argName = stripRealm(argName)
    local edit = false
    for i, item in ipairs(memory) do
      if item.name == name or item.name == argName then
        local oldName = item.name
        memory[i].name = argName
        memory[i].mood = snapValue
        memory[i].text = argNote
        if oldName ~= argName then
            dbNotes[argName] = dbNotes[oldName]
            dbNotes[oldName] = nil
        end
        dbNotes[argName] = {mood = snapValue,text = argNote}
        edit = true
        print(T["EDITED"]);
        break
      end
    end
    if edit == false then
      memory[#memory+1] = {name = argName,text = argNote,class = class,mood = snapValue,time = GetServerTime()}
      dbNotes[argName] = {mood = snapValue,text = argNote}
      --print("You remember |cffFCC000"..argName.." |cffFFFFFFnow!");
      print(T["ADD1"]..argName..T["ADD2"])
      --[[if announce == true then
        SendChatMessage(T["ANNOUNCE1"].." "..argName..T["ANNOUNCE2"].."!","EMOTE")
      end]]--
      if not isElvUIInstalled and not isShadowedUnitFrames then
        addMark()
      end
      isSorted = false
      sortByNameAZ = true
      sortByDescriptionAZ = true
      table.sort(memory,sortByTime)
      if smemory ~= nil then
        table.sort(smemory,sortByTime)
        local item = memory[#memory]
        if searchResult(item) then
          smemory[#smemory + 1] = item
        end
      end
    end

    local maxUsers = #memory - 10
    if smemory ~= nil then maxUsers = #smemory - 10 end
    if maxUsers > 0 then
      scroll = 0
      mainFrameScroll(0,false,false)
    end
    for i = 1,11 do
      local userFrame = userFrames[i]
      if (smemory ~= nil and i == min(#smemory,i)) or (smemory == nil and i == min(#memory,i)) then
        userFrame.userFrameUpdate(i - 1)
        userFrame:Show()
      else userFrame:Hide() end
    end
  end
  if editingName ~= "" then
    editingName = ""
    editingText = ""
    editingMood = 0
  end
  local popup = StaticPopup_Show("REMEMBER",nil,nil,data);
  if popup ~= nil then popup:SetHeight(190) end
end

local function addRememberButton(class,name)
  UIDropDownMenu_AddSeparator()
  local info2 = UIDropDownMenu_CreateInfo();
  info2.text = T["REMEMBER"]
  info2.notCheckable = true;
  info2.func = function() addPopup(class,name) end
  UIDropDownMenu_AddButton(info2,1)
end

local function modify(_,parent,data)
  parent:CreateDivider()
  parent:CreateButton(T["REMEMBER"],function()
    if forever then
      local fClass, fName = "UNKNOWN", nil
      local unit = data and data.unit
      if unit and UnitExists(unit) and UnitIsPlayer(unit) then
        fName = getName(unit)
        fClass = select(2,UnitClass(unit)) or "UNKNOWN"
      end
      if not fName and data then
        fName = data.name
        local guid = data.playerLocation and data.playerLocation.guid
        if not guid and data.playerLocation and data.playerLocation.chatLineID and C_ChatInfo and C_ChatInfo.GetChatLineSenderGUID then
          guid = C_ChatInfo.GetChatLineSenderGUID(data.playerLocation.chatLineID)
        end
        if guid and GetPlayerInfoByGUID then
          local _,englishClass = GetPlayerInfoByGUID(guid)
          if englishClass then fClass = englishClass end
        end
      end
      if fName then addPopup(fClass,fName) end
      return
    end
    local guid = data.playerLocation and (data.playerLocation.guid or C_ChatInfo.GetChatLineSenderGUID(data.playerLocation.chatLineID))
    if guid then
      local _,class,_,_,_,name,realm = GetPlayerInfoByGUID(guid)
      addPopup(class,fixName(name,realm))
    else
      class = "UNKNOWN"
      name = data.name
      addPopup(class,name)
    end
  end)
end
if Menu and Menu.ModifyMenu then
  for _,tag in ipairs({
    "MENU_UNIT_ENEMY_PLAYER",
    "MENU_UNIT_FRIEND",
    "MENU_UNIT_PARTY",
    "MENU_UNIT_PLAYER",
    "MENU_UNIT_RAID_PLAYER"
  }) do Menu.ModifyMenu(tag,modify) end
end

if not classicEra and not forever then
  Menu.ModifyMenu("MENU_LFG_FRAME_SEARCH_ENTRY",function(owner,parent,data)
    parent:CreateDivider()
    parent:CreateButton(T["REMEMBER"],function()
      local class = select(2,C_LFGList.GetSearchResultMemberInfo(owner.resultID,1))
      local name = C_LFGList.GetSearchResultInfo(owner.resultID).leaderName
      addPopup(class,name)
    end)
  end)

  hooksecurefunc("LFGListSearchEntry_OnEnter",function(self)
    if self.resultID then
      local resultInfo = C_LFGList.GetSearchResultInfo(self.resultID)
      if resultInfo and resultInfo.leaderName then
        local note = dbNotes[resultInfo.leaderName]
        if note then
          GameTooltip:AddLine("\n" .. moodColors[note.mood+2] .. "[NOTE] |cffFFFFFF> " .. note.text)
          GameTooltip:Show()
        end
      end
    end
  end)

  hooksecurefunc("LFGListApplicationViewer_UpdateApplicantMember", function(member, appID, memberIdx)
    local applicantName = C_LFGList.GetApplicantMemberInfo(appID, memberIdx)

    member.__applicantName = applicantName

    if member.FriendIcon.Icon:GetTexture() == -11406 then
      member.FriendIcon:SetScale(1)
      member.FriendIcon.Icon:SetTexture(985877)
    end

    for _, n in ipairs(memory) do
      if n.name == applicantName then
        member.FriendIcon:SetAlpha(1)
        member.FriendIcon:Show()
        member.FriendIcon:SetScale(1.4)
        member.FriendIcon.Icon:SetTexture("Interface\\AddOns\\IRememberYou\\mark2")

        local OFFSET_X = 88
        local point, relativeTo, relativePoint, x, y = member.FriendIcon:GetPoint(1)
        if member.FriendIcon.__offsetX ~= OFFSET_X then
          member.FriendIcon:ClearAllPoints()
          member.FriendIcon:SetPoint(point, relativeTo, relativePoint, x + OFFSET_X, y)
          member.FriendIcon.__offsetX = OFFSET_X
        end
      end
    end

    if not member.__noteHooked then
      member.__noteHooked = true

      member:HookScript("OnEnter", function(self)
        local note = dbNotes[self.__applicantName]
        if note then
          GameTooltip:AddLine(" ")
          GameTooltip:AddLine(
            moodColors[note.mood + 2] ..
            "[NOTE] |cffFFFFFF" .. note.text
          )
          GameTooltip:Show()
        end
      end)
    end
  end)
end

--[[function generateRandomString()
  local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  local length = 10
  local randomString = ""

  for _ = 1, length do
      local randomIndex = math.random(1, #characters)
      randomString = randomString .. characters:sub(randomIndex, randomIndex)
  end

  return randomString
end

function stress()
  for i=1,1000 do
    memory[#memory+1] = {name = generateRandomString(),text = generateRandomString(),class = "WARRIOR",mood = 1}
  end
end]]--
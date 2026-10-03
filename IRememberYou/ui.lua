-- ui.lua -- Dragonflight window art for IRememberYou, from the sheets DragonUI ships (a required dependency):
-- the metal frame, rock background and red buttons its own bag and character windows use. The layout
-- numbers follow DragonUI's modules/bags_skin.lua so these windows sit beside DragonUI's without a seam.
local _, IRY = ...

local ART = "Interface\\AddOns\\DragonUI\\Textures\\UI\\"
local METAL, METAL_H, METAL_V = ART .. "uiframemetal2x", ART .. "uiframemetalhorizontal2x", ART .. "uiframemetalvertical2x"
local ROCK, RED = ART .. "ui-background-rock", ART .. "redbutton2x"

local function piece(frame, path, w, h, l, r, t, b)
  local tex = frame:CreateTexture(nil, "OVERLAY")
  tex:SetTexture(path)
  tex:SetSize(w, h)
  tex:SetTexCoord(l, r, t, b)
  return tex
end

-- Metal frame + rock ground around `frame`. compact = the thinner trim retail uses on small dialogs.
function IRY.Chrome(frame, compact)
  local top, bot, topY, botY, left, right = compact and 52 or 75, compact and 24 or 32, compact and 11 or 16, compact and -2 or -3, compact and -9 or -8, compact and 3 or 4
  local tl = piece(frame, METAL, top, top, 0.00195312, 0.294922, 0.00195312, 0.294922)
  tl:SetPoint("TOPLEFT", frame, "TOPLEFT", left, topY)
  local tr = piece(frame, METAL, top, top, 0.298828, 0.591797, 0.00195312, 0.294922)
  tr:SetPoint("TOPRIGHT", frame, "TOPRIGHT", right, topY)
  local bl = piece(frame, METAL, bot, bot, 0.298828, 0.423828, 0.298828, 0.423828)
  bl:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", left, botY)
  local br = piece(frame, METAL, bot, bot, 0.427734, 0.552734, 0.298828, 0.423828)
  br:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", right, botY)
  local t = piece(frame, METAL_H, 32, top, 0, 1, 0.00390625, 0.589844)
  t:SetPoint("TOPLEFT", tl, "TOPRIGHT"); t:SetPoint("TOPRIGHT", tr, "TOPLEFT")
  local b = piece(frame, METAL_H, 16, bot, 0, 0.5, 0.597656, 0.847656)
  b:SetPoint("TOPLEFT", bl, "TOPRIGHT"); b:SetPoint("TOPRIGHT", br, "TOPLEFT")
  local l = piece(frame, METAL_V, top, 16, 0.00195312, 0.294922, 0, 1)
  l:SetPoint("TOPLEFT", tl, "BOTTOMLEFT"); l:SetPoint("BOTTOMLEFT", bl, "TOPLEFT")
  local r = piece(frame, METAL_V, top, 16, 0.298828, 0.591797, 0, 1)
  r:SetPoint("TOPRIGHT", tr, "BOTTOMRIGHT"); r:SetPoint("BOTTOMRIGHT", br, "TOPRIGHT")
  local bg = frame:CreateTexture(nil, "BACKGROUND")
  bg:SetTexture(ROCK)
  bg:SetAlpha(0.8) -- retail tints this ground at 0.8 (FlatPanelBackgroundTemplate)
  bg:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, compact and -14 or -20)
  bg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 3)
  -- the title sits in the metal band, as on DragonUI's windows
  frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  frame.title:SetPoint("TOP", frame, "TOP", 0, compact and -1 or -4)
end

-- Retail's red X, on the stock close button.
function IRY.CloseButton(parent, onClick)
  local btn = CreateFrame("Button", nil, parent, "UIPanelCloseButton")
  btn:SetSize(24, 24)
  btn:ClearAllPoints()
  btn:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 1, 0)
  btn:GetNormalTexture():SetTexture(RED); btn:GetNormalTexture():SetTexCoord(0.152344, 0.292969, 0.0078125, 0.304688)
  btn:GetPushedTexture():SetTexture(RED); btn:GetPushedTexture():SetTexCoord(0.152344, 0.292969, 0.632812, 0.929688)
  btn:GetHighlightTexture():SetTexture(RED); btn:GetHighlightTexture():SetTexCoord(0.449219, 0.589844, 0.0078125, 0.304688)
  if btn:GetDisabledTexture() then btn:GetDisabledTexture():SetTexture(RED); btn:GetDisabledTexture():SetTexCoord(0.152344, 0.292969, 0.320312, 0.617188) end
  btn:SetScript("OnClick", onClick)
  return btn
end

-- Retail's red three-slice button with a label (DragonUI.SkinRedButton draws it).
function IRY.RedButton(parent, label, width, height)
  local btn = CreateFrame("Button", nil, parent)
  btn:SetSize(width or 80, height or 22)
  btn:SetNormalFontObject(GameFontNormal)
  btn:SetHighlightFontObject(GameFontHighlight)
  btn:SetDisabledFontObject(GameFontDisable)
  btn:SetText(label)
  if DragonUI and DragonUI.SkinRedButton then DragonUI.SkinRedButton(btn) end
  return btn
end

-- A text input with the stock InputBoxTemplate border (its middle stretches, unlike the popup's).
local inputs = 0
function IRY.Input(parent, width, maxLetters)
  inputs = inputs + 1
  local box = CreateFrame("EditBox", "IRememberYouInput" .. inputs, parent, "InputBoxTemplate")
  box:SetSize(width, 20)
  box:SetAutoFocus(false)
  box:SetMaxLetters(maxLetters or 100)
  box:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
  return box
end

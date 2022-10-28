function love.errhand(error_message)
    local app_name = gameName
    local version = gameVer
    local github_url = ghRepo
    local edition = love.system.getOS()

    local dialog_message = [[
  %s crashed with the following error:
  
  %s
  
  Would you like to report this crash? You can help us!]]
    local titles = {"Oh no :(", "Uh oh...", "Uh... Seems like the game crashed.", "The game crashed!", "Yep, it crashed."}
    local title = titles[love.math.random(#titles)]
    local full_error = debug.traceback(error_message or "")
    local message = string.format(dialog_message, app_name, full_error)
    local buttons = {"Yes (on GitHub)", "No thanks"}

    local pressedbutton = love.window.showMessageBox(title, message, buttons)

    local function url_encode(text)
      text = string.gsub(text, "\n", "%%0A")
      text = string.gsub(text, " ", "%%20")
      text = string.gsub(text, "#", "%%23")
      return text
    end

    local issuebody = [[
  %s crashed with the following error message:
  
  %s
  
  [If you can, describe what you've been doing when the error occurred]
  
  ---
  Affects: %s
  Edition: %s]]
  
    if pressedbutton == 1 then
      -- Surround traceback in ``` to get a Markdown code block
      full_error = table.concat({"```",full_error,"```"}, "\n")
      issuebody = string.format(issuebody, app_name, full_error, version, edition)
      issuebody = url_encode(issuebody)
  
      local subject = string.format("Crash in %s %s", app_name, version)
      local url = string.format("%s/issues/new?title=%s&body=%s",
                                github_url, subject, issuebody)
      love.system.openURL(url)
    elseif pressedbutton == 3 then -- I was about to do a "Report by email" option but, imagine using email LMAOOO
      issuebody = string.format(issuebody, app_name, full_error, version, edition)
      issuebody = url_encode(issuebody)
  
      local subject = string.format("Crash in %s %s", app_name, version)
      local url = string.format("mailto:%s?subject=%s&body=%s",
                                email, subject, issuebody)
      love.system.openURL(url)
    end
  end
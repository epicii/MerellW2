local locked0 = false
local locked1 = false
local locked2 = false
local locked3 = false
function onCreatePost()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		local nt = getPropertyFromGroup('unspawnNotes', i, 'noteType')
		local width = getPropertyFromGroup('unspawnNotes', i, 'width')
		local x = getPropertyFromGroup('unspawnNotes', i, 'x')
		if nt == 'EMP' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'EMP_Assets')
			setPropertyFromGroup('unspawnNotes', i, 'copyX', false)
			setPropertyFromGroup('unspawnNotes', i, 'x', x - width / 5)
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true)
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'EMP_Notesplashes')
		end
	end
	for i = 0, getProperty('playerStrums.length')-1 do
		makeLuaSprite('disabled'..i, 'Disabled', getPropertyFromGroup('playerStrums', i, 'x'), getPropertyFromGroup('playerStrums', i, 'y'))
		scaleObject('disabled'..i, getPropertyFromGroup('playerStrums', i, 'scale.x'), getPropertyFromGroup('playerStrums', i, 'scale.y'))
		setObjectCamera('disabled'..i, 'hud')
		addLuaSprite('disabled'..i, true)
		setProperty('disabled'..i..'.visible', false)
	end
end

function noteMiss(id, dir, NT, isSus)
    if NT == 'EMP' then
		_G['locked'..dir] = true
		setProperty('disabled'..dir..'.visible', true)
		runTimer('unlock'..dir, getRandomFloat(2, 4), 1)
		playSound('EMP', 0.6)
    end
end

function onUpdatePost(el)
	for i = 0, 3 do
		if _G['locked'..i] then
			noteCount = getProperty('notes.length')
			for b = 0, noteCount-1 do
				local dir = getPropertyFromGroup('notes', b, 'noteData')
				if _G['locked'..dir] then
					setPropertyFromGroup('notes', b, 'canBeHit', false)
				end
			end
		end
	end
end

function onTimerCompleted(t)
	for i = 0, 3 do
		if t == 'unlock'..i then
			_G['locked'..i] = false
			setProperty('disabled'..i..'.visible', false)
		end
	end
end
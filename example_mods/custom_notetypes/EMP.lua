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
end

function noteMiss(id, dir, NT, isSus)
    if NT == 'EMP' then
		_G['locked'..dir] = true
		runTimer('unlock'..dir, getRandomFloat(2, 4), 1)
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
		end
	end
end
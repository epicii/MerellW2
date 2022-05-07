function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'BF-Octane')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'merellGameOver')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'merellContinue')
end

local fixOffset = false
local fixedOffset = false
function onUpdatePost()
	del = getProperty('boyfriend.animation.curAnim.delay')
	--debugPrint(del * 56)
	if inGameOver then
		if getProperty('boyfriend.animation.curAnim.name') ~= 'deathConfirm' then
			if getProperty('boyfriend.animation.curAnim.curFrame') >= 4 and not fixOffset then
				doTweenY('bfoy', 'boyfriend.offset', getCharacterY('boyfriend') - 95, 0.3, 'linear')
				doTweenX('bfox', 'boyfriend.offset', getCharacterX('boyfriend') - 700, 0.3, 'linear')
				fixOffset = true
			end
			if fixedOffset then
				setProperty('boyfriend.offset.y', getCharacterY('boyfriend') - 95)
				setProperty('boyfriend.offset.x', getCharacterX('boyfriend') - 700)
			end
		else
			setProperty('boyfriend.offset.y', getCharacterY('boyfriend') - 15) -- + 80
			setProperty('boyfriend.offset.x', getCharacterX('boyfriend') - 620) -- minus 80
		end
	end
	if string.find(getProperty('boyfriend.animation.name'), 'miss') then
		setProperty('gf.visible', false)
	else
		setProperty('gf.visible', true)
	end
end

function onTweenCompleted(t)
	if t == 'bfoy' then
		fixedOffset = true
	end
end

--setProperty('boyfriend.offset.y', getCharacterY('boyfriend') + 95)
--setProperty('boyfriend.offset.x', getCharacterX('boyfriend') - 295)
local FILE_NAME = 'scores.txt'

t_ScoreData = {}
intSortOrder = false -- true Ascending, false Descending
local intScoreSize = 10

function string.explode(str, char)
		local t = {}
		local c = 0
		while true do
			local cn = str:find (char, c)
			table.insert (t, str:sub(c, (cn and (cn-1)) or #str))
			if (not cn) then
				break
			end

			c = cn + 1
		end

		return t
end


--[[
*********************************************
*********************************************

	Private
	
*********************************************
*********************************************
--]]

local function Scores_close ()
	local f = assert (io.open(FILE_NAME, 'w'), 'Couldnt create scores file')
	
	local strFile = ''
	
	-- Forbered det vi skal skrive ind i filen
	-- Konverter vores sorterede high score tabel til tekst
	-- \n (newline) separerer hver score, | separerer tilhørende værdier
	-- Vi bruger table.concat (concatenate) for at konkatenere (samle) værdierne til tekst
	
	for k,s in ipairs (t_ScoreData) do
		if (k > 1) then
			strFile = strFile .. '\n'
		end
		
		strFile = strFile .. table.concat(s, '|')
	end
	
	f:write (strFile)
	f:close ()
	
	return true
end

local function Scores_initialise ()
	local f = io.open (FILE_NAME, 'r')
	if (not f) then
		return true
	end
	
	-- Indlæs filens indhold
	local strFile = f:read ('*a')
	f:close ()
	
	-- Konverter vores text data til en tabel
	t_ScoreData = string.explode (strFile, '\n')
	for k,v in ipairs (t_ScoreData) do
		t_ScoreData[k] = string.explode (v, '|')
	end
	
	-- Sorter rækkerne i tabellen efter scoren ifølge intSortOrder
	-- loadstring kompilerer og indlæser kode (load -- string) og pakker det ind i en funktion
	-- Vi gør dette fordi vi skal ændre den operatør som sammenligner værdierne ifølge intSortOrder
	loadstring (string.format('table.sort(t_ScoreData, function(a, b) return tonumber(a[1]) %s tonumber(b[1]) end)', (intSortOrder and '<') or '>'))()
	
	return true
end

--[[

	Get amount of score entries
	
	SYNTAX
	int scores_getScoresAmount ()
	
--]]
local function Scores_getScoresAmount ()
	return #t_ScoreData
end

--[[

	Retrieve all scores
	
	SYNTAX
	table scores_getScores ()
	
--]]
local function Scores_getScores ()
	return t_ScoreData
end

--[[

	Retrieve a specific score
	
	SYNTAX
	table scores_getScore ()
	
--]]
local function Scores_getScore (intScoreID)
	return t_ScoreData[intScoreID]
end



--[[

	Insert a score at a given position
	
	SYNTAX
	bool scores_insertScore (intPos [, ... ])
	
--]]
local function Scores_insertScore (intPos, ...)
	table.insert (t_ScoreData, intPos, {...})
	if (Scores_getScoresAmount() > intScoreSize) then
		table.remove (t_ScoreData, Scores_getScoresAmount())
	end
	
	return true
end

--[[

	Remove a score from a given position
	
	SYNTAX
	bool scores_removeScore (intPos)
	
--]]
local function Scores_removeScore (intPos)
	table.remove (t_ScoreData, intPos)
end


--[[
*********************************************
*********************************************

	Public
	
*********************************************
*********************************************
--]]

scores = {}

function scores.initialise (intMaxCount, bOrder)
	intScoreSize = intMaxCount or 10
	intSortOrder = bOrder
	return Scores_initialise ()
end

function scores.close ()
	return Scores_close ()
end

function scores.get (intScoreID)
	return Scores_getScore (intScoreID)
end

function scores.getAll ()
	return Scores_getScores ()
end

function scores.insert (intPos, ...)
	return Scores_insertScore (intPos, ...)
end
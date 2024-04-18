-- Fuel Check API --------------------------------------------------------------------------------------------------------------------

-- Usage:
-- pastebin get XTZuS6iC <create-file-name>

-- Description:
-- API to check a turtle's fuel-level and refuel itself
-- This API contains one function: refuel()
-- The refuel function takes one parameter named fuelMargin.
-- The user can input a margin for fuel in units of moves (1 move = 1 block). This margin is compared against the current fuel level of the turtle.
-- If the fuel margin (number of moves) is less than the fuel level of the turtle, 
-- or no fuel margin is provided, the turtle will attempt to refuel itself
-- If the turtle finds combustible items in its inventory it will refuel with them, checking all inventory slots for combustible items.
-- After refueling, if the turtle's fuel level is still below the fuel margin (if provided), a message will be printed with fuel information


-- Function to return the turtle to where fuel exists (E.g. a chest) using a specified order of moves to return to the turtle 
-- @param fuelWanted (Optional) parameter for the turtle to only fuel itself as much as you want (if it has that much).
-- 			fuelWanted is notated in the number of moves the turtle can move 
-- 			Will use all fuel available in inventory if no argument is provided for fuelWanted
function fuelFromInventory(fuelWanted)
	fuelWanted = fuelWanted or 200000
	local currentFuelLevel = turtle.getFuelLevel()
	local fueledAmount = 0
	for i = 1,16 do
		turtle.select(i)
		if (turtle.refuel(0)) then
			for _ = 1,64 do
				if  (turtle.refuel(1) and turtle.getFuelLevel() >= (currentFuelLevel + fuelWanted)) then
					break
				end
			end
		end
	end
	fueledAmount = turtle.getFuelLevel() - currentFuelLevel
	print("Added " .. fueledAmount .. " fuel")
	return fueledAmount
end

-- Function to check whether current fuel levels are above or equal to a given threshold
-- @param fuelThreshold parameter to determine how much fuel must be required by the turtle to pass a true value.
-- @param verbose parameter to decide whether or not you want print statements each time you check fuel level
function checkFuel(fuelThreshold, verbose)
	verbose = verbose or skip
	local verboseOuts = {'Fuel Level below threshold \n Current Fuel: '..turtle.getFuelLevel()..'\n Fuel Threshold: '..fuelThreshold..'\n Fuel Needed: '.. fuelThreshold - turtle.getFuelLevel()..'',"Turtle is adequately fueled" }
	if (turtle.getFuelLevel() < fuelThreshold) then
		if (verbose) then print(verboseOuts[0]) end
		return false
	else
		if (verbose) then print(verboseOuts[1]) end
		return true
	end
end

--  UNFINISHED METHOD
-- function fuelFromChest()
-- 	local chest = peripheral.find("minecraft:chest")
-- 	for i = 1,16 do
		
-- 		if (chest.getItemDetail(i).name:match("coal")) then
-- 			chest.pullItems(chest, i)
-- 			turtle.refuel(1)
-- 			print("found ender chest")
-- 		end
-- 	end
-- end

-- DEPRECATED METHOD
-- Checks if the turtle has enough fuel left equal to some threshold set by the user.
-- Returns true/false if the turtle has enough fuel left
-- function checkFuel(fuelMargin)
-- 	local isFueled = true
-- 	if (fuelMargin and turtle.getFuelLevel() < fuelMargin or fuelMargin == nil) then
-- 		isFueled = false
-- 		for i = 1, 16 do
-- 			turtle.select(i)
-- 			local is_fuel = turtle.refuel(0)
-- 			if is_fuel then 
-- 				turtle.refuel(64)
-- 			end
-- 		end
-- 		local fuelLevel = turtle.getFuelLevel()
-- 		if (fuelMargin and fuelLevel < fuelMargin ) then
-- 			print("Fuel is still too low\nFuel Margin: " .. fuelMargin .. "\nFuel Level: " .. fuelLevel .. "\nFuel Needed: " .. fuelMargin-fuelLevel)
-- 			return isFueled
-- 		end
-- 	end
-- end

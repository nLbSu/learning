--tips:
	--1.continue函数用于继承上一状态



	
	local testPos  = {
		CGeoPoint:new_local(0,1200),
		CGeoPoint:new_local(-4500,1000),
		CGeoPoint:new_local(-1000,-1000),
		CGeoPoint:new_local(1000,-1000)
	}
	local AttckPos = {
		CGeoPoint:new_local(2 * param.pitchLength/9,0),
		CGeoPoint:new_local(0.42 * param.pitchLength,0.25 * param.pitchWidth),
		CGeoPoint:new_local(0.42 * param.pitchLength,-0.25 * param.pitchWidth),
	}
	
	
	MAINJUDGE = function()	--持球车 
		--计算与绘制
	
		hzlAttackFunc.noCollidePath()
		hzlAttackFunc.getGridPos(3)
		hzlAttackFunc.GridCenter(x,y)
		hzlAttackFunc.decideThirdPos()
		hzlAttackFunc.findHolder()
		hzlAttackFunc.findThief()
	
		-- local state = hzlAttackFunc.stateJudge()
		-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1800), state ,4,0,64,50 )
		-- if state == 1 then				--禁区进攻
		-- 	if player.kickBall("Leader") then	--判断是否需要截球
		-- 		return "catchBall_forA"
		-- 	elseif hzlAttackFunc.ifCanShoot(param_hzl.GoalPos_down) or hzlAttackFunc.ifCanShoot(param_hzl.GoalPos_up) then --判断是否能射门
		-- 		-- AttackTask_hzl.cntForCatchball = 0		
		-- 		return "shoot_forA"
		-- 	elseif player.valid("Assister") and hzlAttackFunc.ifCanPassBall("Assister",player.pos("Assister")) then		--判断能否传给Assister
		-- 		-- AttackTask_hzl.cntForCatchball = 0		
		-- 		return "passTA_forA"
		-- 	elseif player.valid("Breaker") and hzlAttackFunc.ifCanPassBall("Breaker",player.pos("Breaker")) then		--判断能否传给Breaker
		-- 		-- AttackTask_hzl.cntForCatchball = 0		
		-- 		return "passTB_forA"
		-- 	-- elseif  not player.infraredOn("Leader") or player.toBallDist("Leader") < 200  and ball.velMod() < 300   then	--判断是否丢球，需要重新拿起
		-- 		-- AttackTask_hzl.cntForCatchball = 0		
		-- 		-- return "getBall_forA"
		-- 	else															--否则盘带寻找机会
		-- 		-- AttackTask_hzl.cntForCatchball = 0		
		-- 		return "dribbling_forA"												
		-- 	end
		-- elseif state == 2 then			--预进攻
		-- 	local x,y = hzlAttackFunc.getGridPos(3)
		-- 	local PTAssister = hzlAttackFunc.GridCenter(x,y)
		-- 	local PTBreaker = hzlAttackFunc.decideThirdPos()			--注意禁区不能用
			
			
	
		-- 	if player.kickBall("Leader") then	--判断是否需要截球
		-- 		return "catchBall"
		-- 	-- elseif bufcnt(ifCanShoot(param_hzl.GoalPos_down) or ifCanShoot(param_hzl.GoalPos_up),2) then --判断是否能射门
		-- 		-- return "shoot"
		-- 	elseif player.valid("Assister") and hzlAttackFunc.ifCanPassBall("Assister",PTAssister)then		--判断能否传给Assister
		-- 		-- AttackTask_hzl.cntForCatchball = 0		
		-- 		return "passTA"
		-- 	elseif player.valid("Breaker") and hzlAttackFunc.ifCanPassBall("Breaker",PTBreaker) then		--判断能否传给Breaker
		-- 		-- AttackTask_hzl.cntForCatchball = 0		
		-- 		return "passTB"
		-- 	-- elseif  bufcnt( not player.infraredOn("Leader") or player.toBallDist("Leader") < 200  and ball.velMod() < 300,1) then	--判断是否丢球，需要重新拿起
		-- 			-- AttackTask_hzl.cntForCatchball = 0		
		-- 			-- return "getBall"
		-- 	else															--否则盘带寻找机会
		-- 		AttackTask_hzl.cntForCatchball = 0		
		-- 		return "dribbling"												
		-- 	end
		-- else													--防守	
		-- 	return "defense"
		-- end
	end
	
	
	
	choice = 2
	gPlayTable.CreatePlay{
	
	firstState = "skip",
	-- firstState = "test",
	
	---------------------
	
	--[[
	
	1. 测试射门
	
	2. 测试进攻路径规划与策略
	
	]]--
	----------------------
	
	
	
	
	--------------------test----------------
	
	-- ["test"] = {
	-- 	switch = function()
	-- 	end,
	-- 	-- Kicker = task.speed( _,_,1),
	-- 	Breaker = AttackTask_hzl.stop(),
	-- 	Leader = AttackTask_hzl.stop(),
	-- 	Assister = AttackTask_hzl.stop(),
	-- 	match = "[BLA]"
	-- },
	
	-- ----------------------------------------
	-- --第一状态用于初始化
	["skip"] = {
		switch = function()
			-- hzlAttackFunc.noCollidePath()
			-- local x,y = hzlAttackFunc.getGridPos(3)
			-- local p2 = hzlAttackFunc.GridCenter(x,y)
			-- local p3 = hzlAttackFunc.decideThirdPos()
			-- local state = hzlAttackFunc.stateJudge()
			if bufcnt(true,1) then
				if choice == 1 then
					return "shootGoal_1"	
				elseif choice == 2 then
					return "turnTosart"
				end
			end
		end,
		Leader = AttackTask_hzl.stop(),
		Breaker = AttackTask_hzl.stop(),	
		Assister = AttackTask_hzl.stop(),
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "[LBA]"
	},
	
	-- --------------------------------------------
	-- ["shootGoal_1"] = {
	-- 	switch = function()
	-- 		if bufcnt(player.toTargetDist("Kicker") < 30 ,2) then
	-- 			return "shootGoal_2"
	-- 		end
	-- 		-- return "skip"
	-- 	end,
	-- 	Kicker = AttackTask_hzl.runPosForShoot("Kicker"),
	-- 	-- Kicker = AttackTask_hzl.testskill(),
	-- 	match = "[K]"
	-- },
	-- ["shootGoal_2"] = {
	-- 	switch = function()
	-- 		if player.kickBall("Kicker") then
	-- 			return "shootGoal_1"
	-- 		end
	-- 	end,
	-- 	Kicker = AttackTask_hzl.shoot_1("Kicker"),
	-- 	match = "[K]"
	-- },
	
	
	----------------------------------------------
	["turnTosart"] = {
		switch = function()
			MAINJUDGE()
			local state = hzlAttackFunc.stateJudge()
			-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1500), str ,4,0,64,50 )
			if state == 1 or state == 2 then
				return "dribbling"
			else
				return "defense"
			end
		end,
	
		Breaker = AttackTask_hzl.stop(),
		Leader = AttackTask_hzl.stop(),
		Assister = AttackTask_hzl.stop(),
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "(L)(A)(B)"
	},
	
	
	["shoot"] = {
		switch = function()
			MAINJUDGE()
			local state = hzlAttackFunc.stateJudge()
			-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1500), str ,4,0,64,50 )
			if state == 1 or state == 2 then
				if bufcnt(not player.infraredOn("Leader"),4) then
					AttackTask_hzl.cntForShoot = 0
					return "getBall"
				end		
			else
				AttackTask_hzl.cntForShoot = 0
				return "defense"
			end
	
		end,
		Leader = AttackTask_hzl.shoot_1("Leader"),
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "(L)(A)(B)"
	},
	
	
	
	["getBall"] = {
		switch = function()
			MAINJUDGE()
			local state = hzlAttackFunc.stateJudge()
			-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1500), str ,4,0,64,50 )
			if wczDefFunction.isInPA() and (bufcnt(ball.velMod() < 600 and math.abs(ball.velDir()) < math.pi/2 ,3)) then
				return "defense_goalie2_grab"   -- TODO,条件是否合适?
			elseif state == 1 or state == 2 then
				if bufcnt(player.infraredOn("Leader") ,4) then
					return "dribbling"
				end
			else
				return "defense"
			end
		end,
		Leader = AttackTask_hzl.getBallSilence("Leader"),
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "(L)(A)(B)"
	},
	["AcatchBall"] = {
		switch = function()
			MAINJUDGE()
			local state = hzlAttackFunc.stateJudge()
			-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1500), str ,4,0,64,50 )
			if state == 1 or state == 2 then
				local x,y = hzlAttackFunc.getGridPos(3)
				local PTAssister = hzlAttackFunc.GridCenter(x,y)
				local PTBreaker = hzlAttackFunc.decideThirdPos()			--注意禁区不能用
				if bufcnt(player.infraredOn("Assister") ,3) then
					AttackTask_hzl.cntForCatchball = 0
					return "dribbling"
				elseif bufcnt( player.toBallDist("Assister") < 200 , 2) then
					AttackTask_hzl.cntForCatchball = 0
					return "getBall"
				elseif bufcnt( ball.velMod() < 300 and not player.infraredOn("Assister"),4)  then
					AttackTask_hzl.cntForCatchball = 0
					return "getBall"
				end
			else
				AttackTask_hzl.cntForCatchball = 0
				return "defense"
			end
		end,
		Assister = AttackTask_hzl.catchBall("Assister"),
		Leader = AttackTask_hzl.waitForballOrMask("Leader"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "{LAB}"
	},
	["BcatchBall"] = {
		switch = function()	
			MAINJUDGE()
			local state = hzlAttackFunc.stateJudge()
			-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1500), str ,4,0,64,50 )
			if state == 1 or state == 2 then
				local x,y = hzlAttackFunc.getGridPos(3)
				local PTAssister = hzlAttackFunc.GridCenter(x,y)
				local PTBreaker = hzlAttackFunc.decideThirdPos()			--注意禁区不能用
				if bufcnt(player.infraredOn("Breaker") ,3) then
					AttackTask_hzl.cntForCatchball = 0
					return "dribbling"
				elseif bufcnt( player.toBallDist("Breaker") < 200 , 2) then
					AttackTask_hzl.cntForCatchball = 0
					return "getBall"
				elseif bufcnt( ball.velMod() < 300 and not player.infraredOn("Breaker"),4)  then
					AttackTask_hzl.cntForCatchball = 0
					return "getBall"
				end
			else
				AttackTask_hzl.cntForCatchball = 0
				return "defense"
			end
		end,
		Breaker = AttackTask_hzl.catchBall("Breaker"),
		Leader = AttackTask_hzl.waitForballOrMask("Leader"),
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "{LAB}"
	},
	["passTA"] = {
		switch = function()
			 MAINJUDGE()
			local state = hzlAttackFunc.stateJudge()
			-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1500), str ,4,0,64,50 )
			if state == 1 or state == 2 then
				local x,y = hzlAttackFunc.getGridPos(3)
				local PTAssister = hzlAttackFunc.GridCenter(x,y)
				local PTBreaker = hzlAttackFunc.decideThirdPos()			--注意禁区不能用
				if state == 1 then
					if player.pos("Leader"):dist(AttckPos[3]) < 1000 then
						PTAssister = AttckPos[1]
						PTBreaker =  AttckPos[2]
					elseif player.pos("Leader"):dist(AttckPos[2]) < 1000   then
						PTAssister = AttckPos[1]
						PTBreaker =  AttckPos[3]
					else
						PTAssister = AttckPos[2]
						PTBreaker =  AttckPos[3]
					end
				end
				if bufcnt(player.kickBall("Leader"), 2) then
					AttackTask_hzl.cntForWave = 0
					return "AcatchBall"
				elseif bufcnt(not player.infraredOn("Leader"),4) then
					AttackTask_hzl.cntForWave = 0
					return "getBall"
				-- elseif bufcnt(not ( PTAssister and  player.canFlatPassToPos("Assister",PTAssister) and hzlAttackFunc.ifRunGrid("Assister",PTAssister)) ,20) then
				-- 	return "dribbling"
				end		
			else
				return "defense"
			end
		end,
		-- Leader = AttackTask_hzl.waveTail("Leader","Assister",1),
	
		Leader = AttackTask_hzl.beautiCircle("Leader","Assister"),
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "{LAB}"
	},
	["passTB"] = {
		switch = function()
			 MAINJUDGE()
			local state = hzlAttackFunc.stateJudge()
			-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1500), str ,4,0,64,50 )
			if state == 1 or state == 2 then
				local x,y = hzlAttackFunc.getGridPos(3)
				local PTAssister = hzlAttackFunc.GridCenter(x,y)
				local PTBreaker = hzlAttackFunc.decideThirdPos()			--注意禁区不能用
				if state == 1 then
					if player.pos("Leader"):dist(AttckPos[3]) < 1000 then
						PTAssister = AttckPos[1]
						PTBreaker =  AttckPos[2]
					elseif player.pos("Leader"):dist(AttckPos[2]) < 1000   then
						PTAssister = AttckPos[1]
						PTBreaker =  AttckPos[3]
					else
						PTAssister = AttckPos[2]
						PTBreaker =  AttckPos[3]
					end
				end
				if bufcnt(player.kickBall("Leader"), 2) then
					AttackTask_hzl.cntForWave = 0
					return "BcatchBall"
				elseif bufcnt(not player.infraredOn("Leader"),4) then
					AttackTask_hzl.cntForWave = 0
					return "getBall"
				-- elseif bufcnt(not ( PTAssister and  player.canFlatPassToPos("Assister",PTAssister) and hzlAttackFunc.ifRunGrid("Assister",PTAssister)) ,20) then
				-- 	return "dribbling"
				end		
			else
				return "defense"
			end
		end,
		-- Leader = AttackTask_hzl.waveTail("Leader","Breaker",1),
	
		Leader = AttackTask_hzl.beautiCircle("Leader","Breaker"),
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "{LAB}"
	},
	["dribbling"] = {
		switch = function()
			MAINJUDGE()
			local state = hzlAttackFunc.stateJudge()
			-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1500), str ,4,0,64,50 )
	
			if state == 1 or state == 2 then
				local x,y = hzlAttackFunc.getGridPos(3)
				local PTAssister = hzlAttackFunc.GridCenter(x,y)
				local PTBreaker = hzlAttackFunc.decideThirdPos()			--注意禁区不能用
				if state == 1 then
					if player.pos("Leader"):dist(AttckPos[3]) < 1000 then
						PTAssister = AttckPos[1]
						PTBreaker =  AttckPos[2]
					elseif player.pos("Leader"):dist(AttckPos[2]) < 1000   then
						PTAssister = AttckPos[1]
						PTBreaker =  AttckPos[3]
					else
						PTAssister = AttckPos[2]
						PTBreaker =  AttckPos[3]
					end
				end
				if bufcnt(hzlAttackFunc.canDirectShoot("Leader",2000,50) and player.posX("Leader")>2000 ,2) then --判断是否能射门
					yyt.cntForMove = 0
					yyt.flag1 = 0
					return "shoot"
				elseif bufcnt( ball.posX() > 3500 and (hzlAttackFunc.ifCanShoot(param_hzl.GoalPos_down) or hzlAttackFunc.ifCanShoot(param_hzl.GoalPos_up)) ,2) then
					yyt.cntForMove = 0
					yyt.flag1 = 0
	
					return "shoot"
				elseif bufcnt(not player.infraredOn("Leader"),4) then	--判断是否需要截球
					yyt.cntForMove = 0
					yyt.flag1 = 0
	
					return "getBall"
				elseif bufcnt(player.kickBall("Leader"),2) then	--判断是否需要截球
					yyt.cntForMove = 0
					yyt.flag1 = 0
	
					return "catchBall"
				elseif  bufcnt( PTAssister and   ( player.canChipPassTo("Assister","Leader")  or player.canFlatPassToPos("Assister",PTAssister)  ) and hzlAttackFunc.ifRunGrid("Assister",PTAssister),3) then		--判断能否传给Assister
					yyt.cntForMove = 0
					yyt.flag1 = 0
	
					return "passTA"
				elseif  bufcnt( PTBreaker and ( player.canFlatPassToPos("Breaker",PTBreaker) or player.canChipPassTo("Breaker","Leader")) and hzlAttackFunc.ifRunGrid("Breaker",PTBreaker),3) then		--判断能否传给Breaker
					yyt.cntForMove = 0
					yyt.flag1 = 0
	
					return "passTB"
				
				end
			else
				return "defense"
			end
		end,
		-- Leader = yyt.carryBall_pass("Leader"),
		Leader = AttackTask_hzl.beautiCircle("Leader"),
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "(L)(A)(B)"
	},
	["defense"] = {
		switch = function()
			MAINJUDGE()
			-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1500), str ,4,0,64,50 )
			if wczDefFunction.isInPA() and ((ball.velMod() < 400 and math.abs(ball.velDir()) < math.pi / 2 ) or ball.velMod() < 10) and player.pos("Goalie"):dist(ball.pos()) > 120 then
				return "defense_goalie2_grab"   -- TODO,条件是否合适?
			elseif bufcnt(player.infraredOn("Leader") , 5 ) then
				return "defense_1"
				-- elseif bufcnt(hzlAttackFunc.isBallCatch("Assister"),5) then
				-- 	return "AcatchBall_def"
				-- elseif bufcnt(hzlAttackFunc.isBallCatch("Breaker"),5) then
				-- 	return "BcatchBall_def"
			end
		end,
		Leader =  AttackTask_hzl.preGrabBall("Leader"),
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "(L)(A)(B)"
	},
	["defense_goalie2_grab"]={
		switch= function ()
			if not wczDefFunction.isInPA() then
				return "defense"
			elseif bufcnt(player.infraredOn("Goalie") , 5 ) then
				return "defense_goalie2_back"
			end
		end,
		Leader =  AttackTask_hzl.preGrabBall("Leader"),
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Goalie = AttackTask_hzl.goalie2("Goalie"),   -- 吸住球 然后旋转
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "(L)(A)(B)"
	},

	["defense_goalie2_back"] = {
		switch = function ()
			if not wczDefFunction.isInPA() then
				return "defense"
			elseif bufcnt(true,40) then
				return "defense_goalie2_whirl"
			end
		end,
		Leader =  AttackTask_hzl.preGrabBall("Leader"),
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Goalie = AttackTask_hzl.goalie2_back("Goalie"),   -- 吸住球 然后旋转
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "(L)(A)(B)"
	},

	["defense_goalie2_whirl"]={
		switch = function ()
			if not wczDefFunction.isInPA() then
				return "defense"
			elseif wczDefFunction.isSuitableDir("Goalie") or bufcnt(true,240) then
				return "defense"
			end
		end,
		Leader =  AttackTask_hzl.preGrabBall("Leader"),
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Goalie = AttackTask_hzl.goalie2_whirl("Goalie"),   -- 吸住球 然后旋转
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "(L)(A)(B)"
	},

	["defense_1"] = {
		switch = function()
			MAINJUDGE()
			-- debugEngine:gui_debug_msg(CGeoPoint:new_local(4650,-1500), str ,4,0,64,50 )
			
			if  bufcnt(not player.infraredOn("Leader"),4) then
				return "defense"
			elseif bufcnt (hzlAttackFunc.ifGrabBall("Leader") ,2) then
				return "dribbling"	
			-- elseif bufcnt(hzlAttackFunc.isBallCatch("Assister"),5) then
			-- 	return "AcatchBall_def"
			-- elseif bufcnt(hzlAttackFunc.isBallCatch("Breaker"),5) then
			-- 	return "BcatchBall_def"
			end
		end,
		Assister = AttackTask_hzl.waitForballOrMask("Assister"),
		Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
		Leader =  AttackTask_hzl.beautiCircle("Leader"),
	
		Goalie = wczDefTask.goalie("Goalie"),
		Kicker = AttackTask_hzl.TwoBackDef(1,"Kicker"),
		Tier = AttackTask_hzl.TwoBackDef(2,"Tier"),
		match = "(L)(A)(B)"
	},
	
	
	--防守状态下很难做到及时截球，所以这里先不做处理
	-- ["AcatchBall_def"] = {
	-- 	switch = function()
	-- 		MAINJUDGE()
	-- 		local state = hzlAttackFunc.stateJudge()
	-- 			if bufcnt(player.infraredOn("Assister") ,3) then
	-- 				AttackTask_hzl.cntForCatchball = 0
	-- 				return "dribbling"
	-- 			elseif bufcnt( player.toBallDist("Assister") < 200 , 2) then
	-- 				AttackTask_hzl.cntForCatchball = 0
	-- 				return "getBall"
	-- 			elseif bufcnt( ball.velMod() < 300 and not player.infraredOn("Assister"),4)  then
	-- 				AttackTask_hzl.cntForCatchball = 0
	-- 				return "getBall"
	-- 		end
	-- 	end,
	-- 	Assister = AttackTask_hzl.catchBall("Assister"),
	-- 	Leader = AttackTask_hzl.waitForballOrMask("Leader"),
	-- 	Breaker = AttackTask_hzl.waitForballOrMask("Breaker"),
	-- 	Goalie = wczDefTask.goalie("Goalie"),
	-- 	match = "{LAB}"
	-- },
	
	-- ["BcatchBall_def"] = {
	-- 	switch = function()
	-- 		MAINJUDGE()
	-- 		local state = hzlAttackFunc.stateJudge()
	-- 		if bufcnt(player.infraredOn("Breaker") ,3) then
	-- 			AttackTask_hzl.cntForCatchball = 0
	-- 			return "dribbling"
	-- 		elseif bufcnt( player.toBallDist("Breaker") < 200 , 2) then
	-- 			AttackTask_hzl.cntForCatchball = 0
	-- 			return "getBall"
	-- 		elseif bufcnt( ball.velMod() < 300 and not player.infraredOn("Breaker"),4)  then
	-- 			AttackTask_hzl.cntForCatchball = 0
	-- 			return "getBall"
	-- 		end
			
	-- 	end,
	-- 	Breaker = AttackTask_hzl.catchBall("Breaker"),
	-- 	Leader = AttackTask_hzl.waitForballOrMask("Leader"),
	-- 	Assister = AttackTask_hzl.waitForballOrMask("Assister"),
	-- 	Goalie = wczDefTask.goalie("Goalie"),
	-- 	match = "{LAB}"
	-- },
	

name = "NormalPlayV1",
applicable ={
        exp = "a",
        a = true
},
attribute = "attack",
timeout = 99999
}

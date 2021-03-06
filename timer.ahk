Timer(Timer_Name := "", Timer_Opt := "D")
{
	static
	global Timer, Timer_Count
	if !Timer
		Timer := {}
	if (Timer_Opt = "U" or Timer_Opt = "Unset")
		if IsObject(Timer[Timer_Name])
		{
			Timer.Remove(Timer_Name)
			Timer_Count --=
			return true
		}
		else
			return false
	if RegExMatch(Timer_Opt,"(\d+)",Timer_Match)
	{
		if !(Timer[Timer_Name,"Start"])
			Timer_Count += 1
		Timer[Timer_Name,"Start"] := A_TickCount
		Timer[Timer_Name,"Finish"] := A_TickCount + Timer_Match1
		Timer[Timer_Name,"Period"] := Timer_Match1
	}
	if RegExMatch(Timer_Opt,"(\D+)",Timer_Match)
		Timer_Opt := Timer_Match1
	else
		Timer_Opt := "D"
	if (Timer_Name = "")
	{
		for index, element in Timer
			Timer(index)
		return
	}
	if (Timer_Opt = "R" or Timer_Opt = "Reset")
	{
		Timer[Timer_Name,"Start"] := A_TickCount
		Timer[Timer_Name,"Finish"] := A_TickCount + Timer[Timer_Name,"Period"]
	}
	Timer[Timer_Name,"Now"] := A_TickCount
	Timer[Timer_Name,"Left"] := Timer[Timer_Name,"Finish"] - Timer[Timer_Name,"Now"]
	Timer[Timer_Name,"Elapse"] := Timer[Timer_Name,"Now"] - Timer[Timer_Name,"Start"]
	Timer[Timer_Name,"Done"] := true
	if (Timer[Timer_Name,"Left"] > 0)
		Timer[Timer_Name,"Done"] := false
	if (Timer_Opt = "D" or Timer_Opt = "Done")
		return Timer[Timer_Name,"Done"]
	if (Timer_Opt = "S" or Timer_Opt = "Start")
		return Timer[Timer_Name,"Start"]
	if (Timer_Opt = "F" or Timer_Opt = "Finish")
		return Timer[Timer_Name,"Finish"]
	if (Timer_Opt = "L" or Timer_Opt = "Left")
		return Timer[Timer_Name,"Left"]
	if (Timer_Opt = "N" or Timer_Opt = "Now")
		return Timer[Timer_Name,"Now"]
	if (Timer_Opt = "P" or Timer_Opt = "Period")
		return Timer[Timer_Name,"Period"]
	if (Timer_Opt = "E" or Timer_Opt = "Elapse")
		return Timer[Timer_Name,"Elapse"]
}

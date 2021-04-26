ToggleDest = %A_AppData%\ahkReplayBackup\



IfExist, %ToggleDest%timerToggle
	{
		BackupRainbowReplay()
		FileRead, TimerTimeMillisecs, %ToggleDest%timerToggle
		MsgBox , %TimerTimeMillisecs%
		sleep %TimerTimeMillisecs%
		reload
	}
IfExist, %ToggleDest%noTimer
	{
		BackupRainbowReplay()
	}
else
	{
		MsgBox,4,,Do you want to create a timer?
			IfMsgBox Yes
				{
					InputBox, TimerTime, Input time between backups(Minutes).
						if TimerTime =
							return
					FileCreateDir, %ToggleDest%
					TimerTimeMillisecs := TimerTime*60000
					fileAppend,%TimerTimeMillisecs%, %ToggleDest%timerToggle
					BackupRainbowReplay()
					sleep %TimerTimeMillisecs%
					reload
				}
			IfMsgBox No
				{
					FileCreateDir, %ToggleDest%
					fileAppend,, %ToggleDest%noTimer
					BackupRainbowReplay()
				}
	}
	


return



BackupRainbowReplay()
	{
	locationExmpl = C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\games\Tom Clancy's Rainbow Six Siege\MatchReplay
	destinationExmpl = D:\Dokumente\My Games\Rainbow Six - Siege\
	ToggleDest = %A_AppData%\ahkReplayBackup\
	IfExist, %ToggleDest%\nonverbose
		Verbose = 0
	else Verbose = 1
	IfExist, %ToggleDest%\RainbowReplayToggle
		{
		FileRead, GameReplayDir, %ToggleDest%RainbowReplayToggleDir\GameReplayDir
		FileRead, BackupReplayDir, %ToggleDest%\RainbowReplayToggleDir\BackupReplayDir
		FileCopyDir, %GameReplayDir% , %BackupReplayDir%, 1
		if ErrorLevel
			MsgBox Error
		if (Verbose = 1){
			MsgBox, 4,, Everything is backed up!`nIf you want to choose new Dirs just delete %ToggleDest%.`nDo you want to see this message every time?
			IfMsgBox No
				FileAppend, , %ToggleDest%\nonverbose
		}
		return
		}

	else 
		{
		FileSelectFolder, GameReplayDir, *%locationExmpl% , 3, Select the location of the Replay-Files	
		if GameReplayDir = 
			return
		FileSelectFolder, BackupReplayDir, *%destinationExmpl% , 3, Select the destination
		if 	BackupReplayDir =
			return
	
		FileCopyDir, %GameReplayDir% , %BackupReplayDir%, 1

		if ErrorLevel
			MsgBox Error
		else
		
			FileRemoveDir, %ToggleDest%\RainbowReplayToggleDir\, 1
			FileCreateDir, %ToggleDest%\RainbowReplayToggleDir\
			FileAppend, , %ToggleDest%\RainbowReplayToggle
			FileAppend, %GameReplayDir%, %ToggleDest%\RainbowReplayToggleDir\GameReplayDir
			FileAppend, %BackupReplayDir%, %ToggleDest%\RainbowReplayToggleDir\BackupReplayDir
			if (Verbose = 1){
				MsgBox, 4,, Everything is backed up!`nIf you want to choose new Dirs just delete %ToggleDest%.`nDo you want to see this message every time?
				IfMsgBox No
					FileAppend, , %ToggleDest%\nonverbose
			}
			return
		}
	return
	}
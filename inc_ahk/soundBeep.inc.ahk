;<<<<<<<< SoundbeepGameOver <<<< 170814130442 <<<< 14.08.2017 13:04:42 <<<<
SoundbeepGameOver(){
pitch := 750
while(--pitch > 350 ){
	pitch -= 40
	ToolTip, % pitch
	SoundBeep, % pitch, 150 ; Play a higher pitch for half a second.
}
	SoundBeep, % pitch + 180, 550 ; Play a higher pitch for half a second.
}
;>>>>>>>> SoundbeepGameOver >>>> 170814130447 >>>> 14.08.2017 13:04:47 >>>>

;<<<<<<<< SoundbeepMissionImpossibleTheme <<<< 170814103348 <<<< 14.08.2017 10:33:48 <<<<
SoundbeepMissionImpossibleTheme(){
    global g_doSoundBeepACK
    if(!g_doSoundBeepACK)

AHKcode =
(
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 587, 75
Soundbeep, 587, 75
Soundbeep, 622, 75
Soundbeep, 659, 75
Soundbeep, 699, 75
Soundbeep, 740, 75
Soundbeep, 784, 75
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 932, 150
sleep, 150
Soundbeep, 523, 150
sleep, 150
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 699, 150
sleep, 150
Soundbeep, 740, 150
sleep, 150
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 932, 150
sleep, 150
Soundbeep, 523, 150
sleep, 150
Soundbeep, 784, 150
sleep, 300
Soundbeep, 784, 150
sleep, 300
Soundbeep, 699, 150
sleep, 150
Soundbeep, 740, 150
sleep, 150
Soundbeep, 932, 150
Soundbeep, 784, 150
Soundbeep, 587, 1200
sleep, 75
Soundbeep, 932, 150
Soundbeep, 784, 150
Soundbeep, 554, 1200
sleep, 75
Soundbeep, 932, 150
Soundbeep, 784, 150
Soundbeep, 523, 1200
sleep, 150
Soundbeep, 466, 150
Soundbeep, 523, 150
)
DynaRun(AHKcode)
return
}
;>>>>>>>> SOUNDBEEPMissionImpossibleTheme >>>> 170814103354 >>>> 14.08.2017 10:33:54 >>>>




;<<<<<<<< SoundbeepNoACK <<<< 170814140127 <<<< 14.08.2017 14:01:27 <<<<
SoundbeepNoACK(){
    global g_doSoundBeepACK
    if(!g_doSoundBeepACK)
        return
    SoundbeepGameOver()
}
;>>>>>>>> SoundbeepNoACK >>>> 170814140131 >>>> 14.08.2017 14:01:31 >>>>

;<<<<<<<< SoundbeepACK <<<< 170814140035 <<<< 14.08.2017 14:00:35 <<<<
SoundbeepACK(){
    global g_doSoundBeepACK
    if(!g_doSoundBeepACK)
        return
    ; SoundbeepMissionImpossibleTheme()
    SoundBeep,500,5000 ; high, timemilli 14.08.2017 09:43
}
;>>>>>>>> SoundbeepACK >>>> 170814140038 >>>> 14.08.2017 14:00:38 >>>>

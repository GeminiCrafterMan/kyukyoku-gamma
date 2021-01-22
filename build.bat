@echo off
asm68k /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /p /o ae- sonic1.asm, Kyukyoku.bin, s1built.sym, sonic1.lst
convsym sonic1.lst Kyukyoku.bin -input asm68k_lst -inopt "/localSign=@ /localJoin=. /ignoreMacroDefs+ /ignoreMacroExp- /addMacrosAsOpcodes+" -a
fixheadr.exe Kyukyoku.bin
pause
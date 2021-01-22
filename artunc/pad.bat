fsutil file createnew padding.bin 16384
ren sonic.bin sonic_old.bin
copy /b sonic_old.bin+padding.bin sonic.bin
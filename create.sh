#! /bin/sh
device=$1
echo "$device Splash Image Maker"
echo "-----------------------------"
width=1080
height=2160
echo "creating logo.img..."
payloadLimit1=100864
python2 bin/logo_gen.py pics/logo.png $payload_limit1
mv output.img pic1.img
echo "creating fastboot.img..."
payloadLimit2=613888
python2 bin/logo_gen.py pics/fastboot.png $payload_limit2
mv output.img pic2.img
payloadLimit3=101888
python2 bin/logo_gen.py pics/logo.png $payload_limit3
mv output.img pic3.img
echo "creating corrupt.img..."
payloadLimit4=0
python2 bin/logo_gen.py pics/logo.png $payload_limit4
mv output.img pic4.img
echo "compressing images into one..."
cat bin/header_"$device".img pic*.img   > splash.img
rm pic*.img
if [ -e output/flashable/splash.img ]; then
    echo "removing old splash image..."
    rm output/flashable/splash.img
fi
mv splash.img output/flashable
cd output/flashable
echo "creating flashable zip..."
if [ -e $device"_Splash.zip" ]; then
    echo "removing old flashable zip..."
    rm $device"_Splash.zip"
fi
zip -r "$device"_Splash.zip META-INF/* splash.img
cd -
echo "flashable zip created as output/"$device"_flashable.zip"
#!/usr/bin/env bash


# get ROM download URI as arg
if [ $# -lt 1 ]; then
    echo "Usage: ./update_hos.sh <ROM download URI>" 
    exit 1
fi

ROM_DIR="/mnt/ext/ROMs/hos"

ROM_URI=$1
ROM_FILE=$(echo $ROM_URI | rev | cut -d "/" -f 1 | rev)

echo "Starting update. Downloading ROM..."

cd $ROM_DIR
wget -nc $ROM_URI -O $ROM_FILE

echo "Download finished. Rebooting to recovery..."

adb reboot recovery

sideload=0
while [ $sideload -ne 1 ]; do
    read -p "Enter ADB Sideload. Done? [y/N]: " choice
    case $choice in
        [Yy]* ) sideload=1
    esac
done

adb sideload $ROM_FILE

echo "Sideload finished. Manually reboot to system from recovery. Extracting payload..."

rm -rf output extracted
unzip -o $ROM_FILE -d extracted
docker run --rm -v "${PWD}":/data -it vm03/payload_dumper /data/extracted/payload.bin --out /data/output

echo "Payload extracted. Pushing boot.img to device (Downloads/ROM)..."
adb push output/boot.img ./storage/emulated/0/Download/ROM

patched=0
while [ $patched -ne 1 ]; do
    read -p "Patch boot.img with Magisk. Done? [y/N]: " choice
    case $choice in
        [Yy]* ) read -p "Patched img filename?: " patchedimg; patched=1
    esac
done

echo "Retrieving patched img..."
adb pull ./storage/emulated/0/Download/"$patchedimg" .

echo "Flashing patched boot.img..."
adb reboot bootloader
sleep 20
fastboot flash boot $patchedimg

echo "Flashed. Rebooting."
fastboot reboot

echo "Cleaning up..."
rm -rf extracted output $patchedimg
docker rmi vm03/payload_dumper

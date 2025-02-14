build-dongle:
  west build -s ./app -d build_dongle -b "nrf52840dongle_nrf52840" -- -DZMK_CONFIG=/home/adi/temper-zmk-config.git/config -DSHIELD="temper_dongle"

build-left:
 west build -s ./app -d build_left -b "nice_nano_v2" -- -DZMK_CONFIG=/home/adi/temper-zmk-config.git/config -DSHIELD="temper_left"

build-right:
 west build -s ./app -d build_right -b "nice_nano_v2" -- -DZMK_CONFIG=/home/adi/temper-zmk-config.git/config -DSHIELD="temper_right"

clean-dongle:
  rm -rf ./build_dongle

clean-left:
  rm -rf ./build_left

clean-right:
  rm -rf ./build_right

clean-all: clean-dongle clean-right clean-left
  echo

flash-dongle port:
  nrfutil pkg generate --hw-version 52 --sd-req=0x00 \
          --application ./build_dongle/zephyr/zmk.hex \
          --application-version 1 ./build_dongle/zephyr/zmk.zip
  mv ./build_dongle/zephyr/zmk.zip /mnt/c/Users/adi/Downloads/
  /mnt/c/Users/adi/Downloads/nrfutil.exe dfu usb-serial -pkg "C:\Users\adi\Downloads\zmk.zip" -p {{port}}

cp-left:
  cp ./build_left/zephyr/zmk.uf2 /mnt/c/Users/adi/Downloads/temper_left.uf2

cp-right:
  cp ./build_right/zephyr/zmk.uf2 /mnt/c/Users/adi/Downloads/temper_right.uf2

cp-all: cp-left cp-right

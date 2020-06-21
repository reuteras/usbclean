# usbclean

![Linter](https://github.com/reuteras/usbclean/workflows/Linter/badge.svg)

A solution to use a Raspberry Pi to automatically delete data from a USB memory stick. After deletion of the files the disk will be filled with random data that are then removed. Because of the way USB memory sticks work it is not guaranteed that parts of the original files can be retrieved. If anyone has a better solution please file a bug or contact me on Twitter [@reuteras](https://twitter.com/reuteras).

## Installation

I used [Raspbian Lite (February 2016)](https://www.raspberrypi.org/documentation/installation/installing-images/README.md). Information about how to write that image to your SD card can be found at [raspberrypi.org](https://www.raspberrypi.org/documentation/installation/installing-images/README.md).

After installation of Raspbian Login to your Pi (default username/password is pi/raspberry) and run

    sudo apt-get update
    sudo apt-get dist-upgrade
    sudo raspi-config                    # configure according to taste
    sudo apt-get install exfat-fuse exfat-utils git
    git clone https://github.com/reuteras/usbclean.git
    cd usbclean
    sudo bash
    make install

Everything should now be set up and the next time you insert a USB memory stick the files on it should be deleted. Remember that the hardware in Raspberry only supports USB2 so this will take a long time to overwrite the USB memory stick with random data.

## Leds

Before inserting a USB memory stick the green led will be on. While the cleaning process is running the red led will be turned off. When the green led is turned on again you can safely remove the USB memory.

## TODO

* Reformat the memory stick with sfdisk?


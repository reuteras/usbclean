Simple solution to use a Raspberry Pi to delete data from a USB-stick. After deletion of the files the disk will be filled with random data that are removed. Because of the way USB memory sticks work this is not a complete overwrite. If any one has a better solution please file a bug or contact me on Twitter @reuteras.

The MBR will also be removed.

Installation
============

I used [Raspbian Lite (February 2016)](https://www.raspberrypi.org/documentation/installation/installing-images/README.md) and more information about how you can write that image to your SD card can be found at [raspberrypi.org](https://www.raspberrypi.org/documentation/installation/installing-images/README.md).

Login to your Pi (default username/password is pi/raspberry) and run

    sudo apt-get update
    sudo apt-get dist-upgrade
    sudo raspi-config                    # configure according to taste
    sudo apt-get install exfat-fuse exfat-utils git
    git clone https://github.com/reuteras/zerousb.git
    cd zerousb
    sudo bash
    make install

Everything should now be set up and the next time you insert a usb memory stick the files on it should be deleted.


.PHONY: install test

all: install

install:
	cp usbclean.sh monitor.sh /usr/local/bin/
	chown root:root /usr/local/bin/monitor.sh
	chown root:root /usr/local/bin/usbclean.sh
	chmod 755 /usr/local/bin/monitor.sh
	chmod 755 /usr/local/bin/usbclean.sh
	cp 90-local.rules /etc/udev/rules.d/
	service udev reload
	cp usbclean-monitor.service /lib/systemd/system/
	systemctl daemon-reload
	systemctl enable usbclean-monitor.service
	systemctl start usbclean-monitor.service

test:
	shellcheck -f checkstyle *sh > checkstyle.out

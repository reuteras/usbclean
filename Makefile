.PHONY: install

all: install

install:
	cp detach.sh zerousb.sh monitor.sh /usr/local/bin/
	chown root:root /usr/local/bin/detach.sh
	chown root:root /usr/local/bin/monitor.sh
	chown root:root /usr/local/bin/zerousb.sh
	chmod 755 /usr/local/bin/detach.sh
	chmod 755 /usr/local/bin/monitor.sh
	chmod 755 /usr/local/bin/zerousb.sh
	cp 90-local.rules /etc/udev/rules.d/
	service udev reload
	cp zerousb-monitor.service /lib/systemd/system/
	systemctl daemon-reload
	systemctl enable zerousb-monitor.service
	systemctl start zerousb-monitor.service


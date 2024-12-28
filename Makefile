error:
	echo "use 'make install' or 'make uninstall'"

install: package
	kpackagetool6 --type=KWin/Script -i .

uninstall:
	kpackagetool6 --type=KWin/Script -r Switch-Last-Desktop
	qdbus6 org.kde.kglobalaccel /component/kwin org.kde.kglobalaccel.Component.cleanUp

upgrade: package
	kpackagetool6 --type=KWin/Script -u .

test: package upgrade
	qdbus6 org.kde.KWin /KWin reconfigure
	kwin --replace & disown

package: clean
	zip -r switch-to-last-visited-desktop.kwinscript contents metadata.json metadata.json.license README.md

clean:
	rm switch-to-last-visited-desktop.kwinscript || echo "Already cleaned"

log:
	journalctl -f QT_CATEGORY=qml

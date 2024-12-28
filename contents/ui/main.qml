import QtQuick
import org.kde.kwin

QtObject {
    id: root

    property var currentDesktop
    property var previousDesktop

    function initialize() {
        root.previousDesktop = null;
        root.currentDesktop = Workspace.currentDesktop;
    }

    function updateOrder() {
        root.previousDesktop = root.currentDesktop;
        root.currentDesktop = Workspace.currentDesktop;
    }

    function switchDesktop() {
        if (root.previousDesktop === null) {
            return;
        }
        Workspace.currentDesktop = root.previousDesktop;
    }

    property var shortcuts: Item {
        ShortcutHandler {
            name: "Switch to the Last Visited Desktop"
            text: "Switch to the Last Visited Desktop"
            sequence: "Meta+O"
            onActivated: switchDesktop()
        }
    }

    property var connections: Connections {
        target: Workspace
        function onCurrentDesktopChanged() {
            updateOrder();
        }

        function onDesktopsChanged() {
            initialize();
        }
    }

    Component.onCompleted: {
        initialize();
    }
}

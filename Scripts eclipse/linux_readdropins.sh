#!/bin/bash

DEST="/opt"
LAUNCHER_JAR="$(find $DEST/eclipse/plugins -name org.eclipse.equinox.launcher_*.jar)"

java -cp "${LAUNCHER_JAR}" org.eclipse.equinox.launcher.Main -application org.eclipse.equinox.p2.reconciler.application

From: Philipp Rudo <prudo@linux.ibm.com>
Date: Wed, 25 Jul 2018 11:36:15 +0000
Subject: [PATCH 5/5] zfcpdump: Add install script for zfcpdump
Message-Id: <20180725113615.93755-6-prudo@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Since version 198 (Feb 2013) systemd contains kernel-install, a script
managing kernel installs. This script allows execution of drop-in scripts
for customization. Add such a drop-in script to s390-tools to handle the
installation of zfcpdump kernels and simplify interactions between zfcpdump
and zipl.

The script supports two installation modes. One recommended by the
BootLoaderSpecs [1] to /boot/<machine-id>/<kernel-version> directories and
one directly to /boot. In the second case files are renamed during
installation to <original-name>-<kernel-version> to guarantee unique names.

Because the zfcpdump kernel is so special make the script stand-alone and
prevent any other script from being executed (exit 77) when a zfcpdump is
installed. Especially avoid functionality like creating an initrd (already
provided by s390-tools) or creating a boot entry (the zfcpdump kernel
should not be used for any other purpose than dumping).

The script requires systemd >= 203.

[1] https://www.freedesktop.org/wiki/Specifications/BootLoaderSpec/

Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
---
 .gitignore                      |   1 +
 common.mak                      |   3 +-
 zfcpdump/10-zfcpdump.install.in | 114 ++++++++++++++++++++++++++++++++++++++++
 zfcpdump/Makefile               |  16 ++++--
 4 files changed, 130 insertions(+), 4 deletions(-)
 create mode 100755 zfcpdump/10-zfcpdump.install.in

diff --git a/.gitignore b/.gitignore
index 6741256b..31e51e87 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@ zdump/zgetdump
 zfcpdump/cpioinit
 zfcpdump/zfcpdump_part
 zfcpdump/zfcpdump-initrd
+zfcpdump/10-zfcpdump.install
 ziomon/ziomon_mgr
 ziomon/ziomon_util
 ziomon/ziomon_zfcpdd
diff --git a/common.mak b/common.mak
index 986ff303..013b577b 100644
--- a/common.mak
+++ b/common.mak
@@ -184,7 +184,8 @@ export INSTALLDIR BINDIR LIBDIR MANDIR OWNER GROUP
 # Special defines for zfcpdump
 ZFCPDUMP_IMAGE	= zfcpdump-image
 ZFCPDUMP_INITRD	= zfcpdump-initrd
-export ZFCPDUMP_DIR ZFCPDUMP_IMAGE ZFCPDUMP_INITRD
+ZFCPDUMP_FLAVOR	= zfcpdump
+export ZFCPDUMP_DIR ZFCPDUMP_IMAGE ZFCPDUMP_INITRD ZFCPDUMP_FLAVOR
 
 CFLAGS		?= $(DEFAULT_CFLAGS) $(OPT_FLAGS)
 HOSTCFLAGS	?= $(DEFAULT_CFLAGS) $(OPT_FLAGS)
diff --git a/zfcpdump/10-zfcpdump.install.in b/zfcpdump/10-zfcpdump.install.in
new file mode 100755
index 00000000..37fde3b0
--- /dev/null
+++ b/zfcpdump/10-zfcpdump.install.in
@@ -0,0 +1,114 @@
+#!/bin/bash
+#
+# 10-zfcpdump.install - Installation script to handle zfcpdump kernels
+#
+# Copyright IBM Corp. 2018
+#
+# s390-tools is free software; you can redistribute it and/or modify
+# it under the terms of the MIT license. See LICENSE for details.
+#
+#
+# This script supports two modes:
+#
+#  1) Installing the images to /boot/<machine-id>/<kernel-version>
+#     subdirectories, i.e. BOOT_DIR_ABS, as recommended by the BLS.
+#     In this case file names are taken over from the original files.
+#
+#  2) Installing the images directly to /boot. In this case the files are
+#     renamed to <original-name>-<kernel-version>.
+#
+# The existence of BOOT_DIR_ABS is taken as trigger to switch between both
+# modes.
+#
+# The KERNEL_VERSION is assumed to contain '@flavor@' to identify the image
+# as a zfcpdump kernel.
+
+COMMAND="$1"
+KERNEL_VERSION="$2"
+BOOT_DIR_ABS="$3"
+KERNEL_IMAGE="$4"
+
+# Location zipl looks for the zfcpdump kernel
+ZFCPDUMP_IMAGE='@zfcpdump_image@'
+
+# Only handle zfcpdump kernels
+echo "$KERNEL_VERSION" | grep -q '@flavor@' || exit 0
+
+case "$COMMAND" in
+	add)
+		KERNEL_DIR="$(dirname $KERNEL_IMAGE)"
+		KERNEL_NAME="$(basename $KERNEL_IMAGE)"
+
+		for f in \
+			"$KERNEL_IMAGE" \
+			"$KERNEL_DIR"/System.map \
+			"$KERNEL_DIR"/config \
+			"$KERNEL_DIR"/zImage.stub
+		do
+			test -e "$f" || continue
+			test -d "$BOOT_DIR_ABS" \
+				&& DEST="$BOOT_DIR_ABS/$(basename $f)" \
+				|| DEST="/boot/$(basename $f)-$KERNEL_VERSION"
+
+			cp -aT "$f" "$DEST"
+			test $(command -v restorecon) && restorecon -R "$DEST"
+		done
+
+		# hmac file need special treatment
+		f="$KERNEL_DIR/.$KERNEL_NAME.hmac"
+		if [ -e "$f" ]; then
+			test -d "$BOOT_DIR_ABS" \
+				&& DEST="$BOOT_DIR_ABS/$(basename $f)" \
+				|| DEST="/boot/.$KERNEL_NAME-$KERNEL_VERSION.hmac"
+
+			cp -aT "$f" "$DEST"
+			test $(command -v restorecon) && restorecon -R "$DEST"
+		fi
+
+		# Set link so zipl finds the kernel
+		test -d "$BOOT_DIR_ABS" \
+			&& TARGET="$BOOT_DIR_ABS/$KERNEL_NAME" \
+			|| TARGET="/boot/$KERNEL_NAME-$KERNEL_VERSION"
+		ln -sf "$TARGET" "$ZFCPDUMP_IMAGE"
+		;;
+
+	remove)
+		# On removal
+		# $KERNEL_IMAGE is empty -> $KERNEL_NAME is empty -> rebuild it
+		KERNEL_NAME="$(basename $(readlink $ZFCPDUMP_IMAGE))"
+		if [ -d "$BOOT_DIR_ABS" ]; then
+			INSTALL_DIR="$(dirname $BOOT_DIR_ABS)"
+		else
+			INSTALL_DIR="/boot/"
+			KERNEL_NAME="$(echo $KERNEL_NAME \
+				| sed -e "s#\(.*\)-$KERNEL_VERSION#\1#")"
+		fi
+
+		for f in $(find "$INSTALL_DIR" -name "*$KERNEL_VERSION*"); do
+			rm -rf "$f"
+		done
+
+		# Update link to latest remaining zfcpdump kernel.
+		if [ $(readlink "$ZFCPDUMP_IMAGE" | grep "$KERNEL_VERSION") ]
+		then
+			NEXT_IMAGE=$( \
+				find "$INSTALL_DIR" -type f \
+				| grep '@flavor@' \
+				| grep "$KERNEL_NAME" \
+				| grep -v "hmac" \
+				| sort -V \
+				| tail -n1 )
+
+			test $NEXT_IMAGE \
+				&& ln -sf "$NEXT_IMAGE" "$ZFCPDUMP_IMAGE" \
+				|| rm -f "$ZFCPDUMP_IMAGE"
+		fi
+		;;
+	*)
+		;;
+esac
+
+# Prevent execution of all other scripts.
+# The zfcpdump kernel is stripped down to the bare minimum needed for
+# dumping. It is not supposed to be used for any other purpose.
+exit 77
diff --git a/zfcpdump/Makefile b/zfcpdump/Makefile
index 1d9cce53..cb2fd419 100644
--- a/zfcpdump/Makefile
+++ b/zfcpdump/Makefile
@@ -1,6 +1,7 @@
 include ../common.mak
 
 CPIOINIT  = $(call echocmd,"  CPIOINI ",/$@)./cpioinit
+INSTALL_SCRIPTS = 10-zfcpdump.install
 
 ifeq (${HAVE_LIBC_STATIC},0)
 
@@ -20,7 +21,7 @@ check_dep:
 		"HAVE_LIBC_STATIC=0", \
 		"-static")
 
-all: check_dep $(ZFCPDUMP_INITRD)
+all: check_dep $(ZFCPDUMP_INITRD) scripts
 
 cpioinit: cpioinit.c
 	$(HOSTCC) $(HOSTCFLAGS) -o $@ $^
@@ -34,12 +35,21 @@ $(ZFCPDUMP_INITRD): cpioinit zfcpdump_part
 	$(GZIP) -f $@.tmp
 	$(MV) $@.tmp.gz $(ZFCPDUMP_INITRD)
 
+scripts: $(INSTALL_SCRIPTS)
+	chmod +x $(INSTALL_SCRIPTS)
+
 install: all
 	$(INSTALL) -m 611 $(ZFCPDUMP_INITRD) $(DESTDIR)$(ZFCPDUMP_DIR)
 
+%: %.in
+	zfcpdump_image=$(ZFCPDUMP_DIR)/$(ZFCPDUMP_IMAGE);	\
+	$(SED)	-e "s#@zfcpdump_image@#$$zfcpdump_image#g"	\
+		-e "s#@flavor@#$(ZFCPDUMP_FLAVOR)#g"		\
+	< $< > $@
 endif
 
 clean:
-	rm -f *.o *.gz *.tmp *~ zfcpdump_part cpioinit $(ZFCPDUMP_INITRD)
+	rm -f *.o *.gz *.tmp *~ zfcpdump_part cpioinit $(ZFCPDUMP_INITRD) \
+		$(INSTALL_SCRIPTS)
 
-.PHONY: all clean install check_dep
+.PHONY: all clean install check_dep scripts
-- 
2.16.4

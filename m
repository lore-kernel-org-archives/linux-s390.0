Return-Path: <linux-kernel-owner+w=401wt.eu-S1760391AbXJDLc2@vger.kernel.org>
Message-Id: <20071004112828.156496636@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/34] cio: Documentation update.
Content-Disposition: inline; filename=013-cio-docu-update.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/00-INDEX |    2 -
 Documentation/s390/CommonIO |   51 +++++++++++++++++++++++++-------------------
 Documentation/s390/cds.txt  |    8 +++---
 3 files changed, 34 insertions(+), 27 deletions(-)

Index: quilt-2.6/Documentation/s390/00-INDEX
===================================================================
--- quilt-2.6.orig/Documentation/s390/00-INDEX
+++ quilt-2.6/Documentation/s390/00-INDEX
@@ -7,7 +7,7 @@
 cds.txt
 	- s390 common device support (common I/O layer).
 CommonIO
-	- common I/O layer command line parameters and /proc entries
+	- common I/O layer command line parameters, procfs and debugfs	entries
 config3270.sh
 	- example configuration for 3270 devices.
 DASD
Index: quilt-2.6/Documentation/s390/cds.txt
===================================================================
--- quilt-2.6.orig/Documentation/s390/cds.txt
+++ quilt-2.6/Documentation/s390/cds.txt
@@ -286,10 +286,10 @@ first:
             timeout value
 -EIO:       the common I/O layer terminated the request due to an error state
 
-If the concurrent sense flag in the extended status word in the irb is set, the
-field irb->scsw.count describes the number of device specific sense bytes
-available in the extended control word irb->scsw.ecw[0]. No device sensing by
-the device driver itself is required.
+If the concurrent sense flag in the extended status word (esw) in the irb is
+set, the field erw.scnt in the esw describes the number of device specific
+sense bytes available in the extended control word irb->scsw.ecw[]. No device
+sensing by the device driver itself is required.
 
 The device interrupt handler can use the following definitions to investigate
 the primary unit check source coded in sense byte 0 :
Index: quilt-2.6/Documentation/s390/CommonIO
===================================================================
--- quilt-2.6.orig/Documentation/s390/CommonIO
+++ quilt-2.6/Documentation/s390/CommonIO
@@ -1,5 +1,5 @@
-S/390 common I/O-Layer - command line parameters and /proc entries
-==================================================================
+S/390 common I/O-Layer - command line parameters, procfs and debugfs entries
+============================================================================
 
 Command line parameters
 -----------------------
@@ -7,9 +7,9 @@ Command line parameters
 * cio_msg = yes | no
   
   Determines whether information on found devices and sensed device 
-  characteristics should be shown during startup, i. e. messages of the types 
-  "Detected device 0.0.4711 on subchannel 0.0.0042" and "SenseID: Device
-  0.0.4711 reports: ...".
+  characteristics should be shown during startup or when new devices are
+  found, i. e. messages of the types "Detected device 0.0.4711 on subchannel
+  0.0.0042" and "SenseID: Device 0.0.4711 reports: ...".
 
   Default is off.
 
@@ -26,8 +26,10 @@ Command line parameters
   An ignored device can be un-ignored later; see the "/proc entries"-section for
   details.
 
-  The devices must be given either as bus ids (0.0.abcd) or as hexadecimal
-  device numbers (0xabcd or abcd, for 2.4 backward compatibility).
+  The devices must be given either as bus ids (0.x.abcd) or as hexadecimal
+  device numbers (0xabcd or abcd, for 2.4 backward compatibility). If you
+  give a device number 0xabcd, it will be interpreted as 0.0.abcd.
+
   You can use the 'all' keyword to ignore all devices.
   The '!' operator will cause the I/O-layer to _not_ ignore a device.
   The command line is parsed from left to right.
@@ -81,31 +83,36 @@ Command line parameters
   will add 0.0.a000-0.0.accc and 0.0.af00-0.0.afff to the list of ignored
   devices.
 
-  The devices can be specified either by bus id (0.0.abcd) or, for 2.4 backward
-  compatibility, by the device number in hexadecimal (0xabcd or abcd).
+  The devices can be specified either by bus id (0.x.abcd) or, for 2.4 backward
+  compatibility, by the device number in hexadecimal (0xabcd or abcd). Device
+  numbers given as 0xabcd will be interpreted as 0.0.abcd.
+
+* For some of the information present in the /proc filesystem in 2.4 (namely,
+  /proc/subchannels and /proc/chpids), see driver-model.txt.
+  Information formerly in /proc/irq_count is now in /proc/interrupts.
+
 
+debugfs entries
+---------------
 
-* /proc/s390dbf/cio_*/ (S/390 debug feature)
+* /sys/kernel/debug/s390dbf/cio_*/ (S/390 debug feature)
 
   Some views generated by the debug feature to hold various debug outputs.
 
-  - /proc/s390dbf/cio_crw/sprintf
+  - /sys/kernel/debug/s390dbf/cio_crw/sprintf
     Messages from the processing of pending channel report words (machine check
-    handling), which will also show when CONFIG_DEBUG_CRW is defined.
+    handling).
 
-  - /proc/s390dbf/cio_msg/sprintf
-    Various debug messages from the common I/O-layer; generally, messages which 
-    will also show when CONFIG_DEBUG_IO is defined.
+  - /sys/kernel/debug/s390dbf/cio_msg/sprintf
+    Various debug messages from the common I/O-layer, including messages
+    printed when cio_msg=yes.
 
-  - /proc/s390dbf/cio_trace/hex_ascii
+  - /sys/kernel/debug/s390dbf/cio_trace/hex_ascii
     Logs the calling of functions in the common I/O-layer and, if applicable, 
     which subchannel they were called for, as well as dumps of some data
     structures (like irb in an error case).
 
   The level of logging can be changed to be more or less verbose by piping to 
-  /proc/s390dbf/cio_*/level a number between 0 and 6; see the documentation on
-  the S/390 debug feature (Documentation/s390/s390dbf.txt) for details.
-
-* For some of the information present in the /proc filesystem in 2.4 (namely,
-  /proc/subchannels and /proc/chpids), see driver-model.txt.
-  Information formerly in /proc/irq_count is now in /proc/interrupts.
+  /sys/kernel/debug/s390dbf/cio_*/level a number between 0 and 6; see the
+  documentation on the S/390 debug feature (Documentation/s390/s390dbf.txt)
+  for details.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1759067AbXJDLbX@vger.kernel.org>
Message-Id: <20071004112827.886347767@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/34] Add Documentation/s390/00-INDEX.
Content-Disposition: inline; filename=012-cio-docu-index.diff
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

 Documentation/s390/00-INDEX |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: quilt-2.6/Documentation/s390/00-INDEX
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/00-INDEX
@@ -0,0 +1,26 @@
+00-INDEX
+	- this file.
+3270.ChangeLog
+	- ChangeLog for the UTS Global 3270-support patch (outdated).
+3270.txt
+	- how to use the IBM 3270 display system support.
+cds.txt
+	- s390 common device support (common I/O layer).
+CommonIO
+	- common I/O layer command line parameters and /proc entries
+config3270.sh
+	- example configuration for 3270 devices.
+DASD
+	- information on the DASD disk device driver.
+Debugging390.txt
+	- hints for debugging on s390 systems.
+driver-model.txt
+	- information on s390 devices and the driver model.
+monreader.txt
+	- information on accessing the z/VM monitor stream from Linux.
+s390dbf.txt
+	- information on using the s390 debug feature.
+TAPE
+	- information on the driver for channel-attached tapes.
+zfcpdump
+	- information on the s390 SCSI dump tool.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

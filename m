Return-Path: <linux-kernel-owner+w=401wt.eu-S1757350AbYBEPk4@vger.kernel.org>
Message-Id: <20080205153911.166508049@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/18] cio: Update documentation.
Content-Disposition: inline; filename=003-cio-docu.diff
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

 Documentation/DocBook/s390-drivers.tmpl |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

Index: quilt-2.6/Documentation/DocBook/s390-drivers.tmpl
===================================================================
--- quilt-2.6.orig/Documentation/DocBook/s390-drivers.tmpl
+++ quilt-2.6/Documentation/DocBook/s390-drivers.tmpl
@@ -59,7 +59,7 @@
    <title>Introduction</title>
   <para>
     This document describes the interfaces available for device drivers that
-    drive s390 based channel attached devices. This includes interfaces for
+    drive s390 based channel attached I/O devices. This includes interfaces for
     interaction with the hardware and interfaces for interacting with the
     common driver core. Those interfaces are provided by the s390 common I/O
     layer.
@@ -86,9 +86,10 @@
 	The ccw bus typically contains the majority of devices available to
 	a s390 system. Named after the channel command word (ccw), the basic
 	command structure used to address its devices, the ccw bus contains
-	so-called channel attached devices. They are addressed via subchannels,
-	visible on the css bus. A device driver, however, will never interact
-	with the subchannel directly, but only via the device on the ccw bus,
+	so-called channel attached devices. They are addressed via I/O
+	subchannels, visible on the css bus. A device driver for
+	channel-attached devices, however, will never interact	with the
+	subchannel directly, but only via the I/O device on the ccw bus,
 	the ccw device.
   </para>
     <sect1 id="channelIO">
@@ -116,7 +117,6 @@
 !Iinclude/asm-s390/ccwdev.h
 !Edrivers/s390/cio/device.c
 !Edrivers/s390/cio/device_ops.c
-!Edrivers/s390/cio/airq.c
     </sect1>
     <sect1 id="cmf">
      <title>The channel-measurement facility</title>
@@ -147,4 +147,15 @@
    </sect1>
   </chapter>
 
+  <chapter id="genericinterfaces">
+   <title>Generic interfaces</title>
+  <para>
+	Some interfaces are available to other drivers that do not necessarily
+	have anything to do with the busses described above, but still are
+	indirectly using basic infrastructure in the common I/O layer.
+	One example is the support for adapter interrupts.
+  </para>
+!Edrivers/s390/cio/airq.c
+  </chapter>
+
 </book>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

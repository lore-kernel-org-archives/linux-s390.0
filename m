Return-Path: <linux-kernel-owner+w=401wt.eu-S1755014AbYJAI65@vger.kernel.org>
Message-Id: <20081001084126.277407752@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/21] cio: Update cio_ignore documentation.
Content-Disposition: inline; filename=103-cio-docu.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Add documentation for the new "purge" cio_ignore parameter.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/CommonIO |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: quilt-2.6/Documentation/s390/CommonIO
===================================================================
--- quilt-2.6.orig/Documentation/s390/CommonIO
+++ quilt-2.6/Documentation/s390/CommonIO
@@ -70,13 +70,19 @@ Command line parameters
 
   Note: While already known devices can be added to the list of devices to be
         ignored, there will be no effect on then. However, if such a device
-	disappears and then reappears, it will then be ignored.
+	disappears and then reappears, it will then be ignored. To make
+	known devices go away, you need the "purge" command (see below).
 
   For example,
 	"echo add 0.0.a000-0.0.accc, 0.0.af00-0.0.afff > /proc/cio_ignore"
   will add 0.0.a000-0.0.accc and 0.0.af00-0.0.afff to the list of ignored
   devices.
 
+  You can remove already known but now ignored devices via
+	"echo purge > /proc/cio_ignore"
+  All devices ignored but still registered and not online (= not in use)
+  will be deregistered and thus removed from the system.
+
   The devices can be specified either by bus id (0.x.abcd) or, for 2.4 backward
   compatibility, by the device number in hexadecimal (0xabcd or abcd). Device
   numbers given as 0xabcd will be interpreted as 0.0.abcd.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

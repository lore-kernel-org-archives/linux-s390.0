Return-Path: <linux-kernel-owner+w=401wt.eu-S1755150AbYJAJEk@vger.kernel.org>
Message-Id: <20081001084126.516224293@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/21] cio: Exorcise cio_msg= from documentation.
Content-Disposition: inline; filename=104-cio-msg.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/CommonIO |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: quilt-2.6/Documentation/s390/CommonIO
===================================================================
--- quilt-2.6.orig/Documentation/s390/CommonIO
+++ quilt-2.6/Documentation/s390/CommonIO
@@ -104,8 +104,7 @@ debugfs entries
     handling).
 
   - /sys/kernel/debug/s390dbf/cio_msg/sprintf
-    Various debug messages from the common I/O-layer, including messages
-    printed when cio_msg=yes.
+    Various debug messages from the common I/O-layer.
 
   - /sys/kernel/debug/s390dbf/cio_trace/hex_ascii
     Logs the calling of functions in the common I/O-layer and, if applicable, 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1764780AbYCEMAo@vger.kernel.org>
Message-Id: <20080305115714.239239647@de.ibm.com>
References: <20080305115432.691030908@de.ibm.com>
Date: Wed, 05 Mar 2008 12:54:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/10] sclp_vt220: speed up console output for interactive work
Content-Disposition: inline; filename=006-vt220-speedup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Currently an output buffer can wait up to HZ/2 until the buffer is
flushed. The wait time is noticeable in interactive tools like mc.

Change the value to HZ/20, which seems enough for interactive work.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_vt220.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/char/sclp_vt220.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_vt220.c
+++ quilt-2.6/drivers/s390/char/sclp_vt220.c
@@ -367,7 +367,7 @@ sclp_vt220_timeout(unsigned long data)
 	sclp_vt220_emit_current();
 }
 
-#define BUFFER_MAX_DELAY	HZ/2
+#define BUFFER_MAX_DELAY	HZ/20
 
 /* 
  * Internal implementation of the write function. Write COUNT bytes of data

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1761016AbXJDLgc@vger.kernel.org>
Message-Id: <20071004112832.757372923@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 29/34] Remove obsolete recommendation for 8M ramdisk size.
Content-Disposition: inline; filename=029-ramdisk.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Robert P. J. Day <rpjday@mindspring.com>

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/block/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: quilt-2.6/drivers/block/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/block/Kconfig
+++ quilt-2.6/drivers/block/Kconfig
@@ -361,8 +361,7 @@ config BLK_DEV_RAM_SIZE
 	default "4096"
 	help
 	  The default value is 4096 kilobytes. Only change this if you know
-	  what are you doing. If you are using IBM S/390, then set this to
-	  8192.
+	  what are you doing.
 
 config BLK_DEV_RAM_BLOCKSIZE
 	int "Default RAM disk block size (bytes)"

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

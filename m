Return-Path: <linux-kernel-owner+w=401wt.eu-S1764152AbXGJJac@vger.kernel.org>
Message-Id: <20070710093110.286652773@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/16] zcore: Fix __user annotation.
Content-Disposition: inline; filename=006-zcore-user.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/zcore.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/char/zcore.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/zcore.c
+++ quilt-2.6/drivers/s390/char/zcore.c
@@ -156,7 +156,7 @@ static int memcpy_real(void *dest, unsig
 	return rc;
 }
 
-static int memcpy_real_user(__user void *dest, unsigned long src, size_t count)
+static int memcpy_real_user(void __user *dest, unsigned long src, size_t count)
 {
 	static char buf[4096];
 	int offs = 0, size;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

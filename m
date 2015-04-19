Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] s390: char: con3215: Free memory in error path
Date: Sun, 19 Apr 2015 15:17:36 +0200
Message-Id: <1429449456-4050-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe Jaillet <christophe.jaillet@wanadoo.fr>
List-ID: <linux-s390.vger.kernel.org>

If one memory allocation fails, there is a memory leak.

Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
---
 drivers/s390/char/con3215.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index c43aca6..0fc3fe5 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -667,6 +667,8 @@ static struct raw3215_info *raw3215_alloc_info(void)
 	info->buffer = kzalloc(RAW3215_BUFFER_SIZE, GFP_KERNEL | GFP_DMA);
 	info->inbuf = kzalloc(RAW3215_INBUF_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!info->buffer || !info->inbuf) {
+		kfree(info->inbuf);
+		kfree(info->buffer);
 		kfree(info);
 		return NULL;
 	}
-- 
2.1.0

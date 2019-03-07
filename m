Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
Message-ID: <d81a9133ad20d478dc8c14fbc8d1bacf4c8ffe94.camel@perches.com>
Subject: [PATCH] s390/mem_detect: Use IS_ENABLED(CONFIG_BLK_DEV_INITRD)
From: Joe Perches <joe@perches.com>
Date: Thu, 07 Mar 2019 15:51:45 -0800
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

IS_ENABLED should generally use CONFIG_ prefaced symbols and
it doesn't appear as if there is a BLK_DEV_INITRD define.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/s390/boot/mem_detect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/mem_detect.c b/arch/s390/boot/mem_detect.c
index 4cb771ba13fa..5d316fe40480 100644
--- a/arch/s390/boot/mem_detect.c
+++ b/arch/s390/boot/mem_detect.c
@@ -25,7 +25,7 @@ static void *mem_detect_alloc_extended(void)
 {
 	unsigned long offset = ALIGN(mem_safe_offset(), sizeof(u64));
 
-	if (IS_ENABLED(BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
 	    INITRD_START < offset + ENTRIES_EXTENDED_MAX)
 		offset = ALIGN(INITRD_START + INITRD_SIZE, sizeof(u64));
 

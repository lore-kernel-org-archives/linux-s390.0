Return-Path: <linux-kernel-owner+w=401wt.eu-S1753424AbYE2NCX@vger.kernel.org>
Message-Id: <20080529125728.861980900@de.ibm.com>
References: <20080529125501.196123527@de.ibm.com>
Date: Thu, 29 May 2008 14:55:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/11] s390 types: make dma_addr_t 64 bit capable
Content-Disposition: inline; filename=003-dma-64bit.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

virtio tests with guests larger than 4 GB revealed that the dma_addr_t
definition for s390 did not make it into the 64bit world.
This patch changes the definition on s390 to have an u64 on 64bit and
u32 on 32bit systems.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/types.h |    6 ++++++
 1 file changed, 6 insertions(+)

Index: quilt-2.6/include/asm-s390/types.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/types.h
+++ quilt-2.6/include/asm-s390/types.h
@@ -40,7 +40,13 @@ typedef __signed__ long saddr_t;
 
 #ifndef __ASSEMBLY__
 
+typedef u64 dma64_addr_t;
+#ifdef __s390x__
+/* DMA addresses come in 32-bit and 64-bit flavours. */
+typedef u64 dma_addr_t;
+#else
 typedef u32 dma_addr_t;
+#endif
 
 #ifndef __s390x__
 typedef union {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

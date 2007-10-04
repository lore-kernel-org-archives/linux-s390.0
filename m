Return-Path: <linux-kernel-owner+w=401wt.eu-S1761083AbXJDLhU@vger.kernel.org>
Message-Id: <20071004112833.125116380@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 30/34] zcore: fix inline assembly in memcpy_real()
Content-Disposition: inline; filename=030-zcore-inline.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

memcpy_real uses the mvcle instruction. This instruction alters all used
registers (source, destination and 2 x count). Therefore we have to flag
those registers as input/output registers (+d). In addition to that, we
have to specify, that we read from memory designated by "src" and write to
memory designated by "dest".

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/zcore.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/char/zcore.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/zcore.c
+++ quilt-2.6/drivers/s390/char/zcore.c
@@ -141,15 +141,16 @@ static int memcpy_real(void *dest, unsig
 
 	if (count == 0)
 		return 0;
-	flags = __raw_local_irq_stnsm(0xf8); /* switch to real mode */
+	flags = __raw_local_irq_stnsm(0xf8UL); /* switch to real mode */
 	asm volatile (
 		"0:	mvcle	%1,%2,0x0\n"
 		"1:	jo	0b\n"
 		"	lhi	%0,0x0\n"
 		"2:\n"
 		EX_TABLE(1b,2b)
-		: "+d" (rc)
-		: "d" (_dest), "d" (_src), "d" (_len1), "d" (_len2)
+		: "+d" (rc), "+d" (_dest), "+d" (_src), "+d" (_len1),
+		  "+d" (_len2), "=m" (*((long*)dest))
+		: "m" (*((long*)src))
 		: "cc", "memory");
 	__raw_local_irq_ssm(flags);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] [s390]: Use .rept directive to store/load fpu registers
Date: Fri, 28 Aug 2015 19:49:47 +0600
Message-Id: <1440769787-8942-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

We can use .rept directive to simplify/decrease assembly code
that makes storing and loading floating point registers in the
arch/s390/kernel/swsusp.S.

The resulting code after the patch is the same that before

 2c4:	68 00 d2 00       	ld	%f0,512(%r13)
 2c8:	68 10 d2 08       	ld	%f1,520(%r13)
 2cc:	68 20 d2 10       	ld	%f2,528(%r13)
 2d0:	68 30 d2 18       	ld	%f3,536(%r13)
 2d4:	68 40 d2 20       	ld	%f4,544(%r13)
 2d8:	68 50 d2 28       	ld	%f5,552(%r13)
 2dc:	68 60 d2 30       	ld	%f6,560(%r13)
 2e0:	68 70 d2 38       	ld	%f7,568(%r13)
 2e4:	68 80 d2 40       	ld	%f8,576(%r13)
 2e8:	68 90 d2 48       	ld	%f9,584(%r13)
 2ec:	68 a0 d2 50       	ld	%f10,592(%r13)
 2f0:	68 b0 d2 58       	ld	%f11,600(%r13)
 2f4:	68 c0 d2 60       	ld	%f12,608(%r13)
 2f8:	68 d0 d2 68       	ld	%f13,616(%r13)
 2fc:	68 e0 d2 70       	ld	%f14,624(%r13)
 300:	68 f0 d2 78       	ld	%f15,632(%r13)

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/s390/kernel/swsusp.S | 49 ++++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/arch/s390/kernel/swsusp.S b/arch/s390/kernel/swsusp.S
index ca62946..8011e14 100644
--- a/arch/s390/kernel/swsusp.S
+++ b/arch/s390/kernel/swsusp.S
@@ -48,22 +48,15 @@ ENTRY(swsusp_arch_suspend)
 	/* Store registers */
 	mvc	0x318(4,%r1),__SF_EMPTY(%r15)	/* move prefix to lowcore */
 	stfpc	0x31c(%r1)			/* store fpu control */
-	std	0,0x200(%r1)			/* store f0 */
-	std	1,0x208(%r1)			/* store f1 */
-	std	2,0x210(%r1)			/* store f2 */
-	std	3,0x218(%r1)			/* store f3 */
-	std	4,0x220(%r1)			/* store f4 */
-	std	5,0x228(%r1)			/* store f5 */
-	std	6,0x230(%r1)			/* store f6 */
-	std	7,0x238(%r1)			/* store f7 */
-	std	8,0x240(%r1)			/* store f8 */
-	std	9,0x248(%r1)			/* store f9 */
-	std	10,0x250(%r1)			/* store f10 */
-	std	11,0x258(%r1)			/* store f11 */
-	std	12,0x260(%r1)			/* store f12 */
-	std	13,0x268(%r1)			/* store f13 */
-	std	14,0x270(%r1)			/* store f14 */
-	std	15,0x278(%r1)			/* store f15 */
+
+	/* store f0..f15 floating point registers */
+	.set i, 0
+	.set f, 0x200
+	.rept 16
+	std i, f(%r1)
+	.set i, (i+1)
+	.set f, (f+0x8)
+	.endr
 	stam	%a0,%a15,0x340(%r1)		/* store access registers */
 	stctg	%c0,%c15,0x380(%r1)		/* store control registers */
 	stmg	%r0,%r15,0x280(%r1)		/* store general registers */
@@ -250,22 +243,14 @@ restore_registers:
 	lam	%a0,%a15,0x340(%r13)	/* load access registers */
 
 	lfpc	0x31c(%r13)		/* load fpu control */
-	ld	0,0x200(%r13)		/* load f0 */
-	ld	1,0x208(%r13)		/* load f1 */
-	ld	2,0x210(%r13)		/* load f2 */
-	ld	3,0x218(%r13)		/* load f3 */
-	ld	4,0x220(%r13)		/* load f4 */
-	ld	5,0x228(%r13)		/* load f5 */
-	ld	6,0x230(%r13)		/* load f6 */
-	ld	7,0x238(%r13)		/* load f7 */
-	ld	8,0x240(%r13)		/* load f8 */
-	ld	9,0x248(%r13)		/* load f9 */
-	ld	10,0x250(%r13)		/* load f10 */
-	ld	11,0x258(%r13)		/* load f11 */
-	ld	12,0x260(%r13)		/* load f12 */
-	ld	13,0x268(%r13)		/* load f13 */
-	ld	14,0x270(%r13)		/* load f14 */
-	ld	15,0x278(%r13)		/* load f15 */
+	/* load f0...f15 floating point registers */
+	.set i, 0
+	.set f, 0x200
+	.rept 16
+	ld i, f(%r13)
+	.set i, (i+1)
+	.set f, (f+0x8)
+	.endr
 
 	/* Load old stack */
 	lg	%r15,0x2f8(%r13)
-- 
2.5.0

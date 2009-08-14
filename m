Return-Path: <linux-kernel-owner+w=401wt.eu-S1756511AbZHNLdc@vger.kernel.org>
Message-Id: <20090814112615.846335152@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/34] convert/optimize csum_fold() to C
Content-Disposition: inline; filename=113-csum-fold.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

In the meantime gcc generates better code than the old inline
assemblies do. Original inline assembly results in:

lr	%r1,%r2
sr	%r3,%r3
lr	%r2,%r1
srdl	%r2,16
alr	%r2,%r3
alr	%r1,%r2
srl	%r1,16
xilf	%r1,65535
llghr	%r2,%r1
br	%r14

Out of the C code gcc generates this:

rll	%r1,%r2,16
ar	%r1,%r2
srl	%r1,16
xilf	%r1,65535
llghr	%r2,%r1
br	%r14

In addition we don't have any static register allocations anymore and
gcc is free to shuffle instructions around for better pipeline usage.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/checksum.h |   25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/checksum.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/checksum.h
+++ quilt-2.6/arch/s390/include/asm/checksum.h
@@ -78,28 +78,11 @@ csum_partial_copy_nocheck (const void *s
  */
 static inline __sum16 csum_fold(__wsum sum)
 {
-#ifndef __s390x__
-	register_pair rp;
+	u32 csum = (__force u32) sum;
 
-	asm volatile(
-		"	slr	%N1,%N1\n"	/* %0 = H L */
-		"	lr	%1,%0\n"	/* %0 = H L, %1 = H L 0 0 */
-		"	srdl	%1,16\n"	/* %0 = H L, %1 = 0 H L 0 */
-		"	alr	%1,%N1\n"	/* %0 = H L, %1 = L H L 0 */
-		"	alr	%0,%1\n"	/* %0 = H+L+C L+H */
-		"	srl	%0,16\n"	/* %0 = H+L+C */
-		: "+&d" (sum), "=d" (rp) : : "cc");
-#else /* __s390x__ */
-	asm volatile(
-		"	sr	3,3\n"		/* %0 = H*65536 + L */
-		"	lr	2,%0\n"		/* %0 = H L, 2/3 = H L / 0 0 */
-		"	srdl	2,16\n"		/* %0 = H L, 2/3 = 0 H / L 0 */
-		"	alr	2,3\n"		/* %0 = H L, 2/3 = L H / L 0 */
-		"	alr	%0,2\n"		/* %0 = H+L+C L+H */
-		"	srl	%0,16\n"	/* %0 = H+L+C */
-		: "+&d" (sum) : : "cc", "2", "3");
-#endif /* __s390x__ */
-	return (__force __sum16) ~sum;
+	csum += (csum >> 16) + (csum << 16);
+	csum >>= 16;
+	return (__force __sum16) ~csum;
 }
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

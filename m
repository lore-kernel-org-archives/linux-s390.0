Return-Path: <linux-kernel-owner+w=401wt.eu-S1753205AbXCZUyF@vger.kernel.org>
Message-Id: <20070326205249.540976264@de.ibm.com>
References: <20070326205225.438154546@de.ibm.com>
Date: Mon, 26 Mar 2007 22:52:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 2/6] Fix TCP/UDP pseudo header checksum computation.
Content-Disposition: inline; filename=002-tcpudp-fix.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

git commit f994aae1bd8e4813d59a2ed64d17585fe42d03fc changed the
function declaration of csum_tcpudp_nofold. Argument types were
changed from unsigned long to __be32 (unsigned int). Therefore we
lost the implicit type conversion that zeroed the upper half of the
registers that are used to pass parameters. Since the inline assembly
relied on this we ended up adding random values and wrong checksums
were created.
Showed only up on machines with more than 4GB since gcc produced code
where the registers that are used to pass 'saddr' and 'daddr' previously
contained addresses before calling this function.
Fix this by using 32 bit arithmetics and convert code to C, since gcc
produces better code than these hand-optimized versions.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-s390/checksum.h |   59 +++++++++++---------------------------------
 1 files changed, 15 insertions(+), 44 deletions(-)

Index: linux-2.6/include/asm-s390/checksum.h
===================================================================
--- linux-2.6.orig/include/asm-s390/checksum.h
+++ linux-2.6/include/asm-s390/checksum.h
@@ -121,50 +121,21 @@ csum_tcpudp_nofold(__be32 saddr, __be32 
                    unsigned short len, unsigned short proto,
                    __wsum sum)
 {
-#ifndef __s390x__
-	asm volatile(
-		"	alr	%0,%1\n" /* sum += saddr */
-		"	brc	12,0f\n"
-		"	ahi	%0,1\n"  /* add carry */
-		"0:"
-		: "+&d" (sum) : "d" (saddr) : "cc");
-	asm volatile(
-		"	alr	%0,%1\n" /* sum += daddr */
-		"	brc	12,1f\n"
-		"	ahi	%0,1\n"  /* add carry */
-		"1:"
-		: "+&d" (sum) : "d" (daddr) : "cc");
-	asm volatile(
-		"	alr	%0,%1\n" /* sum += len + proto */
-		"	brc	12,2f\n"
-		"	ahi	%0,1\n"  /* add carry */
-		"2:"
-		: "+&d" (sum)
-		: "d" (len + proto)
-		: "cc");
-#else /* __s390x__ */
-	asm volatile(
-		"	lgfr	%0,%0\n"
-		"	algr	%0,%1\n"  /* sum += saddr */
-		"	brc	12,0f\n"
-		"	aghi	%0,1\n"   /* add carry */
-		"0:	algr	%0,%2\n"  /* sum += daddr */
-		"	brc	12,1f\n"
-		"	aghi	%0,1\n"   /* add carry */
-		"1:	algfr	%0,%3\n"  /* sum += len + proto */
-		"	brc	12,2f\n"
-		"	aghi	%0,1\n"   /* add carry */
-		"2:	srlg	0,%0,32\n"
-		"	alr	%0,0\n"   /* fold to 32 bits */
-		"	brc	12,3f\n"
-		"	ahi	%0,1\n"   /* add carry */
-		"3:	llgfr	%0,%0"
-		: "+&d" (sum)
-		: "d" (saddr), "d" (daddr),
-		  "d" (len + proto)
-		: "cc", "0");
-#endif /* __s390x__ */
-	return sum;
+	__u32 csum = (__force __u32)sum;
+
+	csum += (__force __u32)saddr;
+	if (csum < (__force __u32)saddr)
+		csum++;
+
+	csum += (__force __u32)daddr;
+	if (csum < (__force __u32)daddr)
+		csum++;
+
+	csum += len + proto;
+	if (csum < len + proto)
+		csum++;
+
+	return (__force __wsum)csum;
 }
 
 /*

-- 

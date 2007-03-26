Return-Path: <linux-kernel-owner+w=401wt.eu-S1753131AbXCZUwx@vger.kernel.org>
Message-Id: <20070326205248.338724078@de.ibm.com>
References: <20070326205225.438154546@de.ibm.com>
Date: Mon, 26 Mar 2007 22:52:26 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 1/6] dasd: Work around gcc bug.
Content-Disposition: inline; filename=001-dasd-gcc-bug.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

gcc incorrectly removes initialization of register 0 in dasd diag
inline assembly. Use different register to work around this compiler
bug.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd_diag.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/s390/block/dasd_diag.c
===================================================================
--- linux-2.6.orig/drivers/s390/block/dasd_diag.c
+++ linux-2.6/drivers/s390/block/dasd_diag.c
@@ -65,7 +65,7 @@ static const u8 DASD_DIAG_CMS1[] = { 0xc
  * resulting condition code and DIAG return code. */
 static inline int dia250(void *iob, int cmd)
 {
-	register unsigned long reg0 asm ("0") = (unsigned long) iob;
+	register unsigned long reg2 asm ("2") = (unsigned long) iob;
 	typedef union {
 		struct dasd_diag_init_io init_io;
 		struct dasd_diag_rw_io rw_io;
@@ -74,15 +74,15 @@ static inline int dia250(void *iob, int 
 
 	rc = 3;
 	asm volatile(
-		"	diag	0,%2,0x250\n"
+		"	diag	2,%2,0x250\n"
 		"0:	ipm	%0\n"
 		"	srl	%0,28\n"
-		"	or	%0,1\n"
+		"	or	%0,3\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
 		: "+d" (rc), "=m" (*(addr_type *) iob)
-		: "d" (cmd), "d" (reg0), "m" (*(addr_type *) iob)
-		: "1", "cc");
+		: "d" (cmd), "d" (reg2), "m" (*(addr_type *) iob)
+		: "3", "cc");
 	return rc;
 }
 

-- 

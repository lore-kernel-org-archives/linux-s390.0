Return-Path: <linux-kernel-owner+w=401wt.eu-S1761245AbXJDLia@vger.kernel.org>
Message-Id: <20071004112833.790464002@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 32/34] cpcmd: fix inline assembly usage.
Content-Disposition: inline; filename=032-cpcmd-inline.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

After assigning values to specific registers memset was called. This
may clobber the contents of the used registers.
To solve this extract the two used inline assemblies into small
functions that don't call any functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/cpcmd.c |  100 +++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 45 deletions(-)

Index: quilt-2.6/arch/s390/kernel/cpcmd.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/cpcmd.c
+++ quilt-2.6/arch/s390/kernel/cpcmd.c
@@ -2,7 +2,7 @@
  *  arch/s390/kernel/cpcmd.c
  *
  *  S390 version
- *    Copyright (C) 1999,2005 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright IBM Corp. 1999,2007
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Christian Borntraeger (cborntra@de.ibm.com),
  */
@@ -21,6 +21,49 @@
 static DEFINE_SPINLOCK(cpcmd_lock);
 static char cpcmd_buf[241];
 
+static int diag8_noresponse(int cmdlen)
+{
+	register unsigned long reg2 asm ("2") = (addr_t) cpcmd_buf;
+	register unsigned long reg3 asm ("3") = cmdlen;
+
+	asm volatile(
+#ifndef CONFIG_64BIT
+		"	diag	%1,%0,0x8\n"
+#else /* CONFIG_64BIT */
+		"	sam31\n"
+		"	diag	%1,%0,0x8\n"
+		"	sam64\n"
+#endif /* CONFIG_64BIT */
+		: "+d" (reg3) : "d" (reg2) : "cc");
+	return reg3;
+}
+
+static int diag8_response(int cmdlen, char *response, int *rlen)
+{
+	register unsigned long reg2 asm ("2") = (addr_t) cpcmd_buf;
+	register unsigned long reg3 asm ("3") = (addr_t) response;
+	register unsigned long reg4 asm ("4") = cmdlen | 0x40000000L;
+	register unsigned long reg5 asm ("5") = *rlen;
+
+	asm volatile(
+#ifndef CONFIG_64BIT
+		"	diag	%2,%0,0x8\n"
+		"	brc	8,1f\n"
+		"	ar	%1,%4\n"
+#else /* CONFIG_64BIT */
+		"	sam31\n"
+		"	diag	%2,%0,0x8\n"
+		"	sam64\n"
+		"	brc	8,1f\n"
+		"	agr	%1,%4\n"
+#endif /* CONFIG_64BIT */
+		"1:\n"
+		: "+d" (reg4), "+d" (reg5)
+		: "d" (reg2), "d" (reg3), "d" (*rlen) : "cc");
+	*rlen = reg5;
+	return reg4;
+}
+
 /*
  * __cpcmd has some restrictions over cpcmd
  *  - the response buffer must reside below 2GB (if any)
@@ -28,59 +71,27 @@ static char cpcmd_buf[241];
  */
 int  __cpcmd(const char *cmd, char *response, int rlen, int *response_code)
 {
-	unsigned cmdlen;
-	int return_code, return_len;
+	int cmdlen;
+	int rc;
+	int response_len;
 
 	cmdlen = strlen(cmd);
 	BUG_ON(cmdlen > 240);
 	memcpy(cpcmd_buf, cmd, cmdlen);
 	ASCEBC(cpcmd_buf, cmdlen);
 
-	if (response != NULL && rlen > 0) {
-		register unsigned long reg2 asm ("2") = (addr_t) cpcmd_buf;
-		register unsigned long reg3 asm ("3") = (addr_t) response;
-		register unsigned long reg4 asm ("4") = cmdlen | 0x40000000L;
-		register unsigned long reg5 asm ("5") = rlen;
-
+	if (response) {
 		memset(response, 0, rlen);
-		asm volatile(
-#ifndef CONFIG_64BIT
-			"	diag	%2,%0,0x8\n"
-			"	brc	8,1f\n"
-			"	ar	%1,%4\n"
-#else /* CONFIG_64BIT */
-			"	sam31\n"
-			"	diag	%2,%0,0x8\n"
-			"	sam64\n"
-			"	brc	8,1f\n"
-			"	agr	%1,%4\n"
-#endif /* CONFIG_64BIT */
-			"1:\n"
-			: "+d" (reg4), "+d" (reg5)
-			: "d" (reg2), "d" (reg3), "d" (rlen) : "cc");
-		return_code = (int) reg4;
-		return_len = (int) reg5;
-                EBCASC(response, rlen);
+		response_len = rlen;
+		rc = diag8_response(cmdlen, response, &rlen);
+		EBCASC(response, response_len);
         } else {
-		register unsigned long reg2 asm ("2") = (addr_t) cpcmd_buf;
-		register unsigned long reg3 asm ("3") = cmdlen;
-		return_len = 0;
-		asm volatile(
-#ifndef CONFIG_64BIT
-			"	diag	%1,%0,0x8\n"
-#else /* CONFIG_64BIT */
-			"	sam31\n"
-			"	diag	%1,%0,0x8\n"
-			"	sam64\n"
-#endif /* CONFIG_64BIT */
-			: "+d" (reg3) : "d" (reg2) : "cc");
-		return_code = (int) reg3;
+		rc = diag8_noresponse(cmdlen);
         }
-	if (response_code != NULL)
-		*response_code = return_code;
-	return return_len;
+	if (response_code)
+		*response_code = rc;
+	return rlen;
 }
-
 EXPORT_SYMBOL(__cpcmd);
 
 int cpcmd(const char *cmd, char *response, int rlen, int *response_code)
@@ -109,5 +120,4 @@ int cpcmd(const char *cmd, char *respons
 	}
 	return len;
 }
-
 EXPORT_SYMBOL(cpcmd);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

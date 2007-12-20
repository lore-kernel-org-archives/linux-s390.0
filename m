Return-Path: <linux-kernel-owner+w=401wt.eu-S1763151AbXLTP2x@vger.kernel.org>
Message-Id: <20071220152112.021174561@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 41/47] include/asm-s390/: Spelling fixes
Content-Disposition: inline; filename=140-spelling-include.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Joe Perches <joe@perches.com>

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/cio.h    |    4 ++--
 include/asm-s390/dasd.h   |    2 +-
 include/asm-s390/qdio.h   |    2 +-
 include/asm-s390/zcrypt.h |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

Index: quilt-2.6/include/asm-s390/cio.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cio.h
+++ quilt-2.6/include/asm-s390/cio.h
@@ -24,8 +24,8 @@
  * @fmt: format
  * @pfch: prefetch
  * @isic: initial-status interruption control
- * @alcc: adress-limit checking control
- * @ssi: supress-suspended interruption
+ * @alcc: address-limit checking control
+ * @ssi: suppress-suspended interruption
  * @zcc: zero condition code
  * @ectl: extended control
  * @pno: path not operational
Index: quilt-2.6/include/asm-s390/dasd.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/dasd.h
+++ quilt-2.6/include/asm-s390/dasd.h
@@ -105,7 +105,7 @@ typedef struct dasd_information_t {
 } dasd_information_t;
 
 /*
- * Read Subsystem Data - Perfomance Statistics
+ * Read Subsystem Data - Performance Statistics
  */ 
 typedef struct dasd_rssd_perf_stats_t {
 	unsigned char  invalid:1;
Index: quilt-2.6/include/asm-s390/qdio.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/qdio.h
+++ quilt-2.6/include/asm-s390/qdio.h
@@ -184,7 +184,7 @@ struct qdr {
 #endif /* QDIO_32_BIT */
 	unsigned long qiba;             /* queue-information-block address */
 	unsigned int  res8;             /* reserved */
-	unsigned int  qkey    :  4;     /* queue-informatio-block key */
+	unsigned int  qkey    :  4;	/* queue-information-block key */
 	unsigned int  res9    : 28;     /* reserved */
 /*	union _qd {*/ /* why this? */
 		struct qdesfmt0 qdf0[126];
Index: quilt-2.6/include/asm-s390/zcrypt.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/zcrypt.h
+++ quilt-2.6/include/asm-s390/zcrypt.h
@@ -117,7 +117,7 @@ struct CPRBX {
 	unsigned char	padx004[16 - sizeof (char *)];
 	unsigned char *	req_extb;	/* request extension block 'addr'*/
 	unsigned char	padx005[16 - sizeof (char *)];
-	unsigned char *	rpl_extb;	/* reply extension block 'addres'*/
+	unsigned char *	rpl_extb;	/* reply extension block 'address'*/
 	unsigned short	ccp_rtcode;	/* server return code		 */
 	unsigned short	ccp_rscode;	/* server reason code		 */
 	unsigned int	mac_data_len;	/* Mac Data Length		 */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

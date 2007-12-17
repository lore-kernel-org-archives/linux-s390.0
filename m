Return-Path: <linux-kernel-owner+w=401wt.eu-S1763544AbXLQThr@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [PATCH] include/asm-s390/: Spelling fixes
Date: Mon, 17 Dec 2007 11:30:17 -0800
Message-Id: <1197919875-5288-18-git-send-email-joe@perches.com>
Message-Id: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918890.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>


Signed-off-by: Joe Perches <joe@perches.com>
---
 include/asm-s390/cio.h    |    4 ++--
 include/asm-s390/dasd.h   |    2 +-
 include/asm-s390/qdio.h   |    2 +-
 include/asm-s390/zcrypt.h |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-s390/cio.h b/include/asm-s390/cio.h
index 2f08c16..123b557 100644
--- a/include/asm-s390/cio.h
+++ b/include/asm-s390/cio.h
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
diff --git a/include/asm-s390/dasd.h b/include/asm-s390/dasd.h
index 604f68f..3f002e1 100644
--- a/include/asm-s390/dasd.h
+++ b/include/asm-s390/dasd.h
@@ -105,7 +105,7 @@ typedef struct dasd_information_t {
 } dasd_information_t;
 
 /*
- * Read Subsystem Data - Perfomance Statistics
+ * Read Subsystem Data - Performance Statistics
  */ 
 typedef struct dasd_rssd_perf_stats_t {
 	unsigned char  invalid:1;
diff --git a/include/asm-s390/qdio.h b/include/asm-s390/qdio.h
index 74db1dc..828bfcb 100644
--- a/include/asm-s390/qdio.h
+++ b/include/asm-s390/qdio.h
@@ -184,7 +184,7 @@ struct qdr {
 #endif /* QDIO_32_BIT */
 	unsigned long qiba;             /* queue-information-block address */
 	unsigned int  res8;             /* reserved */
-	unsigned int  qkey    :  4;     /* queue-informatio-block key */
+	unsigned int  qkey    :  4;     /* queue-information-block key */
 	unsigned int  res9    : 28;     /* reserved */
 /*	union _qd {*/ /* why this? */
 		struct qdesfmt0 qdf0[126];
diff --git a/include/asm-s390/zcrypt.h b/include/asm-s390/zcrypt.h
index a5dada6..f228f1b 100644
--- a/include/asm-s390/zcrypt.h
+++ b/include/asm-s390/zcrypt.h
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
1.5.3.7.949.g2221a6

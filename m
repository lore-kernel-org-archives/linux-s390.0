Return-Path: <SRS0=h9J9=SO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 2/8] net/smc: fallback to TCP after connect problems
Date: Fri, 12 Apr 2019 12:57:24 +0200
In-Reply-To: <20190412105730.96245-1-ubraun@linux.ibm.com>
References: <20190412105730.96245-1-ubraun@linux.ibm.com>
Message-Id: <20190412105730.96245-3-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Correct the CLC decline reason codes for internal problems to not have
the sign bit set, negative reason codes are interpreted as not eligible
for TCP fallback.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_clc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 24658e8c0de4..6c94d54e7a67 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -40,10 +40,10 @@
 #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
 #define SMC_CLC_DECL_SYNCERR	0x04000000  /* synchronization error          */
 #define SMC_CLC_DECL_PEERDECL	0x05000000  /* peer declined during handshake */
-#define SMC_CLC_DECL_INTERR	0x99990000  /* internal error                 */
-#define SMC_CLC_DECL_ERR_RTOK	0x99990001  /*	 rtoken handling failed       */
-#define SMC_CLC_DECL_ERR_RDYLNK	0x99990002  /*	 ib ready link failed	      */
-#define SMC_CLC_DECL_ERR_REGRMB	0x99990003  /*	 reg rmb failed		      */
+#define SMC_CLC_DECL_INTERR	0x09990000  /* internal error		      */
+#define SMC_CLC_DECL_ERR_RTOK	0x09990001  /*	 rtoken handling failed       */
+#define SMC_CLC_DECL_ERR_RDYLNK	0x09990002  /*	 ib ready link failed	      */
+#define SMC_CLC_DECL_ERR_REGRMB	0x09990003  /*	 reg rmb failed		      */
 
 struct smc_clc_msg_hdr {	/* header1 of clc messages */
 	u8 eyecatcher[4];	/* eye catcher */
-- 
2.16.4

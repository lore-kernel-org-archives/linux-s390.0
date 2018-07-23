Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 4/5] net/smc: use DECLARE_BITMAP for rtokens_used_mask
Date: Mon, 23 Jul 2018 13:53:11 +0200
In-Reply-To: <20180723115312.54694-1-ubraun@linux.ibm.com>
References: <20180723115312.54694-1-ubraun@linux.ibm.com>
Message-Id: <20180723115312.54694-5-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Link group field tokens_used_mask is a bitmap. Use macro
DECLARE_BITMAP for its definition.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 8807865483bb..1e8974c50550 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -192,8 +192,7 @@ struct smc_link_group {
 			struct smc_rtoken	rtokens[SMC_RMBS_PER_LGR_MAX]
 						[SMC_LINKS_PER_LGR_MAX];
 						/* remote addr/key pairs */
-			unsigned long		rtokens_used_mask[BITS_TO_LONGS
-							(SMC_RMBS_PER_LGR_MAX)];
+			DECLARE_BITMAP(rtokens_used_mask, SMC_RMBS_PER_LGR_MAX);
 						/* used rtoken elements */
 		};
 		struct { /* SMC-D */
-- 
2.16.4

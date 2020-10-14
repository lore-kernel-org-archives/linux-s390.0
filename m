Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727391AbgJNRnz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Oct 2020 13:43:55 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 2/3] net/smc: fix valid DMBE buffer sizes
Date: Wed, 14 Oct 2020 19:43:28 +0200
Message-Id: <20201014174329.35791-3-kgraul@linux.ibm.com>
In-Reply-To: <20201014174329.35791-1-kgraul@linux.ibm.com>
References: <20201014174329.35791-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The SMCD_DMBE_SIZES should include all valid DMBE buffer sizes, so the
correct value is 6 which means 1MB. With 7 the registration of an ISM
buffer would always fail because of the invalid size requested.
Fix that and set the value to 6.

Fixes: c6ba7c9ba43d ("net/smc: add base infrastructure for SMC-D and ISM")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index f1dbb5025c0b..5de637472a11 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1596,7 +1596,7 @@ static int smcr_buf_map_usable_links(struct smc_link_group *lgr,
 	return rc;
 }
 
-#define SMCD_DMBE_SIZES		7 /* 0 -> 16KB, 1 -> 32KB, .. 6 -> 1MB */
+#define SMCD_DMBE_SIZES		6 /* 0 -> 16KB, 1 -> 32KB, .. 6 -> 1MB */
 
 static struct smc_buf_desc *smcd_new_buf_create(struct smc_link_group *lgr,
 						bool is_dmb, int bufsize)
-- 
2.17.1

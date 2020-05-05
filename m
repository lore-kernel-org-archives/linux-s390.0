Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728834AbgEENBz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 09:01:55 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 2/2] net/smc: remove unused inline function smc_curs_read
Date: Tue,  5 May 2020 15:01:21 +0200
Message-Id: <20200505130121.103272-3-kgraul@linux.ibm.com>
In-Reply-To: <20200505130121.103272-1-kgraul@linux.ibm.com>
References: <20200505130121.103272-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: YueHaibing <yuehaibing@huawei.com>

commit bac6de7b6370 ("net/smc: eliminate cursor read and write calls")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_cdc.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 9cfabc9af120..2ddcc5fb5ceb 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -97,23 +97,6 @@ static inline void smc_curs_add(int size, union smc_host_cursor *curs,
 	}
 }
 
-/* SMC cursors are 8 bytes long and require atomic reading and writing */
-static inline u64 smc_curs_read(union smc_host_cursor *curs,
-				struct smc_connection *conn)
-{
-#ifndef KERNEL_HAS_ATOMIC64
-	unsigned long flags;
-	u64 ret;
-
-	spin_lock_irqsave(&conn->acurs_lock, flags);
-	ret = curs->acurs;
-	spin_unlock_irqrestore(&conn->acurs_lock, flags);
-	return ret;
-#else
-	return atomic64_read(&curs->acurs);
-#endif
-}
-
 /* Copy cursor src into tgt */
 static inline void smc_curs_copy(union smc_host_cursor *tgt,
 				 union smc_host_cursor *src,
-- 
2.17.1

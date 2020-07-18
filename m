Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727086AbgGRNGz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 18 Jul 2020 09:06:55 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net v2 09/10] net/smc: remove freed buffer from list
Date: Sat, 18 Jul 2020 15:06:17 +0200
Message-Id: <20200718130618.16724-10-kgraul@linux.ibm.com>
In-Reply-To: <20200718130618.16724-1-kgraul@linux.ibm.com>
References: <20200718130618.16724-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Two buffers are allocated for each SMC connection. Each buffer is
added to a buffer list after creation. When the second buffer
allocation fails, the first buffer is freed but not deleted from
the list. This might result in crashes when another connection picks
up the freed buffer later and starts to work with it.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: 6511aad3f039 ("net/smc: change smc_buf_free function parameters")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 42ba227f3e97..ca3dc6af73af 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1772,8 +1772,12 @@ int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 		return rc;
 	/* create rmb */
 	rc = __smc_buf_create(smc, is_smcd, true);
-	if (rc)
+	if (rc) {
+		mutex_lock(&smc->conn.lgr->sndbufs_lock);
+		list_del(&smc->conn.sndbuf_desc->list);
+		mutex_unlock(&smc->conn.lgr->sndbufs_lock);
 		smc_buf_free(smc->conn.lgr, false, smc->conn.sndbuf_desc);
+	}
 	return rc;
 }
 
-- 
2.17.1

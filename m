Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728975AbgICTxi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Sep 2020 15:53:38 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 2/4] net/smc: set rx_off for SMCR explicitly
Date: Thu,  3 Sep 2020 21:53:16 +0200
Message-Id: <20200903195318.39288-3-kgraul@linux.ibm.com>
In-Reply-To: <20200903195318.39288-1-kgraul@linux.ibm.com>
References: <20200903195318.39288-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

SMC tries to make use of SMCD first. If a problem shows up,
it tries to switch to SMCR. If the SMCD initializing problem shows
up after the SMCD connection has already been initialized, field
rx_off keeps the wrong SMCD value for SMCR, which results in corrupted
data at the receiver.
This patch adds an explicit (re-)setting of field rx_off to zero if the
connection uses SMCR.

Fixes: be244f28d22f ("net/smc: add SMC-D support in data transfer")
Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index b42fa3b00d00..a6ac0eb20c99 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1356,6 +1356,8 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 	if (ini->is_smcd) {
 		conn->rx_off = sizeof(struct smcd_cdc_msg);
 		smcd_cdc_rx_init(conn); /* init tasklet for this conn */
+	} else {
+		conn->rx_off = 0;
 	}
 #ifndef KERNEL_HAS_ATOMIC64
 	spin_lock_init(&conn->acurs_lock);
-- 
2.17.1

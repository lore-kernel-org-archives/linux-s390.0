Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27332 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgGZSe4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 26 Jul 2020 14:34:56 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 2/2] net/smc: unique reason code for exceeded max dmb count
Date: Sun, 26 Jul 2020 20:34:28 +0200
Message-Id: <20200726183428.3284-3-kgraul@linux.ibm.com>
In-Reply-To: <20200726183428.3284-1-kgraul@linux.ibm.com>
References: <20200726183428.3284-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

When the maximum dmb buffer limit for an ism device is reached no more
dmb buffers can be registered. When this happens the reason code is set
to SMC_CLC_DECL_MEM indicating out-of-memory. This is the same reason
code that is used when no memory could be allocated for the new dmb
buffer.
This is confusing for users when they see this error but there is more
memory available. To solve this set a separate new reason code when the
maximum dmb limit exceeded.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c   | 13 +++++++++----
 net/smc/smc_clc.h  |  1 +
 net/smc/smc_core.c |  4 ++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 832e36269b10..e7649bbc2b87 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -719,8 +719,11 @@ static int smc_connect_ism(struct smc_sock *smc,
 	}
 
 	/* Create send and receive buffers */
-	if (smc_buf_create(smc, true))
-		return smc_connect_abort(smc, SMC_CLC_DECL_MEM,
+	rc = smc_buf_create(smc, true);
+	if (rc)
+		return smc_connect_abort(smc, (rc == -ENOSPC) ?
+					      SMC_CLC_DECL_MAX_DMB :
+					      SMC_CLC_DECL_MEM,
 					 ini->cln_first_contact);
 
 	smc_conn_save_peer_info(smc, aclc);
@@ -1200,12 +1203,14 @@ static int smc_listen_ism_init(struct smc_sock *new_smc,
 	}
 
 	/* Create send and receive buffers */
-	if (smc_buf_create(new_smc, true)) {
+	rc = smc_buf_create(new_smc, true);
+	if (rc) {
 		if (ini->cln_first_contact == SMC_FIRST_CONTACT)
 			smc_lgr_cleanup_early(&new_smc->conn);
 		else
 			smc_conn_free(&new_smc->conn);
-		return SMC_CLC_DECL_MEM;
+		return (rc == -ENOSPC) ? SMC_CLC_DECL_MAX_DMB :
+					 SMC_CLC_DECL_MEM;
 	}
 
 	return 0;
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 76c2b150d040..cf7b45306f4e 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -48,6 +48,7 @@
 #define SMC_CLC_DECL_NOACTLINK	0x030a0000  /* no active smc-r link in lgr    */
 #define SMC_CLC_DECL_NOSRVLINK	0x030b0000  /* SMC-R link from srv not found  */
 #define SMC_CLC_DECL_VERSMISMAT	0x030c0000  /* SMC version mismatch	      */
+#define SMC_CLC_DECL_MAX_DMB	0x030d0000  /* SMC-D DMB limit exceeded       */
 #define SMC_CLC_DECL_SYNCERR	0x04000000  /* synchronization error          */
 #define SMC_CLC_DECL_PEERDECL	0x05000000  /* peer declined during handshake */
 #define SMC_CLC_DECL_INTERR	0x09990000  /* internal error		      */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index f82a2e599917..b42fa3b00d00 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1614,7 +1614,7 @@ static struct smc_buf_desc *smcd_new_buf_create(struct smc_link_group *lgr,
 		rc = smc_ism_register_dmb(lgr, bufsize, buf_desc);
 		if (rc) {
 			kfree(buf_desc);
-			return ERR_PTR(-EAGAIN);
+			return (rc == -ENOMEM) ? ERR_PTR(-EAGAIN) : ERR_PTR(rc);
 		}
 		buf_desc->pages = virt_to_page(buf_desc->cpu_addr);
 		/* CDC header stored in buf. So, pretend it was smaller */
@@ -1688,7 +1688,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	}
 
 	if (IS_ERR(buf_desc))
-		return -ENOMEM;
+		return PTR_ERR(buf_desc);
 
 	if (!is_smcd) {
 		if (smcr_buf_map_usable_links(lgr, buf_desc, is_rmb)) {
-- 
2.17.1

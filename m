Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728268AbgEAKsa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 May 2020 06:48:30 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 03/13] net/smc: map and register buffers for a new link
Date: Fri,  1 May 2020 12:48:03 +0200
Message-Id: <20200501104813.76601-4-kgraul@linux.ibm.com>
In-Reply-To: <20200501104813.76601-1-kgraul@linux.ibm.com>
References: <20200501104813.76601-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Introduce support to map and register all current buffers for a new
link. smcr_buf_map_lgr() will map used buffers for a new link and
smcr_buf_reg_lgr() can be called to register used buffers on the
IB device of the new link.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_core.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d5ecea490b4e..0e87f652caea 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1185,6 +1185,66 @@ int smcr_link_reg_rmb(struct smc_link *link, struct smc_buf_desc *rmb_desc)
 	return 0;
 }
 
+static int _smcr_buf_map_lgr(struct smc_link *lnk, struct mutex *lock,
+			     struct list_head *lst, bool is_rmb)
+{
+	struct smc_buf_desc *buf_desc, *bf;
+	int rc = 0;
+
+	mutex_lock(lock);
+	list_for_each_entry_safe(buf_desc, bf, lst, list) {
+		if (!buf_desc->used)
+			continue;
+		rc = smcr_buf_map_link(buf_desc, is_rmb, lnk);
+		if (rc)
+			goto out;
+	}
+out:
+	mutex_unlock(lock);
+	return rc;
+}
+
+/* map all used buffers of lgr for a new link */
+int smcr_buf_map_lgr(struct smc_link *lnk)
+{
+	struct smc_link_group *lgr = lnk->lgr;
+	int i, rc = 0;
+
+	for (i = 0; i < SMC_RMBE_SIZES; i++) {
+		rc = _smcr_buf_map_lgr(lnk, &lgr->rmbs_lock,
+				       &lgr->rmbs[i], true);
+		if (rc)
+			return rc;
+		rc = _smcr_buf_map_lgr(lnk, &lgr->sndbufs_lock,
+				       &lgr->sndbufs[i], false);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+/* register all used buffers of lgr for a new link */
+int smcr_buf_reg_lgr(struct smc_link *lnk)
+{
+	struct smc_link_group *lgr = lnk->lgr;
+	struct smc_buf_desc *buf_desc, *bf;
+	int i, rc = 0;
+
+	mutex_lock(&lgr->rmbs_lock);
+	for (i = 0; i < SMC_RMBE_SIZES; i++) {
+		list_for_each_entry_safe(buf_desc, bf, &lgr->rmbs[i], list) {
+			if (!buf_desc->used)
+				continue;
+			rc = smcr_link_reg_rmb(lnk, buf_desc);
+			if (rc)
+				goto out;
+		}
+	}
+out:
+	mutex_unlock(&lgr->rmbs_lock);
+	return rc;
+}
+
 static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
 						bool is_rmb, int bufsize)
 {
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index fa532a423fd7..61ddb5264936 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -368,6 +368,8 @@ int smc_core_init(void);
 void smc_core_exit(void);
 
 void smcr_link_clear(struct smc_link *lnk);
+int smcr_buf_map_lgr(struct smc_link *lnk);
+int smcr_buf_reg_lgr(struct smc_link *lnk);
 int smcr_link_reg_rmb(struct smc_link *link, struct smc_buf_desc *rmb_desc);
 static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
 {
-- 
2.17.1

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64192 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727863AbgKGNAS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 7 Nov 2020 08:00:18 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v3 06/15] net/smc: Add diagnostic information to link structure
Date: Sat,  7 Nov 2020 13:59:49 +0100
Message-Id: <20201107125958.16384-7-kgraul@linux.ibm.com>
In-Reply-To: <20201107125958.16384-1-kgraul@linux.ibm.com>
References: <20201107125958.16384-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

During link creation add network and ib-device name to
link structure. This is needed for diagnostic purposes.

When diagnostic information is gathered, we need to traverse
device, linkgroup and link structures, to be able to do that
we need to hold a spinlock for the linkgroup list, without this
diagnostic information in link structure, another device list
mutex holding would be necessary to dereference the device
pointer in the link structure which would be impossible when
holding a spinlock already.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 11 +++++++++++
 net/smc/smc_core.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index e5996cf5dd3d..ef0aae43a209 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -303,6 +303,16 @@ static u8 smcr_next_link_id(struct smc_link_group *lgr)
 	return link_id;
 }
 
+static inline void smcr_copy_dev_info_to_link(struct smc_link *link)
+{
+	struct smc_ib_device *smcibdev = link->smcibdev;
+
+	snprintf(link->ibname, sizeof(link->ibname), "%s",
+		 smcibdev->ibdev->name);
+	snprintf(link->ndevname, sizeof(link->ndevname), "%s",
+		 smcibdev->netdev[link->ibport - 1]);
+}
+
 int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 		   u8 link_idx, struct smc_init_info *ini)
 {
@@ -317,6 +327,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	lnk->smcibdev = ini->ib_dev;
 	lnk->ibport = ini->ib_port;
 	smc_ibdev_cnt_inc(lnk);
+	smcr_copy_dev_info_to_link(lnk);
 	lnk->path_mtu = ini->ib_dev->pattr[ini->ib_port - 1].active_mtu;
 	atomic_set(&lnk->conn_cnt, 0);
 	smc_llc_link_set_uid(lnk);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 4cf8e811940d..a6ba9cc8c60e 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -124,6 +124,9 @@ struct smc_link {
 	u8			link_is_asym;	/* is link asymmetric? */
 	struct smc_link_group	*lgr;		/* parent link group */
 	struct work_struct	link_down_wrk;	/* wrk to bring link down */
+	/* Diagnostic relevant link information */
+	char			ibname[IB_DEVICE_NAME_MAX];/* ib device name */
+	char			ndevname[IFNAMSIZ];/* network device name */
 
 	enum smc_link_state	state;		/* state of link */
 	struct delayed_work	llc_testlink_wrk; /* testlink worker */
-- 
2.17.1

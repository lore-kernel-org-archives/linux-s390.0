Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404089AbgKXRvO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 12:51:14 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v5 06/14] net/smc: Add diagnostic information to link structure
Date: Tue, 24 Nov 2020 18:50:39 +0100
Message-Id: <20201124175047.56949-7-kgraul@linux.ibm.com>
In-Reply-To: <20201124175047.56949-1-kgraul@linux.ibm.com>
References: <20201124175047.56949-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

From: Guvenc Gulce <guvenc@linux.ibm.com>

During link creation add net-device ifindex and ib-device
name to link structure. This is needed for diagnostic purposes.

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
 net/smc/smc_core.c | 10 ++++++++++
 net/smc/smc_core.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 46087cec3bcd..0088511e30bf 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -313,6 +313,15 @@ static u8 smcr_next_link_id(struct smc_link_group *lgr)
 	return link_id;
 }
 
+static void smcr_copy_dev_info_to_link(struct smc_link *link)
+{
+	struct smc_ib_device *smcibdev = link->smcibdev;
+
+	snprintf(link->ibname, sizeof(link->ibname), "%s",
+		 smcibdev->ibdev->name);
+	link->ndev_ifidx = smcibdev->ndev_ifidx[link->ibport - 1];
+}
+
 int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 		   u8 link_idx, struct smc_init_info *ini)
 {
@@ -327,6 +336,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	lnk->smcibdev = ini->ib_dev;
 	lnk->ibport = ini->ib_port;
 	smc_ibdev_cnt_inc(lnk);
+	smcr_copy_dev_info_to_link(lnk);
 	lnk->path_mtu = ini->ib_dev->pattr[ini->ib_port - 1].active_mtu;
 	atomic_set(&lnk->conn_cnt, 0);
 	smc_llc_link_set_uid(lnk);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index eefb6770b268..3a1bb8e4b81f 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -124,6 +124,8 @@ struct smc_link {
 	u8			link_is_asym;	/* is link asymmetric? */
 	struct smc_link_group	*lgr;		/* parent link group */
 	struct work_struct	link_down_wrk;	/* wrk to bring link down */
+	char			ibname[IB_DEVICE_NAME_MAX]; /* ib device name */
+	int			ndev_ifidx; /* network device ifindex */
 
 	enum smc_link_state	state;		/* state of link */
 	struct delayed_work	llc_testlink_wrk; /* testlink worker */
-- 
2.17.1

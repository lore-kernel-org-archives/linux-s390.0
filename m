Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726956AbgIZKox (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Sep 2020 06:44:53 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 07/14] net/smc: introduce CHID callback for ISM devices
Date: Sat, 26 Sep 2020 12:44:25 +0200
Message-Id: <20200926104432.74293-8-kgraul@linux.ibm.com>
In-Reply-To: <20200926104432.74293-1-kgraul@linux.ibm.com>
References: <20200926104432.74293-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

With SMCD version 2 the CHIDs of ISM devices are needed for the
CLC handshake.
This patch provides the new callback to retrieve the CHID of an
ISM device.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 12 ++++++++++++
 include/net/smc.h          |  1 +
 net/smc/af_smc.c           |  2 ++
 net/smc/smc_core.h         |  1 +
 net/smc/smc_ism.c          |  5 +++++
 net/smc/smc_ism.h          |  1 +
 6 files changed, 22 insertions(+)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index c452ea5d9c8a..fe96ca3c88a5 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -414,6 +414,17 @@ static void ism_get_system_eid(struct smcd_dev *smcd, u8 **eid)
 	*eid = &SYSTEM_EID.seid_string[0];
 }
 
+static u16 ism_get_chid(struct smcd_dev *smcd)
+{
+	struct ism_dev *ismdev;
+
+	ismdev = (struct ism_dev *)smcd->priv;
+	if (!ismdev || !ismdev->pdev)
+		return 0;
+
+	return to_zpci(ismdev->pdev)->pchid;
+}
+
 static void ism_handle_event(struct ism_dev *ism)
 {
 	struct smcd_event *entry;
@@ -471,6 +482,7 @@ static const struct smcd_ops ism_ops = {
 	.signal_event = ism_signal_ieq,
 	.move_data = ism_move,
 	.get_system_eid = ism_get_system_eid,
+	.get_chid = ism_get_chid,
 };
 
 static int ism_dev_init(struct ism_dev *ism)
diff --git a/include/net/smc.h b/include/net/smc.h
index b28b384d0625..e441aa97ad61 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -66,6 +66,7 @@ struct smcd_ops {
 			 bool sf, unsigned int offset, void *data,
 			 unsigned int size);
 	void (*get_system_eid)(struct smcd_dev *dev, u8 **eid);
+	u16 (*get_chid)(struct smcd_dev *dev);
 };
 
 struct smcd_dev {
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8c1cde36adb8..f02ed74a28e6 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -566,6 +566,8 @@ static int smc_find_ism_device(struct smc_sock *smc, struct smc_init_info *ini)
 	smc_pnet_find_ism_resource(smc->clcsock->sk, ini);
 	if (!ini->ism_dev[0])
 		return SMC_CLC_DECL_NOSMCDDEV;
+	else
+		ini->ism_chid[0] = smc_ism_get_chid(ini->ism_dev[0]);
 	return 0;
 }
 
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index ec86084b0dfd..d33bcbc3238f 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -303,6 +303,7 @@ struct smc_init_info {
 	/* SMC-D */
 	u64			ism_peer_gid[SMC_MAX_ISM_DEVS + 1];
 	struct smcd_dev		*ism_dev[SMC_MAX_ISM_DEVS + 1];
+	u16			ism_chid[SMC_MAX_ISM_DEVS + 1];
 };
 
 /* Find the connection associated with the given alert token in the link group.
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 63c3dd5578bf..c5a5b70251b6 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -46,6 +46,11 @@ void smc_ism_get_system_eid(struct smcd_dev *smcd, u8 **eid)
 	smcd->ops->get_system_eid(smcd, eid);
 }
 
+u16 smc_ism_get_chid(struct smcd_dev *smcd)
+{
+	return smcd->ops->get_chid(smcd);
+}
+
 /* Set a connection using this DMBE. */
 void smc_ism_set_conn(struct smc_connection *conn)
 {
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 816d86361e1a..8048e09ddcf8 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -51,5 +51,6 @@ int smc_ism_write(struct smcd_dev *dev, const struct smc_ism_position *pos,
 		  void *data, size_t len);
 int smc_ism_signal_shutdown(struct smc_link_group *lgr);
 void smc_ism_get_system_eid(struct smcd_dev *dev, u8 **eid);
+u16 smc_ism_get_chid(struct smcd_dev *dev);
 void smc_ism_init(void);
 #endif
-- 
2.17.1

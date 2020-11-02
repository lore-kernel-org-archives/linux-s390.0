Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbgKBTed (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 14:34:33 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 05/15] net/smc: Add diagnostic information to smc ib-device
Date: Mon,  2 Nov 2020 20:33:59 +0100
Message-Id: <20201102193409.70901-6-kgraul@linux.ibm.com>
In-Reply-To: <20201102193409.70901-1-kgraul@linux.ibm.com>
References: <20201102193409.70901-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

During smc ib-device creation, add network device name to smc
ib-device structure. Register for netdevice name changes and
update ib-device accordingly. This is needed for diagnostic purposes.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_ib.c   | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_ib.h   |  2 ++
 net/smc/smc_pnet.c |  3 +++
 3 files changed, 52 insertions(+)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 1c314dbdc7fa..c4a04e868bf0 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -557,6 +557,52 @@ static void smc_ib_cleanup_per_ibdev(struct smc_ib_device *smcibdev)
 
 static struct ib_client smc_ib_client;
 
+static void smc_copy_netdev_name(struct smc_ib_device *smcibdev, int port)
+{
+	struct ib_device *ibdev = smcibdev->ibdev;
+	struct net_device *ndev;
+
+	if (ibdev->ops.get_netdev) {
+		ndev = ibdev->ops.get_netdev(ibdev, port + 1);
+		if (ndev) {
+			snprintf((char *)&smcibdev->netdev[port],
+				 sizeof(smcibdev->netdev[port]),
+				 "%s", ndev->name);
+			dev_put(ndev);
+		}
+	}
+}
+
+void smc_ib_ndev_name_change(struct net_device *ndev)
+{
+	struct smc_ib_device *smcibdev;
+	struct ib_device *libdev;
+	struct net_device *lndev;
+	u8 port_cnt;
+	int i;
+
+	mutex_lock(&smc_ib_devices.mutex);
+	list_for_each_entry(smcibdev, &smc_ib_devices.list, list) {
+		port_cnt = smcibdev->ibdev->phys_port_cnt;
+		for (i = 0;
+		     i < min_t(size_t, port_cnt, SMC_MAX_PORTS);
+		     i++) {
+			libdev = smcibdev->ibdev;
+			if (libdev->ops.get_netdev) {
+				lndev = libdev->ops.get_netdev(libdev, i + 1);
+				if (lndev)
+					dev_put(lndev);
+				if (lndev == ndev) {
+					snprintf((char *)&smcibdev->netdev[i],
+						 sizeof(smcibdev->netdev[i]),
+						 "%s", ndev->name);
+				}
+			}
+		}
+	}
+	mutex_unlock(&smc_ib_devices.mutex);
+}
+
 /* callback function for ib_register_client() */
 static int smc_ib_add_dev(struct ib_device *ibdev)
 {
@@ -596,6 +642,7 @@ static int smc_ib_add_dev(struct ib_device *ibdev)
 		if (smc_pnetid_by_dev_port(ibdev->dev.parent, i,
 					   smcibdev->pnetid[i]))
 			smc_pnetid_by_table_ib(smcibdev, i + 1);
+		smc_copy_netdev_name(smcibdev, i);
 		pr_warn_ratelimited("smc:    ib device %s port %d has pnetid "
 				    "%.16s%s\n",
 				    smcibdev->ibdev->name, i + 1,
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index 3e6bfeddd53b..b0868146b46b 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -54,11 +54,13 @@ struct smc_ib_device {				/* ib-device infos for smc */
 	wait_queue_head_t	lnks_deleted;	/* wait 4 removal of all links*/
 	struct mutex		mutex;		/* protect dev setup+cleanup */
 	atomic_t		lnk_cnt_by_port[SMC_MAX_PORTS];/*#lnk per port*/
+	u8			netdev[SMC_MAX_PORTS][IFNAMSIZ];/* ndev names */
 };
 
 struct smc_buf_desc;
 struct smc_link;
 
+void smc_ib_ndev_name_change(struct net_device *ndev);
 int smc_ib_register_client(void) __init;
 void smc_ib_unregister_client(void);
 bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport);
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index f3c18b991d35..b0f40d73afd6 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -828,6 +828,9 @@ static int smc_pnet_netdev_event(struct notifier_block *this,
 	case NETDEV_UNREGISTER:
 		smc_pnet_remove_by_ndev(event_dev);
 		return NOTIFY_OK;
+	case NETDEV_CHANGENAME:
+		smc_ib_ndev_name_change(event_dev);
+		return NOTIFY_OK;
 	case NETDEV_REGISTER:
 		smc_pnet_add_by_ndev(event_dev);
 		return NOTIFY_OK;
-- 
2.17.1

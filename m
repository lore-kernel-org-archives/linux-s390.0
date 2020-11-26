Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390892AbgKZUjc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 15:39:32 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v6 05/14] net/smc: Add diagnostic information to smc ib-device
Date: Thu, 26 Nov 2020 21:39:07 +0100
Message-Id: <20201126203916.56071-6-kgraul@linux.ibm.com>
In-Reply-To: <20201126203916.56071-1-kgraul@linux.ibm.com>
References: <20201126203916.56071-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

From: Guvenc Gulce <guvenc@linux.ibm.com>

During smc ib-device creation, add network device ifindex to smc
ib-device structure. Register for netdevice changes and update ib-device
accordingly. This is needed for diagnostic purposes.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_ib.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_ib.h   |  2 ++
 net/smc/smc_pnet.c |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index fc766b537ac7..61b025c912a9 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -557,6 +557,49 @@ static void smc_ib_cleanup_per_ibdev(struct smc_ib_device *smcibdev)
 
 static struct ib_client smc_ib_client;
 
+static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
+{
+	struct ib_device *ibdev = smcibdev->ibdev;
+	struct net_device *ndev;
+
+	if (!ibdev->ops.get_netdev)
+		return;
+	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
+	if (ndev) {
+		smcibdev->ndev_ifidx[port] = ndev->ifindex;
+		dev_put(ndev);
+	}
+}
+
+void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
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
+		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
+			libdev = smcibdev->ibdev;
+			if (!libdev->ops.get_netdev)
+				continue;
+			lndev = libdev->ops.get_netdev(libdev, i + 1);
+			if (lndev)
+				dev_put(lndev);
+			if (lndev != ndev)
+				continue;
+			if (event == NETDEV_REGISTER)
+				smcibdev->ndev_ifidx[i] = ndev->ifindex;
+			if (event == NETDEV_UNREGISTER)
+				smcibdev->ndev_ifidx[i] = 0;
+		}
+	}
+	mutex_unlock(&smc_ib_devices.mutex);
+}
+
 /* callback function for ib_register_client() */
 static int smc_ib_add_dev(struct ib_device *ibdev)
 {
@@ -596,6 +639,7 @@ static int smc_ib_add_dev(struct ib_device *ibdev)
 		if (smc_pnetid_by_dev_port(ibdev->dev.parent, i,
 					   smcibdev->pnetid[i]))
 			smc_pnetid_by_table_ib(smcibdev, i + 1);
+		smc_copy_netdev_ifindex(smcibdev, i);
 		pr_warn_ratelimited("smc:    ib device %s port %d has pnetid "
 				    "%.16s%s\n",
 				    smcibdev->ibdev->name, i + 1,
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index 3b85360a473b..ab37da341fa8 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -55,11 +55,13 @@ struct smc_ib_device {				/* ib-device infos for smc */
 	struct mutex		mutex;		/* protect dev setup+cleanup */
 	atomic_t		lnk_cnt_by_port[SMC_MAX_PORTS];
 						/* number of links per port */
+	int			ndev_ifidx[SMC_MAX_PORTS]; /* ndev if indexes */
 };
 
 struct smc_buf_desc;
 struct smc_link;
 
+void smc_ib_ndev_change(struct net_device *ndev, unsigned long event);
 int smc_ib_register_client(void) __init;
 void smc_ib_unregister_client(void);
 bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport);
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index f3c18b991d35..6f6d33edb135 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -827,9 +827,11 @@ static int smc_pnet_netdev_event(struct notifier_block *this,
 	case NETDEV_REBOOT:
 	case NETDEV_UNREGISTER:
 		smc_pnet_remove_by_ndev(event_dev);
+		smc_ib_ndev_change(event_dev, event);
 		return NOTIFY_OK;
 	case NETDEV_REGISTER:
 		smc_pnet_add_by_ndev(event_dev);
+		smc_ib_ndev_change(event_dev, event);
 		return NOTIFY_OK;
 	case NETDEV_UP:
 		smc_pnet_add_base_pnetid(net, event_dev, ndev_pnetid);
-- 
2.17.1

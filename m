Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731915AbgKIPS1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Nov 2020 10:18:27 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v4 13/15] net/smc: Add support for obtaining SMCR device list
Date: Mon,  9 Nov 2020 16:18:12 +0100
Message-Id: <20201109151814.15040-14-kgraul@linux.ibm.com>
In-Reply-To: <20201109151814.15040-1-kgraul@linux.ibm.com>
References: <20201109151814.15040-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

Deliver SMCR device information via netlink based
diagnostic interface.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/uapi/linux/smc_diag.h |   6 ++
 net/smc/smc_core.c            |   7 ++
 net/smc/smc_core.h            |   2 +
 net/smc/smc_diag.c            | 133 ++++++++++++++++++++++++++++++++++
 4 files changed, 148 insertions(+)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index ab8f76bdd1a4..4c6332785533 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -88,6 +88,7 @@ enum {
 /* SMC_DIAG_GET_DEV_INFO command extensions */
 enum {
 	SMC_DIAG_DEV_INFO_SMCD = 1,
+	SMC_DIAG_DEV_INFO_SMCR,
 };
 
 #define SMC_DIAG_MAX (__SMC_DIAG_MAX - 1)
@@ -182,6 +183,11 @@ struct smc_diag_dev_info {
 	__u16		pci_vendor;		/* PCI Vendor */
 	__u16		pci_device;		/* PCI Device Vendor ID */
 	__u8		pci_id[SMC_PCI_ID_STR_LEN]; /* PCI ID */
+	__u8		dev_name[IB_DEVICE_NAME_MAX]; /* IB Device name */
+	__u8		netdev[SMC_MAX_PORTS][IFNAMSIZ]; /* Netdev name(s) */
+	__u8		port_state[SMC_MAX_PORTS]; /* IB Port State */
+	__u8		port_valid[SMC_MAX_PORTS]; /* Is IB Port valid */
+	__u32		lnk_cnt_by_port[SMC_MAX_PORTS]; /* # lnks per port */
 };
 
 struct smc_diag_lgr {
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 37cc754485f0..f23f8f1d10d8 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -214,6 +214,11 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 	conn->lgr = NULL;
 }
 
+static struct smc_ib_devices *smc_get_smc_ib_devices(void)
+{
+	return &smc_ib_devices;
+}
+
 static struct smcd_dev_list *smc_get_smcd_dev_list(void)
 {
 	return &smcd_dev_list;
@@ -228,6 +233,8 @@ static const struct smc_diag_ops smc_diag_ops = {
 	.get_lgr_list		= smc_get_lgr_list,
 	.get_smcd_devices	= smc_get_smcd_dev_list,
 	.get_chid		= smc_ism_get_chid,
+	.get_ib_devices		= smc_get_smc_ib_devices,
+	.is_ib_port_active	= smc_ib_port_active,
 };
 
 const struct smc_diag_ops *smc_get_diag_ops(void)
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index eec19a8e394c..6bf89bfe34bd 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -25,6 +25,8 @@ struct smc_diag_ops {
 	struct smc_lgr_list *(*get_lgr_list)(void);
 	struct smcd_dev_list *(*get_smcd_devices)(void);
 	u16 (*get_chid)(struct smcd_dev *smcd);
+	struct smc_ib_devices *(*get_ib_devices)(void);
+	bool (*is_ib_port_active)(struct smc_ib_device *smcibdev, u8 ibport);
 };
 
 struct smc_lgr_list {			/* list of link group definition */
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 6e7798dc57fb..3d5151919326 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -386,6 +386,33 @@ static int smc_diag_handle_lgr(struct smc_link_group *lgr,
 	return rc;
 }
 
+static bool smcr_diag_is_dev_critical(struct smc_lgr_list *smc_lgr,
+				      struct smc_ib_device *smcibdev)
+{
+	struct smc_link_group *lgr;
+	bool rc = false;
+	int i;
+
+	spin_lock_bh(&smc_lgr->lock);
+	list_for_each_entry(lgr, &smc_lgr->list, list) {
+		if (lgr->is_smcd)
+			continue;
+		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+			if (lgr->lnk[i].state == SMC_LNK_UNUSED ||
+			    lgr->lnk[i].smcibdev != smcibdev)
+				continue;
+			if (lgr->type == SMC_LGR_SINGLE ||
+			    lgr->type == SMC_LGR_ASYMMETRIC_LOCAL) {
+				rc = true;
+				goto out;
+			}
+		}
+	}
+out:
+	spin_unlock_bh(&smc_lgr->lock);
+	return rc;
+}
+
 static int smc_diag_fill_lgr_list(struct smc_lgr_list *smc_lgr,
 				  struct sk_buff *skb,
 				  struct netlink_callback *cb,
@@ -541,6 +568,109 @@ static int smc_diag_prep_smcd_dev(struct smcd_dev_list *dev_list,
 	return rc;
 }
 
+static void smc_diag_handle_dev_port(struct smc_diag_dev_info *smc_diag_dev,
+				     struct ib_device *ibdev,
+				     struct smc_ib_device *smcibdev,
+				     int port)
+{
+	unsigned char port_state;
+
+	smc_diag_dev->port_valid[port] = 1;
+	snprintf((char *)&smc_diag_dev->netdev[port],
+		 sizeof(smc_diag_dev->netdev[port]),
+		 "%s", (char *)&smcibdev->netdev[port]);
+	snprintf((char *)&smc_diag_dev->pnet_id[port],
+		 sizeof(smc_diag_dev->pnet_id[port]), "%s",
+		 (char *)&smcibdev->pnetid[port]);
+	smc_diag_dev->pnetid_by_user[port] = smcibdev->pnetid_by_user[port];
+	port_state = smc_diag_ops->is_ib_port_active(smcibdev, port + 1);
+	smc_diag_dev->port_state[port] = port_state;
+	smc_diag_dev->lnk_cnt_by_port[port] =
+			atomic_read(&smcibdev->lnk_cnt_by_port[port]);
+}
+
+static int smc_diag_handle_smcr_dev(struct smc_ib_device *smcibdev,
+				    struct sk_buff *skb,
+				    struct netlink_callback *cb,
+				    struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_dev_info smc_dev;
+	struct smc_pci_dev smc_pci_dev;
+	struct pci_dev *pci_dev;
+	unsigned char is_crit;
+	struct nlmsghdr *nlh;
+	int dummy = 0;
+	int i, rc = 0;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, MAGIC_SEQ_V2_ACK,
+			cb->nlh->nlmsg_type, 0, NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	memset(&smc_dev, 0, sizeof(smc_dev));
+	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
+	for (i = 1; i <= SMC_MAX_PORTS; i++) {
+		if (rdma_is_port_valid(smcibdev->ibdev, i)) {
+			smc_diag_handle_dev_port(&smc_dev, smcibdev->ibdev,
+						 smcibdev, i - 1);
+		}
+	}
+	pci_dev = to_pci_dev(smcibdev->ibdev->dev.parent);
+	smc_set_pci_values(pci_dev, &smc_pci_dev);
+	smc_dev.pci_device = smc_pci_dev.pci_device;
+	smc_dev.pci_fid = smc_pci_dev.pci_fid;
+	smc_dev.pci_pchid = smc_pci_dev.pci_pchid;
+	smc_dev.pci_vendor = smc_pci_dev.pci_vendor;
+	snprintf(smc_dev.pci_id, sizeof(smc_dev.pci_id), "%s",
+		 smc_pci_dev.pci_id);
+	snprintf(smc_dev.dev_name, sizeof(smc_dev.dev_name),
+		 "%s", smcibdev->ibdev->name);
+	is_crit = smcr_diag_is_dev_critical(smc_diag_ops->get_lgr_list(),
+					    smcibdev);
+	smc_dev.is_critical = is_crit;
+
+	/* Just a command place holder to signal back the command reply type */
+	if (nla_put(skb, SMC_DIAG_GET_DEV_INFO, sizeof(dummy), &dummy) < 0)
+		goto errout;
+
+	if (nla_put(skb, SMC_DIAG_DEV_INFO_SMCR,
+		    sizeof(smc_dev), &smc_dev) < 0)
+		goto errout;
+
+	nlmsg_end(skb, nlh);
+	return rc;
+
+errout:
+	nlmsg_cancel(skb, nlh);
+	return -EMSGSIZE;
+}
+
+static int smc_diag_prep_smcr_dev(struct smc_ib_devices *dev_list,
+				  struct sk_buff *skb,
+				  struct netlink_callback *cb,
+				  struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
+	struct smc_ib_device *smcibdev;
+	int snum = cb_ctx->pos[0];
+	int rc = 0, num = 0;
+
+	mutex_lock(&dev_list->mutex);
+	list_for_each_entry(smcibdev, &dev_list->list, list) {
+		if (num < snum)
+			goto next;
+		rc = smc_diag_handle_smcr_dev(smcibdev, skb, cb, req);
+		if (rc < 0)
+			goto out;
+next:
+		num++;
+	}
+out:
+	mutex_unlock(&dev_list->mutex);
+	cb_ctx->pos[0] = num;
+	return rc;
+}
+
 static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 			   struct netlink_callback *cb,
 			   const struct smc_diag_req *req)
@@ -646,6 +776,9 @@ static int smc_diag_dump_ext(struct sk_buff *skb, struct netlink_callback *cb)
 		if ((req->cmd_ext & (1 << (SMC_DIAG_DEV_INFO_SMCD - 1))))
 			smc_diag_prep_smcd_dev(smc_diag_ops->get_smcd_devices(),
 					       skb, cb, req);
+		if ((req->cmd_ext & (1 << (SMC_DIAG_DEV_INFO_SMCR - 1))))
+			smc_diag_prep_smcr_dev(smc_diag_ops->get_ib_devices(),
+					       skb, cb, req);
 	}
 
 	return skb->len;
-- 
2.17.1

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727950AbgKGNAT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 7 Nov 2020 08:00:19 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v3 12/15] net/smc: Add support for obtaining SMCD device list
Date: Sat,  7 Nov 2020 13:59:55 +0100
Message-Id: <20201107125958.16384-13-kgraul@linux.ibm.com>
In-Reply-To: <20201107125958.16384-1-kgraul@linux.ibm.com>
References: <20201107125958.16384-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

Deliver SMCD device information via netlink based
diagnostic interface.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/uapi/linux/smc.h      |  2 +
 include/uapi/linux/smc_diag.h | 20 +++++++++
 net/smc/smc_core.h            | 27 +++++++++++++
 net/smc/smc_diag.c            | 76 +++++++++++++++++++++++++++++++++++
 net/smc/smc_ib.h              |  1 -
 5 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index 635e2c2aeac5..736e8b98c8a5 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -38,4 +38,6 @@ enum {				/* SMC PNET Table commands */
 #define SMC_LGR_ID_SIZE			4
 #define SMC_MAX_HOSTNAME_LEN		32 /* Max length of hostname */
 #define SMC_MAX_EID_LEN			32 /* Max length of eid */
+#define SMC_MAX_PORTS			2 /* Max # of ports per ib device */
+#define SMC_PCI_ID_STR_LEN		16 /* Max length of pci id string */
 #endif /* _UAPI_LINUX_SMC_H */
diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 5a80172df757..ab8f76bdd1a4 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -74,6 +74,7 @@ enum {
 /* V2 Commands */
 enum {
 	SMC_DIAG_GET_LGR_INFO = SMC_DIAG_EXTS_PER_CMD,
+	SMC_DIAG_GET_DEV_INFO,
 	__SMC_DIAG_EXT_MAX,
 };
 
@@ -84,6 +85,11 @@ enum {
 	SMC_DIAG_LGR_INFO_SMCD,
 };
 
+/* SMC_DIAG_GET_DEV_INFO command extensions */
+enum {
+	SMC_DIAG_DEV_INFO_SMCD = 1,
+};
+
 #define SMC_DIAG_MAX (__SMC_DIAG_MAX - 1)
 #define SMC_DIAG_EXT_MAX (__SMC_DIAG_EXT_MAX - 1)
 
@@ -164,6 +170,20 @@ struct smcd_diag_dmbinfo {		/* SMC-D Socket internals */
 	struct smc_diag_v2_lgr_info v2_lgr_info; /* SMCv2 info */
 };
 
+struct smc_diag_dev_info {
+	/* Pnet ID per device port */
+	__u8		pnet_id[SMC_MAX_PORTS][SMC_MAX_PNETID_LEN];
+	/* whether pnetid is set by user */
+	__u8		pnetid_by_user[SMC_MAX_PORTS];
+	__u32		use_cnt;		/* Number of linkgroups */
+	__u8		is_critical;		/* Is device critical */
+	__u32		pci_fid;		/* PCI FID */
+	__u16		pci_pchid;		/* PCI CHID */
+	__u16		pci_vendor;		/* PCI Vendor */
+	__u16		pci_device;		/* PCI Device Vendor ID */
+	__u8		pci_id[SMC_PCI_ID_STR_LEN]; /* PCI ID */
+};
+
 struct smc_diag_lgr {
 	__u8		lgr_id[SMC_LGR_ID_SIZE]; /* Linkgroup identifier */
 	__u8		lgr_role;		/* Linkgroup role */
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index a705a67d6a39..19680fc6aeeb 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -13,6 +13,7 @@
 #define _SMC_CORE_H
 
 #include <linux/atomic.h>
+#include <linux/pci.h>
 #include <rdma/ib_verbs.h>
 
 #include "smc.h"
@@ -383,6 +384,32 @@ static inline void smc_ibdev_cnt_dec(struct smc_link *lnk)
 	atomic_dec(&lnk->smcibdev->lnk_cnt_by_port[lnk->ibport - 1]);
 }
 
+struct smc_pci_dev {
+	__u32		pci_fid;
+	__u16		pci_pchid;
+	__u16		pci_vendor;
+	__u16		pci_device;
+	__u8		pci_id[SMC_PCI_ID_STR_LEN];
+};
+
+static inline void smc_set_pci_values(struct pci_dev *pci_dev,
+				      struct smc_pci_dev *smc_dev)
+{
+	smc_dev->pci_vendor = pci_dev->vendor;
+	smc_dev->pci_device = pci_dev->device;
+	snprintf(smc_dev->pci_id, sizeof(smc_dev->pci_id), "%s",
+		 pci_name(pci_dev));
+#if IS_ENABLED(CONFIG_S390)
+	{
+	struct zpci_dev *zdev;
+
+	zdev = to_zpci(pci_dev);
+	smc_dev->pci_fid = zdev->fid;
+	smc_dev->pci_pchid = zdev->pchid;
+	}
+#endif
+}
+
 struct smc_sock;
 struct smc_clc_msg_accept_confirm;
 struct smc_clc_msg_local;
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index a644e2299dbc..69e2a6a2b657 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -450,6 +450,78 @@ static int smc_diag_fill_smcd_dev(struct smcd_dev_list *dev_list,
 	return rc;
 }
 
+static int smc_diag_handle_smcd_dev(struct smcd_dev *smcd,
+				    struct sk_buff *skb,
+				    struct netlink_callback *cb,
+				    struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_dev_info smc_diag_dev;
+	struct smc_pci_dev smc_pci_dev;
+	struct nlmsghdr *nlh;
+	int dummy = 0;
+	int rc = 0;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, MAGIC_SEQ_V2_ACK,
+			cb->nlh->nlmsg_type, 0, NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	memset(&smc_diag_dev, 0, sizeof(smc_diag_dev));
+	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
+	smc_diag_dev.use_cnt = atomic_read(&smcd->lgr_cnt);
+	smc_diag_dev.is_critical = (smc_diag_dev.use_cnt > 0);
+	smc_diag_dev.pnetid_by_user[0] = smcd->pnetid_by_user;
+	smc_set_pci_values(to_pci_dev(smcd->dev.parent), &smc_pci_dev);
+	smc_diag_dev.pci_device = smc_pci_dev.pci_device;
+	smc_diag_dev.pci_fid = smc_pci_dev.pci_fid;
+	smc_diag_dev.pci_pchid = smc_pci_dev.pci_pchid;
+	smc_diag_dev.pci_vendor = smc_pci_dev.pci_vendor;
+	snprintf(smc_diag_dev.pci_id, sizeof(smc_diag_dev.pci_id), "%s",
+		 smc_pci_dev.pci_id);
+	snprintf((char *)&smc_diag_dev.pnet_id[0],
+		 sizeof(smc_diag_dev.pnet_id[0]), "%s", smcd->pnetid);
+	/* Just a command place holder to signal back the command reply type */
+	if (nla_put(skb, SMC_DIAG_GET_DEV_INFO, sizeof(dummy), &dummy) < 0)
+		goto errout;
+
+	if (nla_put(skb, SMC_DIAG_DEV_INFO_SMCD,
+		    sizeof(smc_diag_dev), &smc_diag_dev) < 0)
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
+static int smc_diag_prep_smcd_dev(struct smcd_dev_list *dev_list,
+				  struct sk_buff *skb,
+				  struct netlink_callback *cb,
+				  struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
+	int snum = cb_ctx->pos[0];
+	struct smcd_dev *smcd;
+	int rc = 0, num = 0;
+
+	mutex_lock(&dev_list->mutex);
+	list_for_each_entry(smcd, &dev_list->list, list) {
+		if (num < snum)
+			goto next;
+		rc = smc_diag_handle_smcd_dev(smcd, skb, cb, req);
+		if (rc < 0)
+			goto errout;
+next:
+		num++;
+	}
+errout:
+	mutex_unlock(&dev_list->mutex);
+	cb_ctx->pos[0] = num;
+	return rc;
+}
+
 static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 			   struct netlink_callback *cb,
 			   const struct smc_diag_req *req)
@@ -551,6 +623,10 @@ static int smc_diag_dump_ext(struct sk_buff *skb, struct netlink_callback *cb)
 		if ((req->cmd_ext & (1 << (SMC_DIAG_LGR_INFO_SMCD - 1))))
 			smc_diag_fill_smcd_dev(smc_diag_ops->get_smcd_devices(),
 					       skb, cb, req);
+	} else if (req->cmd == SMC_DIAG_GET_DEV_INFO) {
+		if ((req->cmd_ext & (1 << (SMC_DIAG_DEV_INFO_SMCD - 1))))
+			smc_diag_prep_smcd_dev(smc_diag_ops->get_smcd_devices(),
+					       skb, cb, req);
 	}
 
 	return skb->len;
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index 5319496adea0..e36c935bc1ec 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -19,7 +19,6 @@
 #include <rdma/ib_verbs.h>
 #include <net/smc.h>
 
-#define SMC_MAX_PORTS			2	/* Max # of ports */
 #define SMC_GID_SIZE			sizeof(union ib_gid)
 
 #define SMC_IB_MAX_SEND_SGE		2
-- 
2.17.1

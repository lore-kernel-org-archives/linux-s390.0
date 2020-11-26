Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390856AbgKZUjf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 15:39:35 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v6 13/14] net/smc: Add support for obtaining SMCD device list
Date: Thu, 26 Nov 2020 21:39:15 +0100
Message-Id: <20201126203916.56071-14-kgraul@linux.ibm.com>
In-Reply-To: <20201126203916.56071-1-kgraul@linux.ibm.com>
References: <20201126203916.56071-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

From: Guvenc Gulce <guvenc@linux.ibm.com>

Deliver SMCD device information via netlink based
diagnostic interface.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/uapi/linux/smc.h | 28 +++++++++++++
 net/smc/smc_core.h       | 28 +++++++++++++
 net/smc/smc_ism.c        | 91 ++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_ism.h        |  1 +
 net/smc/smc_netlink.c    |  6 +++
 5 files changed, 154 insertions(+)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index 707e8af4f0c8..3cb40ab049d9 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -37,12 +37,15 @@ enum {				/* SMC PNET Table commands */
 #define SMC_GENL_FAMILY_NAME		"SMC_GEN_NETLINK"
 #define SMC_GENL_FAMILY_VERSION		1
 
+#define SMC_PCI_ID_STR_LEN		16 /* Max length of pci id string */
+
 /* SMC_GENL_FAMILY commands */
 enum {
 	SMC_NETLINK_GET_SYS_INFO = 1,
 	SMC_NETLINK_GET_LGR_SMCR,
 	SMC_NETLINK_GET_LINK_SMCR,
 	SMC_NETLINK_GET_LGR_SMCD,
+	SMC_NETLINK_GET_DEV_SMCD,
 };
 
 /* SMC_GENL_FAMILY top level attributes */
@@ -52,6 +55,7 @@ enum {
 	SMC_GEN_LGR_SMCR,		/* nest */
 	SMC_GEN_LINK_SMCR,		/* nest */
 	SMC_GEN_LGR_SMCD,		/* nest */
+	SMC_GEN_DEV_SMCD,		/* nest */
 	__SMC_GEN_MAX,
 	SMC_GEN_MAX = __SMC_GEN_MAX - 1
 };
@@ -122,4 +126,28 @@ enum {
 	__SMC_NLA_LGR_D_MAX,
 	SMC_NLA_LGR_D_MAX = __SMC_NLA_LGR_D_MAX - 1
 };
+
+/* SMC_NLA_DEV_PORT attributes */
+enum {
+	SMC_NLA_DEV_PORT_UNSPEC,
+	SMC_NLA_DEV_PORT_PNET_USR,	/* u8 */
+	SMC_NLA_DEV_PORT_PNETID,	/* string */
+	__SMC_NLA_DEV_PORT_MAX,
+	SMC_NLA_DEV_PORT_MAX = __SMC_NLA_DEV_PORT_MAX - 1
+};
+
+/* SMC_GEN_DEV_SMCD attributes */
+enum {
+	SMC_NLA_DEV_UNSPEC,
+	SMC_NLA_DEV_USE_CNT,		/* u32 */
+	SMC_NLA_DEV_IS_CRIT,		/* u8 */
+	SMC_NLA_DEV_PCI_FID,		/* u32 */
+	SMC_NLA_DEV_PCI_CHID,		/* u16 */
+	SMC_NLA_DEV_PCI_VENDOR,		/* u16 */
+	SMC_NLA_DEV_PCI_DEVICE,		/* u16 */
+	SMC_NLA_DEV_PCI_ID,		/* string */
+	SMC_NLA_DEV_PORT,		/* nest */
+	__SMC_NLA_DEV_MAX,
+	SMC_NLA_DEV_MAX = __SMC_NLA_DEV_MAX - 1
+};
 #endif /* _UAPI_LINUX_SMC_H */
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 0b6899a7f634..e8e448771f85 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -13,6 +13,8 @@
 #define _SMC_CORE_H
 
 #include <linux/atomic.h>
+#include <linux/smc.h>
+#include <linux/pci.h>
 #include <rdma/ib_verbs.h>
 #include <net/genetlink.h>
 
@@ -380,6 +382,32 @@ static inline void smc_gid_be16_convert(__u8 *buf, u8 *gid_raw)
 		be16_to_cpu(((__be16 *)gid_raw)[7]));
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
+	{ /* Set s390 specific PCI information */
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
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 2456ee8228cd..0997d6910c58 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -15,6 +15,7 @@
 #include "smc_core.h"
 #include "smc_ism.h"
 #include "smc_pnet.h"
+#include "smc_netlink.h"
 
 struct smcd_dev_list smcd_dev_list = {
 	.list = LIST_HEAD_INIT(smcd_dev_list.list),
@@ -207,6 +208,96 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 	return rc;
 }
 
+static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
+				  struct sk_buff *skb,
+				  struct netlink_callback *cb)
+{
+	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
+	struct smc_pci_dev smc_pci_dev;
+	struct nlattr *port_attrs;
+	struct nlattr *attrs;
+	int use_cnt = 0;
+	void *nlh;
+
+	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &smc_gen_nl_family, NLM_F_MULTI,
+			  SMC_NETLINK_GET_DEV_SMCD);
+	if (!nlh)
+		goto errmsg;
+	attrs = nla_nest_start_noflag(skb, SMC_GEN_DEV_SMCD);
+	if (!attrs)
+		goto errout;
+	use_cnt = atomic_read(&smcd->lgr_cnt);
+	if (nla_put_u32(skb, SMC_NLA_DEV_USE_CNT, use_cnt))
+		goto errattr;
+	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
+		goto errattr;
+	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
+	smc_set_pci_values(to_pci_dev(smcd->dev.parent), &smc_pci_dev);
+	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
+		goto errattr;
+	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))
+		goto errattr;
+	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_VENDOR, smc_pci_dev.pci_vendor))
+		goto errattr;
+	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_DEVICE, smc_pci_dev.pci_device))
+		goto errattr;
+	if (nla_put_string(skb, SMC_NLA_DEV_PCI_ID, smc_pci_dev.pci_id))
+		goto errattr;
+
+	port_attrs = nla_nest_start_noflag(skb, SMC_NLA_DEV_PORT);
+	if (!port_attrs)
+		goto errattr;
+	if (nla_put_u8(skb, SMC_NLA_DEV_PORT_PNET_USR, smcd->pnetid_by_user))
+		goto errportattr;
+	snprintf(smc_pnet, sizeof(smc_pnet), "%s", smcd->pnetid);
+	if (nla_put_string(skb, SMC_NLA_DEV_PORT_PNETID, smc_pnet))
+		goto errportattr;
+
+	nla_nest_end(skb, port_attrs);
+	nla_nest_end(skb, attrs);
+	genlmsg_end(skb, nlh);
+	return 0;
+
+errportattr:
+	nla_nest_cancel(skb, port_attrs);
+errattr:
+	nla_nest_cancel(skb, attrs);
+errout:
+	nlmsg_cancel(skb, nlh);
+errmsg:
+	return -EMSGSIZE;
+}
+
+static void smc_nl_prep_smcd_dev(struct smcd_dev_list *dev_list,
+				 struct sk_buff *skb,
+				 struct netlink_callback *cb)
+{
+	struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
+	int snum = cb_ctx->pos[0];
+	struct smcd_dev *smcd;
+	int num = 0;
+
+	mutex_lock(&dev_list->mutex);
+	list_for_each_entry(smcd, &dev_list->list, list) {
+		if (num < snum)
+			goto next;
+		if (smc_nl_handle_smcd_dev(smcd, skb, cb))
+			goto errout;
+next:
+		num++;
+	}
+errout:
+	mutex_unlock(&dev_list->mutex);
+	cb_ctx->pos[0] = num;
+}
+
+int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	smc_nl_prep_smcd_dev(&smcd_dev_list, skb, cb);
+	return skb->len;
+}
+
 struct smc_ism_event_work {
 	struct work_struct work;
 	struct smcd_dev *smcd;
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 481a4b7df30b..113efc7352ed 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -52,4 +52,5 @@ void smc_ism_get_system_eid(struct smcd_dev *dev, u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
 bool smc_ism_is_v2_capable(void);
 void smc_ism_init(void);
+int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
 #endif
diff --git a/net/smc/smc_netlink.c b/net/smc/smc_netlink.c
index 7e73e16223a0..bf114e10d332 100644
--- a/net/smc/smc_netlink.c
+++ b/net/smc/smc_netlink.c
@@ -17,6 +17,7 @@
 #include <linux/smc.h>
 
 #include "smc_core.h"
+#include "smc_ism.h"
 #include "smc_netlink.h"
 
 /* SMC_GENL generic netlink operation definition */
@@ -41,6 +42,11 @@ static const struct genl_ops smc_gen_nl_ops[] = {
 		/* can be retrieved by unprivileged users */
 		.dumpit = smcd_nl_get_lgr,
 	},
+	{
+		.cmd = SMC_NETLINK_GET_DEV_SMCD,
+		/* can be retrieved by unprivileged users */
+		.dumpit = smcd_nl_get_device,
+	},
 };
 
 /* SMC_GENL family definition */
-- 
2.17.1

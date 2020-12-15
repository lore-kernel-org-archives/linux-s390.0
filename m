Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29070 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727985AbgLOJMB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Dec 2020 04:12:01 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 1/1] net/smc: fix access to parent of an ib device
Date: Tue, 15 Dec 2020 10:10:58 +0100
Message-Id: <20201215091058.49354-2-kgraul@linux.ibm.com>
In-Reply-To: <20201215091058.49354-1-kgraul@linux.ibm.com>
References: <20201215091058.49354-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

The parent of an ib device is used to retrieve the PCI device
attributes. It turns out that there are possible cases when an ib device
has no parent set in the device structure, which may lead to page
faults when trying to access this memory.
Fix that by checking the parent pointer and consolidate the pci device
specific processing in a new function.

Fixes: a3db10efcc4c ("net/smc: Add support for obtaining SMCR device list")
Reported-by: syzbot+600fef7c414ee7e2d71b@syzkaller.appspotmail.com
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_ib.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 89ea10675a7d..ddd7fac98b1d 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -394,6 +394,22 @@ static int smc_nl_handle_dev_port(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+static bool smc_nl_handle_pci_values(const struct smc_pci_dev *smc_pci_dev,
+				     struct sk_buff *skb)
+{
+	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev->pci_fid))
+		return false;
+	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev->pci_pchid))
+		return false;
+	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_VENDOR, smc_pci_dev->pci_vendor))
+		return false;
+	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_DEVICE, smc_pci_dev->pci_device))
+		return false;
+	if (nla_put_string(skb, SMC_NLA_DEV_PCI_ID, smc_pci_dev->pci_id))
+		return false;
+	return true;
+}
+
 static int smc_nl_handle_smcr_dev(struct smc_ib_device *smcibdev,
 				  struct sk_buff *skb,
 				  struct netlink_callback *cb)
@@ -417,19 +433,13 @@ static int smc_nl_handle_smcr_dev(struct smc_ib_device *smcibdev,
 	is_crit = smcr_diag_is_dev_critical(&smc_lgr_list, smcibdev);
 	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, is_crit))
 		goto errattr;
-	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
-	pci_dev = to_pci_dev(smcibdev->ibdev->dev.parent);
-	smc_set_pci_values(pci_dev, &smc_pci_dev);
-	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
-		goto errattr;
-	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))
-		goto errattr;
-	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_VENDOR, smc_pci_dev.pci_vendor))
-		goto errattr;
-	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_DEVICE, smc_pci_dev.pci_device))
-		goto errattr;
-	if (nla_put_string(skb, SMC_NLA_DEV_PCI_ID, smc_pci_dev.pci_id))
-		goto errattr;
+	if (smcibdev->ibdev->dev.parent) {
+		memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
+		pci_dev = to_pci_dev(smcibdev->ibdev->dev.parent);
+		smc_set_pci_values(pci_dev, &smc_pci_dev);
+		if (!smc_nl_handle_pci_values(&smc_pci_dev, skb))
+			goto errattr;
+	}
 	snprintf(smc_ibname, sizeof(smc_ibname), "%s", smcibdev->ibdev->name);
 	if (nla_put_string(skb, SMC_NLA_DEV_IB_NAME, smc_ibname))
 		goto errattr;
-- 
2.17.1

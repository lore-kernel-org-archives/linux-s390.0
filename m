Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E9CC761AF
	for <linux-s390@archiver.kernel.org>; Mon, 27 Mar 2023 03:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjC0D23 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 26 Mar 2023 23:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjC0D22 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 26 Mar 2023 23:28:28 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C81E4209;
        Sun, 26 Mar 2023 20:28:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Veevin1_1679887702;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Veevin1_1679887702)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 11:28:23 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        wintera@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v4 1/9] net/smc: Decouple ism_dev from SMC-D device dump
Date:   Mon, 27 Mar 2023 11:28:11 +0800
Message-Id: <1679887699-54797-2-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679887699-54797-1-git-send-email-guwen@linux.alibaba.com>
References: <1679887699-54797-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch helps to decouple SMC-D device and ISM device, allowing
different underlying device forms, such as non-PCI devices.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/net/smc.h | 1 +
 net/smc/smc_ism.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index a002552..963ce9c 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -77,6 +77,7 @@ struct smcd_ops {
 struct smcd_dev {
 	const struct smcd_ops *ops;
 	void *priv;
+	struct device *parent_pci_dev;
 	struct list_head list;
 	spinlock_t lock;
 	struct smc_connection **conn;
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index fbee249..4249fb9 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -231,11 +231,9 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	struct smc_pci_dev smc_pci_dev;
 	struct nlattr *port_attrs;
 	struct nlattr *attrs;
-	struct ism_dev *ism;
 	int use_cnt = 0;
 	void *nlh;
 
-	ism = smcd->priv;
 	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &smc_gen_nl_family, NLM_F_MULTI,
 			  SMC_NETLINK_GET_DEV_SMCD);
@@ -250,7 +248,8 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
 		goto errattr;
 	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
-	smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
+	if (smcd->parent_pci_dev)
+		smc_set_pci_values(to_pci_dev(smcd->parent_pci_dev), &smc_pci_dev);
 	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
 		goto errattr;
 	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))
@@ -420,6 +419,7 @@ static void smcd_register_dev(struct ism_dev *ism)
 	if (!smcd)
 		return;
 	smcd->priv = ism;
+	smcd->parent_pci_dev = ism->dev.parent;
 	ism_set_priv(ism, &smc_ism_client, smcd);
 	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
-- 
1.8.3.1


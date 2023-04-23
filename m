Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20087C77B76
	for <linux-s390@archiver.kernel.org>; Sun, 23 Apr 2023 12:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjDWMSh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 23 Apr 2023 08:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDWMSW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 23 Apr 2023 08:18:22 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909A91FCC;
        Sun, 23 Apr 2023 05:18:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vgjz4Dz_1682252281;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vgjz4Dz_1682252281)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 20:18:03 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v5 5/9] net/smc: Introduce an interface for getting DMB attribute
Date:   Sun, 23 Apr 2023 20:17:47 +0800
Message-Id: <1682252271-2544-6-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682252271-2544-1-git-send-email-guwen@linux.alibaba.com>
References: <1682252271-2544-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On s390, since all OSs run on a kind of machine level hypervisor which
is a partitioning hypervisor without paging, the sndbufs and DMBs in
such case are unable to be mapped to the same physical memory.

However, in other scene, such as communication within the same OS instance
(loopback) or between guests of a paging hypervisor (eg. KVM), the sndbufs
and DMBs can be mapped to the same physical memory to avoid memory copy
from sndbufs to DMBs.

So this patch introduces an interface to smcd_ops for users to judge
whether DMB-map is available. And for reuse, the interface is designed
to return DMB attribute, not only mappability.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/net/smc.h | 5 +++++
 net/smc/smc_ism.c | 8 ++++++++
 net/smc/smc_ism.h | 1 +
 3 files changed, 14 insertions(+)

diff --git a/include/net/smc.h b/include/net/smc.h
index 021ca42..e39ac41 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -55,6 +55,10 @@ struct smcd_seid {
 
 #define ISM_ERROR	0xFFFF
 
+enum {
+	ISM_DMB_MAPPABLE = 0,
+};
+
 struct smcd_dev;
 
 struct smcd_ops {
@@ -77,6 +81,7 @@ struct smcd_ops {
 	u64 (*get_local_gid)(struct smcd_dev *dev);
 	u16 (*get_chid)(struct smcd_dev *dev);
 	struct device* (*get_dev)(struct smcd_dev *dev);
+	int (*get_dev_dmb_attr)(struct smcd_dev *dev);
 };
 
 struct smcd_dev {
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 8ad4c71..1d97e77 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -213,6 +213,14 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
 	return rc;
 }
 
+bool smc_ism_dmb_mappable(struct smcd_dev *smcd)
+{
+	if (smcd->ops->get_dev_dmb_attr &&
+	    (smcd->ops->get_dev_dmb_attr(smcd) & (1 << ISM_DMB_MAPPABLE)))
+		return true;
+	return false;
+}
+
 int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 			 struct smc_buf_desc *dmb_desc)
 {
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index d18c50a..0b1913a 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -40,6 +40,7 @@ struct smc_ism_vlanid {			/* VLAN id set on ISM device */
 int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
 			 struct smc_buf_desc *dmb_desc);
 int smc_ism_unregister_dmb(struct smcd_dev *dev, struct smc_buf_desc *dmb_desc);
+bool smc_ism_dmb_mappable(struct smcd_dev *smcd);
 int smc_ism_signal_shutdown(struct smc_link_group *lgr);
 void smc_ism_get_system_eid(u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
-- 
1.8.3.1


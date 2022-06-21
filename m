Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AC2CCA473
	for <linux-s390@archiver.kernel.org>; Tue, 21 Jun 2022 11:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349818AbiFULjB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Jun 2022 07:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350176AbiFULio (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jun 2022 07:38:44 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C862A26D;
        Tue, 21 Jun 2022 04:38:05 -0700 (PDT)
X-QQ-mid: bizesmtp68t1655811468tockc4e4
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 19:37:43 +0800 (CST)
X-QQ-SSF: 0100000000700040B000B00A0000000
X-QQ-FEAT: kx8LQfRSHcFpoCd2TCggh4bmwsw8np9DavT4KShlOTkJpyM8p1fuxAYiiBdgW
        7h2kPV2N+xaRqAslaO0gNxzH8YQlGuiTpVRQDeSmtZDt3yV8Zj0aWuc+aU2oafZEcI0Ujvq
        PPe1rURi8PkELyLBaZQa4y3BBC8tpmQxPApzrXQ0Ec7JCN0o0XAFE2QgyjwCaWYRUeLVAU/
        nFPxRahtaW5AITobY4DkHG2Ib/Blz2sIKqnuHZX/cC1cp9lfa81z5jyidlz9E1vdOGZLDQY
        k5igPMDDX+lJmu6KI+KNCGIDeyP0cyCUJIcc+e0S6CDIV02d3UG/L0lBLXTTeC76hLE3eLT
        lcxIGlXFGgXt68upwTajsibV/VYaQ==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     wintera@linux.ibm.com
Cc:     wenjia@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] net: s390: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 19:37:40 +0800
Message-Id: <20220621113740.103317-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: ./drivers/s390/net/qeth_core_main.c
line: 3568

* have to request a PCI to be sure the the PCI
changed to
* have to request a PCI to be sure the PCI

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9e54fe76a9b2..35d4b398c197 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3565,7 +3565,7 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 			if (!atomic_read(&queue->set_pci_flags_count)) {
 				/*
 				 * there's no outstanding PCI any more, so we
-				 * have to request a PCI to be sure the the PCI
+				 * have to request a PCI to be sure the PCI
 				 * will wake at some time in the future then we
 				 * can flush packed buffers that might still be
 				 * hanging around, which can happen if no
-- 
2.17.1


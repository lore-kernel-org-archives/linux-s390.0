Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677E6C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 21 Jun 2022 16:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353723AbiFUQI6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353760AbiFUQI1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jun 2022 12:08:27 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45CF25C65;
        Tue, 21 Jun 2022 09:08:19 -0700 (PDT)
X-QQ-mid: bizesmtp62t1655827686to343lxy
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 00:07:58 +0800 (CST)
X-QQ-SSF: 0100000000000090B000000A0000000
X-QQ-FEAT: Adk7n3szVYEqyBKaH0TqoCnv6w0LLs8B+sZnb3JzA9sPZkYwk44BPKyCQZIbV
        m3uXraRAi8ZBYJsnRXF0LXWgJZ/kyNnINTxP3PUG+V0z4URhBj0+RukupFeMASTkJzvGivA
        LFJJokb2/dSS0uvs4/Y5KxC7lOv+hXLPeUmJFU6jqL+I/C1EVN/u7S+v6gdN5rOQ7WolKPW
        obXgT+9jMYg3OUX4qDVrDZCqSfwdJAqaMnISEHp8jwFQEQvQhwLH+6WR+FhUKBefXDtNhWR
        rXNlVvs3DPelYr73kavGIbqqbk/XXzBdDBeYai2CJLy65t
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] s390/net: Fix duplicate 'the' in two places
Date:   Wed, 22 Jun 2022 00:07:56 +0800
Message-Id: <20220621160756.16226-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

file: drivers/s390/net/qeth_core_main.c
line: 3568
                /*
                 * there's no outstanding PCI any more, so we
                 * have to request a PCI to be sure the the PCI
                 * will wake at some time in the future then we
                 * can flush packed buffers that might still be
                 * hanging around, which can happen if no
                 * further send was requested by the stack
                 */
changed to:
		/*
                 * there's no outstanding PCI any more, so we
                 * have to request a PCI to be sure the PCI
                 * will wake at some time in the future. Then we
                 * can flush packed buffers that might still be
                 * hanging around, which can happen if no
                 * further send was requested by the stack
                 */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/s390/net/qeth_core_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9e54fe76a9b2..5248f97ee7a6 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3565,8 +3565,8 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 			if (!atomic_read(&queue->set_pci_flags_count)) {
 				/*
 				 * there's no outstanding PCI any more, so we
-				 * have to request a PCI to be sure the the PCI
-				 * will wake at some time in the future then we
+                 * have to request a PCI to be sure the PCI
+                 * will wake at some time in the future. Then we
 				 * can flush packed buffers that might still be
 				 * hanging around, which can happen if no
 				 * further send was requested by the stack
-- 
2.17.1


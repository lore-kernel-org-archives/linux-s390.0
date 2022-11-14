Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501F9C4332F
	for <linux-s390@archiver.kernel.org>; Mon, 14 Nov 2022 11:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiKNLKY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Nov 2022 06:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiKNLJd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Nov 2022 06:09:33 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CAA22504
        for <linux-s390@vger.kernel.org>; Mon, 14 Nov 2022 03:07:56 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4N9mkH1ZmKz4f3tgh
        for <linux-s390@vger.kernel.org>; Mon, 14 Nov 2022 19:07:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP4 (Coremail) with SMTP id gCh0CgAnmdaJIXJjZkgLAg--.26140S4;
        Mon, 14 Nov 2022 19:07:54 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-s390@vger.kernel.org
Subject: [PATCH] s390/ap: fix memory leak in ap_init_qci_info()
Date:   Mon, 14 Nov 2022 11:08:29 +0000
Message-Id: <20221114110830.542246-1-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnmdaJIXJjZkgLAg--.26140S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4DZw43uFWfKryxKr1Utrb_yoWDGwb_C3
        yxWF1xCr4jga1xKry2v3W5uFyj9a409ry0vas5try3AryfCrs8WwsFqF4xGr1Yqa17Jwsr
        u34Ut34UZ348tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3Jw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUrcTmDUUUU
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

If kzalloc() for 'ap_qci_info_old' failed, 'ap_qci_info' shold be
freed before return. Otherwise it is a memory leak.

Fixes: 283915850a44 ("s390/ap: notify drivers on config changed and scan complete callbacks")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/s390/crypto/ap_bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 59ac98f2bd27..6cbc5e5d2a0e 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -233,8 +233,10 @@ static void __init ap_init_qci_info(void)
 	if (!ap_qci_info)
 		return;
 	ap_qci_info_old = kzalloc(sizeof(*ap_qci_info_old), GFP_KERNEL);
-	if (!ap_qci_info_old)
+	if (!ap_qci_info_old) {
+		kfree(ap_qci_info);
 		return;
+	}
 	if (ap_fetch_qci_info(ap_qci_info) != 0) {
 		kfree(ap_qci_info);
 		kfree(ap_qci_info_old);
-- 
2.34.1


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B4C433C1
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 09:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716AA61964
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 09:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhC2Jkw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 05:40:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15092 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhC2Jkk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Mar 2021 05:40:40 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F86vv0sqFz19Jtx;
        Mon, 29 Mar 2021 17:38:35 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 17:40:31 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 2/2] s390/cio: use DECLARE_WAIT_QUEUE_HEAD() for wait_queue
Date:   Mon, 29 Mar 2021 17:40:19 +0800
Message-ID: <20210329094019.67044-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329094019.67044-1-liushixin2@huawei.com>
References: <20210329094019.67044-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

wait_queue_head_t can be initialized automatically with DECLARE_WAIT_QUEUE_HEAD()
rather than explicitly calling init_waitqueue_head().

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 drivers/s390/cio/css.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index f01ef6325039..a974943c27da 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -652,13 +652,12 @@ static void css_sch_todo(struct work_struct *work)
 
 static struct idset *slow_subchannel_set;
 static DEFINE_SPINLOCK(slow_subchannel_lock);
-static wait_queue_head_t css_eval_wq;
+static DECLARE_WAIT_QUEUE_HEAD(css_eval_wq);
 static atomic_t css_eval_scheduled;
 
 static int __init slow_subchannel_init(void)
 {
 	atomic_set(&css_eval_scheduled, 0);
-	init_waitqueue_head(&css_eval_wq);
 	slow_subchannel_set = idset_sch_new();
 	if (!slow_subchannel_set) {
 		CIO_MSG_EVENT(0, "could not allocate slow subchannel set\n");
-- 
2.25.1


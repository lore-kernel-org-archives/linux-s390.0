Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8A5C48BDF
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 06:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49179613FA
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 06:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhFOGkg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Jun 2021 02:40:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10070 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhFOGkf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Jun 2021 02:40:35 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3z8k69SSzZdyb;
        Tue, 15 Jun 2021 14:35:34 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 14:38:29 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 15 Jun 2021 14:38:28 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <vneethv@linux.ibm.com>, <dsterba@suse.com>,
        <oberpar@linux.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] s390/sclp: convert list_for_each to entry variant
Date:   Tue, 15 Jun 2021 14:57:00 +0800
Message-ID: <1623740220-15846-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

convert list_for_each() to list_for_each_entry() where
applicable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/s390/char/sclp_tty.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 162127f..6be9de8 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -284,15 +284,13 @@ static unsigned int
 sclp_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	unsigned long flags;
-	struct list_head *l;
 	struct sclp_buffer *t;
 	unsigned int count = 0;
 
 	spin_lock_irqsave(&sclp_tty_lock, flags);
 	if (sclp_ttybuf != NULL)
 		count = sclp_chars_in_buffer(sclp_ttybuf);
-	list_for_each(l, &sclp_tty_outqueue) {
-		t = list_entry(l, struct sclp_buffer, list);
+	list_for_each_entry(t, &sclp_tty_outqueue, list) {
 		count += sclp_chars_in_buffer(t);
 	}
 	spin_unlock_irqrestore(&sclp_tty_lock, flags);
-- 
2.6.2


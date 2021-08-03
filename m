Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4B5C4338F
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 03:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BA260ED6
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 03:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhHCDuS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Aug 2021 23:50:18 -0400
Received: from mx21.baidu.com ([220.181.3.85]:42182 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233709AbhHCDtb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Aug 2021 23:49:31 -0400
Received: from BC-Mail-HQEX01.internal.baidu.com (unknown [172.31.51.57])
        by Forcepoint Email with ESMTPS id B6E44125430E30703E82;
        Tue,  3 Aug 2021 11:49:13 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEX01.internal.baidu.com (172.31.51.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 3 Aug 2021 11:49:13 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 3 Aug 2021 11:49:12 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <vneethv@linux.ibm.com>, <oberpar@linux.ibm.com>,
        <cohuck@redhat.com>, <farman@linux.ibm.com>,
        <mjrosato@linux.ibm.com>, <pasic@linux.ibm.com>,
        <chaitanya.kulkarni@wdc.com>, <axboe@kernel.dk>
CC:     <linux-s390@vger.kernel.org>, <kvm@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH 1/4] s390/scm_blk: Make use of PAGE_ALIGN helper macro
Date:   Tue, 3 Aug 2021 11:49:01 +0800
Message-ID: <20210803034904.1579-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803034904.1579-1-caihuoqing@baidu.com>
References: <20210803034904.1579-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex32.internal.baidu.com (172.31.51.26) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

it's a refactor to make use of PAGE_ALIGN helper macro

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/s390/block/scm_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 88cba6212ee2..9f17aa38ab45 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -158,7 +158,7 @@ static inline struct aidaw *scm_aidaw_alloc(void)
 static inline unsigned long scm_aidaw_bytes(struct aidaw *aidaw)
 {
 	unsigned long _aidaw = (unsigned long) aidaw;
-	unsigned long bytes = ALIGN(_aidaw, PAGE_SIZE) - _aidaw;
+	unsigned long bytes = PAGE_ALIGN(_aidaw) - _aidaw;
 
 	return (bytes / sizeof(*aidaw)) * PAGE_SIZE;
 }
-- 
2.25.1


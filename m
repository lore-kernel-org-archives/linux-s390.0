Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B438C432BE
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 03:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294E460EE7
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 03:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhHCDuQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Aug 2021 23:50:16 -0400
Received: from mx21.baidu.com ([220.181.3.85]:42446 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233712AbhHCDtb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Aug 2021 23:49:31 -0400
Received: from BC-Mail-Ex14.internal.baidu.com (unknown [172.31.51.54])
        by Forcepoint Email with ESMTPS id 1CF19B1B3E8C739C7831;
        Tue,  3 Aug 2021 11:49:17 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex14.internal.baidu.com (172.31.51.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 3 Aug 2021 11:49:17 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 3 Aug 2021 11:49:16 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <vneethv@linux.ibm.com>, <oberpar@linux.ibm.com>,
        <cohuck@redhat.com>, <farman@linux.ibm.com>,
        <mjrosato@linux.ibm.com>, <pasic@linux.ibm.com>,
        <chaitanya.kulkarni@wdc.com>, <axboe@kernel.dk>
CC:     <linux-s390@vger.kernel.org>, <kvm@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH 4/4] s390/cio: Make use of PAGE_ALIGN helper macro
Date:   Tue, 3 Aug 2021 11:49:04 +0800
Message-ID: <20210803034904.1579-5-caihuoqing@baidu.com>
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
 drivers/s390/cio/itcw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/itcw.c b/drivers/s390/cio/itcw.c
index 19e46363348c..4f9e810e287c 100644
--- a/drivers/s390/cio/itcw.c
+++ b/drivers/s390/cio/itcw.c
@@ -141,7 +141,7 @@ static inline void *fit_chunk(addr_t *start, addr_t end, size_t len,
 
 	addr = ALIGN(*start, align);
 	if (check_4k && CROSS4K(addr, len)) {
-		addr = ALIGN(addr, 4096);
+		addr = PAGE_ALIGN(addr);
 		addr = ALIGN(addr, align);
 	}
 	if (addr + len > end)
-- 
2.25.1


Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDD4C4338F
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 03:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BC560EE7
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 03:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhHCDuO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Aug 2021 23:50:14 -0400
Received: from mx21.baidu.com ([220.181.3.85]:42352 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233718AbhHCDtb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Aug 2021 23:49:31 -0400
Received: from BC-Mail-Ex10.internal.baidu.com (unknown [172.31.51.50])
        by Forcepoint Email with ESMTPS id 058B9106A177B9540FF4;
        Tue,  3 Aug 2021 11:49:16 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex10.internal.baidu.com (172.31.51.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 3 Aug 2021 11:49:15 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 3 Aug 2021 11:49:15 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <vneethv@linux.ibm.com>, <oberpar@linux.ibm.com>,
        <cohuck@redhat.com>, <farman@linux.ibm.com>,
        <mjrosato@linux.ibm.com>, <pasic@linux.ibm.com>,
        <chaitanya.kulkarni@wdc.com>, <axboe@kernel.dk>
CC:     <linux-s390@vger.kernel.org>, <kvm@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH 3/4] vfio-ccw: Make use of PAGE_MASK/PFN_UP helper macro
Date:   Tue, 3 Aug 2021 11:49:03 +0800
Message-ID: <20210803034904.1579-4-caihuoqing@baidu.com>
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

it's a refactor to make use of PAGE_MASK/PFN_UP helper macro

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 8d1b2771c1aa..178ff71d5cfd 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -65,7 +65,7 @@ static int pfn_array_alloc(struct pfn_array *pa, u64 iova, unsigned int len)
 
 	pa->pa_iova = iova;
 
-	pa->pa_nr = ((iova & ~PAGE_MASK) + len + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
+	pa->pa_nr = PFN_UP((iova & ~PAGE_MASK) + len);
 	if (!pa->pa_nr)
 		return -EINVAL;
 
@@ -161,7 +161,7 @@ static inline void pfn_array_idal_create_words(
 		idaws[i] = pa->pa_pfn[i] << PAGE_SHIFT;
 
 	/* Adjust the first IDAW, since it may not start on a page boundary */
-	idaws[0] += pa->pa_iova & (PAGE_SIZE - 1);
+	idaws[0] += pa->pa_iova & ~PAGE_MASK;
 }
 
 static void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
@@ -214,8 +214,8 @@ static long copy_from_iova(struct device *mdev,
 		from = pa.pa_pfn[i] << PAGE_SHIFT;
 		m = PAGE_SIZE;
 		if (i == 0) {
-			from += iova & (PAGE_SIZE - 1);
-			m -= iova & (PAGE_SIZE - 1);
+			from += iova & ~PAGE_SIZE;
+			m -= iova & ~PAGE_MASK;
 		}
 
 		m = min(l, m);
-- 
2.25.1


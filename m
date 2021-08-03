Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149FBC4320E
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 03:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7830660ED6
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 03:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhHCDuO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 Aug 2021 23:50:14 -0400
Received: from mx20.baidu.com ([111.202.115.85]:42284 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233715AbhHCDtb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Aug 2021 23:49:31 -0400
Received: from Bc-Mail-Ex13.internal.baidu.com (unknown [172.31.51.53])
        by Forcepoint Email with ESMTPS id E4AD06F0AFA662B24BE2;
        Tue,  3 Aug 2021 11:49:14 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 Bc-Mail-Ex13.internal.baidu.com (172.31.51.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 3 Aug 2021 11:49:14 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 3 Aug 2021 11:49:14 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <vneethv@linux.ibm.com>, <oberpar@linux.ibm.com>,
        <cohuck@redhat.com>, <farman@linux.ibm.com>,
        <mjrosato@linux.ibm.com>, <pasic@linux.ibm.com>,
        <chaitanya.kulkarni@wdc.com>, <axboe@kernel.dk>
CC:     <linux-s390@vger.kernel.org>, <kvm@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH 2/4] s390/vmcp: Make use of PFN_UP helper macro
Date:   Tue, 3 Aug 2021 11:49:02 +0800
Message-ID: <20210803034904.1579-3-caihuoqing@baidu.com>
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

it's a refactor to make use of PFN_UP helper macro

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/s390/char/vmcp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 9e066281e2d0..3f83eb6b9e5b 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -60,17 +60,16 @@ void __init vmcp_cma_reserve(void)
 static void vmcp_response_alloc(struct vmcp_session *session)
 {
 	struct page *page = NULL;
-	int nr_pages, order;
+	int order;
 
 	order = get_order(session->bufsize);
-	nr_pages = ALIGN(session->bufsize, PAGE_SIZE) >> PAGE_SHIFT;
 	/*
 	 * For anything below order 3 allocations rely on the buddy
 	 * allocator. If such low-order allocations can't be handled
 	 * anymore the system won't work anyway.
 	 */
 	if (order > 2)
-		page = cma_alloc(vmcp_cma, nr_pages, 0, false);
+		page = cma_alloc(vmcp_cma, PFN_UP(session->bufsize), 0, false);
 	if (page) {
 		session->response = (char *)page_to_phys(page);
 		session->cma_alloc = 1;
@@ -81,16 +80,15 @@ static void vmcp_response_alloc(struct vmcp_session *session)
 
 static void vmcp_response_free(struct vmcp_session *session)
 {
-	int nr_pages, order;
+	int order;
 	struct page *page;
 
 	if (!session->response)
 		return;
 	order = get_order(session->bufsize);
-	nr_pages = ALIGN(session->bufsize, PAGE_SIZE) >> PAGE_SHIFT;
 	if (session->cma_alloc) {
 		page = phys_to_page((unsigned long)session->response);
-		cma_release(vmcp_cma, page, nr_pages);
+		cma_release(vmcp_cma, page, PFN_UP(session->bufsize));
 		session->cma_alloc = 0;
 	} else {
 		free_pages((unsigned long)session->response, order);
-- 
2.25.1


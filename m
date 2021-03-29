Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC9EC433E9
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8326191F
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhC2SeE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhC2Sdy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Mar 2021 14:33:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C9C061574;
        Mon, 29 Mar 2021 11:33:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y2so4815764plg.5;
        Mon, 29 Mar 2021 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSaTkmfM+DlISEg5t2tvo/fEPeZL9Xe7bKqioL4lk60=;
        b=bwSINefQh0DoGNCOud81X4AaQE+ngF8kpjG+biWhNmTz4pYazW+mi2wvB77qTlmlHP
         Fu2xDJJkdiYCQD9isI2ieFMGdmgf6loayf/11lmPEFvZ1nKKgZE2MVXWvXes13LHTiRy
         j5LBrB7fb+t3l1/NCrv0ho+s8+0wmhFHFMqKtKbJgMwlKlHNK9sM18JOfCQ/hEQciLhW
         0pSfFxOkgaFH0d67absszjG9JhmuyOwm6GLS4+dcNdVQy1eTme2Eqdq1+7FiNOEbqL1U
         easnt/9TBiSWC6P3gFEGmSI0LoIJo/yTON//oEtbpwqI5O6v7N3YzyXa9AOk/Xg0tvKQ
         t/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSaTkmfM+DlISEg5t2tvo/fEPeZL9Xe7bKqioL4lk60=;
        b=E199/IVwgCulWBLP3SRSbH8B/uE0JJwM14jh0RUVPk3jeBi+8L8zVB8vddp/9Zoe7s
         nCuRRfuPR4s3UJg+tVGBn4CbAQ9p1WTNRWn4KIHXaGmUa661knMwUGqqvEdiQ2LFzpNQ
         /MY6ppiYL+A2vEBjlOD7cX9RU3bicoe8cE1v1AnRMmy/0RKxYlKlYx0ulIhy78t2i2Td
         VWMjmOlDfrEA1Ahpd2x+GBbnMC1IzaoUvkmsdFcHzqgTSTTRHyiZl8Kmw5tmC2Fj+jOl
         lo8VBJ3cPClCmhxgfvX07c0VCC7VE6T5EC+59jNPr5uUNpdpRzQJcR9JGVI9LojtJGhP
         TjzA==
X-Gm-Message-State: AOAM5319nz3IM24/Izq01EHveh4TTHjFMFdZr3VxHd5EE98Eb4eIyhDg
        EJSKE4GlZk6+cdE0DPT12HQ=
X-Google-Smtp-Source: ABdhPJzXT70cKxSxdOXATE+ZMVo92pyvGaGyaTU+a/wsCVfCDUVP4b/fz9NpczD4sDKyoVDSZS9GNg==
X-Received: by 2002:a17:90a:64c7:: with SMTP id i7mr435427pjm.95.1617042834227;
        Mon, 29 Mar 2021 11:33:54 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x11sm1151158pjh.0.2021.03.29.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:33:53 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mm: migrate: remove redundant page count check for THP
Date:   Mon, 29 Mar 2021 11:33:12 -0700
Message-Id: <20210329183312.178266-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329183312.178266-1-shy828301@gmail.com>
References: <20210329183312.178266-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Don't have to keep the redundant page count check for THP anymore after
switching to use generic migration code.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 1c0c873375ab..328f76848d6c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2097,18 +2097,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	if (isolate_lru_page(page))
 		return 0;
 
-	/*
-	 * migrate_misplaced_transhuge_page() skips page migration's usual
-	 * check on page_count(), so we must do it here, now that the page
-	 * has been isolated: a GUP pin, or any other pin, prevents migration.
-	 * The expected page count is 3: 1 for page's mapcount and 1 for the
-	 * caller's pin and 1 for the reference taken by isolate_lru_page().
-	 */
-	if (PageTransHuge(page) && page_count(page) != 3) {
-		putback_lru_page(page);
-		return 0;
-	}
-
 	page_lru = page_is_file_lru(page);
 	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
 				thp_nr_pages(page));
-- 
2.26.2


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C450C433B4
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B416109F
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352083AbhERUKD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 16:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352050AbhERUJr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 16:09:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1FBC061573;
        Tue, 18 May 2021 13:08:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b9-20020a17090a9909b029015cf9effaeaso2186084pjp.5;
        Tue, 18 May 2021 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsOsjkhPCcPV0zv6oCcbmotnPtBUzCdIBSrvKgiDikA=;
        b=SwtmZy7QhVhjTdJlzMLxTCWs9t9a8LPJVRDTfGexGYehagSrQXPy+sobHKasW8WhMi
         vyV+EDOWiHNG0QHiCEaYBWXlmDvgeZnSCrI4kVdoDW1fnMCb5fLVB4oqPzCldtWSd+Aq
         gnIYMHgbuzjF1EoItH0nV+nzV6vuIjtVYMQ0NhpjLnAt37nvq8soPHEWH/eA6ajm/r13
         IB2pUlLLDtEFKgoRUKuJp9XPRlvKj8c8YlJtdggxxjE6Kx+uMm6CBKme163wi42wIKX2
         azfWKcO/Ws8VlDvHQOVcmOUNGTp7+WJM1G1SkP4IQhPMyODP/qleLPrnGGRja+3FeoXW
         Nifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsOsjkhPCcPV0zv6oCcbmotnPtBUzCdIBSrvKgiDikA=;
        b=JA/NkYHvLGWJ0+3Xe/kQn7TodUAa7N/C2M5VOgAqissEqPCVccRx5LSIVJV7tsPUHS
         EeXSNZ6CcwPmJR6TAhYvS1/hglF+3HyLXPtrjRC5X53fhYZpQ6zB2vfIq9453vkzFhmL
         fJEHwnH7eqjtXOawWeZx6o+SKCdwpP9tmxJKhSGR0aW+ShHZtyS9qi6/Ol9B2LIe+mDF
         3v/9Cb1BtMLd/EUOGOtaz4UwiQljHX9VQhivGHb4k4C5eLH8CzIijLgo9W8BvwT4hBmF
         G8DOdPT/WWXDjt+vv/qMQzYy6chPVTpLglD4YIl+ba6CrMmR7n+kirvxlD8BZfCp6xxa
         IpXA==
X-Gm-Message-State: AOAM532T4bv2Jh25BmFh7D8RjLRcmJu+946C32K5q5IetsGyD8IlYor7
        b//T13WY0cowjZ5mZObS7Eo=
X-Google-Smtp-Source: ABdhPJytDWDaq+aC4veI99lmSFliP67cUhY8lIZXHRGfmTdfTnvkUJxAwyUWmh809yNfMsIcSzth1w==
X-Received: by 2002:a17:90a:6402:: with SMTP id g2mr7237187pjj.82.1621368508608;
        Tue, 18 May 2021 13:08:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id r11sm13456600pgl.34.2021.05.18.13.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:08:27 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        ying.huang@intel.com, mhocko@suse.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 5/7] mm: migrate: don't split THP for misplaced NUMA page
Date:   Tue, 18 May 2021 13:07:59 -0700
Message-Id: <20210518200801.7413-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210518200801.7413-1-shy828301@gmail.com>
References: <20210518200801.7413-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The old behavior didn't split THP if migration is failed due to lack of
memory on the target node.  But the THP migration does split THP, so keep
the old behavior for misplaced NUMA page migration.

Acked-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 26f79f516100..035daaec1ca0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1420,6 +1420,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int swapwrite = current->flags & PF_SWAPWRITE;
 	int rc, nr_subpages;
 	LIST_HEAD(ret_pages);
+	bool nosplit = (reason == MR_NUMA_MISPLACED);
 
 	trace_mm_migrate_pages_start(mode, reason);
 
@@ -1491,8 +1492,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				/*
 				 * When memory is low, don't bother to try to migrate
 				 * other pages, just exit.
+				 * THP NUMA faulting doesn't split THP to retry.
 				 */
-				if (is_thp) {
+				if (is_thp && !nosplit) {
 					if (!try_split_thp(page, &page2, from)) {
 						nr_thp_split++;
 						goto retry;
-- 
2.26.2


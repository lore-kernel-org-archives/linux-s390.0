Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB7C43461
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD82D6135C
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbhDMVY6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348416AbhDMVY5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Apr 2021 17:24:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47DFC061574;
        Tue, 13 Apr 2021 14:24:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso9673881pjb.3;
        Tue, 13 Apr 2021 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmtfeB5twZZ4rQ0Q6SWlOUiWCuvN4QYBszoXlhLmsSk=;
        b=iVr3rN5OZs9UQnNoWS5iJxIk8vfUyYrz+b1F8GvRCkC0gTKt40QJl9BcrF0UdZKSl0
         6COTC0Pktx90r15Zy7koDF9/Dn7U6cIvBLPkygAFyAoUOnOlVvGowkPqgG6oP2fcL0Cj
         gvvEr2nlre03l6pvwggVW7Gvl3x1WE7ykWutoyWLJArbqlXjj7GHYQ55j4IEJFm5bwOG
         GtyBoUfYkwuuchv88jJ3xQBaWx/v7PgWe18UVhrAv1Pxx8EatORoi6ZI5VS3UE/QHg6F
         40fda+SU9So2hGVDJTPjRvdF/ZmqsYs9hZqB16HIJvfQ6B264VAwUzsAqDtzE9tH7iau
         R0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmtfeB5twZZ4rQ0Q6SWlOUiWCuvN4QYBszoXlhLmsSk=;
        b=eiNBy4O7vpUAQx1hpja2gtFkj3Ff3rhAVdlDtd1JhmjgrN/1GvCqEjHLm/nrhuP4xh
         pOykG1NRwbAeYG+5c1RUM93k4bfQguDq67HzaR8LILesM+Ev+Q91swCdOJDjWs1D0kXg
         P7FR0VA+htiZLD3KrRFBCjz7HfciM3tjiqU3Qe36FN5shLEGTIEZ6XxFBTSLPh0sUjHv
         BK2dqSA9ZTzOQEH0u2tgVdo4rSNxKRjCBjWUS2amgF/zTralMBI2j54DOiSSJhv6/N4g
         URChSphRC5iU2vcRKAVxAypmQ8YrQcL+ItLD2fQqPyL6tHrNkVGl2WJe/o/pMuQ4fmrX
         o6Ig==
X-Gm-Message-State: AOAM531EhC+aX1rw+b0Se8jnfiOdcRKf1PV0aToMCIn7qf6MXgrNTCLM
        EoSGdLfriFM3O47B+g06xRsBNuEsVS3cAoa/
X-Google-Smtp-Source: ABdhPJwYiPy8wHeDk26h6rj5vIUXFbUQ74snf6AFlp+1DmZ150lwhBeMHSj2yODGu2UXHK9FslfXkA==
X-Received: by 2002:a17:90a:ce0a:: with SMTP id f10mr2001141pju.98.1618349077593;
        Tue, 13 Apr 2021 14:24:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw24sm3069345pjb.21.2021.04.13.14.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:24:36 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 4/7] mm: migrate: account THP NUMA migration counters correctly
Date:   Tue, 13 Apr 2021 14:24:13 -0700
Message-Id: <20210413212416.3273-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210413212416.3273-1-shy828301@gmail.com>
References: <20210413212416.3273-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Now both base page and THP NUMA migration is done via migrate_misplaced_page(),
keep the counters correctly for THP.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 333448aa53f1..a473f25fbd01 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2111,6 +2111,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	LIST_HEAD(migratepages);
 	new_page_t *new;
 	bool compound;
+	unsigned int nr_pages = thp_nr_pages(page);
 
 	/*
 	 * PTE mapped THP or HugeTLB page can't reach here so the page could
@@ -2149,13 +2150,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
-			dec_node_page_state(page, NR_ISOLATED_ANON +
-					page_is_file_lru(page));
+			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
+					page_is_file_lru(page), -nr_pages);
 			putback_lru_page(page);
 		}
 		isolated = 0;
 	} else
-		count_vm_numa_event(NUMA_PAGE_MIGRATE);
+		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_pages);
 	BUG_ON(!list_empty(&migratepages));
 	return isolated;
 
-- 
2.26.2


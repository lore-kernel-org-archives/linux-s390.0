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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1427EC433B4
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E511E6109F
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352097AbhERUKH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 16:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352068AbhERUJ5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 16:09:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C96BC061761;
        Tue, 18 May 2021 13:08:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so2192794pjb.3;
        Tue, 18 May 2021 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bft5/S3sIep+UIOe0wjEBCs4qeqthplQvAas8/8e+yo=;
        b=nHLS3OJzElgnE2B/Z8SKCricVXLIx3iJxQjJ0syYMD0st4Cu/HagKgnXREM54zswjw
         XMNbtKvBMaoANopTaCd8U7u2Hm86+M3RuZtminAUpNjSsKZa0ANHy7i82oYV5IUBo3y5
         9as9AvR0a6Tf/pms+EH7p0fkg0BSIgxX0pHVwN8P5Wx2tzfzJWe1qn5USVLiIJCq+FuE
         BSJupLShAnX1rbhtkb46N4UqYZ8EQt19Oxj+xOEtlDuZCPe1a2dfSKZZsE6riRl+RTUN
         VZadMbE778WhVEQIFJBh5I6kdzgTgYVgZZeinQpMkA7oXwHQKhc9R+s52vZyIwRN3/vc
         4HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bft5/S3sIep+UIOe0wjEBCs4qeqthplQvAas8/8e+yo=;
        b=ZXtqbnM3KF3DRg7BvJvnLWwaaw5dIwlO1JzPA+UIVebCU9aSkSU1QKrmTz6IQj9sC7
         /oF/ADQNhPrcC6/LLRFzccf+J5JVspoilQU0smYvh7GGEUlpQNWvmINAEioJ7FyVPFaL
         9Rv+9z9rYE6Uduq3nbAe6+qsMNjWR8p83FjXX3NreK4UVByM8oPAJeD+FsUJ6zJoV0gx
         99w0NvjjMo+PPWr7n4Khe3BCkzkEJwBAOO4j7BknIJMJfQCTn84fLAAqOC37/LWcBQz3
         nwKoMypV3g1nAlyeG/XkoNgw29hAK8YNtIey6kaLmyZoHVZSK3MM5mGmEmuTCa0wEhb4
         B3MQ==
X-Gm-Message-State: AOAM530jIg0vUl2h5yxQU7FSo2OWkzPgYt6s96KHOAcStbX07aTM/LqV
        RPcHD/A9P78hTXfntiaX4hk=
X-Google-Smtp-Source: ABdhPJycucOy8RWBt3ZSLaK0DULZYOHapGP8SDJZBX29cfFbM7ELURa2SaI9yfmt82bS4uEWVqBwiA==
X-Received: by 2002:a17:902:e007:b029:ef:9dd2:be6 with SMTP id o7-20020a170902e007b02900ef9dd20be6mr6495035plo.12.1621368510709;
        Tue, 18 May 2021 13:08:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id r11sm13456600pgl.34.2021.05.18.13.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:08:29 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        ying.huang@intel.com, mhocko@suse.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 6/7] mm: migrate: check mapcount for THP instead of refcount
Date:   Tue, 18 May 2021 13:08:00 -0700
Message-Id: <20210518200801.7413-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210518200801.7413-1-shy828301@gmail.com>
References: <20210518200801.7413-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The generic migration path will check refcount, so no need check refcount here.
But the old code actually prevents from migrating shared THP (mapped by multiple
processes), so bail out early if mapcount is > 1 to keep the behavior.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 035daaec1ca0..77215f28502b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2070,6 +2070,10 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 
 	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
 
+	/* Do not migrate THP mapped by multiple processes */
+	if (PageTransHuge(page) && total_mapcount(page) > 1)
+		return 0;
+
 	/* Avoid migrating to a node that is nearly full */
 	if (!migrate_balanced_pgdat(pgdat, compound_nr(page)))
 		return 0;
@@ -2077,18 +2081,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
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


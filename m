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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7288DC433ED
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F07061246
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348437AbhDMVZC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348418AbhDMVZC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Apr 2021 17:25:02 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D3C061756;
        Tue, 13 Apr 2021 14:24:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f29so12876540pgm.8;
        Tue, 13 Apr 2021 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pRfd+wOd4qoxNAST21yPZCThPxUu/7bAGiKFZOKY6d8=;
        b=lJITJut37aBTK+f9dTgHu1UjML1K+sz8l3RIQxMTDn07BEPrnJ02I5I/bwqAHPhIn5
         S8tiU2O+awovLmX4VVToKSks1+jKTAinxrg9fNCaZhIKwQrgKQKT6YmsjataVgO+KN+s
         WC1NYW1pTKOYHTIYPYD080AF6kOsZvrjZj+grK6E1WkxAbZuVOP2V/irQEyqxdp4va8U
         5XREEOrhTQwmK19x8KewOYi0qofybk5PGLbYU1bSCZtMhhc6SfmXUZjygzLhq5IjTcqL
         8frdihCWj1rzB8mYWv7kn0UwefCShpU571suGRgv6KLXt9pGzjNJiaVRXpOVs4ZfoGL9
         j+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRfd+wOd4qoxNAST21yPZCThPxUu/7bAGiKFZOKY6d8=;
        b=spPoUToxG4x5Mjimyg1LeL4MBLBJVpaFJX+50mihKmjjHi1Rp21G2mVrxE7UmMQDxC
         UENFX9X2CZlTSAmMeaZJoHrKP8Z/VmYOG43Yhw1/ao/aO+sBXfbfTtDq6XDT68Tffu6+
         yj3CR59rGBVvPpXoidaGj2JHS0tYMm/rr9PsxK1ZuIB2RH2jCzWr4opkpRrLDITajYkt
         OWESlbEaogJycyoV21tooJDJiMZugY8uVlotJ3H7U8fYvsk+3cK6+C5P851UHVfA6Ntr
         frTFY1fzRV0hYGjJ9IaZ7nTmKVAc4OCKGqbD+ZNx1jWqSLeLZLT+2CyPQOXr1H22xAiG
         f1GQ==
X-Gm-Message-State: AOAM533Ban4ch0d7cskudBk7j7WpQX3Wj/7BPgw6MwMldBt/FJARhJV0
        2U8FepWG/jod1YB9/ExvRsw=
X-Google-Smtp-Source: ABdhPJwgpAER6R3GgfwWJo6MkscSPav2zxnCK/y1FAkldOUG8y4v39OSNPDocMiAl+h9muoqcInf6w==
X-Received: by 2002:a62:e315:0:b029:243:e499:d5ba with SMTP id g21-20020a62e3150000b0290243e499d5bamr28410928pfh.75.1618349081432;
        Tue, 13 Apr 2021 14:24:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw24sm3069345pjb.21.2021.04.13.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:24:40 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 6/7] mm: migrate: check mapcount for THP instead of ref count
Date:   Tue, 13 Apr 2021 14:24:15 -0700
Message-Id: <20210413212416.3273-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210413212416.3273-1-shy828301@gmail.com>
References: <20210413212416.3273-1-shy828301@gmail.com>
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
index a72994c68ec6..dc7cc7f3a124 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2067,6 +2067,10 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 
 	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
 
+	/* Do not migrate THP mapped by multiple processes */
+	if (PageTransHuge(page) && page_mapcount(page) > 1)
+		return 0;
+
 	/* Avoid migrating to a node that is nearly full */
 	if (!migrate_balanced_pgdat(pgdat, compound_nr(page)))
 		return 0;
@@ -2074,18 +2078,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
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


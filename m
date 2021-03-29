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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45A0C433E3
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951E361959
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhC2SeE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhC2Sdw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Mar 2021 14:33:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B271C061574;
        Mon, 29 Mar 2021 11:33:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j25so10444243pfe.2;
        Mon, 29 Mar 2021 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CRNvcMROqrESHeRKDz8ObLyGg8mIEbD/UzeVrHPcdA=;
        b=dwfbMHXO9rtx22/WgMfUY6cGe3JyGFIlA1Wor9r8FoMKQhg/8D6RV7seDwo52cXxMh
         s8gRBHYQMpBCWbnITkSxA/ewGhQxzHtx59bDfS3MUkIZdLIo5UJO99IVi1sZXZtZRXgY
         gG560qy54JPIFFDY8dJakHXavIqaQJohRgjOX2e4p1oYfMdKTmeaeVb9V6gY7ioRZtLc
         Av0ADSKfI3lkDFcVqxOZyq4uhhuaosjpx05sgL1LBqcKFIPMDEkQpQJ+Jw6fZsP/I/ZB
         8E+HoJoIv5f7ei4tVchySYe3fYsMFzHkHyzQsnuAGW+AvlpvsXCpueoTfMMDag5I/o0b
         JC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CRNvcMROqrESHeRKDz8ObLyGg8mIEbD/UzeVrHPcdA=;
        b=kmQP/NuURJ2hJvc1E6ErPIk5kcSULFH+ZsQKGPcl+39MWyhEP1KOADa7+DCuURwDHs
         mjbDVt6r4NjrgmZ0TuagVVQPMghwnfNGuh5MK0akYxI7fIIuN8L/eMw6BmxBov3qzDQi
         D/AYMPudyVPA7ht8nNlSNaCvLnx61LyyyKFJILUT/RxxHAatFG8MymlLG1o/PWrl+K5J
         6p3z6KoIewJNM7VKl5eO/FUAud1Zw6f59+gKgq67wM3ldsAXp7w5IME2zp71loNwp0vr
         hd5FYbj7SdtAOrZybKqnO6hSgIvtJfCxHB6RJPK1TQa5I9FVpsr0ohcjwXe5tK3MAG0e
         4KPg==
X-Gm-Message-State: AOAM533NAuTZQiBcnV7ee6eLEPhJ0J5gXaZ2lqxBWPn8z6NFWyQ/uycC
        a0bv2brNlGZM+bmh5U61dLZ8NpCkmzlAnA==
X-Google-Smtp-Source: ABdhPJzRrfzExBoG5WiegX0oe7EJkp86mMCbPiGhiwaIffVDW8BeQM+6Y/uubempegqUH6t4hmQzaA==
X-Received: by 2002:a62:fc90:0:b029:213:be9a:7048 with SMTP id e138-20020a62fc900000b0290213be9a7048mr26647878pfh.4.1617042831909;
        Mon, 29 Mar 2021 11:33:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x11sm1151158pjh.0.2021.03.29.11.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:33:50 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mm: migrate: don't split THP for misplaced NUMA page
Date:   Mon, 29 Mar 2021 11:33:11 -0700
Message-Id: <20210329183312.178266-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329183312.178266-1-shy828301@gmail.com>
References: <20210329183312.178266-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The old behavior didn't split THP if migration is failed due to lack of
memory on the target node.  But the THP migration does split THP, so keep
the old behavior for misplaced NUMA page migration.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 86325c750c14..1c0c873375ab 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1444,6 +1444,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int swapwrite = current->flags & PF_SWAPWRITE;
 	int rc, nr_subpages;
 	LIST_HEAD(ret_pages);
+	bool nosplit = (reason == MR_NUMA_MISPLACED);
 
 	if (!swapwrite)
 		current->flags |= PF_SWAPWRITE;
@@ -1495,7 +1496,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			 */
 			case -ENOSYS:
 				/* THP migration is unsupported */
-				if (is_thp) {
+				if (is_thp && !nosplit) {
 					if (!try_split_thp(page, &page2, from)) {
 						nr_thp_split++;
 						goto retry;
-- 
2.26.2


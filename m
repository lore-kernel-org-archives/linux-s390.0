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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D07C43460
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEFA61246
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348436AbhDMVZC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348427AbhDMVZA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Apr 2021 17:25:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF87C061574;
        Tue, 13 Apr 2021 14:24:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h20so8948414plr.4;
        Tue, 13 Apr 2021 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6LlC7e6qPBv/DFANfawt2CvXuDZCeYDosf1+Pz2+ts=;
        b=iE9WM8EBKV5aqe7bVrS2wJeFBV1IT4YtJyiImW0a6iK5SLKlcjpXJyB4HbZU6uTNAh
         +Zg1V+1OsAruwtxi3bUb7wvRNYJkSSu0K3Fe2/D+D6SX09BPrsZxu1y3gmQwWmiaqRZo
         rpEEtoNIHZEbDUTv2KOSim2R4Hbe3c2sGbr/7ArtBmWf2ePJPu4za1U7JXB0muQ+ZXaV
         NEpSPouCHt6XY1qNmzMYD0Kny3niGAKCoDqG2F2VGGIKTQG9nSjZl9xgkWWLT8xg/Fds
         htFwiTIvNWesTRIHp/BEPmyg1a9DmRR3jR9+En280LgLIjCHUQDeX8Y6ASS45SuON+4N
         Zybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6LlC7e6qPBv/DFANfawt2CvXuDZCeYDosf1+Pz2+ts=;
        b=gTF7txc2yIOMwiWg8vMLOMWeOB0gWDOuwLz6ryQWpgoD+i8vJmqUs6DGl9Vz/uZ2V0
         qOzvuZD5S6UjEXxYR7NujQjGlgSUZrKzG7fph+XA7bsA3X8HtAjz7+U/OOX4GqB0js5U
         jGh78yGk7MH0TcPQEgRXPjyj5vC5Y8dCK1CuuFz9luZSPr14WqQrpq/vNEq9aVKuD8B0
         wyuoDn8teznzqNld9ep52plSHMTElgcEbEbDmGvPw/jBQnwRudHoUTNk2DlZFyCMDEzc
         Xu8UiDOOmBZ4CNnXcwxOetSfMO+7hXox+0WAN6DeKniwwWoaoXrz/d0I9PqjtoKJAXn0
         fBow==
X-Gm-Message-State: AOAM531LHwMEUEcOng4G3PPlvMYwsJeRjkgZCrypxWkDH7kNmWxyr6nI
        XZjdH8VI+b/xJB5uQgWpFxc=
X-Google-Smtp-Source: ABdhPJxo7MBByycqzfC3pAyOVupxOhelSDT7jOQ4KiIdzVmez62LtHArR8gJdQ7X0jtuHVX3vGl75Q==
X-Received: by 2002:a17:90a:5418:: with SMTP id z24mr2117305pjh.189.1618349079422;
        Tue, 13 Apr 2021 14:24:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw24sm3069345pjb.21.2021.04.13.14.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:24:38 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 5/7] mm: migrate: don't split THP for misplaced NUMA page
Date:   Tue, 13 Apr 2021 14:24:14 -0700
Message-Id: <20210413212416.3273-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210413212416.3273-1-shy828301@gmail.com>
References: <20210413212416.3273-1-shy828301@gmail.com>
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
 mm/migrate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a473f25fbd01..a72994c68ec6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1417,6 +1417,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int swapwrite = current->flags & PF_SWAPWRITE;
 	int rc, nr_subpages;
 	LIST_HEAD(ret_pages);
+	bool nosplit = (reason == MR_NUMA_MISPLACED);
 
 	trace_mm_migrate_pages_start(mode, reason);
 
@@ -1488,8 +1489,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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


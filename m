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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56513C43460
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DF461074
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352040AbhERUJr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352056AbhERUJp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 16:09:45 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6CEC06175F;
        Tue, 18 May 2021 13:08:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v12so5723397plo.10;
        Tue, 18 May 2021 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJy1kyPl+oDN1LphbCW3pYnL0yTMuSAszJt41Bp1UBM=;
        b=dz0rHWSH3hdqt902RCPgGvJ7ufXgHBvMlvWjyWU9TgOnB6+uISl/zfQAZqijTUm9lj
         gIzdnBYXvA5OTtf9+vGaIo0jwxQR+cpjiZ8Vd4kLF3Bm8qKL7Ftb1DGPQJu9vcww60/n
         K6Jp65JDLmLw4WXCJhZ2Ac7BxaN3ybDLaIDvgZV5WD+AHy+sTTeguiQA4C80YOCigIqg
         NR0wPWRtJ9pmeno0Ng6pa+ewucpiAMwHYVS7J58cd9LaxHDe4c5Uobo9zm460NtPGgPR
         gGgvKGG5Tp36HLsIbanO9KPOZfJYy3UdU+g2N+rEZnczLphoMPuOFtQYUy2H6+85PvwG
         sHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJy1kyPl+oDN1LphbCW3pYnL0yTMuSAszJt41Bp1UBM=;
        b=riooUL3z63842KJMnKnxfUurbmmC5dWYDjIsV0/QGRUtIBNmvW4njk05S3XluyorI9
         4TaxxGfEwl+e8tFrWKeYwU60YWVQOgMnlpvD5PaaVlcdPuaRkHmduuSu6YjpvlEVpPlK
         eAgsHxfO+k7fbhdZYuQ0uJ86C1ZMXL3/4PunPiEEtnpeC1L4TJE2dIOuF5it1JgKLNSN
         YIHv+CMiXkFR5TWExM8K0SXR6ugDGIoDp2boSlIlpWZ8x/Zxli8VMIp3gf6wdXf8WqKw
         d+Xp6FLOr2AYKjl+U17tAn3D6YGfXL+gunMHK31GazChsAbmbmOSu8fS8ki5nb5YAAdQ
         4ooQ==
X-Gm-Message-State: AOAM5324tJE7PYpQc3kAYTjv+vAzJf3WJaoUS6UaOvTbnZowSo+9Ko32
        vm7XrVlM8aBJ9NMn581PNvEuEYe4BzHNP8FL
X-Google-Smtp-Source: ABdhPJxC5xHJpdW0gj/fkethiDc7bPdRQpp9SNv+bII0C3hZHPfOmRFe/+aSGlwmrPy4u/vr0u2k9w==
X-Received: by 2002:a17:90a:ba16:: with SMTP id s22mr7191848pjr.12.1621368506220;
        Tue, 18 May 2021 13:08:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id r11sm13456600pgl.34.2021.05.18.13.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:08:25 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        ying.huang@intel.com, mhocko@suse.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 4/7] mm: migrate: account THP NUMA migration counters correctly
Date:   Tue, 18 May 2021 13:07:58 -0700
Message-Id: <20210518200801.7413-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210518200801.7413-1-shy828301@gmail.com>
References: <20210518200801.7413-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Now both base page and THP NUMA migration is done via migrate_misplaced_page(),
keep the counters correctly for THP.

Acked-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4e0c2644256a..26f79f516100 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2114,6 +2114,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	LIST_HEAD(migratepages);
 	new_page_t *new;
 	bool compound;
+	unsigned int nr_pages = thp_nr_pages(page);
 
 	/*
 	 * PTE mapped THP or HugeTLB page can't reach here so the page could
@@ -2152,13 +2153,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E09C433E5
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77A961554
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhC2SeD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhC2Sdr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Mar 2021 14:33:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E00C061574;
        Mon, 29 Mar 2021 11:33:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v3so9986925pgq.2;
        Mon, 29 Mar 2021 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8eLl3881AHbZ4nNjB6RvYqJ53F/ZpOHZuU1QaCJvItA=;
        b=kwSaBPZO7cNmxBxn0pqrgpKYEG8tAOHuiuyNiyDxCJ5co/V4+pKYYq4FPQlfXlFkVB
         5T+u5kfT14LU01mRwKUj4D+eSFyy1ceWJTJSR1Z2ys75gI+Bo1tDjOaTFdJiSMr78KDW
         aJJerTatPG6tRajq8FGyMWo2ldNPddMXrCpIKW39FwssTzJZkoxIwEmODd2lYwhBRn8K
         eVaK0fkoHahUGSUCVJFhhlUuT9TwH9NUJ+25lQVka8UPmN7gwQBeQ1U+YygBwUdG8+au
         B7bT6WXhQY03CcKZtp7qSmKKPeh0QuVPi7Iu/XFw3F5qwa89ns3oqMyzEpV9st69Rvw+
         MeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8eLl3881AHbZ4nNjB6RvYqJ53F/ZpOHZuU1QaCJvItA=;
        b=EQ/lRLx0Ntmn314UZ71hR7LKaVfeE1upwi/DIPywwt7dUGpG1Hr4gb7S4zldUQ95HR
         PJqXft7W7CEvxAL7WZ9OZXqFpmJRGDynmECqAYlpHlLf0Z45RPpbPFzHfAypyKkqrYkl
         9rNuD8vnjOGC4vKbvN1xrdcC3H5TPafapALevlWQhTwQW7yasLsA8iRCRyJxAQFWYqQO
         O1GtKmunY21W47OmOgtpUC+Yv2WK8uftsBUC+wEbm3tVIgMCfS1z7Hsxb9dVlPpe/+S5
         IfjKf5ZQnrs3EIpj5w4HOh0etmYZSwvbytiwSLxlGuhUxHFVgYERSAuNWK6g8cMaYVPh
         mFgQ==
X-Gm-Message-State: AOAM533abR02C5eZ2L6CXvfmxbqpprKzQgfPO3SypoUIOULQ4wzgG+z/
        4ZaOFZRM2TItGCB/bzrAYoU=
X-Google-Smtp-Source: ABdhPJxyn2xuG80U+SXHgd1NCntqw7s6KhVXO/7VXrjrexxIiOWCkyV1JlwgzlIBdN+psfQDbKvSIg==
X-Received: by 2002:a63:5852:: with SMTP id i18mr8939381pgm.337.1617042827282;
        Mon, 29 Mar 2021 11:33:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x11sm1151158pjh.0.2021.03.29.11.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:33:46 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] mm: migrate: teach migrate_misplaced_page() about THP
Date:   Mon, 29 Mar 2021 11:33:09 -0700
Message-Id: <20210329183312.178266-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329183312.178266-1-shy828301@gmail.com>
References: <20210329183312.178266-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In the following patch the migrate_misplaced_page() will be used to migrate THP
for NUMA faul too.  Prepare to deal with THP.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/migrate.h | 6 ++++--
 mm/memory.c             | 2 +-
 mm/migrate.c            | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3a389633b68f..6abd34986cc5 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -102,14 +102,16 @@ static inline void __ClearPageMovable(struct page *page)
 #ifdef CONFIG_NUMA_BALANCING
 extern bool pmd_trans_migrating(pmd_t pmd);
 extern int migrate_misplaced_page(struct page *page,
-				  struct vm_area_struct *vma, int node);
+				  struct vm_area_struct *vma, int node,
+				  bool compound);
 #else
 static inline bool pmd_trans_migrating(pmd_t pmd)
 {
 	return false;
 }
 static inline int migrate_misplaced_page(struct page *page,
-					 struct vm_area_struct *vma, int node)
+					 struct vm_area_struct *vma, int node,
+					 bool compound)
 {
 	return -EAGAIN; /* can't migrate now */
 }
diff --git a/mm/memory.c b/mm/memory.c
index 003bbf3187d4..7fed578bdc31 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4169,7 +4169,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	}
 
 	/* Migrate to the requested node */
-	migrated = migrate_misplaced_page(page, vma, target_nid);
+	migrated = migrate_misplaced_page(page, vma, target_nid, false);
 	if (migrated) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
diff --git a/mm/migrate.c b/mm/migrate.c
index 62b81d5257aa..9c4ae5132919 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2127,7 +2127,7 @@ static inline bool is_shared_exec_page(struct vm_area_struct *vma,
  * the page that will be dropped by this function before returning.
  */
 int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
-			   int node)
+			   int node, bool compound)
 {
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated;
-- 
2.26.2


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAF5C433ED
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9527F61074
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352093AbhERUKH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 16:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352071AbhERUJ5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 16:09:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043DC061763;
        Tue, 18 May 2021 13:08:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v13so5725582ple.9;
        Tue, 18 May 2021 13:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vcL4h8Y/iDJ4PQ//oXXgHbE7D0ndwuNE52sYaiQ5uA=;
        b=Rm/Otlj3gP5XkV3BLLxJkLQZNy2jj12x4U46YT0W9OzEwpis3BcOIrYA7TVCiGcBYd
         Y/A52de9C1ucmsAiRKng/fYtrQYoCX40xawvO30vOcJUOan7Bv2m4ddeDNmr4hxw0Qq0
         6jl+8hWGd+pTu+rgkD94iUuIYKjREOUB2cvP2M5h11Udgoyr7RPzlPbEi5XXf4WweaUf
         ZpLLVOF0qWA1+HfY6ZP6JGee3F1z5RIbsZofK3zJeI+YbVgxyJb61AlXkNcywq7xNgtx
         S8bSVLZUqAGKZLV9CHJpPhGdkhrgfZCRAoZ+R2kGYxTIKwp5+kZWKvxXdkwpQeMKM6cu
         +FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vcL4h8Y/iDJ4PQ//oXXgHbE7D0ndwuNE52sYaiQ5uA=;
        b=snS1imFqURXbtEa5SVXsZh718Vri6BNxqIQQhyAbqV+o+iOsdNiUrhn/7afxVvFPmw
         qn7WSeaIkZG+CNKlGcChGO96lLNAGHOgd6Mp4YZjv7AN6aUq/ArtD7G475fQ4nXk4ziV
         JpT954mnNCB7pIqHxAueizgGFWdjnUca16VXnqGnzdfAHf1AWQMxBPlW1F6q1T9OolMW
         8hQ/aYue0aBHd4iWm8oJD5AUK67YtjImAsTUof2Zq19esSG2uD2oiCXmuJU/tfogwuSG
         dgJMfz9IyUjUhHtxpRZzYQ5EoiUL+woHRXDFJjo9RoqpudW9Zi3CZZI3q1PJLM7kPBNv
         o6Zg==
X-Gm-Message-State: AOAM532yxA1PLeDO5wvLfYLFj5xPDglvGSiipzeR0RGUShfqD5de0SDV
        De9d922tMWXhq6RAheDPl+E=
X-Google-Smtp-Source: ABdhPJzHjDupKD9HBvIBLGRi6l5SuWQ81rgs7GzcOZnGf3LhF6AGiUZhf89yxQ3FkYWXt210nsqHGw==
X-Received: by 2002:a17:902:8c91:b029:f3:b4da:4600 with SMTP id t17-20020a1709028c91b02900f3b4da4600mr3168651plo.30.1621368512990;
        Tue, 18 May 2021 13:08:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id r11sm13456600pgl.34.2021.05.18.13.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:08:32 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        ying.huang@intel.com, mhocko@suse.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 7/7] mm: thp: skip make PMD PROT_NONE if THP migration is not supported
Date:   Tue, 18 May 2021 13:08:01 -0700
Message-Id: <20210518200801.7413-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210518200801.7413-1-shy828301@gmail.com>
References: <20210518200801.7413-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

A quick grep shows x86_64, PowerPC (book3s), ARM64 and S390 support both
NUMA balancing and THP.  But S390 doesn't support THP migration so NUMA
balancing actually can't migrate any misplaced pages.

Skip make PMD PROT_NONE for such case otherwise CPU cycles may be wasted
by pointless NUMA hinting faults on S390.

Acked-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/huge_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b8526b9b041a..fb984ef5a761 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1735,6 +1735,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
  * Returns
  *  - 0 if PMD could not be locked
  *  - 1 if PMD was locked but protections unchanged and TLB flush unnecessary
+ *      or if prot_numa but THP migration is not supported
  *  - HPAGE_PMD_NR if protections changed and TLB flush necessary
  */
 int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
@@ -1749,6 +1750,9 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
+	if (prot_numa && !thp_migration_supported())
+		return 1;
+
 	ptl = __pmd_trans_huge_lock(pmd, vma);
 	if (!ptl)
 		return 0;
-- 
2.26.2


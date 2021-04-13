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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2636DC433ED
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3EB611F2
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348445AbhDMVZE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348447AbhDMVZE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Apr 2021 17:25:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB12C061574;
        Tue, 13 Apr 2021 14:24:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m18so6730085plc.13;
        Tue, 13 Apr 2021 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cvqUdonBPmk2kB4YQmzOfQMs+Xj3C2NnGl5E7POeuCY=;
        b=a7HJlLdPXf1Ie2ABAbT1fZb01nutSrYXrK/qw9DCVz8ySPMt/orx2o9v45UX+/GsGJ
         9+c1FrvE21rBLQDcbm2CsgF95BEG3vUAoMTFqeFd76lG9GwE0je/Bt232Ci81FclqkUS
         O/mt92nq3yLV5l9asSY+bwhjw3VCRRL9tXBO+VhscJdAZLrGxHOc2d3n82CLAU3+NKKa
         2klPeH4N/FbCZ+ve4uSQCzKDPO2X+Bn0hQTK+vOCcm9gtZKjiexMKbP5IXCkQBYlSk8q
         KW7Ckt2010QZN2LgFkRIWQSm/LtT8kUfLosckW6yz0YLhkbxOJpnsJK5LuQWvMrQRxC8
         DASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cvqUdonBPmk2kB4YQmzOfQMs+Xj3C2NnGl5E7POeuCY=;
        b=KqblghPZD1hDrTvIbaEWT9WOW3u8ZyymvqXkWtvGxD45MfwSY1VFXp0BaRjPksflXe
         i6G7kTb7oKWKyqdQQELofjgzzmRwWWvS7jfOetu7LdJRXTZkKfrQFSkoxdPBGxnPOst9
         LTuqP3Pj6YGcmLEpWnd0olqpVWMo/fkpfOw2dCbeIPL2GiQO8RuSuPis+aSh/Gn39Kvl
         envAKCkSZjAg9huxqLoT9Op5ZtSMZYCOGsUW3vckn8qnKsP8SibfQEDFH8rIwDvDlr01
         xZRqc8iG1gCqbUk3hNADsM2/iNMKSKiBrMLoqGovgNdjf+qlClRs3nexwxfwc9nTpdnp
         Rszg==
X-Gm-Message-State: AOAM531iQQHXfsmv3S2VuCaKB0XFtv/KreEhIaN1T3AYYOsxXLAriqet
        rsXfd+SNDhEIyeMgf2XHKf4=
X-Google-Smtp-Source: ABdhPJx5XohOwflczqaouWLBS/EIq7j+NpJVG76BrGTlOzkAJUP2+sOE/hBZBuiYoDLI2FUEsUe7Uw==
X-Received: by 2002:a17:90a:bb0b:: with SMTP id u11mr2115705pjr.159.1618349083713;
        Tue, 13 Apr 2021 14:24:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw24sm3069345pjb.21.2021.04.13.14.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:24:42 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 7/7] mm: thp: skip make PMD PROT_NONE if THP migration is not supported
Date:   Tue, 13 Apr 2021 14:24:16 -0700
Message-Id: <20210413212416.3273-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210413212416.3273-1-shy828301@gmail.com>
References: <20210413212416.3273-1-shy828301@gmail.com>
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

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/huge_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94981907fd4c..f63445f3a17d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1741,6 +1741,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
  * Returns
  *  - 0 if PMD could not be locked
  *  - 1 if PMD was locked but protections unchanged and TLB flush unnecessary
+ *      or if prot_numa but THP migration is not supported
  *  - HPAGE_PMD_NR if protections changed and TLB flush necessary
  */
 int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
@@ -1755,6 +1756,9 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
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


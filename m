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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA46EC433E1
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8564361554
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhC2SeB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhC2Sdp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Mar 2021 14:33:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ACFC061574;
        Mon, 29 Mar 2021 11:33:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s11so4363914pfm.1;
        Mon, 29 Mar 2021 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYsTycVF/lf5Suqc/le+NiU66k2yrrkWCgrAdMasvHQ=;
        b=EwRoKPvlF7FWX9zpVxFvTd+9Gbfv+po1sNagOi00oOc4hc08cqDJyvrx/d9Nj7oiXe
         8QNj4EBukFzHkr2WG9TLfdQZnqiZuslYs9rrJA3QsutNFZqVYaEw7xiB4CwhLTbmU9XL
         HoTsTBCB3fYRFi4OZM5ZADxflQ5OiqwrSBnxO8vrMxYRZO05CzSn6wnGJDqOGwQUU20t
         /IK3nNMn8ZM+UlafqfarLjZJGVX2HrEwnE0HcjskCVHfm+ykKtnmRXxZE/tsnHVd7/hs
         xBr0jt4STA/4Zd+HAehlVwRRBEFaqdUk/hUixGzinRD20IS+IvGgnoDG7MNN8L3aQ1g+
         U0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYsTycVF/lf5Suqc/le+NiU66k2yrrkWCgrAdMasvHQ=;
        b=ooWPeQ+eo1njIU+hOypvslL2qJ7PGJMrRvf/ydthJFmMMYZf8bFYn5CiC8ufA099p+
         A1sJF11EyeDuSE/WGNfhch6Jt0PnxR6EeNvAxPepGlcjT5naqg/tKqugr/fWthm03loo
         /jHaBA9VB/SBGzPOBz76KzWkyHGkwBtQ5h3eLgT06F9ypToY+jpa9GL8DCzxaERc/MRp
         QOlHxwSgB+3cH/Z9g+AV/azeYHVWoPJjO91WJQK4Xkk53CqEw2jMsavUVgfPDi0Wy1NQ
         U5uz8yfwVdJMwzUvvEpMvMrCP4itpnXXazLz/Q1ZUtwReQ2ay3WjrBVxIOvsjt3eryrz
         YQog==
X-Gm-Message-State: AOAM532x0YmdKdgtggqa3uOoDkhjOWCOl9IUcH6517lMGvjWf5v9vyuN
        wEJLATYiGzQLpzFW7G/DEoM=
X-Google-Smtp-Source: ABdhPJyUwLv/aBlbpIZMlUWrgzevZQFoOKfq2lF1E8ilUH/PStCQt54+emM0GTOxUo68jPoyEJbLWA==
X-Received: by 2002:a63:1f1e:: with SMTP id f30mr25650718pgf.141.1617042825188;
        Mon, 29 Mar 2021 11:33:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x11sm1151158pjh.0.2021.03.29.11.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:33:44 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm: memory: make numa_migrate_prep() non-static
Date:   Mon, 29 Mar 2021 11:33:08 -0700
Message-Id: <20210329183312.178266-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329183312.178266-1-shy828301@gmail.com>
References: <20210329183312.178266-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The numa_migrate_prep() will be used by huge NUMA fault as well in the following
patch, make it non-static.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/internal.h | 3 +++
 mm/memory.c   | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1432feec62df..5ac525f364e6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -618,4 +618,7 @@ struct migration_target_control {
 	gfp_t gfp_mask;
 };
 
+int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
+		      unsigned long addr, int page_nid, int *flags);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index 33be5811ac65..003bbf3187d4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4078,9 +4078,8 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
-				unsigned long addr, int page_nid,
-				int *flags)
+int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
+		      unsigned long addr, int page_nid, int *flags)
 {
 	get_page(page);
 
-- 
2.26.2


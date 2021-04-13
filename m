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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F64C43460
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47CB61242
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbhDMVY5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhDMVY4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Apr 2021 17:24:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4300C06175F;
        Tue, 13 Apr 2021 14:24:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y2so8944225plg.5;
        Tue, 13 Apr 2021 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1ZBdEMq+3MjnBJy65dpAKj+xf+cUYHcWFOoNEXmf+M=;
        b=SvB9X8lBvtivut2BA5VI0UZ2NrD4YaT93CUQv7Q6uXHLcuHfXSTe5LcXe9DiMnEe0Z
         eVK6PupcUxdh0EFav96gan+YlGB2jFDZlBnVl0XlwTF4DAkE86Rvnl7DdRN12R2fItFL
         OFOZ+FyJBh0D875PdCB1VSZDiCk/D/oIvYU0W3FHQJmRctIEuSeKjqkLJ6fDEUW9sHJi
         Q3iA5gW5QEHByQ2mI85/5Q8wfINMRHx2JcMCPbesUHLRhDBDQ35rSKmxO/huerggbdPs
         T+VzKzVCiFxXIYn2xky/SNeVyWdA6wfjLaW/eFjOP8Kf5nlVae6e510LWUlOqONan4E4
         IlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1ZBdEMq+3MjnBJy65dpAKj+xf+cUYHcWFOoNEXmf+M=;
        b=cVcQgQ7LT6RI1MwnjdXYg4n3BaHqmW+iztXJOIzEfAwtNoniiyZYNXX/TAjPyspEwC
         eJuasvaWkKQflVAjqs/Za1k38BXV/Sgqpxzm6NR5BGhJ9bV4ElCn0tybCc+8c77oy37O
         5bBvjhmHuQMhXciuGcIu4++N+8ir5qTmgIFABaGViJmW4TFQyHwuaH3c9HLKUyv/njWb
         wNj2LARC8BKHyBMdnFZ3MXKwZi8ZgteF3Ef3d/j6F2GmdbXIxDqN0uPR6N/sRLksgOLd
         rgs6HQV3bsf6YNnPcZwFde6PFJnAWK5hfxi/ilDCFeReBdBf9Sg+qo1kURtOgDoQHgPQ
         3/PA==
X-Gm-Message-State: AOAM532Yuq6l0IPj4emKrSOkcPI4TLenoYqZmDUSuAXllk4JHZFJJ4JU
        5UvlfH2QQjlESEnuMjYE3Gw=
X-Google-Smtp-Source: ABdhPJw3JAQ5VVCViHQ3J/0GRFEvDaPxbEcy3o1iaSfzjbRncHPT6v4ClCmjTBDlc/t0lyCX1Iqn9g==
X-Received: by 2002:a17:90a:1188:: with SMTP id e8mr2144226pja.89.1618349073080;
        Tue, 13 Apr 2021 14:24:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw24sm3069345pjb.21.2021.04.13.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:24:32 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/7] mm: memory: make numa_migrate_prep() non-static
Date:   Tue, 13 Apr 2021 14:24:11 -0700
Message-Id: <20210413212416.3273-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210413212416.3273-1-shy828301@gmail.com>
References: <20210413212416.3273-1-shy828301@gmail.com>
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
index f469f69309de..b6f889d9c22d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -659,4 +659,7 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 
 void vunmap_range_noflush(unsigned long start, unsigned long end);
 
+int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
+		      unsigned long addr, int page_nid, int *flags);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index e0cbffeceb0b..bbb38066021a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4119,9 +4119,8 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
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


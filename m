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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803FAC43461
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642D06108D
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352057AbhERUJp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 16:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352047AbhERUJk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 16:09:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34DFC061760;
        Tue, 18 May 2021 13:08:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w1so5587790pfu.0;
        Tue, 18 May 2021 13:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/SAb4GmBYcE1RUtznSnoMs9bVmPh+Fmyxo0FfvNKkrs=;
        b=qTXntNfCiZwDGQEMfk2x4vS/wIHq7eq4cub1djq6BDGbwCBDouuYnFDUTkEFw3sFa/
         zXWj8Nzwt0d0vegm5TRX283djZ5lKzUQjPLS0U63PhhBUsHvuJ8Z79joQnd2+wXFpAns
         JmojxPXqAm+C6/6DgPjRJi0A2Sth57/vRHGakaHuw6l2qEBDclnVpk8tQXA3eQeMSxHy
         Y/tpdSguaArIG6gQtegc9JdHB3DAWLvaY5cKnmMxkJtKy/Fg9Y8Zyj/OjuauGSTkT48M
         +AaZmb86n3/I2wGP7wDfP7ikDmqCiHxKmGvCRdRNA1fxGVW0rDjnKBgFnJ/95hefATz4
         yIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/SAb4GmBYcE1RUtznSnoMs9bVmPh+Fmyxo0FfvNKkrs=;
        b=hWVlZjNSOHHC9wbj46IkR1ATJsCRiZNMINkjzvjOeQaHbSVp2rkzDHAcLgGxitNYfu
         2VlunDfjhERTuef48scQCBmq8zxGEZePydP4pUHaIToK89Ea17woCqPGVnA9mnz1r2gC
         XudkkhuEN8rR8fLS2EbpWQ5kYn4eq0eBl9veDwNkI9Ey/ksUNo+x/iL+mlcr2HJCBbk5
         4u+N6TKXO/Nupgxeif6+pgjZgpmV5bRo4/CS41gYRUnvGljyDcLBpwkH66UMUXw9+dJ1
         /gz6YhZN5Wob1SboTCt+cwc2xdhJqw9MkqlJJFsONs9OrToApUM3aTO76oQ4pTzKicOU
         KOkA==
X-Gm-Message-State: AOAM531S6yhsKRgp+oH7oOxABAAiegUrXEqizG4RwZfT4QatJaLsJxsj
        TcbtXXd5XYVm5Pn4cJEGCNk=
X-Google-Smtp-Source: ABdhPJzE79+gi8tH257NdQjO8LFM/9zlnlCFxksOY0avdvvvpts3EqA18TbkrxA3iV9ASa/7lH41oA==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr6792668pgp.138.1621368501491;
        Tue, 18 May 2021 13:08:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id r11sm13456600pgl.34.2021.05.18.13.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:08:20 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        ying.huang@intel.com, mhocko@suse.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/7] mm: memory: make numa_migrate_prep() non-static
Date:   Tue, 18 May 2021 13:07:56 -0700
Message-Id: <20210518200801.7413-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210518200801.7413-1-shy828301@gmail.com>
References: <20210518200801.7413-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The numa_migrate_prep() will be used by huge NUMA fault as well in the following
patch, make it non-static.

Acked-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/internal.h | 3 +++
 mm/memory.c   | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8a176d1d0176..28fc471b4669 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -653,4 +653,7 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 
 void vunmap_range_noflush(unsigned long start, unsigned long end);
 
+int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
+		      unsigned long addr, int page_nid, int *flags);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index f9df3ab12813..a2f2c2a8d28e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4129,9 +4129,8 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
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


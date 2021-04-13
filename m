Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E2C433B4
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821CA611F2
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhDMVY4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbhDMVYz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Apr 2021 17:24:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71398C061574;
        Tue, 13 Apr 2021 14:24:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j7so8947989plx.2;
        Tue, 13 Apr 2021 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TjUgcmFgfVUvxEgmX1mTT6tYY/s/MxXmpJtENaIxR0Y=;
        b=WHt03bHYh693At+HejleiJT5QnmfyIMK2f+Fr/QYvCch1IguEoJKhBNalXI7wTWcDJ
         aj2guXQUN6nRHP5aqfoctgDCZRcU+9RCwIoaziahPsOXBLZf/XPQNBw0bAaPEAWO2PVG
         36elbT/Ehn2HWNBDwpsTwHQfvWWyUkoGRYn/Zh8cwKZAe9BBGo1syrC8NpmvFT4/pkxr
         MXWh+8fl0+1d15nluwkLe9XR+GnGyxwkeG1TEsFG6HEZ1OwF+ogITKKjeIAa37OE44tF
         DSSx4zTujy+rU5Ee6laP+1H3wvLRqAqkThDA+u1QlR8fwVsmxE8dSbGUaZyljZkYQaiK
         rjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TjUgcmFgfVUvxEgmX1mTT6tYY/s/MxXmpJtENaIxR0Y=;
        b=uQI5RSTOexVTJeRA9kkYr1sHh9CHlsNJLA9+gjRSFpjTdeh1iBvk2apdi8OPLmxfnb
         0yKMEWkcjW/TncIrGOfZkw9yl6MLNmWz4hdIANaXWGWa4s4d2dLH4qZMXYJgvftTfLAM
         jBHrnPfcLvgtYOKnV7+MJS0QsF8rtj9Dz4vMaPvuExduR+yZXtJAmWh1HsI+d8Fi1MmY
         /QZJK7Qah+YzMcbuvEakXNBLTImH8YUO7vGbC53LxnZeAQt2AajlM6SjLuzEqZSAEMih
         32XwFfn1m7gZMih1qZbC9sTKd3P919sDzcQ7xhba0KP9qzi9hg1bi+He4cIDg2/zNe8C
         kzrA==
X-Gm-Message-State: AOAM5328PXdfXHVfZyMdHpbJPoewS0DLZY/e1gKcs09/y8qC8i7hAhLG
        durfDrVe4KP6inHmOBk+VVQ=
X-Google-Smtp-Source: ABdhPJwG+h4Eaee+6xKwhiomhLOrGif7IjgvEYV2eR4WT8U78sOVrCpxXeFTL0gfL/O99D7EdyfIcg==
X-Received: by 2002:a17:90a:5884:: with SMTP id j4mr2183180pji.33.1618349068996;
        Tue, 13 Apr 2021 14:24:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw24sm3069345pjb.21.2021.04.13.14.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:24:28 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 RFC PATCH 0/7] mm: thp: use generic THP migration for NUMA hinting fault
Date:   Tue, 13 Apr 2021 14:24:09 -0700
Message-Id: <20210413212416.3273-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


Changelog:
v1 --> v2:
    * Adopted the suggestion from Gerald Schaefer to skip huge PMD for S390
      for now.
    * Used PageTransHuge to distinguish base page or THP instead of a new
      parameter for migrate_misplaced_page() per Huang Ying.
    * Restored PMD lazily to avoid unnecessary TLB shootdown per Huang Ying.
    * Skipped shared THP.
    * Updated counters correctly.
    * Rebased to linux-next (next-20210412).

When the THP NUMA fault support was added THP migration was not supported yet.
So the ad hoc THP migration was implemented in NUMA fault handling.  Since v4.14
THP migration has been supported so it doesn't make too much sense to still keep
another THP migration implementation rather than using the generic migration
code.  It is definitely a maintenance burden to keep two THP migration
implementation for different code paths and it is more error prone.  Using the
generic THP migration implementation allows us remove the duplicate code and
some hacks needed by the old ad hoc implementation.

A quick grep shows x86_64, PowerPC (book3s), ARM64 ans S390 support both THP
and NUMA balancing.  The most of them support THP migration except for S390.
Zi Yan tried to add THP migration support for S390 before but it was not
accepted due to the design of S390 PMD.  For the discussion, please see:
https://lkml.org/lkml/2018/4/27/953.

Per the discussion with Gerald Schaefer in v1 it is acceptible to skip huge
PMD for S390 for now.

I saw there were some hacks about gup from git history, but I didn't figure out
if they have been removed or not since I just found FOLL_NUMA code in the current
gup implementation and they seems useful.

I'm trying to keep the behavior as consistent as possible between before and after.
But there is still some minor disparity.  For example, file THP won't
get migrated at all in old implementation due to the anon_vma check, but
the new implementation doesn't need acquire anon_vma lock anymore, so
file THP might get migrated.  Not sure if this behavior needs to be
kept.

Patch #1 ~ #2 are preparation patches.
Patch #3 is the real meat.
Patch #4 ~ #6 keep consistent counters and behaviors with before.
Patch #7 skips change huge PMD to prot_none if thp migration is not supported.

Yang Shi (7):
      mm: memory: add orig_pmd to struct vm_fault
      mm: memory: make numa_migrate_prep() non-static
      mm: thp: refactor NUMA fault handling
      mm: migrate: account THP NUMA migration counters correctly
      mm: migrate: don't split THP for misplaced NUMA page
      mm: migrate: check mapcount for THP instead of ref count
      mm: thp: skip make PMD PROT_NONE if THP migration is not supported

 include/linux/huge_mm.h |   9 ++---
 include/linux/migrate.h |  23 -----------
 include/linux/mm.h      |   3 ++
 mm/huge_memory.c        | 156 +++++++++++++++++++++++++-----------------------------------------------
 mm/internal.h           |  21 ++--------
 mm/memory.c             |  31 +++++++--------
 mm/migrate.c            | 204 +++++++++++++++++++++--------------------------------------------------------------------------
 7 files changed, 123 insertions(+), 324 deletions(-)


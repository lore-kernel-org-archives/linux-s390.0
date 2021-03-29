Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F645C433DB
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682C960231
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhC2Sd5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhC2Sdl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Mar 2021 14:33:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0572C061574;
        Mon, 29 Mar 2021 11:33:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w11so4826776ply.6;
        Mon, 29 Mar 2021 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=01YFv97u/1C+DtxnTXcB2+iBR0vlWHdf1wN2Z9wyQP0=;
        b=R+RAYtH5b/2luX6Z/fzVxj5Pf7lBMY6Y0G4BaJZQK3CDPRKsc1tkqC1WxVZTIn4ymQ
         BZ5D+tFIUymF0DdYXm237HMelyjQgMpgw5NfFzrBS9+zJrCGtmb4f3vlPIs+4xgiomeH
         tgh+o444gXEiLs5179rBwEKwswafgrCbzbeplus/1ZHk7JmX/T5S4d4Q/302Na6I57ld
         ltGVZ4sHgR/S7CTbJbx70pyXtGfHV/LVWzb+bNH6cGKnBUrpe7j9cPSPn3yQqLBxJPqi
         xSa1URtLekNuX8WKwQaBi+Y9RYVQziPRFzd542Nwko7pvFDrDn1kysV+3Z6iQpZ1R92H
         xBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=01YFv97u/1C+DtxnTXcB2+iBR0vlWHdf1wN2Z9wyQP0=;
        b=nFkhgvgBNFxVYnmZZcq5HOiGrAACR2gvdWjoZKaSEZX1zxpF4iN/uwTJ1zGhUiOsXO
         9oU/kO2MIJlO89/b62TIT9EWahthzKQk7UlJx2PLI+4LE2Tnr2hm0izX7Z8ye0a0NAX+
         elFVQhFPhbR+XlOSUu5NslqaXnOGw/VWngrXJOHe4nsBNq7jRgTnZ9v+q02S6ztLzlYU
         uuQtjSe4iKRZgZGiSfOje3gFp9wJWs5+4wc6FHrpBZ5OZV8jzgotePHNRo9sPZFtD2aK
         ul/wFx6SoGofG7BSkqDZbcYtLLABpfyj8yVGrKeBSw9txMEpzEptvna67icD0nkM2GEY
         SDIQ==
X-Gm-Message-State: AOAM5319xTOGp2p5DQH/tlc4IUqD+bRKyucDX6kd5Le7Kb4xFY2rkne3
        5rG3Dc2+tstbA9S4oznrEFjsO/niIIo=
X-Google-Smtp-Source: ABdhPJzqbTDMbRyAcrawqKDPJ/vLTMHWAlAj3tjICANCsgQBGOUdEwvo91OavTeI0XLhTjnUiBPlSw==
X-Received: by 2002:a17:902:ed84:b029:e7:1f2b:1eb4 with SMTP id e4-20020a170902ed84b02900e71f2b1eb4mr18187086plj.74.1617042820542;
        Mon, 29 Mar 2021 11:33:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x11sm1151158pjh.0.2021.03.29.11.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:33:39 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] mm: thp: use generic THP migration for NUMA hinting fault
Date:   Mon, 29 Mar 2021 11:33:06 -0700
Message-Id: <20210329183312.178266-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


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

I'm not expert on S390 so not sure if it is feasible to support THP migration
for S390 or not.  If it is not feasible then the patchset may make THP NUMA
balancing not be functional on S390.  Not sure if this is a show stopper although
the patchset does simplify the code a lot.  Anyway it seems worth posting the
series to the mailing list to get some feedback.

Patch #1 ~ #3 are preparation and clean up patches.
Patch #4 is the real meat.
Patch #5 keep THP not split if migration is failed for NUMA hinting.
Patch #6 removes a hack about page refcount.

I saw there were some hacks about gup from git history, but I didn't figure out
if they have been removed or not since I just found FOLL_NUMA code in the current
gup implementation and they seems useful.


Yang Shi (6):
      mm: memory: add orig_pmd to struct vm_fault
      mm: memory: make numa_migrate_prep() non-static
      mm: migrate: teach migrate_misplaced_page() about THP
      mm: thp: refactor NUMA fault handling
      mm: migrate: don't split THP for misplaced NUMA page
      mm: migrate: remove redundant page count check for THP

 include/linux/huge_mm.h |   9 ++---
 include/linux/migrate.h |  29 ++-------------
 include/linux/mm.h      |   1 +
 mm/huge_memory.c        | 141 +++++++++++++++++++---------------------------------------------------
 mm/internal.h           |   3 ++
 mm/memory.c             |  33 ++++++++---------
 mm/migrate.c            | 190 ++++++++++++++---------------------------------------------------------------------------------
 7 files changed, 94 insertions(+), 312 deletions(-)


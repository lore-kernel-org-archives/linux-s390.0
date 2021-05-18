Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1E7C433ED
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF76108D
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 20:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352025AbhERUJg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhERUJg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 16:09:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E142C061573;
        Tue, 18 May 2021 13:08:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c17so8245465pfn.6;
        Tue, 18 May 2021 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwqSjjRukmgayPiEHG6XgWTpxGas16u3ual5V3bfHmw=;
        b=Y336uSVRoKiv8jIb6en3BRJS3t7TxflPrXeWFsA7qKyep4LpqEJJIxHjMuuKRTFdaN
         e8SwToUVC3qxaGZe7xH+7sTeuVbT6p9wh7wRUHrcesIcB5dtnsMYcIOR1MWgv8HzvahB
         YxesrTNGVqcxlEbP1LLi6X95ZRjZZ/GBHV8ghJEaeb6jnfjrWGkUFtg3Df+pKlVAi1Hg
         x9fwbGTFH6/F33uhkDeX+j27AJUZA+ovqg0gEb5TphWfVl24CYhZWL/YU50ldYmRk5Tk
         jzsJ/AG40yFJjOYep1UFmtxPTXSjkZR8SDym75KKJ4/ia7dDqxt/XRuTVURFa1h4vWPR
         OxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwqSjjRukmgayPiEHG6XgWTpxGas16u3ual5V3bfHmw=;
        b=cDeKItDT9EmaFu3pfpP2qGgf8dgQJadWkq08T1BsujfHrF3EfXNbhZwnynCuRpxB51
         G2Vbi6Ut/E/2m1IeLVW52ZH/BkP5QJlQ8v+XQ4xyUP5BsXA/+PLEdtpJbTKma/Hl3vqh
         M8t2bQ74rFtVrmoP0QNgME+Z2mZBvpT3yfE96LSqu5c7ivwj/FJu+Ps4NBAV/KbEc/1R
         1HbRlQFvmTxEchwm5E8QlDGUv+ORFNP7bPE36MxWgOFdNgEi9l2mlBqvSyrz5WBNi8t2
         IiQjGNj3pCa/fSJNNJ5zXPrVYZcByrGgNtdQQEDMgRBAD1TFUKO+k3Z1vyyFPi26P0oI
         RgLA==
X-Gm-Message-State: AOAM532qtK8GMeegMIoKQbyPGwhWOYlXMhjA1mpSd0YR8kQ2Yg+E3NRB
        ZOwx/O0U+4+XXVsg1i72LLc=
X-Google-Smtp-Source: ABdhPJzbvDSjO8uCvkwrDXK0OBjaadSCCQZhRcbbnch8QkPAaHiLq0lFgS9zqSFgceSSDGzu7uXb0A==
X-Received: by 2002:a63:364f:: with SMTP id d76mr6736599pga.311.1621368496551;
        Tue, 18 May 2021 13:08:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id r11sm13456600pgl.34.2021.05.18.13.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:08:15 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        ying.huang@intel.com, mhocko@suse.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 0/7] mm: thp: use generic THP migration for NUMA hinting fault
Date:   Tue, 18 May 2021 13:07:54 -0700
Message-Id: <20210518200801.7413-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


Changelog
---------
v2 --> v3:
    * Made orig_pte and orig_pmd a union per Mel (patch 1/7).
    * Renamed pmd and oldpmd in patch 3/7 per Huang Ying.
    * Used total_mapcount() instead of page_mapcount() in patch 6/7.
    * Collected ack tags from Mel.
    * Rebased to linux-next-20210513.
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

Patch #1 ~ #2 are preparation patches.
Patch #3 is the real meat.
Patch #4 ~ #6 keep consistent counters and behaviors with before.
Patch #7 skips change huge PMD to prot_none if thp migration is not supported.


Test
----
Did some tests to measure the latency of do_huge_pmd_numa_page.
The test VM has 80 vcpus and 64G memory. The test would create 2
processes to consume 128G memory together which would incur memory
pressure to cause THP splits. And it also creates 80 processes to hog
cpu, and the memory consumer processes are bound to different nodes
periodically in order to increase NUMA faults.

The below test script is used:

echo 3 > /proc/sys/vm/drop_caches

# Run stress-ng for 24 hours
./stress-ng/stress-ng --vm 2 --vm-bytes 64G --timeout 24h &
PID=$!

./stress-ng/stress-ng --cpu $NR_CPUS --timeout 24h &

# Wait for vm stressors forked
sleep 5

PID_1=`pgrep -P $PID | awk 'NR == 1'`
PID_2=`pgrep -P $PID | awk 'NR == 2'`

JOB1=`pgrep -P $PID_1`
JOB2=`pgrep -P $PID_2`

# Bind load jobs to different nodes periodically to force generate
# cross node memory access
while [ -d "/proc/$PID" ]
do
        taskset -apc 8 $JOB1
        taskset -apc 8 $JOB2
        sleep 300
        taskset -apc 58 $JOB1
        taskset -apc 58 $JOB2
        sleep 300
done

With the above test the histogram of latency of do_huge_pmd_numa_page
is as shown below. Since the number of do_huge_pmd_numa_page varies
drastically for each run (should be due to scheduler), so I converted
the raw number to percentage.

                             patched               base
@us[stress-ng]:
[0]                          3.57%                 0.16%
[1]                          55.68%                18.36%
[2, 4)                       10.46%                40.44%
[4, 8)                       7.26%                 17.82%
[8, 16)                      21.12%                13.41%
[16, 32)                     1.06%                 4.27%
[32, 64)                     0.56%                 4.07%
[64, 128)                    0.16%                 0.35%
[128, 256)                   < 0.1%                < 0.1%
[256, 512)                   < 0.1%                < 0.1%
[512, 1K)                    < 0.1%                < 0.1%
[1K, 2K)                     < 0.1%                < 0.1%
[2K, 4K)                     < 0.1%                < 0.1%
[4K, 8K)                     < 0.1%                < 0.1%
[8K, 16K)                    < 0.1%                < 0.1%
[16K, 32K)                   < 0.1%                < 0.1%
[32K, 64K)                   < 0.1%                < 0.1%

Per the result, patched kernel is even slightly better than the base
kernel. I think this is because the lock contention against THP split
is less than base kernel due to the refactor.


To exclude the affect from THP split, I also did test w/o memory
pressure. No obvious regression is spotted. The below is the test
result *w/o* memory pressure.
                           patched                  base
@us[stress-ng]:
[0]                        7.97%                   18.4%
[1]                        69.63%                  58.24%
[2, 4)                     4.18%                   2.63%
[4, 8)                     0.22%                   0.17%
[8, 16)                    1.03%                   0.92%
[16, 32)                   0.14%                   < 0.1%
[32, 64)                   < 0.1%                  < 0.1%
[64, 128)                  < 0.1%                  < 0.1%
[128, 256)                 < 0.1%                  < 0.1%
[256, 512)                 0.45%                   1.19%
[512, 1K)                  15.45%                  17.27%
[1K, 2K)                   < 0.1%                  < 0.1%
[2K, 4K)                   < 0.1%                  < 0.1%
[4K, 8K)                   < 0.1%                  < 0.1%
[8K, 16K)                  0.86%                   0.88%
[16K, 32K)                 < 0.1%                  0.15%
[32K, 64K)                 < 0.1%                  < 0.1%
[64K, 128K)                < 0.1%                  < 0.1%
[128K, 256K)               < 0.1%                  < 0.1%

The series also survived a series of tests that exercise NUMA balancing
migrations by Mel.


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


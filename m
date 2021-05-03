Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27CBC433B4
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 21:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB259611CD
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 21:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhECV7P (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhECV7P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 May 2021 17:59:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D2DC061573;
        Mon,  3 May 2021 14:58:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n25so8139664edr.5;
        Mon, 03 May 2021 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLMKm/ZQSm5fL9y/P+Fadbw94OoQzyxeONFs/WIU4Ug=;
        b=kyYD8cE5UO2LmEpD13MO9Bhs//1GxGUvwlPGPIMSNNPbV8vzgnoVCpb03Ns+9UOKJc
         P07WaocCOk4SWFIVIw16+N35lQqcDB+0+D/FPZy72/vomdP0KfoLxixVgAh/UohamQe8
         HCrNJWar/bkwxyTC4cT+NGT7G37zL5FnYL+WjZK/m9jPTuo9PjGH6hxth8BFM5SDPK3j
         MJZI6tS/uSbOPv6wwPalfZFqDd4+qHQiBQNxSWGkQEDdKVBJ64s8+FZhxGuz2RMwOUzh
         +3pqNc1GDQOXkiKdOCRYLAitTmIB6t8Xsq9VXDIGG8WMKgU/rG9iakNefsfnU8iBCDJe
         JiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLMKm/ZQSm5fL9y/P+Fadbw94OoQzyxeONFs/WIU4Ug=;
        b=F+cvpdDA0FT9S+U3aIxbOFGf8xVRTF5Acgzd2FV+W1li02yjBS/oGMSL/4mgUvF53f
         AHPBtKpBtcizJuR5FmEzClLKH14hcxm6eE1pDulkQN/V9m/Sa5MZmJHtgfa62mhARf55
         PJL+UqQTl8b975urt13u35c8dPAtc58R6cJxaLaGr/Ko/9XrCBndPw7ehWZUsS2W/3dr
         R7DWkcDW+nZHH+/69Xi5czaEAM6G/5KTIcVQiBH3SrosQ3gm9S1YVR6q5Y2iwJpff9D0
         zSrCF0S4vP/uFbPUCdw3IGBQpXMPTUSqTtN4ngdeWER0ICy/pABZVt0mN0OS/Macqpkb
         8PLA==
X-Gm-Message-State: AOAM5321E/WvCF+tynU73Z++AD/QpvFoT9IH+J+4d1vI8mnOudXM/aYN
        xbBbepIxjLQZ+I8RZ1CT20Dp0NgOgTGBKZ1R5vc=
X-Google-Smtp-Source: ABdhPJy+5zCvRdE1afqItdM+szbgQoyqG8qSWXEah2nDsB+2CYd56f2ZtI1UoT3/5WRR2zdGcykKPiiVCI6dVCXUu+o=
X-Received: by 2002:aa7:cc03:: with SMTP id q3mr22960892edt.366.1620079099524;
 Mon, 03 May 2021 14:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210413212416.3273-1-shy828301@gmail.com>
In-Reply-To: <20210413212416.3273-1-shy828301@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 3 May 2021 14:58:07 -0700
Message-ID: <CAHbLzkoARSnVpi4Ty7zj6znyqpS2YdvZ6VY2CXUDuGt7-iBY+g@mail.gmail.com>
Subject: Re: [v2 RFC PATCH 0/7] mm: thp: use generic THP migration for NUMA
 hinting fault
To:     Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Gently ping.

I also did some tests to measure the latency of do_huge_pmd_numa_page.
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

                                     patched                        base
@us[stress-ng]:
[0]                                  3.57%                         0.16%
[1]                                  55.68%                       18.36%
[2, 4)                             10.46%                        40.44%
[4, 8)                              7.26%                         17.82%
[8, 16)                            21.12%                       13.41%
[16, 32)                         1.06%                           4.27%
[32, 64)                         0.56%                           4.07%
[64, 128)                       0.16%                            0.35%
[128, 256)                     < 0.1%                          < 0.1%
[256, 512)                     < 0.1%                          < 0.1%
[512, 1K)                       < 0.1%                          < 0.1%
[1K, 2K)                         < 0.1%                          < 0.1%
[2K, 4K)                         < 0.1%                          < 0.1%
[4K, 8K)                         < 0.1%                          < 0.1%
[8K, 16K)                       < 0.1%                          < 0.1%
[16K, 32K)                     < 0.1%                          < 0.1%
[32K, 64K)                     < 0.1%                          < 0.1%

Per the result, patched kernel is even slightly better than the base
kernel. I think this is because the lock contention against THP split
is less than base kernel due to the refactor.


To exclude the affect from THP split, I also did test w/o memory
pressure. No obvious regression is spotted. The below is the test
result *w/o* memory pressure.
                                       patched
          base
@us[stress-ng]:
[0]                                      7.97%
        18.4%
[1]                                      69.63%
        58.24%
[2, 4)                                  4.18%
        2.63%
[4, 8)                                  0.22%
        0.17%
[8, 16)                                1.03%
       0.92%
[16, 32)                              0.14%
      < 0.1%
[32, 64)                              < 0.1%
      < 0.1%
[64, 128)                            < 0.1%
     < 0.1%
[128, 256)                          < 0.1%
     < 0.1%
[256, 512)                           0.45%
     1.19%
[512, 1K)                            15.45%
     17.27%
[1K, 2K)                               < 0.1%
       < 0.1%
[2K, 4K)                              < 0.1%
       < 0.1%
[4K, 8K)                              < 0.1%
       < 0.1%
[8K, 16K)                             0.86%
      0.88%
[16K, 32K)                           < 0.1%
     0.15%
[32K, 64K)                           < 0.1%
     < 0.1%
[64K, 128K)                         < 0.1%
    < 0.1%
[128K, 256K)                       < 0.1%                                 < 0.1%


On Tue, Apr 13, 2021 at 2:24 PM Yang Shi <shy828301@gmail.com> wrote:
>
>
> Changelog:
> v1 --> v2:
>     * Adopted the suggestion from Gerald Schaefer to skip huge PMD for S390
>       for now.
>     * Used PageTransHuge to distinguish base page or THP instead of a new
>       parameter for migrate_misplaced_page() per Huang Ying.
>     * Restored PMD lazily to avoid unnecessary TLB shootdown per Huang Ying.
>     * Skipped shared THP.
>     * Updated counters correctly.
>     * Rebased to linux-next (next-20210412).
>
> When the THP NUMA fault support was added THP migration was not supported yet.
> So the ad hoc THP migration was implemented in NUMA fault handling.  Since v4.14
> THP migration has been supported so it doesn't make too much sense to still keep
> another THP migration implementation rather than using the generic migration
> code.  It is definitely a maintenance burden to keep two THP migration
> implementation for different code paths and it is more error prone.  Using the
> generic THP migration implementation allows us remove the duplicate code and
> some hacks needed by the old ad hoc implementation.
>
> A quick grep shows x86_64, PowerPC (book3s), ARM64 ans S390 support both THP
> and NUMA balancing.  The most of them support THP migration except for S390.
> Zi Yan tried to add THP migration support for S390 before but it was not
> accepted due to the design of S390 PMD.  For the discussion, please see:
> https://lkml.org/lkml/2018/4/27/953.
>
> Per the discussion with Gerald Schaefer in v1 it is acceptible to skip huge
> PMD for S390 for now.
>
> I saw there were some hacks about gup from git history, but I didn't figure out
> if they have been removed or not since I just found FOLL_NUMA code in the current
> gup implementation and they seems useful.
>
> I'm trying to keep the behavior as consistent as possible between before and after.
> But there is still some minor disparity.  For example, file THP won't
> get migrated at all in old implementation due to the anon_vma check, but
> the new implementation doesn't need acquire anon_vma lock anymore, so
> file THP might get migrated.  Not sure if this behavior needs to be
> kept.
>
> Patch #1 ~ #2 are preparation patches.
> Patch #3 is the real meat.
> Patch #4 ~ #6 keep consistent counters and behaviors with before.
> Patch #7 skips change huge PMD to prot_none if thp migration is not supported.
>
> Yang Shi (7):
>       mm: memory: add orig_pmd to struct vm_fault
>       mm: memory: make numa_migrate_prep() non-static
>       mm: thp: refactor NUMA fault handling
>       mm: migrate: account THP NUMA migration counters correctly
>       mm: migrate: don't split THP for misplaced NUMA page
>       mm: migrate: check mapcount for THP instead of ref count
>       mm: thp: skip make PMD PROT_NONE if THP migration is not supported
>
>  include/linux/huge_mm.h |   9 ++---
>  include/linux/migrate.h |  23 -----------
>  include/linux/mm.h      |   3 ++
>  mm/huge_memory.c        | 156 +++++++++++++++++++++++++-----------------------------------------------
>  mm/internal.h           |  21 ++--------
>  mm/memory.c             |  31 +++++++--------
>  mm/migrate.c            | 204 +++++++++++++++++++++--------------------------------------------------------------------------
>  7 files changed, 123 insertions(+), 324 deletions(-)
>

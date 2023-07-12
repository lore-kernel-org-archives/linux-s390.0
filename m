Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48A6EB64DD
	for <linux-s390@archiver.kernel.org>; Wed, 12 Jul 2023 04:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjGLE10 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 12 Jul 2023 00:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGLE1Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 12 Jul 2023 00:27:25 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D151F1722
        for <linux-s390@vger.kernel.org>; Tue, 11 Jul 2023 21:27:23 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-57eb0df5265so1528467b3.3
        for <linux-s390@vger.kernel.org>; Tue, 11 Jul 2023 21:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689136043; x=1691728043;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wiHFwa+qInqC9Ufc7qLGqz2T4+XJI6K3K6pkdSvL2BE=;
        b=YjT2iggkRTiXtZMR1jMLANF/DCx6aBNBHMVDVVl8Gr0GinPbSloyq6adfQMkbwXuDy
         4LOhxp9lsDQkNYPLAl5k89Ck7UzmU2gS51lf58HBHMNkZxeBrwzXKOfpjPMpHU7Xhn8z
         K9b44iVOIzPUbQ6ymuTwqdYb3uxH5ZNNlppLByjfI27io4ZaUeNDCqifG61+Enltfq1W
         Q4VeG3xJt0Bk+AP9vkRr0OjwSSW1svxOnjAGiUGPKap1kin/J6ow8NcPSugD6S/XzNDL
         Pw7KzGLDDMHF/NqW9CZBI1VUfB0aeFWeRbgCBvTEtczkxjQmMIk8cik2x0kBWOU3eCTM
         DkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689136043; x=1691728043;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiHFwa+qInqC9Ufc7qLGqz2T4+XJI6K3K6pkdSvL2BE=;
        b=lrAQNWaBoBsuaHfudHeevGz2iL5lirU6ouR1R4pMGDfkWmlvuDvonuYH/TJwP5H3P7
         iZVXXTmDYXynis2ycCnBxO8/qGYIpf4MhNT8IREfVnWMB2af7+3+VolvjOWCry4KLaQz
         cyImvVBDHzt9S9S8x/AOkXs5byERXdzkUS3LttjAy53TRj9sQh9n/gG4MF00rWL9orcU
         J9NkS8Vw1odgK7XeNXIMYzJxbJcLHYYMpnXRFtRlx8wfKCNRvoAl/0tWOEFidNgBb5ZV
         +N7sXESSFiiBJmTAkMl+5cBeIVEUnt9tqawwBmwQf84T9lY1AdFXTAC3l7s5RQfCqRGQ
         O/6g==
X-Gm-Message-State: ABy/qLaOgCr1lBredNrsk5rrreZHT1wurpLNk7obqegOKwaGJyP0BR5M
        hraTvWz+AkgIyhTRQywI+wA8qg==
X-Google-Smtp-Source: APBJJlF5lEOtFts7UwfGvvEUizjbQpUSNw8Id5rb3Vpn8mt/ge/Q6rrPqXyVhuX/GSF3C2Mj1ANz1w==
X-Received: by 2002:a81:91d2:0:b0:559:deed:f363 with SMTP id i201-20020a8191d2000000b00559deedf363mr16696703ywg.2.1689136042885;
        Tue, 11 Jul 2023 21:27:22 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i67-20020a0df846000000b005772f3fc0acsm972965ywf.44.2023.07.11.21.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:27:22 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:27:09 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 00/13] mm: free retracted page table by RCU
Message-ID: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Here is v3 of the series of patches to mm (and a few architectures), based
on v6.5-rc1 which includes the preceding two series (thank you!): in which
khugepaged takes advantage of pte_offset_map[_lock]() allowing for pmd
transitions.  Differences from v1 and v2 are noted patch by patch below.

This replaces the v2 "mm: free retracted page table by RCU"
https://lore.kernel.org/linux-mm/54cb04f-3762-987f-8294-91dafd8ebfb0@google.com/
series of 12 posted on 2023-06-20.

What is it all about?  Some mmap_lock avoidance i.e. latency reduction.
Initially just for the case of collapsing shmem or file pages to THPs:
the usefulness of MADV_COLLAPSE on shmem is being limited by that
mmap_write_lock it currently requires.

Likely to be relied upon later in other contexts e.g. freeing of
empty page tables (but that's not work I'm doing).  mmap_write_lock
avoidance when collapsing to anon THPs?  Perhaps, but again that's not
work I've done: a quick attempt was not as easy as the shmem/file case.

These changes (though of course not these exact patches) have been in
Google's data centre kernel for three years now: we do rely upon them.

Based on v6.5-rc1; and almost good on current mm-unstable or current
linux-next - just one patch conflicts, the 12/13: I'll reply to that
one with its mm-unstable or linux-next equivalent (vma_assert_locked()
has been added next to where vma_try_start_write() is being removed).

01/13 mm/pgtable: add rcu_read_lock() and rcu_read_unlock()s
      v3: same as v1
02/13 mm/pgtable: add PAE safety to __pte_offset_map()
      v3: same as v2
      v2: rename to pmdp_get_lockless_start/end() per Matthew;
          so use inlines without _irq_save(flags) macro oddity;
          add pmdp_get_lockless_sync() for use later in 09/13.
03/13 arm: adjust_pte() use pte_offset_map_nolock()
      v3: same as v1
04/13 powerpc: assert_pte_locked() use pte_offset_map_nolock()
      v3: same as v1
05/13 powerpc: add pte_free_defer() for pgtables sharing page
      v3: much simpler version, following suggestion by Jason
      v2: fix rcu_head usage to cope with concurrent deferrals;
          add para to commit message explaining rcu_head issue.
06/13 sparc: add pte_free_defer() for pte_t *pgtable_t
      v3: same as v2
      v2: use page_address() instead of less common page_to_virt();
          add para to commit message explaining simple conversion;
          changed title since sparc64 pgtables do not share page.
07/13 s390: add pte_free_defer() for pgtables sharing page
      v3: much simpler version, following suggestion by Gerald
      v2: complete rewrite, integrated with s390's existing pgtable
          management; temporarily using a global mm_pgtable_list_lock,
          to be restored to per-mm spinlock in a later followup patch.
08/13 mm/pgtable: add pte_free_defer() for pgtable as page
      v3: same as v2
      v2: add comment on rcu_head to "Page table pages", per JannH
09/13 mm/khugepaged: retract_page_tables() without mmap or vma lock
      v3: same as v2
      v2: repeat checks under ptl because UFFD, per PeterX and JannH;
          bring back mmu_notifier calls for PMD, per JannH and Jason;
          pmdp_get_lockless_sync() to issue missing interrupt if PAE.
10/13 mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()
      v3: updated to using ptent instead of *pte
      v2: first check VMA, in case page tables torn down, per JannH;
          pmdp_get_lockless_sync() to issue missing interrupt if PAE;
          moved mmu_notifier after step 1, reworked final goto labels.
11/13 mm/khugepaged: delete khugepaged_collapse_pte_mapped_thps()
      v3: rediffed
      v2: same as v1
12/13 mm: delete mmap_write_trylock() and vma_try_start_write()
      v3: rediffed (different diff needed for mm-unstable or linux-next)
      v2: same as v1
13/13 mm/pgtable: notes on pte_offset_map[_lock]()
      v3: new: JannH asked for more helpful comment, this is my attempt;
          could be moved to be the first in the series.

 arch/arm/mm/fault-armv.c            |   3 +-
 arch/powerpc/include/asm/pgalloc.h  |   4 +
 arch/powerpc/mm/pgtable-frag.c      |  29 +-
 arch/powerpc/mm/pgtable.c           |  16 +-
 arch/s390/include/asm/pgalloc.h     |   4 +
 arch/s390/mm/pgalloc.c              |  80 ++++-
 arch/sparc/include/asm/pgalloc_64.h |   4 +
 arch/sparc/mm/init_64.c             |  16 +
 include/linux/mm.h                  |  17 --
 include/linux/mm_types.h            |   4 +
 include/linux/mmap_lock.h           |  10 -
 include/linux/pgtable.h             |  10 +-
 mm/khugepaged.c                     | 481 +++++++++++-------------------
 mm/pgtable-generic.c                |  97 +++++-
 14 files changed, 404 insertions(+), 371 deletions(-)

Hugh

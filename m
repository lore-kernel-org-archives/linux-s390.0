Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F06C7EE29
	for <linux-s390@archiver.kernel.org>; Mon, 29 May 2023 06:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjE2GL3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 May 2023 02:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjE2GL1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 May 2023 02:11:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AFBB1
        for <linux-s390@vger.kernel.org>; Sun, 28 May 2023 23:11:25 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bacfb7acdb7so4576678276.0
        for <linux-s390@vger.kernel.org>; Sun, 28 May 2023 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685340684; x=1687932684;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zliJFPKkBRA/n2GaYWcI8flBsJ+sn1iKXV6efEOvVuc=;
        b=7B1W5MLwR/lNmx3BIWIEBSexKnAAtAeI5OObdohvQtJ0ya6QvwHlgYFcOox2PoWx79
         AqTZ5kdBzWLNorOsK4QCVE297PN18hQKAQbCdVGnbvFaS7kyYm3WQLVA/nvW5TUXBwEK
         caAcy7rQi84u8SNtdxTLyllY4LVN73jaN501s4k727QQrqblWsE0z78z1nbHIMjpBe5J
         U7bsOrnIMfDvYrfJ38H4/OhgD5cA+Y2quHyXE8xkEJQ1/qi+xCB9+P6Rf/V3USkqhcRr
         ADhdVtWOZGV+AvVYyI9ulfCMHPe9IScFN/bL7d58cmN+M8/9WGgQpLLoAa3PpgIRJ6V+
         lp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685340684; x=1687932684;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zliJFPKkBRA/n2GaYWcI8flBsJ+sn1iKXV6efEOvVuc=;
        b=BfteKBvN3G4zV+xrxKrV5u3eGUGzyn+t3S/a3EEHOi/b/jvV+PBIio/mJH/kgxC3Ek
         /3MbotwTMAvSLwkQ19hV7dEh1vkU/qQWUYkrwn+6YRl5xdbWEvmxm5MQTMZ4l6j0phnd
         btH+/NCToeJb1NYc0mVEFBbb2TkwPKFEdTPSXKmS45D/iZvvt12DHmYPDrIWCdT1Noet
         PXfZqbsT+ljL/+dikOo4pLoZAMgqGPW0NamcqOl8MgZdoI+BtGoi8LUpc+ExHvMW1iEp
         yZDPB7kC5KWJ95q6yHpkTL6chD4DJr4pbz1VQdMGzJmNYQm7BSW6k43bhQ6Hjyl0yQ+x
         Wufw==
X-Gm-Message-State: AC+VfDwE97IiKS50CK+qExPeQhm0KztFv0zsN/TQSv1Im6Iu1NfqHZwa
        BhpbUHX8xIRY6ogrMYx4O5shYg==
X-Google-Smtp-Source: ACHHUZ6vifKmHFoYdv3qrFkDElnMJbREaNq58bFiSjvre/dDskro6b5jD1pQPpN+OFNUHzxvXn3Qhw==
X-Received: by 2002:a25:d4b:0:b0:ba8:6530:d561 with SMTP id 72-20020a250d4b000000b00ba86530d561mr10306665ybn.30.1685340684077;
        Sun, 28 May 2023 23:11:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r63-20020a252b42000000b00b7b0aba5cccsm2703954ybr.22.2023.05.28.23.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:11:23 -0700 (PDT)
Date:   Sun, 28 May 2023 23:11:07 -0700 (PDT)
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
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 00/12] mm: free retracted page table by RCU
Message-ID: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Here is the third series of patches to mm (and a few architectures), based
on v6.4-rc3 with the preceding two series applied: in which khugepaged
takes advantage of pte_offset_map[_lock]() allowing for pmd transitions.

This follows on from the "arch: allow pte_offset_map[_lock]() to fail"
https://lore.kernel.org/linux-mm/77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com/
series of 23 posted on 2023-05-09,
and the "mm: allow pte_offset_map[_lock]() to fail"
https://lore.kernel.org/linux-mm/68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com/
series of 31 posted on 2023-05-21.

Those two series were "independent": neither depending for build or
correctness on the other, but both series needed before this third one
can safely make the effective changes.  I'll send v2 of those two series
in a couple of days, incorporating Acks and Revieweds and the minor fixes.

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

Based on the preceding two series over v6.4-rc3, but good over
v6.4-rc[1-4], current mm-everything or current linux-next.

01/12 mm/pgtable: add rcu_read_lock() and rcu_read_unlock()s
02/12 mm/pgtable: add PAE safety to __pte_offset_map()
03/12 arm: adjust_pte() use pte_offset_map_nolock()
04/12 powerpc: assert_pte_locked() use pte_offset_map_nolock()
05/12 powerpc: add pte_free_defer() for pgtables sharing page
06/12 sparc: add pte_free_defer() for pgtables sharing page
07/12 s390: add pte_free_defer(), with use of mmdrop_async()
08/12 mm/pgtable: add pte_free_defer() for pgtable as page
09/12 mm/khugepaged: retract_page_tables() without mmap or vma lock
10/12 mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()
11/12 mm/khugepaged: delete khugepaged_collapse_pte_mapped_thps()
12/12 mm: delete mmap_write_trylock() and vma_try_start_write()

 arch/arm/mm/fault-armv.c            |   3 +-
 arch/powerpc/include/asm/pgalloc.h  |   4 +
 arch/powerpc/mm/pgtable-frag.c      |  18 ++
 arch/powerpc/mm/pgtable.c           |  16 +-
 arch/s390/include/asm/pgalloc.h     |   4 +
 arch/s390/mm/pgalloc.c              |  34 +++
 arch/sparc/include/asm/pgalloc_64.h |   4 +
 arch/sparc/mm/init_64.c             |  16 ++
 include/linux/mm.h                  |  17 --
 include/linux/mm_types.h            |   2 +-
 include/linux/mmap_lock.h           |  10 -
 include/linux/pgtable.h             |   6 +-
 include/linux/sched/mm.h            |   1 +
 kernel/fork.c                       |   2 +-
 mm/khugepaged.c                     | 425 ++++++++----------------------
 mm/pgtable-generic.c                |  44 +++-
 16 files changed, 253 insertions(+), 353 deletions(-)

Hugh

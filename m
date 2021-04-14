Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E15FC433ED
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 17:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EC96105A
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 17:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbhDNRQU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Apr 2021 13:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhDNRQR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 14 Apr 2021 13:16:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF741C061574;
        Wed, 14 Apr 2021 10:15:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r128so7432038lff.4;
        Wed, 14 Apr 2021 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJQXEAKrIHFWn1sudHV/OeQTpWST1/mB/y/Z+J+ibCY=;
        b=eKXTqJfujAdVMW+kYIeXdTuOmOTty6jMqeNDA/7FXS4n/mt+fT1WyIGWgz7ORx2ZYl
         RbcyFraRKhrqgeOwM8tZRqvdpK53Ti4Hw6FOLhSb2uvigldYJrRAjYIpDKfxT+7xx0E7
         ScAodrdQFW9vrmhc138wQ+y/TJxXOBwdU08v2jx4qN24C4yNQt6OYY12HHCYWmIe/her
         cfQxNfXSDajYAY+NRIdy/yjNmNNBOSUoMcQzIa6QBC2FT1rbKzyfX7BBdi6+HvMrMx3A
         MqNAhnxjo3yIdAZ4H7UEpB1SWswjbriGyEctj1BxOEcst6RKRXf7qUpVkOIFrrqr3KWC
         Q+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJQXEAKrIHFWn1sudHV/OeQTpWST1/mB/y/Z+J+ibCY=;
        b=YR/QBZ2kg3me2dViC+qx4vTYW8UdN0ifdL88hJJJpzBZmhE0MQ1qkAt4EKk7LtGkqC
         VdWwfqVwb/buG6PedNrrpUe2oaUepPtYcIwnBVgse8e7PPfU2wgqJ/mgzTSOiUskpwp3
         Emaq0ilLewmLPBeUOonUn3Go4ay3AVvydCbxuvz1Hw+1yEJHboh0rDceGsyewUpEa+bz
         QRc/kOrfwu6wa5HdsKUSUIkRWOOJApFif0v+6PoGv6H6//YSxViz3UvqzxAZbUw06rHh
         HWTAVYJa1e86meD/NZPTEoVWe87X8G6YhmWhALo/A1CTTn/DJf8CpOrTDG0BKyUQylgx
         dwCw==
X-Gm-Message-State: AOAM532j+mzG77PpYD5Hp7i/GbnY2CMhQNc++SwB/rhi9CVqTNJVnd1Q
        7Mg9WGu2AohvEH1GqEFJpad3QAt5WkSFzJgFcfA=
X-Google-Smtp-Source: ABdhPJx1rAomw+Zvd4JKKgOb9hPHDz3M8W++z1hOKo+J4PQ50UXQ0NXfR1a2MDOhV7tNr65UeR2IxOWIJbJiNZeQVp8=
X-Received: by 2002:a19:f007:: with SMTP id p7mr9338067lfc.597.1618420553361;
 Wed, 14 Apr 2021 10:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210413212416.3273-1-shy828301@gmail.com> <20210413212416.3273-4-shy828301@gmail.com>
 <87o8ehshzw.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87o8ehshzw.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 14 Apr 2021 10:15:41 -0700
Message-ID: <CAHbLzkrWzhLL5DSS3a2SAnQz-Spjy3S-QyjFy3rkgqvOqCLqmA@mail.gmail.com>
Subject: Re: [v2 PATCH 3/7] mm: thp: refactor NUMA fault handling
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 13, 2021 at 7:44 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > When the THP NUMA fault support was added THP migration was not supported yet.
> > So the ad hoc THP migration was implemented in NUMA fault handling.  Since v4.14
> > THP migration has been supported so it doesn't make too much sense to still keep
> > another THP migration implementation rather than using the generic migration
> > code.
> >
> > This patch reworked the NUMA fault handling to use generic migration implementation
> > to migrate misplaced page.  There is no functional change.
> >
> > After the refactor the flow of NUMA fault handling looks just like its
> > PTE counterpart:
> >   Acquire ptl
> >   Prepare for migration (elevate page refcount)
> >   Release ptl
> >   Isolate page from lru and elevate page refcount
> >   Migrate the misplaced THP
> >
> > If migration is failed just restore the old normal PMD.
> >
> > In the old code anon_vma lock was needed to serialize THP migration
> > against THP split, but since then the THP code has been reworked a lot,
> > it seems anon_vma lock is not required anymore to avoid the race.
> >
> > The page refcount elevation when holding ptl should prevent from THP
> > split.
> >
> > Use migrate_misplaced_page() for both base page and THP NUMA hinting
> > fault and remove all the dead and duplicate code.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/migrate.h |  23 ------
> >  mm/huge_memory.c        | 143 ++++++++++----------------------
> >  mm/internal.h           |  18 ----
> >  mm/migrate.c            | 177 ++++++++--------------------------------
> >  4 files changed, 77 insertions(+), 284 deletions(-)
> >
> > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > index 4bb4e519e3f5..163d6f2b03d1 100644
> > --- a/include/linux/migrate.h
> > +++ b/include/linux/migrate.h
> > @@ -95,14 +95,9 @@ static inline void __ClearPageMovable(struct page *page)
> >  #endif
> >
> >  #ifdef CONFIG_NUMA_BALANCING
> > -extern bool pmd_trans_migrating(pmd_t pmd);
> >  extern int migrate_misplaced_page(struct page *page,
> >                                 struct vm_area_struct *vma, int node);
> >  #else
> > -static inline bool pmd_trans_migrating(pmd_t pmd)
> > -{
> > -     return false;
> > -}
> >  static inline int migrate_misplaced_page(struct page *page,
> >                                        struct vm_area_struct *vma, int node)
> >  {
> > @@ -110,24 +105,6 @@ static inline int migrate_misplaced_page(struct page *page,
> >  }
> >  #endif /* CONFIG_NUMA_BALANCING */
> >
> > -#if defined(CONFIG_NUMA_BALANCING) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> > -extern int migrate_misplaced_transhuge_page(struct mm_struct *mm,
> > -                     struct vm_area_struct *vma,
> > -                     pmd_t *pmd, pmd_t entry,
> > -                     unsigned long address,
> > -                     struct page *page, int node);
> > -#else
> > -static inline int migrate_misplaced_transhuge_page(struct mm_struct *mm,
> > -                     struct vm_area_struct *vma,
> > -                     pmd_t *pmd, pmd_t entry,
> > -                     unsigned long address,
> > -                     struct page *page, int node)
> > -{
> > -     return -EAGAIN;
> > -}
> > -#endif /* CONFIG_NUMA_BALANCING && CONFIG_TRANSPARENT_HUGEPAGE*/
> > -
> > -
> >  #ifdef CONFIG_MIGRATION
> >
> >  /*
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 35cac4aeaf68..94981907fd4c 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1418,93 +1418,21 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
> >  {
> >       struct vm_area_struct *vma = vmf->vma;
> >       pmd_t pmd = vmf->orig_pmd;
> > -     struct anon_vma *anon_vma = NULL;
> > +     pmd_t oldpmd;
>
> nit: the usage of oldpmd and pmd in the function appears not very
> consistent.  How about make oldpmd == vmf->orig_pmd always.  While make
> pmd the changed one?

Thanks for the suggestion. Yes, it seemed neater. Will fix it in the
next version.

>
> Best Regards,
> Huang, Ying
>
> >       struct page *page;
> >       unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> > -     int page_nid = NUMA_NO_NODE, this_nid = numa_node_id();
> > +     int page_nid = NUMA_NO_NODE;
> >       int target_nid, last_cpupid = -1;
> > -     bool page_locked;
> >       bool migrated = false;
> > -     bool was_writable;
> > +     bool was_writable = pmd_savedwrite(pmd);
> >       int flags = 0;
> >
> >       vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> > -     if (unlikely(!pmd_same(pmd, *vmf->pmd)))
> > -             goto out_unlock;
> > -
> > -     /*
> > -      * If there are potential migrations, wait for completion and retry
> > -      * without disrupting NUMA hinting information. Do not relock and
> > -      * check_same as the page may no longer be mapped.
> > -      */
> > -     if (unlikely(pmd_trans_migrating(*vmf->pmd))) {
> > -             page = pmd_page(*vmf->pmd);
> > -             if (!get_page_unless_zero(page))
> > -                     goto out_unlock;
> > +     if (unlikely(!pmd_same(pmd, *vmf->pmd))) {
> >               spin_unlock(vmf->ptl);
> > -             put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
> >               goto out;
> >       }
> >
> > -     page = pmd_page(pmd);
> > -     BUG_ON(is_huge_zero_page(page));
> > -     page_nid = page_to_nid(page);
> > -     last_cpupid = page_cpupid_last(page);
> > -     count_vm_numa_event(NUMA_HINT_FAULTS);
> > -     if (page_nid == this_nid) {
> > -             count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
> > -             flags |= TNF_FAULT_LOCAL;
> > -     }
> > -
> > -     /* See similar comment in do_numa_page for explanation */
> > -     if (!pmd_savedwrite(pmd))
> > -             flags |= TNF_NO_GROUP;
> > -
> > -     /*
> > -      * Acquire the page lock to serialise THP migrations but avoid dropping
> > -      * page_table_lock if at all possible
> > -      */
> > -     page_locked = trylock_page(page);
> > -     target_nid = mpol_misplaced(page, vma, haddr);
> > -     /* Migration could have started since the pmd_trans_migrating check */
> > -     if (!page_locked) {
> > -             page_nid = NUMA_NO_NODE;
> > -             if (!get_page_unless_zero(page))
> > -                     goto out_unlock;
> > -             spin_unlock(vmf->ptl);
> > -             put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
> > -             goto out;
> > -     } else if (target_nid == NUMA_NO_NODE) {
> > -             /* There are no parallel migrations and page is in the right
> > -              * node. Clear the numa hinting info in this pmd.
> > -              */
> > -             goto clear_pmdnuma;
> > -     }
> > -
> > -     /*
> > -      * Page is misplaced. Page lock serialises migrations. Acquire anon_vma
> > -      * to serialises splits
> > -      */
> > -     get_page(page);
> > -     spin_unlock(vmf->ptl);
> > -     anon_vma = page_lock_anon_vma_read(page);
> > -
> > -     /* Confirm the PMD did not change while page_table_lock was released */
> > -     spin_lock(vmf->ptl);
> > -     if (unlikely(!pmd_same(pmd, *vmf->pmd))) {
> > -             unlock_page(page);
> > -             put_page(page);
> > -             page_nid = NUMA_NO_NODE;
> > -             goto out_unlock;
> > -     }
> > -
> > -     /* Bail if we fail to protect against THP splits for any reason */
> > -     if (unlikely(!anon_vma)) {
> > -             put_page(page);
> > -             page_nid = NUMA_NO_NODE;
> > -             goto clear_pmdnuma;
> > -     }
> > -
> >       /*
> >        * Since we took the NUMA fault, we must have observed the !accessible
> >        * bit. Make sure all other CPUs agree with that, to avoid them
> > @@ -1531,43 +1459,60 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
> >                                             haddr + HPAGE_PMD_SIZE);
> >       }
> >
> > -     /*
> > -      * Migrate the THP to the requested node, returns with page unlocked
> > -      * and access rights restored.
> > -      */
> > +     oldpmd = pmd_modify(pmd, vma->vm_page_prot);
> > +     page = vm_normal_page_pmd(vma, haddr, oldpmd);
> > +     if (!page) {
> > +             spin_unlock(vmf->ptl);
> > +             goto out_map;
> > +     }
> > +
> > +     /* See similar comment in do_numa_page for explanation */
> > +     if (!was_writable)
> > +             flags |= TNF_NO_GROUP;
> > +
> > +     page_nid = page_to_nid(page);
> > +     last_cpupid = page_cpupid_last(page);
> > +     target_nid = numa_migrate_prep(page, vma, haddr, page_nid,
> > +                                    &flags);
> > +
> > +     if (target_nid == NUMA_NO_NODE) {
> > +             put_page(page);
> > +             goto out_map;
> > +     }
> > +
> >       spin_unlock(vmf->ptl);
> >
> > -     migrated = migrate_misplaced_transhuge_page(vma->vm_mm, vma,
> > -                             vmf->pmd, pmd, vmf->address, page, target_nid);
> > +     migrated = migrate_misplaced_page(page, vma, target_nid);
> >       if (migrated) {
> >               flags |= TNF_MIGRATED;
> >               page_nid = target_nid;
> > -     } else
> > +     } else {
> >               flags |= TNF_MIGRATE_FAIL;
> > +             vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> > +             if (unlikely(!pmd_same(pmd, *vmf->pmd))) {
> > +                     spin_unlock(vmf->ptl);
> > +                     goto out;
> > +             }
> > +             goto out_map;
> > +     }
> >
> > -     goto out;
> > -clear_pmdnuma:
> > -     BUG_ON(!PageLocked(page));
> > -     was_writable = pmd_savedwrite(pmd);
> > +out:
> > +     if (page_nid != NUMA_NO_NODE)
> > +             task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
> > +                             flags);
> > +
> > +     return 0;
> > +
> > +out_map:
> > +     /* Restore the PMD */
> >       pmd = pmd_modify(pmd, vma->vm_page_prot);
> >       pmd = pmd_mkyoung(pmd);
> >       if (was_writable)
> >               pmd = pmd_mkwrite(pmd);
> >       set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
> >       update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> > -     unlock_page(page);
> > -out_unlock:
> >       spin_unlock(vmf->ptl);
> > -
> > -out:
> > -     if (anon_vma)
> > -             page_unlock_anon_vma_read(anon_vma);
> > -
> > -     if (page_nid != NUMA_NO_NODE)
> > -             task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
> > -                             flags);
> > -
> > -     return 0;
> > +     goto out;
> >  }
> >
>
> [snip]

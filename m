Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC6CC0015E
	for <linux-s390@archiver.kernel.org>; Wed, 19 Jul 2023 05:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGSFEY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 Jul 2023 01:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGSFEX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 19 Jul 2023 01:04:23 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6F1BF2
        for <linux-s390@vger.kernel.org>; Tue, 18 Jul 2023 22:04:21 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5835388d632so16106867b3.3
        for <linux-s390@vger.kernel.org>; Tue, 18 Jul 2023 22:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689743060; x=1692335060;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4gbnMS0W6E9Awn5g41KlL6GZi3HN5/R/yFQL1nQXJg=;
        b=bsfPCapysjnAZODvh7VQx88fm7IvMM72XC0oEOupCXke50rzUpxBzJjYQpi6er51fb
         D4bBL8Bh1D+h6gJQCrL3ilyuQNC5vtgJJbqXXVdUX3wGIHEmUxC4mo1pR0Z+lwJSnYwK
         meVLK3418dgqsYosj9vCSuNEJNkdRzYHJy0dpVlfsGSOV8HIHO4e1UNyCrc3kkrhsuYl
         F7Nsl4WNKMNEHKdGgWak0LJ4fwxrpogQk/dx/JNial3Rw8ApbYcti+VqcZ3cqR3TmrjR
         HLyZAxKWibz4mBf1B911Dg5ToxkxCT+TuKgSTuRLqJQNqiyCWpJGUeH03fYVv65KsNEv
         GKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689743060; x=1692335060;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4gbnMS0W6E9Awn5g41KlL6GZi3HN5/R/yFQL1nQXJg=;
        b=EqVToGNUQjqRMceSL9kxniQVBv1KHW9+VFAlp0lHudtsvZIzmbMPDGghU18j2RNG63
         Ii0XFIXszZFvOtKVy5uCYOEep9KdyWUNaY3yrHBEUUFWszzMgOXQdXq6ASSf9s4zIKr3
         Mc1ipwOL7vzqAr3v8ENBUSkrqwVGsDfbgER6EZCds7+xGobX2o3HWL5/SI/91tJqv4PL
         bxPT1t9BI306ruvGd0WBEWfVzYusCJxW4CMMGbyCi+SgohrRFKySHvt/30bCgDTQ83zz
         Jh2yHbq+jOzaE/q1FS48Goy99ZsDc8teKVf8F6o1Gvd0AL5+7CyPlFbvvqo/7W6Iy2Yn
         /+gQ==
X-Gm-Message-State: ABy/qLabIPFEUiO595zQr737TLTlERfdykxMJ1odRPvmSet9xuD+sSxd
        ACtlnYP4o9JWQaJPOwYlO4O2rQ==
X-Google-Smtp-Source: APBJJlFfOyYeGiVCuczZwoUNyN9JCPq13oUH5g6h02u0hokVq61z1GN7QWMboOKVDLBaFX+57WnbTA==
X-Received: by 2002:a81:a00d:0:b0:573:d3cd:3d2a with SMTP id x13-20020a81a00d000000b00573d3cd3d2amr19838242ywg.28.1689743060542;
        Tue, 18 Jul 2023 22:04:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b125-20020a0df283000000b0056d304e224dsm847329ywf.90.2023.07.18.22.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 22:04:19 -0700 (PDT)
Date:   Tue, 18 Jul 2023 22:04:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
Subject: Re: [PATCH v3 04/13] powerpc: assert_pte_locked() use
 pte_offset_map_nolock()
In-Reply-To: <87msztbiy8.fsf@linux.ibm.com>
Message-ID: <392f311f-83ac-a5a2-d16e-2c7736d1b577@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <e8d56c95-c132-a82e-5f5f-7bb1b738b057@google.com> <87msztbiy8.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 18 Jul 2023, Aneesh Kumar K.V wrote:
> Hugh Dickins <hughd@google.com> writes:
> 
> > Instead of pte_lockptr(), use the recently added pte_offset_map_nolock()
> > in assert_pte_locked().  BUG if pte_offset_map_nolock() fails: this is
> > stricter than the previous implementation, which skipped when pmd_none()
> > (with a comment on khugepaged collapse transitions): but wouldn't we want
> > to know, if an assert_pte_locked() caller can be racing such transitions?
> >
> 
> The reason we had that pmd_none check there was to handle khugpaged. In
> case of khugepaged we do pmdp_collapse_flush and then do a ptep_clear.
> ppc64 had the assert_pte_locked check inside that ptep_clear.
> 
> _pmd = pmdp_collapse_flush(vma, address, pmd);
> ..
> ptep_clear()
> -> asset_ptep_locked()
> ---> pmd_none
> -----> BUG
> 
> 
> The problem is how assert_pte_locked() verify whether we are holding
> ptl. It does that by walking the page table again and in this specific
> case by the time we call the function we already had cleared pmd .

Aneesh, please clarify, I've spent hours on this.

From all your use of past tense ("had"), I thought you were Acking my
patch; but now, after looking again at v3.11 source and today's,
I think you are NAKing my patch in its present form.

You are pointing out that anon THP's __collapse_huge_page_copy_succeeded()
uses ptep_clear() at a point after pmdp_collapse_flush() already cleared
*pmd, so my patch now leads that one use of assert_pte_locked() to BUG.
Is that your point?

I can easily restore that khugepaged comment (which had appeared to me
out of date at the time, but now looks still relevant) and pmd_none(*pmd)
check: but please clarify.

Thanks,
Hugh

> >
> > This mod might cause new crashes: which either expose my ignorance, or
> > indicate issues to be fixed, or limit the usage of assert_pte_locked().
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  arch/powerpc/mm/pgtable.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> > index cb2dcdb18f8e..16b061af86d7 100644
> > --- a/arch/powerpc/mm/pgtable.c
> > +++ b/arch/powerpc/mm/pgtable.c
> > @@ -311,6 +311,8 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
> >  	p4d_t *p4d;
> >  	pud_t *pud;
> >  	pmd_t *pmd;
> > +	pte_t *pte;
> > +	spinlock_t *ptl;
> >  
> >  	if (mm == &init_mm)
> >  		return;
> > @@ -321,16 +323,10 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
> >  	pud = pud_offset(p4d, addr);
> >  	BUG_ON(pud_none(*pud));
> >  	pmd = pmd_offset(pud, addr);
> > -	/*
> > -	 * khugepaged to collapse normal pages to hugepage, first set
> > -	 * pmd to none to force page fault/gup to take mmap_lock. After
> > -	 * pmd is set to none, we do a pte_clear which does this assertion
> > -	 * so if we find pmd none, return.
> > -	 */
> > -	if (pmd_none(*pmd))
> > -		return;
> > -	BUG_ON(!pmd_present(*pmd));
> > -	assert_spin_locked(pte_lockptr(mm, pmd));
> > +	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
> > +	BUG_ON(!pte);
> > +	assert_spin_locked(ptl);
> > +	pte_unmap(pte);
> >  }
> >  #endif /* CONFIG_DEBUG_VM */
> >  
> > -- 
> > 2.35.3

Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD37EE49AB
	for <linux-s390@archiver.kernel.org>; Tue, 22 Aug 2023 18:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjHVSee (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Aug 2023 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHVSed (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Aug 2023 14:34:33 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928ECDA
        for <linux-s390@vger.kernel.org>; Tue, 22 Aug 2023 11:34:31 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58caaedb20bso53896957b3.1
        for <linux-s390@vger.kernel.org>; Tue, 22 Aug 2023 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692729270; x=1693334070;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WMcORuWW+xF6gY7IBQ8Ihi596ledfzVY2HvWzF69bs=;
        b=bVTuVrcGgDo+SJA4P/hqb5H6xSd8MjD7Ssb+fMuazzFA3RYDdO+Fd9IJECACVc1jxX
         McaUm35ext3KtxZ81I4e0oJUZiIMsJMFUj/dISIy8Z74mU6Fv2f80D9ACZ/qgstEp8C3
         dz/3aairaENuzDbobljPrqtuBskwI56lb5nqo3i2CLhXIBQlC0YZY23Jv356UjgetMia
         NHGQqBKQ20oaS2gVAT2pZYOwN8E7FExt8MbK/p05hoSd1swhCWvI5WPhdTLMWUQY4Nk5
         ZcyYBss0xQeF26Dv7c2xX0FJXsI2PMUhWahmGyRBaLEDB8wNdKrE3OKxjNgMxLnHwhf1
         7PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692729271; x=1693334071;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WMcORuWW+xF6gY7IBQ8Ihi596ledfzVY2HvWzF69bs=;
        b=HB6ejoiG4+HpQvTXkIRT6EHOAOKEGIuVyQWRsaxr2bcrTw+qDHYlHvbgleG4LGVFQy
         NtxuXo3QlkidR6frR2S1eCtND/rMwx3d6WGk9NV/ukN4OQU6XZRAueWC24VRcvH9xx/Z
         uXCq29blZe92Lzjp0FfLze69piY7SG8AE+Xvd6/EMFOL54XBRV4WhTqAUahLpqkcR6un
         LJB7E6seUEf+CSg04IfIXOeHf5AJsVPefelJk/Hj6Jfdzp9UN5/PcP/63zxV84UhieZx
         eu8Lt1zyO403ti7R88spZcj3+JQqmdLra7Hg5BQLu83pbblYly8PeyhxNi1U2CIosiJk
         Ig7g==
X-Gm-Message-State: AOJu0YzWMknwwQow2WaeNV1St1bLW0WMGebn0XL8lbSnHKGAHD2mSnGQ
        I59fBHeoZ5iaypEw7HCqcYqwJQ==
X-Google-Smtp-Source: AGHT+IHKsobp5e7zqoup7VzvHJTcsGRbS8zrGrBX3SoF5xm7qcy+ngOpN9zqdPkzqj75WfGQt5eHpQ==
X-Received: by 2002:a81:6009:0:b0:582:5527:ddc with SMTP id u9-20020a816009000000b0058255270ddcmr10163921ywb.34.1692729270534;
        Tue, 22 Aug 2023 11:34:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j1-20020a0dc701000000b0058ddb62f99bsm2956436ywd.38.2023.08.22.11.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:34:29 -0700 (PDT)
Date:   Tue, 22 Aug 2023 11:34:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
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
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
In-Reply-To: <ZOTGvfO31pleXrPF@x1n>
Message-ID: <1b7c7056-d742-86bf-fec-fdb024b2381@google.com>
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com> <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com> <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com> <ZOTGvfO31pleXrPF@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 22 Aug 2023, Peter Xu wrote:
> On Mon, Aug 21, 2023 at 07:51:38PM -0700, Hugh Dickins wrote:
> > On Mon, 21 Aug 2023, Jann Horn wrote:
...
> > > 
> > > I guess an alternative would be to use a spin_trylock() instead of the
> > > current pmd_lock(), and if that fails, temporarily drop the page table
> > > lock and then restart from step 2 with both locks held - and at that
> > > point the page table scan should be fast since we expect it to usually
> > > be empty.
> > 
> > That's certainly a good idea, if collapse on userfaultfd_armed private
> > is anything of a common case (I doubt, but I don't know).  It may be a
> > better idea anyway (saving a drop and retake of ptlock).
> > 
> > I gave it a try, expecting to end up with something that would lead
> > me to say "I tried it, but it didn't work out well"; but actually it
> > looks okay to me.  I wouldn't say I prefer it, but it seems reasonable,
> > and no more complicated (as Peter rightly observes) than the original.
> > 
> > It's up to you and Peter, and whoever has strong feelings about it,
> > to choose between them: I don't mind (but I shall be sad if someone
> > demands that I indent that comment deeper - I'm not a fan of long
> > multi-line comments near column 80).
> 
> No strong opinion here, either.  Just one trivial comment/question below on
> the new patch (if that will be preferred)..

I'm going to settle for the original v1 for now (I'll explain why in reply
to Jann next) - which already has the blessing of your Acked-by, thanks.

(Yes, the locking is a bit confusing: but mainly for the unrelated reason,
that with the split locking configs, we never quite know whether this lock
is the same as that lock or not, and so have to be rather careful.)

> > [PATCH mm-unstable v2] mm/khugepaged: fix collapse_pte_mapped_thp() versus uffd
...
> > @@ -1572,9 +1572,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> >  				haddr, haddr + HPAGE_PMD_SIZE);
> >  	mmu_notifier_invalidate_range_start(&range);
> >  	notified = true;
> > -	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
> > -	if (!start_pte)		/* mmap_lock + page lock should prevent this */
> > -		goto abort;
> > +	spin_lock(ptl);
> 
> .. here will the ptl always be valid?
> 
> That comes from the previous round of pte_offset_map_lock(), and I assume
> after this whole "thp collapse without write lock" work landed, it has the
> same lifecycle with the *pte pointer, so can be invalid right after the rcu
> read lock released; mmap read lock isn't strong enough to protect the ptl,
> not anymore.
> 
> Maybe it's all fine because the thp collapse path is the solo path(s) that
> will release the pte pgtable page without write mmap lock (so as to release
> the ptl too when doing so), and we at least still hold the page lock, so
> the worst case is the other concurrent "thp collapse" will still serialize
> with this one on the huge page lock. But that doesn't look as solid as
> fetching again the ptl from another pte_offset_map_nolock().  So still just
> raise this question up.  It's possible I just missed something.

It is safe, as you say because of us holding the hpage lock, which stops
any racing callers of collapse_pte_mapped_thp() or retract_page_tables():
and these are the functions which (currently) make the *pmd transition
which pte_offset_map_lock() etc. are being careful to guard against.

[In future we can imagine empty page table removal making that transition
too: and that wouldn't even have any hpage to lock.  Will it rely on
mmap_lock for write? or pmd_lock? probably both, but no need to design
for it now.]

But I agree that it does *look* more questionable in this patch: there was
a reassuring pte_offset_map_lock() there before, and now I rely more on
the assumptions and just use the "previous" ptl (and that's why I chose
to make the !start_pte case a VM_BUG_ON a few lines later).

I expect, with more time spent, I could cast it back into more reassuring
form: but it's all a bit of a con trick - if you look further down (even
before v2 or v1 fixes) to "step 4", there we have "if (ptl != pml)" which
is also relying on the fact that ptl cannot have changed.  And no doubt
that too could be recast into more reassuring-looking form, but it
wouldn't actually be worthwhile.

Thanks for considering these, Peter: I'll recommend v1 to Andrew.

Hugh

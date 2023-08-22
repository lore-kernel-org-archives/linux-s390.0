Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3ADEE49A3
	for <linux-s390@archiver.kernel.org>; Tue, 22 Aug 2023 14:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbjHVOkY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjHVOkY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Aug 2023 10:40:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20A126
        for <linux-s390@vger.kernel.org>; Tue, 22 Aug 2023 07:40:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so14142a12.0
        for <linux-s390@vger.kernel.org>; Tue, 22 Aug 2023 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692715221; x=1693320021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C3quYQxeFIPsrSFnkoQ66g6yHaIAyBnzAc9BMpYipc=;
        b=OIlW5unFzV7NWOV6TmLpbogd3cj66r1HwrEAEgnOF/ZkPVlYd9eVUxDfxmFaXHg08Z
         +WZDP1byYy7Gdu80MZ3Qu2k2pNdEoCOyB6ATO//CRJGvDD5AorBPal+hvU31QZLFCMBJ
         6e4zzSDy/w4RB03LeKCvDfLUw5YRCZ28WtCzWt2Vbng2AJDEzISlqMA6jYWoMUXyaL1K
         qPhxmkouE6NH0WXVEhbblWYZd/uH//lE0dz/pdeDr5wClUDPBLh7bplFMBpzoPs4OvzL
         8leJoRVtJ826ssAKqPLkH9r1rGZxyXZwvlP1wBqLPNiDz5aY4+PZ0CiZ1yMzuJTRBRsk
         3e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692715221; x=1693320021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C3quYQxeFIPsrSFnkoQ66g6yHaIAyBnzAc9BMpYipc=;
        b=gwX4dDXEhugk0OgOgMZFEagtx4GUoN0s40OcdExJqAsF5YwoPrMZkelCFmwv6vMuLS
         x/j5Tb8HB2USLsa9iJUksbW3WCwOt7vfQKpJx16rjjXcoDoycC6uAQma/8rX76cPOpZ9
         i1FiyjIsKBbBkDxpRlD1NtzaNmmq73mtPqyK5BoTiAM5OwwJ+7GVXX9H+fgPieblSSr3
         cgQ9h+2P/ov7nPQV++y5G2p+VT3L+27jACp2v00Xe7qDo+dRRlpowu5zq3jcpJLrezXS
         KSJfRaZ6gO26O7zwjHQhTQBCJqi/1Qwk8E2S8HuY3IKpClv1SRCfWjpTR2DdpXkQueGr
         fElQ==
X-Gm-Message-State: AOJu0YxbjP/SSdns5KXK358puD//M7+erIT2EmD+SRYqCgSipjlhcBEb
        EPhWfgVpaVPyfaK9dqcCe5f2KB4+9H+TQZe7kGr5vQ==
X-Google-Smtp-Source: AGHT+IF6H9w5RaJ7PE+MBKpDky923+JUzdrwmx+So9M6hSjxTrf0I+zQW7oUyRqPX7VRVw66ynmMZa9PJ/Zeqq91bQo=
X-Received: by 2002:a50:f690:0:b0:523:d5bc:8424 with SMTP id
 d16-20020a50f690000000b00523d5bc8424mr108311edn.5.1692715220567; Tue, 22 Aug
 2023 07:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com>
 <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com> <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com>
In-Reply-To: <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 22 Aug 2023 16:39:43 +0200
Message-ID: <CAG48ez0S-RjAapaDiJ+oZXpn1vs9niWx54iqzusUScS-BYu0hw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 22, 2023 at 4:51=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
> On Mon, 21 Aug 2023, Jann Horn wrote:
> > On Mon, Aug 21, 2023 at 9:51=E2=80=AFPM Hugh Dickins <hughd@google.com>=
 wrote:
> > > Just for this case, take the pmd_lock() two steps earlier: not becaus=
e
> > > it gives any protection against this case itself, but because ptlock
> > > nests inside it, and it's the dropping of ptlock which let the bug in=
.
> > > In other cases, continue to minimize the pmd_lock() hold time.
> >
> > Special-casing userfaultfd like this makes me a bit uncomfortable; but
> > I also can't find anything other than userfaultfd that would insert
> > pages into regions that are khugepaged-compatible, so I guess this
> > works?
>
> I'm as sure as I can be that it's solely because userfaultfd breaks
> the usual rules here (and in fairness, IIRC Andrea did ask my permission
> before making it behave that way on shmem, COWing without a source page).
>
> Perhaps something else will want that same behaviour in future (it's
> tempting, but difficult to guarantee correctness); for now, it is just
> userfaultfd (but by saying "_armed" rather than "_missing", I'm half-
> expecting uffd to add more such exceptional modes in future).

Hm, yeah, sounds okay. (I guess we'd also run into this if we ever
wanted to make it possible to reliably install PTE markers with
madvise() or something like that, which might be nice for allowing
userspace to create guard pages without unnecessary extra VMAs...)

> > I guess an alternative would be to use a spin_trylock() instead of the
> > current pmd_lock(), and if that fails, temporarily drop the page table
> > lock and then restart from step 2 with both locks held - and at that
> > point the page table scan should be fast since we expect it to usually
> > be empty.
>
> That's certainly a good idea, if collapse on userfaultfd_armed private
> is anything of a common case (I doubt, but I don't know).  It may be a
> better idea anyway (saving a drop and retake of ptlock).

I was thinking it also has the advantage that it would still perform
okay if we got rid of the userfaultfd_armed() condition at some point
- though I realize that designing too much for hypothetical future
features is an antipattern.

> I gave it a try, expecting to end up with something that would lead
> me to say "I tried it, but it didn't work out well"; but actually it
> looks okay to me.  I wouldn't say I prefer it, but it seems reasonable,
> and no more complicated (as Peter rightly observes) than the original.
>
> It's up to you and Peter, and whoever has strong feelings about it,
> to choose between them: I don't mind (but I shall be sad if someone
> demands that I indent that comment deeper - I'm not a fan of long
> multi-line comments near column 80).

I prefer this version because it would make it easier to remove the
"userfaultfd_armed()" check in the future if we have to, but I guess
we could also always change it later if that becomes necessary, so I
don't really have strong feelings on it at this point.

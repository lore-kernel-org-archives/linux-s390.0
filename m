Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5734C7EE23
	for <linux-s390@archiver.kernel.org>; Fri,  2 Jun 2023 02:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjFBCuY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jun 2023 22:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjFBCuX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jun 2023 22:50:23 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656D71A1
        for <linux-s390@vger.kernel.org>; Thu,  1 Jun 2023 19:50:21 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5664b14966bso17008067b3.1
        for <linux-s390@vger.kernel.org>; Thu, 01 Jun 2023 19:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685674220; x=1688266220;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkFBZ6Z26PEaI+Jgv/5bWGu+0hTm1SzRb6kODNNBn+M=;
        b=CxDFRuGfcYOWRd6VMHq3ar2M1xRSdWVVRTOsF6xQ0mdly8R3+o2A6R0v/aETwVkb3P
         6b58l7Ni9XRQdArFtwuFCZ5arCMLCFw+LE0g4/MaXwrjvut1vrEBPVcT+W6pSsdHU+oi
         fjJ5UIEWmivzq31pCg6nsnlxQ0kE76d7AibcK5E6hVfvFaaxgiawOUnXccTx0uAP3pHm
         Idl5hOTvyvy2EPX+52qQ1cF3H5O7fhiSRn3bhB/j26+Hz+Q41PkPVp08UWJRUageIgFV
         GSVHYv6GOPwAxU0jH5OD/WRtBlcd1wSFGZtdCmsng+zRGOD1mVzbdt39IXv/0dJztfSK
         LnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685674220; x=1688266220;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkFBZ6Z26PEaI+Jgv/5bWGu+0hTm1SzRb6kODNNBn+M=;
        b=Acw6oW9bYOTlV4HHg7SswpJ6kyl38TUk0B6Cqmdh88mbFw18s8Ehs2Lg9wAkH3ZlMs
         +I5yfG+wpU9GK4mulIbhc1/AyO4aTpR8oFSiaVjk4JP2fKK1XV1YGIZbp0yDzQ9iMVOn
         3ps8ScjVha1GRfGTwflnq0KD+lBqm/SyL9oyHWMaywO39FvyXg9HU9tft0oXXS2bv/0A
         N9TcXrn0XU3ttuGoPQ6lyB+1x3p0pE4KNGQDPs8dW34uEmPsINUuWxvkPGlbg47JwY9k
         bg7NpMw4bYyVX69ztjD85Cij5/ugD95Re1qeE2wKlBybhbYNlUDwM+gjpPtutr5gSl3V
         5Utw==
X-Gm-Message-State: AC+VfDzFKKVAZlfCd3qPVm0D9hUo4CntphNnFnhSvf71Us3aRi9SAgK7
        f65k763i2m41qEOAqdm/3RMzEw==
X-Google-Smtp-Source: ACHHUZ6dtqdDIUgghSG7BNv1ykA9dzLFfcixbLHtolx08NZCshtI3n5qAtyBLAY0i0F+pIWOM2tKpQ==
X-Received: by 2002:a81:5247:0:b0:565:d40b:f695 with SMTP id g68-20020a815247000000b00565d40bf695mr10827576ywb.48.1685674220390;
        Thu, 01 Jun 2023 19:50:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u5-20020a0deb05000000b0055a07585a91sm72029ywe.11.2023.06.01.19.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 19:50:19 -0700 (PDT)
Date:   Thu, 1 Jun 2023 19:50:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jann Horn <jannh@google.com>
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
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/12] mm/pgtable: add rcu_read_lock() and
 rcu_read_unlock()s
In-Reply-To: <CAG48ez0tnYTVjr7zw3Vp4GTcQ=960EodatjqE5bM9a3EVYM16Q@mail.gmail.com>
Message-ID: <de1e37c-354c-fb98-1598-7ce6d415f257@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <88c445ae-552-5243-31a4-2674bac62d4d@google.com> <CAG48ez0tnYTVjr7zw3Vp4GTcQ=960EodatjqE5bM9a3EVYM16Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-2117762585-1685674219=:27216"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-2117762585-1685674219=:27216
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 31 May 2023, Jann Horn wrote:
> On Mon, May 29, 2023 at 8:15=E2=80=AFAM Hugh Dickins <hughd@google.com> w=
rote:
> > Before putting them to use (several commits later), add rcu_read_lock()
> > to pte_offset_map(), and rcu_read_unlock() to pte_unmap().  Make this a
> > separate commit, since it risks exposing imbalances: prior commits have
> > fixed all the known imbalances, but we may find some have been missed.
> [...]
> > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > index c7ab18a5fb77..674671835631 100644
> > --- a/mm/pgtable-generic.c
> > +++ b/mm/pgtable-generic.c
> > @@ -236,7 +236,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long a=
ddr, pmd_t *pmdvalp)
> >  {
> >         pmd_t pmdval;
> >
> > -       /* rcu_read_lock() to be added later */
> > +       rcu_read_lock();
> >         pmdval =3D pmdp_get_lockless(pmd);
> >         if (pmdvalp)
> >                 *pmdvalp =3D pmdval;
>=20
> It might be a good idea to document that this series assumes that the
> first argument to __pte_offset_map() is a pointer into a second-level
> page table (and not a local copy of the entry) unless the containing
> VMA is known to not be THP-eligible or the page table is detached from
> the page table hierarchy or something like that. Currently a bunch of
> places pass references to local copies of the entry, and while I think
> all of these are fine, it would probably be good to at least document
> why these are allowed to do it while other places aren't.

Thanks Jann: but I have to guess that here you are showing awareness of
an important issue that I'm simply ignorant of.

I have been haunted by a dim recollection that there is one architecture
(arm-32?) which is fussy about the placement of the pmdval being examined
(deduces info missing from the arch-independent interface, by following
up the address?), but I couldn't track it down when I tried.

Please tell me more; or better, don't spend your time explaining to me,
but please just send a link to a good reference on the issue.  I'll be
unable to document what you ask there, without educating myself first.

Thanks,
Hugh

>=20
> $ vgrep 'pte_offset_map(&'
> Index File                  Line Content
>     0 arch/sparc/mm/tlb.c    151 pte =3D pte_offset_map(&pmd, vaddr);
>     1 kernel/events/core.c  7501 ptep =3D pte_offset_map(&pmd, addr);
>     2 mm/gup.c              2460 ptem =3D ptep =3D pte_offset_map(&pmd, a=
ddr);
>     3 mm/huge_memory.c      2057 pte =3D pte_offset_map(&_pmd, haddr);
>     4 mm/huge_memory.c      2214 pte =3D pte_offset_map(&_pmd, haddr);
>     5 mm/page_table_check.c  240 pte_t *ptep =3D pte_offset_map(&pmd, add=
r);
---1463760895-2117762585-1685674219=:27216--

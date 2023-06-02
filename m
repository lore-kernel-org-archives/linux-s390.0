Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155FFC77B7A
	for <linux-s390@archiver.kernel.org>; Fri,  2 Jun 2023 04:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjFBEh4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 2 Jun 2023 00:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjFBEhz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Jun 2023 00:37:55 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD84199
        for <linux-s390@vger.kernel.org>; Thu,  1 Jun 2023 21:37:54 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba86ea269e0so1736386276.1
        for <linux-s390@vger.kernel.org>; Thu, 01 Jun 2023 21:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685680673; x=1688272673;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJxGCGn41BvabvDFNoHM5AnkkTjflqlE1qMNlE8NrT0=;
        b=hLiVWg2vLRCGga9dPaoBmb31J4RQXoKrnLyjofX4nrluqzG+krMZEBkG963VV3+V4S
         s+8cFe/GC9jT+mttHRcUgLqdAWaNK+4XJfOsKmkfRyxraldoFeK3u0aDrpHHDFy8+geA
         I+BVR4akDprVaJTfkU3zr7Uc//8VHDpcHsKp892pLRDmIDEe7dHVOra7Xn0lK7TCCWon
         b3GYtV2/SVVlBXw+4utgS9GHQrb+vEIMWNAyb6VxBnHIWrXHPzYDBTAmo8nwbHBXjTfw
         wghXDbSao4T2gtOYNqjy91CEhqjmEc3+JG5hRAUqAvMS4wRt8RVjEj6zljJFtyHOjo50
         ZEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685680673; x=1688272673;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJxGCGn41BvabvDFNoHM5AnkkTjflqlE1qMNlE8NrT0=;
        b=htO6k1KBLJgJR+Qb5cHhLCUijGTge1SMRzFiqnffuRnGKrWLFLKahzEd9tszauvKL7
         cAepKZgOcutrmp/mqi6LxxqKERY5+gfeZhTW38CLg7OMbsELhhUpqrdanOq4bOawLcIE
         sWcEVGZP2CJOGrT7NNVBtI5UZfHKv3wKDaVO4pj9pCvBZh+ZZ/aTxFO5Ae0MUqPsiiIE
         sjrZZM8QGlJHbNKOwjA9lBtlHV786jmbTySFgRdxKPlQPucac/zzZz2YDYrGz56gy4z+
         0idtnY75pyndlg9NCfqf++xF7kLPA2LqdS4tmrXQRHzvz/DhpwUPYrpwlE9qO8i2cHV+
         4Cvg==
X-Gm-Message-State: AC+VfDxd3Sw7i5Yy9aCtg5e+UOO/lCRK6moZc6Oz7oNX6TIYE+gMDs9Y
        YKoNTLkJj/Xnre7IiEFJnpR84A==
X-Google-Smtp-Source: ACHHUZ62Kcn2qr9AiBqyelJYmBklj7AUuE+DPbUEEozY9Og2nI55kjXOuHw2dqOrnNWIFBw/8cuzPg==
X-Received: by 2002:a25:2b09:0:b0:b69:8770:9d95 with SMTP id r9-20020a252b09000000b00b6987709d95mr2183916ybr.17.1685680672998;
        Thu, 01 Jun 2023 21:37:52 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 194-20020a2503cb000000b00ba8c2f3e1a4sm64190ybd.56.2023.06.01.21.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 21:37:52 -0700 (PDT)
Date:   Thu, 1 Jun 2023 21:37:38 -0700 (PDT)
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
Subject: Re: [PATCH 00/12] mm: free retracted page table by RCU
In-Reply-To: <CAG48ez0pCqfRdVSnJz7EKtNvMR65=zJgVB-72nTdrNuhtJNX2Q@mail.gmail.com>
Message-ID: <3a33b59f-47c1-9dea-209a-9f77eec3cb1@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <CAG48ez0pCqfRdVSnJz7EKtNvMR65=zJgVB-72nTdrNuhtJNX2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-147145368-1685680672=:27841"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-147145368-1685680672=:27841
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 31 May 2023, Jann Horn wrote:
> On Mon, May 29, 2023 at 8:11=E2=80=AFAM Hugh Dickins <hughd@google.com> w=
rote:
> > Here is the third series of patches to mm (and a few architectures), ba=
sed
> > on v6.4-rc3 with the preceding two series applied: in which khugepaged
> > takes advantage of pte_offset_map[_lock]() allowing for pmd transitions=
=2E
>=20
> To clarify: Part of the design here is that when you look up a user
> page table with pte_offset_map_nolock() or pte_offset_map() without
> holding mmap_lock in write mode, and you later lock the page table
> yourself, you don't know whether you actually have the real page table
> or a detached table that is currently in its RCU grace period, right?

Right.  (And I'd rather not assume anything of mmap_lock, but there are
one or two or three places that may still do so.)

> And detached tables are supposed to consist of only zeroed entries,
> and we assume that no relevant codepath will do anything bad if one of
> these functions spuriously returns a pointer to a page table full of
> zeroed entries?

(Nit that I expect you're well aware of: IIRC "zeroed" isn't 0 on s390.)

If someone is using pte_offset_map() without lock, they must be prepared
to accept page-table-like changes.  The limits of pte_offset_map_nolock()
with later spin_lock(ptl): I'm still exploring: there's certainly an
argument that one ought to do a pmd_same() check before proceeding,
but I don't think anywhere needs that at present.

Whether the page table has to be full of zeroed entries when detached:
I believe it is always like that at present (by the end of the series,
when the collapse_pte_offset_map() oddity is fixed), but whether it needs
to be so I'm not sure.  Quite likely it will need to be; but I'm open to
the possibility that all it needs is to be still a page table, with
perhaps new entries from a new usage in it.

The most obvious vital thing (in the split ptlock case) is that it
remains a struct page with a usable ptl spinlock embedded in it.

The question becomes more urgent when/if extending to replacing the
pagetable pmd by huge pmd in one go, without any mmap_lock: powerpc
wants to deposit the page table for later use even in the shmem/file
case (and all arches in the anon case): I did work out the details once
before, but I'm not sure whether I would still agree with myself; and was
glad to leave replacement out of this series, to revisit some time later.

>=20
> So in particular, in handle_pte_fault() we can reach the "if
> (unlikely(!pte_same(*vmf->pte, entry)))" with vmf->pte pointing to a
> detached zeroed page table, but we're okay with that because in that
> case we know that !pte_none(vmf->orig_pte)&&pte_none(*vmf->pte) ,
> which implies !pte_same(*vmf->pte, entry) , which means we'll bail
> out?

There is no current (even at end of series) circumstance in which we
could be pointing to a detached page table there; but yes, I want to
allow for that, and yes I agree with your analysis.  But with the
interesting unanswered question for the future, of what if the same
value could be found there: would that imply it's safe to proceed,
or would some further prevention be needed?

>=20
> If that's the intent, it might be good to add some comments, because
> at least to me that's not very obvious.

That's a very fair request; but I shall have difficulty deciding where
to place such comments.  I shall have to try, then you redirect me.

And I think we approach this in opposite ways: my nature is to put some
infrastructure in place, and then look at it to see what we can get away
with; whereas your nature is to define upfront what the possibilities are.
We can expect some tussles!

Thanks,
Hugh
---1463760895-147145368-1685680672=:27841--

Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B76C77B7A
	for <linux-s390@archiver.kernel.org>; Wed, 31 May 2023 17:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjEaRHf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 31 May 2023 13:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjEaRHb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 31 May 2023 13:07:31 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A6A193
        for <linux-s390@vger.kernel.org>; Wed, 31 May 2023 10:07:03 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so4335ab.1
        for <linux-s390@vger.kernel.org>; Wed, 31 May 2023 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685552819; x=1688144819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgji1uyhymXXLfgjn7ITXdRgSIEcIf2KB/asRIvGKOw=;
        b=ODuuigJHK5p3BMHUC1m9S8L86uxhrUd+EUWNMkyrJEBnUXHeQxiEVNfM6SO3YkVpaf
         ndXjbLCLqzJ7g3A6CBeKBOBIpKZJ8oKUs6e64JWOnao6pAIZuWY6pLI1Gk5cMkVe11ku
         3ioQGLObRRUlNXy2iKn7acx9C/gUEtuQG0pvI7TP/qZYbfE5k5T+ypUHcu3dTEyZLweh
         I1YZ4kQxS8hABPCEpBrqjjPqZMycm3vlbOcgjELpkpea4zxlaNVxdzEU8yX/l9mowUQ9
         tAa7I6e+H6SKOo7nsmvpAUoYeKR3LIqzvhKRAkQH/JXauQIRQwr5rXbFuZVqunOH331S
         5Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552819; x=1688144819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bgji1uyhymXXLfgjn7ITXdRgSIEcIf2KB/asRIvGKOw=;
        b=fkmbLpx/oK1wNMhE5QGxhC0wuQnyE7t/aJpXIgoKhkhydRIjC+CD8KQGZIh8qTUXMM
         LQdthqIa2fQbWWLCk9I3WhqX42qN1sDpSnCZ1Td9LYKw8ZKEsV9QwMoV2tyP57Y5QirP
         u0/3eHwU+jksij84Y+AZHPqgjjr7YC59l3QBtJftPXZz4m4x5Ffp28NMbFbvji55hkRN
         Y8hA5RGjvXLyU1x8Xl56iHk1hJF3BfJMw/RiH17uVhXwhzaASXsGyyai7tbrc462jNa7
         AXykyEtJ6Zi8tB8D6sco934dLGfZxnzfpoIPvixtYzt8ZujdBrZswzwUSBsHjT2miKSJ
         a87g==
X-Gm-Message-State: AC+VfDzzBjHuPIKI9z0Bu7xQL/wpv153g+KpK46D2bFu5NyhTJt4g/Qj
        2cmLC2/LtuVNwctd+lXbaOHke4T6hswR6FD8cBh4zQ==
X-Google-Smtp-Source: ACHHUZ4lBY+ZnFXYMuCa1tPn8bTKD9ClBQYGyuHfrtLAgOzl/Bx5jTe0zz5tpOLgvVRCnZM9JEXo01XssNv7NEWMOtQ=
X-Received: by 2002:a05:6e02:b2e:b0:32f:7715:4482 with SMTP id
 e14-20020a056e020b2e00b0032f77154482mr212194ilu.4.1685552819433; Wed, 31 May
 2023 10:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <88c445ae-552-5243-31a4-2674bac62d4d@google.com>
In-Reply-To: <88c445ae-552-5243-31a4-2674bac62d4d@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 31 May 2023 19:06:23 +0200
Message-ID: <CAG48ez0tnYTVjr7zw3Vp4GTcQ=960EodatjqE5bM9a3EVYM16Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] mm/pgtable: add rcu_read_lock() and rcu_read_unlock()s
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 29, 2023 at 8:15=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
> Before putting them to use (several commits later), add rcu_read_lock()
> to pte_offset_map(), and rcu_read_unlock() to pte_unmap().  Make this a
> separate commit, since it risks exposing imbalances: prior commits have
> fixed all the known imbalances, but we may find some have been missed.
[...]
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index c7ab18a5fb77..674671835631 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -236,7 +236,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long add=
r, pmd_t *pmdvalp)
>  {
>         pmd_t pmdval;
>
> -       /* rcu_read_lock() to be added later */
> +       rcu_read_lock();
>         pmdval =3D pmdp_get_lockless(pmd);
>         if (pmdvalp)
>                 *pmdvalp =3D pmdval;

It might be a good idea to document that this series assumes that the
first argument to __pte_offset_map() is a pointer into a second-level
page table (and not a local copy of the entry) unless the containing
VMA is known to not be THP-eligible or the page table is detached from
the page table hierarchy or something like that. Currently a bunch of
places pass references to local copies of the entry, and while I think
all of these are fine, it would probably be good to at least document
why these are allowed to do it while other places aren't.

$ vgrep 'pte_offset_map(&'
Index File                  Line Content
    0 arch/sparc/mm/tlb.c    151 pte =3D pte_offset_map(&pmd, vaddr);
    1 kernel/events/core.c  7501 ptep =3D pte_offset_map(&pmd, addr);
    2 mm/gup.c              2460 ptem =3D ptep =3D pte_offset_map(&pmd, add=
r);
    3 mm/huge_memory.c      2057 pte =3D pte_offset_map(&_pmd, haddr);
    4 mm/huge_memory.c      2214 pte =3D pte_offset_map(&_pmd, haddr);
    5 mm/page_table_check.c  240 pte_t *ptep =3D pte_offset_map(&pmd, addr)=
;

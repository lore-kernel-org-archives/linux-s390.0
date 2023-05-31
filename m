Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3133C77B73
	for <linux-s390@archiver.kernel.org>; Wed, 31 May 2023 18:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjEaSAB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 31 May 2023 14:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEaSAA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 31 May 2023 14:00:00 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74332128
        for <linux-s390@vger.kernel.org>; Wed, 31 May 2023 10:59:57 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so14785ab.0
        for <linux-s390@vger.kernel.org>; Wed, 31 May 2023 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685555997; x=1688147997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB39BX9t2bk69eR34cuPtTrtH3iMrtwgLqGN0anXQzs=;
        b=sNHcscEzF5oIXlbzrKvF04KLUYw1WT7sMRVqG8QGy8XIgG11atPlAKnpx5jKGtpy6a
         a+jCVG2eG9BX6mHRsSpbaugSwkATgdYQoWfvZd+ALZ/Jy6Mauf49PzdPffe5WmNZPR4Z
         WAFrsIXSEXKtDxjryc6yB0Z+hcuRTBy1nOpSqzMGFFGOJoYlv2FFuEbQe/FRb7W1B+KV
         0tTSBe6RpqLXei52V6g9ZxrdXeXwUXD4CalXMcTtAUE4wynrS414dVRH12lnDs0RZxQf
         mSOnJt6GA5r/CNqCC7dCE5XlEFmkMml+h5K7Z1ZJnauFHk0x4Zj6P4zxqfq+t5LPRE9b
         dxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685555997; x=1688147997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB39BX9t2bk69eR34cuPtTrtH3iMrtwgLqGN0anXQzs=;
        b=eXLvvSiKvW/XcH9k6Yhi67THLUYK4GVJ8to3R3LnX1hXsFEo4cdde5muUTdkRSFODR
         qgMjx6P/2s7wBqG5MpQmP4Xi5RbhngFuRwdcBeHZ39CiJNsRmXfooI/iuEnN3G/Di9QI
         DV0hPQteRD2+hzf1TJfSxauwh2dYbEnNGcpoDTGil3eK61T2QY2kuKiDWv+XamLYNidk
         2KTQ9Zup3+LUsiGBSY+ETNLnqyFsCt796A4tmYVBlA4MoOuDwUOu/qH+s9QLkuYObyju
         zSDxNjTkPcpbhuftSQq4TvvURcTaw60w+icaMM+9aC3/Vr/VjxLs5RFu3gRIeLWhCTp4
         8bbA==
X-Gm-Message-State: AC+VfDwLtB4kvpC/4PWLNWbehHBRqlYZUCxjKuUT1mSdDUFXBon4ZAuc
        9/E5HLYaPiHJXnog+PrNFY5w2pStCOwR/H4qfLCjmw==
X-Google-Smtp-Source: ACHHUZ4G84rWJ4iQu8mReQkW8t0DG4yhWskE8/AflvFlAC8RqDIUu08YD8bIx3gECDchUWXdvk6aMUCK5QJkPh4jMtw=
X-Received: by 2002:a05:6e02:b2e:b0:33b:5343:c1be with SMTP id
 e14-20020a056e020b2e00b0033b5343c1bemr174970ilu.29.1685555996652; Wed, 31 May
 2023 10:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 31 May 2023 19:59:20 +0200
Message-ID: <CAG48ez0pCqfRdVSnJz7EKtNvMR65=zJgVB-72nTdrNuhtJNX2Q@mail.gmail.com>
Subject: Re: [PATCH 00/12] mm: free retracted page table by RCU
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

On Mon, May 29, 2023 at 8:11=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
> Here is the third series of patches to mm (and a few architectures), base=
d
> on v6.4-rc3 with the preceding two series applied: in which khugepaged
> takes advantage of pte_offset_map[_lock]() allowing for pmd transitions.

To clarify: Part of the design here is that when you look up a user
page table with pte_offset_map_nolock() or pte_offset_map() without
holding mmap_lock in write mode, and you later lock the page table
yourself, you don't know whether you actually have the real page table
or a detached table that is currently in its RCU grace period, right?
And detached tables are supposed to consist of only zeroed entries,
and we assume that no relevant codepath will do anything bad if one of
these functions spuriously returns a pointer to a page table full of
zeroed entries?

So in particular, in handle_pte_fault() we can reach the "if
(unlikely(!pte_same(*vmf->pte, entry)))" with vmf->pte pointing to a
detached zeroed page table, but we're okay with that because in that
case we know that !pte_none(vmf->orig_pte)&&pte_none(*vmf->pte) ,
which implies !pte_same(*vmf->pte, entry) , which means we'll bail
out?

If that's the intent, it might be good to add some comments, because
at least to me that's not very obvious.

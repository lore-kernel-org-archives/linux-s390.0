Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC71EE4993
	for <linux-s390@archiver.kernel.org>; Tue, 22 Aug 2023 15:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbjHVPej (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Aug 2023 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbjHVPei (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Aug 2023 11:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791DDCDA
        for <linux-s390@vger.kernel.org>; Tue, 22 Aug 2023 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692718438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfDVn6rZaVtHsRanik8WVSt7RnpiFjyAz4ecoDpN/hY=;
        b=YTJoWRsrLWhhm+QydrbaNM1b4slmyvtQMut8mbhOJiyiE4w7YZKH9qlpPxSrULXM0WdcTW
        2MshFfKXhmZBeyPE1QRepYb9VL09ES6Hj52n/PUn9wSmNBK1uPCObQwmPUpH5geynhkYOX
        fR8w9MTfdH1aI+Z36ndQE34S0IQ9hho=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-DDRBV6KnOVysLS5bksoq0Q-1; Tue, 22 Aug 2023 11:33:57 -0400
X-MC-Unique: DDRBV6KnOVysLS5bksoq0Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe919c0348so25482645e9.1
        for <linux-s390@vger.kernel.org>; Tue, 22 Aug 2023 08:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718436; x=1693323236;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfDVn6rZaVtHsRanik8WVSt7RnpiFjyAz4ecoDpN/hY=;
        b=Ba4iw2nvRAv1sBtGanO4CH7srBaEACLPtaSr3PIgGoAEVVGWlvpL2v+6LXgIxuSWWN
         /6xi7KH+eR0E8HNm1I+zCMalirHwt1Wt6NrEW3TrWmNdnNlQL0GjLeHe9GB4FDl6DtOt
         t9nG26TlzxW9C1C8KO5XO/VDlNF6bdwnIPZHvZTnMVciEEGvecsUvTWaA87JQEWpFYeK
         YSc7b5tUjSNTeoG7VmBufSzsfok4G+Fg7CxYMq/RIYBjXLRJepTTgCQssUnH6FmkqrrA
         ylZHSS0uT2grw1gypdodzjXY6Sr9OCgQdLyWe4tABqwgB7z3q2fO0ewhgBWCseU+2WMw
         py4Q==
X-Gm-Message-State: AOJu0Ywp2HkvOgdjiWvICJYMnyGbTv9WFvpDr1EH8O4zs5d+HTMwWrd6
        N8VRUqtkSSn5gXI3vOP+z2p+JD0eBpCj3vejskXEnL6hLVU3y0oR+0+Tx+4IAI7qh2LiJicK9iN
        yjzDDRWwtwqRI4E4d1hcFaA==
X-Received: by 2002:a05:600c:5122:b0:3fe:fbba:afa2 with SMTP id o34-20020a05600c512200b003fefbbaafa2mr1535349wms.6.1692718435899;
        Tue, 22 Aug 2023 08:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEzgSt6c0d06CTldkinI+npTxalTCO8OFb2Fse9kAQ1VCoxoVKY5diKxmxkF7aMIBFdM0KIA==
X-Received: by 2002:a05:600c:5122:b0:3fe:fbba:afa2 with SMTP id o34-20020a05600c512200b003fefbbaafa2mr1535303wms.6.1692718435498;
        Tue, 22 Aug 2023 08:33:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c? (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de. [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c044e00b003fa96fe2bd9sm19752310wmb.22.2023.08.22.08.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:33:54 -0700 (PDT)
Message-ID: <d05a6922-8dbc-e6fb-f2c5-48f331652f20@redhat.com>
Date:   Tue, 22 Aug 2023 17:33:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
Content-Language: en-US
To:     Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Zach O'Keefe <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com>
 <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com>
 <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com>
 <CAG48ez0S-RjAapaDiJ+oZXpn1vs9niWx54iqzusUScS-BYu0hw@mail.gmail.com>
 <ZOTSyv6fuC1pkt76@casper.infradead.org>
 <CAG48ez2NrQjB5T5++uJSZ8-id5-H2mbSRX8c36gAJ5p_BMHOFw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAG48ez2NrQjB5T5++uJSZ8-id5-H2mbSRX8c36gAJ5p_BMHOFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22.08.23 17:30, Jann Horn wrote:
> On Tue, Aug 22, 2023 at 5:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>> On Tue, Aug 22, 2023 at 04:39:43PM +0200, Jann Horn wrote:
>>>> Perhaps something else will want that same behaviour in future (it's
>>>> tempting, but difficult to guarantee correctness); for now, it is just
>>>> userfaultfd (but by saying "_armed" rather than "_missing", I'm half-
>>>> expecting uffd to add more such exceptional modes in future).
>>>
>>> Hm, yeah, sounds okay. (I guess we'd also run into this if we ever
>>> wanted to make it possible to reliably install PTE markers with
>>> madvise() or something like that, which might be nice for allowing
>>> userspace to create guard pages without unnecessary extra VMAs...)
>>
>> I don't know what a userspace API for this would look like, but I have
>> a dream of creating guard VMAs which only live in the maple tree and
>> don't require the allocation of a struct VMA.  Use some magic reserved
>> pointer value like XA_ZERO_ENTRY to represent them ... seems more
>> robust than putting a PTE marker in the page tables?
> 
> Chrome currently uses a lot of VMAs for its heap, which I think are
> basically alternating PROT_NONE and PROT_READ|PROT_WRITE anonymous
> VMAs. Like this:
> 
> [...]
> 3a10002cf000-3a10002d0000 ---p 00000000 00:00 0
> 3a10002d0000-3a10002e6000 rw-p 00000000 00:00 0
> 3a10002e6000-3a10002e8000 ---p 00000000 00:00 0
> 3a10002e8000-3a10002f2000 rw-p 00000000 00:00 0
> 3a10002f2000-3a10002f4000 ---p 00000000 00:00 0
> 3a10002f4000-3a10002fb000 rw-p 00000000 00:00 0
> 3a10002fb000-3a10002fc000 ---p 00000000 00:00 0
> 3a10002fc000-3a1000303000 rw-p 00000000 00:00 0
> 3a1000303000-3a1000304000 ---p 00000000 00:00 0
> 3a1000304000-3a100031b000 rw-p 00000000 00:00 0
> 3a100031b000-3a100031c000 ---p 00000000 00:00 0
> 3a100031c000-3a1000326000 rw-p 00000000 00:00 0
> 3a1000326000-3a1000328000 ---p 00000000 00:00 0
> 3a1000328000-3a100033a000 rw-p 00000000 00:00 0
> 3a100033a000-3a100033c000 ---p 00000000 00:00 0
> 3a100033c000-3a100038b000 rw-p 00000000 00:00 0
> 3a100038b000-3a100038c000 ---p 00000000 00:00 0
> 3a100038c000-3a100039b000 rw-p 00000000 00:00 0
> 3a100039b000-3a100039c000 ---p 00000000 00:00 0
> 3a100039c000-3a10003af000 rw-p 00000000 00:00 0
> 3a10003af000-3a10003b0000 ---p 00000000 00:00 0
> 3a10003b0000-3a10003e8000 rw-p 00000000 00:00 0
> 3a10003e8000-3a1000401000 ---p 00000000 00:00 0
> 3a1000401000-3a1000402000 rw-p 00000000 00:00 0
> 3a1000402000-3a100040c000 ---p 00000000 00:00 0
> 3a100040c000-3a100046f000 rw-p 00000000 00:00 0
> 3a100046f000-3a1000470000 ---p 00000000 00:00 0
> 3a1000470000-3a100047a000 rw-p 00000000 00:00 0
> 3a100047a000-3a100047c000 ---p 00000000 00:00 0
> 3a100047c000-3a1000492000 rw-p 00000000 00:00 0
> 3a1000492000-3a1000494000 ---p 00000000 00:00 0
> 3a1000494000-3a10004a2000 rw-p 00000000 00:00 0
> 3a10004a2000-3a10004a4000 ---p 00000000 00:00 0
> 3a10004a4000-3a10004b6000 rw-p 00000000 00:00 0
> 3a10004b6000-3a10004b8000 ---p 00000000 00:00 0
> 3a10004b8000-3a10004ea000 rw-p 00000000 00:00 0
> 3a10004ea000-3a10004ec000 ---p 00000000 00:00 0
> 3a10004ec000-3a10005f4000 rw-p 00000000 00:00 0
> 3a10005f4000-3a1000601000 ---p 00000000 00:00 0
> 3a1000601000-3a1000602000 rw-p 00000000 00:00 0
> 3a1000602000-3a1000604000 ---p 00000000 00:00 0
> 3a1000604000-3a100062b000 rw-p 00000000 00:00 0
> 3a100062b000-3a1000801000 ---p 00000000 00:00 0
> [...]
> 
> I was thinking if you used PTE markers as guards, you could maybe turn
> all that into more or less a single VMA?

I proposed the topic "A proper API for sparse memory mappings" for the 
bi-weekly MM meeting on September 20, that would also cover exactly that 
use case. :)

-- 
Cheers,

David / dhildenb


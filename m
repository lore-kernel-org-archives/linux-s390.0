Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB97C7EE23
	for <linux-s390@archiver.kernel.org>; Thu,  8 Jun 2023 13:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbjFHN6l (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Jun 2023 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbjFHN6j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Jun 2023 09:58:39 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08730271D
        for <linux-s390@vger.kernel.org>; Thu,  8 Jun 2023 06:58:38 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39c873a5127so276167b6e.1
        for <linux-s390@vger.kernel.org>; Thu, 08 Jun 2023 06:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686232715; x=1688824715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNu2/S7sKOt+ubQCHoHXnO+tkZORQ3Sbd1tjf3f4Mr4=;
        b=c3kx8K7tTcukv+anoLR5JE3/ubg8q5CO3nzZOO6SU5CXIix8vczuprLx4rXVDWTdEX
         hs+E+zzja4ua8gGSjBrbVm6Ep8+L0fOEvdhrqVYJLxFv130wvOZzdjAaB2Flhgb2TRRb
         uqPK/7XI63a9Wl2IZQN4DEejxckFyPyr0xFuvLWArVQ/+f9ud9V5FeMXJ6bonL6nPSkP
         ZAWsLq+XfvZHPiGRN/xo7lAPtKsiLx+Q72RSIJ86pzS9EcuyNwtp9F9J96kqArgULjkv
         3GfO6CrfSEhxuYeCqGRvjyHkvsZI1BdV24dd8bBsMQRPPswYuaCUpkJe5qj8Iwetk/KI
         UiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232715; x=1688824715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNu2/S7sKOt+ubQCHoHXnO+tkZORQ3Sbd1tjf3f4Mr4=;
        b=W5UGMmiRFppgseTuufjCfXjStFreI7OngHjCRdZ5z+QFNbXf+rhxuIM16Dl5mh3Ixb
         qahviwTCp1bDpOCQ1rtECJkxTYQViW+pVHu/BNTND35gq35/UelmxH4eMLuWKqe94K9K
         QPIMNPjKyI70qytlRUmQFaHC2iBYq5/1nbhJEJuedIcr7OJ1zKnRQ5tsAxikL3YqW7JG
         NS7g4TI2B0u+fiNX8Q0lf2LBfA4hCFYrBqx1MAVnBTWB2P0NGiO1R4N4aW6zNpkb7k5B
         pEINyQKOQuu8ISaz2QK0E82Utmqa/ntQUhCb5KDdGAAeloSu1xJfpQADtFNGWVixack6
         YiVA==
X-Gm-Message-State: AC+VfDzorTwV0ff4IW6nGuRhFUUfHwYioHQC8jm+tfna9kjv221f83e/
        EIovH4FZ5xwLw/lHifGmFulhmQ==
X-Google-Smtp-Source: ACHHUZ79SDvHlQrsY3n06C+42lQZ8V3VBEDt3rX4FxqxgeXDKorKznGSCHqgRSC89Wx2XwVPR9xrlA==
X-Received: by 2002:aca:90e:0:b0:397:f9f2:76b with SMTP id 14-20020aca090e000000b00397f9f2076bmr8071851oij.30.1686232715650;
        Thu, 08 Jun 2023 06:58:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id pg4-20020a17090b1e0400b00256a4d59bfasm3119836pjb.23.2023.06.08.06.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:58:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q7G9o-003TSq-VU;
        Thu, 08 Jun 2023 10:58:32 -0300
Date:   Thu, 8 Jun 2023 10:58:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
        Zack Rusin <zackr@vmware.com>,
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
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
Message-ID: <ZIHeiDf9srvRagfr@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com>
 <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com>
 <20230606214037.09c6b280@thinkpad-T15>
 <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 07, 2023 at 08:35:05PM -0700, Hugh Dickins wrote:

> My current thinking (but may be proved wrong) is along the lines of:
> why does something on its way to being freed need to be on any list
> than the rcu_head list?  I expect the current answer is, that the
> other half is allocated, so the page won't be freed; but I hope that
> we can put it back on that list once we're through with the rcu_head.

I was having the same thought. It is pretty tricky, but if this was
made into some core helper then PPC and S390 could both use it and PPC
would get a nice upgrade to have the S390 frag re-use instead of
leaking frags.

Broadly we have three states:

 all frags free
 at least one frag free
 all frags used

'all frags free' should be returned to the allocator
'at least one frag free' should have the struct page on the mmu_struct's list
'all frags used' should be on no list.

So if we go from 
  all frags used -> at least one frag free
Then we put it on the RCU then the RCU puts it on the mmu_struct list

If we go from 
   at least one frag free -> all frags free
Then we take it off the mmu_struct list, put it on the RCU, and RCU
frees it.

Your trick to put the list_head for the mm_struct list into the frag
memory looks like the right direction. So 'at least one frag free' has
a single already RCU free'd frag hold the list head pointer. Thus we
never use the LRU and the rcu_head is always available.

The struct page itself can contain the actual free frag bitmask.

I think if we split up the memory used for pt_frag_refcount we can get
enough bits to keep track of everything. With only 2-4 frags we should
be OK.

So we track this data in the struct page:
  - Current RCU free TODO bitmask - if non-zero then a RCU is already
    triggered
  - Next RCU TODO bitmaks - If an RCU is already triggrered then we
    accumulate more free'd frags here
  - Current Free Bits - Only updated by the RCU callback

?

We'd also need to store the mmu_struct pointer in the struct page for
the RCU to be able to add/remove from the mm_struct list.

I'm not sure how much of the work can be done with atomics and how
much would need to rely on spinlock inside the mm_struct.

It feels feasible and not so bad. :)

Figure it out and test it on S390 then make power use the same common
code, and we get full RCU page table freeing using a reliable rcu_head
on both of these previously troublesome architectures :) Yay

Jason

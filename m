Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFABFEB64D9
	for <linux-s390@archiver.kernel.org>; Mon, 10 Jul 2023 17:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjGJRVp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 10 Jul 2023 13:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjGJRVd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 10 Jul 2023 13:21:33 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D195CE58
        for <linux-s390@vger.kernel.org>; Mon, 10 Jul 2023 10:21:14 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-766fd5f9536so332767085a.3
        for <linux-s390@vger.kernel.org>; Mon, 10 Jul 2023 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689009674; x=1691601674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDKqe6h9VsjQuDpKI9KRg1N7kbgZMbKA4ecQ1xozFqs=;
        b=IMsBYjy3Toq+G3vBDgnvPIjgdoK/8dHggIY3Hs7qoUt25YkpzOmPBi/nHn//DrOYJB
         /Ua+/QBa5Use8IJESRSiFunKdkGqNHd+YUqoRuJfQ4kcz9FzGR8GIZXsQpoAByEtiRoW
         aHShM1l7QbL76OMNkc1lG2qoSZ//vH0KwhSWZJu3JAj2Jxo8XWZBsa1X0VxWF2oEWd2s
         Qu1lVdsr/969sUuC9+ClJLKaydssewFZiIszGWbW/S6Cjo7VrKDsSxZ7RPNvyFeMxk1W
         6TYZEng5dbEcOdn1U6fXy08kcBT33/DATCe+/VchSTeFDgqF+J/WUVPSVonRZqpbV4JY
         T2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689009674; x=1691601674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDKqe6h9VsjQuDpKI9KRg1N7kbgZMbKA4ecQ1xozFqs=;
        b=fjA8PULZvcWptZ/BvMVnD1gwXuYHRZR9+zSrWhptTVpkIK+OtR7fjQhLuzqdnosSQ6
         IuytYj0Z8ERiF4OxfE+6E9Nxk5o5IX7iawZCnNcNsLQ71bNqR3pacYMWP7tjyg0ZpTw6
         RdjB8z/aYei9LQPnYvca5Jf0wD9Swf8/xa3aPiW29kULUMdSZt/zhIFVPAG2kZOCTPec
         1fNyHA8FGNZDExG1foKNvyMb1cmdlCvn2KMMXnNhXomEqA+5muEto/TobjeIq2GTuY4W
         tL3pCoLM3aq/yvfH0g3mgFB+z06YWNzIar3RFaeVjnat/9XiQytoyGkyW5JFUhVv0myY
         DC0Q==
X-Gm-Message-State: ABy/qLZrfWGI0awr3o6c0y/M4ep8gtq+JmVasbuPNx2Yxnwliw1uvhmU
        ScQvyzmRU/bg1slUUaYOgK++ZQ==
X-Google-Smtp-Source: APBJJlEZjgv87sGoqCoA2OyNTenIrI3xxoXPoRV2o/wxukY2mPE0POHCvXNINrLxikThI/IjdSHCSQ==
X-Received: by 2002:a05:620a:198f:b0:767:205b:7f4b with SMTP id bm15-20020a05620a198f00b00767205b7f4bmr13197531qkb.41.1689009673882;
        Mon, 10 Jul 2023 10:21:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g6-20020ae9e106000000b00767dc4c539bsm61695qkm.44.2023.07.10.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:21:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qIuZT-0004Dq-J0;
        Mon, 10 Jul 2023 14:21:11 -0300
Date:   Mon, 10 Jul 2023 14:21:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
Message-ID: <ZKw+BxRUrGC8LW5P@ziepe.ca>
References: <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
 <20230628211624.531cdc58@thinkpad-T15>
 <cd7c2851-1440-7220-6c53-16b343b1474@google.com>
 <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca>
 <20230629175645.7654d0a8@thinkpad-T15>
 <edaa96f-80c1-1252-acbb-71c4f045b035@google.com>
 <7bef5695-fa4a-7215-7e9d-d4a83161c7ab@google.com>
 <20230704171905.1263478f@thinkpad-T15>
 <e678affb-5eee-a055-7af1-1d29a965663b@google.com>
 <20230705145516.7d9d554d@thinkpad-T15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705145516.7d9d554d@thinkpad-T15>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 05, 2023 at 02:55:16PM +0200, Gerald Schaefer wrote:

> Ah ok, I was aware of that "semi-RCU" fallback logic in tlb_remove_table(),
> but that is rather a generic issue, and not s390-specific. I thought you
> meant some s390-oddity here, of which we have a lot, unfortunately...
> Of course, we call tlb_remove_table() from our page_table_free_rcu(), so
> I guess you could say that page_table_free_rcu() cannot guarantee what
> tlb_remove_table() cannot guarantee.

The issue is the arches don't provide a reliable way to RCU free
things, so the core code creates an RCU situation using the MMU
batch. With the non-RCU compatible IPI fallback. So it isn't actually
RCU, it is IPI but optimized with RCU in some cases.

When Hugh introduces a reliable way to RCU free stuff we could fall
back to that in the TLB code instead of invoking the synchronize_rcu()

For lots of arches, S390 included after this series, this would be
pretty easy.

What I see now as the big trouble is that this series only addresses
PTE RCU'ness and making all the other levels RCUable would be much
harder on some arches like power.

In short we could create a CONFIG_ARCH_RCU_SAFE_PAGEWALK and it could
be done on alot of arches quite simply, but at least not power. Which
makes me wonder about the value, but maybe it could shame power into
doing something..

However, calling things 'page_table_free_rcu()' when it doesn't
actually always do RCU but IPI optimzed RCU is an unfortunate name :(
As long as you never assume it does RCU anywhere else, and don't use
rcu_read_lock(), it is fine :)

The corner case is narrow, you have to OOM the TLB batching before you
loose the RCU optimization of the IPI.  Then you can notice that
rcu_read_lock() doesn't actually protect against concurrent free.

Jason

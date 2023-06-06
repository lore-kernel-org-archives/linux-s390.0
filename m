Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED4AC7EE32
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jun 2023 19:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbjFFTEd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbjFFTEX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jun 2023 15:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB05119
        for <linux-s390@vger.kernel.org>; Tue,  6 Jun 2023 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686078218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmPwhcLQLS6QAOJhnaZRrlptzdg2mUtfNMjjPY6LfS8=;
        b=AFuQrzjWZt9DInEY1lFNe2Dkl2jWUeOnZvEx5qHaeGepugKSmH3uiA6RXeZM6tL2ddVh48
        DmlcdnHCQCHqUaJaJTJi4xa7fyWwzBuf0roPU+B8OJVu5y5PjQqcZGmW0Z02eAWTJ5Qn2d
        evCVBAC6WjTzbhU7/EYtMPaLsJ+bbMg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-YpiJe8xbMJSMFcLjx6ykUQ-1; Tue, 06 Jun 2023 15:03:37 -0400
X-MC-Unique: YpiJe8xbMJSMFcLjx6ykUQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b147a2548so130958685a.1
        for <linux-s390@vger.kernel.org>; Tue, 06 Jun 2023 12:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078216; x=1688670216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmPwhcLQLS6QAOJhnaZRrlptzdg2mUtfNMjjPY6LfS8=;
        b=W++Im9QDdVFNPZ573p/zAnW6snXLB1jvzVLWhUXy0e0K+VxH9bWxA5SgVIIiKaRUa4
         YzAz/mpj8/nNHy+lcz+L6BTn808kO4PzFlTf4ewwj83StoDI+6Hqx6IgYnH8Zt6gFGI4
         Fi+EpRo6t6/hdwqF4O5miQpYFSw2JQMjwsN4riJDSphKQnEHAuCKaLcQYhlmQjM3q4h1
         KiJhnhamY10P4C8SEdHfqLCe0cZzebRmo1fdK/9CsF4qsZ/9mAAjxrKVUuAqeOxQ2NUr
         qoHTMakKX0Ai8x0loRIdvcJQgaXWhJPGuEj42+NqToqwOPxh6xoXege6qU4CnoOpkfqH
         W99A==
X-Gm-Message-State: AC+VfDwvs/fEYRUxNuXCprAlrmfuAZRNP9ksJU9evXbhs+hu0uf1y1Ia
        +/orGFKP2wwdWKH/gyfUUgmfcZblGz80XhYaMjiokUTNqP82422aZYsq6ANpgfzr6lcGU9x+Hcy
        UR8q0JLOYOb3A3it5vnogkQ==
X-Received: by 2002:a05:620a:2b92:b0:75b:23a1:69f0 with SMTP id dz18-20020a05620a2b9200b0075b23a169f0mr3107585qkb.7.1686078216677;
        Tue, 06 Jun 2023 12:03:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5C5YMccZA+iUS9RAssWOgobvDgS7+Te3WrU+7dZkM3FviCtXVqQlWbzikNWhoOiLhOPK8t2g==
X-Received: by 2002:a05:620a:2b92:b0:75b:23a1:69f0 with SMTP id dz18-20020a05620a2b9200b0075b23a169f0mr3107557qkb.7.1686078216403;
        Tue, 06 Jun 2023 12:03:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a166e00b0074636e35405sm5100311qko.65.2023.06.06.12.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 12:03:35 -0700 (PDT)
Date:   Tue, 6 Jun 2023 15:03:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCH 05/12] powerpc: add pte_free_defer() for pgtables sharing
 page
Message-ID: <ZH+DAxLhIYpTlIFc@x1n>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <28eb289f-ea2c-8eb9-63bb-9f7d7b9ccc11@google.com>
 <ZHSwWgLWaEd+zi/g@casper.infradead.org>
 <ZHn6n5eVTsr4Wl8x@ziepe.ca>
 <4df4909f-f5dd-6f94-9792-8f2949f542b3@google.com>
 <ZH95oobIqN0WO5MK@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZH95oobIqN0WO5MK@ziepe.ca>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 06, 2023 at 03:23:30PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 05, 2023 at 08:40:01PM -0700, Hugh Dickins wrote:
> 
> > diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> > index 20652daa1d7e..e4f58c5fc2ac 100644
> > --- a/arch/powerpc/mm/pgtable-frag.c
> > +++ b/arch/powerpc/mm/pgtable-frag.c
> > @@ -120,3 +120,54 @@ void pte_fragment_free(unsigned long *table, int kernel)
> >  		__free_page(page);
> >  	}
> >  }
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +#define PTE_FREE_DEFERRED 0x10000 /* beyond any PTE_FRAG_NR */
> > +
> > +static void pte_free_now(struct rcu_head *head)
> > +{
> > +	struct page *page;
> > +	int refcount;
> > +
> > +	page = container_of(head, struct page, rcu_head);
> > +	refcount = atomic_sub_return(PTE_FREE_DEFERRED - 1,
> > +				     &page->pt_frag_refcount);
> > +	if (refcount < PTE_FREE_DEFERRED) {
> > +		pte_fragment_free((unsigned long *)page_address(page), 0);
> > +		return;
> > +	}
> 
> From what I can tell power doesn't recycle the sub fragment into any
> kind of free list. It just waits for the last fragment to be unused
> and then frees the whole page.
> 
> So why not simply go into pte_fragment_free() and do the call_rcu directly:
> 
> 	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
> 	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> 		if (!kernel)
> 			pgtable_pte_page_dtor(page);
> 		call_rcu(&page->rcu_head, free_page_rcu)

We need to be careful on the lock being freed in pgtable_pte_page_dtor(),
in Hugh's series IIUC we need the spinlock being there for the rcu section
alongside the page itself.  So even if to do so we'll need to also rcu call 
pgtable_pte_page_dtor() when needed.

-- 
Peter Xu


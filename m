Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81996C7EE31
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jun 2023 19:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbjFFTLG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbjFFTKu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jun 2023 15:10:50 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAEA213D
        for <linux-s390@vger.kernel.org>; Tue,  6 Jun 2023 12:08:42 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6af6df7f93aso5885257a34.0
        for <linux-s390@vger.kernel.org>; Tue, 06 Jun 2023 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686078518; x=1688670518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBKThEgW3NTUkiZRvoX00WYF0JkCsCOEnA4ezJ54Iw0=;
        b=FJFr/wVIfPdoTjvHgpxP3od5kCmSMH1Z0JrOBWgah9N0Buw0Lqq2GUP2GVXw6WOiRh
         c++a4+grcHjQUmrxZiqzadYduVRf1CjUAli+D+QVPy9jcNL51cCAxEPrkdxnOFwEvhnb
         yJu3DX76dubw3UjpXKmY8bLxybb3MkH1N7SDa2D3lfFWRbwwkD/iwvDq5Rbs4pKZHixV
         RtekPOxZJPk6BJtOGDh+2UFQd8Mq/YXw/gd5ayUOvGPplgDFeju7Fn5HsUTFW/r4mQOQ
         KmK3lw44ULOSI0p8hKsZ+RHFSRdJo1L5kdi+DoAT49/RG5m4rt+DVmg8pGjnsJ3eO7lg
         Wt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078518; x=1688670518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBKThEgW3NTUkiZRvoX00WYF0JkCsCOEnA4ezJ54Iw0=;
        b=YvIw3N1d9XniTJykNqjRE96nKgG/4JExXy3iZJkmUqvCLCZ9ummI0B1mgTCpvv6+jz
         fJAZKzUnXaciGWRt7RW+nSIbYHKMk+ciPNyl7My14rFvA3SvC3ULXa05YAHNP1TQnrz2
         NGTCpAw1jVKvhmdENgw3EeShIplCoJnTa7lRl5dja61gzAtIPWdRMZZtgKZPS3kc8jtI
         H45AFhdAAjUJQQ92nvHHK8nKyODDbZDQsZmC1E4fcBHAyHSQv/sanKRfRjIsuAkN3Y+M
         Wti9xSv5r3lggrqcE0vU63gB2COwVlFANFjX9Z2u+g142I4NtlqEN6ErMVSv4Dl463ur
         X7Mg==
X-Gm-Message-State: AC+VfDzdKIrMsKnZR4CQfE3gLVF8SnBmVdZ9H4x2kY1BVjU5r3dJ+xrU
        0hDMvxR8ZVGoBPcuNbz0RMpCcg==
X-Google-Smtp-Source: ACHHUZ48+nKNEQNTWy8wtaVIu/9suMpGBPu4hlCMZiSBnV9dLjpuiCkwZXnEA6HwkSqHl0CVdHIYlw==
X-Received: by 2002:a05:6358:c407:b0:11b:3e4d:a203 with SMTP id ff7-20020a056358c40700b0011b3e4da203mr614356rwb.23.1686078517796;
        Tue, 06 Jun 2023 12:08:37 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f36-20020a631f24000000b0051f14839bf3sm7777289pgf.34.2023.06.06.12.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 12:08:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q6c2k-0030xL-9k;
        Tue, 06 Jun 2023 16:08:34 -0300
Date:   Tue, 6 Jun 2023 16:08:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <ZH+EMp9RuEVOjVNb@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <28eb289f-ea2c-8eb9-63bb-9f7d7b9ccc11@google.com>
 <ZHSwWgLWaEd+zi/g@casper.infradead.org>
 <ZHn6n5eVTsr4Wl8x@ziepe.ca>
 <4df4909f-f5dd-6f94-9792-8f2949f542b3@google.com>
 <ZH95oobIqN0WO5MK@ziepe.ca>
 <ZH+DAxLhIYpTlIFc@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH+DAxLhIYpTlIFc@x1n>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 06, 2023 at 03:03:31PM -0400, Peter Xu wrote:
> On Tue, Jun 06, 2023 at 03:23:30PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 05, 2023 at 08:40:01PM -0700, Hugh Dickins wrote:
> > 
> > > diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> > > index 20652daa1d7e..e4f58c5fc2ac 100644
> > > --- a/arch/powerpc/mm/pgtable-frag.c
> > > +++ b/arch/powerpc/mm/pgtable-frag.c
> > > @@ -120,3 +120,54 @@ void pte_fragment_free(unsigned long *table, int kernel)
> > >  		__free_page(page);
> > >  	}
> > >  }
> > > +
> > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > +#define PTE_FREE_DEFERRED 0x10000 /* beyond any PTE_FRAG_NR */
> > > +
> > > +static void pte_free_now(struct rcu_head *head)
> > > +{
> > > +	struct page *page;
> > > +	int refcount;
> > > +
> > > +	page = container_of(head, struct page, rcu_head);
> > > +	refcount = atomic_sub_return(PTE_FREE_DEFERRED - 1,
> > > +				     &page->pt_frag_refcount);
> > > +	if (refcount < PTE_FREE_DEFERRED) {
> > > +		pte_fragment_free((unsigned long *)page_address(page), 0);
> > > +		return;
> > > +	}
> > 
> > From what I can tell power doesn't recycle the sub fragment into any
> > kind of free list. It just waits for the last fragment to be unused
> > and then frees the whole page.
> > 
> > So why not simply go into pte_fragment_free() and do the call_rcu directly:
> > 
> > 	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
> > 	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> > 		if (!kernel)
> > 			pgtable_pte_page_dtor(page);
> > 		call_rcu(&page->rcu_head, free_page_rcu)
> 
> We need to be careful on the lock being freed in pgtable_pte_page_dtor(),
> in Hugh's series IIUC we need the spinlock being there for the rcu section
> alongside the page itself.  So even if to do so we'll need to also rcu call 
> pgtable_pte_page_dtor() when needed.

Er yes, I botched that, the dtor and the free_page should be in a the
rcu callback function

Jason

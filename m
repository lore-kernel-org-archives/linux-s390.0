Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C38EB64DC
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jun 2023 23:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjFTXwo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Jun 2023 19:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFTXwn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Jun 2023 19:52:43 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA4A1729
        for <linux-s390@vger.kernel.org>; Tue, 20 Jun 2023 16:52:40 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-62ff0e0c5d7so41808866d6.1
        for <linux-s390@vger.kernel.org>; Tue, 20 Jun 2023 16:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687305160; x=1689897160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb4/4UZZyVYXRpnqB4ac9M1vy7WiRZuGJxfCVEQQGnA=;
        b=eHDK8AuLxbgGjPONohhcJU+nFgRy3VUDmlsbmajZr4D1UWA3e8AuMYXaeciUgBkep8
         f6bKXam0Jvh8Fg7MhXn+MFgX3auRLfaEe2gd6saoiplTzPSIaF+kI0Qk0wgOmmfVZKHs
         6JKEGXzCCBK6/+fpaJ1IjsLnhvPkkSeY2cwgGMmWbML9jCxP4UGazGmT4xxDCwrd5oUv
         XT0f1oc61zdfM88/KTJtP2UPYpFj8Ale9ODjFUxpR8mMv4Y8u2pkZdAgw3PtmINxiS7a
         nLJfeWKVJl0lroNewiTzHETr0Qxsvmv2HDsbeeYrg9e06SzsTsZ5fe+Ezg8CBNEOt3oG
         oN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687305160; x=1689897160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vb4/4UZZyVYXRpnqB4ac9M1vy7WiRZuGJxfCVEQQGnA=;
        b=YXyGCviPIDi8txVD2+oz8Lm/vBZgtF/cMaE2XmtzNHM9SQoMkofjfYnwJ19PRoxoL/
         PTWmG/ic01PdLfUCAp7RiT7LXUEAx5oUbm9ew4xznEMo3WxSfc9V6PQE35gCM+koIYCD
         n5WekG5+XqxDA8Vm8EvweWspliuHGyWbfHXVAhEUIp/0kLslDTVYuvj2XXTocUzezT/2
         xgzdqn0+DGtTwackYMKrhrgl/uDs12OJM8TyxGDVBXBGr1forGLVu3xAf+y89mKw8+2A
         EkEfdhoXGXQ+U11NTx2lFYRJFfPiq7dbEvXsxulkHFlrFF35q3Vuy8huuYEvIsmfWLEL
         JX8g==
X-Gm-Message-State: AC+VfDwqAmZjgBz2HEpNVi0VB+OHP8i+esi/fbafx471gykSpF872UCn
        K2p4SYy23vMW21kWLIj9vAcNXw==
X-Google-Smtp-Source: ACHHUZ541VkZsfkII91BiSyuAKxfiQdFgXBN5W+JWnHcdBPEKYx5+92MrYfFYTfliHRuIvOLaZ9Cyg==
X-Received: by 2002:ad4:5bae:0:b0:62d:ddeb:3781 with SMTP id 14-20020ad45bae000000b0062dddeb3781mr16704999qvq.20.1687305159707;
        Tue, 20 Jun 2023 16:52:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id jo30-20020a056214501e00b006301819be40sm1816704qvb.49.2023.06.20.16.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 16:52:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qBl9K-007Vog-KI;
        Tue, 20 Jun 2023 20:52:38 -0300
Date:   Tue, 20 Jun 2023 20:52:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
        "David Sc. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH v2 05/12] powerpc: add pte_free_defer() for pgtables
 sharing page
Message-ID: <ZJI7xkXWmjrE1yY3@ziepe.ca>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
 <5cd9f442-61da-4c3d-eca-b7f44d22aa5f@google.com>
 <ZJGRa4zvsXfc43vB@ziepe.ca>
 <2ad8b6cf-692a-ff89-ecc-586c20c5e07f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad8b6cf-692a-ff89-ecc-586c20c5e07f@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 20, 2023 at 12:54:25PM -0700, Hugh Dickins wrote:
> On Tue, 20 Jun 2023, Jason Gunthorpe wrote:
> > On Tue, Jun 20, 2023 at 12:47:54AM -0700, Hugh Dickins wrote:
> > > Add powerpc-specific pte_free_defer(), to call pte_free() via call_rcu().
> > > pte_free_defer() will be called inside khugepaged's retract_page_tables()
> > > loop, where allocating extra memory cannot be relied upon.  This precedes
> > > the generic version to avoid build breakage from incompatible pgtable_t.
> > > 
> > > This is awkward because the struct page contains only one rcu_head, but
> > > that page may be shared between PTE_FRAG_NR pagetables, each wanting to
> > > use the rcu_head at the same time: account concurrent deferrals with a
> > > heightened refcount, only the first making use of the rcu_head, but
> > > re-deferring if more deferrals arrived during its grace period.
> > 
> > You didn't answer my question why we can't just move the rcu to the
> > actual free page?
> 
> I thought that I had answered it, perhaps not to your satisfaction:
> 
> https://lore.kernel.org/linux-mm/9130acb-193-6fdd-f8df-75766e663978@google.com/
> 
> My conclusion then was:
> Not very good reasons: good enough, or can you supply a better patch?

Oh, I guess I didn't read that email as answering the question..

I was saying to make pte_fragment_free() unconditionally do the
RCU. It is the only thing that uses the page->rcu_head, and it means
PPC would double RCU the final free on the TLB path, but that is
probably OK for now. This means pte_free_defer() won't do anything
special on PPC as PPC will always RCU free these things, this address
the defer concern too, I think. Overall it is easier to reason about.

I looked at fixing the TLB stuff to avoid the double rcu but quickly
got scared that ppc was using a kmem_cache to allocate other page
table sizes so there is not a reliable struct page to get a rcu_head
from. This looks like the main challenge for ppc... We'd have to teach
the tlb code to not do its own RCU stuff for table levels that the
arch is already RCU freeing - and that won't get us to full RCU
freeing on PPC.

Anyhow, this is a full version of what I was thinking:

diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 20652daa1d7e3a..b5dcd0f27fc115 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -106,6 +106,21 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel)
 	return __alloc_for_ptecache(mm, kernel);
 }
 
+static void pgtable_free_cb(struct rcu_head *head)
+{
+	struct page *page = container_of(head, struct page, rcu_head);
+
+	pgtable_pte_page_dtor(page);
+	__free_page(page);
+}
+
+static void pgtable_free_cb_kernel(struct rcu_head *head)
+{
+	struct page *page = container_of(head, struct page, rcu_head);
+
+	__free_page(page);
+}
+
 void pte_fragment_free(unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
@@ -115,8 +130,13 @@ void pte_fragment_free(unsigned long *table, int kernel)
 
 	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
 	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
+		/*
+		 * Always RCU free pagetable memory. rcu_head overlaps with lru
+		 * which is no longer in use by the time the table is freed.
+		 */
 		if (!kernel)
-			pgtable_pte_page_dtor(page);
-		__free_page(page);
+			call_rcu(&page->rcu_head, pgtable_free_cb);
+		else
+			call_rcu(&page->rcu_head, pgtable_free_cb_kernel);
 	}
 }

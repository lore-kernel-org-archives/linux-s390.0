Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F723C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 18:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiCPS2d (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbiCPS2c (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 14:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF0A5A59A;
        Wed, 16 Mar 2022 11:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30E2618B8;
        Wed, 16 Mar 2022 18:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1B8C340EC;
        Wed, 16 Mar 2022 18:27:05 +0000 (UTC)
Date:   Wed, 16 Mar 2022 18:27:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 4/7] arm64/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Message-ID: <YjIr9f9qaz4xITVd@arm.com>
References: <20220315141837.137118-1-david@redhat.com>
 <20220315141837.137118-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315141837.137118-5-david@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 15, 2022 at 03:18:34PM +0100, David Hildenbrand wrote:
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index b1e1b74d993c..62e0ebeed720 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -14,6 +14,7 @@
>   * Software defined PTE bits definition.
>   */
>  #define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
> +#define PTE_SWP_EXCLUSIVE	(_AT(pteval_t, 1) << 2)	 /* only for swp ptes */

I think we can use bit 1 here.

> @@ -909,12 +925,13 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  /*
>   * Encode and decode a swap entry:
>   *	bits 0-1:	present (must be zero)
> - *	bits 2-7:	swap type
> + *	bits 2:		remember PG_anon_exclusive
> + *	bits 3-7:	swap type
>   *	bits 8-57:	swap offset
>   *	bit  58:	PTE_PROT_NONE (must be zero)

I don't remember exactly why we reserved bits 0 and 1 when, from the
hardware perspective, it's sufficient for bit 0 to be 0 and the whole
pte becomes invalid. We use bit 1 as the 'table' bit (when 0 at pmd
level, it's a huge page) but we shouldn't check for this on a swap
entry.

-- 
Catalin

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB36C433DB
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 20:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E507264E68
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 20:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhBQU0x (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:26:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235012AbhBQU0u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Feb 2021 15:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613593522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hZtRJeUML7NHUfQaoih4ryjpEijORracEaJufXohTpE=;
        b=cc8vViWY2QCgC5YaU/p1FluPbyHCTL/18aHudvKUjuK8crgjn+n7yv8Ihod6nXmykYf3JL
        QGS4AAkr8bHycQANPmsbIxriEC/xVF/zyxhEs5i0vts8w1oYePAIWtRX20gxV39/r20u+9
        m751s3FzqHYnDZQJjt/oY6A72pgYl9M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-yosYPlnGMIedqRNarAnLRQ-1; Wed, 17 Feb 2021 15:25:21 -0500
X-MC-Unique: yosYPlnGMIedqRNarAnLRQ-1
Received: by mail-qk1-f197.google.com with SMTP id h7so11563618qkf.16
        for <linux-s390@vger.kernel.org>; Wed, 17 Feb 2021 12:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hZtRJeUML7NHUfQaoih4ryjpEijORracEaJufXohTpE=;
        b=e3sM9Q609f930voh6WxzoRpNXQod3MrFuVvhSfwMinlCBaaVnQXi3wF8QaJpsyx/HP
         WtqpurTbI5x3m4ewcuewP/F832n6g3WjZXpkGKncxMtfDNmhbjI1sdjHZjXr0rwNxM1p
         Vq5jTx1j5g5SKUURqxBXvs1HG+3pnBOMmoSRtt6phDjzJPlSQrP1s0FzmmdSJBn5GfPC
         9pQM0CnygH5vdmnwqqtgliT7OYrx+2KGV2J+/yLATWFvQLk3YJZfq789LMQgAKC8EH1G
         nK6E675V+bzyqQim351p7r/Rzo9Nw59bFKcl8BX22t1KEZjyCP6JdeA4C9H3y05hh1i9
         sXsQ==
X-Gm-Message-State: AOAM531jVCYTmxOBMyjwLw19CQY5L1LgfJwf7jw2WLw6ZuQtPmbkG2n5
        S+z8HLut+PGx3rmA6ogpJKjoqCXVLuTfnNlZwGP2DQbHf7EVCnQvrnWKCr0kkSAUQl/GRddyy5c
        kHGdMRhpy1b2LGNf1yAChpA==
X-Received: by 2002:a37:e4d:: with SMTP id 74mr997937qko.109.1613593520571;
        Wed, 17 Feb 2021 12:25:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh1hgcn30UQ1Pzk5/L6ZLtIbXgncB61U4mq0qYkBmtccAv/ChS4Cjoj7zOPZwFtCtLxtOTeQ==
X-Received: by 2002:a37:e4d:: with SMTP id 74mr997909qko.109.1613593520273;
        Wed, 17 Feb 2021 12:25:20 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id r80sm2436111qke.97.2021.02.17.12.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:25:19 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:25:18 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, shu wang <malate_wangshu@hotmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 5/5] mm proc/task_mmu.c: add hugetlb specific routine
 for clear_refs
Message-ID: <20210217202518.GA19238@xz-x1>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
 <20210211000322.159437-6-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211000322.159437-6-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 10, 2021 at 04:03:22PM -0800, Mike Kravetz wrote:
> There was is no hugetlb specific routine for clearing soft dirty and
> other referrences.  The 'default' routines would only clear the
> VM_SOFTDIRTY flag in the vma.
> 
> Add new routine specifically for hugetlb vmas.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/proc/task_mmu.c | 110 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 829b35016aaa..f06cf9b131a8 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1116,6 +1116,115 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +#ifdef CONFIG_HUGETLB_PAGE
> +static inline bool huge_pte_is_pinned(struct vm_area_struct *vma,
> +					unsigned long addr, pte_t pte)
> +{
> +	struct page *page;
> +
> +	if (likely(!atomic_read(&vma->vm_mm->has_pinned)))
> +		return false;
> +	page = pte_page(pte);
> +	if (!page)
> +		return false;
> +	return page_maybe_dma_pinned(page);
> +}
> +
> +static int clear_refs_hugetlb_range(pte_t *ptep, unsigned long hmask,
> +				unsigned long addr, unsigned long end,
> +				struct mm_walk *walk)
> +{
> +	struct clear_refs_private *cp = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct hstate *h = hstate_vma(walk->vma);
> +	unsigned long adj_start = addr, adj_end = end;
> +	spinlock_t *ptl;
> +	pte_t old_pte, pte;
> +
> +	/*
> +	 * clear_refs should only operate on complete vmas.  Therefore,
> +	 * values passed here should be huge page aligned and huge page
> +	 * size in length.  Quick validation before taking any action in
> +	 * case upstream code is changed.
> +	 */
> +	if ((addr & hmask) != addr || end - addr != huge_page_size(h)) {
> +		WARN_ONCE(1, "%s passed unaligned address\n", __func__);
> +		return 1;
> +	}

I wouldn't worry too much on the interface change - The one who will change the
interface should guarantee all existing hooks will still work, isn't it? :)

It's slightly confusing to me on why "clear_refs should only operate on
complete vmas" is related to the check, though.

> +
> +	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, ptep);
> +
> +	/* Soft dirty and pmd sharing do not mix */

Right, this seems to be a placeholder for unsharing code.

Though maybe we can do that earlier in pre_vma() hook?  That should be per-vma
rather than handling one specific huge page here, hence more efficient imho.

this reminded me that I should also better move hugetlb_unshare_all_pmds() of
my other patch into hugetlb.c, so that this code can call it.  Currently it's a
static function in userfaultfd.c.

> +
> +	pte = huge_ptep_get(ptep);
> +	if (!pte_present(pte))
> +		goto out;
> +	if (unlikely(is_hugetlb_entry_hwpoisoned(pte)))
> +		goto out;
> +
> +	if (cp->type == CLEAR_REFS_SOFT_DIRTY) {

Maybe move this check into clear_refs_test_walk()?  We can bail out earlier if:

      (is_vm_hugetlb_page(vma) && (type != CLEAR_REFS_SOFT_DIRTY))

> +		if (huge_pte_is_pinned(vma, addr, pte))
> +			goto out;

Out of topic of this patchset, but it's definitely a pity that we can't track
soft dirty for pinned pages.  Currently the assumption of the pte code path is:
"if this page can be DMA written then we won't know whether data changed after
all, then tracking dirty is meaningless", however that's prone to change when
new hardwares coming, say, IOMMU could start to trap DMA writes already.

But again that's another story.. and we should just follow what we do with
non-hugetlbfs for sure here, until some day if we'd like to revive soft dirty
tracking with pinned pages.

> +
> +		/*
> +		 * soft dirty and pmd sharing do not work together as
> +		 * per-process is tracked in ptes, and pmd sharing allows
> +		 * processed to share ptes.  We unshare any pmds here.
> +		 */
> +		adjust_range_if_pmd_sharing_possible(vma, &adj_start, &adj_end);

Ideally when reach here, huge pmd sharing won't ever exist, right?  Then do we
still need to adjust the range at all?

Thanks,

-- 
Peter Xu


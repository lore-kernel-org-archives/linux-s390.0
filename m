Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640E8C433DB
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F70E64E4D
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 19:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhBQTeS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:34:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232037AbhBQTeG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Feb 2021 14:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613590360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chBTvRcsAS3a8FwwRXtdGKU8rCHr+b0YM98s8yuNtRk=;
        b=Gk5Y4N5QYULfWhSqJqoMjoT1yReWg9nW0ZCYaVSPK8ThXNAZSrdoojn1k3HG2utreZHxjT
        eVCKfzCgS+9pyxa2dsF6BRt3tjfvXHeHsdqk+8NuHmBCB99IVNUUDX3lp/vhuEb+LorUIf
        TsvqXUtA+zpPmKPYIl2BB3hFFXlI6lw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-mqosr0FcMU2NrwdlIWWHpg-1; Wed, 17 Feb 2021 14:32:36 -0500
X-MC-Unique: mqosr0FcMU2NrwdlIWWHpg-1
Received: by mail-qk1-f199.google.com with SMTP id 124so11484917qkg.6
        for <linux-s390@vger.kernel.org>; Wed, 17 Feb 2021 11:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=chBTvRcsAS3a8FwwRXtdGKU8rCHr+b0YM98s8yuNtRk=;
        b=YPPw7PrF0LQaKWFD4yqrUKzrcdaXYtxGPOySAhd9GD9jnC4G0JKHd66WE2Hl3z9CiI
         9hh4VdBpLPulCGDXuetV1/9kFptrle0Gl6gBA9nTPLfjyOYhgR90hJDzn+Lo7qmRQCTr
         Jj9Vv/TMZtuNNnx8e1fyU0DtPLYZOnqCeForK2WmxU+Qz/ShRCXtTx3Ltswz6EtAGGFt
         w+bu0i4wMuXoEE9Q1xtrYQblDq9XzwOm9hu+K/mF0Uv3LZ9sHA8s+3TwjTf7DjX3Ol+/
         EnfCBcNYZ7E+tUbcDei+3HauOiLJXYNZz2IQ6xEqjeEFcpPOaM4T2q24vCMIADsVfCzT
         89og==
X-Gm-Message-State: AOAM531IzdD/Vl+VlVjTSyAVm4C/ekIuo7AuXgqdUpIuBBRLWBKeOziR
        i1HwvwM4tLQxTwybqBes1myff7zNdLMzX4Z6vb0EEv6Q+c+vzamDu7V5DUeR0Bg2i0y/5GINKRq
        yz+m2iSSjHEEZYk62CgPWIQ==
X-Received: by 2002:a05:620a:49d:: with SMTP id 29mr779499qkr.49.1613590356408;
        Wed, 17 Feb 2021 11:32:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxct/0TJkTVSD+yBw+bPJ6QHtjBf76n2Tn291AoVtlG0ddONxQkZKMiK59c+lYA6ShiyS4cCg==
X-Received: by 2002:a05:620a:49d:: with SMTP id 29mr779471qkr.49.1613590356146;
        Wed, 17 Feb 2021 11:32:36 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id w20sm2263025qki.102.2021.02.17.11.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:32:35 -0800 (PST)
Date:   Wed, 17 Feb 2021 14:32:33 -0500
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
Subject: Re: [RFC PATCH 2/5] hugetlb: enhance hugetlb fault processing to
 support soft dirty
Message-ID: <20210217193233.GB6519@xz-x1>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
 <20210211000322.159437-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211000322.159437-3-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 10, 2021 at 04:03:19PM -0800, Mike Kravetz wrote:
> hugetlb fault processing code would COW all write faults where the
> pte was not writable.  Soft dirty will write protect ptes as part
> of it's tracking mechanism.  The existing hugetlb_cow  code will do
> the right thing for PRIVATE mappings as it checks map_count.  However,
> for SHARED mappings it would actually allocate and install a COW page.
> Modify the code to not call hugetlb_cow for SHARED mappings and just
> update the pte.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 47f3123afd1a..b561b6867ec1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4584,8 +4584,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	 * spinlock. For private mappings, we also lookup the pagecache
>  	 * page now as it is used to determine if a reservation has been
>  	 * consumed.
> +	 * Only non-shared mappings are sent to hugetlb_cow.
>  	 */
> -	if ((flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
> +	if ((flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry) &&
> +					!(vma->vm_flags & VM_SHARED)) {
>  		if (vma_needs_reservation(h, vma, haddr) < 0) {
>  			ret = VM_FAULT_OOM;
>  			goto out_mutex;
> @@ -4593,9 +4595,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  		/* Just decrements count, does not deallocate */
>  		vma_end_reservation(h, vma, haddr);
>  
> -		if (!(vma->vm_flags & VM_MAYSHARE))
> -			pagecache_page = hugetlbfs_pagecache_page(h,
> -								vma, haddr);
> +		pagecache_page = hugetlbfs_pagecache_page(h, vma, haddr);

Pure question: I see that the check actually changed from VM_MAYSHARE into
VM_SHARE, then I noticed I'm actually unclear on the difference..  Say, when
VM_MAYSHARE is set, could VM_SHARED be cleared in any case?  Or say, is this
change intended?

I see that vma_set_page_prot() tried to remove VM_SHARED if soft dirty enabled
(which should cause vma_wants_writenotify() to return true, iiuc), however
that's temporary just to calculate vm_page_prot, and it's not applied to the
vma->vm_flags.  I failed to find a place where VM_SHARED of the vma is cleared
while VM_MAYSHARE is set..

>  	}
>  
>  	ptl = huge_pte_lock(h, mm, ptep);
> @@ -4620,9 +4620,18 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  	if (flags & FAULT_FLAG_WRITE) {
>  		if (!huge_pte_write(entry)) {
> -			ret = hugetlb_cow(mm, vma, address, ptep,
> -					  pagecache_page, ptl);
> -			goto out_put_page;
> +			if (!(vma->vm_flags & VM_SHARED)) {
> +				ret = hugetlb_cow(mm, vma, address, ptep,
> +						pagecache_page, ptl);
> +				goto out_put_page;
> +			}
> +
> +			/* write protected for soft dirty processing */
> +			if ((vma->vm_flags & VM_WRITE) &&

This VM_WRITE check seems to be redundant.  As example, do_user_addr_fault() of
x86 code will check this right after vma lookup by access_error().  So when
reach here if "flags & FAULT_FLAG_WRITE", then VM_WRITE must be set, imho.

> +					(vma->vm_flags & VM_SHARED))
> +				entry = huge_pte_mkwrite(entry);

Same question to VM_SHARED, since "(vma->vm_flags & VM_SHARED)" is just checked
above and we'll go hugetlb_cow() otherwise.

> +
> +			entry = huge_pte_mkdirty(entry);

There's another huge_pte_mkdirty() right below; likely we could merge them somehow?

Thanks,

>  		}
>  		entry = huge_pte_mkdirty(entry);
>  	}
> -- 
> 2.29.2
> 

-- 
Peter Xu


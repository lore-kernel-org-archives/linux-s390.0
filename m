Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F147C433DB
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 16:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1222164DE0
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 16:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhBQQZs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Feb 2021 11:25:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233128AbhBQQZr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Feb 2021 11:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613579060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fqY3aX+LcVTJX1gt4GvTFj3mpGHf8hCtl9l3H4cgEMs=;
        b=bhhQeOko8HkD7Jo/+LpuRBUUkdsFCk1nrHPuJCYP53TQe4JeleIt2KaTwT/oo+qFMEFFb7
        e677WRrLah8KYQWG7QlXRYF2ebreGVRhpJ3v3QwSxjCsvyxYidUTN5+apSnnrtFodbfQ/m
        FzQbxtthX9vpiEYMebk23KRsL4vDah8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-bHcJG2uNN6KpoHzbKMrLiA-1; Wed, 17 Feb 2021 11:24:18 -0500
X-MC-Unique: bHcJG2uNN6KpoHzbKMrLiA-1
Received: by mail-qv1-f72.google.com with SMTP id z28so10293037qva.15
        for <linux-s390@vger.kernel.org>; Wed, 17 Feb 2021 08:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fqY3aX+LcVTJX1gt4GvTFj3mpGHf8hCtl9l3H4cgEMs=;
        b=UWsFg2xk6qGkN4zRnJd0e4SFC/aacS1JKNQaZinoLdh0QEBkSTpf+HmmNppFugP4kY
         jPXUzte+G/3TK2fOjtXmlMMRt4wgnaTUnlzWdVRqumtcnEIatBbd7/bjsbm851ffro+7
         YTbO0matjlnzEA6Sls6XBut+eLUPxu17hSVfwifjGAvntpg8z7PhlKQHYJc4ONfIBss3
         7+lpmwd7eTQD2+Q+QFDzV8iAAuHqcCxIghnHlSGO2F4iowJYwXiKYE2xtBV+fs9GtMpC
         cYr+VW9/gI3pRj/s6UY9vYnXY/RQQscH6pDXzK+bd+jaMCHyyvrwvE+2QqLAl6RDkZTR
         e4vA==
X-Gm-Message-State: AOAM530TYIUrM+X/iiEB2W+pyrVTkm6ycD90At1CaFfzJzcZkg8lCwXt
        2WjcbuAZ/U5jomVRSu2vyOyJTBVk5AAFXDniI6OpR3aAjvEGtwbOh9kUCJd9wJv7zGG34V+hDyD
        SGR0oykGez5Ugl6Pa67nvEg==
X-Received: by 2002:ac8:59d6:: with SMTP id f22mr61294qtf.230.1613579058313;
        Wed, 17 Feb 2021 08:24:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn9Qa0Y9o7twQrPMgLfwghwwaSijFXNhNL1AlkR44bHdaMQ3yXomUNjdjOPLlg9C3gTJHwAQ==
X-Received: by 2002:ac8:59d6:: with SMTP id f22mr61266qtf.230.1613579058053;
        Wed, 17 Feb 2021 08:24:18 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id k129sm1919411qkf.108.2021.02.17.08.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:24:17 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:24:15 -0500
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
Subject: Re: [RFC PATCH 1/5] hugetlb: add hugetlb helpers for soft dirty
 support
Message-ID: <20210217162415.GA6519@xz-x1>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
 <20210211000322.159437-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211000322.159437-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 10, 2021 at 04:03:18PM -0800, Mike Kravetz wrote:
> Add interfaces to set and clear soft dirty in hugetlb ptes.  Make
> hugetlb interfaces needed for /proc clear_refs available outside
> hugetlb.c.
> 
> arch/s390 has it's own version of most routines in asm-generic/hugetlb.h,
> so add new routines there as well.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  arch/s390/include/asm/hugetlb.h | 30 ++++++++++++++++++++++++++++++
>  include/asm-generic/hugetlb.h   | 30 ++++++++++++++++++++++++++++++
>  include/linux/hugetlb.h         |  1 +
>  mm/hugetlb.c                    | 10 +---------
>  4 files changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
> index 60f9241e5e4a..b7d26248fb1c 100644
> --- a/arch/s390/include/asm/hugetlb.h
> +++ b/arch/s390/include/asm/hugetlb.h
> @@ -105,6 +105,11 @@ static inline pte_t huge_pte_mkdirty(pte_t pte)
>  	return pte_mkdirty(pte);
>  }
>  
> +static inline pte_t huge_pte_mkyoung(pte_t pte)
> +{
> +	return pte_mkyoung(pte);
> +}
> +
>  static inline pte_t huge_pte_wrprotect(pte_t pte)
>  {
>  	return pte_wrprotect(pte);
> @@ -115,9 +120,34 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
>  	return pte_modify(pte, newprot);
>  }
>  
> +static inline bool huge_pte_soft_dirty(pte_t pte)
> +{
> +	return pte_soft_dirty(pte);
> +}
> +
> +static inline pte_t huge_pte_clear_soft_dirty(pte_t pte)
> +{
> +	return pte_clear_soft_dirty(pte);
> +}
> +
> +static inline pte_t huge_pte_swp_clear_soft_dirty(pte_t pte)
> +{
> +	return pte_swp_clear_soft_dirty(pte);
> +}
> +

Indeed asm/hugetlb.h of s390 didn't include asm-generic/hugetlb.h as what was
normally done by asm/hugetlb.h of other archs.  Do you know why it's special?
E.g. huge_pte_wrprotect() of s390 version is actually the same of the default
version.

When I looked at the huge_pte_wrprotect() I also see that there seems to have
no real user of __HAVE_ARCH_HUGE_PTE_WRPROTECT.  Not sure whether it can be
dropped.  My gut feeling is that s390 should also include asm-generic/hugetlb.h
but only redefine the helper only if necessary, since I see no point defining
the same helper multiple times.

>  static inline bool gigantic_page_runtime_supported(void)
>  {
>  	return true;
>  }
>  
> +#if !defined(__HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE) && !defined(MODULE)
> +#include <asm/tlbflush.h>
> +
> +static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
> +					unsigned long start, unsigned long end)
> +{
> +	flush_tlb_range(vma, start, end);
> +}
> +#endif

Similar question here, only ppc defined __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE, so
IIUC it means s390 should simply use the default version, and it'll be great if
we don't need to redefine it here.

Thanks,

-- 
Peter Xu


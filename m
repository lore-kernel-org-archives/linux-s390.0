Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46071C433E0
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 19:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C72264E2E
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 19:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhBQThY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:37:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233258AbhBQThX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Feb 2021 14:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613590556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6lkoNLwaY2kbnYVognDDNLrsSmwkL+Qv8v4auisu9Y=;
        b=hEx9k5jzulQ4PvbsJnJgHNQXPB9sh5dndOM0E9XP8FSjmsYYEAoZXwaU8INag3pMLp/aR0
        FgMT8jBffOaV6kMblK+YB+TXTJrWX2ypaCO7VNRQw8785UTPA2nwYdMDlvib1EznuM1NeO
        L3mFhW9080gizMhz9d2ukDYrtv3p3eo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-gCuhtTDPPS6U5pvMSj-qMw-1; Wed, 17 Feb 2021 14:35:52 -0500
X-MC-Unique: gCuhtTDPPS6U5pvMSj-qMw-1
Received: by mail-qv1-f69.google.com with SMTP id j6so10619301qvo.11
        for <linux-s390@vger.kernel.org>; Wed, 17 Feb 2021 11:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a6lkoNLwaY2kbnYVognDDNLrsSmwkL+Qv8v4auisu9Y=;
        b=S1K5LV86jDaBmETIXZqNmTLB77P8vjCcADPLda7hGn0QN3QrFPhYWyfdyytZNzjPfi
         BLE95Ez9xbrmGV/x5X3ZjMLGZdBKgEai9fwYVxsvT69G99vWa0OfiGESL9/E4nToWnan
         VUBIFcKFCZWL+pDw8gCxt9Fz1ltPdj3dV0xpJaP6/ueTh6lqCYkHYM3o2f5beWqGUZbI
         DvOlo2AhvD8TL/221LRiJ/H4IOVU9+5F+40OFuaFXo+FVEKVvX16aubA9wIur06UtKb6
         p0jpZteQsqsRhYqgFv0p8FdeSJrTjS16FDPgRHxRqike8XiaA4bkZsRhB/3AJqFvl6+T
         wLdg==
X-Gm-Message-State: AOAM5308VsWZ13vohoiRaUzZMbJ+zgPrVmLloBbBAvPPMi+WAcJJrGB4
        cSqT/sMKrhMHEiQ7c6uyBhVuvcYRmKBjjVt6yagmsKHMql8sqw9GINFUh8wFiBxMCy9itNXbdAb
        LrpP6Oa5Dz1xVy+FpSuVy2w==
X-Received: by 2002:a37:c17:: with SMTP id 23mr815911qkm.282.1613590552398;
        Wed, 17 Feb 2021 11:35:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTYIIg5rgOnDJUJSvEaJQTHUn7YXNS0+K5gx2PYQc1TOI5PZNuWIJYe6QRYJIwljMi/RFGQw==
X-Received: by 2002:a37:c17:: with SMTP id 23mr815897qkm.282.1613590552210;
        Wed, 17 Feb 2021 11:35:52 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 12sm1861151qtt.88.2021.02.17.11.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:35:51 -0800 (PST)
Date:   Wed, 17 Feb 2021 14:35:50 -0500
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
Subject: Re: [RFC PATCH 3/5] mm proc/task_mmu.c: add soft dirty pte checks
 for hugetlb
Message-ID: <20210217193550.GC6519@xz-x1>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
 <20210211000322.159437-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211000322.159437-4-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 10, 2021 at 04:03:20PM -0800, Mike Kravetz wrote:
> Pagemap was only using the vma flag PM_SOFT_DIRTY for hugetlb vmas.
> This is insufficient.  Check the individual pte entries.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/proc/task_mmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 602e3a52884d..829b35016aaa 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1507,6 +1507,10 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>  		flags |= PM_SOFT_DIRTY;
>  
>  	pte = huge_ptep_get(ptep);
> +
> +	if (huge_pte_soft_dirty(pte))
> +		flags |= PM_SOFT_DIRTY;

Should this be put into pte_present() chunk below?  Since I feel like we'd need
huge_pte_swp_soft_dirty() for !pte_present().  Say, _PAGE_SOFT_DIRTY and
_PAGE_SWP_SOFT_DIRTY can be different.

> +
>  	if (pte_present(pte)) {
>  		struct page *page = pte_page(pte);
>  
> -- 
> 2.29.2
> 

-- 
Peter Xu


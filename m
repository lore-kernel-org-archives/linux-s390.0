Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCB3C433DB
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 19:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1ABF64DF0
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 19:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhBQTqb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:46:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233310AbhBQTqO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Feb 2021 14:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613591081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DKRCGD5cZBFDckHkhQGxjYspyMuPSVpV7imvsh15Fwg=;
        b=iLVjX7Wd+HlriVFyBUvM2uJ/baXyjJBP9wZw1Xi/HX8v6RAMX9F6FFV6gJY4ywogzN4ax/
        vzv03VFupsjm5aJVTUKOZFsMPTDNTmG1HX7YvLZZHZrX3cfyopaNWeLLM7ex6Q09SWWwMI
        I/85lIgc3qNh6Xe4LBhQXwdMzRALwXU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-wB4k82vEOpCS5nbuQyOEUQ-1; Wed, 17 Feb 2021 14:44:39 -0500
X-MC-Unique: wB4k82vEOpCS5nbuQyOEUQ-1
Received: by mail-qk1-f197.google.com with SMTP id c63so11541576qkd.1
        for <linux-s390@vger.kernel.org>; Wed, 17 Feb 2021 11:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DKRCGD5cZBFDckHkhQGxjYspyMuPSVpV7imvsh15Fwg=;
        b=YwREElkj7aWxtpmgSCPOsDmDuwivfqh3dwtaP3azzhd2pXEgy5QHC4oxbOv9ejK7Qe
         NFSV5GtoYaakbAa/YD40WuZF4r2GON5RR5+NggoEknHAkWJ40SlwSOo2ETFeBUwYtH57
         QTxnxBTvxxV8gVdggtjoBYleNdMHylqVCzNTrJGkxCVy1lOrfqzd5vRDDzmCUgcE8Qem
         tl/x5eMcrEt20WN1sbYOL0jlCdBuZ1Ikz9Qo/sT91yAiczgSZQj3aZj50jwmUk91dJ+x
         Pb8Jizo+vai/BHW3wKkyV2lye4RNJTcSpptgTbk6kyNiUsf/JBi8gP2hBnr4R1GlMBWJ
         Zh4A==
X-Gm-Message-State: AOAM5333NQOR4VagKjzUoSufZ/lPjQHPRxEvya6+0bADgSw11rm5Lt+Z
        oihZ6XIPCtXs0F1rFjt1QdaDc5WrHuSNuOJ2V3oe/wNZScf4vEL76Di2h6DG7syu6wC1YQnolWv
        qilmqg/Y7IqEKPZvzy8j3zQ==
X-Received: by 2002:a37:e20b:: with SMTP id g11mr832454qki.292.1613591078916;
        Wed, 17 Feb 2021 11:44:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmn0YnwZ3NDVqO0cMhaXsErwcpE5p4rLVKMLyL5IWYZzrdUFReeIRZBso5fLx1tUu0zEu6dg==
X-Received: by 2002:a37:e20b:: with SMTP id g11mr832433qki.292.1613591078685;
        Wed, 17 Feb 2021 11:44:38 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id k187sm2318732qkc.74.2021.02.17.11.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:44:38 -0800 (PST)
Date:   Wed, 17 Feb 2021 14:44:36 -0500
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
Subject: Re: [RFC PATCH 4/5] hugetlb: don't permit pmd sharing if soft dirty
 in use
Message-ID: <20210217194436.GD6519@xz-x1>
References: <20210211000322.159437-1-mike.kravetz@oracle.com>
 <20210211000322.159437-5-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211000322.159437-5-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 10, 2021 at 04:03:21PM -0800, Mike Kravetz wrote:
> If page modifications are being monitoried with the soft dirty mechanism,
> then this information is contained in page table entries.  Tracking is
> enabled on a 'per-process' basis.  hugetlb pmd sharing allows processes
> to share page table entries.  This makes pmd sharing incompatible with
> soft dirty monitoring.  So, pmd sharing must be disabled if soft dirty
> tracking is in use.
> 
> The VM_SOFTDIRTY flag is set in all vma's by default.  When soft dirty
> monitoring is started, the flag is cleared.  We can therefore allow pmd
> sharing in vmas with the VM_SOFTDIRTY flag set.  Check this when deciding
> to perform pmd sharing.
> 
> A subsequent patch will add code to allow soft dirty monitoring for hugetlb
> vmas.  Any existing pmd sharing will be undone at that time.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b561b6867ec1..cf4aa63be9b1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5285,6 +5285,13 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>  	unsigned long base = addr & PUD_MASK;
>  	unsigned long end = base + PUD_SIZE;
>  
> +	/*
> +	 * Do not allow pmd sharing if soft dirty tracking is in use.
> +	 */
> +	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) &&
> +				!(vma->vm_flags & VM_SOFTDIRTY))
> +		return false;
> +

Reviewed-by: Peter Xu <peterx@redhat.com>

The indent of using three tabs is a bit weird to me, though.. I do see this
happen somewhere else in the repo too, so maybe it's a way to indent that I
don't know.

Thanks,

-- 
Peter Xu


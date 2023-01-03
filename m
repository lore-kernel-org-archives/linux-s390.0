Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043B2C4708E
	for <linux-s390@archiver.kernel.org>; Tue,  3 Jan 2023 23:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjACXjG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 3 Jan 2023 18:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjACXjF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Jan 2023 18:39:05 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798261DE
        for <linux-s390@vger.kernel.org>; Tue,  3 Jan 2023 15:39:04 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id x11so25851077qtv.13
        for <linux-s390@vger.kernel.org>; Tue, 03 Jan 2023 15:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4IcK9nCCJcWx4DXnUq9jN3aJ923JmnvuRI8XJBFIY/0=;
        b=AinaOJu6/IFu11c89krxqHstp+Qx6bg/GaS+/T4HG1pBBDurgbVIkkpQhX5l5tMvqb
         Dt1aixulGN49hn0TCZDfJL7P2ujEI3Sb32Da2Ad7RzLbA8dzxkEYLQq3GZQcrenecSyI
         FUTCfOup8/4qyfgTpAhOtrWipWNbIm0VnCSVdwFYngsL8nHD9rkzKFRezi0Kl7Q3hvbA
         wfliVsDb7QqWxrnaKcP0ps9OCvq8tpOVmKmO7wCblz0d6e8uNpGAskXpNHAZ3s+sAcAQ
         h+10YPQxw7ir5wvpzI0aHOfOWM7euZeizl49b4id9HdeFXirSJK4GNlbhtO17TXeoseg
         BCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IcK9nCCJcWx4DXnUq9jN3aJ923JmnvuRI8XJBFIY/0=;
        b=OLE5seRAfYhICbXdTkxiv9M0wScTpi6gM5huLWeUrY72RGT+2sVQXMsG33UU0BBgqc
         tiwENuT9lhelm4yngmnJCPBmu8qAX4i36RU4rTNpyIPEmI6ht92xoasN4t0XRFwn4rl0
         kgOzF4eHpIZG+jpw8eBx9ja5NAav2WL8zt89b0bUlOI7+vQgC2Kp48LakqVUekoJgxkC
         Ak69WasYDxSIivieIuLNgSQlkrYL0LST15+kMleJxS7AcovIC4/ujBU1gL8rwmVQhSO8
         WewTq2U8UL7W54XHEDNe2snbPd8wWnDbgMj7+p4wtw53vsJs1rwIEqhIkC7pOYEUe5VL
         I7tg==
X-Gm-Message-State: AFqh2kq1xTFMpEhXAphADDXrlNgv9sYBgoJ5YGe5Ui00b7GkK9VTxrMy
        SgWFPelaXURZP3/xHQKhErhngQ==
X-Google-Smtp-Source: AMrXdXvvM0guVyAor9xuEVWRu39rmqbdPOUOe8zG+/P2s+Pkb0RWQqNWBIKUyv6DWLfpgnETi66GRw==
X-Received: by 2002:ac8:73c7:0:b0:3a7:f3e7:5149 with SMTP id v7-20020ac873c7000000b003a7f3e75149mr59471515qtp.61.1672789143621;
        Tue, 03 Jan 2023 15:39:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id m10-20020a05620a220a00b006eeca296c00sm22545055qkh.104.2023.01.03.15.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:39:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pCqs2-001cNC-IA;
        Tue, 03 Jan 2023 19:39:02 -0400
Date:   Tue, 3 Jan 2023 19:39:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Christian =?utf-8?Q?Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/1] vfio/type1: Respect IOMMU reserved regions in
 vfio_test_domain_fgsp()
Message-ID: <Y7S8loyvHyjAmNdh@ziepe.ca>
References: <20230102093452.761185-1-schnelle@linux.ibm.com>
 <20230102093452.761185-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102093452.761185-2-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jan 02, 2023 at 10:34:52AM +0100, Niklas Schnelle wrote:
> Since commit cbf7827bc5dc ("iommu/s390: Fix potential s390_domain
> aperture shrinking") the s390 IOMMU driver uses a reserved region
> instead of an artificially shrunk aperture to restrict IOMMU use based
> on the system provided DMA ranges of devices. In particular on current
> machines this prevents use of DMA addresses below 2^32 for all devices.
> While usually just IOMMU mapping below these addresses is
> harmless. However our virtual ISM PCI device looks at new mappings on
> IOTLB flush and immediately goes into the error state if such a mapping
> violates its allowed DMA ranges. This then breaks pass-through of the
> ISM device to a KVM guest.
> 
> Analysing this we found that vfio_test_domain_fgsp() maps 2 pages at DMA
> address 0 irrespective of the IOMMUs reserved regions. Even if usually
> harmless this seems wrong in the general case so instead go through the
> freshly updated IOVA list and try to find a range that isn't reserved
> and fits 2 pages and use that for testing for fine grained super pages.

Why does it matter? The s390 driver will not set fgsp=true, so if it
fails because map fails or does a proper detection it shouldn't make a
difference.

IOW how does this actualy manifest into a failure?

> -	if (!ret) {
> -		size_t unmapped = iommu_unmap(domain->domain, 0, PAGE_SIZE);
> +	list_for_each_entry(region, regions, list) {
> +		if (region->end - region->start < PAGE_SIZE * 2)
> +			continue;
>  
> -		if (unmapped == PAGE_SIZE)
> -			iommu_unmap(domain->domain, PAGE_SIZE, PAGE_SIZE);
> -		else
> -			domain->fgsp = true;
> +		ret = iommu_map(domain->domain, region->start, page_to_phys(pages), PAGE_SIZE * 2,
> +				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);

The region also needs to have 'region->start % (PAGE_SIZE*2) == 0' for the
test to work

Jason

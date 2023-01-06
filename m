Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC28C3DA7A
	for <linux-s390@archiver.kernel.org>; Fri,  6 Jan 2023 17:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjAFR0A (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Jan 2023 12:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjAFRZq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Jan 2023 12:25:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E50F7D9D9
        for <linux-s390@vger.kernel.org>; Fri,  6 Jan 2023 09:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673025904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRJJdpda2LberW2Uz7MtJU0ApzokqFKrYHUptCsTqd0=;
        b=U0SyufCJqS8a8+sByJi4e8drvIgVm0XH6Jd4Y3y+LxJYVp1iyPTaMU9nkrClOW74nhYB/s
        HC3j8jCFUMG1k2yRZhXcoKbQHKNM5kFIHZlioopVN4LC7UbxNDpOozj/tJnbX9sUS0E+HN
        TwUB73LGq7Z8OgJF3KPd44nHuEc7r50=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-198-vC5axV2qOvWK_grVOrFQhw-1; Fri, 06 Jan 2023 12:24:55 -0500
X-MC-Unique: vC5axV2qOvWK_grVOrFQhw-1
Received: by mail-il1-f197.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so1436448iln.21
        for <linux-s390@vger.kernel.org>; Fri, 06 Jan 2023 09:24:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRJJdpda2LberW2Uz7MtJU0ApzokqFKrYHUptCsTqd0=;
        b=q7i/J5Jz2S/io5+xo/JfPDgbAklQTqT4ONPdY3+h2E2qN2d1dBX855Syc56W+KFSFZ
         fLKOgnwCEww8PocuTSTAxXWz38QMHThaC4E33rLQCcOBAgrkZYd5NzUd7V153us95dOp
         dUWrf3fEAwGtF2/TUYEAuByhBGMfXv8i3HaM24ErHMucDykvh3d9DeydZ7a3LHJZYOjw
         vhS7yLjp9i9gpsWQvcNgpQ6bP9NxlP5J4+EEIKnxQSOLnJP/iv1rYNbwHrvvorZzCT2h
         fgc60sm+62zKFHHExP1LhdfbQwQ4sgvr2/cjYBQ4Vm7LxY/ng1EI4jRZbBfd+3LohB61
         euTg==
X-Gm-Message-State: AFqh2kqClWZO9nvUo3wgPpOyBBheXy+O8z02pZZuggM9z2CQeqx6A8wu
        x6RKLhhX9lSVYkedr6w41kvH8iG9N85xSf0du7EpFMvr8KB+vYmNzhem+KwRIwYjRYIBMDgaMdv
        LJmAg0JVSJQIaspFjooTCjw==
X-Received: by 2002:a05:6e02:105:b0:30c:8559:9d33 with SMTP id t5-20020a056e02010500b0030c85599d33mr8126738ilm.3.1673025894893;
        Fri, 06 Jan 2023 09:24:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtaheVCMJsd6UkYBpmwqPt3EuW+qeUOqMou/3T67c+kqzqmdM7Q68FRZUlmkLIekfUKA50HbA==
X-Received: by 2002:a05:6e02:105:b0:30c:8559:9d33 with SMTP id t5-20020a056e02010500b0030c85599d33mr8126722ilm.3.1673025894562;
        Fri, 06 Jan 2023 09:24:54 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a17-20020a056e020e1100b0030c186ea94fsm522963ilk.55.2023.01.06.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 09:24:53 -0800 (PST)
Date:   Fri, 6 Jan 2023 10:24:50 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= 
        <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] vfio/type1: Respect IOMMU reserved regions in
 vfio_test_domain_fgsp()
Message-ID: <20230106102450.2e6c70bb.alex.williamson@redhat.com>
In-Reply-To: <20230104154202.1152198-2-schnelle@linux.ibm.com>
References: <20230104154202.1152198-1-schnelle@linux.ibm.com>
        <20230104154202.1152198-2-schnelle@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  4 Jan 2023 16:42:02 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> Since commit cbf7827bc5dc ("iommu/s390: Fix potential s390_domain
> aperture shrinking") the s390 IOMMU driver uses reserved regions for the

Are you asking for this in v6.2?  Seems like the above was introduced
in v6.2 and I can't tell if this is sufficiently prevalent that we need
a fix in the same release.

> system provided DMA ranges of PCI devices. Previously it reduced the
> size of the IOMMU aperture and checked it on each mapping operation.
> On current machines the system denies use of DMA addresses below 2^32 for
> all PCI devices.
> 
> Usually mapping IOVAs in a reserved regions is harmless until a DMA
> actually tries to utilize the mapping. However on s390 there is
> a virtual PCI device called ISM which is implemented in firmware and
> used for cross LPAR communication. Unlike real PCI devices this device
> does not use the hardware IOMMU but inspects IOMMU translation tables
> directly on IOTLB flush (s390 RPCIT instruction). If it detects IOVA
> mappings outside the allowed ranges it goes into an error state. This
> error state then causes the device to be unavailable to the KVM guest.
> 
> Analysing this we found that vfio_test_domain_fgsp() maps 2 pages at DMA
> address 0 irrespective of the IOMMUs reserved regions. Even if usually
> harmless this seems wrong in the general case so instead go through the
> freshly updated IOVA list and try to find a range that isn't reserved,
> and fits 2 pages, is PAGE_SIZE * 2 aligned. If found use that for
> testing for fine grained super pages.
> 
> Fixes: 6fe1010d6d9c ("vfio/type1: DMA unmap chunking")

Nit, the above patch pre-dates any notion of reserved regions, so isn't
this actually fixing the implementation of reserved regions in type1 to
include this test?  ie.

Fixes: af029169b8fd ("vfio/type1: Check reserved region conflict and update iovalist")

> Reported-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> v1 -> v2:
> - Reworded commit message to hopefully explain things a bit better and
>   highlight that usually just mapping but not issuing DMAs for IOVAs in
>   a resverved region is harmless but still breaks things with ISM devices.
> - Added a check for PAGE_SIZE * 2 alignment (Jason)
> 
>  drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 23c24fe98c00..87b27ffb93d0 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1856,24 +1856,32 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>   * significantly boosts non-hugetlbfs mappings and doesn't seem to hurt when
>   * hugetlbfs is in use.
>   */
> -static void vfio_test_domain_fgsp(struct vfio_domain *domain)
> +static void vfio_test_domain_fgsp(struct vfio_domain *domain, struct list_head *regions)
>  {
> -	struct page *pages;
>  	int ret, order = get_order(PAGE_SIZE * 2);
> +	struct vfio_iova *region;
> +	struct page *pages;
>  
>  	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
>  	if (!pages)
>  		return;
>  
> -	ret = iommu_map(domain->domain, 0, page_to_phys(pages), PAGE_SIZE * 2,
> -			IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
> -	if (!ret) {
> -		size_t unmapped = iommu_unmap(domain->domain, 0, PAGE_SIZE);
> +	list_for_each_entry(region, regions, list) {
> +		if (region->end - region->start < PAGE_SIZE * 2 ||
> +				region->start % (PAGE_SIZE*2))

Maybe this falls into the noise, but we don't care if region->start is
aligned to a double page, so long as we can map an aligned double page
within the region.  Maybe something like:

	dma_addr_t start = ALIGN(region->start, PAGE_SIZE * 2);

	if (start >= region->end || (region->end - start < PAGE_SIZE * 2))
		continue;


s/region->// for below if so.  Thanks,

Alex

> +			continue;
>  
> -		if (unmapped == PAGE_SIZE)
> -			iommu_unmap(domain->domain, PAGE_SIZE, PAGE_SIZE);
> -		else
> -			domain->fgsp = true;
> +		ret = iommu_map(domain->domain, region->start, page_to_phys(pages), PAGE_SIZE * 2,
> +				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
> +		if (!ret) {
> +			size_t unmapped = iommu_unmap(domain->domain, region->start, PAGE_SIZE);
> +
> +			if (unmapped == PAGE_SIZE)
> +				iommu_unmap(domain->domain, region->start + PAGE_SIZE, PAGE_SIZE);
> +			else
> +				domain->fgsp = true;
> +		}
> +		break;
>  	}
>  
>  	__free_pages(pages, order);
> @@ -2326,7 +2334,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		}
>  	}
>  
> -	vfio_test_domain_fgsp(domain);
> +	vfio_test_domain_fgsp(domain, &iova_copy);
>  
>  	/* replay mappings on new domains */
>  	ret = vfio_iommu_replay(iommu, domain);


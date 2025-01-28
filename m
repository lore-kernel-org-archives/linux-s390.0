Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3401DE4F0
	for <linux-s390@vger.kernel.org>; Tue, 28 Jan 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738085409; cv=none; b=mjpLCx34Z1cIZGClrT+ktky6Rnb7BxSjEWqtmTZMSFD3+El7ZynXgurGMvvsbq6JhTtBr794btiuSiumB6PZdrQSJd0a4qYwWrOxs2Vncrv2vZokhp77emDkluxZIQ7wHTuxzbFgjp2VWcpcPLYiIgHNc20gFS9DPHIsEqpfgqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738085409; c=relaxed/simple;
	bh=tysSkBR0Z8lEM3foLBv4kTY9Hl+FQOveKxPM9tZicv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anwZvAYbV6JdDDzXKq99r6F5UmMzIMCc6c6X5s1+s/AI6heAJ8fnK2KWrDAofNYC5SW8zMCfc733rVIqacU+zGit0AYKZpxcLte9DFpATlI114ig7udtNUOneHQyCikRHuoWy3h5FjDRx2skGGFqnvEQN5j1CrVN/a+CYPsGh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HSKfS+Pe; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HSKfS+Pe"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so30502846d6.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Jan 2025 09:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738085404; x=1738690204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDYik77/xun0xe9niWU6y+mgX3x25FoUK2bntOot5h8=;
        b=HSKfS+Pen+E1eAmdaH+/tgPIPWNbEvIvLYK6ikAPw8R3s6bqswuZIqxyWjTvdfp7X4
         DtdURVo10Dyfci4XGe8DlrFGbwjuvEf3nKOeQ3zG5SmKAF2je9+KM8q5NUFWUyv3ulf1
         /KyRbfM0U3hj6kJ8EpPgZMt/VtG5Z24rsSMIaCxzi26l8NQN9dFf6jdw2kJNBaTobDfq
         VqrOdCGkO4ATZxU6NDTYGZh2iz3tNvbhQiOAZw0Kwjotzkm3lnrQpB1fJ58OawsKL1gE
         WD0oFyvsQPbq/QlLVCebWNuUKiPHscDz4BOC5NedgP6mc131nFLgEGz1bw3Dd5K+6D41
         FAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738085404; x=1738690204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDYik77/xun0xe9niWU6y+mgX3x25FoUK2bntOot5h8=;
        b=wfmGmZ4Wcveg87y/inb1Pn4CeTq26RJOCVDbJUn26puJuAHXdvJoWWcn7lSJ2Cew7O
         WUeZroiArSey9PttDZEQKHSkA4D2pJbm/JAzOodY/u9Wt45zWARpTr/VhjWmzRmeqQXT
         kJasHLGFTStraI21JMl69O6flmgxQtFbiqxQZddLIoL9ZhHQYeXQHHgAfA/+WK+ecDXw
         8X9O4CVdp2OWAyxJvsuZTbxT0OgAi2izBKp1dB3C64QY8nd9ZxJDfZabuPmo88RRZ1wg
         ythEkQhFq/7gXf8ky6VWPGFGRyaKiOFoXFAkIe683Z27IhaSDpl43gRQacatCfe8HbOd
         g4mA==
X-Forwarded-Encrypted: i=1; AJvYcCVaKFgmWONDZH5So5Ze8ZDWBdHVcMB1GL7Br6Ue9NxV0uSOwxlDUiNbry4GGpr4UkDZCtn7GgE5u4xS@vger.kernel.org
X-Gm-Message-State: AOJu0YwslEgtlLtuLZJxeH/K0wl7MBmtGIVSazm42qD2Uq+1D1NFA9y0
	YRLRALqlAFOBgiHwe9qufuzZN69foFc/2QcWRqXEXiB7mK5CAeTpBI0H/unVHAI=
X-Gm-Gg: ASbGncsNFqM7YLUf7nnFVbgCgVpFbeayGFjDBkpUPAGItKt1Bl41kh7URglKGmHARL1
	vuoP5CAC3ngHP6CGHGdP431WqDsXuc7CaUTLqPGUvbsPwVFvZtRAX6PYwi/paHf7w+4UoEwAcQD
	r1P/8FgxOiD0kCVIX8KzsMJvOiIXtl+436NyXyNuMdsS4u+UwUsgAvpXF1pMAClIwwWzH1kjBFk
	okfP0SnRvf5J8b2s/6NJQCjox034wwPs43J8k5//3Z+dyqVY97mtc/s1/0maIwWPWpfHvqW/Okb
	L098aJG49gRClBNZWHDoYFolTKFgavBzOJAvYhAwOY5Bn1TsaEdLuyH4YmLgD+UW
X-Google-Smtp-Source: AGHT+IHXPALu4u+DKA7wUGmdN7CK3HwJKRJc2DZTgmFqwqNFpsajznD1cDb3S1znrg8mB76NY8eQ8Q==
X-Received: by 2002:a05:6214:224e:b0:6e1:5076:c400 with SMTP id 6a1803df08f44-6e1b21e52edmr675377206d6.39.1738085403769;
        Tue, 28 Jan 2025 09:30:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20524c9afsm47259876d6.48.2025.01.28.09.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 09:30:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tcpPW-00000007fAp-37V1;
	Tue, 28 Jan 2025 13:30:02 -0400
Date: Tue, 28 Jan 2025 13:30:02 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	svens@linux.ibm.com, borntraeger@linux.ibm.com,
	farman@linux.ibm.com, clegoate@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iommu/s390: implement iommu passthrough via
 identity domain
Message-ID: <20250128173002.GE1524382@ziepe.ca>
References: <20250124201717.348736-1-mjrosato@linux.ibm.com>
 <20250124201717.348736-4-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124201717.348736-4-mjrosato@linux.ibm.com>

On Fri, Jan 24, 2025 at 03:17:17PM -0500, Matthew Rosato wrote:
> Enabled via the kernel command-line 'iommu.passthrough=1' option.
> 
> Introduce the concept of identity domains to s390-iommu, which relies on
> the bus_dma_region to offset identity mappings to the start of the DMA
> aperture advertized by CLP.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  arch/s390/pci/pci.c        |  6 ++-
>  drivers/iommu/s390-iommu.c | 95 +++++++++++++++++++++++++++++---------
>  2 files changed, 76 insertions(+), 25 deletions(-)

Seems Ok

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> -static const struct iommu_ops s390_iommu_ops = {
> -	.blocked_domain		= &blocking_domain,
> -	.release_domain		= &blocking_domain,
> -	.capable = s390_iommu_capable,
> -	.domain_alloc_paging = s390_domain_alloc_paging,
> -	.probe_device = s390_iommu_probe_device,
> -	.device_group = generic_device_group,
> -	.pgsize_bitmap = SZ_4K,
> -	.get_resv_regions = s390_iommu_get_resv_regions,
> -	.default_domain_ops = &(const struct iommu_domain_ops) {
> -		.attach_dev	= s390_iommu_attach_device,
> -		.map_pages	= s390_iommu_map_pages,
> -		.unmap_pages	= s390_iommu_unmap_pages,
> -		.flush_iotlb_all = s390_iommu_flush_iotlb_all,
> -		.iotlb_sync      = s390_iommu_iotlb_sync,
> -		.iotlb_sync_map  = s390_iommu_iotlb_sync_map,
> -		.iova_to_phys	= s390_iommu_iova_to_phys,
> -		.free		= s390_domain_free,
> +#define S390_IOMMU_COMMON_OPS() \
> +	.blocked_domain		= &blocking_domain, \
> +	.release_domain		= &blocking_domain, \
> +	.capable = s390_iommu_capable, \
> +	.domain_alloc_paging = s390_domain_alloc_paging, \
> +	.probe_device = s390_iommu_probe_device, \
> +	.device_group = generic_device_group, \
> +	.pgsize_bitmap = SZ_4K, \
> +	.get_resv_regions = s390_iommu_get_resv_regions, \
> +	.default_domain_ops = &(const struct iommu_domain_ops) { \
> +		.attach_dev	= s390_iommu_attach_device, \
> +		.map_pages	= s390_iommu_map_pages, \
> +		.unmap_pages	= s390_iommu_unmap_pages, \
> +		.flush_iotlb_all = s390_iommu_flush_iotlb_all, \
> +		.iotlb_sync      = s390_iommu_iotlb_sync, \
> +		.iotlb_sync_map  = s390_iommu_iotlb_sync_map, \
> +		.iova_to_phys	= s390_iommu_iova_to_phys, \
> +		.free		= s390_domain_free, \
>  	}
> +
> +static const struct iommu_ops s390_iommu_ops = {
> +	S390_IOMMU_COMMON_OPS()
> +};
> +
> +static const struct iommu_ops s390_iommu_rtr_ops = {
> +	.identity_domain	= &s390_identity_domain,
> +	S390_IOMMU_COMMON_OPS()
>  };

Though it is a pattern in iommu drivers to use a non-cost ops and
mutate them during probe. For instance you could NULL
s390_iommu_rtr_ops->identity_domain if the platform does not support
it.

On the other hand your version with a const ops is security nicer.

Alternatively, I have a patch series that adds a
domain_alloc_identity() function to get virtio-iommu moved to the new
APIs, that could work well here too and keep the const ops.

Jason

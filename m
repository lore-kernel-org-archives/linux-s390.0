Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74E18E027
	for <linux-s390@vger.kernel.org>; Thu,  8 Aug 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124697; cv=none; b=qCrL2xHQfmCjlwIjwZymlNEY82li9ByUJCM8015ncs3T940R4eIeyFPjrU8t/BEGJY83mz9LCP3EkUqGOY0x8QPee9Yfgd8qX+XW1HqAsPO0msfj89qCNZRyvXCdu+uTvdF8hdKB2ok/wnf8YPE0V9fRyeG/7mEPUVxJBbItrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124697; c=relaxed/simple;
	bh=v4z/T2QMQWRkZbfhTp7wy+humaxZM4Ysj28SZ3O15Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBspy81iIWGnJ/zWDcxRCH+lRgAlWMf3J6gq1G6RBKx/y1wpYQtJOD2FfLydk27/mVOKsNIrpPUOwUqw1od2F/gXhObbbXqzkPSQIQl0gq+1Xx08PyYh0glRURx7DEMcP7Ts3dVpL0uXI48Kos0Pw0T5Z51HXJS1qCmpzoLnio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U0GNrD6p; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U0GNrD6p"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso929588276.0
        for <linux-s390@vger.kernel.org>; Thu, 08 Aug 2024 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723124693; x=1723729493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lf+LaXbOqHU1zf4xD79bBxN+yUqIFJd0X9fwfr61rGQ=;
        b=U0GNrD6pRhmLDwQ+z8x+RGZxy3VRtmZ9mlLcc2S5P99XyxH6QrBbXiiDmV7Z70Twd4
         U01KUD466KKh2YrWVYkfXAGGFCJWzc/HD8HCmiYL43GULBy4hFVy/TFnYPEgeKMKuO5O
         6/UXa+rHetPIHcSKNmoY3GPKLcvcDvKvkNVEoi/tx1dxPr7K7t30SAY4+cuyNwxyF4km
         eANNs3Q4IMj0dY4sKWytzLdPLOKLVvbiEfvVS5NwEfPwqfNF8qinb89/LmPm44qJGVBW
         x2JB1L1NrFcJW+sJu/cbmQan7gKRkHSYFzlvQ0gUfb/9A4KrrUpZVj4VhJCfwFQ9eiEi
         uGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723124693; x=1723729493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf+LaXbOqHU1zf4xD79bBxN+yUqIFJd0X9fwfr61rGQ=;
        b=uoBuuMX/gqg4xvmpxPLtPbeNHD/1CVbcujz9FwiYJqc33xnMJ+oOCLZHJD1ZAXfqMM
         YMyDgY+gQTAqa/vBAdjN7oKkbRKCbgWU7ct0GyT7zVqA02VbbGU3LPqcVfDo75z4kNIv
         89TWGViWoU5j7vcKSCyTY7KYLnMPqqyN9fqosPm3R2Rfp0kG7mYvt70xb43CkvEykqHm
         8f5tP9JcG2z+5aO+b3E3Rh0dZh4QoDV4dB93H/bAK3Asmg+KlAt1Kdt4VXZWbnS6grE4
         4NHPPbeNf2c5YNqieX0kqH5drUIKVsER2ZVZ7g7d/MnI2G0RMu7hwnK3GTxtZRA6R0FD
         Cd5w==
X-Forwarded-Encrypted: i=1; AJvYcCVWsLkE/sjfLwg8s8RdnEMJELrTSbhkShITvLovW5PX//yq9NiIxVWj/b84/+Vnv7y4xCFOVVMMNgq1+/43Z3s44ZKfgluHC3kUvw==
X-Gm-Message-State: AOJu0YxU5tkqLG1VkssK50yYq4PM/kt+T+YiX84a6mE8gBqbVaWq4b7A
	DuNknJ6XNOd6sWQaCq7DvMcXBc4/yiXG3qHe8WcTxfGm/+RTY5iV9rytwL1eack=
X-Google-Smtp-Source: AGHT+IFkk1wcTebhQWnEQD8v7UnnmwSVZFNhMGrZ+kfAFqxL6cjXwd838hwbGHYCXjCUBuvserTTnA==
X-Received: by 2002:a05:6902:1b92:b0:e05:fdbe:bbf7 with SMTP id 3f1490d57ef6-e0e9dbf3af4mr2040319276.42.1723124693271;
        Thu, 08 Aug 2024 06:44:53 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785f0b5dsm159678085a.58.2024.08.08.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 06:44:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sc3Rj-0093Vj-0x;
	Thu, 08 Aug 2024 10:44:51 -0300
Date: Thu, 8 Aug 2024 10:44:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] iommu/s390: Implement blocking domain
Message-ID: <20240808134451.GC1985367@ziepe.ca>
References: <20240806-blocking_domain-v1-1-8abc18e37e52@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-blocking_domain-v1-1-8abc18e37e52@linux.ibm.com>

On Tue, Aug 06, 2024 at 03:45:15PM +0200, Niklas Schnelle wrote:
> This fixes a crash when surprise hot-unplugging a PCI device. This crash
> happens because during hot-unplug __iommu_group_set_domain_nofail()
> attaching the default domain fails when the platform no longer
> recognizes the device as it has already been removed and we end up with
> a NULL domain pointer and UAF.

Huh?

A device can't be removed before telling the iommu subsystem about
it. How did the domain become NULL asynchronously while the iommu side
thought it was still alive?? That seems like the main bug here..

> Note: I somewhat suspect this to be related to the following discussion
> or at least we have seen the same backtraces in reports that we suspect
> to be caused by the issue fixed with this patch.

No, it shouldn't be. That bug is because the netstack is continuing to
use a struct device with the DMA API after the device driver has been
removed. That is just illegal.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ed6c5cb60c5a..91b3b23bf55c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -119,8 +119,11 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>  static void __iommu_group_set_domain_nofail(struct iommu_group *group,
>  					    struct iommu_domain *new_domain)
>  {
> -	WARN_ON(__iommu_group_set_domain_internal(
> -		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
> +	int ret = __iommu_group_set_domain_internal(
> +		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
> +
> +	/* Allow attach to fail when the device is gone */
> +	WARN_ON(ret && ret != -ENODEV);
>  }

Like this doesn't really make sense. Until the iommu subystem removes
the device from the group it really cannot be "gone".

The hypervisor could fail attachment because the hypervisor has
already fenced the device. Sure, that make sense, but it is not really
that the device is gone from a Linux perspective, it is just now in a
forced-blocked state.

Like Lu says, if we need to add a new flow for devices that are now
force-blocking and cannot be changed then it will need its own error
code.

But what is the backtrace that runs into this warn on? VFIO exiting
and trying to put the device back to the DMA API?

Though I feel like more is needed here if you expect to allow the
nofail version of this to actually fail.. For instance a force-blocked
device should block driver binding through the dma_owner APIs.

> +static int blocking_domain_attach_device(struct iommu_domain *domain,
> +					 struct device *dev)
> +{
> +	struct s390_domain *s390_domain = to_s390_domain(domain);
> +	struct zpci_dev *zdev = to_zpci_dev(dev);
> +	unsigned long flags;
> +
> +	if (!zdev)
> +		return 0;
> +
> +	/* Detach sets the blocking domain */
> +	if (zdev->s390_domain)
> +		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);

When I've done these conversions on other drivers it was the case that
zdev->s390_domain is never NULL. Instead probe_device immediately
starts it as a blocking_domain or fails to probe.

This way we don't ever have the ill defined notion of NULL here.

> @@ -777,6 +812,8 @@ static int __init s390_iommu_init(void)
>  subsys_initcall(s390_iommu_init);
>  
>  static const struct iommu_ops s390_iommu_ops = {
> +	.blocked_domain		= &s390_blocking_domain.domain,
> +	.release_domain		= &s390_blocking_domain.domain,

If you set release_domain then remove s390_iommu_release_device(), it
is the same code.

Jason

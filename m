Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E01AD3E2
	for <linux-s390@vger.kernel.org>; Wed, 14 Aug 2024 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593606; cv=none; b=hGtX1mjp89k0DmMecUf5bYp00tl65en68niNwoPxArw4IlGX/jex2lV2cYFhk/sbUsdWJbTLVjEBtFAc2KTDmEz5EmFSeG+EeaSyH8u6mTgzRcYe/TFXR+ujcxNT4lA+/vpH0SFE3RIdw3KVvfYQqaEtpz/Ypb/z1dyZLMkwmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593606; c=relaxed/simple;
	bh=lyUBr8DcNwXFGeDmAOEtTkq0g9vv6Eeu+1G6uPz0/T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN4zsndgl79kylFBIqndOrj3C8Ti0W/AtWqGpCkMzdYIXZiICoLtd22PBh9YVfx8odqBFj1v2tbUPH55v+wVdzwxf5rk4DlFhPFb795+RPdyzvVKqYkWsVXkC7Mx6EXtM/+F+isf1D4k6wp8/zqDx/BjwBrTxdcZhSrjLdNfnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Fp5jItZ0; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fp5jItZ0"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5af743b8fso3229675eaf.3
        for <linux-s390@vger.kernel.org>; Tue, 13 Aug 2024 17:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723593602; x=1724198402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQGE2zWdMfVGgSfoUheG6pezAQlX6jQvTcEtw8hGlq0=;
        b=Fp5jItZ0FRtc/8E1cro5XRTKs/2b07RSSGHjNPFxbSDkvL/PwmxkxM/PvkY4xjpieU
         JMsduVf0pcqJT70Uovaa45TDQs2D7/p3Vb2x7sXATsvwbi54s/yUKpiQsCXsmhyCni/g
         hOaooN9Ip7xfEvsEqd+uIqigKb0lUINXICrPNIFo/bWqyjL9Sd2xDtAp7nD5o1nv4u0p
         TUWDcA2B+w4I/Vuk/tTbDYgUs8wWOwHljnkEoltVsQulmcP9LeVBY7iWpuT4yad3Uigz
         /W8mthyjPtRhDLJDfblADq2ytAFeksBFWpywLE7+yD4QxCdDj3p9lXhTimcRGfJMVr2e
         oE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723593602; x=1724198402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQGE2zWdMfVGgSfoUheG6pezAQlX6jQvTcEtw8hGlq0=;
        b=WvmyI03CdWo5zTkAK2u+O7kThZpn1K/hnkhmDsz3Vt0yYagEteE2RXGHt4NaiCG16a
         St4UeKwS0M+qpn2OLEhKZlQKNSQaVxSWKJp04uHy5D3/IIWqOExvSdEvyBCRebtU17WK
         +lq0I0AHEr/WHmtdAKmKyMxe69VdT88afsWALpPFehgHRqAiQEkSvnDQRse4wxAsEopx
         4wYu0aEh1t0LUtZgTw27maDXp+6LvnJs57OVhT9HMR2dfzqEv8lXKL2ZDYlyoQza3i5L
         vFT4qK/6weXYRCtkhsp7xyLy/Y+Z8cCUva+B2RUk27OT77UVHEL9yo3U1O6yEZ+J7H31
         pewg==
X-Forwarded-Encrypted: i=1; AJvYcCU+6av2UGW1DfxdFZwoG6Hd1EXfbgRK8bgcs0aJqit0p1x5/UIZY3muK9eKLH8/JKczwmnU5me65mK1w70ReT9C1R48B4yiRYfOCA==
X-Gm-Message-State: AOJu0YwOhYHgNSiB4C0CqXD/IXU256FV2DECoU2jzkXOEqElcOc2rk/M
	tt81igacfYbp9mjV/Xn3dO63poR9rl85ulFeyg3QAa8Do13TBYRJjyK85ETymOY=
X-Google-Smtp-Source: AGHT+IG/rb7hCnWcydFZZ0in+bYCzY+Gq20Mo60sp+Z1pjHVWRsNQtmZT6YFEMIf1f/7Bb3NVEAo2Q==
X-Received: by 2002:a05:6358:724d:b0:1aa:c9ba:4330 with SMTP id e5c5f4694b2df-1b1aab0fe3fmr133802555d.4.1723593602440;
        Tue, 13 Aug 2024 17:00:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c28ed1csm36351451cf.86.2024.08.13.17.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 17:00:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1se1Qn-00AUce-3o;
	Tue, 13 Aug 2024 21:00:01 -0300
Date: Tue, 13 Aug 2024 21:00:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
	baolu.lu@linux.intel.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, svens@linux.ibm.com, jroedel@suse.de,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] iommu/s390: Implement blocking domain
Message-ID: <20240814000001.GU1985367@ziepe.ca>
References: <20240813192803.129449-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813192803.129449-1-mjrosato@linux.ibm.com>

On Tue, Aug 13, 2024 at 03:28:03PM -0400, Matthew Rosato wrote:
> This fixes a crash when surprise hot-unplugging a PCI device. This crash
> happens because during hot-unplug __iommu_group_set_domain_nofail()
> attaching the default domain fails when the platform no longer
> recognizes the device as it has already been removed and we end up with
> a NULL domain pointer and UAF. This is exactly the case referred to in
> the second comment in __iommu_device_set_domain() and just as stated
> there if we can instead attach the blocking domain the UAF is prevented
> as this can handle the already removed device. Implement the blocking
> domain to use this handling.  With this change, the crash is fixed but
> we still hit a warning attempting to change DMA ownership on a blocked
> device.
> 
> Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
> Co-developed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> Changes for v2:
> - Added co-author tag from Niklas + my SoB
> - Removed changes to drivers/iommu/iommu.c
> - Revert back to -EIO for failed attach in s390-iommu
> - Set blocking domain during probe_device / remove s390_domain check during
>   blocking attach
> - Remove s390_iommu_release_device
> - Update commit message to reflect changes
> ---
>  drivers/iommu/s390-iommu.c | 64 ++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 20 deletions(-)

This is probably OK as is, but there are a few things that don't quite
match the pattern still here

The blocking domain should be the iommu_domain type since it is
global and shared. None of the additional driver members should ever
be touched as that would maybe become dangerous.

> +static struct s390_domain s390_blocking_domain = {

Ideally would be struct iommu_domain s390_blocking_domain

That in turn means going around and looking carefully at
zdev->s390_domain. All uses can probably be removed except for this:

struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
{
	if (!zdev || !zdev->s390_domain)
		return NULL;
	return &zdev->s390_domain->ctrs;
}

Which doesn't look good for a blocking domain anyhow. Also the above
looks racy, nothing prevents s390_domain from being freed if it is
read outside an iommu op.

The checks for null zdev also don't make sense:

static int blocking_domain_attach_device(struct iommu_domain *domain,
					 struct device *dev)
{
	struct s390_domain *s390_domain = to_s390_domain(domain);
	struct zpci_dev *zdev = to_zpci_dev(dev);
	unsigned long flags;

	if (!zdev)
		return 0;

The core guarentees these functions are never called unless probe
succeeds and probe won't succeed if zdev is NULL.

And it would be good to rename s390_iommu_detach_device() to
blocking_domain_attach_device(), then the obsolete "detach" naming is
gone and this driver just uses a blocked before attach pattern.

> @@ -403,16 +414,14 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
>  
>  	if (zdev->s390_domain)
>  		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);

s390_domain is never NULL now, the test can go away

> +static int blocking_domain_attach_device(struct iommu_domain *domain,
> +					 struct device *dev)
> +{
> +	struct s390_domain *s390_domain = to_s390_domain(domain);
> +	struct zpci_dev *zdev = to_zpci_dev(dev);
> +	unsigned long flags;

flags is never used? Compiler didn't warn?

Jason

Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99B2066FB;
	Fri, 21 Feb 2025 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135763; cv=none; b=A5YqGNoWLeiiQQv/E90xdp7MTzH0Et4vsdpu8I3w9/ldmSsaMZMRY9wfxYHmHi4SKQFn4AJMbTaHsCRaPdAXd4rc/IZaB35hrFFiRl6WkNTXoOfjWyGzv9D2WdO3Lcg3N9P1iYGBba25j1W2TIKhgUpL6K59Ysw20ksEJRcwzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135763; c=relaxed/simple;
	bh=kj4d0d41STTV9L3rbd8n4L8j2d2EbKeh7wEJWkAUSYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDLeyPksXoQV9vGrfESO6MXnsS7BxZyhScBkR7lLtJvjFID84RViWYAcSWQzJ+Tr8WIUvhgR2AXP4HBHcfla4wZtOR0eOBANSBjgDD3hVJ2mHPvK3z4XoN+Zyk9Uyg96DmmCeQU0bJQ7SVZ8If2IGeiq6BeELDw7NK5TaCBvCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=efRkc6S9; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="efRkc6S9"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4AAAE42FC0;
	Fri, 21 Feb 2025 12:02:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740135754;
	bh=kj4d0d41STTV9L3rbd8n4L8j2d2EbKeh7wEJWkAUSYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efRkc6S9UE9J/RtnztI1PsUPpiWWOB6d5HvnsxnbewjzKdWjmg2r53hAVFdanm05e
	 1gdZdnqBKvssNIGBPOkK4x2yIM0WhsThUBzj9eioHcZ08r+w4hO6i01g6t33bNRFq9
	 tPoyDszUT88tuRRjswz+479soi1xVin29Vp8RosqVOl8zgiw4ZkvMODuRf8zubOEGT
	 dCo9MsxwJECMAfIODisbQwZfoQnA0Db3sdBQJdpaF59e0aDDsxSbFwdJ1czIPOUv5k
	 QFWKE/G0T0fVCOZLpznSKatAz2r/0I83QykeTx/Q4a1uX4islC1CvqeEANf/01NGur
	 sXR+FJeMDQLyg==
Date: Fri, 21 Feb 2025 12:02:33 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: will@kernel.org, robin.murphy@arm.com, gerald.schaefer@linux.ibm.com,
	schnelle@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, svens@linux.ibm.com,
	borntraeger@linux.ibm.com, farman@linux.ibm.com,
	clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 0/4] iommu/s390: add support for IOMMU passthrough
Message-ID: <Z7hdSXY3N79AkZj7@8bytes.org>
References: <20250212213418.182902-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212213418.182902-1-mjrosato@linux.ibm.com>

On Wed, Feb 12, 2025 at 04:34:14PM -0500, Matthew Rosato wrote:
> This series introduces the ability for certain devices on s390 to bypass
> a layer of IOMMU via the iommu.passthrough=1 option.  In order to enable
> this, the concept of an identity domain is added to s390-iommu.  On s390,
> IOMMU passthrough is only allowed if indicated via a special bit in s390
> CLP data for the associated device group, otherwise we must fall back to
> dma-iommu.
> 
> Changes for v5:
> - Fixup error checking for bus_dma_region size
> - Add review/test tags
> 
> Changes for v4:
> - Additional patch to handle IOAT registration within s390-iommu.  This
>   fixes an issue with re-registration of identity domain during events
>   like zpci_hot_reset_device
> - Fixup page alignment for bus_dma_region setup
> - Dropped a few review/test tags due to above changes
> 
> Changes for v3:
> - Rebase onto 6.13
> - fixed bus_dma_region size (Niklas) 
> 
> Changes for v2:
> - Remove ARCH_HAS_PHYS_TO_DMA, use bus_dma_region
> - Remove use of def_domain_type, use 1 of 2 ops chosen at init
> 
> Matthew Rosato (4):
>   s390/pci: check for relaxed translation capability
>   s390/pci: store DMA offset in bus_dma_region
>   iommu/s390: handle IOAT registration based on domain
>   iommu/s390: implement iommu passthrough via identity domain
> 
>  arch/s390/include/asm/pci.h     |   4 +-
>  arch/s390/include/asm/pci_clp.h |   4 +-
>  arch/s390/kvm/pci.c             |  17 +---
>  arch/s390/pci/pci.c             |  35 ++++----
>  arch/s390/pci/pci_bus.c         |  25 ++++++
>  arch/s390/pci/pci_clp.c         |   1 +
>  arch/s390/pci/pci_sysfs.c       |  11 +--
>  drivers/iommu/s390-iommu.c      | 138 ++++++++++++++++++++++++++------
>  8 files changed, 168 insertions(+), 67 deletions(-)

Applied, thanks.

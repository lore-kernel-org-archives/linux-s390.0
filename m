Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C33ACEE9;
	Mon,  8 Jun 2026 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952304; cv=none; b=aMXJXcls4aPgvJJGqyvSJpHngFElTflcet5NK/z6Kjq4CantGb9Bha0L18CxYEWVS0CFvwVWcFGPTbZnhm9MF3XK3+pilxSC7wttpuHGYOtHeCFHUjOXsGDzLnci8Z3l7qxUAqrM0le7rCQqVWOgY5ksaAJHu29t8oj7kRrmX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952304; c=relaxed/simple;
	bh=Q27Zdb+kF51K+jdqLK0AruNnM8NCFFoZ7m413Ngs/cc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lmVav7JanCt3pVi8zdhP+Sre7sGTFYRzwqGe3JQ2AJXwEUUTMXOKLavQUYHPiJczq853lX0xwouMkHUYZ+Y6oDv4tINKKuzu/17WHBMuI3Pd4syembKYmOCkolqRauMCqTpDbPfNDzgRC9J0wzCnO2MF5CI5qKETY+7QNSM/dMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih0Yppl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih0Yppl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FE91F00898;
	Mon,  8 Jun 2026 20:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780952303;
	bh=MnnYMxjYrpHOw7mwTYOO6RexMQiDhUDcBZsiKTjwfkM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Ih0Yppl7pFXzMm4unDKUWZADI+HdUUopOs1VjiFQFxDBFXeV/jgy6S0NLcOUynuzn
	 ceUbDC7ME4k3aRYbEaI6bjcIn2Ah0iToiUoMufU3E8bne5kwULoAg0qedzw1YK6PVF
	 okzf/1McD96k886/SOgRqROygwN6JNM2P2a+pyW0PPr+PhE6IQefzzBqXIGEQKfH3C
	 JgPaNvWy0fwpBBDMQitMo6Qkjj7pytBbW/HUGfNj81LhgY4wcVBX9F3FozqsrXMrsD
	 FBphSKVSYyptZp0Ucty3008+vHDuWFz82MVfKQqwsKJhqXgE1u8YPj7L1VSJJ1gT2j
	 uS7VwxoasBd4w==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id F2973F40076;
	Mon,  8 Jun 2026 16:58:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 08 Jun 2026 16:58:22 -0400
X-ME-Sender: <xms:7SwnasK1vwPI6yq-jWrrV-wxSqWYp3h-BhXqa1MPoRYCCuhdjvqHlQ>
    <xme:7SwnanQYOOVXFJv5iW1n2ySdZYJL2Znm2HmUHYvbzEt8O-axb4B9HIue7KfgNZl4I
    LkBYQO8zaOni7Fe4nEJ6_YZa-Q4h7RW7rTkxT93fxbMretR-vp05N0>
X-ME-Received: <xmr:7SwnajFIeLRrVS89yZM79i49yQfqWUrK-WbleevLjNRwgl5ePK7_tCU5o1cUAZuyhwgEODFAJuBDaZj6DNBakENJ17MzDCNJihI>
X-ME-Proxy-Cause: dmFkZTGP9x8buTQcIGw9eBuielzgRk78B5z7jEIpxuXdhXbMY3b3bCj/WyeIYQV5NgDglD
    q1JwUuBggNZgjADQ893ZM+dthjPdfnhQFB6H/PFmyV1IWif+adhfC/SUsoHRe+1JQxW9DJ
    t5bcS7GNIvRhD/mIVeBtbBVzzbBYL8rlYKCUVly1FzibZDeyWk7STAmZ1Z1+DAKo6nG7mL
    neUTtcjh7VPvYOJQggjAJvMUVnzWceSVmbvLONMxv11siBHty2D7S8UUXQAnBCGxnXtc7O
    E57znILnfs0VWSi8HPlmq7Q2jhdz8+M+Vj7JGz9oPJk41BLvML9M/sVsnEyPstBwSpY2F7
    uEHHp3kXXNWii6ZfOjNgkPOnhF9qAM9wJHMLNeIeJHiulCnDy4wW+G4Pna5nJHJ5w9DqZ2
    Ns+OpB6nkDmr3J6KyHmaelXoff8wLwTux+u+HKBHjlY7bZZkGnmv9eDXZWw+1m6u/371Az
    4fuOOJ6PSINwESQ72WLkMfLv+BMq4p+TADU0Ic93rVPTCgYvHrGKnTEakCaKiPiEQzKXPG
    SebO2OVdAWAnp16t3mo5+7tBm0pj+I0us0+OCpzl9M+7FDjn3tyMM0N1ZgzDcnnEanhWIk
    6j9V3wdt5JT5oxi8nhukS74Dh9/kX2/rHSTe0uVjoh+w5QUx0RLyM9E0Kkww
X-ME-Proxy: <xmx:7SwnakWz0TW4RvbJ4B5HPTaGRQO8RQXSlE9eFO__EkBXtSomkENEXA>
    <xmx:7SwnalyHpT4bamDdI_8r50K51151jtoYe40VtT52cgmVoNr-3SL1ow>
    <xmx:7Swnag-Y6ol94bkeTGOS5GYWpOGvHtsk4sUlOrq6tFIFWVpxS2snMQ>
    <xmx:7Swnai_Wj2ffpyXcI2n777ZFPFkk3u6OihrgqhODTv6Oq98DKB1kBg>
    <xmx:7Swnanw6AnXrPO7wNAQIUI1IMUMNYVpe2JnNzz2l8pSPo5TOS6_GOHE6>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 16:58:21 -0400 (EDT)
Date: Mon, 08 Jun 2026 13:58:19 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>, 
 Alexey Kardashevskiy <aik@amd.com>, 
 linux-coco@lists.linux.dev, 
 iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,  Dan Williams <djbw@kernel.org>,
  Jason Gunthorpe <jgg@ziepe.ca>,  Joerg Roedel <joro@8bytes.org>,
  Jonathan Cameron <jic23@kernel.org>,  Kevin Tian <kevin.tian@intel.com>,
  Nicolin Chen <nicolinc@nvidia.com>,  Samuel Ortiz <sameo@rivosinc.com>,
  Steven Price <steven.price@arm.com>,
  Suzuki K Poulose <Suzuki.Poulose@arm.com>,
  Will Deacon <will@kernel.org>,  Xu Yilun <yilun.xu@linux.intel.com>,
  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
  Paolo Bonzini <pbonzini@redhat.com>,
  Tony Krowiak <akrowiak@linux.ibm.com>,
  Halil Pasic <pasic@linux.ibm.com>,  Jason Herne <jjherne@linux.ibm.com>,
  Harald Freudenberger <freude@linux.ibm.com>,
  Holger Dengler <dengler@linux.ibm.com>,
  Heiko Carstens <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>,
  Alexander Gordeev <agordeev@linux.ibm.com>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,
  Sven Schnelle <svens@linux.ibm.com>,
  Alex Williamson <alex@shazbot.org>,
  Matthew Rosato <mjrosato@linux.ibm.com>,
  Farhan Ali <alifm@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,
  linux-s390@vger.kernel.org
Message-ID: <6a272cebec4af_4fa7810048@djbw-dev.notmuch>
In-Reply-To: <yq5aik81sf22.fsf@kernel.org>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
 <yq5apl2gsw6y.fsf@kernel.org>
 <yq5aldd4spyc.fsf@kernel.org>
 <6a1774dd80f74_19737610095@djbw-dev.notmuch>
 <yq5aik81sf22.fsf@kernel.org>
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Aneesh Kumar K.V wrote:
[..]
> > I think we can wait to move it to its own IOMMU operation unless/until
> > there is a need to set RUN outside of an explicit guest request, right?
> 
> Something like the below? (the diff against this series)
> 
> I have not yet integrated this into the full CCA patchset for testing,
> but I wanted to make sure we are aligned on the UAPI.
[..]
> -static bool iommufd_vdevice_tsm_req_scope_valid(u32 scope)
> +static bool iommufd_vdevice_tsm_req_arch_valid(u32 tvm_arch)
>  {
> -	if (scope > IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST)
> +	switch (tvm_arch) {
> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_CCA:
> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_SEV:
> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_TDX:

Makes sense for any command that needs tunneling. However, see below, what is
that set, and do we need a IOMMU_VDEVICE_TSM_COMMON when architecture
differentiation is not required?

> +		return true;
> +	default:
>  		return false;
> +	}
> +}
>  
> -	switch (scope) {
> -	case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
> -	case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
> -	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
> -	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
> +static bool iommufd_vdevice_tsm_req_op_valid(u32 op, u32 tvm_arch)
> +{
> +	switch (op) {
> +	case TSM_REQ_READ_OBJECT:
> +	case TSM_REQ_REGEN_OBJECT:
> +	case TSM_REQ_OBJECT_INFO:

The design goal of the netlink device-evidence interface is to be able
to respond to all shapes of requests for evidence. So netlink caches
objects that the hypercall handler can fill responses from.

It eliminates a class of commands that need tunneling.

> +	case TSM_REQ_VALIDATE_MMIO:
> +	case TSM_REQ_SET_TDI_STATE:

Are these potentially candidates for a IOMMU_VDEVICE_TSM_COMMON? The
handler knows how to do the arch-specific response from the common
iommufd result, or is there TSM-specific payload beyond @tsm_code for
these.

Make it the case that guest_req only needs non-common arch for
operations that are implementation unique, or where the response payload
exceeds what can be conveyed via @tsm_code.

>  		return true;
> +	case TSM_REQ_SEV_ENABLE_DMA:
> +	case TSM_REQ_SEV_DISABLE_DMA:
> +		return tvm_arch == IOMMU_VDEVICE_TSM_TVM_ARCH_SEV;

Right, this appears to be the only case where the command is
implementation unique. The handler can only ask iommufd to take
arch-specific action.

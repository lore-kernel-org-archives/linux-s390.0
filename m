Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD6439332;
	Wed, 29 Jul 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315952; cv=none; b=vCJ4oU1KLe3o0OzyQCcLUpEB+ny+NTTeaUxW+qizmMlc10x9+JLcfvtDO4TA/XpY7o6t/Wa73xTxYT9Q3KDqz6ZvnqOUWrsgvNC/bmYYU49kgdffVbViNq/wDROsdOEAudcSk1VGYuSElar3V6WBxN+3rm63bYd1YV1W38Q1c7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315952; c=relaxed/simple;
	bh=Ifgsh1erQBtK7EZCOyhFIlGF/sTEQ/sRw8fApy8L8b0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P02UAwKo6T3D6hcYiSWNp9gcziv3Jza98g9Pa4tjrr7LaGuOHjf2gB0aykMsk5iuaTfrw1KYEm6mGPxV0gVMd3PqA5JSrnS0Jb5LAsKpFtMEKA3m8m/J/szLmujaH4LxrTx7Q+SzKRtcLwovkOmSvX49fFjRVb8vqKfH4sEYhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIiVguq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIiVguq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B8C1F000E9;
	Wed, 29 Jul 2026 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785315950;
	bh=mdJF8EmQKgpnQ4yp7hIAeNI8pBNYHTci1rt2RdWV4Nk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FIiVguq8KuBDqtT0PXndjI3quzG7GdBQ1gIp34vD37A8jQkdWqL0UX8t4ngnnjw/Y
	 C1TGNG6KB/mLppq5/XDp/OJd0nOoba+lKfaEOW1LX+EA2h4mD1pQbF1PvCJ/Q/Eqzu
	 JYHZG1UhYCRPP+hX0i3nNC/TPyuGs3AWR/UFZrCcjQeHQFvPfssnUTotdfEDMCcf9C
	 Bque7EqPetzJBNZ/tmfvnu38rco3IaKUW/tUjUkQDC8B9Va+jAkXSWlio5jwcBDJcQ
	 032EZr/fGZqP3Ig+R6AV32MntNnjBgko8r+IdZsY00ucLhuRfLDTrWkLN6fQNm1iE3
	 VDhP3iJzHAcTA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
In-Reply-To: <ami_mpd_1pF4Tmdu@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
Date: Wed, 29 Jul 2026 14:35:36 +0530
Message-ID: <yq5a5x1ygo7z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mostafa Saleh <smostafa@google.com> writes:

> On Fri, Jul 17, 2026 at 11:34:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
>> reference and update the direct callers accordingly.
>> 
>> This is a preparatory change for a follow-up patch which updates the
>> attributes based on the selected swiotlb pool. Keeping the signature change
>> separate makes the follow-up patch easier to review.
>> 
>
> I do not understand the point of this, why would
> swiotlb_tbl_map_single() force attrs over the caller which should
> already know the context (whether DMA is shared or not) which case
> would this be useful to force from the SWIOTLB code?
>

The mapping request was for private memory, but the device could not use
it because the dma_capable() (force_dma_unencrypted() == true) check
failed. As a result, dma_direct_map_phys() allocated a swiotlb bounce
buffer, which is shared. Since the DMA now targets the shared bounce
buffer rather than the original private memory, the attributes must be
updated to reflect the new shared mapping.

dma_addr = phys_to_dma(dev, phys);
if (unlikely(!dma_capable(dev, dma_addr, size, true)))
	if (is_swiotlb_active(dev))
		return swiotlb_map(dev, phys, size, dir, attrs);


-aneesh

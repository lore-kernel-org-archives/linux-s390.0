Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3E43303C;
	Fri,  7 Aug 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103934; cv=none; b=KFELrsj0KJG6z+eurWz/RptxtX5Ciw1iYR/gpgfuZtiAoRq2xVa5G+3pOLyRnbBCyZ2aw2hSkSlF30TG/8SadM9LC7R5wf3akxwi9ZcIG7SO+dmcVFzCRE+MbSHcMJb1nMKnt9J33qoDEVJQp6SEtYgwleCHSlZiQRjTDYyrjMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103934; c=relaxed/simple;
	bh=d9eHFqF4ILa/m5FwwPTWfmm6RlAunnATLpfvh3A36LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lav8HrvAf9SZWUiHy6Ap1KUXTcpBDTMpqOItlHDfFdWPls3piZ18yIIhZZsPV+ifyRI0oSR+tGZHTAxNC5nGstCHaoAi4DG0X/giCjqm19tTeprSFOuXy1r2am7y7B3Gr8MaTHX3HyjHuK0oTvDgwigHLI8noF5RknGkFTxTxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb5CNrdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb5CNrdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F7A1F00A3A;
	Fri,  7 Aug 2026 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103918;
	bh=Xd3UFDIz5wYvevp0q0lFRxsbOOvF3TFwe4o0b4um2rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nb5CNrdE/4Z45mCov87EsHo7R+c/XppeMgdWkypZiJi0hG1F3qOgd2tMn8awJqvaS
	 lbdSFBuX+8DZW+BUgsVb72bpNXzoeTOxLUMO7EfDoa8A1uqNuAgZxEIKcOk6xWqCjz
	 inB/PGpqH/asRSsq2GTJ8yf/60nRgNhE7C1XyCY51qwFthllbwSfudh5hb9iKzACj7
	 QziTT7OLJ6iY0pmcLYRNlH75OV6VN8M2L9EGh7RPznyr9g/ejgHCUX6HO7rcff8qyK
	 jVXAQEnK36ohiepgjg3IyQBDlNwN1AqiRdGYIzb5ul1D0/BFPUE3uuAab7MCjuibx8
	 FtaKWGZWWR0DA==
Date: Fri, 7 Aug 2026 12:58:29 +0100
From: Will Deacon <will@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <anXIZSh9lq99VG9X@willie-the-truck>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807092612.2202005-1-aneesh.kumar@kernel.org>

On Fri, Aug 07, 2026 at 02:56:12PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Realm guests and protected KVM guests may require swiotlb for device DMA
> even when all system RAM is addressable by the DMA zones.
> 
> Do not reduce the SWIOTLB buffer to the kmalloc-bouncing size for these
> guests, as the reduced number of slots can be exhausted during CCA guest
> operation.
> 
> Fixes: 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/mm/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e308a7cabd12..24caaf10e755 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -339,7 +339,8 @@ void __init arch_mm_preinit(void)
>  {
>  	unsigned int flags = SWIOTLB_VERBOSE;
>  
> -	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> +	    max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {

Protected guests under pKVM rely on restricted DMA, so won't this just
waste memory for them?

Will

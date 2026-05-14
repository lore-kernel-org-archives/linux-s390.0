Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD32FE591;
	Thu, 14 May 2026 05:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734904; cv=none; b=PT/E0txWT3wCjCYPZtEZaCyQ9MD5ynX530n2wGau/yyrl9m53CvhYUqh8LJBsKxeaEE7H2Z7O9uQBuiGQqaM54ryTHsxf6RUbvuH3VqIy/mnGNRAhaERuLp9m5TGl6BMuCC8U7RYeyH+7A4FwSOKQ+R0qEu3hgLvFwf6qPb3g2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734904; c=relaxed/simple;
	bh=1MkgikfobnnlXszu7oxK5om44m9zNem1u1FAvwxDkPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sQjCgvrJ3XEsGFFDtp5atwekp11x3qkiNaFuhFLAMWITpEPmgAqbJZd2cYTCqynkF6E6LEx11Qm0GRd7/ZM6jbG8N47zy3L4txsrhmvtUXTj/nUTw6oXiq+9KD+nCQq8REbISKzcRuOwk341rzMmrR2VB7hvFuvqSBrQzQthzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/TU8m9r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/TU8m9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A5FC2BCB7;
	Thu, 14 May 2026 05:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734904;
	bh=1MkgikfobnnlXszu7oxK5om44m9zNem1u1FAvwxDkPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o/TU8m9rl7cjkl/2skOf7z8JNyS5pEEj1mPV4RtgOnPRWyJpSYblQYNiNFDTeFVk8
	 gU4giYSM4safXp6KaQXjocZhyTtJ4S0lFTopjislANRrONcrvJeo5n+BW0SlTMu/9y
	 BCHG7SXjUd4yMTWX4t8i+xiIiCrVanPCZHefstfatgj26vxkH3G8OnCJLztrLsLWdp
	 zvoCVCUtEa+qGVjmY8fB703D6M0ojTio/PP2PkUqJBAmF+sEtE+n+dNxKLidPSaEHE
	 jMfzrjVvUX0JNhAbNLWyCF4+/393zwZ2HvF1SPftZF04LcdJklp/gXVEnoRSBtSGkQ
	 NkNLmRpeIccsA==
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 02/13] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
In-Reply-To: <agSDk0QsEM0ZBCTA@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-3-aneesh.kumar@kernel.org>
 <agSDk0QsEM0ZBCTA@google.com>
Date: Thu, 14 May 2026 10:31:30 +0530
Message-ID: <yq5ajyt6a8k5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> On Tue, May 12, 2026 at 02:33:57PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
>> dma-direct allocation path and use the attribute to drive the related
>> decisions.
>>=20
>> This updates dma_direct_alloc(), dma_direct_free(), and
>> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
>>=20
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  kernel/dma/direct.c | 44 ++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 36 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index b958f150718a..0c2e1f8436ce 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -201,16 +201,31 @@ void *dma_direct_alloc(struct device *dev, size_t =
size,
>>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>  {
>>  	bool remap =3D false, set_uncached =3D false;
>> -	bool mark_mem_decrypt =3D true;
>> +	bool mark_mem_decrypt =3D false;
>>  	struct page *page;
>>  	void *ret;
>>=20=20
>> +	/*
>> +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
>> +	 * attribute. The direct allocator uses it internally after it has
>> +	 * decided that the backing pages must be shared/decrypted, so the
>> +	 * rest of the allocation path can consistently select DMA addresses,
>> +	 * choose compatible pools and restore encryption on free.
>> +	 */
>> +	if (attrs & DMA_ATTR_CC_SHARED)
>> +		return NULL;
>> +
>> +	if (force_dma_unencrypted(dev)) {
>> +		attrs |=3D DMA_ATTR_CC_SHARED;
>> +		mark_mem_decrypt =3D true;
>> +	}
>> +
>>  	size =3D PAGE_ALIGN(size);
>>  	if (attrs & DMA_ATTR_NO_WARN)
>>  		gfp |=3D __GFP_NOWARN;
>>=20=20
>> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
>> +	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) =3D=3D
>> +	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
>>  		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>>=20=20
>>  	if (!dev_is_dma_coherent(dev)) {
>> @@ -244,7 +259,7 @@ void *dma_direct_alloc(struct device *dev, size_t si=
ze,
>>  	 * Remapping or decrypting memory may block, allocate the memory from
>>  	 * the atomic pools instead if we aren't allowed block.
>>  	 */
>> -	if ((remap || force_dma_unencrypted(dev)) &&
>> +	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
>>  	    dma_direct_use_pool(dev, gfp))
>>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>>=20=20
>> @@ -318,11 +333,20 @@ void *dma_direct_alloc(struct device *dev, size_t =
size,
>>  void dma_direct_free(struct device *dev, size_t size,
>>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>>  {
>> -	bool mark_mem_encrypted =3D true;
>> +	bool mark_mem_encrypted =3D false;
>>  	unsigned int page_order =3D get_order(size);
>>=20=20
>> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
>> +	/*
>> +	 * if the device had requested for an unencrypted buffer,
>> +	 * convert it to encrypted on free
>> +	 */
>> +	if (force_dma_unencrypted(dev)) {
>> +		attrs |=3D DMA_ATTR_CC_SHARED;
>> +		mark_mem_encrypted =3D true;
>> +	}
>> +
>> +	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) =3D=3D
>> +	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
>>  		/* cpu_addr is a struct page cookie, not a kernel address */
>>  		dma_free_contiguous(dev, cpu_addr, size);
>>  		return;
>> @@ -365,10 +389,14 @@ void dma_direct_free(struct device *dev, size_t si=
ze,
>>  struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>>  		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>>  {
>> +	unsigned long attrs =3D 0;
>>  	struct page *page;
>>  	void *ret;
>>=20=20
>> -	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>> +	if (force_dma_unencrypted(dev))
>> +		attrs |=3D DMA_ATTR_CC_SHARED;
>> +
>> +	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>
> What about dma_direct_free_pages()? Nothing inside uses attrs, but
> that=E2=80=99s quite similar to dma_direct_alloc_pages()
>
> Also, at this point, shouldn=E2=80=99t this patch also remove
> force_dma_unencrypted() calls from dma_set_decrypted() and
> dma_set_encrypted()?
>

The final change have=20

void dma_direct_free_pages(struct device *dev, size_t size,
...
{
	/*
	 * if the device had requested for an unencrypted buffer,
	 * convert it to encrypted on free
	 */
	bool mark_mem_encrypted =3D  force_dma_unencrypted(dev);

That got added by "dma-direct: select DMA address encoding from DMA_ATTR_CC=
_SHARED "

I'll move that hunk into this patch. The overall goal is=20

dma_direct_alloc(.. attrs)
{

	if (force_dma_unencrypted(dev))
		attrs |=3D DMA_ATTR_CC_SHARED;
}

dma_direct_free(.. attrs)
{
	if (force_dma_unencrypted(dev)) {
		attrs |=3D DMA_ATTR_CC_SHARED;
		mark_mem_encrypted =3D true;
	}

	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
		mark_mem_encrypted =3D false;

}

dma_direct_alloc_pages()
{
	if (force_dma_unencrypted(dev))
		attrs |=3D DMA_ATTR_CC_SHARED;

}

dma_direct_free_pages()
{
	bool mark_mem_encrypted =3D  force_dma_unencrypted(dev);

	if (swiotlb_find_pool(dev, page_to_phys(page)))
		mark_mem_encrypted =3D false;

}

-aneesh

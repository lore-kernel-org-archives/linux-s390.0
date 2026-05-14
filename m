Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0AD224FA;
	Thu, 14 May 2026 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738122; cv=none; b=WerAcLed00eG2T1BHbPZq0SCP8JiEnEw/WC0Wo1thR1Or30LrNxDQIkGj61wqxiwYLjcdl1rl5veB1y01hIrbbXQz0DGR/ihhGtu9rLP1klVS/px+ABlSBPltJo/lm9px4iPbZQf9Sy9X/BdJ7RjWpk9RBlHCkk6HyNG9zUTKKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738122; c=relaxed/simple;
	bh=tAsj5bKRflS4qmDBR3+7R/dpv/9jhbBCyle1aPZlCQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EE5vWzpRiB/obYSPVl8JhiMFkmFLTUb5uyEpBCJEnzQ10LkQzq+YP+9hANb7jouBQiLNMD9wtCyD5gaGJvTII7AiD44Tm9gOWqFSpQF+ELy4ATLz7chkSNkGa6p/nvnwhSgJz50+Srs4bXwU4F0ok8iOdQwvrcA7i4SuECUgvY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4+2goqA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4+2goqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73008C2BCC6;
	Thu, 14 May 2026 05:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778738122;
	bh=tAsj5bKRflS4qmDBR3+7R/dpv/9jhbBCyle1aPZlCQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X4+2goqArmbM9JX0bhb/Fk6gpvCP4/B8PWXzJEJiNW8seAZCeddIhEHkct+egLIlX
	 iy0cxFQOVoFxDb6vX4L1hMe9bp8rztbDSbTjYbQEQSUlY3B/NuDtXgJwLrxUvnggh9
	 bujWbkRBLOLmLL0qX28pQF+NZ4rXGs+cdODH+S1ILocnr1avoTD8ARuodbwvN4IFvl
	 TuBou/EzHKmxACceHY4rDTnXR1R2ryOut2C/M9F5t7JWHfWsK+cIE9pvbybb3tVGln
	 z88ip41kP8qnpbBLePyhQsnZP1+M2wsNcYd6EP12l8o2sdLqL62WuozpL3TaWoAEOf
	 F3cjj+p7pB83A==
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <agSKQrSIhizCXKwx@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
Date: Thu, 14 May 2026 11:24:42 +0530
Message-ID: <yq5ah5oaa63h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> On Tue, May 12, 2026 at 02:33:59PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> Teach swiotlb to distinguish between encrypted and decrypted bounce
>> buffer pools, and make allocation and mapping paths select a pool whose
>> state matches the requested DMA attributes.
>>=20
>> Add a decrypted flag to io_tlb_mem, initialize it for the default and
>> restricted pools, and propagate DMA_ATTR_CC_SHARED into swiotlb pool
>> allocation. Reject swiotlb alloc/map requests when the selected pool does
>> not match the required encrypted/decrypted state.
>>=20
>> Also return DMA addresses with the matching phys_to_dma_{encrypted,
>> unencrypted} helper so the DMA address encoding stays consistent with the
>> chosen pool.
>>=20
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  include/linux/dma-direct.h |  10 ++++
>>  include/linux/swiotlb.h    |   8 ++-
>>  kernel/dma/direct.c        |  14 +++--
>>  kernel/dma/swiotlb.c       | 108 +++++++++++++++++++++++++++----------
>>  4 files changed, 107 insertions(+), 33 deletions(-)
>>=20
>> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>> index c249912456f9..94fad4e7c11e 100644
>> --- a/include/linux/dma-direct.h
>> +++ b/include/linux/dma-direct.h
>> @@ -77,6 +77,10 @@ static inline dma_addr_t dma_range_map_max(const stru=
ct bus_dma_region *map)
>>  #ifndef phys_to_dma_unencrypted
>>  #define phys_to_dma_unencrypted		phys_to_dma
>>  #endif
>> +
>> +#ifndef phys_to_dma_encrypted
>> +#define phys_to_dma_encrypted		phys_to_dma
>> +#endif
>>  #else
>>  static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t =
paddr)
>>  {
>> @@ -90,6 +94,12 @@ static inline dma_addr_t phys_to_dma_unencrypted(stru=
ct device *dev,
>>  {
>>  	return dma_addr_unencrypted(__phys_to_dma(dev, paddr));
>>  }
>> +
>> +static inline dma_addr_t phys_to_dma_encrypted(struct device *dev,
>> +		phys_addr_t paddr)
>> +{
>> +	return dma_addr_encrypted(__phys_to_dma(dev, paddr));
>> +}
>>  /*
>>   * If memory encryption is supported, phys_to_dma will set the memory e=
ncryption
>>   * bit in the DMA address, and dma_to_phys will clear it.
>> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
>> index 3dae0f592063..b3fa3c6e0169 100644
>> --- a/include/linux/swiotlb.h
>> +++ b/include/linux/swiotlb.h
>> @@ -81,6 +81,7 @@ struct io_tlb_pool {
>>  	struct list_head node;
>>  	struct rcu_head rcu;
>>  	bool transient;
>> +	bool unencrypted;
>>  #endif
>>  };
>>=20=20
>> @@ -111,6 +112,7 @@ struct io_tlb_mem {
>>  	struct dentry *debugfs;
>>  	bool force_bounce;
>>  	bool for_alloc;
>> +	bool unencrypted;
>>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>>  	bool can_grow;
>>  	u64 phys_limit;
>> @@ -282,7 +284,8 @@ static inline void swiotlb_sync_single_for_cpu(struc=
t device *dev,
>>  extern void swiotlb_print_info(void);
>>=20=20
>>  #ifdef CONFIG_DMA_RESTRICTED_POOL
>> -struct page *swiotlb_alloc(struct device *dev, size_t size);
>> +struct page *swiotlb_alloc(struct device *dev, size_t size,
>> +		unsigned long attrs);
>>  bool swiotlb_free(struct device *dev, struct page *page, size_t size);
>>=20=20
>>  static inline bool is_swiotlb_for_alloc(struct device *dev)
>> @@ -290,7 +293,8 @@ static inline bool is_swiotlb_for_alloc(struct devic=
e *dev)
>>  	return dev->dma_io_tlb_mem->for_alloc;
>>  }
>>  #else
>> -static inline struct page *swiotlb_alloc(struct device *dev, size_t siz=
e)
>> +static inline struct page *swiotlb_alloc(struct device *dev, size_t siz=
e,
>> +		unsigned long attrs)
>>  {
>>  	return NULL;
>>  }
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index dc2907439b3d..97ae4fa10521 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -104,9 +104,10 @@ static void __dma_direct_free_pages(struct device *=
dev, struct page *page,
>>  	dma_free_contiguous(dev, page, size);
>>  }
>>=20=20
>> -static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t=
 size)
>> +static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t=
 size,
>> +		unsigned long attrs)
>>  {
>> -	struct page *page =3D swiotlb_alloc(dev, size);
>> +	struct page *page =3D swiotlb_alloc(dev, size, attrs);
>>=20=20
>>  	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>>  		swiotlb_free(dev, page, size);
>> @@ -266,8 +267,12 @@ void *dma_direct_alloc(struct device *dev, size_t s=
ize,
>>  						  gfp, attrs);
>>=20=20
>>  	if (is_swiotlb_for_alloc(dev)) {
>> -		page =3D dma_direct_alloc_swiotlb(dev, size);
>> +		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>>  		if (page) {
>> +			/*
>> +			 * swiotlb allocations comes from pool already marked
>> +			 * decrypted
>> +			 */
>>  			mark_mem_decrypt =3D false;
>>  			goto setup_page;
>>  		}
>> @@ -374,6 +379,7 @@ void dma_direct_free(struct device *dev, size_t size,
>>  		return;
>>=20=20
>>  	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
>> +		/* Swiotlb doesn't need a page attribute update on free */
>>  		mark_mem_encrypted =3D false;
>>=20=20
>>  	if (is_vmalloc_addr(cpu_addr)) {
>> @@ -403,7 +409,7 @@ struct page *dma_direct_alloc_pages(struct device *d=
ev, size_t size,
>>  						  gfp, attrs);
>>=20=20
>>  	if (is_swiotlb_for_alloc(dev)) {
>> -		page =3D dma_direct_alloc_swiotlb(dev, size);
>> +		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>>  		if (!page)
>>  			return NULL;
>>=20=20
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index ab4eccbaa076..065663be282c 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -259,10 +259,21 @@ void __init swiotlb_update_mem_attributes(void)
>>  	struct io_tlb_pool *mem =3D &io_tlb_default_mem.defpool;
>>  	unsigned long bytes;
>>=20=20
>> +	/*
>> +	 * if platform support memory encryption, swiotlb buffers are
>> +	 * decrypted by default.
>> +	 */
>> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> +		io_tlb_default_mem.unencrypted =3D true;
>> +	else
>> +		io_tlb_default_mem.unencrypted =3D false;
>> +
>>  	if (!mem->nslabs || mem->late_alloc)
>>  		return;
>>  	bytes =3D PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
>> -	set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
>> +
>> +	if (io_tlb_default_mem.unencrypted)
>> +		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
>>  }
>>=20=20
>>  static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr=
_t start,
>> @@ -505,8 +516,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>>  	if (!mem->slots)
>>  		goto error_slots;
>>=20=20
>> -	set_memory_decrypted((unsigned long)vstart,
>> -			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
>> +	if (io_tlb_default_mem.unencrypted)
>> +		set_memory_decrypted((unsigned long)vstart,
>> +				     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
>> +
>>  	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
>>  				 nareas);
>>  	add_mem_pool(&io_tlb_default_mem, mem);
>> @@ -539,7 +552,9 @@ void __init swiotlb_exit(void)
>>  	tbl_size =3D PAGE_ALIGN(mem->end - mem->start);
>>  	slots_size =3D PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs)=
);
>>=20=20
>> -	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
>> +	if (io_tlb_default_mem.unencrypted)
>> +		set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
>> +
>>  	if (mem->late_alloc) {
>>  		area_order =3D get_order(array_size(sizeof(*mem->areas),
>>  			mem->nareas));
>> @@ -563,6 +578,7 @@ void __init swiotlb_exit(void)
>>   * @gfp:	GFP flags for the allocation.
>>   * @bytes:	Size of the buffer.
>>   * @phys_limit:	Maximum allowed physical address of the buffer.
>> + * @unencrypted: true to allocate unencrypted memory, false for encrypt=
ed memory
>>   *
>>   * Allocate pages from the buddy allocator. If successful, make the all=
ocated
>>   * pages decrypted that they can be used for DMA.
>> @@ -570,7 +586,8 @@ void __init swiotlb_exit(void)
>>   * Return: Decrypted pages, %NULL on allocation failure, or ERR_PTR(-EA=
GAIN)
>>   * if the allocated physical address was above @phys_limit.
>>   */
>> -static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_l=
imit)
>> +static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes,
>> +		u64 phys_limit, bool unencrypted)
>>  {
>>  	unsigned int order =3D get_order(bytes);
>>  	struct page *page;
>> @@ -588,13 +605,13 @@ static struct page *alloc_dma_pages(gfp_t gfp, siz=
e_t bytes, u64 phys_limit)
>>  	}
>>=20=20
>>  	vaddr =3D phys_to_virt(paddr);
>> -	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
>> +	if (unencrypted && set_memory_decrypted((unsigned long)vaddr, PFN_UP(b=
ytes)))
>>  		goto error;
>>  	return page;
>>=20=20
>>  error:
>>  	/* Intentional leak if pages cannot be encrypted again. */
>> -	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
>> +	if (unencrypted && !set_memory_encrypted((unsigned long)vaddr, PFN_UP(=
bytes)))
>>  		__free_pages(page, order);
>>  	return NULL;
>>  }
>> @@ -604,30 +621,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, siz=
e_t bytes, u64 phys_limit)
>>   * @dev:	Device for which a memory pool is allocated.
>>   * @bytes:	Size of the buffer.
>>   * @phys_limit:	Maximum allowed physical address of the buffer.
>> + * @attrs:	DMA attributes for the allocation.
>>   * @gfp:	GFP flags for the allocation.
>>   *
>>   * Return: Allocated pages, or %NULL on allocation failure.
>>   */
>>  static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>> -		u64 phys_limit, gfp_t gfp)
>> +		u64 phys_limit, unsigned long attrs, gfp_t gfp)
>>  {
>>  	struct page *page;
>> -	unsigned long attrs =3D 0;
>>=20=20
>>  	/*
>>  	 * Allocate from the atomic pools if memory is encrypted and
>>  	 * the allocation is atomic, because decrypting may block.
>>  	 */
>> -	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)=
) {
>> +	if (!gfpflags_allow_blocking(gfp) && (attrs & DMA_ATTR_CC_SHARED)) {
>>  		void *vaddr;
>>=20=20
>>  		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>>  			return NULL;
>>=20=20
>> -		/* swiotlb considered decrypted by default */
>> -		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> -			attrs =3D DMA_ATTR_CC_SHARED;
>> -
>>  		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
>>  					   attrs, dma_coherent_ok);
>>  	}
>> @@ -638,7 +651,8 @@ static struct page *swiotlb_alloc_tlb(struct device =
*dev, size_t bytes,
>>  	else if (phys_limit <=3D DMA_BIT_MASK(32))
>>  		gfp |=3D __GFP_DMA32;
>>=20=20
>> -	while (IS_ERR(page =3D alloc_dma_pages(gfp, bytes, phys_limit))) {
>> +	while (IS_ERR(page =3D alloc_dma_pages(gfp, bytes, phys_limit,
>> +					     !!(attrs & DMA_ATTR_CC_SHARED)))) {
>>  		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
>>  		    phys_limit < DMA_BIT_MASK(64) &&
>>  		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
>> @@ -657,15 +671,18 @@ static struct page *swiotlb_alloc_tlb(struct devic=
e *dev, size_t bytes,
>>   * swiotlb_free_tlb() - free a dynamically allocated IO TLB buffer
>>   * @vaddr:	Virtual address of the buffer.
>>   * @bytes:	Size of the buffer.
>> + * @unencrypted: true if @vaddr was allocated decrypted and must be
>> + *	re-encrypted before being freed
>>   */
>> -static void swiotlb_free_tlb(void *vaddr, size_t bytes)
>> +static void swiotlb_free_tlb(void *vaddr, size_t bytes, bool unencrypte=
d)
>>  {
>>  	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>>  	    dma_free_from_pool(NULL, vaddr, bytes))
>>  		return;
>>=20=20
>>  	/* Intentional leak if pages cannot be encrypted again. */
>> -	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
>> +	if (!unencrypted ||
>> +	    !set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
>>  		__free_pages(virt_to_page(vaddr), get_order(bytes));
>>  }
>>=20=20
>> @@ -676,6 +693,7 @@ static void swiotlb_free_tlb(void *vaddr, size_t byt=
es)
>>   * @nslabs:	Desired (maximum) number of slabs.
>>   * @nareas:	Number of areas.
>>   * @phys_limit:	Maximum DMA buffer physical address.
>> + * @attrs:	DMA attributes for the allocation.
>>   * @gfp:	GFP flags for the allocations.
>>   *
>>   * Allocate and initialize a new IO TLB memory pool. The actual number =
of
>> @@ -686,7 +704,8 @@ static void swiotlb_free_tlb(void *vaddr, size_t byt=
es)
>>   */
>>  static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>>  		unsigned long minslabs, unsigned long nslabs,
>> -		unsigned int nareas, u64 phys_limit, gfp_t gfp)
>> +		unsigned int nareas, u64 phys_limit, unsigned long attrs,
>> +		gfp_t gfp)
>>  {
>>  	struct io_tlb_pool *pool;
>>  	unsigned int slot_order;
>> @@ -704,9 +723,10 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struc=
t device *dev,
>>  	if (!pool)
>>  		goto error;
>>  	pool->areas =3D (void *)pool + sizeof(*pool);
>> +	pool->unencrypted =3D !!(attrs & DMA_ATTR_CC_SHARED);
>>=20=20
>>  	tlb_size =3D nslabs << IO_TLB_SHIFT;
>> -	while (!(tlb =3D swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp))) {
>> +	while (!(tlb =3D swiotlb_alloc_tlb(dev, tlb_size, phys_limit, attrs, g=
fp))) {
>>  		if (nslabs <=3D minslabs)
>>  			goto error_tlb;
>>  		nslabs =3D ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
>> @@ -724,7 +744,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct=
 device *dev,
>>  	return pool;
>>=20=20
>>  error_slots:
>> -	swiotlb_free_tlb(page_address(tlb), tlb_size);
>> +	swiotlb_free_tlb(page_address(tlb), tlb_size,
>> +			 !!(attrs & DMA_ATTR_CC_SHARED));
>>  error_tlb:
>>  	kfree(pool);
>>  error:
>> @@ -742,7 +763,9 @@ static void swiotlb_dyn_alloc(struct work_struct *wo=
rk)
>>  	struct io_tlb_pool *pool;
>>=20=20
>>  	pool =3D swiotlb_alloc_pool(NULL, IO_TLB_MIN_SLABS, default_nslabs,
>> -				  default_nareas, mem->phys_limit, GFP_KERNEL);
>> +				  default_nareas, mem->phys_limit,
>> +				  mem->unencrypted ? DMA_ATTR_CC_SHARED : 0,
>> +				  GFP_KERNEL);
>>  	if (!pool) {
>>  		pr_warn_ratelimited("Failed to allocate new pool");
>>  		return;
>> @@ -762,7 +785,7 @@ static void swiotlb_dyn_free(struct rcu_head *rcu)
>>  	size_t tlb_size =3D pool->end - pool->start;
>>=20=20
>>  	free_pages((unsigned long)pool->slots, get_order(slots_size));
>> -	swiotlb_free_tlb(pool->vaddr, tlb_size);
>> +	swiotlb_free_tlb(pool->vaddr, tlb_size, pool->unencrypted);
>>  	kfree(pool);
>>  }
>>=20=20
>> @@ -1232,6 +1255,7 @@ static int swiotlb_find_slots(struct device *dev, =
phys_addr_t orig_addr,
>>  	nslabs =3D nr_slots(alloc_size);
>>  	phys_limit =3D min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
>>  	pool =3D swiotlb_alloc_pool(dev, nslabs, nslabs, 1, phys_limit,
>> +				  mem->unencrypted ? DMA_ATTR_CC_SHARED : 0,
>>  				  GFP_NOWAIT);
>>  	if (!pool)
>>  		return -1;
>> @@ -1394,6 +1418,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>>  		enum dma_data_direction dir, unsigned long attrs)
>>  {
>>  	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
>> +	bool require_decrypted =3D false;
>>  	unsigned int offset;
>>  	struct io_tlb_pool *pool;
>>  	unsigned int i;
>> @@ -1411,6 +1436,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
*dev, phys_addr_t orig_addr,
>>  	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>>  		pr_warn_once("Memory encryption is active and system is using DMA bou=
nce buffers\n");
>>=20=20
>> +	/*
>> +	 * if we are trying to swiotlb map a decrypted paddr or the paddr is e=
ncrypted
>> +	 * but the device is forcing decryption, use decrypted io_tlb_mem
>> +	 */
>> +	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
>> +		require_decrypted =3D true;
>> +
>> +	if (require_decrypted !=3D mem->unencrypted)
>> +		return (phys_addr_t)DMA_MAPPING_ERROR;
>> +
>>  	/*
>>  	 * The default swiotlb memory pool is allocated with PAGE_SIZE
>>  	 * alignment. If a mapping is requested with larger alignment,
>> @@ -1608,8 +1643,14 @@ dma_addr_t swiotlb_map(struct device *dev, phys_a=
ddr_t paddr, size_t size,
>>  	if (swiotlb_addr =3D=3D (phys_addr_t)DMA_MAPPING_ERROR)
>>  		return DMA_MAPPING_ERROR;
>>=20=20
>> -	/* Ensure that the address returned is DMA'ble */
>> -	dma_addr =3D phys_to_dma_unencrypted(dev, swiotlb_addr);
>> +	/*
>> +	 * Use the allocated io_tlb_mem encryption type to determine dma addr.
>> +	 */
>> +	if (dev->dma_io_tlb_mem->unencrypted)
>> +		dma_addr =3D phys_to_dma_unencrypted(dev, swiotlb_addr);
>> +	else
>> +		dma_addr =3D phys_to_dma_encrypted(dev, swiotlb_addr);
>> +
>>  	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
>>  		__swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
>>  			attrs | DMA_ATTR_SKIP_CPU_SYNC,
>> @@ -1773,7 +1814,8 @@ static inline void swiotlb_create_debugfs_files(st=
ruct io_tlb_mem *mem,
>>=20=20
>>  #ifdef CONFIG_DMA_RESTRICTED_POOL
>>=20=20
>> -struct page *swiotlb_alloc(struct device *dev, size_t size)
>> +struct page *swiotlb_alloc(struct device *dev, size_t size,
>> +		unsigned long attrs)
>>  {
>>  	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
>>  	struct io_tlb_pool *pool;
>> @@ -1784,6 +1826,9 @@ struct page *swiotlb_alloc(struct device *dev, siz=
e_t size)
>>  	if (!mem)
>>  		return NULL;
>>=20=20
>> +	if (mem->unencrypted !=3D !!(attrs & DMA_ATTR_CC_SHARED))
>> +		return NULL;
>> +
>>  	align =3D (1 << (get_order(size) + PAGE_SHIFT)) - 1;
>>  	index =3D swiotlb_find_slots(dev, 0, size, align, &pool);
>>  	if (index =3D=3D -1)
>> @@ -1853,9 +1898,18 @@ static int rmem_swiotlb_device_init(struct reserv=
ed_mem *rmem,
>>  			kfree(mem);
>>  			return -ENOMEM;
>>  		}
>> +		/*
>> +		 * if platform supports memory encryption,
>> +		 * restricted mem pool is decrypted by default
>> +		 */
>> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
>> +			mem->unencrypted =3D true;
>> +			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>> +					     rmem->size >> PAGE_SHIFT);
>> +		} else {
>> +			mem->unencrypted =3D false;
>> +		}
>
> This breaks pKVM as it doesn=E2=80=99t set CC_ATTR_MEM_ENCRYPT, so all vi=
rtio
> traffic now fails.
>
> Also, by design, some drivers are clueless about bouncing, so
> I believe that the pool should have a way to control it=E2=80=99s property
> (encrypted or decrypted) and that takes priority over whatever
> attributes comes from allocation.
> And that brings us to the same point whether it=E2=80=99s better to return
> the memory along with it=E2=80=99s state or we pass the requested state.
> I think for other cases it=E2=80=99s fine for the device/DMA-API to dicta=
te
> the attrs, but not in restricted-dma case, the firmware just knows better.
>

Is it that the pKVM guest kernel does not have awareness of
encrypted/decrypted DMA allocations? Instead, the firmware attaches
hypervisor-shared pages to the device via restricted-dma-pool? The
kernel then has swiotlb->for_alloc =3D true, and hence all DMA allocations
go through the restricted-dma-pool?

Given that pKVM supports pkvm_set_memory_encrypted() and
pkvm_set_memory_decrypted(), can we consider adding CC_ATTR_MEM_ENCRYPT
support to pKVM? It would also be good to investigate whether we can set
force_dma_unencrypted(dev) to true where needed.

I agree that this patch, as it stands, can break pKVM because we are now
missing the set_memory_decrypted() call required for pKVM to work.

We now mark the swiotlb io_tlb_mem as unencrypted/encrypted in the guest
using struct io_tlb_mem->unencrypted. I am not clear what we can use for
pKVM to conditionalize this so that it works for both protected and
unprotected guests.

-aneesh


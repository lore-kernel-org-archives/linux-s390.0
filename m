Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BF743934B;
	Wed,  8 Jul 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523361; cv=none; b=Eiouid1tt6TWROnPHUlatGtDBHar/3zQYkJ+XBiHcC25xOCNImYMXtfHVa/Gnk8uKPya8ycJMnBlEL0hptXWckilOlXcap2ZndFNZ0PET8alsdEE0XFCJoFHfiIl718sfixRwfWqw/Tr7a7oOPAc2zsjfJq2O94C/qUKCd5pLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523361; c=relaxed/simple;
	bh=ovVa70K1EOneiBZ7lC3AoXEGPRmjzupYItZ1gg3SCQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oxnElqcEbDD2Mm8pxWJDZ9JQWKliouBR+BEb4TKqPnxIjyalJLjdcz39VOW4WTKTgqRXs98qXEGOYuTJWh5HVmuba5uhK/WtXEuWMCIEZoRXHWG/PYB4sB3JgpgxQBeMGch4Ntm+fWyqvDU3mxszF+k2elSgZGjyaV9t38g6i4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duiLudFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duiLudFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6EC1F00A3A;
	Wed,  8 Jul 2026 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783523359;
	bh=wn/P+Gm3OCkFQ+7GJs+RVSAKPOX9EEcvT9NnSy5NxSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=duiLudFVLeL3G/NPJkeMVZRUX3Un092z5jKJpfKTnO8neikVecyIet9W5yX1f7N3L
	 N30FCWXE636kQaVba6y875r6A92xlvt3rFwIioTlhAYvRe//MWhTEzSiWTKpdxQ7bC
	 p/6uB0lHuurI0YmHmTW9nKtWq4Pnk27mmoNKyo9MzwT0aGoo8BAtA2bTEhKgFguV7X
	 lWPpbo+vSx6VDUn1AsA4EK4/LYf18sUEPE3QNQW2ooxE57bXLbK2gox2Yp0MHsw7/q
	 lDehH0I1is4t3Gv2zNLePQLDLL3AqGZGDsvcvoyulnB4Kz8qjcUvusH1pBWfs5ull2
	 0KQ5oOZsnESkg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
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
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
In-Reply-To: <ak42F240d-53QeFN@arm.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
Date: Wed, 08 Jul 2026 20:39:04 +0530
Message-ID: <yq5ase5th627.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Wed, Jul 01, 2026 at 11:19:20AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 97987f850a33..acf67c7064db 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -338,10 +338,8 @@ void __init arch_mm_preinit(void)
>>  	unsigned int flags = SWIOTLB_VERBOSE;
>>  	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>>  
>> -	if (is_realm_world()) {
>> +	if (is_realm_world())
>>  		swiotlb = true;
>> -		flags |= SWIOTLB_FORCE;
>> -	}
>
> For this part:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
>> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>> index e05dc7649366..f3fc28f352ba 100644
>> --- a/kernel/dma/direct.h
>> +++ b/kernel/dma/direct.h
>> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>>  {
>>  	dma_addr_t dma_addr;
>>  
>> +	/*
>> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
>> +	 * as shared by default.
>> +	 */
>> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
>> +		attrs |= DMA_ATTR_CC_SHARED;
>> +
>>  	if (is_swiotlb_force_bounce(dev)) {
>> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
>> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>> -				return DMA_MAPPING_ERROR;
>> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>> +			return DMA_MAPPING_ERROR;
>>  
>> -			return swiotlb_map(dev, phys, size, dir, attrs);
>> -		}
>> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
>> -		return DMA_MAPPING_ERROR;
>> +		return swiotlb_map(dev, phys, size, dir, attrs);
>>  	}
>>  
>> -	if (attrs & DMA_ATTR_MMIO) {
>> -		dma_addr = phys;
>> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>> -			goto err_overflow;
>> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
>> +	if (attrs & DMA_ATTR_CC_SHARED)
>>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
>> +	else
>> +		dma_addr = phys_to_dma_encrypted(dev, phys);
>
> For AMD/SME, on host with memory encryption we now end up setting the C
> bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
> some other MMIO bus understands this attribute. Maybe we should stick to
> something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
> since this is not universally defined, just use the old dma_addr = phys
> if MMIO and ignore any unlikely DMA offsets.
>
> In the other case, for an arm CCA guest, if the MMIO is shared we end up
> setting the shared attribute but that's fine, it's only an IPA address.
>

P2PDMA with CoCo is currently not supported, as discussed here:

https://lore.kernel.org/all/20260521175420.GA7702@ziepe.ca
https://lore.kernel.org/all/20260522132240.GD7702@ziepe.ca

Since I do not have much experience with P2PDMA, I have prepared a patch
that Leon Romanovsky <leonro@nvidia.com> has kindly agreed to review to
ensure it is correct. I have attached it below.

The conclusion is that P2P is not currently supported, so we get this
series merged first and handle P2PDMA support as a follow-up outside
this series.

commit f39bcb603c5cc4cfa738597715828ac45f01f142
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Date:   Fri May 22 10:10:35 2026 +0530

    PCI/P2PDMA: Carry host bridge DMA attrs through map and unmap
    
    P2PDMA host bridge mappings currently pass DMA_ATTR_MMIO and rely on
    dma-direct to add DMA_ATTR_CC_SHARED for devices that require unencrypted
    DMA. That puts P2PDMA-specific confidential-computing policy in the generic
    dma-direct MMIO mapping path and does not preserve the selected attributes
    through all unmap paths.
    
    Add DMA mapping flags to struct p2pdma_provider for host bridge mappings
    and use those flags in the block, dma-buf and HMM mapping paths. Store the
    attributes selected at map time where the unmap side no longer has provider
    context, so that the unmap path uses the same attributes that were used for
    mapping.

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index bfdb9ed70741..fafc6d6b8522 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -87,10 +87,11 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
-	unsigned int attrs = 0;
+	unsigned long attrs = 0;
 
 	if (iter->p2pdma.map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
-		attrs |= DMA_ATTR_MMIO;
+		attrs |= iter->p2pdma.mem->dma_mapping_flags;
+	iter->attrs = attrs;
 
 	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
 			rq_dma_dir(req), attrs);
@@ -107,7 +108,7 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 		struct phys_vec *vec)
 {
 	enum dma_data_direction dir = rq_dma_dir(req);
-	unsigned int attrs = 0;
+	unsigned long attrs = 0;
 	size_t mapped = 0;
 	int error;
 
@@ -115,7 +116,8 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 	iter->len = dma_iova_size(state);
 
 	if (iter->p2pdma.map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
-		attrs |= DMA_ATTR_MMIO;
+		attrs |= iter->p2pdma.mem->dma_mapping_flags;
+	iter->attrs = attrs;
 
 	do {
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
@@ -168,6 +170,7 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 	struct phys_vec vec;
 
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
+	iter->attrs = 0;
 	iter->status = BLK_STS_OK;
 	iter->p2pdma.map = PCI_P2PDMA_MAP_NONE;
 
diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..e6d4ee8acd19 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -59,11 +59,13 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
  * @sgt:    Scatter-gather table
  * @state:  DMA IOVA state relevant in IOMMU-based DMA
  * @size:   Total size of DMA transfer
+ * @attrs:  DMA attributes used for host bridge mappings
  */
 struct dma_buf_dma {
 	struct sg_table sgt;
 	struct dma_iova_state *state;
 	size_t size;
+	unsigned long attrs;
 };
 
 /**
@@ -119,6 +121,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 		 */
 		break;
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		dma->attrs = provider->dma_mapping_flags;
 		dma->state = kzalloc_obj(*dma->state);
 		if (!dma->state) {
 			ret = -ENOMEM;
@@ -147,7 +150,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 			ret = dma_iova_link(attach->dev, dma->state,
 					    phys_vec[i].paddr, 0,
 					    phys_vec[i].len, dir,
-					    DMA_ATTR_MMIO);
+					    dma->attrs);
 			if (ret)
 				goto err_unmap_dma;
 
@@ -155,7 +158,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 		} else {
 			addr = dma_map_phys(attach->dev, phys_vec[i].paddr,
 					    phys_vec[i].len, dir,
-					    DMA_ATTR_MMIO);
+					    dma->attrs);
 			ret = dma_mapping_error(attach->dev, addr);
 			if (ret)
 				goto err_unmap_dma;
@@ -195,11 +198,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 		; /* Do nothing */
 	} else if (dma_use_iova(dma->state)) {
 		dma_iova_destroy(attach->dev, dma->state, mapped_len, dir,
-				 DMA_ATTR_MMIO);
+				 dma->attrs);
 	} else {
 		for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
 			dma_unmap_phys(attach->dev, sg_dma_address(sgl),
-				       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);
+				       sg_dma_len(sgl), dir, dma->attrs);
 	}
 	sg_free_table(&dma->sgt);
 err_free_state:
@@ -231,13 +234,13 @@ void dma_buf_free_sgt(struct dma_buf_attachment *attach, struct sg_table *sgt,
 		; /* Do nothing */
 	} else if (dma_use_iova(dma->state)) {
 		dma_iova_destroy(attach->dev, dma->state, dma->size, dir,
-				 DMA_ATTR_MMIO);
+				 dma->attrs);
 	} else {
 		struct scatterlist *sgl;
 
 		for_each_sgtable_dma_sg(sgt, sgl, i)
 			dma_unmap_phys(attach->dev, sg_dma_address(sgl),
-				       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);
+				       sg_dma_len(sgl), dir, dma->attrs);
 	}
 
 	sg_free_table(sgt);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b53..8f05f53b78fd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -436,6 +436,7 @@ struct nvme_iod {
 
 	size_t total_len;
 	struct dma_iova_state dma_state;
+	unsigned long dma_attrs;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
 	struct nvme_dma_vec *dma_vecs;
 	unsigned int nr_dma_vecs;
@@ -443,6 +444,7 @@ struct nvme_iod {
 	dma_addr_t meta_dma;
 	size_t meta_total_len;
 	struct dma_iova_state meta_dma_state;
+	unsigned long meta_dma_attrs;
 	struct nvme_sgl_desc *meta_descriptor;
 };
 
@@ -859,7 +861,7 @@ static void nvme_free_descriptors(struct request *req)
 	}
 }
 
-static void nvme_free_prps(struct request *req, unsigned int attrs)
+static void nvme_free_prps(struct request *req, unsigned long attrs)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
@@ -872,7 +874,7 @@ static void nvme_free_prps(struct request *req, unsigned int attrs)
 }
 
 static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
-		struct nvme_sgl_desc *sg_list, unsigned int attrs)
+		struct nvme_sgl_desc *sg_list, unsigned long attrs)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	enum dma_data_direction dir = rq_dma_dir(req);
@@ -899,7 +901,7 @@ static void nvme_unmap_metadata(struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct device *dma_dev = nvmeq->dev->dev;
 	struct nvme_sgl_desc *sge = iod->meta_descriptor;
-	unsigned int attrs = 0;
+	unsigned long attrs = 0;
 
 	if (iod->flags & IOD_SINGLE_META_SEGMENT) {
 		dma_unmap_page(dma_dev, iod->meta_dma,
@@ -912,11 +914,11 @@ static void nvme_unmap_metadata(struct request *req)
 		map = PCI_P2PDMA_MAP_BUS_ADDR;
 	else if (iod->flags & IOD_META_MMIO) {
 		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
-		attrs |= DMA_ATTR_MMIO;
+		attrs = iod->meta_dma_attrs;
 	}
 
 	if (!blk_rq_dma_unmap(req, dma_dev, &iod->meta_dma_state,
-			      iod->meta_total_len, map)) {
+			      iod->meta_total_len, map, attrs)) {
 		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
 			nvme_free_sgls(req, sge, &sge[1], attrs);
 		else
@@ -935,7 +937,7 @@ static void nvme_unmap_data(struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct device *dma_dev = nvmeq->dev->dev;
-	unsigned int attrs = 0;
+	unsigned long attrs = 0;
 
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
 		static_assert(offsetof(union nvme_data_ptr, prp1) ==
@@ -949,11 +951,11 @@ static void nvme_unmap_data(struct request *req)
 		map = PCI_P2PDMA_MAP_BUS_ADDR;
 	else if (iod->flags & IOD_DATA_MMIO) {
 		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
-		attrs |= DMA_ATTR_MMIO;
+		attrs = iod->dma_attrs;
 	}
 
 	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
-			      map)) {
+			      map, attrs)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req, &iod->cmd.common.dptr.sgl,
 			               iod->descriptors[0], attrs);
@@ -1270,6 +1272,7 @@ static blk_status_t nvme_map_data(struct request *req)
 		break;
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		iod->flags |= IOD_DATA_MMIO;
+		iod->dma_attrs = iter.attrs;
 		break;
 	case PCI_P2PDMA_MAP_NONE:
 		break;
@@ -1305,6 +1308,7 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 		break;
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		iod->flags |= IOD_META_MMIO;
+		iod->meta_dma_attrs = iter.attrs;
 		break;
 	case PCI_P2PDMA_MAP_NONE:
 		break;
@@ -1405,6 +1409,8 @@ static blk_status_t nvme_prep_rq(struct request *req)
 	iod->nr_descriptors = 0;
 	iod->total_len = 0;
 	iod->meta_total_len = 0;
+	iod->dma_attrs = 0;
+	iod->meta_dma_attrs = 0;
 	iod->nr_dma_vecs = 0;
 
 	ret = nvme_setup_cmd(req->q->queuedata, req);
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index b2d5266f8653..35ab3f8b53a8 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -285,6 +285,11 @@ int pcim_p2pdma_init(struct pci_dev *pdev)
 			continue;
 
 		p2p->mem[i].owner = &pdev->dev;
+
+		p2p->mem[i].dma_mapping_flags = DMA_ATTR_MMIO;
+		if (force_dma_unencrypted(dev))
+			p2p->mem[i].dma_mapping_flags |= DMA_ATTR_CC_SHARED;
+
 		p2p->mem[i].bus_offset =
 			pci_bus_address(pdev, i) - pci_resource_start(pdev, i);
 	}
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 214c181ff2c9..fab72c0f8053 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -16,6 +16,7 @@ struct blk_dma_iter {
 	/* Output address range for this iteration */
 	dma_addr_t			addr;
 	u32				len;
+	unsigned long			attrs;
 	struct pci_p2pdma_map_state	p2pdma;
 
 	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
@@ -49,23 +50,19 @@ static inline bool blk_rq_dma_map_coalesce(struct dma_iova_state *state)
  * @state:	DMA IOVA state
  * @mapped_len: number of bytes to unmap
  * @map:	peer-to-peer mapping type
+ * @attrs:	DMA attributes used for the mapping
  *
  * Returns %false if the callers need to manually unmap every DMA segment
  * mapped using @iter or %true if no work is left to be done.
  */
 static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
 		struct dma_iova_state *state, size_t mapped_len,
-		enum pci_p2pdma_map_type map)
+		enum pci_p2pdma_map_type map, unsigned long attrs)
 {
 	if (map == PCI_P2PDMA_MAP_BUS_ADDR)
 		return true;
 
 	if (dma_use_iova(state)) {
-		unsigned int attrs = 0;
-
-		if (map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
-			attrs |= DMA_ATTR_MMIO;
-
 		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
 				 attrs);
 		return true;
diff --git a/include/linux/hmm-dma.h b/include/linux/hmm-dma.h
index f58b9fc71999..d9f967ed7ce1 100644
--- a/include/linux/hmm-dma.h
+++ b/include/linux/hmm-dma.h
@@ -14,12 +14,14 @@ struct pci_p2pdma_map_state;
  * @state: DMA IOVA state
  * @pfns: array of PFNs
  * @dma_list: array of DMA addresses
+ * @dma_attrs: array of DMA attributes
  * @dma_entry_size: size of each DMA entry in the array
  */
 struct hmm_dma_map {
 	struct dma_iova_state state;
 	unsigned long *pfn_list;
 	dma_addr_t *dma_list;
+	unsigned long *dma_attrs;
 	size_t dma_entry_size;
 };
 
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 873de20a2247..402dc5e5d62b 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -21,10 +21,12 @@ struct scatterlist;
  *
  * A p2pdma provider is a range of MMIO address space available to the CPU.
  * @owner: Device to which this provider belongs.
+ * @dma_mapping_flags: DMA attributes to use for host bridge mappings.
  * @bus_offset: Bus offset for p2p communication.
  */
 struct p2pdma_provider {
 	struct device *owner;
+	unsigned long dma_mapping_flags;
 	u64 bus_offset;
 };
 
diff --git a/mm/hmm.c b/mm/hmm.c
index c72c9ddfdb2f..a871d8cb7dd9 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -720,6 +720,11 @@ int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
 	if (!map->pfn_list)
 		return -ENOMEM;
 
+	map->dma_attrs = kvcalloc(nr_entries, sizeof(*map->dma_attrs),
+				  GFP_KERNEL | __GFP_NOWARN);
+	if (!map->dma_attrs)
+		goto err_attrs;
+
 	use_iova = dma_iova_try_alloc(dev, &map->state, 0,
 			nr_entries * PAGE_SIZE);
 	if (!use_iova && dma_need_unmap(dev)) {
@@ -731,6 +736,8 @@ int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
 	return 0;
 
 err_dma:
+	kvfree(map->dma_attrs);
+err_attrs:
 	kvfree(map->pfn_list);
 	return -ENOMEM;
 }
@@ -749,6 +756,7 @@ void hmm_dma_map_free(struct device *dev, struct hmm_dma_map *map)
 		dma_iova_free(dev, &map->state);
 	kvfree(map->pfn_list);
 	kvfree(map->dma_list);
+	kvfree(map->dma_attrs);
 }
 EXPORT_SYMBOL_GPL(hmm_dma_map_free);
 
@@ -811,11 +819,12 @@ dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-		attrs |= DMA_ATTR_MMIO;
+		attrs |= p2pdma_state->mem->dma_mapping_flags;
 		pfns[idx] |= HMM_PFN_P2PDMA;
 		break;
 	case PCI_P2PDMA_MAP_BUS_ADDR:
 		pfns[idx] |= HMM_PFN_P2PDMA_BUS | HMM_PFN_DMA_MAPPED;
+		map->dma_attrs[idx] = 0;
 		return pci_p2pdma_bus_addr_map(p2pdma_state->mem, paddr);
 	default:
 		return DMA_MAPPING_ERROR;
@@ -848,10 +857,12 @@ dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
 		if (dma_need_unmap(dev))
 			dma_addrs[idx] = dma_addr;
 	}
+	map->dma_attrs[idx] = attrs;
 	pfns[idx] |= HMM_PFN_DMA_MAPPED;
 	return dma_addr;
 error:
 	pfns[idx] &= ~HMM_PFN_P2PDMA;
+	map->dma_attrs[idx] = 0;
 	return DMA_MAPPING_ERROR;
 
 }
@@ -871,14 +882,11 @@ bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
 	struct dma_iova_state *state = &map->state;
 	dma_addr_t *dma_addrs = map->dma_list;
 	unsigned long *pfns = map->pfn_list;
-	unsigned long attrs = DMA_ATTR_REQUIRE_COHERENT;
+	unsigned long attrs = DMA_ATTR_REQUIRE_COHERENT | map->dma_attrs[idx];
 
 	if ((pfns[idx] & valid_dma) != valid_dma)
 		return false;
 
-	if (pfns[idx] & HMM_PFN_P2PDMA)
-		attrs |= DMA_ATTR_MMIO;
-
 	if (pfns[idx] & HMM_PFN_P2PDMA_BUS)
 		; /* no need to unmap bus address P2P mappings */
 	else if (dma_use_iova(state))
@@ -890,6 +898,7 @@ bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
 
 	pfns[idx] &=
 		~(HMM_PFN_DMA_MAPPED | HMM_PFN_P2PDMA | HMM_PFN_P2PDMA_BUS);
+	map->dma_attrs[idx] = 0;
 	return true;
 }
 EXPORT_SYMBOL_GPL(hmm_dma_unmap_pfn);


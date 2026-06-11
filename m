Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101463451D6;
	Thu, 11 Jun 2026 05:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155567; cv=none; b=uTIjMLs2ealykMoxo1Zifv3Z3dObDJdvuGssZhw3m/ipOHlzmg5k6VCnuU4ustG5OkOzPUfJdpfK/gOTefNFnZgqkiy30YRTiDHxM2RT7vIl9MSQRCJvDl3KsxEpZkobRXOeXtFUYcki4TPdWmBCPsr2oOPAP76wl3BVSuqwxv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155567; c=relaxed/simple;
	bh=imkPUyYTVSioyf8vEp8Zh2hmaQy0gN3sW4E9CRMe47w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oN4xBKSOLNNyPHTSp/owIW5AETDAVrHP22bWPFm9oSO9pTJECu/5NZNI9O11rcySHR4uOEL9nFr2p1uDtT5BtQepP09AKOJSO8WS3MdZDhybpy5hEeWEPXOUaeAQLEpGn+3cszSMrEsn4jvPQrbbxruLHBI4tP7Wfb96yvLSUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3lWXQ1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3lWXQ1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A794D1F00893;
	Thu, 11 Jun 2026 05:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781155561;
	bh=XDuIn3y/rCO4r9DXHWsg+1RIZVo9GqzNtV1PP4apQRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=G3lWXQ1eDa81mBrJCkA/PCQooKDKZDvbt48avgp0O6fw29Xx6sKxbhO5qZnkxZ4u9
	 OxKbgbkMquVdngJ8SPiyWyre/tflzFPwaxG9vTOH79OGqlciuGssBF34DWyso1CHZw
	 aDVLXDoti3JcbI9D0Oi2cQfQuhj+pJ3kbX4EYy4Xe2MEKUwpaADT61w7nEgRm3kwLM
	 tSP+LAKWvEyh/ut0Dg4osfZsHaat6KgXBk/q1moX91KKeOfFQmsmWMabYftzxu7D6x
	 6RhvniODTNH6y39Z5sFE58ao01nIDFW6k3pW4yaiik4r+mgNv+m7xs7Nex2pRFVN0z
	 TxODrAxyW9DsA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <20260609143242.GK2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
Date: Thu, 11 Jun 2026 10:55:47 +0530
Message-ID: <yq5aa4t1myw4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> The sashiko note does look legit though:
>
> 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> 	    !gfpflags_allow_blocking(gfp) && !coherent) {
> 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> 					   gfp, attrs, NULL);
> 		if (!page)
> 			return NULL;
>
> I don't see anything doing the force_dma_unencrypted test along this
> callchain..
>
> I guess it should be done one step up in dma_alloc_attrs() instead of
> in dma_direct_alloc()?
>

I think we should do something similar to what dma_map_phys() does here,
considering that we only support DMA direct with DMA_ATTR_CC_SHARED/DMA_ATTR_ALLOC_CC_SHARED.

@@ -637,6 +637,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
+	bool is_cc_shared;
 
 	WARN_ON_ONCE(!dev->coherent_dma_mask);
 
@@ -657,8 +658,17 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
+	if (force_dma_unencrypted(dev))
+		attrs |= DMA_ATTR_ALLOC_CC_SHARED;
+
+	is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
+
 	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
+	} else if (is_cc_shared) {
+		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
+				attrs);
+		return NULL;
 	} else if (use_dma_iommu(dev)) {
 		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
 	} else if (ops->alloc) {

-aneesh

Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11534107D
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783969719; cv=none; b=ok25zjhqbU/gRou/ugETdcK1NEpDT4LjPXIYtZ1qV2yKXyjKBtYZYHzEhVtWPaTnfmrlcfiEx5YH6oAlunhybNMKaTDEXc5Kia2gXxeIv0gecwfKJi8pYIJqXNS1GfRExOXvXNiw44J9zneJG54WPWAGpmMsHmQ0AWMZJzgtlvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783969719; c=relaxed/simple;
	bh=GJtnY2yRqKWNI1Dlg/xVBMh0aCykSCHp+2ZiZ1vJGtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJvazGmLUHV0ByUN5GqoyuTPyLp+P0Ncng/Grqx6kq0l+ryq2hxwY9YkXIUN4zd+48mzkSGdqpvNZ8otbicDVWkSJBCvQAP2wo8fVCPGVLfVpLj8FswaCNWDotMXbiO5wlycEehkXaoVjH6nb+QChG2qskysgF2Mq2ZGIFzj97U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MqjW4xzt; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MqjW4xzt"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8efef6533aaso2134076d6.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783969716; x=1784574516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xI/VqVGbyjLJTRr9oYnYDAONmrfr0w8bRuYGoSNi5Tw=;
        b=MqjW4xztWnYhBon3ETzBahBe1UEqum/+yLC5gAXdpTYpUeYO33CB1j2nKUGuRMBBsa
         lzIDJQnyr3qSw5ZbtrXBPmWbLgLXBGjzaLY8MS0CMcRXoAn1dPmhYg8Ik4ZcY/OZ1x3e
         S5xrOn+JrUVjDRBI1xrictfc1Ui+yZ/GolDQXwcuYV1wywjxyw2/B7H6B1k8Baivfeir
         R8Y8gnzOPCNIvD/+1HhJct1ZRlRnK4YoQyxZ0iy5it/kmfhc57Z9M1kBwsSsTNR9tiMj
         bTUbPcZAkFx6HO49SQvlqjSN6OYn3eEM1SAojt24ulbSM9vYUGKzhYyyz2VNW1pb+7U9
         r/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969716; x=1784574516;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xI/VqVGbyjLJTRr9oYnYDAONmrfr0w8bRuYGoSNi5Tw=;
        b=iqVxNPo2KWrEWdn1/GiGTvugH1s7VqxEyuRuaYmip+EzZTPz8nrKVubVzqISwFi/1T
         doSSmida95qzGedHdX8zVp6TaM+sBlnD0DIRBytu/tVFAGRULUEftdz5EeshttUZYYaZ
         wbrQbyOHeFYLTi9vpyw5O7b4ZthtBvRaEo9sNAPo7Dez/Kz39NONynBaHInkWVSwqyDP
         Zpjq2ZsLD0oFCpxqi0VgPSAO4wH30x80lbI5k4sSYNdZfWz2tHt1kHTKdx2Pr726Fz5o
         w59ZIHsLiGQKAmEkEBTybA1l1/dGsX5TvycbZM90OgbJ90o89jjMqwABBXkos6BRvEPt
         jDxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoISJQr/JkbuwVuPo465BQx6XuBhui1qsZ9MxXYm7W58ADmYm1AE6fR1ffIvMH15HgiIpxqHfhwrME9@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUfj12YGsSUQu+CmLoZb6QzcbVw4EvNkWVdBHonQlFlsxXZul
	L657NWhDRKVOQKKOYhOHUjqJHMbcJE68X4XY8x4SmN2yNIJXElTdynrunPWxr+s5brA=
X-Gm-Gg: AfdE7ckX8UeM5ybwlK1DzIilXggxjStiXR1x9aF9B9zJiEwb/yleYGUG1V3mXmXHKJP
	4T0q/ENc6YFf7IkI9hygjMcFY+uKbwVBPhWKWWP/pEDGWTQSTpfKp5sZGxy1Q2nGrL0i7wLv70v
	Frwj4QgN95nwo4MZh2qxwLavq5PwVyFe6ipDaTg2bCs2nD7jfdrciYRe7VIV5wZZ0OP4RMR2n3y
	PwE802Rs64eRQ5EkOemKqUTcHZ0KoZf/BrPEPylHT0YooqPNwnRU426evMnOVrTvekiK08V0tZr
	8mDaDsCpX7KzpGaqAeSjAhh/h1VKepWNMocsVUvmJ9LyGrqxP6tmh5uQd/n525MhYqrCyGJCU35
	q7a2k+a62kT5f8xRjMDKmD5IQ/OjR5jsC76bzgIz77y26+CdRJI1CYTxoWK6j
X-Received: by 2002:a05:6214:419c:b0:8ef:6c8a:e8db with SMTP id 6a1803df08f44-9040206aa9fmr110916776d6.47.1783969715612;
        Mon, 13 Jul 2026 12:08:35 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0811sm137651756d6.3.2026.07.13.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:08:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjM14-0000000E3qf-1Q0G;
	Mon, 13 Jul 2026 16:08:34 -0300
Date: Mon, 13 Jul 2026 16:08:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 05/22] swiotlb: Preserve allocation virtual address
 for dynamic pools
Message-ID: <20260713190834.GN3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-6-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-6-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:09AM +0530, Aneesh Kumar K.V (Arm) wrote:
> swiotlb_alloc_tlb() can allocate from the DMA atomic pool when a decrypted
> pool is needed from atomic context. With CONFIG_DMA_DIRECT_REMAP, the
> atomic pool is backed by remapped virtual addresses, which are not the same
> as the direct-map addresses returned by phys_to_virt().
> 
> swiotlb_init_io_tlb_pool() currently reconstructs the pool virtual address
> from the physical start address. For atomic-pool backed allocations this
> stores the wrong address in pool->vaddr. Later, swiotlb_free_tlb() passes
> that address to dma_free_from_pool(), which will fail to recognize the
> chunk
> 
> Pass the virtual address returned by the allocation path into
> swiotlb_init_io_tlb_pool(), and store that address in pool->vaddr. This
> keeps the pool free path using the same virtual address as the allocator.
> 
> Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

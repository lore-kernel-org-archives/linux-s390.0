Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B790322B8C
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970019; cv=none; b=Chh47kkpJgexr5hL+p2tttgJDJMnhnTJEM6J1Q4D9pkejlgeuZH1deB8Fh+ymg2Og+xf9hGBXbYII7dWwg8qltSFYdCx8GwCLrI8fTY6bCtXzK9IZjwUB1zO8gEqCNR8CGyiSrGycFmqaYiPUD6hVnVCaR+T4xIoPcuJ8s1DdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970019; c=relaxed/simple;
	bh=92pQU4Hi+MtUFsgN9vNGOKjNaZ7KSv66gg2PCC2d0mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCVK5dVPHMw6cA2eIci5Es3qZeIwkbu+NzzU5NI4lDs2vslHIw62GqpovqXXhWjwiP7YPyDsz93xQsiKGMoiiSsKZc0lrXuEKLL1PZoaGu2B9mN6T8GKhRbh1X9HBCkOGkuSOzmqj7VXig3fYHgmu3nAqanQ8qEplx44bOs/ACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X+FJtney; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X+FJtney"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e67555e24so16745885a.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970016; x=1784574816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GfyQxZTxEaV2M3A7Wuj8sGJT6iMHPBQ3Q1zHUbuKZKY=;
        b=X+FJtneytfqfXy7zQB93jwoK0szhm67je+1u5mvahofIgGkRha+WGnKKDDJvr0Vwx0
         fSL3ile12+AbINr9+y6IGQn57MHIx03b06e8kMOfc3jN5anp+E5lbWghOAYXuryZ1G93
         BvgYwh3edykCohmB/57obh41mAePg9Kfna/lgID17uAEf2y3xQqkJXUdul63WRjqcVSa
         KBqLQapMgvO0dkbCZSSFHPGbI2bDosyFFoMiM6oMnJ8sAl68VTunQ1zEr9uFfalm0Vzf
         FBEM5Gj631BRH0T1Ntim5bRqXSWXmgZaP3DzVJZYkniqMoMs/1FwmyP/Pu5hE/603YSH
         v2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970016; x=1784574816;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GfyQxZTxEaV2M3A7Wuj8sGJT6iMHPBQ3Q1zHUbuKZKY=;
        b=bUDSo5UCflLd+/XIRRVe7kUQpynt/SKzaNQ/G7GheegCthCVFyLESLcLYvT0OCGZNe
         JKUy7rC8MtmgpS3xCWALyhVqAMhUPLLqz3e187b78P7WaIhDeqMVkc/jRUNg0lOd/oQ6
         aavD1qt2b1/AzOy169eA0HG1gHqaxwAgMTuLKnDHhWiYu2C08zej8zVKdkzEtCxbpb5H
         YOqz6ATOniTyKvwmEjR+0BrfBCrUymD4u+AuTVAvjkKmG6TftlQl0lBaaLp/917hXs7X
         xOfd1VFHKO5LTSFJORxuFEf16icZqg9Yaynz/YFdD4sUkx7s3bF9SUBZO7h9t0bQAbJ1
         v0fg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8KT/KRA4EKVwUz/+oQdO7YvKQfj9lYTLBVRPE55Hbi2QshmQhIL7UxVv0vb6B4B3pYJ2XEKuZqk6S@vger.kernel.org
X-Gm-Message-State: AOJu0Yztz8ko+O4FPZvPHuGIgTeCsZ8Q8tuB6zEo6I7UNQKWfCJGTygi
	rhKib3YoDNvzk/sXQo8xYOgW1TwidzNRKHKCoHfI8YGspryQc0dENUDXJd8otyaMV+g=
X-Gm-Gg: AfdE7cmJBnImV0pgrgEyDOdkviaWrHtnJi1+dwHs5kFFmo4WkSxELUFkmEZzJ6Y+P9P
	ojQeVaVR5d6qu/Dg8tpsfFtcofBepQ46E+XjKBB2/uCJ0kDNJFF6hB9M55i0cO8UPnGpXweL50V
	pkbZgajp/4ZzgAoBvQPnHLyL2Tk2YwvFOx+IttqREl3bzRu8+92GWn5ZrdYo9Sit6RAz0ow1Huw
	q6l6teUgi1AyY7oF4OLeE04O6Q107+CREMsbk7HQxQ694WEqgj+Zya0nMHANb/FMDe32L3RkmmU
	GCoNFWOziZ0Cs5AQe7vvwGqY5N5dVqgw/GxtLkpR5XnK8hyqwRrKxxZm3n0YqItw+plN5TnPp2h
	y4VMCZxyM+BgOL5B6D9o9Sev8nfq/7rGnElb+57s1Qh0Y305v3rsr/L1uiKCu
X-Received: by 2002:a05:620a:8908:b0:92b:6805:9198 with SMTP id af79cd13be357-92ef2c69c53mr1083302685a.64.1783970016442;
        Mon, 13 Jul 2026 12:13:36 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5bab293sm1169545085a.18.2026.07.13.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:13:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjM5v-0000000E4M5-1cBx;
	Mon, 13 Jul 2026 16:13:35 -0300
Date: Mon, 13 Jul 2026 16:13:35 -0300
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 09/22] dma-mapping: Add internal shared allocation
 attribute
Message-ID: <20260713191335.GP3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-10-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-10-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:13AM +0530, Aneesh Kumar K.V (Arm) wrote:
> DMA_ATTR_CC_SHARED describes an existing DMA mapping whose backing memory
> is already shared, or decrypted, for confidential computing. It is a
> mapping attribute: callers use it to request a shared DMA address encoding
> for memory that has already been prepared for shared DMA.
> 
> Allocation paths need a related but different state. Once the DMA core
> decides that an allocation must use shared backing pages, the lower-level
> allocation helpers need to select shared pools, decrypt newly allocated
> pages, derive the DMA address with the shared-memory translation and
> restore encryption on free. That state is internal to the DMA-mapping
> implementation and should not be passed by drivers to dma_alloc_attrs().
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  Documentation/core-api/dma-attributes.rst | 29 +++++++++++++++++++++++
>  include/linux/dma-mapping.h               |  8 +++++++
>  include/trace/events/dma.h                |  3 ++-
>  3 files changed, 39 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

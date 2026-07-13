Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD134CFCA
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965382; cv=none; b=RbKL9x/gAnnDV5JkZ21OPoXs2Kx03O/mGYT+U7a3VI/+saz8wx1w6d3tinkVGhCwTTBp2XiWKQLXdJhBGh+IaXf+oCAwvlJd6wBi22NW2nSrwUwGE9gBxSwJXh1Y+t1IXyDrqUZ/BR8D0zo0OvH6rcTCcl49wtlyQPmyq1RBL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965382; c=relaxed/simple;
	bh=HZlJhE5yEawTWMpR2br1LMTc0/ct1LglVKv1a4251Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhBMEwHpEyXfatT23QQvFTHvgE0SnuC0sA6pdIaIc3DRjWsJ/VDQ8lYCVnsNoa681USvcGvDAbxPLs+anm378qW7pWaSxWtQjWMGHlQbKUngzTXwK/UujMK/I8nvsYnYxGbj9nDB2yrBKjsvjQ2qmj9NMg+CyKpDMKh+0+P/K4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NESxXD2j; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NESxXD2j"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51bfad59921so26639981cf.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783965378; x=1784570178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/wrHcKHA68TkDcKIgsJLD5FCo0DNb4FA5MINQ+2Q20=;
        b=NESxXD2jr50NXEdpf3bfSO4izmiFSGEGphusmfAyjRRbphMy+VeUUKqz5zeqdVZUPV
         sNs0YqgRypVu4DP4I07ygdORQtZhA5Koe7nrM4LM00wq9mOV/cPJ2syk/F37v5CYOnPX
         1TgRQXC8jjy2GW5EOomeF1n8qgAAzrc3UssO8mUyvXHyHr+iTaZgtrr42RNBrZ4DrWSL
         p1VXMo4AFqxV1USeCR19qWJ9NN2WTk41HK2BsC2OMdeXL7ObmZ6FVF7qAPfETBaXjdPQ
         qJ8zQ1kn9F5Pv9LboizRGuR4jJlg83BqwYdamwZoxM0kVcnCEjn5owH40P8cqHGJ7GF0
         guig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965378; x=1784570178;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/wrHcKHA68TkDcKIgsJLD5FCo0DNb4FA5MINQ+2Q20=;
        b=ZHkiW1khCZDcXirk1wswXUl71yiVBd1mNvzCWIYSK/iOFSYZyqlRzL6UtFcYlxHNEo
         Y7vfD8egFiciSHf9Fh/1Uo0bo6CjPYBu3x2rr6fggGY2T2W5v5agTADIBEjFQ0c6pTkD
         jWyFs4DRq0vSl9WvZeRFEagrjGEro17+pRyk0te322po4dgp5Af8J2CV6KuZWuA0wB3u
         8QGBp2dVhESZJWB86Takn66cNjrd+hguZ9AIh55TrRbzNVnEPNoZhxt+pi0FuNneV9fn
         lD9jf/ktYdT7XMU0nGeqQYuiDVq77LBx3oPixgzZS67gwuHbnAM/u3Mz2C09/2WrgiTl
         XJsA==
X-Forwarded-Encrypted: i=1; AHgh+Rqoi3UMYSSt512MiQ0fDoU9fk9fJUl1DrOVGyHWFuhoNzXncas+2ZFXYsVslrMh39Zh+X0ZEYpeT7lR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+b8OGRfB6J+Ie5zXscrZoiE0Tgi0m2SJszAAC0Rnzb7hlGBOC
	VFYjsNSqak3e0WElOhGJnwn0Ldrd2irZtjPft0GVQ/OOayEODrUf4x8Un3j08RYUZJM=
X-Gm-Gg: AfdE7ck6iJEd6ZI2s9tSmeRu0xAhKjLEgc/ToUU8Oy/cHedgTN+FRdeqnZ7GzXESc8l
	6436cFyoGG31k00+eBX/ZW1GckdbNj//gYUUIi0qBeiifqaQK9xUHRvs+xUzcUel0KlgNpG8snf
	o5N1ixuP59FF5FhbHh7ZOC7dlnCQhZ1p5zn31wpBayCnpfPJn8DlvHk8NIuQjVDibxqgwjSe3jz
	tw53P7K8uFVlelYkmShELhcH7Kiu3C8hEhD+0xQ4UQxBhfahHZGMRoLut0WeiW8uZeqgfG6Xolp
	dFpVZ9cZ6f16gQMNVIX638PA13ys35lCqYIrix1puDETT/29gDm1AEwozGCFpNxZBA3BAdQt9D8
	rJe8GZalfC2EJlNwDT4fVoiFa3yMd2Ao7pHxF/Qu6N1uIkenAjqN9R2cmR4mR
X-Received: by 2002:ac8:584d:0:b0:51a:8945:3141 with SMTP id d75a77b69052e-51cbf1faa3dmr98217881cf.55.1783965378189;
        Mon, 13 Jul 2026 10:56:18 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf5f61csm91065131cf.22.2026.07.13.10.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:56:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKt6-0000000Dx9V-2ddz;
	Mon, 13 Jul 2026 14:56:16 -0300
Date: Mon, 13 Jul 2026 14:56:16 -0300
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260713175616.GJ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-12-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:15AM +0530, Aneesh Kumar K.V (Arm) wrote:
> -static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> +static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>  			      gfp_t gfp)
>  {
>  	unsigned int order;
> @@ -114,14 +120,17 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>  	 * shrink so no re-encryption occurs in dma_direct_free().
>  	 */
> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> -	if (ret) {
> -		leak_pages = true;
> -		goto remove_mapping;
> +	if (dma_pool->cc_shared) {
> +		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> +					   1 << order);
> +		if (ret) {
> +			leak_pages = true;
> +			goto remove_mapping;
> +		}
>  	}
> -	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
> -				pool_size, NUMA_NO_NODE);
> +
> +	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
> +				page_to_phys(page), pool_size, NUMA_NO_NODE);
>  	if (ret)
>  		goto encrypt_mapping;
>  
> @@ -129,12 +138,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	return 0;
>  
>  encrypt_mapping:
> -	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> -	if (WARN_ON_ONCE(ret)) {
> -		/* Decrypt succeeded but encrypt failed, purposely leak */
> +	if (dma_pool->cc_shared &&
> +	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
>  		leak_pages = true;
> -	}
> +

Was it intentional to remove the WARN_ON and comment ?

Jason

Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C5357D12
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971695; cv=none; b=IUSb9deLs0xeFGNqfJf0pYRA6wfDEkn+GJpwcusc2ghExBmlWmSLiN+EaHHSTgE3va4QwH4e6zGSa87V2uhvqBVssHaaT9ALrzWyysILpPmifutkX2DDhjbGWtc+v318s4lZoHKHtmmUxd1S0qP1+nUkdDHVmUL6jmYXZzGPeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971695; c=relaxed/simple;
	bh=B2Rb2Qu3H6K9h4z3M1wOOTBejPY5tvykheBX1AXjDsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8iHL1xFfay0CT79sMOrSxfG5ECYZqizJwmvTN32nmmFiTCKoxYSI/8ej+iI9LAwNHFJCQ3eOTowT6Rib+EsF3R5lgx58vOri1gtNHgX1N00bcmGAoVHvHfUN9em4a2Mn8XisLP97qL54PD+nUo1DRbO5buMiL1jGYJiQsdbj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h19Ux+5R; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h19Ux+5R"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c29b46382so23068211cf.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971693; x=1784576493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RaFiCRG6TDd5hbIwyaOKkhGT65gZ81YsG2fbaxJfaHI=;
        b=h19Ux+5RrIt2Qj37Ey0Ugc8JC3GtEyjgueBFjgbu1ab57PiPF016jCyccKLgUITV5L
         yaOWYx1pB+y76f9O3vSw/VFXyBbrRXiOLnyoGtDOe1QUqUChHHJwxQKxFujCa4OZMrON
         sgwbwCC2Y52Z5VHMQnGY2+Q2RWfIu9G71LUIctHzyYuMoGMuXZpI0bEmN5jvoD2XuKDq
         UDYx2BgVFFJC7Q1XwlLgvZprnu/vfsAjp/2FDQlg3I2SNYZiSEJHhuNIG80I0NqItGbT
         CPDd05RlVlHU14ySmBtCwUlDjhphdwgr/BaiB04YDvIpbhmVrcHRlNW+un4hSyqoBS9a
         MQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971693; x=1784576493;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaFiCRG6TDd5hbIwyaOKkhGT65gZ81YsG2fbaxJfaHI=;
        b=sklDQB+N4K//1OpSLn7mEqqFUvuxaC4+AeAqZvC9wT44ZJHWZHKpLhMJCSshOzYfZT
         +O37dwdBGrWxlYDxCL3NXfJeUdcqocmGmufmR4pOw0o/ityqaN2g7qdZOVVAnQx1PYop
         QgPScU0kJ80rowRqlllcbeAff+SBaXeUqJ0GBpmWABs2cMJhhAMjvvR87j/vW1YrTHrz
         9Jz8gcmm5RjpO2Ciu1VKSKN6n+KR2Cfe9rsGXIf9Kb+4hAS7p8Go3UWXXStl1kmxu4XQ
         ZWJ0Xxu/dWqBQNRrqLlmSlz50O0RBb9RlxEcUD+rHtJs3G+Gv25bBd4+cL+kIoFMBzoe
         Q8Iw==
X-Forwarded-Encrypted: i=1; AHgh+RrRLZIRVXqwuA5Xpp/xSc6stC1xgcEzS1Y/75CA7a3xmucvY575WK9IzgrG17co9o4eddY4Aib+FegO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7cMQ/Jo2UYKfrJs0ymD5+Qt/ewpZgWSwkKfn4vzr3O5D6Vgsl
	tzSqxn59nhJEosPSiWh4WRVIptzsznunS4VMXxuzITt7HsMM9kXjHkhjYh9wLbcbeww=
X-Gm-Gg: AfdE7cmt/xOXHKi3/VJ1aBsIeVuD8cytUrfM9rxCZpMCF5oOROlsLgg4eQzCn7SEO8f
	Gc+s39qO/Q0dE21c+qLkqXZtsNr1bYm2+9CNHNwaqVD/GT0bbHLYXUKxewwNkQA81twlbt6Q5wc
	vZjOOpMcCLCgi5I+V8LzA3Y2GhGHXq59508jaPA5Ojt01rtZaiMxtIY+/ezpKqqCwcJMZL/QmMr
	hoVj/QAoOp3cFQtnH5zCA+oTPjV29H04+asI0lb8AZwExggyKAnAnT6N2vX0fLAjboLS5OiAawp
	vXxROPMxD6iXEk8BravaTM9TmLY5K0iUYIqCY5ml6wtPQL5Z0apBYIFfBE12S3Jo8goj/+MxiZZ
	3F6IWFSDZg6oY6OZLcROtb8dQfDbqW0YzyTVAmOxaixgweyjn4AASpKGjCvUn
X-Received: by 2002:ac8:5fcf:0:b0:517:8711:d46c with SMTP id d75a77b69052e-51cbf0f3fa9mr100726891cf.31.1783971692761;
        Mon, 13 Jul 2026 12:41:32 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b44sm90213801cf.30.2026.07.13.12.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:41:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMWx-0000000E6nC-2kaU;
	Mon, 13 Jul 2026 16:41:31 -0300
Date: Mon, 13 Jul 2026 16:41:31 -0300
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
Subject: Re: [PATCH v7 20/22] dma: swiotlb: free dynamic pools from process
 context
Message-ID: <20260713194131.GZ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-21-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-21-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:24AM +0530, Aneesh Kumar K.V (Arm) wrote:

> @@ -840,7 +843,7 @@ static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *pool)
>  	list_del_rcu(&pool->node);
>  	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
>  
> -	call_rcu(&pool->rcu, swiotlb_dyn_free);
> +	swiotlb_schedule_dyn_free(pool);

This knows if the pool has cc_shared memory in it since there is now a
flag tracking that? So should the work queue version be conditional on
that flag?

Jason

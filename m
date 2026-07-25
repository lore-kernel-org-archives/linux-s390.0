Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB32459DD
	for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784990058; cv=none; b=jQkq2CaDhH8iLNE5zL8t3ez/XKdIcAzNZ7xZHk39HwgpZcmxibvaY5SnOpdPxodSHt6jXTLX07/ddWWEjwQqftWoQc/o8dTjv0SifvJVXVDzc66oFvLJFRBBcDifYDm3QBWXL/hy9X5D7O6z2/uZpquozlSEFTgtPvKjLDYXlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784990058; c=relaxed/simple;
	bh=YvPY+TLfnAZJLuA11fwmu2rvBC8Nt5tUSqw5kT8WiQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAzWMN77WtpuQMkJSIqPVo9L1Dq31jraV2s0XprxQrDz8kjR3qfRRperWtZEG5D4TAb12Sl7S3mPFeu1G4l8qioGeMAuWWAy055+bLtvPM7kBxyU0jsaeDuADahdUX8Y3sPkV5rKgTvH4IjLtmZ7vIOQ/Jgfio4o7KR+ujEyaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XUMaulVM; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XUMaulVM"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-74ae4c75b20so727030137.1
        for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784990056; x=1785594856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vD91S1DbebApVBCN527t7AaQw07MlhokwGC+vI5FhsI=;
        b=XUMaulVMriK2c49kk4iystDShc7ivllItiMlNvFoalQdNBdfzKDkDGPCnY6EeP7xpI
         XmqYz8snPcYjC4JiXgSohd3oF09yMaWPyJkBLCkOWOIxemVv2Pzx3MCa2mUnHu+8G99j
         fr2GPkbN7fsdj99DAoVvfCnRtaHMhrD9IHciay+cqpzLH1BV4FJKXdrfeoT1SAh43hZY
         YyB0RnMxkMTXSsCsTOHtwTCjaYNAKljLz4YCN+Su9JqL6Nb21FyJYIeR74Q2i7I53C04
         v++1ASZmuN0o4TMyX9sPhUo1o/tD1gPp+RWA8NtJ1nHZP5krs0DelwvFgEG6Ql1NYsD0
         g6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784990056; x=1785594856;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vD91S1DbebApVBCN527t7AaQw07MlhokwGC+vI5FhsI=;
        b=dpZUdsZ688uZa30URcR7p7asS4in7Lpj9JqmwKrnuGLXpwdm0o3SwTqb2lE6ojRfCI
         XUP9ovnA31ZILO5KnvD+f7eXiGfum8ZJ6n19MxZc0vg88YBQ3cDGzM5CC3BQiDSD2FwR
         C1CmQNVHr24pTopei7ZJjt2IXy0weUdLWJX3YOANw+S/YIFykSx2YD7Jys0Vwq2hVRNP
         WXqrQ9NL3xjzIxJVu4MfB3jq/IlhQ2YIDOFvFXS3oFb8jbQnwXFp7ISW9d7g6PoMw3En
         3MNUcPJbykjA3PDE4akIL2xtkBxx5M5+6hc8KK/sEVxowR63vRZ4gFYEuJFRdzkUR2BE
         B4Ww==
X-Forwarded-Encrypted: i=1; AHgh+Rq80xQij6Zbn7GZroPMXAH6hrTn7rqdcxOt6NzVEOoSRaKDtWD4mGEAZ6g9wv27UyLdxJIHYZhZsRAv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjo+iE6/+dEbR1llWvtiLddVeeSdCp49CZBoJ0M/DDKPej7/dM
	XQcTKpXYrUEIZK4gVRg0CpwIF33yqLPhh9HTfSzRlHxAxc4XlvHkrBnxnPrzQcPKUso=
X-Gm-Gg: AR+sD12N1LAXwQXVVBSWJ7h4DsaD09uNnABPalZWIG3C6xRvvdBuXoo0s/iObiKwEWL
	NjJv1u7cmvYoASG8XJ9MsBzauGbUzZ1OYWVULBAw6xkwW6aKNPlEGWRZxbM9Rqy0YhyYBnyEX6w
	RTeN9DNVfgOz5u6ZdGfdStUbo8iwd7Iv+AYp10vnt9ltaKhEdMo1/VGKl1IqY4BcC7qLH/pIei9
	d3GynH9I9dMZKx/c/fXEFk9jiLgQB3BxhEP8NRDF3J+8lv7NDVPn+Zv6FFXDZYZMDS5aFWvfbuW
	zVHaKDD6t8VYB4rqi6AbMOKTU6gdnHoqIikPFYTfRI388BYh8gWg9db7A1T39qicD2mFworkWvX
	ygAsbsb6J+nY7sZ90Ow7orfyqynHf0qDraO3S+h4A9M7R+Wf9ag35
X-Received: by 2002:a67:fd76:0:b0:744:d517:b0b0 with SMTP id ada2fe7eead31-74f9f02b7f2mr2159251137.10.1784990055747;
        Sat, 25 Jul 2026 07:34:15 -0700 (PDT)
Received: from ziepe.ca ([12.18.163.234])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774f12690sm1878229241.12.2026.07.25.07.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:34:15 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wndS7-000000000hU-1YTd;
	Sat, 25 Jul 2026 11:34:11 -0300
Date: Sat, 25 Jul 2026 11:34:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <amTJY_CdE-uDgoGG@ziepe.ca>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
 <amEhEKQW0_HJ9cLN@ziepe.ca>
 <20260723075704.GC110966@unreal>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723075704.GC110966@unreal>

On Thu, Jul 23, 2026 at 10:57:04AM +0300, Leon Romanovsky wrote:
> On Wed, Jul 22, 2026 at 04:59:12PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:
> > 
> > > Something like, but probably void* needs to be phys_addr_t:
> > > 
> > > static inline struct page *dma_phys_to_page(void *addr)
> > > {
> > > #ifdef CONFIG_DMA_DIRECT_REMAP
> > > 	return vmalloc_to_page(addr);
> > > #else
> > > 	return virt_to_page(addr);
> > > #endif
> > > }
> > 
> > I don't like this, we don't know for sure the addr will be in a vmap
> > and this will fail if it isn't.
> 
> Of course we know. The existing "#ifdef CONFIG_DMA_DIRECT_REMAP" is
> relevant for addresses acquired from pool.

Yeah, but I still don't like it :) It is hard to follow if you make
those kinds of leaps, someone will call this new helper on something
they shouldn't

> dma_phys_to_page() is a bad name for some low-level conversion function.
> It needs to be internal to DMA logic, in the level when we convert from
> phys to page.

I think we should not convert from phys to page, that's also easy to
do wrong

Jason

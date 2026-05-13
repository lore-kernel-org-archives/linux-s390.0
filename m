Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C314DB562
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693100; cv=none; b=T+xJ+FJSF20qgzU6gw6kNg9jJF1TUKNxkjf6xVEj4GM3wn/nYWdCnlx1MJca+OHVa9tsYsaFS3F2/IGOvH3Vboo9uREPsNws9mEzwPyBt7bZS5a/hekTr0ZKuN08xSHFCCydQ5qzT07ve7LNN/F7H8UEGnxaCs+CdVI3PwlTV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693100; c=relaxed/simple;
	bh=BfC504n+kThMXbLodptWdwF+5sTWwaf4D5wXQNX5RnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esbdUbn9Jl3xkUQ48caUupHF70eqGrzzjXRWocHHT+6FU9zNhPgFhOxEbk1Lx9tj0XoGkDsHncqWKfhGoxKhfApytM2+tg+vtXDnDu1WmViMcUGuLKsucxSmFKyG9+REO3tTPtrJcu+tbPPt+9gn+B7xZc1My0e/5LhiP9x448I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Grm08l/c; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Grm08l/c"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb40149037so653871785a.2
        for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778693092; x=1779297892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQtwNmxswhQih8gmC6FPDl+zfVKzr3i0rq4YmglfcBk=;
        b=Grm08l/c2QX0cUK33emAUMJqEP8/C1QHmgP06iVG3PsVSVBDg4DycrWgdqqYLskFUH
         XMYIPSq9n0YhVFhNSA48SlIC8JM3L0RpBExlf8uY/2nymk4Chbb2UP9UAWdcJSIpU+O6
         4APh7F5FQ5swGH8MlbS36UwKs9F5ac91eIT5YcXZ7E9uoxfaqbYfACq1YFSQXHzkf+28
         fqQrOH4QJ7Fh4Yi7dOzPfUgT+SnIxWgbDRUK/wPvzFqYYm4Zq0s8F0orUjiepEY4Gxek
         KMVizDXugein1K8quZdaY4YIeF+gAiXLDUkHJDY5zdYfUdzSyzyZ0MPJ2US4F/227oZ4
         +RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693092; x=1779297892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQtwNmxswhQih8gmC6FPDl+zfVKzr3i0rq4YmglfcBk=;
        b=nfNlq9jloo7OpUIsMxx4mLbElll+70IIFUB13fbgTqtH7U9gh5jy2xn9DkjYNxPZHp
         4uQxZWqq/SCAFoURY5putsqfgP83f9DrWHWvE2M99tozjhyZKvt0FAGPPhntP7kEIebH
         AZ71oJBmpjcryKWaodup2Xo6TB98SJ5CG9SZE2ylYhDjT4NJcEiWWVSDfqyIvKGLGv/1
         EB5uImhmYdLXFCFWeM+TbY7FE67oiPt0+K0pFTn6knU/H/9zgBdvVJ4njFRu6/T4j3Cs
         6W8ZbdADTDRGQbH7AaeYnmEBD9qWWU1kznFnyrWbugtjWzDgBEwS1uSVYoBFuh76EfSh
         e7VA==
X-Forwarded-Encrypted: i=1; AFNElJ901vcpN601dXW0ml6cNuBXZGj3CGY8cxIVil6wep1ctuueeb3OnDrLGoHKWFJOZh99IpIFoe+Y115K@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQifZDHub7eVqULmHHh7CgsyRpZIE0ULc4rTSYpfIopKbqNQx
	0TrutqG60nMq3tK7XEJkPm6D7+aBzHhL6MDKe2kpfvuzxtorcafSKSPo8yi7chsKb5M=
X-Gm-Gg: Acq92OHL3qxi5ESMwft8q95NtLwI3vg9NJ0ul+yLA3zSPXjApZ1nkrGDuIb9rFY7hSs
	Ly8kXDcADvK6KAGFwMxQDknxzRsOtQwIWuzMGMiaLZStTapHDtFS59IQYMUh6e0KwQhwnaz9852
	F3HVKuAuVggKpB9l3BRRPcbQSKZghh2SVEg24AOsMB7lchZJC8o7VmFMJjWDbUNtpiLFbQzu8IE
	YSG9Ua29/IOikUTh/iwu64nLZlU+5vCSM6b/x+6fScqvPEPsTvt1NEjh3tblb6uUNbzgflQ8TXy
	N6q81snOj3vuW6+F+bOl5x3zSiIFWFesFB7KPi0KWaEAT1I9C/OfKetzllX+ck5Va/9qUNlbCeb
	iOS104JYF1M3FU+R8gi9CNOOTrjILVfmPYqO7Kgnnprr8qMizr2trjGFFMmmi/KrbJkhZY8H4Gh
	l3VHEYYAtKIkLLSf6zbwnYkIuxDmZGFA1t0vRxqk70EQzsjCMb2aX003aYuZBSceZcUcvbPRWLN
	VnEzQ==
X-Received: by 2002:a05:620a:19a3:b0:8ee:42cc:4d9c with SMTP id af79cd13be357-90f8ac08735mr658592985a.39.1778693092335;
        Wed, 13 May 2026 10:24:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83bbf5sm13598685a.28.2026.05.13.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:24:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNDKE-00000003dZu-0jxL;
	Wed, 13 May 2026 14:24:50 -0300
Date: Wed, 13 May 2026 14:24:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260513172450.GR7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agSKQrSIhizCXKwx@google.com>

On Wed, May 13, 2026 at 02:27:14PM +0000, Mostafa Saleh wrote:

> > +		/*
> > +		 * if platform supports memory encryption,
> > +		 * restricted mem pool is decrypted by default
> > +		 */
> > +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> > +			mem->unencrypted = true;
> > +			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> > +					     rmem->size >> PAGE_SHIFT);
> > +		} else {
> > +			mem->unencrypted = false;
> > +		}
>
> This breaks pKVM as it doesn’t set CC_ATTR_MEM_ENCRYPT, so all virtio
> traffic now fails.

How will pKVM signal what kind of memory the DMA needs then?

Does it use set_memory_decrypted()? How can it use
set_memory_decrypted() without offering CC_ATTR_MEM_ENCRYPT ?

> Also, by design, some drivers are clueless about bouncing, so

Oh? What does this mean? We take quite a dim view of drivers mis-using
the DMA API..

> I believe that the pool should have a way to control it’s property
> (encrypted or decrypted) and that takes priority over whatever
> attributes comes from allocation.

We should get here because dma_capable() fails, and then swiotlb needs
to return something that makes dma_capable() succeed. Yes, it should
return details about the thing it decided, but it shouldn't have been
pre-created with some idea how to make dma_capable() work.

If dma_capable() can fail, then swiotlb should know exactly what to do
to fix it.

If pkvm wants to use the hacky scheme where you force a swiotlb pool
configuration during arch init with force swiotlb that's a somewhat
different flow and, sure the forced pool should force do whatever it
is forced to.

But lets try to keep them seperated in the discussion..

> And that brings us to the same point whether it’s better to return
> the memory along with it’s state or we pass the requested state.
> I think for other cases it’s fine for the device/DMA-API to dictate
> the attrs, but not in restricted-dma case, the firmware just knows better.

The memory type must be returned back at some level so downstream
things can do the right transformation of the phys_addr_t.

One of the aspirational CC things that should work is a T=1 device
tries to DMA from a decrypted page, finds the address is above the dma
limit of the device, so it bounces it with SWIOTLB to an encrypted low
address page and then the DMA API internal flow switiches from working
with decrypted to encrypted phys_addr_t.

If we can make that work then maybe the flows are designed correctly.

Jason

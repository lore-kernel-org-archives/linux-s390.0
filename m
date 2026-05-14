Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3973A961B
	for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769457; cv=none; b=gq9ye8rDjIweTlkYXAhiPk88v49C9NdyUNzlVCYxGTqQVsPrQ6YwPouq5EJTcRuSZeffF0Mitb0ABEjFkz9lX/yLGdIuE/neoDZvmFJlPCyBzG/iBQOoF7xlRRs6tGp8i2HJxufRFWO6FL6PEd2rGp8DhvVUw6VzinnkJJVK/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769457; c=relaxed/simple;
	bh=1R/nhGX8X+QrR70RUCgUXl+c5YpTnUwInBBh5eq6G2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU359j/YZHX0M8aP7qnIDuRgI/oJWVmbiyMdpdEAoXivUJjVs9e+PWLPntwKrDch82+VOl7xh3TXE4Prsvha6/z4EVBu00Pme+NzBKzfSU8C5ZX61DL50wodlJEEULxqAyPk6pBGBXF5Pgd5opBy8R8+EUajBjtAQ5O5kuwdjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cSc8k9w7; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cSc8k9w7"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b4000e51fdso81668646d6.1
        for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778769455; x=1779374255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKVmCu+Gb/QJi05GS/MUngbhCp2nJ8/F0kCLFA01DR8=;
        b=cSc8k9w7tEpbi8iOL8N+3t6eQFPffF84Fk+HyJ+WnZFcOHkzkL1DVNsTKbG0uUibL8
         HzzqF7SHLllGz0Eyink0ap9anZL6dUI8kngC7T490+dQ6ROtMsVMXEYQj206s2wL1Q0K
         /KNmHlRiNeyDysIfIUd0HxIxtNe5JRA+p+gfU9CotGOD/3v8hrOAHgQwli+MyPfEnYPO
         AB5hW5seKKdBfVS7fpr4y5kcb6N7MXEk07/IqyVgphtE6P/KWhNr42sKBjMJfePn0CzG
         yUjV2WYXU/HhxYhKzuebAVgexP7DaoK9XSGs5xCSQQzcqBvUMUQQfP+AftNE0uBLOaL7
         kRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769455; x=1779374255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKVmCu+Gb/QJi05GS/MUngbhCp2nJ8/F0kCLFA01DR8=;
        b=TOe/r5+2tMXP3BnDsFqCZirnLHcVaypiw66g/j8IxUohUoqz9P/smAVRWGpwB//z6j
         rm4csEhIT9RogAJm+7XuKq527+cMkt/VRHBHKWa+qq+0CBEm1B+u1z8uczTI+uIAOOhV
         G0RSyelbTNmuBJvxtyjo6xT/T57qYGuyYmK/EYr8hMCaZouROFQKGKoQYXrZ9bqLRnqL
         plg7zCfxd4XmRMyk/EfqJW5ZEKdDKa8DMFTxUjs3W3kwuq6UlKKXRdgFYNo0YjpWBi3Z
         qK6l/OzCbjodnsWWFBPMwbg24QUMOUGQsMdNzXsPwF3eyMP0m0EXU+6PjxbzUSZZad/r
         ualg==
X-Forwarded-Encrypted: i=1; AFNElJ9Qx/DJVXzyLUStaJ4Xk2C3Z55OJ9REVO1ZX0vfFplZmwAJZSd1coGjmxg35inMeo0+MmH2+KBDF0Mr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtfw+T3i9NkXvjJAR8a3tUUTXq3i9xHMV6wTwakfaAJTSWpIXN
	YlPEKlD1o6uqsupaEAC7KRvg6wM9PjvrNrWpSfNva8VQdlmrNROwCix3BOOCwZfSflU=
X-Gm-Gg: Acq92OGZIoaZ4SAPmfbFuE8ZyBiiiWK7dM+AizPCbS1i5S/Jcfij/VL+7VkRvrkZeq8
	VETWyADErvFeBsr8gREISguzucm3t5/fVDqYAdFZadpIJjd2yDk9a+0ugjaSEBhrh8lWOkvEy6n
	rQp19+kdlIMXevtmBUEHL3b7muPv6UP/9WgKLZAHZcV5duHooByTCxYxXcUeDhr5FfQ2LV0HAHz
	6yxVCWUmfd4RuHIbiro+YjNkbe7QYouu4LrIIE2jKOwWJtDT63nhOpZ+DzYeE+kN41pxOaemRKE
	AJU4XKv0tXEmrbx0400MLLH3T3pmJgNvoNemqzJSWZQKR9vUbvmBbizPmi9IuHfOOGVnYt8I7yF
	yYUayZbUlKaK6t7w0+l2X7Rk5Yg4SzzCjpuQOq3EgGElOTrFRvFCyQ8M15hd7Zh+pAJxdpGpRAV
	7CbR1jQsu712h2mNWWOSV2OscPlWrcnoxihIlsEZq0wQg7eeKrqFNAzq4kSUkgVt2mcy+dbOABn
	b9y7w==
X-Received: by 2002:a05:6214:55c6:b0:8ca:ee3:6e99 with SMTP id 6a1803df08f44-8ca0ee376b1mr2894306d6.44.1778769454659;
        Thu, 14 May 2026 07:37:34 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908e11929sm25017416d6.14.2026.05.14.07.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:37:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNXBt-00000005Lti-0CPB;
	Thu, 14 May 2026 11:37:33 -0300
Date: Thu, 14 May 2026 11:37:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260514143733.GB7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5apl2y5f96.fsf@kernel.org>

On Thu, May 14, 2026 at 06:18:05PM +0530, Aneesh Kumar K.V wrote:
> > There is no problem with non-protected guests as they don't use memory
> > encryption, my initial thought was that th encrpyted/decrypted is
> > per-pool property which is decided by FW (device-tree).
> 
> What I meant was that we need a generic way to identify a pKVM guest, so
> that we can use it in the conditional above.

If I understood Mostafa's remarks I think different devices in the
guest need shared/decrypted and some don't? Ie a virtio hypervisor
device needs shared while a real PCI device doesn't? Is that right?

In CC terms that would be a mixture of T=0 and T=1 devices hardwired
and signaled by firwmare..

Ideally we'd have a flow where if the arch precreates a swiotlb pool
with special parameters this overrides all other decision making. Then
this series is about making CC NOT use that flow... ??

Jason

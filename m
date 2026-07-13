Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923F357CF8
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971446; cv=none; b=MxvI35HllJOmcHSV5ekA7W60DWv6+JyJUmTy4jmYowz6bXSEA56G728PzSVqaOT56P5ccIZ/V+3p3ZneTQeVqaL+EkQ5F2nyWS+c2Mc/ozhknVFh4C9zKrI+DliibEV+98gIoMAF7tjkQ0/JKqfriQ6zE8dB3ghknvJBClIUufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971446; c=relaxed/simple;
	bh=Xsfi+SO6SJr84aSbkQrUqh5LTCvlYWMyrm0+dQckaBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHfH1F53ztGHofrN3Yj/A1cWY46dntH+hm9P8y8nNa7KcQASKNRO93aagFj4AqQ4hd2eEU5XTLheRyYmJm35MZN4yS9xxTWu4j2lgNopINaIWQpwkuosqc0sSgbDDtGBDGPHAsUk0ua9bi52yxUWymDr+cT07YC2wuYnAJpb71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bCH7thWk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bCH7thWk"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e85499ffbso20849785a.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971444; x=1784576244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=seRQ4x7WCVBDlRNvM1ESoBfWnXSVwL4ZPJ5Cc52Vq54=;
        b=bCH7thWkHUmHqjRoXeaBgsb3lecl0+IbVkKRPH4GzvVS4UZWsD+3865TdbqG8jpLSP
         SsjWB0DamBr1/ayp5/ZSi7hpGwSkHr35Xxk5Bn9hEraHpLp5mkDXoziSKuanF46obtot
         +6Qm8zvlRIGqaYAmemVVD0BPyR9dH7o9xnRrz8AFyl23uq6meFQ6kbW7nRgdUWJGuLLL
         J7qbilrsVdDj9QfFMcAQBUDhzU8VN1Yk24MGvwXFMWIZwlL4EFi0TUGoKf9o8eRbRIqV
         XF9Fxexa0xMZ6AsBI7tO525l7G3+5BPfasS86Q03YBqjqpUY/twzQg4xpUuXe2wIQPGX
         fsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971444; x=1784576244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seRQ4x7WCVBDlRNvM1ESoBfWnXSVwL4ZPJ5Cc52Vq54=;
        b=CB9qJj3lAu5ATVDOMGuuu2uTvSTDuaalYen3eC+TnXNa2PiIyZ74lRiIjrdYeN54pa
         di1V8RTRsJ8y4PYRhrk9vpk7cYw9fdAAoDJByAoD7qAPszL2WenKQo5QGOqPIjUVkvW8
         M8feKl1qinUOtFOx66YOJMFTj23lLu1cIzNMgG0lrP8LeO9Dg5aRH7ePSz1qzgRK/06l
         jcmYVIDmTnc6kn2FXDhsoaXjjbIuu/TO5BMRS/sTN5vt+I1i6rRfeCfunvZZeAECOdzy
         kTJCCZK3dGtEEqQ5L5Xd8SI9P/hclyvFvW0D41H1PnteM8oAJo/vgOJ0PC9iKFuCIRTG
         dtEg==
X-Forwarded-Encrypted: i=1; AHgh+Rpbjc1QTJcIKh0CZKr1wbwJFxAQTax5bbpHVqL4d5Xedyon1qCYi9qVLmky5qitAUp0ZWrE8IOmJBoS@vger.kernel.org
X-Gm-Message-State: AOJu0YzyMrbTY8BnR8E5KixgGsV0Kho2gmybq+VOe/9zsBmP/KtsdFIj
	qW4RNC/6qZJZB99VhfNsfogNTOIYKRffy5aOydZdPok0fADMBy49fcdaIeNZixYy/Vo=
X-Gm-Gg: AfdE7cl9TTMOct7ZoHhKJ7/1k6437RZ3J53Se++YUhQbg/0qDXQXsdsV+24kEX/Elk9
	uMWroaND8poNgl+6yxZ9/4+iqgjNZuxYydypc9hn6MNEz3gZ+OGwmdAnhExs4Z+KuIM8OZOLSsS
	2lkPFOnZLoXJYs7qn9aHxyYYxzPO/apV7JiIcspz7lvMY7GuDflFhSvlmZoh6fjP6vsV5Qp+W3w
	rSxlUvvqSay8Vl+leSQ1gIUp395+UMwU8OWUYgbXD3iQfGvUm3dpqPjaEvLR2hOrqcxPaFz74th
	QNROI6xHgXJGRj9nmL1oNzS8EWwgD7KreCQvgqLdHqxJ8olGjb/6XVe0Nkt2vW01RFOjKKDRoX1
	Aq0hIGI1uwAVCmELrmAOoj4SkD8TO8iGBiT9e6dU2NnQmhIJKhjERrnIwC465LWLI748cvZs=
X-Received: by 2002:a05:620a:2551:b0:915:5930:94e6 with SMTP id af79cd13be357-92ef2bcc91emr1112783085a.51.1783971443832;
        Mon, 13 Jul 2026 12:37:23 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm1177578085a.11.2026.07.13.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMSw-0000000E6Rs-2gqS;
	Mon, 13 Jul 2026 16:37:22 -0300
Date: Mon, 13 Jul 2026 16:37:22 -0300
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
Subject: Re: [PATCH v7 17/22] dma-direct: set decrypted flag for remapped DMA
 allocations
Message-ID: <20260713193722.GW3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-18-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-18-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:21AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Devices that are DMA non-coherent and require a remap were skipping
> dma_set_decrypted(), leaving DMA buffers encrypted even when the device
> requires unencrypted access. Move the call after the if (remap) branch
> so that both the direct and remapped allocation paths correctly mark the
> allocation as decrypted (or fail cleanly) before use.
> 
> Fix dma_direct_alloc() and dma_direct_free() to apply set_memory_*() to the
> linear-map alias of the backing pages instead of the remapped CPU address.
> Also disallow highmem pages for __DMA_ATTR_ALLOC_CC_SHARED, because highmem
> buffers do not provide a usable linear-map address.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 56 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

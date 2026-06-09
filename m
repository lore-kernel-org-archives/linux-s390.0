Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465B33F599
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014554; cv=none; b=fPrEVLb292vNK+0qp+CtmTB7nxk5HXJUwLTe5Ge9AGgeZn+DEwMMIqv4hTJZ5AfyxNiYiqzwE+blkWiuXkCLq5vMTnhsBA7RaUpSCJIdeRgNjGbfRyLqRrRnFFPWm1CGtIjQPmJIf9+bPPIB42mus8PqbG76+6H9895hgd21Q9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014554; c=relaxed/simple;
	bh=MmkUJTtuyXY3s/7sXM+BP/PzWFzsXVq+eKe6PElRRWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uglIWKDbIT7mEAy5LGe63Kiej0SlRR4tDAyckMQNfGsSomDSwXJb4Bss5ObOY6HKCzBY7qc5q2LnYq0NudMUdtzr2YgSwPgHkW7bpgS8hI5wP9VKXD56Rm2l77rHRca0f0bHzPm9yi5PQzW2PlP1LBzxE3WJtxMOsOz1PkKR1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aaM+VksD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aaM+VksD"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ce9df31130so87736086d6.1
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781014552; x=1781619352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
        b=aaM+VksD81FwB9qeScW7Sviahb1dkjb/ysJ4WiEyEGLyTs0Z6cGucYu+dxVqbdpXRi
         f8gbU9i+o6e3FfWrmod8ExT89VcRLxM2HRnfSfDDzhaduA3uN4cR4Vd0tWpLyYtguRHR
         boHXaNm4jeKhWgSqym8XL+I7kQxM37q/Hctx7UNd9wCj0vbFATeAYasZ+qkq4WEdzXHH
         5xdTUaUOLnZKWZG0z4Tu/QKNDdjdQT+oR74Il5Vmx3mmgs58Be40v5pIqu6YzMnzzInY
         hjSMgGOfFHBJocJUiljwGsMNozPcr0jeQdE6Q2PLAcQtj/hi+jwCnC0dTaLYm+rkFccJ
         VYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014552; x=1781619352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
        b=D/Kh4cMBSs6HkxHq93Fsmn2Wh/m1NNXltySWo8NBI90c2Bwkz05wG+7XUPp5+2EVvM
         wdvlmaR5Cv49KnarK+88JDk/9les0Rs3igCDDpAQJPKzU7ArxXRTG2g09ylGVQfOyipW
         GywKH4h+Oilm9BgfR9C1gv1Bq7YHVuLIOVHA2VAVMo89oyct15fN3wQcccL8d3kri295
         XKyhED+PQZ67+NIon04EU9qeN26rt5nM/gjn1C5+QWFi+tYcp+GNeEXh/vfHAIWM7yDn
         O9vdVdPTUX1N0k/Ep3ST+rkCCfu+6spiNxllpTPmJsTbdSDMkcY4wDYsFIRumrrf/DiD
         iM6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9waFie/g7U3JThVklkrBWVWDIaGRvsY9lSDydBKHYfmOYwV7CDzXlgk34KFy7KLZJ4CsaaWVYjRByk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fhNNhzCOkrudzBVZ9geDOOo8KLb8uLuzIcBvwyt7yJA8mgyD
	9PNRGT9V/xQIEv5Gd+Dp6smfBGqtc3qFJAFhinsHV4WX4MXUhBsJAtg9dfWm5xCy1rU=
X-Gm-Gg: Acq92OGl4AZr0iS7PPZ9uWk8vdHUxa8LLyEDaBqYK/9lAaJ8kXY4YZR4rr2i5Gdxn9o
	JMhy3qsiOtNl7OdiL2wrDJwwIUsqBJPHfneGEsJTVddopIggEhqyDf3KucJjqQkAM7hK4XJ1GRZ
	WlVRYLioyoJP+V2qV5DIYNZlhimP5LWuOyyQ9flPWJeptTPKX+7GsUIyhFHOcJSERBFnG0r19ut
	iaoIKs8gZIfKXHdJXL9Fw0K1u3jKi6PnrCNMSzrK+BJr2oUxib2AQDY+ybATy2UAOaQIr6R6NEt
	xv4lxMeCEkhvjSuDSBcswDf2eNczBq7WXqsZ6agGly7zk2kVY9lwFSY2wahrivkzFCAW+UipUYU
	1M1MUWyNEzQ/ydnRTpNGSIC7z5ygVWJLnOisVTYLajSifHr1bQ+1buYegUY98n0WBZuKuHy9POj
	68TSr6jdAbgDyBSDjid5BR7yUWvMMLtgbRBmZcXt7q987FxpgQC7QKCbtJm/ASLSYsrN2FWiZod
	CkjMe8Ys5jOwjNQ
X-Received: by 2002:a05:6214:626:b0:8ce:ba04:7bc2 with SMTP id 6a1803df08f44-8cee626f0eamr293032506d6.38.1781014535341;
        Tue, 09 Jun 2026 07:15:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd077be8sm204702746d6.40.2026.06.09.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:15:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWxEs-000000021xL-0mOX;
	Tue, 09 Jun 2026 11:15:34 -0300
Date: Tue, 9 Jun 2026 11:15:34 -0300
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
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 14/20] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260609141534.GJ2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-15-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604083959.1265923-15-aneesh.kumar@kernel.org>

On Thu, Jun 04, 2026 at 02:09:53PM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -270,9 +270,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
>  	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
> -	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +	    dma_direct_use_pool(dev, gfp)) {
> +		page = dma_direct_alloc_from_pool(dev, size,
> +					dma_handle, &cpu_addr,
> +					gfp, attrs);
> +		return page ? cpu_addr : NULL;
> +	}

You should probably put this at the start of the series so it can be
backported

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

To Petr's question I think this just shows nobody is really stressing
the PCI dma paths on CC VMs today.

	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);

For instance the places even calling dma_alloc_pages() don't look like
things people would use in a CC VM.

Jason

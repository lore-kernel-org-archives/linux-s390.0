Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D1339B41
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970894; cv=none; b=ubtOP3ZLTyx9fZR4BYpOWR4Mlurwm333b+nxgn9u82ohmO1fdssPtKG4SN4jIhlH+cnqRcM6jfa3ohSGrG//TdQ4ONb9p4DZruIzsnYbPaH/sk7zm101MNAgVEniNvoCoVprAdo0dv8E4RAS5QzkVNeiBDg7vQ8MBY/bL9YNb5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970894; c=relaxed/simple;
	bh=ASIpMrAC+mByzdrQ5Zb07sCc54XQ+GfbRmFG4npeTmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc5njmi3y5v/op6DJZjNxQTHCFpVro6A94RG0FxYHw1citdm+dW6Gidjbbvg7e05OjWj6iK+v2w3Xqbw7q5yAxbl/hHmONAslEVYklZblle+MZcKjOXLo13sdEds9bkDQVRZy/JwcUCx6zd+qGXLtd1+VIvHRWvqaD32Avo2g1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WHMm3xl0; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WHMm3xl0"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92f03daaa97so152973585a.2
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970892; x=1784575692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bN9JaggjBtthcoIhUPMeMbFxrz5q2FPyWPTtAmvW2io=;
        b=WHMm3xl0bfF+6we+O3I8RDBnwPoqhwvWCDx6SYH6YsEn+9eFj6XwmjkmCCm/Oje8fs
         w0B5Br1elU/IQnGR8b27F54Asy7uVPSBt3vydN6pjqiAnNDsTXBxQopaIhnwXxcLUDwD
         XrR3Ttdwb72bM2MXqb3EJIBcKUCxZdo3ALsU+MrYBGV7uNFfCMGaG6uv9DU9vhJKkXeu
         x5EuSuF+iaiLDPvjQPhxdLNOEVaz09F5HxhQAn4DSuaztbBw08vnMBzrhLvuM71jsmRo
         dVDR9l9u8KDDaTjDi2APfvJtRnI9onbX/qAi9ZCjgVMAxsGpKNAn08iinXjnj2N3Qnu9
         Wqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970892; x=1784575692;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bN9JaggjBtthcoIhUPMeMbFxrz5q2FPyWPTtAmvW2io=;
        b=qoaXk+DJ71q0eVGlbABYwzGWc5dpVs/rTE1CIASsNafgQrz5jFTYqDlKQ2XwWfVO8W
         YTOPKiRllHHJJs5ZAWhky3vYvzk1W7ZgJm75msZny4K3NqW312kocwBjpDS9RnpBT7zS
         JI/uImKhc+OvrWEY7MITKz30N+hM4+Uh1PnhsnIKmWG5csUHw15iMRlkyLb5jrjJNH1W
         7ViyKy9NRiZmKh3vEvIHhx3SlQ5yrCvnq9h4Et3Y+AVVJ3s60mNjvk0Q2DLExVu09qQH
         Tap7Fyepla3+m6c/5hBTG3nhMpZXL6Fg7VSsU+kAfCraHIi9afbHpIqwU3XyUNR67O5u
         6F2g==
X-Forwarded-Encrypted: i=1; AHgh+RoBYTff648nWKlYIIhGLHNkH0AJsfn1T9Ix7DYKjwH2etah2ei3753pL+y0uKSKpQz98OUlNS1w8zcH@vger.kernel.org
X-Gm-Message-State: AOJu0YyfrmijslsEVU8cymD9y79ch9x0+EQuvu9tFBTNE65GiXuYRVcY
	q6KXGokyrWR0ARrtpo9fl3ACXDRIBYxNn0i28gfkgtGE2Tq5XVYtVz+kUvPlXBjEVzc=
X-Gm-Gg: AfdE7ckJCzNQrfgqbwEI/ia+7D+cpMOy6C7cwpBUFkxO5jFwHnqqMShGqfDzYfSEWjc
	5DKVMZAEtgTSd0JoD3S1wvnRANl35ZD3QFmRcdFYc61W1Z2zKh0SK8cXp7ER3y87KKsz2o+BuVq
	imPn/CEt+jw6qXHjFM5u1vVLesV0vhPKpB2Pfx8z/LtLwCv7duPT7GD2IqMKVvJbaWluuUeyZGJ
	kDNAIOIHC8omuP/uYU2h7L4ZoCVTqXdBy5vG+YfNIIExKKDFXP+FmcNIcDHQbNLO7zMwiaeZKiO
	qYByqY8rAMnzA8boHZdIgBa+OZKh06afTge0BPRnAmbcwNAPwWQIC47ZrOhbscTj2BJa/zpy4xk
	23SWd1J2aS/MbDwvqQnXll5cpd1tve/vgHW5QvGYJGDB80YPOhYxbxCLWhepiYR5++Z4JjYs=
X-Received: by 2002:a05:620a:2616:b0:92e:4a4a:4478 with SMTP id af79cd13be357-92ef2b55ebbmr1041396385a.31.1783970891864;
        Mon, 13 Jul 2026 12:28:11 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm137804776d6.21.2026.07.13.12.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:28:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMK0-0000000E5Zr-4AHb;
	Mon, 13 Jul 2026 16:28:09 -0300
Date: Mon, 13 Jul 2026 16:28:08 -0300
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
Subject: Re: [PATCH v7 15/22] dma-direct: pass attrs to dma_capable() for
 DMA_ATTR_CC_SHARED checks
Message-ID: <20260713192808.GU3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-16-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-16-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:19AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Teach dma_capable() about DMA_ATTR_CC_SHARED so the capability
> check can reject encrypted DMA addresses for devices that require
> unencrypted/shared DMA.
> 
> Also propagate DMA_ATTR_CC_SHARED in swiotlb_map() when the selected
> SWIOTLB pool is decrypted so the capability check sees the correct DMA
> address attribute.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/x86/kernel/amd_gart_64.c | 30 ++++++++++++++++--------------
>  drivers/xen/swiotlb-xen.c     |  6 +++---
>  include/linux/dma-direct.h    | 10 +++++++++-
>  kernel/dma/direct.h           |  6 +++---
>  kernel/dma/swiotlb.c          |  2 +-
>  5 files changed, 32 insertions(+), 22 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

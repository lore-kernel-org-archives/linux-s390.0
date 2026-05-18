Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E033E2AB8
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093307; cv=none; b=fCK+uY90fyW7zCyy5wO+KJPa2aEec+AJQKyvw7C/3YxQi4M1kEqk3+IKS29I6qctIoEpk9Hj2EgbBhIhQc7zePNZs9QZzEqdwJIzd2AczPelWm9FwwiOe3nfEj0UMuKRT/45Em5IFs2TWOiNkpNyGxTZu8ex9QiSjKPJ0iuCedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093307; c=relaxed/simple;
	bh=KwzE4WvS1tturD3icBf4rnhXP8uxns5EKACf2ikgZYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkvUxQ7hgiiDIzI5UU/RQpjVoxP7GrYZRrCSkRIitJUYt906T42qOggBo/LPBsOnX8gioHhexEUfCrbWbjCmg1Nv8QKljWUeqCpwIYpMfdX6WQxSd19cP55ubm9UC+2OIKPY7gfZFYgNt3IfLPjATjU/wLgjRKzEd85MPlSrCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=P5LYrqNL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="P5LYrqNL"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so617470f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779093302; x=1779698102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwzE4WvS1tturD3icBf4rnhXP8uxns5EKACf2ikgZYY=;
        b=P5LYrqNL7XtdbUGcOrnWpRhqpUNEvJXcZ33kH0AJpR2Rnf5DrN6RupVyo8952XYSxO
         E2doM/aYPY9YgaiXSJin+IqExw2UFgnZas5MuXU+7rPkvF/rZJbflUAgrjkO9s5d9ZCl
         tY92tlEGjBSUDwzvqsTbHQ9HA6ABqjfviANHzZx/LoWX+XVUBDtwMBNEgVyiBLouVB1U
         XC4fAE93fgn0FqpavSwzx6a3A96FFNWjdPekMJRTV8uE0BkJ1nJ4IRkgaEesWbFo9Zr9
         WvNUi0ynIrjOZl0RL3pIkGEP7sFQdTPyGOui2gZt7KKyOQIQLcVkPJod6VZQdT1NJGwz
         Kvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779093302; x=1779698102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwzE4WvS1tturD3icBf4rnhXP8uxns5EKACf2ikgZYY=;
        b=GCLbizLlIzgQYVEKtI1Wq2NvA3hgLS8n1tz+QZ05RZ6iy1I1Eq2qCAx0yosndGPeMm
         YGjSURBfm0tbB1XKUIZ9eaMM0YHc99IGcoASDQNOB3eyxZNqLB6f97xereo57vMfdsJC
         hAsW74+PVA0bSyp+nlT2ymxd6J+aBGrCCN6qHi+kF4koXaKQ9aQDyhi1oJ/Azpx0W7gW
         sW/rt9O/+ZWwfXAcj1UhqDglqKI/HsDMTH7qWPOVVZrb0f8jCsJg8Gl9qbgrCfDbfsqW
         hi6tqbBUnJjuiBrVzD5e58s1MPSpl8RRa4LnWUmIz6igiNCaA30XRL1phPSLu0NUVQiD
         2jAg==
X-Forwarded-Encrypted: i=1; AFNElJ8be/x04UZOJvJMW/chPwohuiUr/fg0xjXOG70QQOzl1/Eb6XjdQ3jkp+2dazwCs5dHhPlBU4C++7vW@vger.kernel.org
X-Gm-Message-State: AOJu0YypWteKInM3aISJLvEen7sx+Wbdq7g9UO3Ed+Go/mSUMDl66dXw
	KuxCxX1M70h9kwHTzagIBnAQaVPDSSJs14SfsOcLZk27CRVXuV7E8my5KejIjcrk65I=
X-Gm-Gg: Acq92OEjcjHdaUlbROqWmcnxRGiC5dp9+s7uMv2/9zfSw+tbDOlZsX4R3MqYIio1/6O
	dbe1ymrM0Ba3tl9t77wnr8N84S1Oi+c/8HlHIxEKqz1VNxmpBVHskKIvu0j31H5VUPFUHxNEqjf
	iUwDwbEnyK/i23yi8bWYrZwUHoxVHThJwZmCzeZMAzcTqHgeiHqn6evau4EePVKL5CSLbYlbHFy
	XQzBun5aCKW+6msIgcp/QfbBBYlM1DkKH51NtgLwKLJ4WDMXXwpvExcENh3il6ApVlzPSMPYvFl
	da7N7me3U9NI6aA7OwWhEpaGTLB58R16DRRWKbNhEMPxMW1uzeL3XGRxMPUBf3XMdt+p+hcDXr8
	csxj8AOKM4otxk4Em7XFTTA0b+gjFFqFi2nIj8vKFRwg4vYVYS8d+7VaOHo1/8Dhtywxy2KJPD6
	JBtBZ6C3rtx1G5sScykocvYQKbvol3NJQ3FlYsyYvBONJy
X-Received: by 2002:a05:6000:2083:b0:43f:ea04:dcc7 with SMTP id ffacd0b85a97d-45e5c5f277emr23023553f8f.24.1779093301850;
        Mon, 18 May 2026 01:35:01 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm35354787f8f.37.2026.05.18.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:35:01 -0700 (PDT)
Date: Mon, 18 May 2026 10:34:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Mostafa Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 00/13] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <agrPHNClrdRvzOFI@FV6GYCPJ69>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <agldl4XQLKAtyLty@FV6GYCPJ69>
 <yq5amrxxxh0h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5amrxxxh0h.fsf@kernel.org>

Mon, May 18, 2026 at 10:23:58AM +0200, aneesh.kumar@kernel.org wrote:
>Jiri Pirko <jiri@resnulli.us> writes:
>
>> Tue, May 12, 2026 at 11:03:55AM +0200, aneesh.kumar@kernel.org wrote:
>>>This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>>>dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>>>are handled consistently.
>>>
>>>Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>>shared/decrypted buffer handling. This series consolidates the
>>>force_dma_unencrypted() checks in the top-level functions and ensures
>>>that the remaining DMA interfaces use DMA attributes to make the correct
>>>decisions.
>>
>> FWIW, the patchset in general looks good to me. I tested this with my
>> system_cc_shared dmabuf flow, works flawlessly.
>>
>> Thanks!
>>
>Thanks, Can I add
>
>Tested-by: Jiri Pirko <jiri@resnulli.us>

Tested-by: Jiri Pirko <jiri@nvidia.com>

Thanks.

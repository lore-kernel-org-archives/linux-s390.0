Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184A3F9F2F
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750355; cv=none; b=c8OsIZSaGIvqdjlKNO6WmE6YjTMnlRnFlf/b698JYQUOrEodqHGuugMTgBCRtrWlfndxiN+5Zuzl+YPl5hk9Fhu2BGytM50l6N8WqPWOCSSA34ylcsNFd+RRCCeAfcANGn8PbF2zo1t3ksdX25MNjHRR6bAV6s0lsRSC8ttE85I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750355; c=relaxed/simple;
	bh=QzKGPAMMMcYp8C3yznRY+b0+buzB7XKjOZxs2Zi0vAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmKpyGPOTGdNKz5Z1OsX1vJNvlHvIjUbxC6bXoAn9P9o0Gq8Wwm2oO9CTOkhO2HE4P+IHBw2BCoYCKV7Mx5Qi7bvqsH7VzFY3pkyX/mLEwOCCb8by98C0z2UKj2wHh5yFXphsmhJui9X3LE6+7sBM0nkmmGs5EcZfe0koaw2MY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eBukXR/E; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eBukXR/E"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e041ea211so10836894a91.0
        for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784750353; x=1785355153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EEIQnXJI41GVGpHCEj7IDcqZ+AmiiYPwRk5ZlYk7rZE=;
        b=eBukXR/EsjSSPdjGAt6oue4EPdv626XfkH8m3FKgn91ujkV/y6GptDL2sICWDF0t8d
         OntmcgG0cUrI17tvqqFVW+eeoxJraybSXYIT0sqsovZGBTg0PmzHOZERuYqJdEn8Yd25
         Py0s55El45+7/jSvGkGe14TnCIKksIn8caOC5LhFx1nZTPN3rYsWpmYzBkKd++ByaX2o
         eVCuw7zH4an6RUQQAd6wEhPl4RhdMbeqTrxhL9ovkZG7BY+nHqfsX8kg64D0gcXVEb2e
         AeDvBD6HWk2jCO7wDKD4+Q0jSjJJDww2a1imWAyC3W1tGOcmx+LClRZY/Mpip3AbEiR9
         BQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750353; x=1785355153;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EEIQnXJI41GVGpHCEj7IDcqZ+AmiiYPwRk5ZlYk7rZE=;
        b=qYtejB8ivore9ckeTIJ4LT3YOym2EfYUttwrsBjG83xpyejAuuN1rbBRl6n0PcqUX6
         CGBErMsDikcJYLfEisb4p3An6yqJBtiTs+XntDgZLwlIisvYThbBRn/gwbzOIaxMyk09
         yS9LwzQ2QRJPKDqS6zb5V/rFqFmzWqXEohI7gO+cImJoOqP92Un3YpBy0uXRiZYJqJ5P
         U3h393s/gJ3ogZczHRP+V6sE/YvOpAFKZUKM4/+Kzv2IQyeTfIS020kmsjLc+QlCD03P
         jwOhvI+0ZRRFdvYJMTQ7eB/XYFhqASPB/rtxTa/tJPxImDZQ3DFTX4sbpID1DkXWRrUC
         tBaA==
X-Forwarded-Encrypted: i=1; AHgh+RpY5QM1CRY7vnxCQWHzkfm3RoIxEltEQm9nnvjX3OgHYxlGrbPbbZHeRzbP4dPcZB5zeDuI25Q67uMn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+KkKClNi78vbjYRYusQZYsnLZxSnk0ZjCS6pQO4dTzyB4he/y
	9kOuEXRF24I1jsOHkUXcWy05ir7KOuXdfw2L7WUZN1DKF+PxXZN06PMaPbXn+RfsRTs=
X-Gm-Gg: AR+sD11198ZDDGu9vSAjnfA1CEHnuEBQI7lrJlzONteOx4o5glzoffHkwReA8QX6QxO
	x7vyuTEat9ERzahQyVVaKSh3CHweOgYMiKGc+t/FH8JQUN+OP4vWCK+NR3v7tYO6yecNRmR5WVv
	8zEZNH5K6v6W5SbSFTn1e+kdeU6GXtudcgbbCj40SBnNCCXpve0mg0LsvSDBiLZsFdH6MUlH7CF
	TQX5xCcLPHBQZFVFfVX+gL0XWpSqVnmV19p/5tifKW1rsWM7miLMcQb2ePvJk+n9fZUqoFIi7PL
	SDbwvrJRVjj6KiYULKbOaSvX7lXZvl8qxfh5m9jZI32toBwIbRNMbnvzJgIiUQwx3ToZtLFMB9a
	BMwN0fV5qpJ+pJ/eJlxpi7pEeOrxU4mm4bhTxfVICCC7nBnoaWB2N
X-Received: by 2002:a17:90b:28c5:b0:38e:7080:b4c0 with SMTP id 98e67ed59e1d1-38ec6979bc6mr98413a91.10.1784750353408;
        Wed, 22 Jul 2026 12:59:13 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm14809771c88.2.2026.07.22.12.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:59:12 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wmd60-000000002O0-1hvF;
	Wed, 22 Jul 2026 16:59:12 -0300
Date: Wed, 22 Jul 2026 16:59:12 -0300
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
Message-ID: <amEhEKQW0_HJ9cLN@ziepe.ca>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721153321.GO110966@unreal>

On Tue, Jul 21, 2026 at 06:33:21PM +0300, Leon Romanovsky wrote:

> Something like, but probably void* needs to be phys_addr_t:
> 
> static inline struct page *dma_phys_to_page(void *addr)
> {
> #ifdef CONFIG_DMA_DIRECT_REMAP
> 	return vmalloc_to_page(addr);
> #else
> 	return virt_to_page(addr);
> #endif
> }

I don't like this, we don't know for sure the addr will be in a vmap
and this will fail if it isn't.

Jason

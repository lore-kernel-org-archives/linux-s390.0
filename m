Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4349242D89
	for <linux-s390@vger.kernel.org>; Sun, 17 May 2026 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778998784; cv=none; b=FB5K78UoWTJnYSGIJxSbP6chHiycnobZND9bkW4IzE4smEKwtJyLBYlndDDF9VSLKf3sIaBRG6kgBM0W4CXrhqh+48EZcGhHym42rAp68frpIlaR01OTVAPXytVl6j6linMcaM4B7kIFgtpoQ8NEvywIMl3jH/KQ5Qpux+2f2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778998784; c=relaxed/simple;
	bh=qUI1Kvy8G4UZN8XVWU9+FHDr0P4yKt9TWkL45QXTVdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqXY2z2h92Q9QhkY1Gp93RRVRzRWChb6YskwIVTp5XI5Is2c5qLExvqKhbbW0enrXKcg8KyENDHn/pR/tv0xvfkOmKbgcesMzKMxbrMqLFTX8u4ouRRe8Tl31PO5RSXf+md2aAAbYwGsCoX0aiy/KXSavA7+mGnAQSTheEKX7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=AIYIR9mX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="AIYIR9mX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso8849375e9.0
        for <linux-s390@vger.kernel.org>; Sat, 16 May 2026 23:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778998781; x=1779603581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUI1Kvy8G4UZN8XVWU9+FHDr0P4yKt9TWkL45QXTVdc=;
        b=AIYIR9mXMpSfjxuk16yMwjcVQz2F989QSFq7LRXAZo00x2h7wG/KmqMvsGRgbxyOCY
         XyBfaqNN/qYmGx0X6PD8qgAcbzpKe5rDMqvAaLP9b52t46l4ivpSNwTdsNzMH6Jz43EK
         JR4AfgaDkS7IWkFJfdcVbRb4Zlk57/uU9KrDQxU3KaQpQnbGJ9zF1ed2jPB+cpwQK8Bc
         oVXNKcDSwHDWTEbhOK2wzvKFnu42wolqK6ZhADhU6inYYnuiCx9U5iH0xRNrpOv45+FV
         UnJtz1ydDnG3JQ24l7sAWGZFp358fnJ+0bfngWZv06JOG8BTjSYk9zfwjIXzErQ4AoGG
         vHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778998781; x=1779603581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUI1Kvy8G4UZN8XVWU9+FHDr0P4yKt9TWkL45QXTVdc=;
        b=pDZinmhxZTfGqC1TTZ/88k6tGTDqcSqZfxaLRozVvl2YzlrNLzBZY2H/CfCETUYaGP
         +mIPN9zNBx0AO4JhSYA9Iz/6FOfmV0BsFPojpdMFNcGmXms2aKkq1/uwMGm8zLIdUuDD
         iGn4tiG+NgIXCqs+FtTsnKpba+G8lPaqhVMV8PrEk+Bhx3bvPmaVcvD1fpAVZXglzvKb
         WF3hJwwVWb6emZqVfs4L5Ahz6JBwgQLiGtaT5nimsI/05+XjWprRjGOhGF6Tohp3uYs5
         WHQ7mT78OK2K6bQI2DC+NJBel+LTW+lJT+DZd0hd20ogVkh/uGuuE0Aqog7M3Cj55GCE
         AnWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+p5g4mgI8bgFDyB/ZIZitkwMh/PqqYA6/3WmFdFAtyQpP+e2OArbnGijJ7iKjcbhnmk6vsr6IbXIV0@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDZ6C9UPxVila6d7wIB9kui8c4A9qSrz1tpraruvOThsnA6jd
	/+73t6M/wZh1lCxQUOahw4Z/tfAe/+svxY35PDrXuUrc2XCS41XlAjL5/wqGVoqG9u4=
X-Gm-Gg: Acq92OFGxavDyJrFWnaoA+wcX6zPuRI532Y6u9YGq7EOvsMxYJ4JIi6vrMeuaoPIyzP
	cDKUYG1HHCpEWt8g02dpgdoHW8xjIUNyQz2fDJ40mkiHuv+GbaHzJzL/WaNL888YmLJcRiFy4dV
	HTAewfmsIjSG1qgWOuvd3COZydTc5L87NRczq13sTtUhvjtJ26r6KJI7u3KJb+Y8IjLCUxkz3Vl
	zhhcMGhA23ixOpdzpPXDCkxDoCZVPo+bYMPl97PhAeBdUnkabYEjtqYDrgXeXfFRwveLonqMxEe
	kBux9VRGt1NeqX6gs3UWsX32mUw3HUQvEW+7dGGAVqsMr+IqrCVPXP4f5y3jzMW9CLkWHN1phpq
	73LiCtg2XIiMuna0/yuOzBp2BuY91fzHbyQkvHsNhA717hyy6M7ZhwI0ygTZod1rdIG5ykuwLu2
	x3i3sP4RX3C7SLNqW4ZG7LLGC7UVc6qQncAIAd/+N7vwS+CA==
X-Received: by 2002:a05:600c:a30a:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48fe5fda35fmr111967805e9.8.1778998781051;
        Sat, 16 May 2026 23:19:41 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm163535945e9.12.2026.05.16.23.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:19:39 -0700 (PDT)
Date: Sun, 17 May 2026 08:19:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
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
Message-ID: <agldl4XQLKAtyLty@FV6GYCPJ69>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512090408.794195-1-aneesh.kumar@kernel.org>

Tue, May 12, 2026 at 11:03:55AM +0200, aneesh.kumar@kernel.org wrote:
>This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>are handled consistently.
>
>Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>shared/decrypted buffer handling. This series consolidates the
>force_dma_unencrypted() checks in the top-level functions and ensures
>that the remaining DMA interfaces use DMA attributes to make the correct
>decisions.

FWIW, the patchset in general looks good to me. I tested this with my
system_cc_shared dmabuf flow, works flawlessly.

Thanks!

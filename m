Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17541411C8
	for <linux-s390@vger.kernel.org>; Mon, 12 Aug 2024 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723442097; cv=none; b=EzzRUZAymYwwMo2CwF0/pMPLOVcBkBqV0i5IxGj9VYxiMW4QiMAUsKyq7zKIP1GBNNaXRHYAtLAQfHLQWd8Y1h1kp6eBeVr2jHaYfEMnNnKM5mrg/DTopcqpCKWMZgygmlBbZocTkvvuyw00EKES5f/IWbWKd8zn9EoKiQLnloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723442097; c=relaxed/simple;
	bh=OWFPyLk9qijbZylrTVEw9W4riew8091W+ugBuLpyJX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTrsJhTi7VcJgf4d74R6D0Xf107fh+V/a8LUmXQsbqz0L8p9DZ8H9jlNlb/0cWRKeFVGeKkCW0WHHcDIMqjOAV3URAVfEoplzY5IVlxNW3g8211VgujGwFttN8auh8H9pRHDXAefdi4nmfCAtm12R51gGEXD8TJsith6zKHSGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gl0JoiON; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gl0JoiON"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so632344066b.0
        for <linux-s390@vger.kernel.org>; Sun, 11 Aug 2024 22:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723442094; x=1724046894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYo1INLOq156Qw62vGRe5A8jAlkKQVGuSnU9/QE+v7o=;
        b=gl0JoiON1v9v+nIw8JNCQy4vLykplCIULMoKTkzHMhv+fMjNfkfhPGfz7Q4IzoQVco
         9lSWmObcE8S60AbfaLgPuPx1OctfH0mSRveqw1rZyJzXnx8mPBeqqRIvWE10kFNk9YEU
         MG2CYT8C3JRCnn4RfRkHyuSNztBAcu3U6x2OHCZPIxfhAVnB84luzeGY3BuEs1dd7ATZ
         worLgQvaq/4AX3xDkA5GSI6ncxb/ZSWItQZaYqDvxWypU/blHr3ZwMMXkt1d0goEd38y
         DY7QrwAGKSXmh3ujrGdOLEtP1+3bTfgsiS4cXqYT6JOOHTpPf+97N7vsGcDuyKvZ2Ghv
         iivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723442094; x=1724046894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYo1INLOq156Qw62vGRe5A8jAlkKQVGuSnU9/QE+v7o=;
        b=grNpBEMlc+l+nwnpV3Y2cK3gozRQ10eBIY/ODVZffZXIRgVReb++sZpOvs14Zy1M1V
         JTQ6roX4dyoA3d2B+4DBMQ24kwW/EQKE2AzzPdVwydYtkTRLFGyEqMvkfS4vChBbVJC7
         WFMeL/KiJ7jEafz1hHxfd3QVLEnRafPLvEaGoxpSUsFlwdwSLFKzMxMCMMHMU58+pzip
         jQgeiCtdcq4LhViimxVxRBgQ7oevdF6z0W7MOgfsOFQD11b+Hu3vdU17IXTClH5PevUs
         Cr6ei7QAOVzqCv1qWRpLx7wcxr+MtH2vnn1GRROi52oyB0klqCxi84o4gKHjMfQ6/YBi
         J0uA==
X-Forwarded-Encrypted: i=1; AJvYcCWfjP/8t6cTZE0vp4f71mlGo0gF3+XMQVaf6FRVeMVA/POjBkkwfOsdWqXji1JYrfcRHRt6cFjYFzBgrMjnsq+7v+r6mTnQ/yrrpA==
X-Gm-Message-State: AOJu0YxC/uisusvfgc271KqCP+RSBlZz0vyazbhR0U9yYnOOQ8ZazEt5
	ZIU6XIlhJcN9vc6o2fN7M1+PcZYRhmSwU9FHeavwZKL5Rft1sWRTp7crfZa+hR8=
X-Google-Smtp-Source: AGHT+IEWJlWulwINR2mvPDA0F+GzST96BiyVI1VBUqXaw2VqDuwlnso7Bu+sdLf7W/E58YfrQZmfvQ==
X-Received: by 2002:a17:906:478a:b0:a73:9037:fdf5 with SMTP id a640c23a62f3a-a80ab75a8d2mr689304566b.6.1723442094028;
        Sun, 11 Aug 2024 22:54:54 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb243d78sm198422366b.224.2024.08.11.22.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 22:54:53 -0700 (PDT)
Date: Mon, 12 Aug 2024 07:54:52 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Ramon Fried <ramon@neureality.ai>, Elad Nachman
 <enachman@marvell.com>, Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v6 RESED 2/2] arm64: support DMA zone above 4GB
Message-ID: <20240812075452.4ef3eef5@mordecai.tesarici.cz>
In-Reply-To: <70d2c447b6dbf472b8e7fec5804deddc12692aab.1723359916.git.baruch@tkos.co.il>
References: <cover.1723359916.git.baruch@tkos.co.il>
	<70d2c447b6dbf472b8e7fec5804deddc12692aab.1723359916.git.baruch@tkos.co.il>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 10:09:36 +0300
Baruch Siach <baruch@tkos.co.il> wrote:

> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Commit 791ab8b2e3db ("arm64: Ignore any DMA offsets in the
> max_zone_phys() calculation") made arm64 DMA/DMA32 zones span the entire
> RAM when RAM starts above 32-bits. This breaks hardware with DMA area
> that start above 32-bits. But the commit log says that "we haven't
> noticed any such hardware". It turns out that such hardware does exist.
> 
> One such platform has RAM starting at 32GB with an internal bus that has
> the following DMA limits:
> 
>   #address-cells = <2>;
>   #size-cells = <2>;
>   dma-ranges = <0x00 0xc0000000 0x08 0x00000000 0x00 0x40000000>;
> 
> That is, devices under this bus see 1GB of DMA range between 3GB-4GB in
> their address space. This range is mapped to CPU memory at 32GB-33GB.
> With current code DMA allocations for devices under this bus are not
> limited to DMA area, leading to run-time allocation failure.
> 
> This commit reinstates DMA zone at the bottom of RAM. The result is DMA
> zone that properly reflects the hardware constraints as follows:
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> [baruch: split off the original patch]
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Note that I'm not an Arm64 maintainer, so the value of my review is
limited, but AFAICS this change should work as intended.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  arch/arm64/mm/init.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index c45e2152ca9e..bfb10969cbf0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -114,20 +114,8 @@ static void __init arch_reserve_crashkernel(void)
>  				    low_size, high);
>  }
>  
> -/*
> - * Return the maximum physical address for a zone given its limit.
> - * If DRAM starts above 32-bit, expand the zone to the maximum
> - * available memory, otherwise cap it at 32-bit.
> - */
>  static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>  {
> -	phys_addr_t phys_start = memblock_start_of_DRAM();
> -
> -	if (phys_start > U32_MAX)
> -		zone_limit = PHYS_ADDR_MAX;
> -	else if (phys_start > zone_limit)
> -		zone_limit = U32_MAX;
> -
>  	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>  }
>  


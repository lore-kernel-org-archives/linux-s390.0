Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA641B36A
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012679; cv=none; b=SwfX26k5c0FgL9ybhoPXlLzDnhR/jHO2bgf7+MGonz8qJ0J5LJFbNrTcfsHWTKCm9L58qpfxPLwA8YvX6g/5NtjeHKDTgGw8yTYZ+GHuVNojND30IMFilmnuIhVJv6Hjolxumkal/39vGChsCT3EE+hKZTctowtBQZ8CCGoh2CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012679; c=relaxed/simple;
	bh=De9dpWLqJDkTwPqqIvLBYIkFXDqvYTvryiNP3i+XxAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KF3flVjWXbW2eCl9Wtztn8GdFdA7DgOGSRTzDnadvAbcjJ6r3IRXd2/yhRj4XBKHpNI49Qmp4wb8w6mH7Wgl1/klLFG7f/5CAIKhQrfdEw+9SXV2yYukGsk9wi+5gxEtB6mYqU00WcRvtJmFMBXxbpLmyBc0HqDWAHZSJiwp+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cRMetSv8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cRMetSv8"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ee224f5fdso576538f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781012677; x=1781617477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l00W81UYsyqDsSVEFT5iHHagCSaGJS6VwfSu9rBGR+c=;
        b=cRMetSv8wXNxtuCIHaWBL8a+lkH2aTXZ0aq2oEHHKt5iU2y2XqsoLYltsJwH//1M7G
         FgFRqTDDH4NrvwkyAyzezpK+n1eFUcvaDepoumVx0/nCjvbdYG8X9cZRWcdMOa1XvVuw
         s3h5ONlDDMEu2IiCPlmr1c38oFhj20Zzwlgvx88IM4bS4y+axfFulKGElavXj/GOrBwD
         6+lee47KbnKFJNg31qFV3tS+tOaQys2akgfu+oTkhota2F6gcNq46GlaJJKIe2mXBJSN
         XGcTTFX38gCBjpwRqF5zKDiofSjCG8JXvk2NsqCoHraZYJwa/HyNMoJuZFO8uMYRm/cT
         JZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012677; x=1781617477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l00W81UYsyqDsSVEFT5iHHagCSaGJS6VwfSu9rBGR+c=;
        b=Bb0Fl0HHHB9mlI0XYodaGWlPnduLw4LgTMDsBVJ/itAos8YbYyBVgBgBiYVFMiqnaS
         8PssS5ojZ/nr+5XGt73fv9rH6/PcK+aB90RO5H0LLF3ZMGbPCzaUTxSHBQXGw8CC0mrx
         5SlNSB0dIWFnjjvKycUC8vYiJ34zzuROO7ZdPRKtxQJxD/ue62nH1qllohjdPcOZ+gB4
         zVMi+1HNdqlwe/IzQ6V9+FtYNm665C4cn/5ttgFkEUWRH4FY++fssSlrmR4Cb+B/6Fw4
         UsVDafAhB79BmmIA4UMzdJrM89W2BXWUw0tYpy3hygmeTT45u8dUczB9leePKKvdVIvJ
         Wn5g==
X-Forwarded-Encrypted: i=1; AFNElJ8QnFq5JbY4XBzKkGjC7QqehunMQVYbNnI0Pc4tTTPEWS1mEfl/q4xuoGw7ylToz9VwTEtew5WPC415@vger.kernel.org
X-Gm-Message-State: AOJu0YzCy8j8WgnqKZeD8O47/7Toz1Z1beFOkLFZv6VXqpqdHMJIvUB+
	qH3EZDA6l1rDMZqZ1ga7/7IwWc9xZK1i5jR0mORmm1q1bmjzI89Hjc5HSlcAqCDk1Y8=
X-Gm-Gg: Acq92OEyFg9ErV27wjW1V2VH/Ba+nWRgwOeMr7gsd5UU0LIDYlnTLyk/LV+wh7j7AtI
	nciDlJNPP40zChNnppbwkE9UkXxiimwD2BIlvtjbsxrQUYKzRMcNTQztpL1QMZ5+XRW+Fc1CcQx
	4Ald1W+25l6Ye0g6q8i4IFb45sPZq32cBS476wcPDQuiu+1501T4laXoPcmHyoHKgeH2h4SWSL9
	l4slrwF7PrBICvwHhOB8OvXy95MMcWSuyN2ob5Jy5zmMQlZ5hft09eJm4ETPAZ2lQNbbusXz8Kz
	JUVXCKIQpakzckZvPghRl6rmSuc+XDOQXFOgKBN+Uykde31cuyvlKpQPyo2KqKZnsV+84L20dMl
	Jbx9dCxGCf59umXkEqsws+8k1PQZJMRfw1sKLqMF+2Ft5Iq19aXy21LUHs182HAXRikppBpqJLy
	30Zwkgd8/L+E6G79Dy55t2C6QpO0tdvt4JCg==
X-Received: by 2002:a05:6000:715:b0:441:1c35:4b79 with SMTP id ffacd0b85a97d-4603076f62bmr12393402f8f.8.1781012676663;
        Tue, 09 Jun 2026 06:44:36 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm66805957f8f.36.2026.06.09.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:44:36 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:44:34 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 20/20] swiotlb: remove unused SWIOTLB_FORCE flag
Message-ID: <20260609154434.13dba7b9@mordecai>
In-Reply-To: <20260604083959.1265923-21-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-21-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:59 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
> controlled through the swiotlb=force command line option via
> swiotlb_force_bounce.
> 
> Remove the unused flag and simplify the force_bounce initialization.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/swiotlb.h | 1 -
>  kernel/dma/swiotlb.c    | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 526f82e9da45..af88ca7182f4 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -15,7 +15,6 @@ struct page;
>  struct scatterlist;
>  
>  #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
> -#define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
>  #define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */

These constants are kernel-internal, so let's not leave a hole in the
bitmask... I mean, what about changing SWIOTLB_ANY to (1 << 1) after
you remove SWIOTLB_FORCE?

Other than that, LGTM.

I consider this whole series a big step towards saner handling of
encrypted/decrypted memory for DMA buffers. Thank you for your effort!

Petr T

>  
>  /*
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index e4bd8c9eaeda..81cc4928e949 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -400,8 +400,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  	if (swiotlb_force_disable)
>  		return;
>  
> -	io_tlb_default_mem.force_bounce =
> -		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
> +	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
>  
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	if (!remap)


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B82C327A
	for <linux-s390@vger.kernel.org>; Mon,  6 Oct 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759066; cv=none; b=edK641DJhWcmm1oBhEcmuBRU8TPLNoRDvlbH+cZ7nH8dFxWwnVzfRgyYxY3z0/ygEiShrhtST1aJImQ2HlorwNtoAPgbSrePVqVncd1C81GUGfwxgDKFCbRLXlZws+rOx+lxs4mU+lbbWw2NuvLo77nUlKpZlBBR/OvTy1U/pzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759066; c=relaxed/simple;
	bh=aoHPu3E0mvHoalx0FWQM3EH+lnlTpy4HtT99+90hPDc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AuHWVftTUZ8pf/ubX2z8bAwUG9pSxuIpNEKVUgeqGvY17kIHUDdb3d/RgUMnZWb6lPW+zRlFFRDEqlZmrg3e22aTD4YqOMOduWQz8aH8s26+w6hZjCUUMSlLWmmYxk4HyjScvu/kHehVf8ucC1MQ2LlpxUhIyWe2r0/FmMEq4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xe94k6yo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xe94k6yo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759759064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N38NCXKatF4Nc9lTi4kU9EIStYgT9YorHxjupIC+4LM=;
	b=Xe94k6yoBohVja/fm+Awb2foeGBYDIIapZ9QvawSy8Jx8YGdKmSM4QQKk4iibJCZiSe54Q
	gBlnaXphDubGHU3nUg7iw51qGnQ3MDHEtfKCvdWEIQFtiUMWDyxXJRjj68Cpa4qQysKa4f
	mQd6S9D9nkSsyuvweLQ/jDZNO+vsB8w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-yD7BEV5JO3W0S700JX1s3g-1; Mon, 06 Oct 2025 09:57:42 -0400
X-MC-Unique: yD7BEV5JO3W0S700JX1s3g-1
X-Mimecast-MFC-AGG-ID: yD7BEV5JO3W0S700JX1s3g_1759759061
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdf7b5c46so2463708f8f.2
        for <linux-s390@vger.kernel.org>; Mon, 06 Oct 2025 06:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759061; x=1760363861;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N38NCXKatF4Nc9lTi4kU9EIStYgT9YorHxjupIC+4LM=;
        b=Lb5bYcd1Wl6Ssort40lUGQ5/rezIkdR++w6jEsMDtfgwtMdVK+LtJaVhi+UmyIO3LK
         sFyq3UGA/oE39XxZ0nefFDTFvB8l5EM7Mx76BSpACybJv5r/c5O/SXejBFZD72WiRJTx
         KwZRyuFLUt81GUwK6dsAVPgHalE+HFr1kKUCRrIVV6k/CnoZV1KfF4cp9OkYW6aX/2XD
         rurTtWNQ1plT2F4cLlz3vbxCjhMEfNw6OqhTQBH7hnJATMY5uh1QA81i+3bw2B4o+Pm2
         gyJq3UZzP5cCIGh+0QQ+hz8s0WahNIq6Mhix3aYjoVVA4dcsV8NxDV/jrgQzxtOzkzUG
         4S7w==
X-Forwarded-Encrypted: i=1; AJvYcCW0ul+oupoWBBi5VvPmvWHiVLLkw/RD3rAC4ACB7Qqx7yK+McRXVodXHyTfRqgXLcK1p1FdCsIzklIu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2MgTej55lHpLr/YrfrJD1XJGdctrCwMgc4QkmLyifHjhX21g
	y8eO0kPmFjKtIL0xFmvoTGl7WeKOTdwOuoXb9yqJYyOfgyn84AGBMrb0snOUlwYtD4a5CslzxWO
	8f1ZDTqJz7phc34yDchFfNOr5dhz1iT2bnfNWY36qw+CyG2aUKB1WCIkqelSZV9s=
X-Gm-Gg: ASbGncvVMZ55ejnRjSW+KYafjPp+afDsbpydyZ+1HQo5b0Z2xJ4zWfkyfFiy2ijMV8u
	iAYrzkyxb5cmoMTYNPAEa/5BW6FaSaW45LGiMWHybV8DLlhehyC2xW9vs+kNoSNtYvmo69PfG5C
	v17qw3gW5LWWupBttJa2EmrymZ0CDuj/hVICeGt9G4Rhut4bos7pjezlXPytgclvYJT3fwpKYo9
	tIrXlLQOO8CJauotUdq3ngMTGm49M2oJFjkl/lji1cyn2UoSYzeCYb1qSZQH46X4tUUqlynUI8w
	5+7HyKWNocda4bIkbtTr2ThBDw0VEzpF0OpWMaKmhmVSBTLLCJ1+fwOulCeXlKZJMwmr/CeU/eB
	BOdw1KA2XfAh2+yfkYSo=
X-Received: by 2002:a05:6000:24c8:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-4256714c990mr8743309f8f.14.1759759061349;
        Mon, 06 Oct 2025 06:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSEXhNL5qt3C2EExsoRcqgHMQ8DFjBOOTUMJgsVGWdtBaHzjZoYrl+W+SOqr9EcfM/+bfqVw==
X-Received: by 2002:a05:6000:24c8:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-4256714c990mr8743277f8f.14.1759759060881;
        Mon, 06 Oct 2025 06:57:40 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de. [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c54sm21356683f8f.11.2025.10.06.06.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:57:40 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:57:38 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Tariq Toukan <tariqt@nvidia.com>
cc: Catalin Marinas <catalin.marinas@arm.com>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
    Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
    linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
    Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Justin Stitt <justinstitt@google.com>, 
    linux-s390@vger.kernel.org, llvm@lists.linux.dev, 
    Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>, 
    Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Salil Mehta <salil.mehta@huawei.com>, Sven Schnelle <svens@linux.ibm.com>, 
    Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
    Yisen Zhuang <yisen.zhuang@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
    Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
    Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev, 
    Niklas Schnelle <schnelle@linux.ibm.com>, 
    Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>, 
    Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH net-next V6] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
In-Reply-To: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
Message-ID: <e77083c4-82ac-0c95-1cf1-5a13f15e7c58@redhat.com>
References: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 29 Sep 2025, Tariq Toukan wrote:
> +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
> +				size_t mmio_wqe_size, unsigned int offset)
> +{
> +#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
> +	if (cpu_has_neon()) {
> +		kernel_neon_begin();
> +		asm volatile
> +		(".arch_extension simd;\n\t"
> +		"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
> +		"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
> +		:
> +		: "r"(mmio_wqe), "r"(sq->bfreg.map + offset)
> +		: "memory", "v0", "v1", "v2", "v3");
> +		kernel_neon_end();
> +		return;
> +	}
> +#endif

This one breaks the build for me:
/tmp/cc2vw3CJ.s: Assembler messages:
/tmp/cc2vw3CJ.s:391: Error: unknown architectural extension `simd;'

Removing the extra ";" after simd seems to fix it.

Regards,
Sebastian


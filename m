Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD82417C5;
	Mon, 21 Jul 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753138800; cv=none; b=T5wxuX9/umDCiz8YnBpN7s2WFyKGX8m/2p7K4Q1CeQOCa922RpscC57yXqdplB3aOxljMxz/f5yxgvM5g6R7u/k5oXYwxtwDB5v44ks1uWlgWR/AonMnKs4XJj7LJZjWtBiW/3/hTNw+DdoTVgihQzgzXK1BxuhfUwexpdgIyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753138800; c=relaxed/simple;
	bh=1l1qCq8RhRHOce1Tf8sw0XBDQPRKflzH3Beo70vl88s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsrJJFbP+74iIDBJJiCNrXvJ8KYKsC2QS2eZcjrY6czsFoNz3E0oJrr3nR3+88yrM4StWs3FMqKJMHHuPUYySjUQ9MsFPgq3BivdZ4UoTxthzs6AzrTaglfoZ1ZwK9fIY7b8LQV+8CnUGLMUhw8Z0x9pVrW1MsHWg8kd9mlTEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/FeWG8D; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/FeWG8D"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c733792e9so752290a12.0;
        Mon, 21 Jul 2025 15:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138796; x=1753743596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6qH8mhMJUNtpiP5ZkZtwmZQrunIQJlcyvnjoj0lgTw=;
        b=C/FeWG8DvsoqB2zXzPW7BBp4wCIIOK2vNPPhABp1lZ8xOK/gAKv9a+nprxI6BoHPgt
         GjyRkS/P8TYCDhm8o1otWN4LBpNMO4tDooAc1zX+ldApy4y72smOssRPWReg81GEHPyh
         BtAxWxs/eTUZt5bQOLNt3Mrv9Ls5YC2vgvDOzyZ9jVkFx33HVD+jLc/OBKS9CmHToAMw
         xkPbsJakVaa1tgwmT7qXG/dGuyr/rxlkGMjOLGq1ETgEaHalqvOMt8/TNexoi3GJ7BU2
         ze5BzVxkkSKACvtM+NtahOsAfTS0PQ85lbdr+/WSsS+9wjw3Rqzf6ewOeDts7CvJOLKl
         UAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138796; x=1753743596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6qH8mhMJUNtpiP5ZkZtwmZQrunIQJlcyvnjoj0lgTw=;
        b=NAtYSkiVWPtFSLyvTxwqUPPM0zcx0l724ZaIUIuZ0ucdhVAIaCszfZlZ2yVprtM9x0
         WcAQ3bCTkZH4aI8y6Sf8WnNIS+pvOkY5clQGCbo2v8GnPKgOD5jh9ddfCt4f75sT/kjO
         jxbM7QbERs9WmkLJ/K21M1apdxxzTA/T9Bg2imspX3uI0r8iejYJL07nxL01iFl8GuON
         uA+1y9jICTnLqKS/4//A3a4SLje97Wa5aiGOHn+pZxE+Rgej3xvJ6z+iGLhfg+YxToXz
         ZTyxKQoA1i66t5+qpmCClyStVMoJKBQm8568HvA8o5Q8DhJ/lQeMFs1Jft6il74er/PN
         K3NA==
X-Forwarded-Encrypted: i=1; AJvYcCX0kKu/Y/m24TbIxr7/lbfjv5APLRgfhYg428935skNUKf1X/7A4nPzL80Mn7yn5SlDMw6Ue5QIpjE9Pw==@vger.kernel.org, AJvYcCXnYrZ0O68E2pPlf4bbTDOcq41pgVo5AGdVzi8AgLXKk3eW3KhCasZL32VCBQt8ILeLmW1hGUlGiUdui50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJuBYdUwzz1F7T78lDfP34uFsJOht1DLw2HxpCbnwcBHJCCzc
	OnbllwDLPDUuMdNcbGoRYMkuwlZfcPds/7qu3b8tcDjve2FTjbPatlfo
X-Gm-Gg: ASbGncsx8xWjJAJDuQfmiCOHYHqFiqhmxzBz7drEZK7/74bPcAxWJ/61SbBIygxZslW
	/fKsBXebU+vT7oC0oDRbGEdMge/cNFcHRIOVCzJr2HRSMWswazHR1ba0K9cEmXsfgMwR2r4HHbT
	HtOyTmPZNQKCihO64MXPpWMGWEWwsL6UUmu73IWRxlKos6MRqZCBQdToPJ1OncHPUJ0dpg55YZq
	83E46q+dcpd7ue7+NTyY/D608r+YjKx1dpf6jm9Ta6/1wXLH3B/vY9iUxBVaGnblDbd7F8YA7yF
	7yN9tQwkkzKAltV4ouuelju7WE5SfKrIYAgjCNy9zEdF7wlo+cG4tmoDVZGPW3wZkmTrt5YSpQ1
	i0LBb+Dig7+AKCDI1YGiheXJaQjkArYD72crJPgsISy1Wh32ifbEP19aY14+pCvmFqTvjrb0YNH
	Gejww=
X-Google-Smtp-Source: AGHT+IEnEupELw4ajNrlfkyI1uQuImlm2WT9jEJPd1nte24ZB52Dcj+jDrjKRG7BtovOALnxWEn+Rg==
X-Received: by 2002:a05:6402:3582:b0:612:b0d9:3969 with SMTP id 4fb4d7f45d1cf-612b0d93f03mr5896841a12.8.1753138796402;
        Mon, 21 Jul 2025 15:59:56 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f543ddsm5962670a12.30.2025.07.21.15.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 15:59:55 -0700 (PDT)
Message-ID: <bc47c08b-fbc7-4954-8e81-c22bce654556@gmail.com>
Date: Tue, 22 Jul 2025 00:59:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN
 option
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-2-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717142732.292822-2-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> to defer KASAN initialization until shadow memory is properly set up.
> 
> Some architectures (like PowerPC with radix MMU) need to set up their
> shadow memory mappings before KASAN can be safely enabled, while others
> (like s390, x86, arm) can enable KASAN much earlier or even from the
> beginning.
> 
> This option allows us to:
> 1. Use static keys only where needed (avoiding overhead)
> 2. Use compile-time constants for arch that don't need runtime checks
> 3. Maintain optimal performance for both scenarios
> 
> Architectures that need deferred KASAN should select this option.
> Architectures that can enable KASAN early will get compile-time
> optimizations instead of runtime checks.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v3:
> - Introduced CONFIG_ARCH_DEFER_KASAN to control static key usage
> ---
>  lib/Kconfig.kasan | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index f82889a830f..38456560c85 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -19,6 +19,14 @@ config ARCH_DISABLE_KASAN_INLINE
>  	  Disables both inline and stack instrumentation. Selected by
>  	  architectures that do not support these instrumentation types.
>  
> +config ARCH_DEFER_KASAN
> +	bool
> +	help
> +	  Architectures should select this if they need to defer KASAN
> +	  initialization until shadow memory is properly set up. This
> +	  enables runtime control via static keys. Otherwise, KASAN uses
> +	  compile-time constants for better performance.
> +
>  config CC_HAS_KASAN_GENERIC
>  	def_bool $(cc-option, -fsanitize=kernel-address)
>  

This needs to be merged with the next patch where this option at least has some users.


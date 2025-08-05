Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79327292B52;
	Tue,  5 Aug 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414400; cv=none; b=uF+ORf24kRL3cljjPZt8ddPmg8FgwV3Hy3sYr00DNnJgBG2wg6dOV8CdTfn0Kn6LHeHJn3tWYE2Y60TvG7UOiKzd3oQCzQFeMibnVEVvWQaenY343lDS8EkHd7DxOI6E2+bnQxyvP0CiPRxpUgeKGcUVUKdeSUzoSuNCOnkh8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414400; c=relaxed/simple;
	bh=vAXnpuKxs/l1W6Pm+Trii3WWl/FJ6RefL0KkHMHqok4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4aO/mO444LMbH7wofIbMhpEYnbARKENS3t0fSh/QYIps/+Lszeljw9EatRIj32IoHS82OcqRY9rmzkdpOZdkVfA9fBwzugJxo3aDWuXbvW8EIy5ZOiHHusW8CIeYJHsBWpgl23GK3cMSt9YP+MMFtNYTw8bUuGLhX1/qYegboc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk/DiF+i; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk/DiF+i"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b98acb9faso132449e87.3;
        Tue, 05 Aug 2025 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754414396; x=1755019196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/FfZaSan1eV7HDF3Wa83lEa0xPcSUpZYrzYE5G9wjk=;
        b=Zk/DiF+id+OMDjUW38sxBjTWhAT9DFKEsoAGPgFHkPEOZ2ob9qlFUpCwrcrymC9zRb
         IX/qEGxjUTBz6SAEvWpHcurPJ8Ym4rphh8gfYiL3vR3lwTpmNmkQvH0rlnn4UCdpHd6u
         PfGmjgycrqRZgTpfzXAER4xz52SkStkKHl4Jelv+VwszqfHyg1b2ChLuXw/d973tnjwx
         z6imxpV3jggFl/VWmtFcDTlDkJfYLqMmDnJhycULTTqFndIS8vC+zsFg/5iujQ7/A7/c
         1KTqkaxzOs3N5bvH5+SLwKYFAafibR1RALS05IAAQoibxUz0NAye+dO5lFKG4/9BSpY2
         StZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754414396; x=1755019196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/FfZaSan1eV7HDF3Wa83lEa0xPcSUpZYrzYE5G9wjk=;
        b=l89Ah0IJKMVScUoJ9va6lKcRYEcOw4q5FK+PqpV7IZtWesF/+KNcGzb+BPz8Z5yZ12
         5+lbbKSCnOHdzcmYxpu/mA+YuI5D/CVy5PrQqDhwcQmXYOq77NScSZNZvprIonmPKxba
         Lwoxh9YH/t+MZg6QrFCNzVfourujGkCFbn/XiFio9GfUVjtpee2mUB0QTDqt2nVmGBN2
         /s7RTT3xbL4u42rHjV7wPJsZoQmkJXON5svQozboogXALcwoFqUFkyfU83ov6NS/eozK
         QSprfcMc9fQJts+6KJb82VxSLK33/FtRegQ02hg0HunNdHnR27ey/btzib6FnkiGO5aD
         yu/w==
X-Forwarded-Encrypted: i=1; AJvYcCU6hyK7/GTCr0dps0Zzgv7HtDDaKfjmQ0sKxkgJDUSFH6OYjv5O8pSIxInm0Dysm+9ZG1DQbsBfx8WFAQ==@vger.kernel.org, AJvYcCWScw/3vlHHENa8p7ENjWWFcJAOueWKLMLXwL2H0bqVSXjnTer1aQHx0+WlR6GvadAH/oHNIPEXji7zrZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3MRc0oClwuiq2BUF5bapqqLn4IgPpS+klghxCFSZIiCZUxDI
	Zu29DGdM49il4DrkBKAqMqX3wjfipMQY7Y0NZ4QlkviZ7vqkJQyL23y6
X-Gm-Gg: ASbGnctVzsda8h2zlgj0EB8TZ2fRqgeAcQ4ef51LbKnlKG41W58MW5adZzJP4/CE/RH
	KlR7Zvu/mMNzVCiYyA3dLnJKGPUMFeoSEr36lkDlCgm96HIGl+2gmXt9V4WpOOh54Wg2VmorVbj
	uGw+GB2kU0I4WE6tEu7/U8CHULBvcQlUDByyrKiMzfvIMPsvyqFi90Ku35wALRtKzvsPX1n0917
	aTYk6ggyJ7KVna6Dkn4cvoerG3JRzHY9Kf9Ha3TqMuqWMe8vOzmRWQw8p8D1VKEeNpky3vY8BxD
	O2Frf+NyCF2Fc0ysssv7Can/z79an0DusM5Y+IYXB9JP6vC5L8gLSoYNVE8/Z/HpyQNW45ZSjRv
	kJ9qrfwstmZhi87TvNK4ZlifZWAoJ
X-Google-Smtp-Source: AGHT+IFZ9pdK1jvsk2cxgalB1qSoH0zZWAWc/VG+Lc+QySUYQJ+aNEU1tTzI15MgaTEZ+riRKR17/A==
X-Received: by 2002:a05:6512:6d1:b0:553:2480:230a with SMTP id 2adb3069b0e04-55b979b819amr1540170e87.0.1754414396425;
        Tue, 05 Aug 2025 10:19:56 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a9483sm19586481fa.23.2025.08.05.10.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 10:19:56 -0700 (PDT)
Message-ID: <60895f3d-abe2-4fc3-afc3-176a188f06d4@gmail.com>
Date: Tue, 5 Aug 2025 19:19:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] kasan/um: select ARCH_DEFER_KASAN and call
 kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn,
 trishalfonso@google.com, davidgow@google.com
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250805142622.560992-1-snovitoll@gmail.com>
 <20250805142622.560992-7-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250805142622.560992-7-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 9083bfdb773..8d14c8fc2cd 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -5,6 +5,7 @@ menu "UML-specific options"
>  config UML
>  	bool
>  	default y
> +	select ARCH_DEFER_KASAN

select ARCH_DEFER_KASAN if STATIC_LINK

>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	select ARCH_HAS_CACHE_LINE_SIZE
>  	select ARCH_HAS_CPU_FINALIZE_INIT
> diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
> index f97bb1f7b85..81bcdc0f962 100644
> --- a/arch/um/include/asm/kasan.h
> +++ b/arch/um/include/asm/kasan.h
> @@ -24,11 +24,6 @@
>  
>  #ifdef CONFIG_KASAN
>  void kasan_init(void);
> -extern int kasan_um_is_ready;
> -
> -#ifdef CONFIG_STATIC_LINK
> -#define kasan_arch_is_ready() (kasan_um_is_ready)
> -#endif
>  #else
>  static inline void kasan_init(void) { }
>  #endif /* CONFIG_KASAN */

Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC3244697;
	Wed, 23 Jul 2025 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292001; cv=none; b=bbvXrlYVYUvzB/eMkUNuU22MtQ1ziXvHZbFjP7AD8qzXJNmfGFzHe6rlQv2ojM7usGx79PJ1jMlpURbfMNYYBczhLIWgbidzScDo/TBMkHG7a1d+PkBob0lnfUT+ZwNmknyIWQBaXN+6zBEVSVoyuiR45jNN0IMjE5Nbhgw728M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292001; c=relaxed/simple;
	bh=C2VlGrQRcLA6KNMLUWn4frGY1BGHzl2OatrBQFPkZDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQCNyjQejHQgFGUy8yzBQ8q1Zd6SNunR7WVCDKADgNhsDTKwIBZ/+bBRGuXZupzoigWPWZjxS/4rN/FTvWlJe1ne7ZNPjNWwpzQY+HmuOayh5uwJZNEyKoi8rgNU4rWNx207YE734rNxLM1y7oSQyLSVQdeqPRaEO0oa7mgBlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3TsDAwh; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3TsDAwh"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55a1eced1abso9414e87.3;
        Wed, 23 Jul 2025 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753291998; x=1753896798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBM3XOa1GXkPG7AU5j/kIOwYcdf4HqHkAm2pQZ3zu3U=;
        b=d3TsDAwhRnzHHCVMNNkAXmbwISMmAE5CtOgI2nqgRLHiso9LzFkJzGCaaTUhMzEp0r
         le+jxG3A9wCjzp1WKALfm6lEza1tvSCFpNcCxdNOVH1m47lbTZki+CErKkF5yCvDfxv0
         7atJjHc40EuetIIBVwTl5pzmU6OyVIJfY2AOoa8c5cx5dICScW99FcmDhAbhxCNOSumM
         X11tbVIFll5WVULK+9UyLPrnfhkMDu5ELSNcMHxpRZUfigInjYAKkY0raUcI8/85WtRS
         a13xCxQiGbLyeTh3/iaEr/GaW1A0eGx3lAQiomznR4ubgeXAIPsBDmLF+Va9/LSxcDR6
         UkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291998; x=1753896798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBM3XOa1GXkPG7AU5j/kIOwYcdf4HqHkAm2pQZ3zu3U=;
        b=EZhY5wiG1v639IqvQXPwndba0wRQ7vl8sTYUiFYXL4TWvMKkyHKKTKvrmhE4SmrQuK
         ZTDVZxJhrAxz8pkTDWDeOwKOQzRE8OWTiVpQ+ISaqB36c+jgM4zl86pnBLn5S+MZjYNz
         N9sP+1dB3Deplc4laYXI6rIRyC+fLLFpIkdtzUiaFOq/j7gtoz+Hq9wmmYy/XfXeySjD
         9MeeW6OCckNbt6NnhuYGvFHIinVOgljyZY8f9t44/YpSvPJmSFCBOrcKpWwU5NQx1XhP
         gJsgqpjRNi4iKgrmHgrxG77XM6uXAYQfG8/A6pPgBPAhKRaV5MTkOXVgOoFoeQ5nDd/+
         XiQg==
X-Forwarded-Encrypted: i=1; AJvYcCUSs+8cjdT3CzCSa6yzX2omqBt2lRx8CpYtN7UhvSerGRfNoTUT/jujzmmvByLfoZn/Sqj66Az5HdS+Rg==@vger.kernel.org, AJvYcCV9g5MgBcrZfih30YgfH4PrZTyny+ZyfO0805J9mJSUN0LRmdCc5P1FHuCyEj05elQn1No2KrrgahCt/wY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4CFVY/fHW3C4/vjK7A1n/sl5v9lWbyCec2SjCxvpIJDKDqD1H
	eY2gc/WF2sll6XFUPqmG6Nffj+sQZSTEcdEVs4TybZ8ipDmKjnjgoRYF
X-Gm-Gg: ASbGncv0Xj9jLhul6nXbYkztyz76JzhOWyeeO6oA39HVnpDceCWcJcedAXsO97GlzjQ
	lm1Q79PB9yoYTH8my1rfJaJUBCuEhUua/qKb2ebtgzgL+C9Up4Q41pnoYSPMCNM0H424TtuaVfH
	eeA2mN5e52yZ+G8Ad11dhbdOJGififxhRmpQtwFvVdW9xurpskMLBix5PELUdGLK+VaaYfT0LS/
	6nrnhy326Qp23ZVpn1zQyKYpP6SLq3c9KweRNepYDR/YxysCFoPi/6HZmDTnxVKIZnae1hQDJZ/
	5BeW1Ai50LjJs60FFWQ7tagsq3N9SVT0GiHdZv1qdwgp60ig/Nejj5mcXUSeBZ4SZcHRIrQAeF1
	BrW40WeDSJOdAs976ET6eYC9LPhZN2XwD07olItQ=
X-Google-Smtp-Source: AGHT+IEhfKgja72kmMEVu8mg+y0GPA2wBPQGXBF9w7fJkfAZVikcQ8zyKptW1cZk85GIYWtzdxftWQ==
X-Received: by 2002:a05:6512:3c8b:b0:553:24b4:6492 with SMTP id 2adb3069b0e04-55a5132157emr458860e87.5.1753291997236;
        Wed, 23 Jul 2025 10:33:17 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aac980sm2396014e87.74.2025.07.23.10.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 10:33:16 -0700 (PDT)
Message-ID: <f7051d82-559f-420d-a766-6126ba2ed5ab@gmail.com>
Date: Wed, 23 Jul 2025 19:32:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] kasan: unify kasan_arch_is_ready() and remove
 arch-specific implementations
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, akpm@linux-foundation.org, glider@google.com,
 dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <f10f3599-509d-4455-94a3-fcbeeffd8219@gmail.com>
 <CACzwLxjD0oXGGm2dkDdXjX0sxoNC2asQbjigkDWGCn48bitxSw@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CACzwLxjD0oXGGm2dkDdXjX0sxoNC2asQbjigkDWGCn48bitxSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/22/25 8:21 PM, Sabyrzhan Tasbolatov wrote:
> On Tue, Jul 22, 2025 at 3:59 AM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>
>>
>>
>> On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
>>
>>> === Testing with patches
>>>
>>> Testing in v3:
>>>
>>> - Compiled every affected arch with no errors:
>>>
>>> $ make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
>>>       OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
>>>       HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld \
>>>       ARCH=$ARCH
>>>
>>> $ clang --version
>>> ClangBuiltLinux clang version 19.1.4
>>> Target: x86_64-unknown-linux-gnu
>>> Thread model: posix
>>>
>>> - make ARCH=um produces the warning during compiling:
>>>       MODPOST Module.symvers
>>>       WARNING: modpost: vmlinux: section mismatch in reference: \
>>>               kasan_init+0x43 (section: .ltext) -> \
>>>               kasan_init_generic (section: .init.text)
>>>
>>> AFAIU, it's due to the code in arch/um/kernel/mem.c, where kasan_init()
>>> is placed in own section ".kasan_init", which calls kasan_init_generic()
>>> which is marked with "__init".
>>>
>>> - Booting via qemu-system- and running KUnit tests:
>>>
>>> * arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results.
>>> * x86_64 (GENERIC): no regression, no errors
>>>
>>
>> It would be interesting to see whether ARCH_DEFER_KASAN=y arches work.
>> These series add static key into __asan_load*()/_store*() which are called
>> from everywhere, including the code patching static branches during the switch.
>>
>> I have suspicion that the code patching static branches during static key switch
>> might not be prepared to the fact the current CPU might try to execute this static
>> branch in the middle of switch.
> 
> AFAIU, you're referring to this function in mm/kasan/generic.c:
> 
> static __always_inline bool check_region_inline(const void *addr,
> 
>       size_t size, bool write,
> 
>       unsigned long ret_ip)
> {
>         if (!kasan_shadow_initialized())
>                 return true;
> ...
> }
> 
> and particularly, to architectures that selects ARCH_DEFER_KASAN=y, which are
> loongarch, powerpc, um. So when these arch try to enable the static key:
> 
> 1. static_branch_enable(&kasan_flag_enabled) called
> 2. Kernel patches code - changes jump instructions
> 3. Code patching involves memory writes
> 4. Memory writes can trigger any KASAN wrapper function
> 5. Wrapper calls kasan_shadow_initialized()
> 6. kasan_shadow_initialized() calls static_branch_likely(&kasan_flag_enabled)
> 7. This reads the static key being patched --- this is the potential issue?
> 


Yes, that's right.


> The current runtime check is following in tis v3 patch series:
> 
> #ifdef CONFIG_ARCH_DEFER_KASAN
> ...
> static __always_inline bool kasan_shadow_initialized(void)
> {
>         return static_branch_likely(&kasan_flag_enabled);
> }
> ...
> #endif
> 
> I wonder, if I should add some protection only for KASAN_GENERIC,
> where check_region_inline() is called (or for all KASAN modes?):
> 
> #ifdef CONFIG_ARCH_DEFER_KASAN
> ...
> static __always_inline bool kasan_shadow_initialized(void)
> {
>         /* Avoid recursion (?) during static key patching */
>         if (static_key_count(&kasan_flag_enabled.key) < 0)
>                 return false;
>         return static_branch_likely(&kasan_flag_enabled);
> }
> ...
> #endif
> 
> Please suggest where the issue is and if I understood the problem.

I don't know if it's a real problem or not. I'm just pointing out that we might
have tricky use case here and maybe that's a problem, because nobody had such use
case in mind. But maybe it's just fine.
I think we just need to boot test it, to see if this works.

> I might try to run QEMU on powerpc with KUnits to see if I see any logs.
powerpc used static key same way before your patches, so powerpc should be fine.

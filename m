Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E7214A94;
	Mon, 21 Jul 2025 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139956; cv=none; b=LVql7fh+uNFhS9LKNTCUEfa8544IksDncYoL+c7rHxgTH4ZGsW+pF1JdaFUW76IGWADB99nbCUPiaHg1uPgT2dTROEiQ1GnIPzulGIiZawYCJdKkOubmbRNXw34l7zzokcfVQAIi3zl2wLj3Op9kieMORgIB+kfhCJGsWGgU/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139956; c=relaxed/simple;
	bh=rdAkJU1uKTabmiWmolO/lfoE99GSpKLoFg6bqNIeYwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6PuQgpX0YwVwDvfJAPb21IKWsWlYNx8aCK7eJEK+kxyx08nq1/JZEU5fuuRLMnq14t/T3+nSkhMXanroSfihwjNGPOfrl5IPUQhBxQ7FMUTeHKqlotERmFa5Rk4z59KiJetLfbTpS91irK1Jf5V5Y6+T72yqGRbqY7mVK0OEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwaJ7r3z; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwaJ7r3z"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae6d8584e08so5028766b.2;
        Mon, 21 Jul 2025 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753139953; x=1753744753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7uUxr86UctpR4wo5BHRFyvrfjd8nsrpfmZh9G1fUjI=;
        b=bwaJ7r3zTowA2CpXXtnEm4cfULrSx1Wtz/MXWwVNpkLsdR9/zC8HHNhV34r3n9VJSN
         zTIeMbXGuiPpHGrOxGomrD23oH9Jn8vFS4jzvFP+XE8BR4a5pJ+uKEfWnSP2CJusJOrp
         JzNfW75kenoSmCDkwY5Ex+yw6Oul44/S5YYfoWobOSvsHuFZJWAeDUnnLdSKplbUG17C
         MTicfAqEbYMEH2B3AfPGV4aY3/GnS65R5njo+OF/gcZUPWfEhg4mef0r1HLC67N14dkR
         53+4ZaKPAUTfSM81f/Tg1y7+r9LWTyMAatx+xJBiDrDIQpD3Jlppzpku4WN39521eRkA
         PhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753139953; x=1753744753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7uUxr86UctpR4wo5BHRFyvrfjd8nsrpfmZh9G1fUjI=;
        b=HUMVAdl8HQL9gZObW99thy+iqwjGCOvkljnLGVOiH8PmrlssPEBn6qDjvQ2rpFISN5
         K2QyMBf0+5/EvVhG52ewv9VFJ4Zhnbk8uzTBfBKrZJPjc284t2jdPVGMVgdrFZasJBRw
         jb7DNuqGzf/ou0PyqZcqs0qSLqe9P4b6kl6d2nlutOuIxo3oUPXbKOyVdK9wOvma3YKN
         pPCSull3TtJqv7ToqvIpSp64f1opyNEFwwm6nJvjn3m/hHlETbYJ/bkx8xbOlHTwTtTm
         sT1vYQI7xQ2vOnAGBF7Ts9nqvzsqBVku5ea2pKUFN6oRhWhllkqGvizT8sPe/Ebn4Gm/
         eFiw==
X-Forwarded-Encrypted: i=1; AJvYcCVnmwp0+9sml7L8KMG9wPT8cY96uOnw1bcA5UCRD3TUuqyBktOMG3+6YHGy1zotq5jQ7m9dHPr46+Z218g=@vger.kernel.org, AJvYcCWODhvQru8EY3UIdFKBbrXOnL5ytt6lQN3+q/DIDTR39NSS7sr3BMXu9ZotIPrX51u2CDPXhTNatOI19A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/hSIK4KLZUXotAmfSwumFPRAxjWynpOZRbk5RHU8HoUSI2HE
	nDwpDCfnvX86peMHNzjjg/x5zYI6j+2S02O5VRsbvUWOSLCT49jd6Kpq
X-Gm-Gg: ASbGncue2StGRAU/Gx/B2LD5KEoT9FIag2IhPD1z1T3QfALYdLQiXedrfgP/HoC4EHi
	MJW7tGOBPamscJb2/vFb8Tg8ETmv9wx0VjzF2lVSg1l/0Mgk4lJ4aGA1QRC584Gyy9zDAhgrQVf
	NPXSm489MbsbJtW4NOWVKNU8EsnLRz/6mnY61cncgV3sjd68PdnxxuTSIGvnvS2Me3tAEJubPO2
	8fWQ8v9dZs2q57GhhAeigXF3qLpJ7ymriNI1X12b1lZf9swVqfDF0RoFcLEa5DyP/bZVs4aj/JM
	ycWnIufi+8kNRbl1m+bRUkhSLjy+F4QD6JhJW0FMxS4LWzRrAvN/St7k9chGBJQACZArjlgGF3J
	nSxh2aqTkxCbMGyrS7biT5aUMLVbNzIoZwefKFU/HDzzOg441rR0eh7WOSPOAzRxUTq9F
X-Google-Smtp-Source: AGHT+IEyAyDIGzGDBFvxWK+s5z/H1D9rPFTjwAnBXhww3QxIrjDEOAm8ilmaU8TjGW6AeZa6UNDATw==
X-Received: by 2002:a17:907:706:b0:ad8:8200:ecf7 with SMTP id a640c23a62f3a-ae9c99aa29fmr821747766b.4.1753139953227;
        Mon, 21 Jul 2025 16:19:13 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7ea53sm757005366b.133.2025.07.21.16.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 16:19:12 -0700 (PDT)
Message-ID: <a1bc7a9d-817d-49cc-b7f1-79a900090136@gmail.com>
Date: Tue, 22 Jul 2025 01:18:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN
 option
To: Andrew Morton <akpm@linux-foundation.org>,
 Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, glider@google.com, dvyukov@google.com,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-2-snovitoll@gmail.com>
 <20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/25 12:10 AM, Andrew Morton wrote:
> On Thu, 17 Jul 2025 19:27:21 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:
> 
>> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
>> to defer KASAN initialization until shadow memory is properly set up.
>>
>> Some architectures (like PowerPC with radix MMU) need to set up their
>> shadow memory mappings before KASAN can be safely enabled, while others
>> (like s390, x86, arm) can enable KASAN much earlier or even from the
>> beginning.
>>
>> This option allows us to:
>> 1. Use static keys only where needed (avoiding overhead)
>> 2. Use compile-time constants for arch that don't need runtime checks
>> 3. Maintain optimal performance for both scenarios
>>
>> Architectures that need deferred KASAN should select this option.
>> Architectures that can enable KASAN early will get compile-time
>> optimizations instead of runtime checks.
> 
> Looks nice and appears quite mature.  I'm reluctant to add it to mm.git
> during -rc6, especially given the lack of formal review and ack tags.
> 
> But but but, that's what the mm-new branch is for.  I guess I'll add it
> to get some additional exposure, but whether I'll advance it into
> mm-unstable/linux-next for this cycle is unclear.
> 
> What do you (and others) think?

After looking a bit, it breaks UM and probably LoongArch too.
I'd say it needs more work and not ready even for mm-new.

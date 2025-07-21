Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A917996;
	Mon, 21 Jul 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753138789; cv=none; b=jT7OFexhU8Iqx5N4L+eWxMmoXHXwC1kg1Q54lhzxhsus4tku7yLfnjdE2xV8AOmBLUM4gT8n2TbH2IpX1yZfBZ8JnGDfNrTSjgR0A+MxCpDVK4NyHymnbxPIzX13hRAjNoDulZiC52ja2jePkVCuRAemFfMjWesFP8NJ8+s6MGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753138789; c=relaxed/simple;
	bh=+7tVxomXlBN2ep8coxou7cFT9C4R2OKsqiwHvfpGarw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFYf7cIcB5l3wEoBwU8H2TyTXE51Y7+dDm1sp7vwcE0H4LS1JaFbjlpnnTE/uHZaZWbA4v74W6fczNCmro8aS2aGQyAf/IWerJVTeeqYD7WsQczaJkRuTPKt6aPvImoRN3VsmJJEDJ396AuggeLNUwS8xTbhjGQlkPOkawpDwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkibj3Gt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkibj3Gt"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6089c0d376eso876150a12.2;
        Mon, 21 Jul 2025 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138785; x=1753743585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qziS/qpONFFAWWmGEcjsGqxLtdqROLsiMhv3HQa+DVo=;
        b=dkibj3GtJ3A72iRfMmZiueDCm448Cts9EW9n8/0z6a9I1KGF45kv+tkxhmqPJiEQAS
         W3fJ9DfMmRIhSLNIpLcN2NdhaJ5Zmu1vuMiFM1u6B0+okMroXwi7PYaHOwGX03Jc8rel
         b31UOVHesoo3uoXxlSl40QQXOxsF4WsLJSXjpL7ifg0WzN5I8Vy1YNdMb8c3Q6T/V/oR
         3WZWDztQy8sto2sY3s8Olf4YEMafKwoF7oR7LdC/O1HVQnDu3ZgXYvG7XCTTzMQu9lr4
         pvoW7uMWLK55OYz+fPbioEkEQxtb9qPL4IdV8AmNRQhfZ4DquMoVdBZqla11G9zPju8i
         07dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138785; x=1753743585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qziS/qpONFFAWWmGEcjsGqxLtdqROLsiMhv3HQa+DVo=;
        b=rDoN2iZ6uAQGVWjUmAy2XrEE6OdQiC/9ha8d9tpE3QT53WYTPkGAu+UANXbwxQE5Vr
         suwChQ5JmxI0gUZyyvYcNcZR/nZGyfRgVhfscSI8UoSH6LFtcALha8w0izB70lr0eBqU
         vZLThutU0/Mn9VOC/SoiHNSC0a5hIQIGA11iKYQS4JJ/vPWtJkRwWdfx0GB2oXXsPuDZ
         ZruI5MR6xNjBTLq6GodZdK3lmFyGrzDvZ6H7S+dUYRtYWyxGKvWOifpCwYV2W5PsUrs4
         7cYY6eaMwTEjqFq+A/rKfTXwDBG/9/Klv6R0PU5rbqKlHA3X3CInVjU3t5FqyWF/T0KX
         WXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE64Yu/zqi4aQhkHNjEPLqmPmXGNpiBdOjEj6+h3+H4qsJwO6wxEksCL9o/CoVnteKWCHVemDqhRMLjQ==@vger.kernel.org, AJvYcCUmV2+ytcbQirMXJTvznRb3T/sdX0yduaS1oqaKXPCOdldZI6WezaZ4H/2sYXi0vj0FZuK8u5jm9Wur4dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHIqQ/Kdw68RMCVtJ2a5s91UzrtVx7rDuAsn9VxTSCsgWtxU1v
	CAOuMcVeywKF0FsD6nwDZGDrcMzAHaSNEZGcIOAMhdb3t/8eBcFo2f0dZzsVuGyALDc=
X-Gm-Gg: ASbGnctu6ynzt5O8682V39paxkhvbBd2QtGit2PsQQCItWX9mBVApBUISSBqQU9h2BX
	P72Aphtp3RTnkb8KcgvC4WFSinp6iP8flOsYCGii0KNMGlsCJS+sJ9WvMJ/ly5NC2zrkejsSFvZ
	7bTqzQbKeoac1ZnS5WxTtkuRdCIILmQBYWrDy7TRHRGJ3wgkimQpumgfmmwN6mdCrO7+MHUAz1z
	HX3x0lbaPakwF7Ube4edGfp1D1DSfPWJUO1VgXjNac+tNyLAu44ARweHON70bTn2ltg3E1WgGGP
	IgrFrgnrzKA5euqzhA2Efwtfqbdft5xzr8ERzPoP2ZaQpiGBHnUys+h1Q+QBXFhuCYlNnzwxTSJ
	AZZhHGZ4FFqK0IKqOS4DPx2BbWUlqQy/9Hrr1yFI+mB7D69kcx4foe0547o7MCvWMFEIA
X-Google-Smtp-Source: AGHT+IFBO2iP/n38Feyyqa7ON62IpV2R/kvBKzJAAeBv02jcMXCr2o0KVEmn950sS2xc+ad0bPTgUA==
X-Received: by 2002:a17:907:1b05:b0:ae3:bd92:e6aa with SMTP id a640c23a62f3a-ae9c99adb7amr852181266b.6.1753138784434;
        Mon, 21 Jul 2025 15:59:44 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7d330sm755829066b.126.2025.07.21.15.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 15:59:43 -0700 (PDT)
Message-ID: <f10f3599-509d-4455-94a3-fcbeeffd8219@gmail.com>
Date: Tue, 22 Jul 2025 00:59:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] kasan: unify kasan_arch_is_ready() and remove
 arch-specific implementations
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:

> === Testing with patches
> 
> Testing in v3:
> 
> - Compiled every affected arch with no errors:
> 
> $ make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
> 	OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
> 	HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld \
> 	ARCH=$ARCH
> 
> $ clang --version
> ClangBuiltLinux clang version 19.1.4
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> 
> - make ARCH=um produces the warning during compiling:
> 	MODPOST Module.symvers
> 	WARNING: modpost: vmlinux: section mismatch in reference: \
> 		kasan_init+0x43 (section: .ltext) -> \
> 		kasan_init_generic (section: .init.text)
> 
> AFAIU, it's due to the code in arch/um/kernel/mem.c, where kasan_init()
> is placed in own section ".kasan_init", which calls kasan_init_generic()
> which is marked with "__init".
> 
> - Booting via qemu-system- and running KUnit tests:
> 
> * arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results.
> * x86_64 (GENERIC): no regression, no errors
> 

It would be interesting to see whether ARCH_DEFER_KASAN=y arches work.
These series add static key into __asan_load*()/_store*() which are called
from everywhere, including the code patching static branches during the switch.

I have suspicion that the code patching static branches during static key switch
might not be prepared to the fact the current CPU might try to execute this static
branch in the middle of switch.

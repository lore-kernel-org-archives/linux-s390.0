Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1FC28C2BF
	for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661949; cv=none; b=R4UMmojRyR/SmSQ6ETjKZYcUGAZNdv/ivO9Iuo4JR8dJ+GoWpy40ZrpieNAG5G178EyQavSsn0JXDzai2cKDZSKORDR9MoTNJUg+4NfWoXKxDZmaWyfcqY9RCN7HVIFYB4j3zixjuIF/6TPzPgRsZTztURITmM1bHGIclto2iMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661949; c=relaxed/simple;
	bh=71IExVGtWUCM2N3COEM/mV1OmBFUH7sMjuEBU+ua+FM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSVApNuFJ3be1SrPDpy5yLE9eRhI0C6PU2s2BR1ALCpW/rq+riDkghDdY03dC1PBVcQe58YLIJXOfowMZEp7QKVEw01L1dQjAm7d05nfrNa6aQdptA1BdzmCucNo7M3QYQBtHC9fQA+syjA2dFG4Wa6KjAY5l/K+ADXhDeHYxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US4mxDzj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US4mxDzj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso39305455e9.2
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773661947; x=1774266747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1FINDvU0UxUqjZlFZpZ58KZuPwMyU/XPMlyrs5R8Wo=;
        b=US4mxDzj1u8+TAMALm1jZ448UnUuwWyAVE3wFja/RD1q1QzX+/se20WkWNcfOWzG+t
         B1mrDo4Bw/bj8+nUpbAD9rs1PrxI73TEH87/lKaGX+uR+aMBxC3VaqdfXYoAzEPPFXc5
         ynXXBu23fz0QHeB1CPeeFLPSZZTkz8x+i6Iw6ybmQdS5LkMsD+GQNFdEw+Sp5sRVokeW
         P4e8FWFyPvZVcmsqr4FlC3Li/UcHaZjxrOmHVnB4mkxCbOFOIb5ydZAaPwSL9cEx1Vnc
         7ZdIsU7fSQiSZj2a0f/QFLMdbiIQAiG4r6sjLxgFxUCN2Cq88glz0RgP0DL9exaClzT8
         2zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661947; x=1774266747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G1FINDvU0UxUqjZlFZpZ58KZuPwMyU/XPMlyrs5R8Wo=;
        b=qDEgHQvdigVcl3GI2CeWDMDTqzbP0NGxpqASpHhZGo0UHPTbAnRD86ak2NugaPyIIG
         OpAl6F2tnxgSesDqUSv0OPyikk8mgTXOCtKRHw5jFboe1AuQ25Qq9r+ooHopgOygIGGd
         DrNmXVkjuxp4nJirGwjsn/0/VerCfbWgCV6ogyClG+BlmIjESB117iEDpeHAH2YsvxND
         fAvbF9hjqHAyspj/fBX0RLUkfnhSuyV/wQI6xPgK3BGZmnToNCMP2/qmgrFVNOYUPS63
         224O6c9jMKdTrPWnKGH3tKmJXUHHvUOozy8hps1WnwAUx80b1gmsorUqLqVqIcK2oIGw
         Sozg==
X-Forwarded-Encrypted: i=1; AJvYcCUrQ/QkKaXVJaYMewXrRinvs5IAkcimZkHdFYY8MDEkzPdRjSIwrYb7Z8K3ugZLk75fGp/MbHcno2Db@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/mCrVSpA1C5uKOsQS4nzV9iCxx1uvhq7vcNiONZBu8ct4jLs
	KKjJIl9zWg39aAg/YZA3isU7Dlnl75gHIFGMNyDHpybkI3ydeCOpNq/AHGq5Ol3x
X-Gm-Gg: ATEYQzygbzM+nBJEUhO6jQWKI8ne6f5Oi6IOqab95HmCnXa6+fBsVrjdUCS9zupHcwr
	4w4p8fs5aUqlhOyJcZJi+/9gPa6djU6AIe4S8fFGiCmBQTthlvMW3xTcwpnisXVZkAJca5TYsHM
	RsIB1iJ0VA5vG0esJn6K78AuxZlv0uvlpKGPGFGzvYENBVPuXcZxcsP98pJg2E2DCgmwIIuXfif
	LwpPNXy09e3h05un3AAg/6ZnDojUjJVRAmwhoVkGvpIdfvwBo9p2Wb+N3p2izpY1/JpmCKN+vGr
	RDeH4PnSE2QGMP6iEXbbCrPvlGKXTdFKWmN5cRLbDRM+wl14gGRsXKcW3VBN6yMdTCCY3sgMeLb
	kTtst3Ntz4VZmPcVrTnWnTfAvd7Rj8KdkIyskqQF/CBiwNhY7rtVwl0yHEE0RZBPFWIZzxivVLO
	wMJgoh2QMtu8/fBtBsMplcmqXzSID3FapCaPJk7AzBTV9dFGQ4rKqmuAEkB9g4lnJ9
X-Received: by 2002:a05:600d:844f:10b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-485567029cdmr158924705e9.26.1773661946379;
        Mon, 16 Mar 2026 04:52:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f255sm525678625e9.12.2026.03.16.04.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 04:52:26 -0700 (PDT)
Date: Mon, 16 Mar 2026 11:52:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, =?UTF-8?B?QW5kcsOp?= Almeida
 <andrealmeid@igalia.com>, <linux-arch@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>, Jisheng
 Zhang <jszhang@kernel.org>
Subject: Re: [RFC PATCH v2 3/7] arm64/runtime-const: Use
 aarch64_insn_patch_text_nosync() for patching
Message-ID: <20260316115224.036e0351@pumpkin>
In-Reply-To: <20260316052401.18910-4-kprateek.nayak@amd.com>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
	<20260316052401.18910-4-kprateek.nayak@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 05:23:57 +0000
K Prateek Nayak <kprateek.nayak@amd.com> wrote:

> The current scheme to directly patch the kernel text for runtime
> constants runs into the following issue with futex adapted to using
> runtime constants on arm64:

Doesn't this need to come before the previous patch?

	David

> 
>   Unable to handle kernel write to read-only memory at virtual address fff0000000378fc8
>   Mem abort info:
>     ESR = 0x000000009600004e
>     EC = 0x25: DABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x0e: level 2 permission fault
>   Data abort info:
>     ISV = 0, ISS = 0x0000004e, ISS2 = 0x00000000
>     CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>   swapper pgtable: 4k pages, 52-bit VAs, pgdp=00000000420a7000
>   [fff0000000378fc8] pgd=18000000bffff403, p4d=18000000bfffe403, pud=18000000bfffd403, pmd=0060000040200481
>   Internal error: Oops: 000000009600004e [#1]  SMP
>   Modules linked in:
>   CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0-rc6-00004-g7e6457d29e6a-dirty #291 PREEMPT
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>   pc : futex_init+0x13c/0x348
>   lr : futex_init+0xc8/0x348
>   sp : ffff80008002bd40
>   x29: ffff80008002bd40 x28: ffffa4b73ba0a160 x27: ffffa4b73bd10d74
>   x26: ffffa4b73cb68b28 x25: ffffa4b73ba0b000 x24: ffffa4b73c66b000
>   x23: 0000000000003fe0 x22: 0000000000000000 x21: ffffa4b73bd10d74
>   x20: 0000000000008000 x19: 0000000000000000 x18: 00000000ffffffff
>   x17: 000000007014db06 x16: ffffa4b73ca3ec08 x15: ffff80010002b937
>   x14: 0000000000000006 x13: fff0000077200000 x12: 00000000000002b2
>   x11: 00000000000000e6 x10: fff0000079e00000 x9 : fff0000077200000
>   x8 : fff00000034df9e0 x7 : 0000000000000200 x6 : ffffa4b73ba0b000
>   x5 : fff0000003510000 x4 : 0000000052803fe0 x3 : 0000000072a00000
>   x2 : fff0000000378fc8 x1 : ffffa4b739d78fd0 x0 : ffffa4b739d78fc8
>   Call trace:
>    futex_init+0x13c/0x348 (P)
>    do_one_initcall+0x6c/0x1b0
>    kernel_init_freeable+0x204/0x2e0
>    kernel_init+0x20/0x1d8
>    ret_from_fork+0x10/0x20
>   Code: 120b3c84 120b3c63 2a170084 2a130063 (29000c44)
>   ---[ end trace 0000000000000000 ]---
> 
> The pc at "futex_init+0x13c/0x348" points to:
> 
>   futex_init()
>     runtime_const_init(shift, __futex_shift)
>       __runtime_fixup_shift()
>         *p = cpu_to_le32(insn); /* <--- Here --- */
> 
> ... which points to core_initcall() being too late to patch the kernel
> text directly unlike the "d_hash_shift", "__names_cache" which are
> initialized during start_kernel() before the protections are in place.
> 
> Use aarch64_insn_patch_text_nosync() to patch the runtime constants
> instead of doing it directly to allow for running runtime_const_init()
> slightly later into the boot.
> 
> Since aarch64_insn_patch_text_nosync() calls caches_clean_inval_pou()
> internally, __runtime_fixup_caches() ends up being redundant.
> runtime_const_init() are rare and the overheads of multiple calls to
> caches_clean_inval_pou() instead of batching them together should be
> negligible in practice.
> 
> At least one usage in kprobes.c suggests cpu_to_le32() conversion is not
> necessary for aarch64_insn_patch_text_nosync() unlike in the current
> scheme of patching *p directly.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  arch/arm64/include/asm/runtime-const.h | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
> index 4c3f0b9aad98..764e244f06a4 100644
> --- a/arch/arm64/include/asm/runtime-const.h
> +++ b/arch/arm64/include/asm/runtime-const.h
> @@ -7,6 +7,7 @@
>  #endif
>  
>  #include <asm/cacheflush.h>
> +#include <asm/text-patching.h>
>  
>  /* Sigh. You can still run arm64 in BE mode */
>  #include <asm/byteorder.h>
> @@ -63,13 +64,7 @@ static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
>  	u32 insn = le32_to_cpu(*p);
>  	insn &= 0xffe0001f;
>  	insn |= (val & 0xffff) << 5;
> -	*p = cpu_to_le32(insn);
> -}
> -
> -static inline void __runtime_fixup_caches(void *where, unsigned int insns)
> -{
> -	unsigned long va = (unsigned long)where;
> -	caches_clean_inval_pou(va, va + 4*insns);
> +	aarch64_insn_patch_text_nosync(p, insn);
>  }
>  
>  static inline void __runtime_fixup_ptr(void *where, unsigned long val)
> @@ -79,7 +74,6 @@ static inline void __runtime_fixup_ptr(void *where, unsigned long val)
>  	__runtime_fixup_16(p+1, val >> 16);
>  	__runtime_fixup_16(p+2, val >> 32);
>  	__runtime_fixup_16(p+3, val >> 48);
> -	__runtime_fixup_caches(where, 4);
>  }
>  
>  /* Immediate value is 6 bits starting at bit #16 */
> @@ -89,8 +83,7 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
>  	u32 insn = le32_to_cpu(*p);
>  	insn &= 0xffc0ffff;
>  	insn |= (val & 63) << 16;
> -	*p = cpu_to_le32(insn);
> -	__runtime_fixup_caches(where, 1);
> +	aarch64_insn_patch_text_nosync(p, insn);
>  }
>  
>  /* Immediate value is 6 bits starting at bit #16 */
> @@ -99,7 +92,6 @@ static inline void __runtime_fixup_mask(void *where, unsigned long val)
>  	__le32 *p = lm_alias(where);
>  	__runtime_fixup_16(p, val);
>  	__runtime_fixup_16(p+1, val >> 16);
> -	__runtime_fixup_caches(where, 2);
>  }
>  
>  static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),


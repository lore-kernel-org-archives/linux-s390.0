Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4204039182D
	for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661837; cv=none; b=rtGPiN/KvVk22dUm1pUWzvvxmWk8K3+k7zfyWD+Q7N0Ni1LpC7NCNflIB357e8oAQPYNXSXApPQiiuG5gIRO8Ms8VDaizJU0QmYjfjCC9hBrBRR6H/L9g3FXTLYWUbFF9QlOay+xcdWSfuCFzmqDSeSYhwpoy6Z+8TdUm5JsZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661837; c=relaxed/simple;
	bh=uPHgjUUn8VsVJXlffrTlOt7/AdJOHet4wTx4z9k4RXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqGky5JW47O9IrM9sZIvmRqG7IMKNBfbHvodwdxIG2m0xFlXW+QI1G8zjBH7snSefwFSVvN46yCUQo4G86T1/tjjwhJ83itbbaSm+vAKw90jkF0U3oS1vtZjaSAFXUQrljD3mFJOBVaPc4YRpYWZsv/gZCcBSmbWFCFiYVioZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwiqZVr7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwiqZVr7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso37224345e9.2
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773661832; x=1774266632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kQhGtTK/Lt5/UNF5mERVigZml+1Hw4HwS17dAwaToA=;
        b=ZwiqZVr7kcG9m9YwtSy2CrLxZrMtxdPcTH/eDgk7vFYWMzcW9j5M+p9jUjxoIFNL2K
         E4AtTAMQLyMWS/UDG5nc5iODFtuFsBIy9eq6/4EXgM5yAk3MBGnMuPRKdxDkFn1LNTBJ
         fSbTkRQgemYKibMW9rLX/S2/QN5sTR/1mzTHM4bSUJIWL1nM6dRQumo4TCPiwcQjSp+i
         PaJEDR8kCf3ahkytXox4yN/gKCdiQWIvLrDohBXOPm3zelLy4lLcu4/pjlocwnkvvwxd
         7/OU0z3UtS1p1uocTIK6IJwRrUqf1l+ApOTUxk/dWHg9UUhEgYKqY4yOqpOunAsLNO9/
         L3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661832; x=1774266632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5kQhGtTK/Lt5/UNF5mERVigZml+1Hw4HwS17dAwaToA=;
        b=IAjVu3PBgXhFDlmq1D7QMVjuMzAWKJgO6kJneCj4RgNtUAQ4V8jGkHmQfOpCFhSxd+
         9Jo5Icz5iLC8Je6T8nsQE2PstjEQLzoAgAGtAIep0M48YWdKFeyhqcErVmFbPAjbJSE3
         FXrq7J58GENyQtVt4icgpFK36V8m9vknWV6qbYeZyNd0srpyeFAUA2+1MVe88Ikk1I8u
         qM7dntrtTQP1sL5HlkL/Ocrvqqozy1gtC2jcTxyCaLfeb1NK28lI7pfncjTsEUotitzf
         gpo6m4M+Zy6Z5A7NiXx3rfWQs2FzkhS6Lo+ibjyoS4yAqCcIfr4sNi0cp4q99myYpPGr
         +ZOw==
X-Forwarded-Encrypted: i=1; AJvYcCUYCrTSjYPRbx39+niDHTuC13JoRoAXqIHU/1y3IPRf7ybABFG165Zu1Izaowf7rbRdZQeGdmnHBgOC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BtmJAcIjiXa/VGkNOcWjwkPWEXZT5AUYGOQQ8qTmw7xH/EDN
	F7aB6i+k8GY4V2HhIwjuYNXcmjTd1p9i8kUw4u5q4+RATFybzbXXZTY/
X-Gm-Gg: ATEYQzyMkoo/xhmievV6F6XWPorGy/NGGi9xTDxYnwsPEPllm9ihS2gpK8f+7Sv+Mur
	3WKYBFrbzdL9j6hvsMruFN3klt5SMaA+cqhtiPcmn0FN1czDZZ/txajwHnBLkg2QnddFlUEewIy
	O6McyR80neuf9FD3/Mc451oV90Le/NqJblYbTOsfwaBUjn4c3NDYEe5mAbtmMsV+82n0FfXtkJv
	yClLkYryyXoU7LTpFHSoTMDifHGAS7s6En3vhivoCLx79RvnzfSm3U+upPA/NNhXnE1V/PmdjNw
	lkkhFiWIHf8vbhREBNhpKcBL363apUuWIcr/tYNCutdJiFFVpckAnsdKPqTJH663+4CrTwSJ2X4
	5w6ySpoJG72IAxARYh3T/U1TJoBfvMVljVyNgMg7+kUJ8+aRDXZoxILDC48gL0VoASZfAYuuPLx
	9cJx+kU+66t6pRvwu3FiH0Jiz4hvo7g8XmUdEdVXDj431QKRt8Kdrg6XF66EO+f2mJ
X-Received: by 2002:a05:600c:1e8b:b0:483:b505:9db7 with SMTP id 5b1f17b1804b1-4855672ada8mr206704535e9.32.1773661832366;
        Mon, 16 Mar 2026 04:50:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm421847035e9.0.2026.03.16.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 04:50:32 -0700 (PDT)
Date: Mon, 16 Mar 2026 11:50:30 +0000
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
Subject: Re: [RFC PATCH v2 2/7] arm64/runtime-const: Introduce
 runtime_const_mask_32()
Message-ID: <20260316115030.6988ad62@pumpkin>
In-Reply-To: <20260316052401.18910-3-kprateek.nayak@amd.com>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
	<20260316052401.18910-3-kprateek.nayak@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 05:23:56 +0000
K Prateek Nayak <kprateek.nayak@amd.com> wrote:

> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
> 
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path. GCC generates a:
> 
>   movz  w1, #lo16, lsl #0     // w1 = bits [15:0]
>   movk  w1, #hi16, lsl #16    // w1 = full 32-bit value
>   and   w0, w0, w1	      // w0 = w0 & w1

I don't thing the '&' needs to be part of the asm block.
Just generate the 32bit constant and do the mask in C.
That will let the compiler schedule the instructions.
It also make the code patching more generally useful.

	David


> 
> pattern to tackle arbitrary 32-bit masks and the same was also suggested
> by Claude which is implemented here. __runtime_fixup_ptr() already
> patches a "movz, + movk lsl #16" sequence which has been reused to patch
> the same sequence for __runtime_fixup_mask().
> 
> Assisted-by: Claude:claude-sonnet-4-5
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  arch/arm64/include/asm/runtime-const.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
> index c3dbd3ae68f6..4c3f0b9aad98 100644
> --- a/arch/arm64/include/asm/runtime-const.h
> +++ b/arch/arm64/include/asm/runtime-const.h
> @@ -35,6 +35,19 @@
>  		:"r" (0u+(val)));				\
>  	__ret; })
>  
> +#define runtime_const_mask_32(val, sym) ({			\
> +	unsigned long __ret;					\
> +	asm_inline("1:\t"					\
> +		"movz %w0, #0xcdef\n\t"				\
> +		"movk %w0, #0x89ab, lsl #16\n\t"			\
> +		"and %w0,%w0,%w1\n\t"				\
> +		".pushsection runtime_mask_" #sym ",\"a\"\n\t"	\
> +		".long 1b - .\n\t"				\
> +		".popsection"					\
> +		:"=r" (__ret)					\
> +		:"r" (0u+(val)));				\
> +	__ret; })
> +
>  #define runtime_const_init(type, sym) do {		\
>  	extern s32 __start_runtime_##type##_##sym[];	\
>  	extern s32 __stop_runtime_##type##_##sym[];	\
> @@ -80,6 +93,15 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
>  	__runtime_fixup_caches(where, 1);
>  }
>  
> +/* Immediate value is 6 bits starting at bit #16 */
> +static inline void __runtime_fixup_mask(void *where, unsigned long val)
> +{
> +	__le32 *p = lm_alias(where);
> +	__runtime_fixup_16(p, val);
> +	__runtime_fixup_16(p+1, val >> 16);
> +	__runtime_fixup_caches(where, 2);
> +}
> +
>  static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
>  	unsigned long val, s32 *start, s32 *end)
>  {


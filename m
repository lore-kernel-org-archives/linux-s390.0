Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39663F1ABD
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318342; cv=none; b=qBr7JTeqbAfxpo00FzOc5wE1q80oBdp9VYWJ3LrLNdfdoRxHG/4ayth0hFo41dPVPcu/RlZum6a9aIm5W6nTLMphJ9AgdT+Gip6UnloPoeHszQM7Z5f3kLURk4KDuorWlrzHYbzoaqmzN+T9DFMciYr3qpqGmUvxwwDBr1p2KNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318342; c=relaxed/simple;
	bh=bBEIpBUB43BZa53CSuyn25k126QXXsrK9MijXSC+VwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvWl//DyTrav1bQTej0O71n67RWSCLGGMNnuhU+5C/08zTJ9sON7ukr2S7ySECmAQam0QplJiHNtMN3CTwFAbnd40j4TfZ9wmHSWRdGW2sOqdxf4caJW+/j90XPYe1ROqbRtYpb9ZPyznFQ2VJ+5gGzUvlk2VmVg2ByabyjW+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjHUu+hR; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjHUu+hR"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace19so256071eec.3
        for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790318340; x=1790923140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+XCKYNMunQtwjsoXeGr7yLk4ydEdG3nbjO5mlaJXoXQ=;
        b=kjHUu+hRDiAjx/GTeNB7c+y11/uouUMKOLJ7gegIystcmre94e+ZE2VmfY91wwDdoX
         OkmFdlVABrSNSJMyrgI62SAf6Lb6GiGJmsNKKYOCVLyd1SxNrW12Ad0CWg4WbF8AWYO2
         KFez60cTOpOz/gSQ/cgfbRWcPO6qdXlKXrhaXJpZuXpofNFuI47DxCw8Lnf0QC+a6+Ma
         KJDDVzI5sUb4/hpmBeJ7HJGnPlMhlLxJBRDSGGOi4nQcTjZgg+ef0SDoiMVVE4xeFeLn
         jg6VTL43h9kNORo1Mdd2dnFxQ+wuFtQiVP/2VpY8ejXtJEQR3oP/45AQePAhb9zgEgKx
         qYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318340; x=1790923140;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+XCKYNMunQtwjsoXeGr7yLk4ydEdG3nbjO5mlaJXoXQ=;
        b=kFHBEIjQxUk6yUIJTE5f9B6/Orx1RpCpey/cX0KSmGQH5k45edSzN1kowtEkllLbqT
         ehU7qd5SYfKbLKdcfc27iKEIvfV0kY/Vsa5vMrKCQYBO5GaWQPKHl81Sou8gXab8PdlZ
         lqQYQg7CWKwF6eXYu2ScTKuoLUuCtYDgZY3z5/sIYfIfcJqtqN9FvzfK9HM1kBZmWnRh
         b9HzfaVzH2Tdn2VgEz+QA6RhLEXZ7JLHZtLyDTvF2CSXc63pHdZ43mmufKFubZWFI/Hy
         5pCF6JE68dYY338VTgz/5I620VqWGmriIXcVlQNtlWl27M18AcX+Y8DBsjZDyNRCzPOh
         J6zA==
X-Forwarded-Encrypted: i=1; AKwUvBxLPpL82M4JxQKjFpxRgpbNcjdlUpASIc8RrMTkFLca+BDeY/jfrv9bZr3J3pme6sktLHMzFh0RSDxB@vger.kernel.org
X-Gm-Message-State: AFuF++nNKn/EO2rG7KtXzFbFhOK/4Ywrhwf5MWGEDkzQOsAG593aRPc4
	RLB8NTpp8CjvnNdeGrcGdk2BlrbAjVjin71APAgNnpYelcjfADh7yGmI
X-Gm-Gg: AYBFou3OwwmCDtqqFedpQVYMwrOsGe1rGGOd3a6E8BG7QUbWaZWgflAdVgytOr4x7P3
	r1WpOIe1lC6aOdTagxcacIuLnRLIId/o9tzRaQjuNqe84OCq+l6u1lia1bYX7BvDe++qg0sOlgk
	wk90IdSMROp35FglXp6p1v+FcSDvzroeMVI0Aj24Fvn2IvCDs+aVK/+NzghvG/+U92YMs05cI75
	fQkLsBglMQa0opBZdvqEVtZ3C+xWf4KFsJ1ngVE6pE+TEwzqBclnWMr4n+PChYitKT0L9fTfhEZ
	1PLnIEoOJIguCLXr1HZ98zqOoOB+tDjYLPPJ2xSoq9Q4pPZ+BctJ54cMIFuSBCp/eOTuZUJYgq5
	aIOnS1iC5oVk5Reaeod3bm0b7Os3VpWfEo2vxw1bRr/+USEhVt34zEDemJBx4BU12OLrfzO5NLg
	CWkN9puEu+eO2S3c/U76Lib8hFZfc9akywm1VSYKy1G/zvaMYUw9pR1rUWfi/IS2vIBVbh9UEP4
	zbMZIRcl5zNm+E0kuJn7+ozwp3iWyVeA9r/FU8AMLW/
X-Received: by 2002:a05:7300:7315:b0:33b:e9a7:d81f with SMTP id 5a478bee46e88-340031cca3cmr5226961eec.11.1790318339666;
        Thu, 24 Sep 2026 23:38:59 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757f31sm6418823eec.14.2026.09.24.23.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:38:58 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:08:38 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, jszhang@kernel.org, japo@linux.ibm.com, 
	jpoimboe@kernel.org, seanjc@google.com, pmladek@suse.com, thuth@redhat.com, 
	ynorov@nvidia.com, joelagnelf@nvidia.com, david@davidgow.net, 
	fujita.tomonori@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <arYWpnhia9icB-60@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924111557.GP1837346@noisy.programming.kicks-ass.net>

> Untested thingies for arm64 and s390x.
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 914282016069..3d8a969eab5f 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -987,14 +987,13 @@ void do_serror(struct pt_regs *regs, unsigned long esr)
>  #ifdef CONFIG_GENERIC_BUG
>  int is_valid_bugaddr(unsigned long addr)
>  {
> -	/*
> -	 * bug_brk_handler() only called for BRK #BUG_BRK_IMM.
> -	 * So the answer is trivial -- any spurious instances with no
> -	 * bug table entry will be rejected by report_bug() and passed
> -	 * back to the debug-monitors code and handled as a fatal
> -	 * unexpected debug exception.
> -	 */
> -	return 1;
> +	u32 insn;
> +
> +	if (aarch64_insn_read((u32 *)addr, &insn))
> +		return 0;
> +
> +	/* Match ASM_BUG_FLAGS() / BUG() instructions. */
> +	return insn == (0xd4200000 | (BUG_BRK_IMM << 5));
>  }
>  #endif
>  
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index b6ba4465f59d..8bbb082fd5e3 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -26,6 +26,7 @@
>  #include <linux/entry-common.h>
>  #include <linux/kmsan.h>
>  #include <linux/bug.h>
> +#include <linux/uaccess.h>
>  #include <asm/entry-percpu.h>
>  #include <asm/asm-extable.h>
>  #include <asm/irqflags.h>
> @@ -55,7 +56,12 @@ static inline void __user *get_trap_ip(struct pt_regs *regs)
>  #ifdef CONFIG_GENERIC_BUG
>  int is_valid_bugaddr(unsigned long addr)
>  {
> -	return 1;
> +	u16 insn;
> +
> +	if (get_kernel_nofault(insn, (u16 *)addr))
> +		return 0;
> +
> +	return insn == 0x0001 || insn == 0x000e;
>  }
>  #endif
>  
Thanks for this.
lemme test these and i'll send it out after verifying.

Regards,
Mukesh


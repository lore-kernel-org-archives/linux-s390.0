Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E425E3C1095
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626218; cv=none; b=fwwvHDmc/xLtrg1vBkXu2hYD8yaBTYT/NieFc/zpSMp7D8CW5+0dNLpiAmiq6M9VpafZRDVHVnsPPgBDi7C/W7EA3tfOjrEDLUTkK4Zpp80b1GaEwBIuQu9BOANdh1ElVKU4jk8Sm8rFxU0nVgS9KglhOws+4FzB+csLye7oKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626218; c=relaxed/simple;
	bh=jWS6CuM01KL0TKzupA5IpoB96YuuBOzox4OyTj5L3ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etNzbFKGmHQHXPi6IWD57ivhoP8nrEK8ZcPM3yzscEO95nwEVPJ8sNwniOt92LM4cuGG6ZmRYJdXadfT8wNWclKS/lxro7IuVGRbzqOxksyDJdysJcv5J8eDKVawtv7OUAPR652vYLoy8YyMbTrKreUZahRjviGJ/NxM8f4wyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqtr7Pdz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqtr7Pdz"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so126799a12.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783626215; x=1784231015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vcViCEZV9Tm/crNMdaH3VAbncnTvlz/mpQaPDKjBGxQ=;
        b=lqtr7PdzoLi5KIuH+qhR2eo1YEi5HjHV+RwQAXdjt79GdpJVHZuaALcbCbT/1JafLs
         T8acxp7+XV8P2lmNeHETLq28wrIPwjWWYaDLMkxD0/FXnRwWryOkrsQ9MgSmDIa0PfbS
         yxWxCMEcwjqJdNuS70916A3Oay2WO2CNql37nywWZHLHETvBSe0/UeG+W81RmIYCQoIu
         bjgYOte+BOSLllK2sjenPL9QRc7SzNm+OQX3Q6DV2iy+KpqJw0RuURODj52fNPeeMfUo
         JuuWZRnRAFHibkzB9rP28k3hiRvud/ZFbUqpHLQtnWOpQDgldZXdEbsv2Z00ckYwqfp2
         wWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783626215; x=1784231015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcViCEZV9Tm/crNMdaH3VAbncnTvlz/mpQaPDKjBGxQ=;
        b=j7sZ97T0DN1Lii6xqX363UeXToIq3VsrFGZEWOokuSmHeKayeJzvYyZ6XNk4h+C55e
         GhZsIcxCMP/yRcVmuuKulWZ/rMp9xJEJQUaPBrUBvJy42Nba5VzAuojwk+bovZZIklZ9
         t/vuqoBG+zMc4clPfWWfCbxlmCzMgwe7S45VPgI90D1efQvjv+udGrDx1d/vDcIkpkCD
         dZaKc6rjJMCm9C6mew9o24Z2Kc+KSlUJHLTT9FMGyOKHj1Zd8CCjgpc23pb/f0iTe2Vc
         m7BnkkxefPzTowpplZiNOQMFTsgp10j93bgav4fYztcUrGJn96CNM+F8rtISBEUMNG9H
         jrgw==
X-Forwarded-Encrypted: i=1; AHgh+RoVkdtGCZaiHTcdsjJ5WlbO4X7SSh6I6vYqLeNguXf3XtXIjEIentqc7SCL77beYPq0jeIxI7N0M+7x@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQuf7gKz+eQlInTLGvPDMvV67PD1XkeK1ZsFgevBmZc3Zmyqd
	xXaGRuMA8EFc4OGQunYNGyREcGbGn01BkoVjwfEsDVqbRAJOy4qPyUSW
X-Gm-Gg: AfdE7ckvEvrUIMWuGWDdUo9moQ7tDIt2BcXrZ90BJM0a2PwfjlrhcHfF0HpYkGpNA1g
	enFRXmZT7oDghryyeXbG2sn4XVClLh3nq455k0dxwbovfjz+t69aw7foU+auIKgHsuq17+uEu6V
	jJ5tXXhbaqIitliDzGMGgo/tS2+aK3KuFqUoUDKfWlCwj5fBKDLye2vM4Qv043Ma//olM5VjvS9
	fqLStjkS7iU8UQys2m2X1jW2h4fnJ+dh5YY/bvhhAf0/FaH4SZ9+7vwsgXsmxw7blhK6QVc/6rP
	87saaV1x+xRfCBQxC36hUxYKaNyA8lERrEmWB6BBDLEOX2qRC47TL4htw26yRpz1aPNX3FJ/w0a
	71p/WXkFOjLg+qzahc6RyLxRx5KvKxIdZYS4NskXdRSnQmzisZpLem5EOif9hs6Kwa2J0RQV4wl
	WR+pOyuxXpxQ1coiyh1O3zTxRRNw4ODIOgVCiODo0FgAEIrmmsHb0oq0PvpQEK
X-Received: by 2002:a05:6a21:6daa:b0:3c0:9c1a:8949 with SMTP id adf61e73a8af0-3c0bd287dd3mr11145411637.65.1783626215188;
        Thu, 09 Jul 2026 12:43:35 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c9a1sm39667491c88.2.2026.07.09.12.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:43:34 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:13:15 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 15/18] x86/entry: Make syscall functions static
Message-ID: <ak_5y-p4DPztR-CH@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.438361565@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.438361565@kernel.org>

On Tue, Jul 07, 2026 at 09:06:57PM +0200, Thomas Gleixner wrote:
> They are only used in the respective source files. No point in exposing
> them.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  arch/x86/entry/syscall_32.c    |    2 +-
>  arch/x86/entry/syscall_64.c    |   10 ++++++----
>  arch/x86/include/asm/syscall.h |    8 --------
>  3 files changed, 7 insertions(+), 13 deletions(-)
> 
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -41,7 +41,7 @@ const sys_call_ptr_t sys_call_table[] =
>  #endif
>  
>  #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
> -long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
> +static noinline long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
>  {
>  	switch (nr) {
>  	#include <asm/syscalls_32.h>
> --- a/arch/x86/entry/syscall_64.c
> +++ b/arch/x86/entry/syscall_64.c
> @@ -32,7 +32,7 @@ const sys_call_ptr_t sys_call_table[] =
>  #undef  __SYSCALL
>  
>  #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
> -long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
> +static noinline long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
>  {
>  	switch (nr) {
>  	#include <asm/syscalls_64.h>
> @@ -40,15 +40,17 @@ long x64_sys_call(const struct pt_regs *
>  	}
>  }
>  
> -#ifdef CONFIG_X86_X32_ABI
> -long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
> +static noinline long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
>  {
> +#ifdef CONFIG_X86_X32_ABI
>  	switch (nr) {
>  	#include <asm/syscalls_x32.h>
>  	default: return __x64_sys_ni_syscall(regs);
>  	}
> -}
> +#else
> +	return -ENOSYS;
>  #endif
> +}
>  
>  static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
>  {
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h
> @@ -21,14 +21,6 @@ typedef long (*sys_call_ptr_t)(const str
>  extern const sys_call_ptr_t sys_call_table[];
>  
>  /*
> - * These may not exist, but still put the prototypes in so we
> - * can use IS_ENABLED().
> - */
> -extern long ia32_sys_call(const struct pt_regs *, unsigned int nr);
> -extern long x32_sys_call(const struct pt_regs *, unsigned int nr);
> -extern long x64_sys_call(const struct pt_regs *, unsigned int nr);
> -
> -/*
>   * Only the low 32 bits of orig_ax are meaningful, so we return int.
>   * This importantly ignores the high bits on 64-bit, so comparisons
>   * sign-extend the low 32 bits.
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

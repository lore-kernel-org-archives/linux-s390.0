Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DA3C5DB6
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626593; cv=none; b=RecYpN1njk3PXLX7m9CC3DTvBaPzYWv5WA4YRAQ+53TLZzr/1dStajk1IWgWMQPcel7fn22K42Q37ECN+5JT91VL1rTNZQIsOsKS+zGD5yfvZZQuejQnNoKPTXuuyRrLoZg1vVVoPMtQ7njwKcvfmK/B0fG4LP8MeuDvwn3Ljzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626593; c=relaxed/simple;
	bh=O3SPqd0FCeHdHAXnIs2zdCH8B3mqG0zpsrqZGFxlKyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0Z5jF6b5hL5mGa5oQoynixM9n0GkEJhtoiybQNGF8BS3xFu/p+2RQ/ULmdo+6WhwYOK3l3dwTY00wDIk/EA17SoZDyHVKAFXdgKh1P2ITCVSIaS85p00MJxQz5nVKbJbQypNvnUfGBR2NIbQnrEOzn5tIUQKWCNSryUgKCBKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYxJw6Hc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYxJw6Hc"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso126489a12.2
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783626588; x=1784231388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wZIZ82kjBIDu2ZrVW8MGg3L6TnunPhQvQy9pezlSzDk=;
        b=WYxJw6HcCAitSLvAoPRMBNHwW+ITldVYEYwVbun6ncnSFOrNKsELQKcri5qgmxHOkB
         wx4QogG01yDYzDdHkp/mpFkmQCGSfktkvYF8Ar4ZY35orteCaCRNgN2dRnl5A81LFENw
         /sC83P3xh0ItVrrU4HfpPSVp2Du4fdaFlbH+BjRMtpXQPLwbehjpYIeWuv2rw2hKroeh
         xZSB1yaC63igCnNCW8JN7DTFTMZcbY/BFUAs4siWW6cHKuEViOL3j5jDKKjRa3Kt0HZ6
         thrSnh95sdyOsIxKXrIhYY2z3cA31v9pxBmoecM2y9uDvVOsyt04Ofj8nhka26E9dvhq
         ZY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783626588; x=1784231388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wZIZ82kjBIDu2ZrVW8MGg3L6TnunPhQvQy9pezlSzDk=;
        b=HAPutti1c3ayIauZ0U/w0nmrjXgjsW5hMYfSS0Ipk1J99CKcEQb+XWmKbO7mARTYka
         PBXg66+V5cIi4o+qXvlTOMkC/CVbTVE6PUy4Rly42CPV1tZJd+5Gbx6BjdP0My54CMXP
         AWBNxEWJOusPRDIFyamuymoGJpESaq29U2+D4qlJAAVPlUM8b9l5Pf1Wc8GWnLiIAzem
         o4sf65TTabZO2XPJ1Co3VmOdJT4XsHLsgl3b4j/E26X7hDdLiTec9g2NgkgF+EH+erTX
         NTQrI9AXY3M1+3z5WAjus+zAwepkotvgtVy+cDuebJnsgCmUYhqRNZYEIWEV4AHPv1i5
         rXHQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNYElMXKzxvxyBuvYR3GGC/q7qPdwgSnL+4AncdK8KaQqAKrDA5ohUtrpTmh4Qgm3ZqOAgRxUCQ8Uw@vger.kernel.org
X-Gm-Message-State: AOJu0YwyhYyyTQqiKMHkTavamGVyaTFegqUxDuR0QZccK52tFV3wJjKS
	IrUBmSCS8r1px5BnidPVte0BujmOp0Gs83yrHHoSmVkYC7hyffPscyrx
X-Gm-Gg: AfdE7cnyqDj32+D04MkqSXUq2zG49PThRtKMk6TAdvRpeL7NOTApTQfJ2S1kxe37Mzj
	gGMyCV3ygDRZT70BQZbReIxBAlQ/vqquGbQrDNrV+3DzoO1or7FwFGJlfoA4IHQwfXYBLrSI7Au
	USO6+ya0itr74PlguX8GTcoliPSA+0HajWx27j+Ms/GzW1foVCePuIwsFLRChkBjefN+KjmAvQX
	l8THuxzfqUNy0rCeK8ILYK47G9twy+AeO/l/W8pmKlfLGNNpV/zGyDTu03ACoKLoJ6FsJqWVgsM
	qSRjNPjoS4kOMi5JiiSt/THE4zD4xkLG+hcbTC4drvY/fkQwmQqQLdTzDQ/7KmhwEgd+oxgRFYl
	PwMM7Zb7IUuMWVa+RusV+T+bKRXMuw7mOrOkLosqByS3yScqr2NS5Jjd+G+PwPpSih2NXyPoJpq
	VJap30i8Z0WfaMs/YtOzy8SNDwzz9+Rydxc/LgHd7js8xNpivT+rkiGINXhpAk
X-Received: by 2002:a05:6a21:512:b0:3bf:a0e5:999f with SMTP id adf61e73a8af0-3c0bcfab03dmr10300238637.22.1783626587867;
        Thu, 09 Jul 2026 12:49:47 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm34548981eec.16.2026.07.09.12.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:49:47 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:19:28 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-doc@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, x86@kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org
Subject: Re: [patch 18/18] entry, treewide: Make
 syscall_enter_from_user_mode[_work]() indicate syscall execution
Message-ID: <ak_63WGVz28C2dc0@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.603111179@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707190254.603111179@kernel.org>

On Tue, Jul 07, 2026 at 09:07:09PM +0200, Thomas Gleixner wrote:
> From: Michal Suchánek <msuchanek@suse.de>
> 
> The return values of syscall_enter_from_user_mode[_work]() are
> non-intuitive. Both functions return the syscall number which should be
> invoked by the architecture specific syscall entry code. The returned
> number can be:
> 
>   - the unmodified syscall number which was handed in by the caller
> 
>   - a modified syscall number (ptrace, seccomp, trace/probe/bpf)
> 
> That has an additional twist. If the return value is -1L then the caller is
> not allowed to modify the return value as that indicates that the modifying
> entity requests to abort the syscall and set the return value already. That
> can obviously not be differentiated from a syscall which handed in -1 as
> syscall number.
> 
> The established way to deal with that is:
> 
>     set_return_value(regs, -ENOSYS);
>     nr = syscall_enter_from_user_mode(regs, nr);
>     if ((unsigned)nr < SYSCALLNR_MAX)
>     	handle_syscall(regs, nr);
>     else if (nr != -1)
>     	set_return_value(regs, -ENOSYS);
> 
> The latter is obviously redundant, but that's just a leftover of the
> historical evolution of this code. S390 has some special requirements here,
> which can be avoided when the return value is not ambiguous.
> 
> Now that the functions which modify the syscall number and want to abort
> are converted to indicate that with a boolean return value, it's obvious to
> hand this through to the callers.
> 
> Rework syscall_enter_from_user_mode[_work]) so they take a pointer to the
> syscall number and return a boolean, which indicates whether the syscall
> should be handled or not.
> 
> That's not only more intuitive, it also results in slightly denser
> executable code on x86 at least, but perf results are neutral and within
> the noise.
> 
> [ tglx: Adopted it to the changes in the generic entry code, fixed up the
>   	32-bit fallout and rewrote change log ]
> 
> Signed-off-by: Michal Suchánek <msuchanek@suse.de>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-doc@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> ---
>  Documentation/core-api/entry.rst |   18 +++++++++++-------
>  arch/loongarch/kernel/syscall.c  |   14 +++++++-------
>  arch/powerpc/kernel/syscall.c    |    3 ++-
>  arch/riscv/kernel/traps.c        |   11 +++++------
>  arch/s390/kernel/syscall.c       |    7 +++++--
>  arch/x86/entry/syscall_32.c      |   25 ++++++++++++-------------
>  arch/x86/entry/syscall_64.c      |   12 ++++++------
>  include/linux/entry-common.h     |   12 +++++-------
>  8 files changed, 53 insertions(+), 49 deletions(-)
> 
>  
[...]
>  	syscall_exit_to_user_mode(regs);
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -18,7 +18,8 @@ notrace long system_call_exception(struc
>  	long ret;
>  	syscall_fn f;
>  
> -	r0 = syscall_enter_from_user_mode_randomize_stack(regs, r0);
> +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))
Missing one closing ')'.

> +		return syscall_get_error(current, regs);
>  
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {

Apart from this.


Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

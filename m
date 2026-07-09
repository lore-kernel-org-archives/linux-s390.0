Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B204499AB
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622981; cv=none; b=Joq4ZVW8VyqTvYEw5XKoW+3yzucNUMzD2kYdBPdX8iAcRrgPkUYZJ9W/1yS/2oZ6IlN+o9x8SVIi5yoCYg4lFZN7bViNfgSh2fHYeCUVMf0mucPD3rvlpTCG9qzQxEhqpS5OCCw7BZCHtsvZCqanvRQGKCFQLa9ipb256E8xUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622981; c=relaxed/simple;
	bh=Vt3AAg3Xfx8+LNeTFAW2+W3Hb+78J4FMQ1nIkkkMzK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DP3EfHFcoDkVumVdL1f94HOpYZwhptIoCB44EKPjzfutwTvNXd8vFk7racswpPZxHsdw/o1iPMbzCmFr3EgICCtIhV/zcm888QB1XjeDj7t6aBSXvbSoagz2AsDZluNHD49sNteAJhxG1IdJOcvViiQOAB+28EseI5b66nQ70gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WseUpRiD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WseUpRiD"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38175907a56so1104175a91.0
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622978; x=1784227778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nwM8hgg0owOvY9szEO+ZJ41xpH48S7vT5kW5bfv9ji8=;
        b=WseUpRiDSW1IwvJgJS8P4KkUNnBWLn7KhUi98d7jYXG6XuXauUVzyeudzSDC80u4EZ
         ZBoh2fncfuh1OfPnEgQH7fpXE0QyODrg5BQaPaqwFRfrKcV3X0xNWeNuXgfxNUQiqSUD
         d/OFMuunwQZHR3xDsSJWX4M7+h9j11+6Lx8rFgnBzZFBWkLVUuS870k5worYzoz5Gcub
         alPI6Q3hla4/AsL7CbHM03wPidOJ+1vPSXO8YuAYWAtkFh/OvWAhECy3/AvwOLZkdlNs
         MdbkqBUXt8hcVLq2nwxmBlIPPS/5b6Igt9XjnTbg440E2N2pGveUWVor5FM5WetWaGVQ
         Tr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622978; x=1784227778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwM8hgg0owOvY9szEO+ZJ41xpH48S7vT5kW5bfv9ji8=;
        b=WQjd+JPZ467kVKhyQJiOCzWkPJQzKxjhheuvuZx63QimC9rhOXnzAVQAiABqJepqdS
         Fbssx8Vp3wAJHy2GOQBHLAL1rWphZrZYTSnm7Bc/jnk0jUdRDoTGSpVSHd4r7A+39q+Q
         +ObC4YXEB2IEQ4NQhJ53Vkt5y3sy1cZ5oAfHDISPPp3/uJdE0RuPMvGcIYWc5aSPN5oA
         tB0pVQxopn5ILm+erA9hdhX9fptfx2RPQkCmFMZIyXmdHXVYQF5LlMQqxPpr3MsyPsJQ
         OzAm2sShT+JTSIYxMFiMiIdFe16BJWCLakMdCtqkNUVUmUrmeqMP7/Pci63Fc1MVCOut
         JVwg==
X-Forwarded-Encrypted: i=1; AHgh+RqjZMgrYnQRWfytd3EO1e3FgLaW+4RQqLp9iYfSWvk/3iv2M2Njia8ZmrHPZuSMq8IbC431VJHw/VHp@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/IDFSgLgddel6my0+DZbEqIcN9JCO8eSOJBV92sYbn1Panls
	gAmqReksc/PFL3Vt86+OFOamAmRicLWD5s9Aegqdyo+W3I1pHLhl3XC0
X-Gm-Gg: AfdE7cm8ITE+JMvBjNaWoJXuvtx20TJJiPRguT/BCg7JkfJf87QkI2jLbG0lrqwZmLQ
	MrOyAqS1K6uniiy7LGCVwQ5ch4cmpfN02VMcswHU7q+4jtbnw2Jw91xoEbjccXh+rRa5qL31ynG
	lO2H987ZvVQ0xanRWlsFwYDtc6NVhCxhMjbq49CmzCXuZ38uHQy3JPvNHk3L1I9O9WjEXUVrCf3
	I/5jTk3CPTeSkdNlKjQKw3EX+SwRcFvMMyvEk2Z+U7xKP8hkW+UXlnUDp9ojHEtdu+gW4d4VbQ7
	KHT4r5cJ4dZMW4DGYhgCIui7AKQRb/9wPRzctecV2qpy+dnyYK18fGkWkHMZ9WfGCXsBzz0oEy2
	WSWEHl5VhQCH45VLlgp9onAi8wZSMjmE1Xo1NIBYhokFmnEADHTtNLJSjGDJrnW7DqRjYEu7I0E
	e/SHSmpfnziOGIwiD6g7qf8fJ2ZsGIdV/ruulnC2WKrG6Bm246tfSx5evm9yei
X-Received: by 2002:a17:90b:180a:b0:387:d9cc:7dc1 with SMTP id 98e67ed59e1d1-38d15c8e9c6mr429024a91.19.1783622978242;
        Thu, 09 Jul 2026 11:49:38 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm37887153eec.1.2026.07.09.11.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:49:37 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:19:18 +0530
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
Subject: Re: [patch 09/18] entry: Remove syscall_enter_from_user_mode()
Message-ID: <ak_tIel1LZh-zlAU@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.132654198@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.132654198@kernel.org>

On Tue, Jul 07, 2026 at 09:06:32PM +0200, Thomas Gleixner wrote:
> All architecture use either:
> 
>     nr = enter_from_user_mode_randomize_stack(regs, nr);
> 
> or
> 
>     enter_from_user_mode_randomize_stack(regs);
>     nr = syscall_enter_from_user_mode_work(regs, nr);
> 
> Remove the now unused function.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  Documentation/core-api/entry.rst |   17 +++++++++-------
>  include/linux/entry-common.h     |   40 +++------------------------------------
>  include/linux/irq-entry-common.h |    6 ++---
>  3 files changed, 17 insertions(+), 46 deletions(-)
> 
> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -68,7 +68,7 @@ low-level C code must not be instrumente
>    noinstr void syscall(struct pt_regs *regs, int nr)
>    {
>  	arch_syscall_enter(regs);
> -	nr = syscall_enter_from_user_mode(regs, nr);
> +	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
>  
>  	instrumentation_begin();
>  	if (!invoke_syscall(regs, nr) && nr != -1)
> @@ -78,12 +78,14 @@ low-level C code must not be instrumente
>  	syscall_exit_to_user_mode(regs);
>    }
>  
> -syscall_enter_from_user_mode() first invokes enter_from_user_mode() which
> -establishes state in the following order:
> +syscall_enter_from_user_mode_randomize_stack() first invokes
> +enter_from_user_mode_randomize_stack() which establishes state in the
> +following order:
>  
>    * Lockdep
>    * RCU / Context tracking
>    * Tracing
> +  * Apply stack randomization
>  
>  and then invokes the various entry work functions like ptrace, seccomp, audit,
>  syscall tracing, etc. After all that is done, the instrumentable invoke_syscall
> @@ -99,10 +101,11 @@ that it invokes exit_to_user_mode() whic
>    * RCU / Context tracking
>    * Lockdep
>  
> -syscall_enter_from_user_mode() and syscall_exit_to_user_mode() are also
> -available as fine grained subfunctions in cases where the architecture code
> -has to do extra work between the various steps. In such cases it has to
> -ensure that enter_from_user_mode() is called first on entry and
> +syscall_enter_from_user_mode_randomize_stack() and
> +syscall_exit_to_user_mode() are also available as fine grained subfunctions
> +in cases where the architecture code has to do extra work between the
> +various steps. In such cases it has to ensure that
> +enter_from_user_mode_randomize_stack() is called first on entry and
>  exit_to_user_mode() is called last on exit.
>  
>  Do not nest syscalls. Nested syscalls will cause RCU and/or context tracking
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -19,7 +19,7 @@
>  #endif
>  
>  /*
> - * SYSCALL_WORK flags handled in syscall_enter_from_user_mode()
> + * SYSCALL_WORK flags handled in syscall_enter_from_user_mode_work()
>   */
>  #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
>  				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
> @@ -205,42 +205,10 @@ do {									\
>  	_ret;								\
>  })
>  
> -/**
> - * syscall_enter_from_user_mode - Establish state and check and handle work
> - *				  before invoking a syscall
> - * @regs:	Pointer to currents pt_regs
> - * @syscall:	The syscall number
> - *
> - * Invoked from architecture specific syscall entry code with interrupts
> - * disabled. The calling code has to be non-instrumentable. When the
> - * function returns all state is correct, interrupts are enabled and the
> - * subsequent functions can be instrumented.
> - *
> - * This is the combination of enter_from_user_mode() and
> - * syscall_enter_from_user_mode_work() to be used when there is no
> - * architecture specific work to be done between the two.
> - *
> - * Returns: The original or a modified syscall number. See
> - * syscall_enter_from_user_mode_work() for further explanation.
> - */
> -static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
> -{
> -	long ret;
> -
> -	enter_from_user_mode(regs);
> -
> -	instrumentation_begin();
> -	local_irq_enable();
> -	ret = syscall_enter_from_user_mode_work(regs, syscall);
> -	instrumentation_end();
> -
> -	return ret;
> -}
> -
>  /*
> - * If SYSCALL_EMU is set, then the only reason to report is when
> - * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
> - * instruction has been already reported in syscall_enter_from_user_mode().
> + * If SYSCALL_EMU is set, then the only reason to report is when SINGLESTEP is
> + * set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall instruction has been
> + * already reported in syscall_enter_from_user_mode_work().
>   */
>  static __always_inline bool report_single_step(unsigned long work)
>  {
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -49,9 +49,9 @@
>   * Defaults to an empty implementation. Can be replaced by architecture
>   * specific code.
>   *
> - * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
> - * section. Use __always_inline so the compiler cannot push it out of line
> - * and make it instrumentable.
> + * Invoked from enter_from_user_mode_syscall_and_randomize_stack() in the
> + * non-instrumentable section. Use __always_inline so the compiler cannot push
> + * it out of line and make it instrumentable.
>   */
>  static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs);
>  
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475031AA87
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628142; cv=none; b=UcuQKXlY+JBF+F8mDnbCyC0kYFt8o2Bt7duUXrDn0XvH7VemA2gr53z0pdnPAqKbloeiECi92U9vjjlOQjVrSs7oAqtjM87J+GFE6x5t1W4QZ/Jo/4jyIDjYxcSOImAPEb4w7tanJbKRbMdekRB4W3/eNL/3N2fO1ndy5ul848U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628142; c=relaxed/simple;
	bh=vDHDpmX/SHzXbqc6X1TB+shIwLpdQz10EZJe4LqT6ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDYeLeMOKrHwewrvv/RYDtKYyf9pk/KUkb1ni5p2iwzd3y1ThOFjOpXsnu9ViyX1ZkKxebsx4AxAe6MZv4u8JqyWhtrAG8Ufb+TtPG8JcWL4GFe5JQ/Bzvub0sRV/Ty/I0tVJIVN720Hq50D1Zp5Bu/Fa+2Ov1rkouz/w/0W7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPcGO3ki; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPcGO3ki"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so171764a12.2
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783628139; x=1784232939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4V4fuwVKw9a+buqSTfOSwTO6Zlt+2k8vx+/ObUQlSos=;
        b=pPcGO3ki8aiA3GFmYvP3IhvWe6YILhYaUEBulmCKeZ+r2KJTGiKNjkWuBhmMdrAZCr
         bIN7si8+TB3Ko4eJJBOKEUm8ErKb3XWJWpBzeB+6uED6h7M5VC7NlQqFytg1IEnbHB6Y
         Tl4YVmDV/pGjBpyr6T22sGOsT93E1DQEu5bjWpEGM/XwbNLQsHu8pYLedW0pJWFjS1BK
         SJcfmUZpOC+qL9SrkwA3m+w1jy7R+wzwPnNl0VlGkQLBg6LqNq90l/CPGNzTtLwvzpaL
         ebSDYixhMSQx0osVC70xVd9HGap9GELh7qdrjHRvv4rlAJdmpNB106P8JEU0ydkpnt6T
         74iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783628139; x=1784232939;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4V4fuwVKw9a+buqSTfOSwTO6Zlt+2k8vx+/ObUQlSos=;
        b=ShwO830wS2aZAsJ2UmfRZ6TthxbgB9L9UerB1L8Bc5ZiWtTah4lwNdFxTo0IBJt2+1
         piVv7d6UZ9sor5AgMa+QBuR1X21YoSapRDb9tkuT+Fj2xYh85J+Sr5aoh4a0QZPphNHb
         SijcHGj/7pvmFs8y15Pv4V3I1rkVxhR4GbgMRVQlcH44a6d3N1GVXodfN7RMx01wiSf7
         P5yq/qiOOdTaAeWAgns7OdCHr3FBVuLKICtn/UZ7642eVNuUD1Etz9IgH9/8Pj/cuk64
         xM7bQQJWiGTBbJknYCnOUvP5L8cYDQlxpV/mHRYbX0MJr/mVXGyCTYqV5XG3YIfmRAH+
         tiCA==
X-Forwarded-Encrypted: i=1; AHgh+RoJygWboz6xwbXXqgcBnpM215F2CfHDjJhrHUaEDlCAl+jXz7QtK8BT5SvBV7rbhO1IJyFq3wq9aUM/@vger.kernel.org
X-Gm-Message-State: AOJu0YxBp5SUGsipdqkTM7ZIrleuitzGY2X58k/u0N6W0vlYQ4osa/Fp
	TT1RCHTDMpWt9WbasIPaczbuZMqeBHUfIaA/HGyc90zn4MOQIZ5EIZ5+
X-Gm-Gg: AfdE7clY5Flk5UgkM+rRO/r5q7uOzSzD7UAzNf2XBnh/nQ1g5IOs6VdbIunlEkXxnlw
	nY9h+qlvnnXP+uPGCUimZ51jFUrnNSwXAhDZx3md6K4vevO1D/z3/ubxeEUU99t6ZdNhb7+9762
	1ySQyo23mgJMxiF33Bww7Z3+YCfmvMy3Zxr+59son8UZPFEVrFEmXivjJAF9/i/LDMubil/IirU
	ZETUkWrcRpnbYKqFJdR4mbjN6+Ah3+g55IBs+Cne7qkAOhUnwSSXByCRQBH2jnvivynwNZzZR03
	eGBfkUPygy5GYQwsRqqAkqwKI7TwyKnLaPDQRRclmmE+YJZSZ8qR7diTr+G1my5rYnuBGZzF5CB
	QG23vopB76gtboeZqCZf0djfdVXF2kfLE5uy4gGmhFXePMhlAuI1xoLJd3pypuTbyw7ozmj4OEm
	65LybomkMqBUCb+L/y6phTZaZSgvYFtquk44hF5jpQ3JiVQTD+dh9V7uGVeOtp0GKKi7Fb260=
X-Received: by 2002:a05:6a21:32a2:b0:398:8870:b58f with SMTP id adf61e73a8af0-3c0bcbe77a5mr11679805637.14.1783628138627;
        Thu, 09 Jul 2026 13:15:38 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3120c8e41fcsm2908315eec.15.2026.07.09.13.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:15:38 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:45:19 +0530
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
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry
 handling
Message-ID: <ak_7lawD_OujooyZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707181957.433213175@kernel.org>

On Tue, Jul 07, 2026 at 09:05:53PM +0200, Thomas Gleixner wrote:
> Sorry for the long CC list, but this is a treewide change.
> 
> Michal recently posted a RFC patch to separate the potential syscall number
> modifications in syscall_enter_user_mode_work() from the information
> whether the syscall should be processed and the return value modified:
> 
>   https://lore.kernel.org/lkml/CE1qW@kunlun.suse.cz
> 
> The existing logic is:
> 
> arch_syscall()
> 	regs->result = -ENOSYS;
> 
> 	syscallnr = syscall_enter_from_user_mode(regs, syscall);
> 
> 	if (syscallnr != -1L)
> 		regs->result = invoke_syscall(regs, syscall;
> 
> syscall_enter_from_user_mode() invokes ptrace, seccomp and
> tracing/BPF/Probes. All of them can modify the syscall number.
> 
> ptrace and seccomp explicitly set the syscall number to -1L to indicate
> that the syscall invocation needs to be skipped and the result has not to
> be modified as it might have been modified by ptrace or seccomp. The
> tracer/BPF/Probes mechanism can modify the syscall number as well and
> relies implicitly on the -1L logic.
> 
> This can obviously not be differentiated from a syscall invocation where
> userspace provided -1 as syscall number.
> 
> The general agreement of the discussion was that the current mechanism,
> while functionally correct is non-intuitive and something like Michals
> proposal would make that code clearer and easier to handle on the
> architecture side:
> 
> arch_syscall()
> 	regs->result = -ENOSYS;
> 
> 	if (syscall_enter_from_user_mode(regs, &syscall)) 
> 		regs->result = invoke_syscall(regs, syscall;
> 
> That discussion made me look deeper into the related code and as usual
> there were a lot of other things to discover.
> 
>   1) Stack randomization
> 
>      add_random_kstack_offset() can only be invoked after
>      enter_from_user_mode() established proper state as it calls into
>      instrumentable code.
> 
>      PowerPC got that wrong and the other architectures either invoke it
>      after enter_from_user_mode() or after syscall_enter_from_user_mode().
> 
>      The latter is suboptimal as the randomization takes place after all
>      the user mode entry work. Aside of that add_random_kstack_offset()
>      uses get/put_cpu_var(), which makes it usable in preemptible code, but
>      when invoked in the interrupt disabled region that's pointless
>      overhead.
> 
>   2) As discussed in the above thread just changing the function signature
>      of syscall_enter_from_user_mode[_work]() so they take a pointer
>      argument for the syscall and then return 0 on success is not really
>      intuitive either. Aside of that this breaks the implicit assumption of
>      the tracer when setting the syscall number to -1.
> 
>   3) The x86 entry code has some historically accumulated oddities
> 
> The following series addresses this by:
> 
>   1) Providing new [syscall_]enter_from_user_mode() variants, which include
>      stack randomization and utilize a new add_random_kstack_offset_irqsoff()
>      variant, which avoids the get/put_cpu_var() overhead and converting all
>      usage sites over
> 
>   2) Picking up Jinjie's seccomp patch from:
> 
>      https://lore.kernel.org/lkml/20260629130616.642022-2-ruanjinjie@huawei.com
> 
>      and addressing the feedback (renaming the seccomp functions)
> 
>   3) Making the ptrace and tracer related functions return a boolean value
>      to indicate syscall permission
> 
>   4) Addressing the x86 oddities
> 
>   5) Converting the tree over to the new scheme
> 
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
> 
> There should be no functional changes, at least there are none intended.
> 
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
> 
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
> 
> The series applies on Linus tree and is also available from git:
> 
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
> 
> Thanks,
> 
> 	tglx
> ---
>  Documentation/core-api/entry.rst      |   33 +++++---
>  arch/alpha/kernel/ptrace.c            |    4 -
>  arch/arc/kernel/ptrace.c              |    2 
>  arch/arm/kernel/ptrace.c              |    4 -
>  arch/arm64/kernel/ptrace.c            |    4 -
>  arch/csky/kernel/ptrace.c             |    4 -
>  arch/hexagon/kernel/traps.c           |    2 
>  arch/loongarch/kernel/syscall.c       |   17 +---
>  arch/m68k/kernel/ptrace.c             |    4 -
>  arch/microblaze/kernel/ptrace.c       |    2 
>  arch/mips/kernel/ptrace.c             |    4 -
>  arch/nios2/kernel/ptrace.c            |    2 
>  arch/openrisc/kernel/ptrace.c         |    2 
>  arch/parisc/kernel/ptrace.c           |   12 +--
>  arch/powerpc/kernel/syscall.c         |    5 -
>  arch/riscv/kernel/traps.c             |   14 +--
>  arch/s390/kernel/syscall.c            |   11 +-
>  arch/sh/kernel/ptrace_32.c            |    4 -
>  arch/sparc/kernel/ptrace_32.c         |    2 
>  arch/sparc/kernel/ptrace_64.c         |    2 
>  arch/um/kernel/ptrace.c               |    2 
>  arch/um/kernel/skas/syscall.c         |    2 
>  arch/x86/entry/syscall_32.c           |   70 +++++++------------
>  arch/x86/entry/syscall_64.c           |   61 ++++++----------
>  arch/x86/entry/vsyscall/vsyscall_64.c |   14 +--
>  arch/x86/include/asm/entry-common.h   |    1 
>  arch/x86/include/asm/syscall.h        |   10 --
>  arch/xtensa/kernel/ptrace.c           |    5 -
>  include/asm-generic/syscall.h         |    4 -
>  include/linux/entry-common.h          |  125 ++++++++++++++++++++--------------
>  include/linux/irq-entry-common.h      |    6 -
>  include/linux/ptrace.h                |   13 +--
>  include/linux/randomize_kstack.h      |   19 +++++
>  include/linux/seccomp.h               |   12 +--
>  kernel/entry/syscall-common.c         |    7 +
>  kernel/seccomp.c                      |   35 ++++-----
>  36 files changed, 264 insertions(+), 256 deletions(-)
> 
> 
> 
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

Boot tested this on P11 LPAR and P9 powernv system.
Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

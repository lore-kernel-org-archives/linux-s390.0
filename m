Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3962F12A5;
	Tue,  7 Jul 2026 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451159; cv=none; b=pkEvgJ/wGEQHYxNTnXDdjRAdNZ6ke0tREY3EjUFeQGyP17E4byRSUqaFmG0xcXuEyqA2krjEvKEwANDQ9XKDbSp6HHkHRhDc0KH03YiiuNba8/qiZW3ZDqUL9fliqA/etdXvesJbA5zZvnK4WFTpOexSr+LCHPs4xeV9VUJTp50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451159; c=relaxed/simple;
	bh=QXLUt1TPzW5KUIfT+EbS13frXZWcSnBhPA0WRti5QHo=;
	h=Date:Message-ID:From:To:Cc:Subject; b=POA9D7ZKW0/zNUHuA5rKB3WkMniTIJteB8EAENg8NhbVwtwBt1fg1LHd6lLxJcr0qlUrf1Pmg0JlU1I6ZWzgY3/UX05uHHb/AeEgLfHkg2qeTewX/n0KReX/MxrzlfZTfT3AJBHZflxvsHuI+ljeIgwraSElD/x/7CLYHHxXlTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFkWTdo5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFkWTdo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113781F000E9;
	Tue,  7 Jul 2026 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451156;
	bh=sKaa6jqJcnZ3kixdUKctGHCLE8bgvUhOgv/iQQ4U2eg=;
	h=Date:From:To:Cc:Subject;
	b=VFkWTdo5yhgpXx9sxvRHZ3HlP4xSZ4aHXa1zsGtMnp9mQpMvU4qieroT0K0+AUmNe
	 mH4Zbvrp37BWRtV+WSrFvOBwzQyMx5YfHARXuOrmubRPkhjAk6NgYYQTWgkAhazAju
	 1djGcOQc2V77x2qVXGFvC6BkwM/+Iezw2J7QhqUY7M9Y5saOvbXsETd73JhuSwTJ1e
	 Hk7rq39ys7eddzm/Skk6nfXmoJIZBJVZnDdD7rbJtFga+XVDyFyYEDjJyfJdP9Y2Vt
	 rb/jER5CfvGmtQfb87VuvQHb1UgZTCkpnw26sWY8rQ0z0x4vkc0U56YUbxw1o0tQkB
	 6sQc63NXlLiVQ==
Date: Tue, 07 Jul 2026 21:05:53 +0200
Message-ID: <20260707181957.433213175@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Guo Ren <guoren@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>,
 Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: [patch 00/18] entry: Consolidate and rework syscall entry handling
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Sorry for the long CC list, but this is a treewide change.

Michal recently posted a RFC patch to separate the potential syscall number
modifications in syscall_enter_user_mode_work() from the information
whether the syscall should be processed and the return value modified:

  https://lore.kernel.org/lkml/CE1qW@kunlun.suse.cz

The existing logic is:

arch_syscall()
	regs->result = -ENOSYS;

	syscallnr = syscall_enter_from_user_mode(regs, syscall);

	if (syscallnr != -1L)
		regs->result = invoke_syscall(regs, syscall;

syscall_enter_from_user_mode() invokes ptrace, seccomp and
tracing/BPF/Probes. All of them can modify the syscall number.

ptrace and seccomp explicitly set the syscall number to -1L to indicate
that the syscall invocation needs to be skipped and the result has not to
be modified as it might have been modified by ptrace or seccomp. The
tracer/BPF/Probes mechanism can modify the syscall number as well and
relies implicitly on the -1L logic.

This can obviously not be differentiated from a syscall invocation where
userspace provided -1 as syscall number.

The general agreement of the discussion was that the current mechanism,
while functionally correct is non-intuitive and something like Michals
proposal would make that code clearer and easier to handle on the
architecture side:

arch_syscall()
	regs->result = -ENOSYS;

	if (syscall_enter_from_user_mode(regs, &syscall)) 
		regs->result = invoke_syscall(regs, syscall;

That discussion made me look deeper into the related code and as usual
there were a lot of other things to discover.

  1) Stack randomization

     add_random_kstack_offset() can only be invoked after
     enter_from_user_mode() established proper state as it calls into
     instrumentable code.

     PowerPC got that wrong and the other architectures either invoke it
     after enter_from_user_mode() or after syscall_enter_from_user_mode().

     The latter is suboptimal as the randomization takes place after all
     the user mode entry work. Aside of that add_random_kstack_offset()
     uses get/put_cpu_var(), which makes it usable in preemptible code, but
     when invoked in the interrupt disabled region that's pointless
     overhead.

  2) As discussed in the above thread just changing the function signature
     of syscall_enter_from_user_mode[_work]() so they take a pointer
     argument for the syscall and then return 0 on success is not really
     intuitive either. Aside of that this breaks the implicit assumption of
     the tracer when setting the syscall number to -1.

  3) The x86 entry code has some historically accumulated oddities

The following series addresses this by:

  1) Providing new [syscall_]enter_from_user_mode() variants, which include
     stack randomization and utilize a new add_random_kstack_offset_irqsoff()
     variant, which avoids the get/put_cpu_var() overhead and converting all
     usage sites over

  2) Picking up Jinjie's seccomp patch from:

     https://lore.kernel.org/lkml/20260629130616.642022-2-ruanjinjie@huawei.com

     and addressing the feedback (renaming the seccomp functions)

  3) Making the ptrace and tracer related functions return a boolean value
     to indicate syscall permission

  4) Addressing the x86 oddities

  5) Converting the tree over to the new scheme

With that all architectures using the generic syscall entry code follow the
same scheme, apply stack randomization at the correct and earliest possible
place and skip syscall processing depending on the boolean return value of
syscall_enter_from_user_mode[_work]().

There should be no functional changes, at least there are none intended.

The resulting text size for the syscall entry code on x8664 is slightly
smaller than before these changes.

Testing syscall heavy workloads and micro benchmarks shows a small
performance gain for the general rework, but the last patch, which changes
the logic to be more understandable has no measurable impact in either
direction.

The series applies on Linus tree and is also available from git:

        git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1

Thanks,

	tglx
---
 Documentation/core-api/entry.rst      |   33 +++++---
 arch/alpha/kernel/ptrace.c            |    4 -
 arch/arc/kernel/ptrace.c              |    2 
 arch/arm/kernel/ptrace.c              |    4 -
 arch/arm64/kernel/ptrace.c            |    4 -
 arch/csky/kernel/ptrace.c             |    4 -
 arch/hexagon/kernel/traps.c           |    2 
 arch/loongarch/kernel/syscall.c       |   17 +---
 arch/m68k/kernel/ptrace.c             |    4 -
 arch/microblaze/kernel/ptrace.c       |    2 
 arch/mips/kernel/ptrace.c             |    4 -
 arch/nios2/kernel/ptrace.c            |    2 
 arch/openrisc/kernel/ptrace.c         |    2 
 arch/parisc/kernel/ptrace.c           |   12 +--
 arch/powerpc/kernel/syscall.c         |    5 -
 arch/riscv/kernel/traps.c             |   14 +--
 arch/s390/kernel/syscall.c            |   11 +-
 arch/sh/kernel/ptrace_32.c            |    4 -
 arch/sparc/kernel/ptrace_32.c         |    2 
 arch/sparc/kernel/ptrace_64.c         |    2 
 arch/um/kernel/ptrace.c               |    2 
 arch/um/kernel/skas/syscall.c         |    2 
 arch/x86/entry/syscall_32.c           |   70 +++++++------------
 arch/x86/entry/syscall_64.c           |   61 ++++++----------
 arch/x86/entry/vsyscall/vsyscall_64.c |   14 +--
 arch/x86/include/asm/entry-common.h   |    1 
 arch/x86/include/asm/syscall.h        |   10 --
 arch/xtensa/kernel/ptrace.c           |    5 -
 include/asm-generic/syscall.h         |    4 -
 include/linux/entry-common.h          |  125 ++++++++++++++++++++--------------
 include/linux/irq-entry-common.h      |    6 -
 include/linux/ptrace.h                |   13 +--
 include/linux/randomize_kstack.h      |   19 +++++
 include/linux/seccomp.h               |   12 +--
 kernel/entry/syscall-common.c         |    7 +
 kernel/seccomp.c                      |   35 ++++-----
 36 files changed, 264 insertions(+), 256 deletions(-)



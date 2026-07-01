Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12E2D2397;
	Wed,  1 Jul 2026 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930682; cv=none; b=hC4RQwFSkhPbv6+Qo4+Mgt08ZsGefczYK3o/ObWzz6IDHyHOMQO2oV5Ba97MSw+Dfrbceze59FrEn8y3D6DIBiRN6Zb5Z8RN10Me7pBl0m1tkMr2QxePm46IvuqsbyU3TV5ucILPjQUf7L6cj2uoFRYX9/9SzPQQNiL2244l25E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930682; c=relaxed/simple;
	bh=R4PrjPPldbkza6k4mQFltyh8jCayrmqUnrZsmEVd700=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CBpruavM2Zeyx/GLiZ6+JiA85T938EJyiySfI40tLQ1QUXu8g2nAHAJxdn1mA17Oh5nvPfiKCVeCdn8XSYUWnLRcthvNdV77uYYxD+Lup+JZJJbhhnoZhF/Ej15jVEzgRxaNCt9t0B0irPiQHfD6YtqfSlkSQFnfceRDkf/ks2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=sjQ+NwvX; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="sjQ+NwvX"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 661IT8Ra2191034
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 1 Jul 2026 11:29:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 661IT8Ra2191034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782930551;
	bh=syy/ox+gzg6WwJpXFhS25G5cfX2XqjSCA2Oh6WGRHtw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sjQ+NwvX3+MD5NIDGiYs+hr3FBy9zy664qemA2dwqMcL7OP+Xmso771H8OxcnLi4l
	 vCEiK24hKWmVbNgHj8qxzgrIvFmotzsro4LnLc0IPkN2ERHhLo++HRSPM7lbe8b0jG
	 oQ9J27yhe/mb3rKM07COC2c2dwVHvRitGxRT4JAh+byH0dfoeQzLY41ndCLwfS1Rau
	 MNk0ePRjiicRT9L9ka77tnbKn09y6Z7Q7fN0VWXb/tY/fcPo86Wi94xJhkNqTrFZBW
	 yq3/jzvH3xVufd9bV+xTOTuCHTq2arfKB0qkc7qTr6TIBVg3K9+9sffc0s+KArbCQ2
	 SEmT6q5BX6nYQ==
Date: Wed, 01 Jul 2026 11:29:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Zong Li <zong.li@sifive.com>,
        Nam Cao <namcao@linutronix.de>, Deepak Gupta <debug@rivosinc.com>,
        Lukas Gerlach <lukas.gerlach@cispa.de>,
        Rui Qi <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC=5D_entry=3A_Untangle_the_return_value_of?=
 =?US-ASCII?Q?_syscall=5Fenter=5Ffrom=5Fuser=5Fmode_from_syscall_NR?=
User-Agent: K-9 Mail for Android
In-Reply-To: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
Message-ID: <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 1, 2026 10:42:08 AM PDT, "Michal Such=C3=A1nek" <msuchanek@suse=2Ed=
e> wrote:
>The return value of syscall_enter_from_user_mode is used both for the
>adjusted syscall number and the indicator that a syscall should be
>skipped=2E
>
>As seccomp can be invoked on any syscall, including invalid ones this
>somewhat undermines seccomp=2E
>
>While the seccomp variants that terminate the process do not need to
>care about this for the filter that sets the syscall return value this
>disctinction is required=2E
>
>Pass the syscall number as a pointer to the inline entry functions, and
>use the return value exclusively for the indication that the syscall is
>already handled=2E
>
>This should avoid the need for the s390 PIF_SYSCALL_RET_SET which is the
>workaround for exactly this deficiency=2E
>
>If this is desirable the patch could be split into some series that
>adjusts the code flow where needed so that the final change is mostly
>mechanical=2E
>
>There is also another way to handle this problem=2E
>
>With x86 using bit 30 to denote compatibility syscall it sounds like
>declaring syscall number a 30bit quantity would work=2E
>
>Then bit 31 could be used to denote an invalid syscall that can never be
>executed, and the -1 returned from syscall_enter_from_user_mode would
>then be inherently invalid=2E
>
>That is so long as no architectures use syscall numbers outside of this
>range so far, and the limitation is considered fine=2E
>
>Signed-off-by: Michal Such=C3=A1nek <msuchanek@suse=2Ede>
>---
> Documentation/core-api/entry=2Erst | 12 ++++++----
> arch/loongarch/kernel/syscall=2Ec  |  6 ++---
> arch/powerpc/kernel/syscall=2Ec    |  3 ++-
> arch/riscv/kernel/traps=2Ec        |  6 ++---
> arch/s390/kernel/syscall=2Ec       |  6 ++---
> arch/x86/entry/syscall_32=2Ec      | 39 +++++++++++++++-----------------
> arch/x86/entry/syscall_64=2Ec      | 19 ++++++++--------
> include/linux/entry-common=2Eh     | 38 ++++++++++++++-----------------
> 8 files changed, 63 insertions(+), 66 deletions(-)
>
>diff --git a/Documentation/core-api/entry=2Erst b/Documentation/core-api/=
entry=2Erst
>index 71d8eedc0549=2E=2Eb0bfae31fe7c 100644
>--- a/Documentation/core-api/entry=2Erst
>+++ b/Documentation/core-api/entry=2Erst
>@@ -68,12 +68,14 @@ invoked from low-level assembly code looks like this:
>   noinstr void syscall(struct pt_regs *regs, int nr)
>   {
> 	arch_syscall_enter(regs);
>-	nr =3D syscall_enter_from_user_mode(regs, nr);
>=20
>-	instrumentation_begin();
>-	if (!invoke_syscall(regs, nr) && nr !=3D -1)
>-	 	result_reg(regs) =3D __sys_ni_syscall(regs);
>-	instrumentation_end();
>+	/* Skip syscall when -1 is returned */
>+	if (!syscall_enter_from_user_mode(regs, &nr)) {
>+		instrumentation_begin();
>+		if (!invoke_syscall(regs, nr) && nr !=3D -1)
>+			result_reg(regs) =3D __sys_ni_syscall(regs);
>+		instrumentation_end();
>+	}
>=20
> 	syscall_exit_to_user_mode(regs);
>   }
>diff --git a/arch/loongarch/kernel/syscall=2Ec b/arch/loongarch/kernel/sy=
scall=2Ec
>index 94c1c3b5b0b5=2E=2Efc18ac56b91c 100644
>--- a/arch/loongarch/kernel/syscall=2Ec
>+++ b/arch/loongarch/kernel/syscall=2Ec
>@@ -58,7 +58,7 @@ typedef long (*sys_call_fn)(unsigned long, unsigned lon=
g,
>=20
> void noinstr __no_stack_protector do_syscall(struct pt_regs *regs)
> {
>-	unsigned long nr;
>+	unsigned long nr, ret;
> 	sys_call_fn syscall_fn;
>=20
> 	nr =3D regs->regs[11];
>@@ -70,11 +70,11 @@ void noinstr __no_stack_protector do_syscall(struct p=
t_regs *regs)
> 	regs->orig_a0 =3D regs->regs[4];
> 	regs->regs[4] =3D -ENOSYS;
>=20
>-	nr =3D syscall_enter_from_user_mode(regs, nr);
>+	ret =3D syscall_enter_from_user_mode(regs, &nr);
>=20
> 	add_random_kstack_offset();
>=20
>-	if (nr < NR_syscalls) {
>+	if (nr < NR_syscalls && !ret) {
> 		syscall_fn =3D sys_call_table[array_index_nospec(nr, NR_syscalls)];
> 		regs->regs[4] =3D syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[=
6],
> 					   regs->regs[7], regs->regs[8], regs->regs[9]);
>diff --git a/arch/powerpc/kernel/syscall=2Ec b/arch/powerpc/kernel/syscal=
l=2Ec
>index a9da2af6efa8=2E=2E45d11d518c51 100644
>--- a/arch/powerpc/kernel/syscall=2Ec
>+++ b/arch/powerpc/kernel/syscall=2Ec
>@@ -20,7 +20,8 @@ notrace long system_call_exception(struct pt_regs *regs=
, unsigned long r0)
> 	syscall_fn f;
>=20
> 	add_random_kstack_offset();
>-	r0 =3D syscall_enter_from_user_mode(regs, r0);
>+	if (unlikely(syscall_enter_from_user_mode(regs, &r0)))
>+		return syscall_get_error(current, regs);
>=20
> 	if (unlikely(r0 >=3D NR_syscalls)) {
> 		if (unlikely(trap_is_unsupported_scv(regs))) {
>diff --git a/arch/riscv/kernel/traps=2Ec b/arch/riscv/kernel/traps=2Ec
>index 8c62c771a656=2E=2E9326a4a50696 100644
>--- a/arch/riscv/kernel/traps=2Ec
>+++ b/arch/riscv/kernel/traps=2Ec
>@@ -325,7 +325,7 @@ asmlinkage __visible __trap_section  __no_stack_prote=
ctor
> void do_trap_ecall_u(struct pt_regs *regs)
> {
> 	if (user_mode(regs)) {
>-		long syscall =3D regs->a7;
>+		long ret, syscall =3D regs->a7;
>=20
> 		regs->epc +=3D 4;
> 		regs->orig_a0 =3D regs->a0;
>@@ -333,11 +333,11 @@ void do_trap_ecall_u(struct pt_regs *regs)
>=20
> 		riscv_v_vstate_discard(regs);
>=20
>-		syscall =3D syscall_enter_from_user_mode(regs, syscall);
>+		ret =3D syscall_enter_from_user_mode(regs, &syscall);
>=20
> 		add_random_kstack_offset();
>=20
>-		if (syscall >=3D 0 && syscall < NR_syscalls) {
>+		if (syscall >=3D 0 && syscall < NR_syscalls && !ret) {
> 			syscall =3D array_index_nospec(syscall, NR_syscalls);
> 			syscall_handler(regs, syscall);
> 		}
>diff --git a/arch/s390/kernel/syscall=2Ec b/arch/s390/kernel/syscall=2Ec
>index 75d5a3cab14e=2E=2E9e5b873c011d 100644
>--- a/arch/s390/kernel/syscall=2Ec
>+++ b/arch/s390/kernel/syscall=2Ec
>@@ -95,7 +95,7 @@ SYSCALL_DEFINE0(ni_syscall)
>=20
> void noinstr __do_syscall(struct pt_regs *regs, int per_trap)
> {
>-	unsigned long nr;
>+	unsigned long nr, ret;
>=20
> 	enter_from_user_mode(regs);
> 	add_random_kstack_offset();
>@@ -121,7 +121,7 @@ void noinstr __do_syscall(struct pt_regs *regs, int p=
er_trap)
> 		regs->psw=2Eaddr =3D current->restart_block=2Earch_data;
> 		current->restart_block=2Earch_data =3D 1;
> 	}
>-	nr =3D syscall_enter_from_user_mode_work(regs, nr);
>+	ret =3D syscall_enter_from_user_mode_work(regs, &nr);
> 	/*
> 	 * In the s390 ptrace ABI, both the syscall number and the return value
> 	 * use gpr2=2E However, userspace puts the syscall number either in the
>@@ -129,7 +129,7 @@ void noinstr __do_syscall(struct pt_regs *regs, int p=
er_trap)
> 	 * work, the ptrace code sets PIF_SYSCALL_RET_SET, which is checked her=
e
> 	 * and if set, the syscall will be skipped=2E
> 	 */
>-	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET)))
>+	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET) || =
ret))
> 		goto out;
> 	regs->gprs[2] =3D -ENOSYS;
> 	if (likely(nr < NR_syscalls)) {
>diff --git a/arch/x86/entry/syscall_32=2Ec b/arch/x86/entry/syscall_32=2E=
c
>index 31b9492fe851=2E=2E525e99691b31 100644
>--- a/arch/x86/entry/syscall_32=2Ec
>+++ b/arch/x86/entry/syscall_32=2Ec
>@@ -128,7 +128,7 @@ static __always_inline bool int80_is_external(void)
>  */
> __visible noinstr void do_int80_emulation(struct pt_regs *regs)
> {
>-	int nr;
>+	long nr;
>=20
> 	/* Kernel does not use INT $0x80! */
> 	if (unlikely(!user_mode(regs))) {
>@@ -168,8 +168,7 @@ __visible noinstr void do_int80_emulation(struct pt_r=
egs *regs)
> 	nr =3D syscall_32_enter(regs);
>=20
> 	local_irq_enable();
>-	nr =3D syscall_enter_from_user_mode_work(regs, nr);
>-	do_syscall_32_irqs_on(regs, nr);
>+	syscall_enter_from_user_mode_work(regs, &nr);
>=20
> 	instrumentation_end();
> 	syscall_exit_to_user_mode(regs);
>@@ -208,7 +207,7 @@ __visible noinstr void do_int80_emulation(struct pt_r=
egs *regs)
>  */
> DEFINE_FREDENTRY_RAW(int80_emulation)
> {
>-	int nr;
>+	long nr;
>=20
> 	enter_from_user_mode(regs);
>=20
>@@ -232,8 +231,10 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
> 	nr =3D syscall_32_enter(regs);
>=20
> 	local_irq_enable();
>-	nr =3D syscall_enter_from_user_mode_work(regs, nr);
>-	do_syscall_32_irqs_on(regs, nr);
>+	if (!syscall_enter_from_user_mode_work(regs, &nr)) {
>+		nr &=3D GENMASK(31, 0);
>+		do_syscall_32_irqs_on(regs, nr);
>+	}
>=20
> 	instrumentation_end();
> 	syscall_exit_to_user_mode(regs);
>@@ -245,20 +246,17 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
> /* Handles int $0x80 on a 32bit kernel */
> __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
> {
>-	int nr =3D syscall_32_enter(regs);
>-
>-	/*
>-	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
>-	 * orig_ax, the int return value truncates it=2E This matches
>-	 * the semantics of syscall_get_nr()=2E
>-	 */
>-	nr =3D syscall_enter_from_user_mode(regs, nr);
>-	instrumentation_begin();
>+	long nr =3D syscall_32_enter(regs);
>=20
> 	add_random_kstack_offset();
>-	do_syscall_32_irqs_on(regs, nr);
>+	if (!syscall_enter_from_user_mode(regs, &nr)) {
>+		instrumentation_begin();
>=20
>-	instrumentation_end();
>+		nr &=3D & GENMASK(31, 0);
>+		do_syscall_32_irqs_on(regs, nr);
>+
>+		instrumentation_end();
>+	}
> 	syscall_exit_to_user_mode(regs);
> }
> #endif /* !CONFIG_IA32_EMULATION */
>@@ -301,10 +299,9 @@ static noinstr bool __do_fast_syscall_32(struct pt_r=
egs *regs)
> 		return false;
> 	}
>=20
>-	nr =3D syscall_enter_from_user_mode_work(regs, nr);
>-
>-	/* Now this is just like a normal syscall=2E */
>-	do_syscall_32_irqs_on(regs, nr);
>+	if (!syscall_enter_from_user_mode_work(regs, &nr))
>+		/* Now this is just like a normal syscall=2E */
>+		do_syscall_32_irqs_on(regs, nr);
>=20
> 	instrumentation_end();
> 	syscall_exit_to_user_mode(regs);
>diff --git a/arch/x86/entry/syscall_64=2Ec b/arch/x86/entry/syscall_64=2E=
c
>index 71f032504e73=2E=2E3400c2f43a62 100644
>--- a/arch/x86/entry/syscall_64=2Ec
>+++ b/arch/x86/entry/syscall_64=2Ec
>@@ -84,19 +84,20 @@ static __always_inline bool do_syscall_x32(struct pt_=
regs *regs, int nr)
> }
>=20
> /* Returns true to return using SYSRET, or false to use IRET */
>-__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
>+__visible noinstr bool do_syscall_64(struct pt_regs *regs, long nr)
> {
>-	nr =3D syscall_enter_from_user_mode(regs, nr);
>-
>-	instrumentation_begin();
> 	add_random_kstack_offset();
>+	if (!syscall_enter_from_user_mode(regs, &nr)) {
>=20
>-	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr !=3D -=
1) {
>-		/* Invalid system call, but still a system call=2E */
>-		regs->ax =3D __x64_sys_ni_syscall(regs);
>-	}
>+		instrumentation_begin();
>=20
>-	instrumentation_end();
>+		if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr)) {
>+			/* Invalid system call, but still a system call=2E */
>+			regs->ax =3D __x64_sys_ni_syscall(regs);
>+		}
>+
>+		instrumentation_end();
>+	}
> 	syscall_exit_to_user_mode(regs);
>=20
> 	/*
>diff --git a/include/linux/entry-common=2Eh b/include/linux/entry-common=
=2Eh
>index 416a3352261f=2E=2E4991071d01fe 100644
>--- a/include/linux/entry-common=2Eh
>+++ b/include/linux/entry-common=2Eh
>@@ -69,10 +69,8 @@ static inline void syscall_enter_audit(struct pt_regs =
*regs, long syscall)
> 	}
> }
>=20
>-static __always_inline long syscall_trace_enter(struct pt_regs *regs, un=
signed long work)
>+static __always_inline long syscall_trace_enter(struct pt_regs *regs, un=
signed long work, unsigned long *syscall)
> {
>-	long syscall, ret =3D 0;
>-
> 	/*
> 	 * Handle Syscall User Dispatch=2E  This must comes first, since
> 	 * the ABI here can be something that doesn't make sense for
>@@ -93,27 +91,25 @@ static __always_inline long syscall_trace_enter(struc=
t pt_regs *regs, unsigned l
>=20
> 	/* Handle ptrace */
> 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
>-		ret =3D arch_ptrace_report_syscall_entry(regs);
>-		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
>+		if (arch_ptrace_report_syscall_entry(regs) || (work & SYSCALL_WORK_SYS=
CALL_EMU))
> 			return -1L;
> 	}
>=20
> 	/* Do seccomp after ptrace, to catch any tracer changes=2E */
> 	if (work & SYSCALL_WORK_SECCOMP) {
>-		ret =3D __secure_computing();
>-		if (ret =3D=3D -1L)
>-			return ret;
>+		if (__secure_computing())
>+			return -1L;
> 	}
>=20
> 	/* Either of the above might have changed the syscall number */
>-	syscall =3D syscall_get_nr(current, regs);
>+	*syscall =3D syscall_get_nr(current, regs);
>=20
> 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
>-		syscall =3D trace_syscall_enter(regs, syscall);
>+		*syscall =3D trace_syscall_enter(regs, *syscall);
>=20
>-	syscall_enter_audit(regs, syscall);
>+	syscall_enter_audit(regs, *syscall);
>=20
>-	return ret ? : syscall;
>+	return 0;
> }
>=20
> /**
>@@ -126,12 +122,12 @@ static __always_inline long syscall_trace_enter(str=
uct pt_regs *regs, unsigned l
>  * enabled after invoking enter_from_user_mode(), enabling interrupts an=
d
>  * extra architecture specific work=2E
>  *
>- * Returns: The original or a modified syscall number
>+ * Returns: The original or a modified syscall number as syscall
>  *
>- * If the returned syscall number is -1 then the syscall should be
>- * skipped=2E In this case the caller may invoke syscall_set_error() or
>- * syscall_set_return_value() first=2E  If neither of those are called a=
nd -1
>- * is returned, then the syscall will fail with ENOSYS=2E
>+ * If the returned value is -1 then the syscall should be skipped=2E In =
this case
>+ * the caller may invoke syscall_set_error() or syscall_set_return_value=
()
>+ * first=2E  If neither of those are called and -1 is returned, then the=
 syscall
>+ * will fail with ENOSYS=2E
>  *
>  * It handles the following work items:
>  *
>@@ -139,14 +135,14 @@ static __always_inline long syscall_trace_enter(str=
uct pt_regs *regs, unsigned l
>  *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_en=
ter()
>  *  2) Invocation of audit_syscall_entry()
>  */
>-static __always_inline long syscall_enter_from_user_mode_work(struct pt_=
regs *regs, long syscall)
>+static __always_inline long syscall_enter_from_user_mode_work(struct pt_=
regs *regs, long *syscall)
> {
> 	unsigned long work =3D READ_ONCE(current_thread_info()->syscall_work);
>=20
> 	if (work & SYSCALL_WORK_ENTER)
>-		syscall =3D syscall_trace_enter(regs, work);
>+		return syscall_trace_enter(regs, work, syscall);
>=20
>-	return syscall;
>+	return 0;
> }
>=20
> /**
>@@ -167,7 +163,7 @@ static __always_inline long syscall_enter_from_user_m=
ode_work(struct pt_regs *re
>  * Returns: The original or a modified syscall number=2E See
>  * syscall_enter_from_user_mode_work() for further explanation=2E
>  */
>-static __always_inline long syscall_enter_from_user_mode(struct pt_regs =
*regs, long syscall)
>+static __always_inline long syscall_enter_from_user_mode(struct pt_regs =
*regs, long *syscall)
> {
> 	long ret;
>=20

Negative numbers most definitely not be assigned as valid system calls, no=
t now, not ever=2E=20

Therein lies some serious madness=2E

I believe setting the syscall number to -1 to skip is an ABI already in e=
=2Eg=2E ptrace, so I doubt we can just get rid of it anyway=2E=20

I would say as follows:

Let's formally define that:=20

- valid system call numbers are positive 32-bit numbers, using the appropr=
iate ABI convention for "int"=2E

- bits [30:n] for some value of n are reserved for architecture-specific f=
lags/modes=2E MIPS uses an offset of 2000 decimal between its syscall ABIs,=
 which would imply n ~ 11, although I personally think that is too restrict=
ive (MIPS could in fact use such a flag to provide an escape into a larger =
number space if we ever need more than 2000 system calls=2E)

I would suggest n =3D 24, at least for now=2E It is easier to give up addi=
tional bits later than to claw them back when already used=2E=20

Thus:=20

1=2E The type for a system call is int=2E

2=2E A valid system call number is always going to be positive=2E

3=2E Bits [30:24] are available for architecture ABI use=2E The "architect=
ure independent" part of the system call number is therefore 24 bits wide=
=2E

4=2E The exact ABI is platform-specific, obviously, but as a general guide=
line (especially for new platforms/ABIs) should follow the rules for a plat=
form "int" if practical=2E Notably, when passing a value in a register larg=
er than 32 bits, which side of the calling interface is responsible for sig=
n-extending a value passed in a register=2E If caller side, the kernel shou=
ld validate, if callee side the kernel should ignore the additional bits an=
d do the extension=2E

5=2E A negative system call number is guaranteed to return -ENOSYS (unless=
 intercepted by seccomp, ptrace, or another mechanism under user space cont=
rol=2E)

6=2E If the platform needs to algorithmically modify the system call numbe=
r due to platform-specific concerns (say, the platform uses a 16-bit specia=
l purpose register for the syscall number, or it has multiple kernel entry =
points with different behavior), it should if at all possible transcode the=
 system call number as necessary to match this convention in APIs that are =
exposed to general kernel code=2E=20

For example, in the future I could very much see the IA32 code in the x86 =
kernel using bit 29 internally to indicate an ia32 system call, simplifying=
 the is_compat implementation on x86=2E It should not mean that passing bit=
 29 to either the syscall instruction or int $0x80 will be accepted=2E


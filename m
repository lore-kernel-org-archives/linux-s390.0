Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63B47CC61;
	Tue,  7 Jul 2026 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451215; cv=none; b=esdh/N8kK0xn/BLWy2ZOCCffv4t1P70k3YcGUIkS7ot+18JTUrXRtM+cnMCPbzlqiqWxvaB6xjHdUwwefMybLv+diEAsCyGq0Re0Ga2Qu/7HkgoJ08bVOINgfMs+nsvAtDYyNy/XbWSiuthEg7gcEIKpAo5leD2Rk1ukcDFbeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451215; c=relaxed/simple;
	bh=Kd+px02StZMbwQ7TKPgRkHPqsuwdU2Idw88bWNwsXCk=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=siVPsNKPt4rnPVavG296MPlQy/Lxl49IUliL4/R4UNV/6KYUr/LkGOl9H+qap50zylAKbur6spt0ODEX3oxXskAb9ymVo49JcbQTYM3ovPcMjL6ni1oBs8ko6vrrLMf6pSFkBsiX+oB0IyVkwFAS86SdnW6p3Kb1LWfwwv8OZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX8UQNU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX8UQNU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997691F00A3F;
	Tue,  7 Jul 2026 19:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451211;
	bh=2hP2B4F9qeeUXuU3XysbmgOwdSnbN4nPIvEqn4Tc+Vc=;
	h=Date:From:To:Cc:Subject:References;
	b=GX8UQNU5eotoxcPBLwgb2dREYSYCaobbI7j41EIjeAQbZxYCGuF9DAt9CuKdWhml5
	 sKLqvJU7OLLMsewiAA5UrA2UnmhlrFwfEUGzISBe2Jat9AL4izazWtNtXgKtBBNbzS
	 Pk/Ylkh8qbCDazP5INDbcRzOErFrWroa9+BlpD5E0YXaC/H3Z3JkwneB2JtFInyqn1
	 9UUW7cznoP9Sj9JShH/9STHt6/MiC/5xbpW1rEBQWCbAjEVvJGIuJwCWYWkkgnIyrX
	 3Z+Nm44fpA3fg/FSFwJd+2UjfCZ/sMDtcZhjx7lFIz/M/97exj3ilz3ZoFUpMhhgHk
	 1wiFALaxAM02A==
Date: Tue, 07 Jul 2026 21:06:48 +0200
Message-ID: <20260707190254.338083894@kernel.org>
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
Subject: [patch 13/18] entry: Make trace_syscall_enter() return type bool
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In preparation of converting the return value of
syscall_enter_from_user_mode[_work]() bool, rework trace_syscall_enter() to

 - update the syscall number via a pointer argument

 - Return True if the syscall number is != -1, False otherwise

That aligns with ptrace_report_syscall_permit_enter() and
seccomp_permit_syscall().

The only difference is that this also returns False, when the syscall
number was already -1 to begin with, but there is not much which can be
done about that. As the architecture has to preset the return value to
-ENOSYS anyway, that results in the correct return value for such an
invalid syscall.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h  |    8 +++++---
 kernel/entry/syscall-common.c |    7 ++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -58,7 +58,7 @@ static __always_inline bool arch_ptrace_
 #endif
 
 bool syscall_user_dispatch(struct pt_regs *regs);
-long trace_syscall_enter(struct pt_regs *regs, long syscall);
+bool trace_syscall_enter(struct pt_regs *regs, long *syscall);
 void trace_syscall_exit(struct pt_regs *regs, long ret);
 
 static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
@@ -108,8 +108,10 @@ static __always_inline long syscall_trac
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
 
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
-		syscall = trace_syscall_enter(regs, syscall);
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
+		if (!trace_syscall_enter(regs, &syscall))
+			return -1L;
+	}
 
 	syscall_enter_audit(regs, syscall);
 
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -7,14 +7,15 @@
 
 /* Out of line to prevent tracepoint code duplication */
 
-long trace_syscall_enter(struct pt_regs *regs, long syscall)
+bool trace_syscall_enter(struct pt_regs *regs, long *syscall)
 {
-	trace_sys_enter(regs, syscall);
+	trace_sys_enter(regs, *syscall);
 	/*
 	 * Probes or BPF hooks in the tracepoint may have changed the
 	 * system call number. Reread it.
 	 */
-	return syscall_get_nr(current, regs);
+	*syscall = syscall_get_nr(current, regs);
+	return *syscall != -1L;
 }
 
 void trace_syscall_exit(struct pt_regs *regs, long ret)


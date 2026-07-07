Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8B3E0C6F;
	Tue,  7 Jul 2026 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451178; cv=none; b=oNO+0PJ6vphzzz8O2mOXztX5x40arfTna5PbajO8sWF7L4oqDPsmJyOqzRqr/QJiiN9xlOxlry7aQ/bCKevRVNnO74Zilrj4kTgrjXPlYk+oCYTOe8+zTufCZAvlVUp+2Ui4LBO11rJH7cs7wDYQr/xqexgXcxlmRW9/HqNFTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451178; c=relaxed/simple;
	bh=/ShrazNoDRJYcoJPipwaW5cSycazwuXUK/Lpp8y6PZw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kiie5zupVVwuzTjKt39mzAkRHseNo0mtqtNryx0IsjHTs/zASqnNiJOr4qkxdg3wXxI+/tP/+MCvufP+PQGtIC2e/oDTq2+ZGIfLze60xm49ai8IfyCWsFZnOMVe5jWfaTkL8yBy2k1p9fmQmYYQtYv4hweIWvlWlLpj46PIAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0NwhOtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0NwhOtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3571F000E9;
	Tue,  7 Jul 2026 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451173;
	bh=4+5KtSAhpclzOPxgH9736FL7Uf1pNCSlMPQrqwffdRU=;
	h=Date:From:To:Cc:Subject:References;
	b=L0NwhOtn/pOWM0ulqppTdz+f5F1vPIiktRF8++iqaXbfQrbA09EWRmKXUTgs+tJGZ
	 9BOc+sE0QdxWAWxboebj5k3TGGiEZy86TkscBomKuqCnVcID0FRgb+hXm7kRhQb508
	 18f9wNTMGjmah3berrpcvUtgyoh65Oruioe9rXjT2vjCE0ifLG+hzmK2ha75qKIz8p
	 1GtYXAThFYccYlfm3dA4KtHGVG1cGenYQHaPXFR1tPeFk2o5v6tnBtmGInkBCyatdE
	 GHsMMbjrc9U1K+LMYACpZgx7BpGh3yI1J/j1USPF0e6lRALp6AqGe77XqRzuOFecve
	 UXBMPM/ZYnxHQ==
Date: Tue, 07 Jul 2026 21:06:11 +0200
Message-ID: <20260707190253.865955911@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
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
Subject: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

syscall_enter_from_user_mode_randomize_stack() replaces
syscall_enter_from_user_mode() and the subsequent invocation of
add_random_kstack_offset().

The advantage is that it applies the stack randomization right after
enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
as that code is invoked with interrupts disabled.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/kernel/syscall.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -11,7 +11,6 @@
 #include <linux/linkage.h>
 #include <linux/nospec.h>
 #include <linux/objtool.h>
-#include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 
@@ -70,9 +69,7 @@ void noinstr __no_stack_protector do_sys
 	regs->orig_a0 = regs->regs[4];
 	regs->regs[4] = -ENOSYS;
 
-	nr = syscall_enter_from_user_mode(regs, nr);
-
-	add_random_kstack_offset();
+	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
 
 	if (nr < NR_syscalls) {
 		syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];


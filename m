Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAD43F4D7;
	Tue,  7 Jul 2026 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451226; cv=none; b=phmktehB7us//R4kAlHa3qd0WHMIGTQdeLGFI3BuQaz4IdDtbhwbRsF7xBNFYjjJBn2SMxR5dfkGueoADZu4Z2jEetmLMjHq/CCNQ9MMI9w/n/UapJTNWBwyFs17poIi/MpNGqz1DDACDBi8oFHx+QL5AJ+AC6LFEZ5WdNuNIEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451226; c=relaxed/simple;
	bh=/3nHDhz12x4f14CZgcOAbR0f2UE9sEAXtCHIKlhj+K8=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AekHhbRnw/Nt3bykayNnLBc97WZe/ZRG5X70IjDBaU2Di2AppcJm5ShsZDLBgCxTdYitVVLV41JRdrOmGfzsPZtSP6NgA1NLC7FKTpGqZZWIEoz3r43hAzz0qMnVzybHV9a5w4MGcubbrg16mRCyRsihbhVG16fTYvq8n2SHNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLelz5RM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLelz5RM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0645A1F000E9;
	Tue,  7 Jul 2026 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451219;
	bh=TiJrYE33DXumkQwt2/+W2OjkQTFHtAcxd2PwMoVTvyY=;
	h=Date:From:To:Cc:Subject:References;
	b=mLelz5RMvm7eytF+jRJ4D5fjNpUVxBoHH7hg2nYnZT/UFPrsYUFlgsa1ekVxmkuNT
	 gqUlNLdwWLgnYzjvuNk4q4mfdBDP4L9l+PTvTfQrCbLe3tZ/yCqRzAo7NlwS8PHVVI
	 49mJ8Q2tJOFblQl3o/L9kClWZZm2mywKm7GJNLZxIBpy3Ihnr2srvP1DZLhHyNUo1f
	 Hc4RmwqJyFgE/dUEvlOSzi5K2ghRbH1MWuPc5m+aohcMKTewB0AZ3WteDH3gsBS7Ig
	 eb6bs+QZFAyC8WgWIMWvxdkpIA0RxkwSS687u/2TmUsTZblqnvzwjAyicI3Zcq5CI+
	 B67Z6TZ23hK0Q==
Date: Tue, 07 Jul 2026 21:06:57 +0200
Message-ID: <20260707190254.438361565@kernel.org>
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
Subject: [patch 15/18] x86/entry: Make syscall functions static
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

They are only used in the respective source files. No point in exposing
them.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 arch/x86/entry/syscall_32.c    |    2 +-
 arch/x86/entry/syscall_64.c    |   10 ++++++----
 arch/x86/include/asm/syscall.h |    8 --------
 3 files changed, 7 insertions(+), 13 deletions(-)

--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -41,7 +41,7 @@ const sys_call_ptr_t sys_call_table[] =
 #endif
 
 #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
-long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
+static noinline long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
 	#include <asm/syscalls_32.h>
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -32,7 +32,7 @@ const sys_call_ptr_t sys_call_table[] =
 #undef  __SYSCALL
 
 #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
-long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
+static noinline long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
 	#include <asm/syscalls_64.h>
@@ -40,15 +40,17 @@ long x64_sys_call(const struct pt_regs *
 	}
 }
 
-#ifdef CONFIG_X86_X32_ABI
-long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
+static noinline long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
+#ifdef CONFIG_X86_X32_ABI
 	switch (nr) {
 	#include <asm/syscalls_x32.h>
 	default: return __x64_sys_ni_syscall(regs);
 	}
-}
+#else
+	return -ENOSYS;
 #endif
+}
 
 static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 {
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -21,14 +21,6 @@ typedef long (*sys_call_ptr_t)(const str
 extern const sys_call_ptr_t sys_call_table[];
 
 /*
- * These may not exist, but still put the prototypes in so we
- * can use IS_ENABLED().
- */
-extern long ia32_sys_call(const struct pt_regs *, unsigned int nr);
-extern long x32_sys_call(const struct pt_regs *, unsigned int nr);
-extern long x64_sys_call(const struct pt_regs *, unsigned int nr);
-
-/*
  * Only the low 32 bits of orig_ax are meaningful, so we return int.
  * This importantly ignores the high bits on 64-bit, so comparisons
  * sign-extend the low 32 bits.


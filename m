Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441901;
	b=zgV7u+XxfqQ3f/8q9J2lPMTBjmlzfDLlknwFtx02ADfXGWoe0oLNRk9/1EpBEdH+o13q
	 3cVq+PmSAb2KepYUzCvxjBJIPjkpITd2Lz0a70oF36/PWbN0TyfOLQRwKIUWfH/Gna/r8
	 zYJbrHpA+puiL54Bf2uDDnAUEpHLFGU0J5V5H104lBRFYasaTII/OVKirk9OxDUorg4Dk
	 fjNIEcfKTrzY/OJCrX50CXGMWCOUrpAlJJibReBG+CL+umuQArZe2wBJ/ihX+663ZBfp/
	 9f2bvwVNmVJz0uMhuWpobxirteLgxzQOkuEQrEewFuDLRx6Q/R+rDrmzBfA4BNoDfjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441901;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=JPmhvZcQZsMI6w6eJvQYmGXP4b/7L7ItLiKaLRPpFiQ=;
	b=N8kE23H7VDN8zh7XmWAeScgqM/NboF89Q4dsEeNx4hJ8v3wwczLoF0YKUmOBIidWsdPh
	 Sj6PxtzcNYZxjqmjWtSYTUs36MevFoOadm08USUKNC+aD5Nqdd8AjfU0kxVElt+PZvdQS
	 Xnsb3x/JMmSEVw8rcoKgWDxbCDB10+y0kN95xC2/88jUv13ymjqdG7Uaqb1T+bM/aV1pZ
	 2eLQ9pU7mkr/pF0B/dbfMf6r0ccbYK8W4np2wRrwmz5dAhWhzAUBbxKHFQlVjl4qDiH62
	 Sv2v5WbXz/hHjCMW+Ixg5QMCcxY8964HLsnlwsveg8DNM24Ma6psG50PvioHImZtUMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rCXDMhbM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Vihz+OSm;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37103606A32A;
	Mon, 23 Nov 2026 13:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37103606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rCXDMhbM;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Vihz+OSm
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795441899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPmhvZcQZsMI6w6eJvQYmGXP4b/7L7ItLiKaLRPpFiQ=;
	b=rCXDMhbMNovmfoO6qyadNrRk7f6HVHBen34hmO8c2sCJxmWlrI+kuN6Fu1RHeKKsk6EY24
	E0SacrConMBbHsRxfbnnA1QmrkSNG5ig6+9Hj82q0+fcZzQog4JMvSX6BdBkvLPKAZY09a
	cmajQWcX84aMnEYYUqKcjQOYaLNnWLHV9hW4r1F+KoYJyRFvRAAJZbR87Cv1533ZENWlNL
	1IH3b3cUootBgp4GSIrRdqXPpBA39+LY1KQmZGiOE+gUNUvfwW3zvseTDo78nzug9YZv0c
	Nf0/IEvGQ27iEzT9+d3kiH4e7e72aytWDiOonz7mndTpsY7S1mpQeK4PjYtpeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795441899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPmhvZcQZsMI6w6eJvQYmGXP4b/7L7ItLiKaLRPpFiQ=;
	b=Vihz+OSme/gaZLLhdpsDZx8NOwH494utLHXdBxi1jGqiwVH9qbyOTU05x0YmhKAKY4MP4H
	F0xPTtLbZf0pAzDg==
Date: Mon, 23 Nov 2026 14:51:02 +0100
Subject: [PATCH v6 11/11] vDSO: Automatically enable VDSO_CHECK
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-vdso-absolute-reloc-v6-11-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
In-Reply-To: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Christophe Leroy <chleroy@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795441872; l=4650;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=tCXUwkZUh4Hl18kwgGqhcWJoeos+T/6rMQq0M5SHQdY=;
 b=gvQ6fSLlDUp8t1Kpx0/BBIhQ7AihqhesygBcKjwQL0dpVUoOyS5DoqWuOa59xHy5yVuHPzbgt
 Z/t2kJ3fm0ZAJfn4xh2H2o29XKP0jwDQOX8shG9Arg4eFHtoqbgV9U/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All architectures using the generic vDSO library should enable
VDSO_CHECK. Now that this is the case, enable VDSO_CHECK automatically.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/mm/Kconfig    | 1 -
 arch/arm64/Kconfig     | 1 -
 arch/loongarch/Kconfig | 1 -
 arch/mips/Kconfig      | 1 -
 arch/powerpc/Kconfig   | 1 -
 arch/riscv/Kconfig     | 1 -
 arch/s390/Kconfig      | 1 -
 arch/sparc/Kconfig     | 1 -
 arch/x86/Kconfig       | 1 -
 lib/vdso/Kconfig       | 2 ++
 10 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7f55ed37f464..41d7b495ec45 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -943,7 +943,6 @@ config VDSO
 	depends on AEABI && MMU && CPU_V7
 	default y if ARM_ARCH_TIMER
 	select GENERIC_GETTIMEOFDAY
-	select VDSO_CHECK
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index df22b4ed5e29..1075bc661833 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -258,7 +258,6 @@ config ARM64
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select USER_STACKTRACE_SUPPORT
-	select VDSO_CHECK
 	select VDSO_GETRANDOM
 	select VMAP_STACK
 	help
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ad4cafeddbb8..b5ed4881d3c0 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -211,7 +211,6 @@ config LOONGARCH
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
 	select USER_STACKTRACE_SUPPORT
-	select VDSO_CHECK
 	select VDSO_DATASTORE
 	select VDSO_GETRANDOM
 	select ZONE_DMA32 if 64BIT
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 31c247c2faeb..ed17c9b1624c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -106,7 +106,6 @@ config MIPS
 	select TRACE_IRQFLAGS_SUPPORT
 	select ARCH_HAS_ELFCORE_COMPAT
 	select HAVE_ARCH_KCSAN if 64BIT
-	select VDSO_CHECK
 
 config MIPS_FIXUP_BIGPHYS_ADDR
 	bool
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4a75c3a830..c3b6cd655606 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -327,7 +327,6 @@ config PPC
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
-	select VDSO_CHECK
 	select VDSO_DATASTORE
 	select VDSO_GETRANDOM
 	#
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2a0f5fbcd7e3..e7891a2a89da 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -226,7 +226,6 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
-	select VDSO_CHECK if MMU
 	select VDSO_DATASTORE if MMU
 	select VDSO_GETRANDOM if MMU && 64BIT
 	select USER_STACKTRACE_SUPPORT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 71a614832886..7138d923d86f 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -289,7 +289,6 @@ config S390
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY
 	select USER_STACKTRACE_SUPPORT
-	select VDSO_CHECK
 	select VDSO_GETRANDOM
 	select VIRT_CPU_ACCOUNTING
 	select VMAP_STACK
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 90df77235184..742ffff8c37f 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -114,7 +114,6 @@ config SPARC64
 	select ARCH_SUPPORTS_SCHED_SMT if SMP
 	select ARCH_SUPPORTS_SCHED_MC  if SMP
 	select ARCH_HAS_LAZY_MMU_MODE
-	select VDSO_CHECK
 	select GENERIC_GETTIMEOFDAY
 
 config ARCH_PROC_KCORE_TEXT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 09d3aa04ee82..58dce0b66179 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -302,7 +302,6 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
-	select VDSO_CHECK
 	select VDSO_GETRANDOM			if X86_64
 	select HOTPLUG_PARALLEL			if SMP && X86_64
 	select HOTPLUG_SMT			if SMP
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 559f5534831e..741de1abe923 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -6,6 +6,7 @@ config VDSO_DATASTORE
 config GENERIC_GETTIMEOFDAY
 	bool
 	select VDSO_DATASTORE
+	select VDSO_CHECK
 	help
 	  This is a generic implementation of gettimeofday vdso.
 	  Each architecture that enables this feature has to
@@ -21,6 +22,7 @@ config GENERIC_VDSO_OVERFLOW_PROTECT
 config VDSO_GETRANDOM
 	bool
 	select VDSO_DATASTORE
+	select VDSO_CHECK
 	help
 	  Selected by architectures that support vDSO getrandom().
 

-- 
2.56.1


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD23B9D98;
	Tue,  8 Sep 2026 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849254; cv=none; b=cXeaYjF655vyO+XGNvsLxoJOelLrIWPKBQqMGjMMSbMJwcDIZm2k4ikAmNXLmMOJmhqOJyMOF8iStF6CuN2eic4AZjyg8u00tWpUD6u/TkhCuuzN0BcswcOO/yHhgUi14JplpwzvHg5MkwvVSy/wS+YOjyJUm3ClvaaLpDzDVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849254; c=relaxed/simple;
	bh=8YBIXCqpUcZIhKo2ozvfdc454ybWMwplCW6yYOuJO9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2EbF0xt76M1+44X2ihbVBEqB2hTQj34YdC11Am2w95UxcRWR0SlJpFi5cLUABpU8M49PiZNriX33+bgZ3gE7dQbnXN6fWTX8ScUUWrKj/RgzdYnnDRuprVeQ9M4U44CPGTxExwdRGzgtIQCbT7KzFZGFa3wtz7KVHzu/ixGi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XPrer1rN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f9FPRGn6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XPrer1rN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f9FPRGn6"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQENS+2l3jE9bZko+PkLsKR5sNnfI5HJVcqDCuCIVEw=;
	b=XPrer1rNUAnaGlK6vBf4LguK9S6cEYlB8nZZrjRH44T0JYQMAKyYETb6FU7higRUl2aap8
	WPSjupacb2z13S04FQ0SJwG7i5o+PC1OLnBB5YCADw0UGpC2KSsaA9trHc8qBOetMTQve0
	NqaQl/n+ar+DEQjQWhkSInykqClLoMkc1uWPEodTVaq598SF88TtmGIx1H2fHIe1AwzdxB
	0wspvPUe1V8QhduMDS69XofBa/hyc2iRwUnB8p3goy0lgh6Z7KeHRDqnvOkRg7zB8SW8Qb
	FqrCyZ8Y06A671+Lr4boaBg9FZESkcMcbumRwfxWCaD3ADQPhCoX+US7aH30zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQENS+2l3jE9bZko+PkLsKR5sNnfI5HJVcqDCuCIVEw=;
	b=f9FPRGn66gCreVPpSFc3v18Vb8RE2PZIstfZMu10x/SOVv9mER00NGNKQm9o2b9lG/56PF
	Oy/Vw7WBWfgQcDDQ==
Date: Tue, 08 Sep 2026 08:33:58 +0200
Subject: [PATCH v5 24/24] vDSO: Automatically enable VDSO_CHECK
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-24-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
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
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=4650;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8YBIXCqpUcZIhKo2ozvfdc454ybWMwplCW6yYOuJO9M=;
 b=QeYK3jQJuWSOc5ZUbflHX/mM5G6ZrF/wQ5dZ1MsnWSa5wV32FY94s+AgAEqJT3r76pNju6OUd
 jvOXRT9ewDOBI2Td8ZRhAKi0jUGb3Ma2dwo847OeLvKpvkhvaACA78Q
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
index 565988a66e98..6574659dfb61 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -950,7 +950,6 @@ config VDSO
 	depends on AEABI && MMU && CPU_V7
 	default y if ARM_ARCH_TIMER
 	select GENERIC_GETTIMEOFDAY
-	select VDSO_CHECK
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1caaf4737f02..b5a51b0ef944 100644
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
index 5dc98a4b9c7f..a21f51e5815e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -213,7 +213,6 @@ config LOONGARCH
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
 	select USER_STACKTRACE_SUPPORT
-	select VDSO_CHECK
 	select VDSO_DATASTORE
 	select VDSO_GETRANDOM
 	select ZONE_DMA32 if 64BIT
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9a3ce550c95d..e2eb9627bd14 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -107,7 +107,6 @@ config MIPS
 	select TRACE_IRQFLAGS_SUPPORT
 	select ARCH_HAS_ELFCORE_COMPAT
 	select HAVE_ARCH_KCSAN if 64BIT
-	select VDSO_CHECK
 
 config MIPS_FIXUP_BIGPHYS_ADDR
 	bool
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f19e225cfc5c..2580e27e4328 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -330,7 +330,6 @@ config PPC
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
-	select VDSO_CHECK
 	select VDSO_DATASTORE
 	select VDSO_GETRANDOM
 	#
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f580d2afecf7..f8e26c4bed2b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -229,7 +229,6 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
-	select VDSO_CHECK if MMU
 	select VDSO_DATASTORE if MMU
 	select VDSO_GETRANDOM if MMU && 64BIT
 	select USER_STACKTRACE_SUPPORT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bc12367a7b00..4b51bc6e8948 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -291,7 +291,6 @@ config S390
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY
 	select USER_STACKTRACE_SUPPORT
-	select VDSO_CHECK
 	select VDSO_GETRANDOM
 	select VIRT_CPU_ACCOUNTING
 	select VMAP_STACK
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 628bdfc2f088..ab77d3f2536e 100644
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
index ee0f2c401980..15fd9ec5ecac 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -305,7 +305,6 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
-	select VDSO_CHECK
 	select VDSO_GETRANDOM			if X86_64
 	select HOTPLUG_PARALLEL			if SMP && X86_64
 	select HOTPLUG_SMT			if SMP
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 112b42a5aeb1..12a640c78b72 100644
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
2.55.0


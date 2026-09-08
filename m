Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B53859D4;
	Tue,  8 Sep 2026 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849239; cv=none; b=OQd+NxDZG7HT1m3EdetZPdxNshKo4zl8YcY+Kn+JqtH+0HM0uW3hk2klmf5cAUJCxxWyn4wFbt3ybM4EIPwlr58ecSUW8pjl4/0xGvfI4ueFEtlXGKdRQAORDb6JnszfRLeG1zPOjX8Z1pf5Sv6Y00uynbWRbu/VB+8JVyemIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849239; c=relaxed/simple;
	bh=b3nIkO5dCOkLCB+RhAZSMfv9iyr/5udIrKKC/R5UfGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3kv34qlJNDLUrhH7UNIJwsWfcIGdrt3qvKawz8veu8q5O+9YdRr5/QaIbZAy81cVwHDoD0emkleMkR2/bye/katWuy6jZw2wPcJB4ZHwyEu3zkEPjmoJ2wZVRYQqmVUcdOF4cJWWeQ9S6FMQb4dmxrP9HUJ4DsGxHSgZtHH1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=da+locf+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rGIpB+VW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="da+locf+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rGIpB+VW"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rCxHOjDU+1K4duStPKjAXJyT/7CSkrSSpDiIH+J3gQ=;
	b=da+locf+fYZS/T5UEThHqFcTDFXtvv69gxiMsF/ZubAOmr0jXYhOT3/KoH+tH/Op7c1vsy
	bpRepepo9H4IVaLokGW2IAwi1CWeXhd8o+dNwcx4sQhR3qvQh8ZBTI6S3Za8toe475YqL9
	m52Xec1PkVIHNnUIbn3no0eX4OaVjR4eFvZXam8e/0rp6XYFlSAcG0zrJO4CYAxWcD/7Bt
	tANKqUikMG/E33o4//5C703pUa8pqwDoJG3+m2PnIOpEmRRCwvUZcUhOxeAXqdjVJBbxMA
	fBIKwWukg4cdp/joxinRYCAl0XPGoVpBL/l3pBR9qkhcL0hyX26IC/ovUmuN9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rCxHOjDU+1K4duStPKjAXJyT/7CSkrSSpDiIH+J3gQ=;
	b=rGIpB+VWmPNCZoxaugfvlZgtr9WAIBlKJMe9XrdCQurBFn8CcRHDbE0U1PBy6BjjzxN9GO
	PeQVrvH5QgAT1ZCg==
Date: Tue, 08 Sep 2026 08:33:44 +0200
Subject: [PATCH v5 10/24] sparc: elf: Move relocation constants to UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-10-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=5043;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=b3nIkO5dCOkLCB+RhAZSMfv9iyr/5udIrKKC/R5UfGI=;
 b=FLRNHzsCqKdcJx3OOfwKa5Me9losfqQALszfZzWeIrGPgKpu5aG5hMJXNy/WjoqfB9MFnNHp1
 jIUinzpdhRoADtkUKsdgIyuWwsFe9f5ZRqdDteADesxBx76m5aXYrxr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These constants are useful for cross-platform userspace, for example to
process ELF files during kernel cross-compilation.

Move them from the kernel-private architecture-specific header to the UAPI.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/include/asm/elf_32.h | 43 ----------------------------------------
 arch/sparc/include/asm/elf_64.h | 44 -----------------------------------------
 include/uapi/linux/elf-r.h      | 44 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 87 deletions(-)

diff --git a/arch/sparc/include/asm/elf_32.h b/arch/sparc/include/asm/elf_32.h
index 37a6016c9ccd..02736284f7af 100644
--- a/arch/sparc/include/asm/elf_32.h
+++ b/arch/sparc/include/asm/elf_32.h
@@ -13,49 +13,6 @@
  */
 #define STT_REGISTER		13
 
-/*
- * Sparc ELF relocation types
- */
-#define	R_SPARC_NONE		0
-#define	R_SPARC_8		1
-#define	R_SPARC_16		2
-#define	R_SPARC_32		3
-#define	R_SPARC_DISP8		4
-#define	R_SPARC_DISP16		5
-#define	R_SPARC_DISP32		6
-#define	R_SPARC_WDISP30		7
-#define	R_SPARC_WDISP22		8
-#define	R_SPARC_HI22		9
-#define	R_SPARC_22		10
-#define	R_SPARC_13		11
-#define	R_SPARC_LO10		12
-#define	R_SPARC_GOT10		13
-#define	R_SPARC_GOT13		14
-#define	R_SPARC_GOT22		15
-#define	R_SPARC_PC10		16
-#define	R_SPARC_PC22		17
-#define	R_SPARC_WPLT30		18
-#define	R_SPARC_COPY		19
-#define	R_SPARC_GLOB_DAT	20
-#define	R_SPARC_JMP_SLOT	21
-#define	R_SPARC_RELATIVE	22
-#define	R_SPARC_UA32		23
-#define R_SPARC_PLT32		24
-#define R_SPARC_HIPLT22		25
-#define R_SPARC_LOPLT10		26
-#define R_SPARC_PCPLT32		27
-#define R_SPARC_PCPLT22		28
-#define R_SPARC_PCPLT10		29
-#define R_SPARC_10		30
-#define R_SPARC_11		31
-#define R_SPARC_64		32
-#define R_SPARC_OLO10		33
-#define R_SPARC_WDISP16		40
-#define R_SPARC_WDISP19		41
-#define R_SPARC_7		43
-#define R_SPARC_5		44
-#define R_SPARC_6		45
-
 /* Bits present in AT_HWCAP, primarily for Sparc32.  */
 
 #define HWCAP_SPARC_FLUSH       1    /* CPU supports flush instruction. */
diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 694ed081cf8d..3be9e2d3a94a 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -16,50 +16,6 @@
  */
 #define STT_REGISTER		13
 
-/*
- * Sparc ELF relocation types
- */
-#define	R_SPARC_NONE		0
-#define	R_SPARC_8		1
-#define	R_SPARC_16		2
-#define	R_SPARC_32		3
-#define	R_SPARC_DISP8		4
-#define	R_SPARC_DISP16		5
-#define	R_SPARC_DISP32		6
-#define	R_SPARC_WDISP30		7
-#define	R_SPARC_WDISP22		8
-#define	R_SPARC_HI22		9
-#define	R_SPARC_22		10
-#define	R_SPARC_13		11
-#define	R_SPARC_LO10		12
-#define	R_SPARC_GOT10		13
-#define	R_SPARC_GOT13		14
-#define	R_SPARC_GOT22		15
-#define	R_SPARC_PC10		16
-#define	R_SPARC_PC22		17
-#define	R_SPARC_WPLT30		18
-#define	R_SPARC_COPY		19
-#define	R_SPARC_GLOB_DAT	20
-#define	R_SPARC_JMP_SLOT	21
-#define	R_SPARC_RELATIVE	22
-#define	R_SPARC_UA32		23
-#define R_SPARC_PLT32		24
-#define R_SPARC_HIPLT22		25
-#define R_SPARC_LOPLT10		26
-#define R_SPARC_PCPLT32		27
-#define R_SPARC_PCPLT22		28
-#define R_SPARC_PCPLT10		29
-#define R_SPARC_10		30
-#define R_SPARC_11		31
-#define R_SPARC_64		32
-#define R_SPARC_OLO10		33
-#define R_SPARC_WDISP16		40
-#define R_SPARC_WDISP19		41
-#define R_SPARC_7		43
-#define R_SPARC_5		44
-#define R_SPARC_6		45
-#define R_SPARC_UA64		54
-
 /* Bits present in AT_HWCAP, primarily for Sparc32.  */
 #define HWCAP_SPARC_FLUSH       0x00000001
 #define HWCAP_SPARC_STBAR       0x00000002
diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 0c6a8698f300..72fc9045a5d4 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -649,4 +649,48 @@
 
 #define R_MIPS_PC32		248
 
+/*
+ * Sparc ELF relocation types
+ */
+#define	R_SPARC_NONE		0
+#define	R_SPARC_8		1
+#define	R_SPARC_16		2
+#define	R_SPARC_32		3
+#define	R_SPARC_DISP8		4
+#define	R_SPARC_DISP16		5
+#define	R_SPARC_DISP32		6
+#define	R_SPARC_WDISP30		7
+#define	R_SPARC_WDISP22		8
+#define	R_SPARC_HI22		9
+#define	R_SPARC_22		10
+#define	R_SPARC_13		11
+#define	R_SPARC_LO10		12
+#define	R_SPARC_GOT10		13
+#define	R_SPARC_GOT13		14
+#define	R_SPARC_GOT22		15
+#define	R_SPARC_PC10		16
+#define	R_SPARC_PC22		17
+#define	R_SPARC_WPLT30		18
+#define	R_SPARC_COPY		19
+#define	R_SPARC_GLOB_DAT	20
+#define	R_SPARC_JMP_SLOT	21
+#define	R_SPARC_RELATIVE	22
+#define	R_SPARC_UA32		23
+#define R_SPARC_PLT32		24
+#define R_SPARC_HIPLT22		25
+#define R_SPARC_LOPLT10		26
+#define R_SPARC_PCPLT32		27
+#define R_SPARC_PCPLT22		28
+#define R_SPARC_PCPLT10		29
+#define R_SPARC_10		30
+#define R_SPARC_11		31
+#define R_SPARC_64		32
+#define R_SPARC_OLO10		33
+#define R_SPARC_WDISP16		40
+#define R_SPARC_WDISP19		41
+#define R_SPARC_7		43
+#define R_SPARC_5		44
+#define R_SPARC_6		45
+#define R_SPARC_UA64		54
+
 #endif /* _UAPI_LINUX_ELF_R_H */

-- 
2.55.0


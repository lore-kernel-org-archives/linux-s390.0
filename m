Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB23A7849;
	Tue,  8 Sep 2026 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849237; cv=none; b=KlwlxRmSRqfAT6C/vNJFCWBizwICod32WIp/vFfNNb9wZPUD0g6nCvwvho8gnUTLENMnpdqN35nMhUfTjVd4q7GGBAN7TBUKa+Ri+H34gE3nn/NIz3DPhgvBPlo8IUv2NUy/WYK7lIPChmfjnUT+XcqC391F43w3GiZVst3CjW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849237; c=relaxed/simple;
	bh=A10H22cVXmPgY/NixL/2JhIgd7FK72hpu8GKd8hQAKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KnsWrQkKwvt5Rn1Tsqzs5m6IwssVv0BgcIN2jTDy6xBtn2ujy481/PMvevlAx2K5MXwFwCnFRVQEWkbE6ur3+JIgx609bEm+ZYNs1KgAeun1AVmEeA75CiLXTNy/2KilCO/kjKO+hRRUtPKC2oB6h5Sb824V3hH1f4TFGNVAsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ahR3dXuI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VZsZyyx6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ahR3dXuI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VZsZyyx6"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJq6yR2p7bWWswQ+1JaEFwknbMonVxi+i+XtDlX1VJE=;
	b=ahR3dXuIvmy9rLY/NaJKRHDCHK0nSGp3+7XiZcORdfSnIPwrsGHbO7bgDbz8h9Ed9Nqwm2
	aoWGwa9rBrndpnaB9nw64Kj1w1m+8AUs44vqnM7PPYmHMeeEEo406mkBUaoKh9Hj8RAfv7
	jjc7ulGhFOejma1EKD+dVfp5TS189yjYMsgnV7FxGuGah4BrD5a8ivX5lxTOo9D1pUlbi7
	A2kvwa+AUJtq/vfQPN+lxM4XcUiIBNFikfImhIdNpNaFyr/x5u2PjfCgaPu7M+xUn5eqzi
	by8lXtwRNpOWf3XzVgrg9kptObSnF4I4PxRDxSv6HilvMNkMswBwyTjPqcyvjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJq6yR2p7bWWswQ+1JaEFwknbMonVxi+i+XtDlX1VJE=;
	b=VZsZyyx6tVMPgVUY8ZTFc6uDIAMDbc5w2oz5UFAf/4aF13Vb6IF0cflWvNHI9lzRI8DjSR
	iNQZmO5z7gh/+JCw==
Date: Tue, 08 Sep 2026 08:33:43 +0200
Subject: [PATCH v5 09/24] MIPS: ELF: Move relocation constants to UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-9-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=4382;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=A10H22cVXmPgY/NixL/2JhIgd7FK72hpu8GKd8hQAKo=;
 b=qKSQneyNuKEBUb6rfiRCvkfACMHprRMYmjlZw9I/e5PmwvqMoWeNI3JR4y8qsFGqgWsmxafnd
 O3IJy63bZaPB7kwaUolzd0zlzGxuCuw9umZ22crEBlrxXnL6ZfXMF3b
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These constants are useful for cross-platform userspace, for example to
process ELF files during kernel cross-compilation.

Move them from the kernel-private architecture-specific header to the UAPI.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/include/asm/elf.h | 55 --------------------------------------------
 include/uapi/linux/elf-r.h  | 56 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index aaef0eaa68d5..347e12584bee 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -70,61 +70,6 @@
 #define DT_MIPS_HIPAGENO	0x70000014
 #define DT_MIPS_RLD_MAP		0x70000016
 
-#define R_MIPS_NONE		0
-#define R_MIPS_16		1
-#define R_MIPS_32		2
-#define R_MIPS_REL32		3
-#define R_MIPS_26		4
-#define R_MIPS_HI16		5
-#define R_MIPS_LO16		6
-#define R_MIPS_GPREL16		7
-#define R_MIPS_LITERAL		8
-#define R_MIPS_GOT16		9
-#define R_MIPS_PC16		10
-#define R_MIPS_CALL16		11
-#define R_MIPS_GPREL32		12
-/* The remaining relocs are defined on Irix, although they are not
-   in the MIPS ELF ABI.	 */
-#define R_MIPS_UNUSED1		13
-#define R_MIPS_UNUSED2		14
-#define R_MIPS_UNUSED3		15
-#define R_MIPS_SHIFT5		16
-#define R_MIPS_SHIFT6		17
-#define R_MIPS_64		18
-#define R_MIPS_GOT_DISP		19
-#define R_MIPS_GOT_PAGE		20
-#define R_MIPS_GOT_OFST		21
-/*
- * The following two relocation types are specified in the MIPS ABI
- * conformance guide version 1.2 but not yet in the psABI.
- */
-#define R_MIPS_GOTHI16		22
-#define R_MIPS_GOTLO16		23
-#define R_MIPS_SUB		24
-#define R_MIPS_INSERT_A		25
-#define R_MIPS_INSERT_B		26
-#define R_MIPS_DELETE		27
-#define R_MIPS_HIGHER		28
-#define R_MIPS_HIGHEST		29
-/*
- * The following two relocation types are specified in the MIPS ABI
- * conformance guide version 1.2 but not yet in the psABI.
- */
-#define R_MIPS_CALLHI16		30
-#define R_MIPS_CALLLO16		31
-/*
- * Introduced for MIPSr6.
- */
-#define R_MIPS_PC21_S2		60
-#define R_MIPS_PC26_S2		61
-/*
- * This range is reserved for vendor specific relocations.
- */
-#define R_MIPS_LOVENDOR		100
-#define R_MIPS_HIVENDOR		127
-
-#define R_MIPS_PC32		248
-
 #define SHN_MIPS_ACCOMON	0xff00		/* Allocated common symbols */
 #define SHN_MIPS_TEXT		0xff01		/* Allocated test symbols.  */
 #define SHN_MIPS_DATA		0xff02		/* Allocated data symbols.  */
diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 3d9e3b57f1ff..0c6a8698f300 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -593,4 +593,60 @@
 /* Keep this the last entry.  */
 #define R_390_NUM	61
 
+/* MIPS relocations defined by the ABIs */
+#define R_MIPS_NONE		0
+#define R_MIPS_16		1
+#define R_MIPS_32		2
+#define R_MIPS_REL32		3
+#define R_MIPS_26		4
+#define R_MIPS_HI16		5
+#define R_MIPS_LO16		6
+#define R_MIPS_GPREL16		7
+#define R_MIPS_LITERAL		8
+#define R_MIPS_GOT16		9
+#define R_MIPS_PC16		10
+#define R_MIPS_CALL16		11
+#define R_MIPS_GPREL32		12
+/* The remaining relocs are defined on Irix, although they are not
+   in the MIPS ELF ABI.	 */
+#define R_MIPS_UNUSED1		13
+#define R_MIPS_UNUSED2		14
+#define R_MIPS_UNUSED3		15
+#define R_MIPS_SHIFT5		16
+#define R_MIPS_SHIFT6		17
+#define R_MIPS_64		18
+#define R_MIPS_GOT_DISP		19
+#define R_MIPS_GOT_PAGE		20
+#define R_MIPS_GOT_OFST		21
+/*
+ * The following two relocation types are specified in the MIPS ABI
+ * conformance guide version 1.2 but not yet in the psABI.
+ */
+#define R_MIPS_GOTHI16		22
+#define R_MIPS_GOTLO16		23
+#define R_MIPS_SUB		24
+#define R_MIPS_INSERT_A		25
+#define R_MIPS_INSERT_B		26
+#define R_MIPS_DELETE		27
+#define R_MIPS_HIGHER		28
+#define R_MIPS_HIGHEST		29
+/*
+ * The following two relocation types are specified in the MIPS ABI
+ * conformance guide version 1.2 but not yet in the psABI.
+ */
+#define R_MIPS_CALLHI16		30
+#define R_MIPS_CALLLO16		31
+/*
+ * Introduced for MIPSr6.
+ */
+#define R_MIPS_PC21_S2		60
+#define R_MIPS_PC26_S2		61
+/*
+ * This range is reserved for vendor specific relocations.
+ */
+#define R_MIPS_LOVENDOR		100
+#define R_MIPS_HIVENDOR		127
+
+#define R_MIPS_PC32		248
+
 #endif /* _UAPI_LINUX_ELF_R_H */

-- 
2.55.0


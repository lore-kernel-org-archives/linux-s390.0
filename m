Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3F3A0EB8;
	Tue,  8 Sep 2026 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849237; cv=none; b=u5tiKca0PSJ+nodEiSZTtL14PvSbBdI8pD5Cw++s+9o4YvLSeJR2TEHQMY8FlXcva1upCehx7XYfBSIprBpusHNAj9Zf7I9EBzwWfetJMYB/PMlkN0Ov3oq8rV5eU+jKARXTY60/vgyr0DWa3m4Sr6VhufJrLkJWmb4xhruyL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849237; c=relaxed/simple;
	bh=A2KwwyE44rpRvMfg8HmJMKqJMXpNGArDCbHCP2lPOtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ga9Qai0XMcBAjbQ7UOYxgkrBhtd192Msio6cjkTx3bAyg9KinMBbNIVyFVcBIPbqp9I6B3MbFUcSxhpZP7C4AswD9823mSDNPVCCHD5uQQk+QR2lAkbHMSn29MmBzb26QWcoUx4XRcA2Ufxg3DkFRL2OwcL84HlPOkNwELtTj5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBfchTQ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=epagOxWH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBfchTQ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="epagOxWH"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FawW0xiyyB3XDpeEil2328xu9JZeGaaUH29QSwtR0fg=;
	b=BBfchTQ31DifkjFqwb5y4n5BvOGW48DOyhiHYRpdPzrEQcn+IitYmXoSVnLWzvWa6lwHuy
	sZD+8Y+YV+U5Q+RLLiaQuk6+JRBJF9vi1Y1DGh92/GH1x2M0Sy+puIE8ZRZhqgBqF9ZxcX
	OVMEGjMH4cuC2Ih8qYPFGclgRGEjWPRnkw/+9BlYAZfTwu3dB+NLPwZ6JmOUFvLGShphqo
	lpE6byOStxgm5iAG6jOHo0tEAOdE8cTToyKI6d+gadpfoJgZfZRrWhapeXH8p8WEX3WKnq
	ZIRI/ePB8OFwnrq7FOJP8oo233EMrmmz/MJKwghMXEJPb8wamnhU9yuJgEsxpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FawW0xiyyB3XDpeEil2328xu9JZeGaaUH29QSwtR0fg=;
	b=epagOxWHbraL4pZF2ABSEKqkk81eezIl8Gi009ltXa6+5yB+cGQ8VNDm3CyFBBc9mW3J0y
	3loMMVZFFoRrE7AA==
Date: Tue, 08 Sep 2026 08:33:40 +0200
Subject: [PATCH v5 06/24] riscv: elf: Move relocation constants to UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-6-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=4962;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=A2KwwyE44rpRvMfg8HmJMKqJMXpNGArDCbHCP2lPOtc=;
 b=BIFQBlA6uOHvotUFp7WcFcjkRWr4zWTBvAzopoDSHqbuVQn/0iY7yQ9cklHXDfQCbhw1lLP4v
 +pw2vSBQ8BmAxY2zgjj9x+KL+h6I3EZtcmF2oBqsXSxkzdljxYY/Ns5
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These constants are useful for cross-platform userspace, for example to
process ELF files during kernel cross-compilation.

Move them from the kernel-private architecture-specific header to the UAPI.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/uapi/asm/elf.h | 66 ---------------------------------------
 include/uapi/linux/elf-r.h        | 66 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index 11a71b8533d5..05cf74a4a535 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -32,70 +32,4 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define ELF_RISCV_R_TYPE(r_info)	ELF32_R_TYPE(r_info)
 #endif
 
-/*
- * RISC-V relocation types
- */
-
-/* Relocation types used by the dynamic linker */
-#define R_RISCV_NONE		0
-#define R_RISCV_32		1
-#define R_RISCV_64		2
-#define R_RISCV_RELATIVE	3
-#define R_RISCV_COPY		4
-#define R_RISCV_JUMP_SLOT	5
-#define R_RISCV_TLS_DTPMOD32	6
-#define R_RISCV_TLS_DTPMOD64	7
-#define R_RISCV_TLS_DTPREL32	8
-#define R_RISCV_TLS_DTPREL64	9
-#define R_RISCV_TLS_TPREL32	10
-#define R_RISCV_TLS_TPREL64	11
-#define R_RISCV_IRELATIVE	58
-
-/* Relocation types not used by the dynamic linker */
-#define R_RISCV_BRANCH		16
-#define R_RISCV_JAL		17
-#define R_RISCV_CALL		18
-#define R_RISCV_CALL_PLT	19
-#define R_RISCV_GOT_HI20	20
-#define R_RISCV_TLS_GOT_HI20	21
-#define R_RISCV_TLS_GD_HI20	22
-#define R_RISCV_PCREL_HI20	23
-#define R_RISCV_PCREL_LO12_I	24
-#define R_RISCV_PCREL_LO12_S	25
-#define R_RISCV_HI20		26
-#define R_RISCV_LO12_I		27
-#define R_RISCV_LO12_S		28
-#define R_RISCV_TPREL_HI20	29
-#define R_RISCV_TPREL_LO12_I	30
-#define R_RISCV_TPREL_LO12_S	31
-#define R_RISCV_TPREL_ADD	32
-#define R_RISCV_ADD8		33
-#define R_RISCV_ADD16		34
-#define R_RISCV_ADD32		35
-#define R_RISCV_ADD64		36
-#define R_RISCV_SUB8		37
-#define R_RISCV_SUB16		38
-#define R_RISCV_SUB32		39
-#define R_RISCV_SUB64		40
-#define R_RISCV_GNU_VTINHERIT	41
-#define R_RISCV_GNU_VTENTRY	42
-#define R_RISCV_ALIGN		43
-#define R_RISCV_RVC_BRANCH	44
-#define R_RISCV_RVC_JUMP	45
-#define R_RISCV_GPREL_I		47
-#define R_RISCV_GPREL_S		48
-#define R_RISCV_TPREL_I		49
-#define R_RISCV_TPREL_S		50
-#define R_RISCV_RELAX		51
-#define R_RISCV_SUB6		52
-#define R_RISCV_SET6		53
-#define R_RISCV_SET8		54
-#define R_RISCV_SET16		55
-#define R_RISCV_SET32		56
-#define R_RISCV_32_PCREL	57
-#define R_RISCV_PLT32		59
-#define R_RISCV_SET_ULEB128	60
-#define R_RISCV_SUB_ULEB128	61
-
-
 #endif /* _UAPI_ASM_RISCV_ELF_H */
diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 0d0dfaa7c724..02e420c255df 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -314,4 +314,70 @@
 /* Keep this the last entry.  */
 #define R_PPC64_NUM		253
 
+
+/*
+ * RISC-V relocation types
+ */
+
+/* Relocation types used by the dynamic linker */
+#define R_RISCV_NONE		0
+#define R_RISCV_32		1
+#define R_RISCV_64		2
+#define R_RISCV_RELATIVE	3
+#define R_RISCV_COPY		4
+#define R_RISCV_JUMP_SLOT	5
+#define R_RISCV_TLS_DTPMOD32	6
+#define R_RISCV_TLS_DTPMOD64	7
+#define R_RISCV_TLS_DTPREL32	8
+#define R_RISCV_TLS_DTPREL64	9
+#define R_RISCV_TLS_TPREL32	10
+#define R_RISCV_TLS_TPREL64	11
+#define R_RISCV_IRELATIVE	58
+
+/* Relocation types not used by the dynamic linker */
+#define R_RISCV_BRANCH		16
+#define R_RISCV_JAL		17
+#define R_RISCV_CALL		18
+#define R_RISCV_CALL_PLT	19
+#define R_RISCV_GOT_HI20	20
+#define R_RISCV_TLS_GOT_HI20	21
+#define R_RISCV_TLS_GD_HI20	22
+#define R_RISCV_PCREL_HI20	23
+#define R_RISCV_PCREL_LO12_I	24
+#define R_RISCV_PCREL_LO12_S	25
+#define R_RISCV_HI20		26
+#define R_RISCV_LO12_I		27
+#define R_RISCV_LO12_S		28
+#define R_RISCV_TPREL_HI20	29
+#define R_RISCV_TPREL_LO12_I	30
+#define R_RISCV_TPREL_LO12_S	31
+#define R_RISCV_TPREL_ADD	32
+#define R_RISCV_ADD8		33
+#define R_RISCV_ADD16		34
+#define R_RISCV_ADD32		35
+#define R_RISCV_ADD64		36
+#define R_RISCV_SUB8		37
+#define R_RISCV_SUB16		38
+#define R_RISCV_SUB32		39
+#define R_RISCV_SUB64		40
+#define R_RISCV_GNU_VTINHERIT	41
+#define R_RISCV_GNU_VTENTRY	42
+#define R_RISCV_ALIGN		43
+#define R_RISCV_RVC_BRANCH	44
+#define R_RISCV_RVC_JUMP	45
+#define R_RISCV_GPREL_I		47
+#define R_RISCV_GPREL_S		48
+#define R_RISCV_TPREL_I		49
+#define R_RISCV_TPREL_S		50
+#define R_RISCV_RELAX		51
+#define R_RISCV_SUB6		52
+#define R_RISCV_SET6		53
+#define R_RISCV_SET8		54
+#define R_RISCV_SET16		55
+#define R_RISCV_SET32		56
+#define R_RISCV_32_PCREL	57
+#define R_RISCV_PLT32		59
+#define R_RISCV_SET_ULEB128	60
+#define R_RISCV_SUB_ULEB128	61
+
 #endif /* _UAPI_LINUX_ELF_R_H */

-- 
2.55.0


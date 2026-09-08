Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382573A783D;
	Tue,  8 Sep 2026 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849239; cv=none; b=IV0jIdOHSH1760EtQjWOPI1IPfaGrW0+O0q2Ci413FpJawDrlllZT/9tUZKLf8AQQcAm/ICHk4TRbJI6o/rvbGsXyqfahAscpiPG6/sLntUa2kxsTd6hNxFceObhtZk3oWil+JajzW+l2d2D6WQyDxI2gl7iwQJnGO9R3r7mugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849239; c=relaxed/simple;
	bh=TVNv1EnbeVl7eOp2X/cpMXp3v4L6yRWQXdRgwohhP1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QnLDrKcn8iyM0AHT8bEPucRAFQcbQ3eada1OE9xgc+Ey9j+oZ+I5/LRfS3jqtl0JcgSZSNlFJmiTRTUcNoX2ddpilZYg9di6jbd/qZE6R7sPhN7+ULsUOOenkbtWNsHJUy+mvmg7KKpdb4Z2nXwX5eYnuR+FwfmcjcbwEvTx2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RvteM5pX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tPWSdfCK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RvteM5pX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tPWSdfCK"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGf3TnE/lW/fYbZlFBrmGDjZjd6QYLG2uDJD7NOhZPg=;
	b=RvteM5pX/6scTvVHhc9nHPA51oZliMFKpw0j5QYKMFpse7+yPHSkVy9fM+rso/Wb2YFrm1
	H1wiqXKWH1Z2v3SGs3royO/jD58rDDfo11wybTYB9b0p52SEr1U93v/XqQsxU3Oz4QOvXM
	lB9yw3AsT0ySjk0xrTX7JA5uNIOUl9V0q9lwcoZAUyxlZjaonToBT7f4xPG3MCq6XztezM
	4IUl0hofZ21/AcEdhGZv5aCyyQyxkmx81s1BIOMmsqgAt4bfXss0uaKrGwDolo8Nz1mueb
	HIbO21hw0BEwZGhu5nDiFjPqpQUd/uWztc8r7Mp5JuDJYZbhdyZxqsyCd2nS6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGf3TnE/lW/fYbZlFBrmGDjZjd6QYLG2uDJD7NOhZPg=;
	b=tPWSdfCKOrl+sngE7bk54ExyIa5LzKKavkT70SIPlYNF5G1LVQzybS8BYFZ3IaW4EZdY9Z
	8ES7SXoSssj4LgDw==
Date: Tue, 08 Sep 2026 08:33:41 +0200
Subject: [PATCH v5 07/24] LoongArch: Move relocation constants to UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-7-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=10431;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TVNv1EnbeVl7eOp2X/cpMXp3v4L6yRWQXdRgwohhP1I=;
 b=H7Of+EsKkYRm00bvzre3reaxsgBnlaZY8AOjsL+5NYLinUvECXNhAROQlYKStcUa1mehUxMl/
 fwHuq7Wucb3BtsShMthHqQgQZN4C/z+vtTAIEgpoimFJKe1C60eIDd3
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These constants are useful for cross-platform userspace, for example to
process ELF files during kernel cross-compilation.

Move them from the kernel-private architecture-specific header to the UAPI.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/include/asm/elf.h | 130 ---------------------------------------
 include/uapi/linux/elf-r.h       | 130 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
index 912c50cdd6b7..3cbce7e772fa 100644
--- a/arch/loongarch/include/asm/elf.h
+++ b/arch/loongarch/include/asm/elf.h
@@ -21,136 +21,6 @@
 #define EF_LOONGARCH_ABI_ILP32_SINGLE_FLOAT	0x6
 #define EF_LOONGARCH_ABI_ILP32_DOUBLE_FLOAT	0x7
 
-/* LoongArch relocation types used by the dynamic linker */
-#define R_LARCH_NONE				0
-#define R_LARCH_32				1
-#define R_LARCH_64				2
-#define R_LARCH_RELATIVE			3
-#define R_LARCH_COPY				4
-#define R_LARCH_JUMP_SLOT			5
-#define R_LARCH_TLS_DTPMOD32			6
-#define R_LARCH_TLS_DTPMOD64			7
-#define R_LARCH_TLS_DTPREL32			8
-#define R_LARCH_TLS_DTPREL64			9
-#define R_LARCH_TLS_TPREL32			10
-#define R_LARCH_TLS_TPREL64			11
-#define R_LARCH_IRELATIVE			12
-#define R_LARCH_MARK_LA				20
-#define R_LARCH_MARK_PCREL			21
-#define R_LARCH_SOP_PUSH_PCREL			22
-#define R_LARCH_SOP_PUSH_ABSOLUTE		23
-#define R_LARCH_SOP_PUSH_DUP			24
-#define R_LARCH_SOP_PUSH_GPREL			25
-#define R_LARCH_SOP_PUSH_TLS_TPREL		26
-#define R_LARCH_SOP_PUSH_TLS_GOT		27
-#define R_LARCH_SOP_PUSH_TLS_GD			28
-#define R_LARCH_SOP_PUSH_PLT_PCREL		29
-#define R_LARCH_SOP_ASSERT			30
-#define R_LARCH_SOP_NOT				31
-#define R_LARCH_SOP_SUB				32
-#define R_LARCH_SOP_SL				33
-#define R_LARCH_SOP_SR				34
-#define R_LARCH_SOP_ADD				35
-#define R_LARCH_SOP_AND				36
-#define R_LARCH_SOP_IF_ELSE			37
-#define R_LARCH_SOP_POP_32_S_10_5		38
-#define R_LARCH_SOP_POP_32_U_10_12		39
-#define R_LARCH_SOP_POP_32_S_10_12		40
-#define R_LARCH_SOP_POP_32_S_10_16		41
-#define R_LARCH_SOP_POP_32_S_10_16_S2		42
-#define R_LARCH_SOP_POP_32_S_5_20		43
-#define R_LARCH_SOP_POP_32_S_0_5_10_16_S2	44
-#define R_LARCH_SOP_POP_32_S_0_10_10_16_S2	45
-#define R_LARCH_SOP_POP_32_U			46
-#define R_LARCH_ADD8				47
-#define R_LARCH_ADD16				48
-#define R_LARCH_ADD24				49
-#define R_LARCH_ADD32				50
-#define R_LARCH_ADD64				51
-#define R_LARCH_SUB8				52
-#define R_LARCH_SUB16				53
-#define R_LARCH_SUB24				54
-#define R_LARCH_SUB32				55
-#define R_LARCH_SUB64				56
-#define R_LARCH_GNU_VTINHERIT			57
-#define R_LARCH_GNU_VTENTRY			58
-#define R_LARCH_B16				64
-#define R_LARCH_B21				65
-#define R_LARCH_B26				66
-#define R_LARCH_ABS_HI20			67
-#define R_LARCH_ABS_LO12			68
-#define R_LARCH_ABS64_LO20			69
-#define R_LARCH_ABS64_HI12			70
-#define R_LARCH_PCALA_HI20			71
-#define R_LARCH_PCALA_LO12			72
-#define R_LARCH_PCALA64_LO20			73
-#define R_LARCH_PCALA64_HI12			74
-#define R_LARCH_GOT_PC_HI20			75
-#define R_LARCH_GOT_PC_LO12			76
-#define R_LARCH_GOT64_PC_LO20			77
-#define R_LARCH_GOT64_PC_HI12			78
-#define R_LARCH_GOT_HI20			79
-#define R_LARCH_GOT_LO12			80
-#define R_LARCH_GOT64_LO20			81
-#define R_LARCH_GOT64_HI12			82
-#define R_LARCH_TLS_LE_HI20			83
-#define R_LARCH_TLS_LE_LO12			84
-#define R_LARCH_TLS_LE64_LO20			85
-#define R_LARCH_TLS_LE64_HI12			86
-#define R_LARCH_TLS_IE_PC_HI20			87
-#define R_LARCH_TLS_IE_PC_LO12			88
-#define R_LARCH_TLS_IE64_PC_LO20		89
-#define R_LARCH_TLS_IE64_PC_HI12		90
-#define R_LARCH_TLS_IE_HI20			91
-#define R_LARCH_TLS_IE_LO12			92
-#define R_LARCH_TLS_IE64_LO20			93
-#define R_LARCH_TLS_IE64_HI12			94
-#define R_LARCH_TLS_LD_PC_HI20			95
-#define R_LARCH_TLS_LD_HI20			96
-#define R_LARCH_TLS_GD_PC_HI20			97
-#define R_LARCH_TLS_GD_HI20			98
-#define R_LARCH_32_PCREL			99
-#define R_LARCH_RELAX				100
-#define R_LARCH_DELETE				101
-#define R_LARCH_ALIGN				102
-#define R_LARCH_PCREL20_S2			103
-#define R_LARCH_CFA				104
-#define R_LARCH_ADD6				105
-#define R_LARCH_SUB6				106
-#define R_LARCH_ADD_ULEB128			107
-#define R_LARCH_SUB_ULEB128			108
-#define R_LARCH_64_PCREL			109
-#define R_LARCH_CALL36				110
-#define R_LARCH_TLS_DESC_PC_HI20		111
-#define R_LARCH_TLS_DESC_PC_LO12		112
-#define R_LARCH_TLS_DESC64_PC_LO20		113
-#define R_LARCH_TLS_DESC64_PC_HI12		114
-#define R_LARCH_TLS_DESC_HI20			115
-#define R_LARCH_TLS_DESC_LO12			116
-#define R_LARCH_TLS_DESC64_LO20			117
-#define R_LARCH_TLS_DESC64_HI12			118
-#define R_LARCH_TLS_DESC_LD			119
-#define R_LARCH_TLS_DESC_CALL			120
-#define R_LARCH_TLS_LE_HI20_R			121
-#define R_LARCH_TLS_LE_ADD_R			122
-#define R_LARCH_TLS_LE_LO12_R			123
-#define R_LARCH_TLS_LD_PCREL20_S2		124
-#define R_LARCH_TLS_GD_PCREL20_S2		125
-#define R_LARCH_TLS_DESC_PCREL20_S2		126
-#define R_LARCH_CALL30				127
-#define R_LARCH_PCADD_HI20			128
-#define R_LARCH_PCADD_LO12			129
-#define R_LARCH_GOT_PCADD_HI20			130
-#define R_LARCH_GOT_PCADD_LO12			131
-#define R_LARCH_TLS_IE_PCADD_HI20		132
-#define R_LARCH_TLS_IE_PCADD_LO12		133
-#define R_LARCH_TLS_LD_PCADD_HI20		134
-#define R_LARCH_TLS_LD_PCADD_LO12		135
-#define R_LARCH_TLS_GD_PCADD_HI20		136
-#define R_LARCH_TLS_GD_PCADD_LO12		137
-#define R_LARCH_TLS_DESC_PCADD_HI20		138
-#define R_LARCH_TLS_DESC_PCADD_LO12		139
-
 #ifndef ELF_ARCH
 
 /* ELF register definitions */
diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 02e420c255df..4b6d3f111d7b 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -380,4 +380,134 @@
 #define R_RISCV_SET_ULEB128	60
 #define R_RISCV_SUB_ULEB128	61
 
+/* LoongArch relocation types used by the dynamic linker */
+#define R_LARCH_NONE				0
+#define R_LARCH_32				1
+#define R_LARCH_64				2
+#define R_LARCH_RELATIVE			3
+#define R_LARCH_COPY				4
+#define R_LARCH_JUMP_SLOT			5
+#define R_LARCH_TLS_DTPMOD32			6
+#define R_LARCH_TLS_DTPMOD64			7
+#define R_LARCH_TLS_DTPREL32			8
+#define R_LARCH_TLS_DTPREL64			9
+#define R_LARCH_TLS_TPREL32			10
+#define R_LARCH_TLS_TPREL64			11
+#define R_LARCH_IRELATIVE			12
+#define R_LARCH_MARK_LA				20
+#define R_LARCH_MARK_PCREL			21
+#define R_LARCH_SOP_PUSH_PCREL			22
+#define R_LARCH_SOP_PUSH_ABSOLUTE		23
+#define R_LARCH_SOP_PUSH_DUP			24
+#define R_LARCH_SOP_PUSH_GPREL			25
+#define R_LARCH_SOP_PUSH_TLS_TPREL		26
+#define R_LARCH_SOP_PUSH_TLS_GOT		27
+#define R_LARCH_SOP_PUSH_TLS_GD			28
+#define R_LARCH_SOP_PUSH_PLT_PCREL		29
+#define R_LARCH_SOP_ASSERT			30
+#define R_LARCH_SOP_NOT				31
+#define R_LARCH_SOP_SUB				32
+#define R_LARCH_SOP_SL				33
+#define R_LARCH_SOP_SR				34
+#define R_LARCH_SOP_ADD				35
+#define R_LARCH_SOP_AND				36
+#define R_LARCH_SOP_IF_ELSE			37
+#define R_LARCH_SOP_POP_32_S_10_5		38
+#define R_LARCH_SOP_POP_32_U_10_12		39
+#define R_LARCH_SOP_POP_32_S_10_12		40
+#define R_LARCH_SOP_POP_32_S_10_16		41
+#define R_LARCH_SOP_POP_32_S_10_16_S2		42
+#define R_LARCH_SOP_POP_32_S_5_20		43
+#define R_LARCH_SOP_POP_32_S_0_5_10_16_S2	44
+#define R_LARCH_SOP_POP_32_S_0_10_10_16_S2	45
+#define R_LARCH_SOP_POP_32_U			46
+#define R_LARCH_ADD8				47
+#define R_LARCH_ADD16				48
+#define R_LARCH_ADD24				49
+#define R_LARCH_ADD32				50
+#define R_LARCH_ADD64				51
+#define R_LARCH_SUB8				52
+#define R_LARCH_SUB16				53
+#define R_LARCH_SUB24				54
+#define R_LARCH_SUB32				55
+#define R_LARCH_SUB64				56
+#define R_LARCH_GNU_VTINHERIT			57
+#define R_LARCH_GNU_VTENTRY			58
+#define R_LARCH_B16				64
+#define R_LARCH_B21				65
+#define R_LARCH_B26				66
+#define R_LARCH_ABS_HI20			67
+#define R_LARCH_ABS_LO12			68
+#define R_LARCH_ABS64_LO20			69
+#define R_LARCH_ABS64_HI12			70
+#define R_LARCH_PCALA_HI20			71
+#define R_LARCH_PCALA_LO12			72
+#define R_LARCH_PCALA64_LO20			73
+#define R_LARCH_PCALA64_HI12			74
+#define R_LARCH_GOT_PC_HI20			75
+#define R_LARCH_GOT_PC_LO12			76
+#define R_LARCH_GOT64_PC_LO20			77
+#define R_LARCH_GOT64_PC_HI12			78
+#define R_LARCH_GOT_HI20			79
+#define R_LARCH_GOT_LO12			80
+#define R_LARCH_GOT64_LO20			81
+#define R_LARCH_GOT64_HI12			82
+#define R_LARCH_TLS_LE_HI20			83
+#define R_LARCH_TLS_LE_LO12			84
+#define R_LARCH_TLS_LE64_LO20			85
+#define R_LARCH_TLS_LE64_HI12			86
+#define R_LARCH_TLS_IE_PC_HI20			87
+#define R_LARCH_TLS_IE_PC_LO12			88
+#define R_LARCH_TLS_IE64_PC_LO20		89
+#define R_LARCH_TLS_IE64_PC_HI12		90
+#define R_LARCH_TLS_IE_HI20			91
+#define R_LARCH_TLS_IE_LO12			92
+#define R_LARCH_TLS_IE64_LO20			93
+#define R_LARCH_TLS_IE64_HI12			94
+#define R_LARCH_TLS_LD_PC_HI20			95
+#define R_LARCH_TLS_LD_HI20			96
+#define R_LARCH_TLS_GD_PC_HI20			97
+#define R_LARCH_TLS_GD_HI20			98
+#define R_LARCH_32_PCREL			99
+#define R_LARCH_RELAX				100
+#define R_LARCH_DELETE				101
+#define R_LARCH_ALIGN				102
+#define R_LARCH_PCREL20_S2			103
+#define R_LARCH_CFA				104
+#define R_LARCH_ADD6				105
+#define R_LARCH_SUB6				106
+#define R_LARCH_ADD_ULEB128			107
+#define R_LARCH_SUB_ULEB128			108
+#define R_LARCH_64_PCREL			109
+#define R_LARCH_CALL36				110
+#define R_LARCH_TLS_DESC_PC_HI20		111
+#define R_LARCH_TLS_DESC_PC_LO12		112
+#define R_LARCH_TLS_DESC64_PC_LO20		113
+#define R_LARCH_TLS_DESC64_PC_HI12		114
+#define R_LARCH_TLS_DESC_HI20			115
+#define R_LARCH_TLS_DESC_LO12			116
+#define R_LARCH_TLS_DESC64_LO20			117
+#define R_LARCH_TLS_DESC64_HI12			118
+#define R_LARCH_TLS_DESC_LD			119
+#define R_LARCH_TLS_DESC_CALL			120
+#define R_LARCH_TLS_LE_HI20_R			121
+#define R_LARCH_TLS_LE_ADD_R			122
+#define R_LARCH_TLS_LE_LO12_R			123
+#define R_LARCH_TLS_LD_PCREL20_S2		124
+#define R_LARCH_TLS_GD_PCREL20_S2		125
+#define R_LARCH_TLS_DESC_PCREL20_S2		126
+#define R_LARCH_CALL30				127
+#define R_LARCH_PCADD_HI20			128
+#define R_LARCH_PCADD_LO12			129
+#define R_LARCH_GOT_PCADD_HI20			130
+#define R_LARCH_GOT_PCADD_LO12			131
+#define R_LARCH_TLS_IE_PCADD_HI20		132
+#define R_LARCH_TLS_IE_PCADD_LO12		133
+#define R_LARCH_TLS_LD_PCADD_HI20		134
+#define R_LARCH_TLS_LD_PCADD_LO12		135
+#define R_LARCH_TLS_GD_PCADD_HI20		136
+#define R_LARCH_TLS_GD_PCADD_LO12		137
+#define R_LARCH_TLS_DESC_PCADD_HI20		138
+#define R_LARCH_TLS_DESC_PCADD_LO12		139
+
 #endif /* _UAPI_LINUX_ELF_R_H */

-- 
2.55.0


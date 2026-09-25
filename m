Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79D3B4EA4;
	Fri, 25 Sep 2026 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372809; cv=none; b=Uyqc++CoJDqSWiS9wUT7bVOeWccjuDgmkE2n4lonvJcwYlPt0Z8KavqV+kscOAtu3yuUUPEWSaie4QC4xDjDRArXfu2XHPg2v41PZVtcr/lGkYb3dziA8fM6TAWU0/H74lFr0qj0C4+rnQ14384kgYJwGpUUpWCeMHqkdQJGIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372809; c=relaxed/simple;
	bh=qfYb8LExFZKhOZoo6PYdu/74pKDZe28vsCDbBPgPD0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IvBoAqcWR8PvKE9ECW8Ax/ktqwGlf7vSV7csJGvnZN9+lj2ADEkJDx1LnXs492gHfE9yB3UN14cXh12ZwZIMJve0AD7oOHh4j44bgUXOZn88FpYbe0cO4xoco567Hg3cmwQTqlmsS7y8o/ED6WEcg1r5VS6az8kkBg/qVlGydk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjOCOMxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjOCOMxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DD01F000FF;
	Fri, 25 Sep 2026 21:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790372806;
	bh=DKt6P2Fl5MJjmmPs8iOrbwYY7/Dy3c/10TSsSmLgIWU=;
	h=From:Date:Subject:To:Cc;
	b=mjOCOMxonBQrI/fWpS54CVTATTo2gTSmDIx5aJ2pamRmFgvZF5+jTtkD2lXzW8h23
	 iCt9xJxaT8Cwn9jUJ7x5eM/8xQYEG1K7HmXFs8oPHgMXCR81FPLutdDlGc7y4/usU4
	 WTkRzjzEgLLxiqaALt9vAiBFnSJAvkQAZ9/35jSPzYb2YPYVrSG+4I//jtfWz3gOtJ
	 wCbBCh30deIt82y6rl6EiHrzpsl9UpbQjO+QXGPDjCdf3VC7kEQnzc/9t4B7r2mmiz
	 vssEJMjBYYxV3di4i2cTuY2PFnbGOaiUOJudDc5wKq02b/0xINAToZSlzKZ1SBgRkC
	 b+aQmc990kQzQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 25 Sep 2026 22:46:32 +0100
Subject: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQ6CMBBFr0K6dkw7Aoor72FYVDpAlbamrY2G9
 O4CnsDlS17++zML5DUFdi5m5inpoJ1dAHcF60ZpBwKtFmbIseaNqCGp4GCg6KVVzoBMTiswZAJ
 FmKZkAEs4lqqselnzgyC2LD099fq9Va7tj8PrdqcurtOrMeoQnf9sN5JYvf+KSYCAE5cN9kiIl
 bw8yFua9s4PrM05fwFKSm2x6QAAAA==
X-Change-ID: 20260916-vdso-getrandom-avoid-memset-llvm-24-74d45fa6031e
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8506; i=nathan@kernel.org;
 h=from:subject:message-id; bh=qfYb8LExFZKhOZoo6PYdu/74pKDZe28vsCDbBPgPD0M=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnbXu9RDM6o0Jg05QFvWviEi/3+0srrju74P981Zgq/2
 K8vv456d5SyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJvHvJ8D/avGLj8+5Nfocn
 sPIeE4lQ+qWUtcnXoez+07kPXa+bTXRk+J99+5f4t2va6xcujGQ2+XRa9aPGrBMBqyRmTn4sLnp
 S4jQDAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent change in LLVM [1], builds with the random vDSO
implementation, such as PowerPC and RISC-V, fail when checking the vDSO:

  arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not supported
  arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported

memset() is now generated when zeroing params->reserved for some builds
because LLVM has an optimization (now run in more instances) that can
recognize at compile time when it is assigning a static value to a
contiguous area of memory and turn that into a call to memset(). Both
clang and GCC assume memset() is always available [2].

clang provides a builtin, __builtin_memset_inline [3][4], that can be
used to ensure an external function call is not generated when zeroing
this memory. Use it when it is available.

While GCC has no issues with the current code, it has generated memset()
before, as seen in commit b7bad082e113 ("random: vDSO: avoid call to out
of line memset()"). GCC 14 provides '-finline-stringops=memset' [5][6]
with a similar guarantee to the clang builtin, so use it and
__builtin_memset() when available.

If no option is available, provide a simple memset_inline() like the one
from lib/string.c to avoid adding an ugly ifdef.

Link: https://github.com/llvm/llvm-project/commit/90cebef1411617fc3eedd359bdf00cb44b1c2439 [1]
Link: https://gcc.gnu.org/onlinedocs/gcc-16.2.0/gcc/Standards.html#index-ffreestanding [2]
Link: https://github.com/llvm/llvm-project/commit/38637ee477541370a90b37f149069d8e5c0c2efd [3]
Link: https://clang.llvm.org/docs/LanguageExtensions.html#guaranteed-inlined-memset [4]
Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=1ff6d9f7428b0668cd8ab0b3e3ab94f1d733124d [5]
Link: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-finline-stringops [6]
Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Switch approach entirely (Jason, Nick)
  - clang: use __builtin_memset_inline() to avoid external call
  - GCC 14+: use __builtin_memset + -finline-stringops=memset (hence the
    massive CC list increase)
  - GCC < 14: no issues currently but avoid ifdef with simple memset
    implementation
- Link to v1: https://patch.msgid.link/20260916-vdso-getrandom-avoid-memset-llvm-24-v1-1-80a92f2e225a@kernel.org
---
 arch/arm64/kernel/vdso/Makefile     |  2 +-
 arch/loongarch/vdso/Makefile        |  1 +
 arch/powerpc/kernel/vdso/Makefile   |  1 +
 arch/riscv/kernel/vdso/Makefile     |  1 +
 arch/s390/kernel/vdso/Makefile      |  1 +
 arch/x86/entry/vdso/vdso64/Makefile |  2 +-
 init/Kconfig                        |  7 +++++++
 lib/vdso/getrandom.c                | 19 +++++++++++++++++--
 8 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 7dec05dd33b7..f6619e1cb2ce 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -41,7 +41,7 @@ CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
 			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
 			-Wmissing-prototypes -Wmissing-declarations
 
-CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
+CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables $(CONFIG_CC_OPT_INLINE_MEMSET)
 
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
 CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 9c9181bb4071..0b84892d084b 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -16,6 +16,7 @@ ccflags-vdso := \
 	$(filter -m64,$(KBUILD_CFLAGS)) \
 	$(filter -march=%,$(KBUILD_CFLAGS)) \
 	$(filter -m%-float,$(KBUILD_CFLAGS)) \
+	$(CONFIG_CC_OPT_INLINE_MEMSET) \
 	$(CLANG_FLAGS) \
 	-D__VDSO__
 
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 368759f81708..0d1a49529885 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -43,6 +43,7 @@ ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO
 ccflags-y += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 ccflags-y += $(call cc-option, -fno-stack-protector)
 ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += $(CONFIG_CC_OPT_INLINE_MEMSET)
 ccflags-y += -ffreestanding -fasynchronous-unwind-tables
 ccflags-remove-y := $(CC_FLAGS_FTRACE)
 ldflags-y := -Wl,--hash-style=both -nostdlib -shared -z noexecstack $(CLANG_FLAGS)
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 8dbf2532a573..c023046a3fd7 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -36,6 +36,7 @@ endif
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 ccflags-y += -fno-builtin
+ccflags-y += $(CONFIG_CC_OPT_INLINE_MEMSET)
 ccflags-y += $(KBUILD_BASE_ISA)$(CFI_MARCH)
 ccflags-y += $(CFI_FULL)
 asflags-y += $(KBUILD_BASE_ISA)$(CFI_MARCH)
diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makefile
index 35c834b895ec..54bcf2984ca1 100644
--- a/arch/s390/kernel/vdso/Makefile
+++ b/arch/s390/kernel/vdso/Makefile
@@ -29,6 +29,7 @@ KBUILD_CFLAGS_VDSO := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_VDSO))
 KBUILD_CFLAGS_VDSO := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_VDSO))
 KBUILD_CFLAGS_VDSO += -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
 KBUILD_CFLAGS_VDSO += -fno-stack-protector $(DISABLE_KSTACK_ERASE)
+KBUILD_CFLAGS_VDSO += $(CONFIG_CC_OPT_INLINE_MEMSET)
 ldflags-y := -shared -soname=linux-vdso.so.1 \
 	     --hash-style=both --build-id=sha1 \
 	     $(call ld-option, --eh-frame-hdr) -T
diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/vdso64/Makefile
index 7c0790065b5e..c2353a065279 100644
--- a/arch/x86/entry/vdso/vdso64/Makefile
+++ b/arch/x86/entry/vdso/vdso64/Makefile
@@ -14,7 +14,7 @@ vobjs-$(CONFIG_X86_SGX)			+= vsgx.o
 vobjs-$(CONFIG_FUTEX_ROBUST_UNLOCK)	+= vfutex.o
 
 # Compilation flags
-flags-y				:= -DBUILD_VDSO64 -m64 -mcmodel=small
+flags-y				:= -DBUILD_VDSO64 -m64 -mcmodel=small $(CONFIG_CC_OPT_INLINE_MEMSET)
 
 # The location of this include matters!
 include $(src)/../common/Makefile.include
diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c52..ff3f8475dd2f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -173,6 +173,13 @@ config CC_HAS_ALLOC_TOKEN
 config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
 
+config CC_HAS_OPT_INLINE_MEMSET
+	def_bool $(cc-option,-finline-stringops=memset)
+
+config CC_OPT_INLINE_MEMSET
+	string
+	default "-finline-stringops=memset" if CC_HAS_OPT_INLINE_MEMSET
+
 config LD_CAN_USE_KEEP_IN_OVERLAY
 	# ld.lld prior to 21.0.0 did not support KEEP within an overlay description
 	# https://github.com/llvm/llvm-project/pull/130661
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 2851afa9154f..f5cad5641985 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -29,6 +29,22 @@
 	}									\
 } while (0)
 
+#if __has_builtin(__builtin_memset_inline)
+#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
+#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
+#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
+#else
+static inline void *memset_inline(void *dst, int value, size_t size)
+{
+	char *d = dst;
+
+	while (size--)
+		*d++ = value;
+
+	return d;
+}
+#endif
+
 static void memcpy_and_zero_src(void *dst, void *src, size_t len)
 {
 	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
@@ -83,8 +99,7 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 		params->size_of_opaque_state = sizeof(*state);
 		params->mmap_prot = PROT_READ | PROT_WRITE;
 		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
-		for (size_t i = 0; i < ARRAY_SIZE(params->reserved); ++i)
-			params->reserved[i] = 0;
+		memset_inline(params->reserved, 0, sizeof(params->reserved));
 		return 0;
 	}
 

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260916-vdso-getrandom-avoid-memset-llvm-24-74d45fa6031e

Best regards,
--  
Cheers,
Nathan


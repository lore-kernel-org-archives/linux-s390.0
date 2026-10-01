Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64E3CBE6E;
	Thu,  1 Oct 2026 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850070; cv=none; b=DnFc7mHTvMf6AknRqTmvs3dSts4Ap2B75Tw1xkN8bRpP+u4t4atiby+MDaBN/TONDqKVVyHvjrAdk9cWEWkXxXrUS5/C5oTjuzPoHNmtKlWdCu6RtH0YGboMhJaKvoK6+x/ICtSI4o7buVPBQFqyBltBjHw0/WJmpZPzLdRY/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850070; c=relaxed/simple;
	bh=K+D5HzOOw2YhoSzRO9tZqkH7/wgeF2+vlFSBovWaLvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF2lnRL3vseyFp+UjbZpHR188TRBLxbTQKrBGgythA2+OEd4xpJ6M/zFuUnRRK3/yqGtU65Rh+synXxomba7TWV20gfL02RZ4LabNRDqPyp57UcZcGx9av62/+DYoMDTduuDW4wVnqj3y7NZ45j0wBYTPCKmHuZzYfFZSBLAm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef/WVD5V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef/WVD5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA3D1F000FF;
	Thu,  1 Oct 2026 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790850069;
	bh=feMna+qdEPtnp8EkIUrCw+ISbx/ENY0YCIQ2BzjjZgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ef/WVD5V5FLSfjP0aPt2vTcQCgBycsH1fGDxVj0zqLYEMo56HuAugy4F7OXA1KAzn
	 Ngu9N4pO+SM+wz9Hlc5A8O4MJHjhppK3lcGZWU4ZX6UEDhXBT4BmkiebfebiOFmEYx
	 1ndtaCP6h4jaEC/aRDHJhiH6ZHOpnX76b/ullqnOCzDCEwHs2iT6GgUccGM8tpsepX
	 U7OcGDKmoaI+mj9yl/B2gba/Usb2JXb+rPMQEsy9issnW2WJiHUWhorNKgfql0HiPA
	 cb17rzDBoviEFtKfmKPdTDSp46kziRdc/CrASS04RlOpexlN4ZLTvT+Sj2k/7axGKv
	 fuG0s7AX5WLiQ==
Date: Thu, 1 Oct 2026 12:20:59 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20261001102059.GA4176271@ax162>
References: <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
 <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar4nD8aRH7wEvTMt@zx2c4.com>

On Thu, Oct 01, 2026 at 11:25:35AM +0200, Jason A. Donenfeld wrote:
> Darn. Yea. The naive memset kills optimizations.
> 
> Okay, new strategy:
> 
> - on clang, pass `-mllvm -max-store-memset=4294967295`
> - on gcc, pass `-finline-stringops=memset`
> 
> And keep the same code. (Or, better, see if those options generate good
> code with b7bad082e113640fc81200ff869e5c2d7a9c29a2 reverted; I would
> prefer that simpler initializer.)

Reverting b7bad082e113640fc81200ff869e5c2d7a9c29a2 would break GCC < 14
though, right (since no '-finline-stringops=memset')?

> Nathan, do these work?

I would really prefer not to use an internal LLVM flag here. While there
are some instances of internal LLVM flags in the kernel tree already,
LLVM generally only provides them for debugging and not end user
control. The change that introduced -max-store-memset only did it to
"allow fine-tuning of the inlining threshold for performance analysis
and optimization". If they decide to remove it for whatever reason,
we're back to square one.

  https://github.com/llvm/llvm-project/commit/b28eeb28bea39148738dc375e8a97072a1907e64

I know something like below would be uglier due to the ifdef but it
would avoid changing anything for GCC while clearing up the issue at
hand for clang in a guaranteed stable and succinct manner.

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 2851afa9154f..f495d2111ee3 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -83,8 +83,12 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 		params->size_of_opaque_state = sizeof(*state);
 		params->mmap_prot = PROT_READ | PROT_WRITE;
 		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
+#if __has_builtin(__builtin_memset_inline)
+		__builtin_memset_inline(params->reserved, 0, sizeof(params->reserved));
+#else
 		for (size_t i = 0; i < ARRAY_SIZE(params->reserved); ++i)
 			params->reserved[i] = 0;
+#endif
 		return 0;
 	}
 
--

If that is not acceptable, something like the following does appear to
work for me.

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
index 8583d9f06c52..98d8d7fa64c5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -173,6 +173,11 @@ config CC_HAS_ALLOC_TOKEN
 config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
 
+config CC_OPT_INLINE_MEMSET
+	string
+	default "-finline-stringops=memset" if $(cc-option,-finline-stringops=memset)
+	default "-mllvm -max-store-memset=4294967295" if $(cc-option,-mllvm -max-store-memset=4294967295)
+
 config LD_CAN_USE_KEEP_IN_OVERLAY
 	# ld.lld prior to 21.0.0 did not support KEEP within an overlay description
 	# https://github.com/llvm/llvm-project/pull/130661
-- 
Cheers,
Nathan

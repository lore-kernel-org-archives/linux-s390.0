Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DA47C0F2;
	Fri,  2 Oct 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936020; cv=none; b=iQcNqSswwVB7xiMsSolw2wVIofb/xXRIQaPvRUEmMfOoy/whROd59Sl7aF66Xhn26XY5nX7M2RaoLYaS5cBYT0VPb8B1TaX3ngt4vWJlZ+RxcesDl6+F8O6OMLfKg8InAutMXvWVbGd4I3IMN2hEqWzxF9qqo7MYPU4DFh5Pm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936020; c=relaxed/simple;
	bh=1/ap9cUtrgNrKPWEI1NuOfT4Z+aTecz5BwAvVBNru/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSoW1l1WR08UXVT2bWvTxPNvPC5sSkbE+8HHBDhf4zjTD5BugByKyKuW+lweQ5LHGVpILOpXdowGK8JXURsLsr6u9uUhrtTGLmVqDXz8avvs2jI++dvQzfIH1EX9kIcbFdrFF6mSO68C8bUy7nZmTIsfhoed8TCHegjTPIsaxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YtBXFh9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YtBXFh9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE5E1F000FF;
	Fri,  2 Oct 2026 10:13:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=YtBXFh9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790936012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOzm6aI90EpK2LXg0mKkr8pixnkrVyev2/1n2mK0D2E=;
	b=YtBXFh9DHcA4h2DpmpNDa4WiBetUEUDqY34cjYXeg5spaRZvTZtgHlC3h9zJDu3n4WoGNL
	eIH3xyvt4QPZt8bElnZ5+/wBUcdC0za4zMqnHaO0omBSBFmvf0W7aqB54s/3WAlVF8ST0G
	/X9dszl5qzotlF9SKwDebP7b/CNvzVE=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 6ecc7897 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 10:13:31 +0000 (UTC)
Date: Fri, 2 Oct 2026 12:13:27 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Nathan Chancellor <nathan@kernel.org>
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
Message-ID: <ar-Dx-deXN93M24v@zx2c4.com>
References: <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
 <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com>
 <20261001102059.GA4176271@ax162>
 <ar46ap4jzLWyP92C@zx2c4.com>
 <20261001110310.GA138012@ax162>
 <20261002094932.GA3435055@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002094932.GA3435055@ax162>

On Fri, Oct 02, 2026 at 11:49:32AM +0200, Nathan Chancellor wrote:
> On Thu, Oct 01, 2026 at 01:03:10PM +0200, Nathan Chancellor wrote:
> > On Thu, Oct 01, 2026 at 12:48:10PM +0200, Jason A. Donenfeld wrote:
> > > Does this commit seem okay with you? I used the diff you sent below and
> > > adjusted the commit message: https://git.zx2c4.com/linux-rng/commit/?id=56ff95ee85715047eb5b5220243778af657778c8
> > 
> > Yeah, that seems fine to me, thanks for taking care of it!
> 
> Can you adjust the LLVM value by one from 4294967295 to 4294967294? ~0U
> is actually a special value, so we hit an assertion in the SystemZ
> backend.
> 
>   https://github.com/llvm/llvm-project/blob/3f48e22a1f321d5d3341bd812803694cea588785/llvm/lib/CodeGen/SelectionDAG/SelectionDAG.cpp#L9547
>   https://github.com/llvm/llvm-project/blob/3f48e22a1f321d5d3341bd812803694cea588785/llvm/lib/Target/SystemZ/SystemZISelLowering.cpp#L1470-L1471
> 
> clang: llvm/lib/Target/SystemZ/SystemZISelLowering.cpp:1471: virtual bool llvm::SystemZTargetLowering::findOptimalMemOpLowering(LLVMContext &, std::vector<EVT> &, unsigned int, const MemOp &, unsigned int, unsigned int, const AttributeList &, EVT *) const: Assertion `Limit != ~0U && "Expected EmitTargetCodeForMemXXX() to handle AlwaysInline cases."' failed.
> PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and dumped files.
> Stack dump:
> 0.      Program arguments: ...
> 1.      <eof> parser at end of file
> 2.      Code generation
> 3.      Running pass 'Function Pass Manager' on module 'arch/s390/kernel/vdso/vgetrandom.c'.
> 4.      Running pass 'SystemZ DAG->DAG Pattern Instruction Selection' on function '@__kernel_getrandom'
> ...

Holy smokes. Sure, fixed:  https://git.zx2c4.com/linux-rng/commit/?id=eb13a1ff271b0d180687eebb30611b0b276d5193


From eb13a1ff271b0d180687eebb30611b0b276d5193 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 25 Sep 2026 22:46:32 +0100
Subject: [PATCH] random: vDSO: avoid call to memset() when zeroing reserved
 parameter

After a recent change in LLVM [1], builds with the random vDSO
implementation, such as PowerPC and RISC-V, fail when checking the vDSO:

  arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not supported
  arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported

memset() is now generated when zeroing params->reserved for some builds
because LLVM has an optimization (now run in more instances) that can
recognize at compile time when it is assigning a static value to a
contiguous area of memory and turn that into a call to memset(). Both
clang and GCC assume memset() is always available [2].

Clang has an internal fiddly hook, -max-store-memset, which we can set
to a high number, to disable generating out of line memset calls [3].
Similarly, GCC has -finline-stringops=memset to do the same [4], should
this issue ever hit future version of GCC. While these options wouldn't
make sense for normal kernel code, it is fine for the extremely limited
and intentionally compact vDSO code.

Link: https://github.com/llvm/llvm-project/commit/90cebef1411617fc3eedd359bdf00cb44b1c2439 [1]
Link: https://gcc.gnu.org/onlinedocs/gcc-16.2.0/gcc/Standards.html#index-ffreestanding [2]
Link: https://github.com/llvm/llvm-project/commit/b28eeb28bea39148738dc375e8a97072a1907e64 [3]
Link: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-finline-stringops [4]
Closes: https://github.com/ClangBuiltLinux/linux/issues/2183
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/arm64/kernel/vdso/Makefile     | 2 +-
 arch/loongarch/vdso/Makefile        | 1 +
 arch/powerpc/kernel/vdso/Makefile   | 1 +
 arch/riscv/kernel/vdso/Makefile     | 1 +
 arch/s390/kernel/vdso/Makefile      | 1 +
 arch/x86/entry/vdso/vdso64/Makefile | 2 +-
 init/Kconfig                        | 5 +++++
 7 files changed, 11 insertions(+), 2 deletions(-)

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
index 8583d9f06c52..ad592fdf29af 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -173,6 +173,11 @@ config CC_HAS_ALLOC_TOKEN
 config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)

+config CC_OPT_INLINE_MEMSET
+	string
+	default "-finline-stringops=memset" if $(cc-option,-finline-stringops=memset)
+	default "-mllvm -max-store-memset=4294967294" if $(cc-option,-mllvm -max-store-memset=4294967294)
+
 config LD_CAN_USE_KEEP_IN_OVERLAY
 	# ld.lld prior to 21.0.0 did not support KEEP within an overlay description
 	# https://github.com/llvm/llvm-project/pull/130661
--
2.55.0

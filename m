Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F767547059;
	Sat, 26 Sep 2026 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790416962; cv=none; b=JOCPXDUtgd70Y/QIwx6PpRhHEK3UoY3oCsk30nem/+H3b3Ytz6vIeHSmbyCKHn9RhioLI1MT408eHDjnW/BMyT1Z7qhXtC0M30hqskI0b5YlrrnOTem0Y3lAc6qg7IoIepIKwaETsrMaqFsI8vQnxqMFsYmvzdtJ5YALAQ9+/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790416962; c=relaxed/simple;
	bh=o9NExWXLQJP2ceRXECNYfIu8itYI4attG2+2+YG/KrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUU/+g3piS2puDu1yUe+holhoWP3BW0k21DG8LC9so82vVLlRmfbIhh2zDhvsH680tOQ5a9mvkvfjqrY4Lx3RhUuCivSOuXKE9W5icgOYpAyK//OwRF85gc3CJ4eIo2WCkwMQK+gUFBDFBqTqPvX6BCsKM7x4oEKjyQDAa4ncoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=OfuqufY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OfuqufY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5C31F000FF;
	Sat, 26 Sep 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=OfuqufY7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790416955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4UQCU/ng7lvOfRadkfffYlo+ZYxoOXVPEaR6txbrSk=;
	b=OfuqufY7Zlzrp2MAniYFVjK13GMq17YgmuZGEkdWoZWzrVashWdc1VY7gG6iw5f1ay+UGR
	OIx/M6Kn9cb9R3rhwYAPHY8tFbYHBh11+x4RCQ49ugzXpzm2kx17CtXFw7mIf9ioCavt+m
	sUgBH7n/oWVrLYceHgWDzsrCpDBOGJA=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id da1c29b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 26 Sep 2026 10:02:35 +0000 (UTC)
Date: Sat, 26 Sep 2026 12:02:26 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
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
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
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
Message-ID: <areYMjNcaqe86ds4@zx2c4.com>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>

On Fri, Sep 25, 2026 at 03:00:46PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 25, 2026 at 2:56 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Sep 25, 2026 at 2:53 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Sep 25, 2026 at 2:46 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > After a recent change in LLVM [1], builds with the random vDSO
> > > > implementation, such as PowerPC and RISC-V, fail when checking the vDSO:
> > > >
> > > >   arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not supported
> > > >   arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
> > > >
> > > > memset() is now generated when zeroing params->reserved for some builds
> > > > because LLVM has an optimization (now run in more instances) that can
> > > > recognize at compile time when it is assigning a static value to a
> > > > contiguous area of memory and turn that into a call to memset(). Both
> > > > clang and GCC assume memset() is always available [2].
> > > >
> > > > clang provides a builtin, __builtin_memset_inline [3][4], that can be
> > > > used to ensure an external function call is not generated when zeroing
> > > > this memory. Use it when it is available.
> > > >
> > > > While GCC has no issues with the current code, it has generated memset()
> > > > before, as seen in commit b7bad082e113 ("random: vDSO: avoid call to out
> > > > of line memset()"). GCC 14 provides '-finline-stringops=memset' [5][6]
> > > > with a similar guarantee to the clang builtin, so use it and
> > > > __builtin_memset() when available.
> > > >
> > > > If no option is available, provide a simple memset_inline() like the one
> > > > from lib/string.c to avoid adding an ugly ifdef.
> > > >
> > > > Link: https://github.com/llvm/llvm-project/commit/90cebef1411617fc3eedd359bdf00cb44b1c2439 [1]
> > > > Link: https://gcc.gnu.org/onlinedocs/gcc-16.2.0/gcc/Standards.html#index-ffreestanding [2]
> > > > Link: https://github.com/llvm/llvm-project/commit/38637ee477541370a90b37f149069d8e5c0c2efd [3]
> > > > Link: https://clang.llvm.org/docs/LanguageExtensions.html#guaranteed-inlined-memset [4]
> > > > Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=1ff6d9f7428b0668cd8ab0b3e3ab94f1d733124d [5]
> > > > Link: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#index-finline-stringops [6]
> > > > Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > > ---
> > > > Changes in v2:
> > > > - Switch approach entirely (Jason, Nick)
> > > >   - clang: use __builtin_memset_inline() to avoid external call
> > > >   - GCC 14+: use __builtin_memset + -finline-stringops=memset (hence the
> > > >     massive CC list increase)
> > > >   - GCC < 14: no issues currently but avoid ifdef with simple memset
> > > >     implementation
> > > > - Link to v1: https://patch.msgid.link/20260916-vdso-getrandom-avoid-memset-llvm-24-v1-1-80a92f2e225a@kernel.org
> > > > ---
> > > >  arch/arm64/kernel/vdso/Makefile     |  2 +-
> > > >  arch/loongarch/vdso/Makefile        |  1 +
> > > >  arch/powerpc/kernel/vdso/Makefile   |  1 +
> > > >  arch/riscv/kernel/vdso/Makefile     |  1 +
> > > >  arch/s390/kernel/vdso/Makefile      |  1 +
> > > >  arch/x86/entry/vdso/vdso64/Makefile |  2 +-
> > > >  init/Kconfig                        |  7 +++++++
> > > >  lib/vdso/getrandom.c                | 19 +++++++++++++++++--
> > > >  8 files changed, 30 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > > > index 7dec05dd33b7..f6619e1cb2ce 100644
> > > > --- a/arch/arm64/kernel/vdso/Makefile
> > > > +++ b/arch/arm64/kernel/vdso/Makefile
> > > > @@ -41,7 +41,7 @@ CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
> > > >                         $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
> > > >                         -Wmissing-prototypes -Wmissing-declarations
> > > >
> > > > -CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
> > > > +CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables $(CONFIG_CC_OPT_INLINE_MEMSET)
> > > >
> > > >  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
> > > >  CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
> > > > diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> > > > index 9c9181bb4071..0b84892d084b 100644
> > > > --- a/arch/loongarch/vdso/Makefile
> > > > +++ b/arch/loongarch/vdso/Makefile
> > > > @@ -16,6 +16,7 @@ ccflags-vdso := \
> > > >         $(filter -m64,$(KBUILD_CFLAGS)) \
> > > >         $(filter -march=%,$(KBUILD_CFLAGS)) \
> > > >         $(filter -m%-float,$(KBUILD_CFLAGS)) \
> > > > +       $(CONFIG_CC_OPT_INLINE_MEMSET) \
> > > >         $(CLANG_FLAGS) \
> > > >         -D__VDSO__
> > > >
> > > > diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
> > > > index 368759f81708..0d1a49529885 100644
> > > > --- a/arch/powerpc/kernel/vdso/Makefile
> > > > +++ b/arch/powerpc/kernel/vdso/Makefile
> > > > @@ -43,6 +43,7 @@ ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO
> > > >  ccflags-y += $(DISABLE_LATENT_ENTROPY_PLUGIN)
> > > >  ccflags-y += $(call cc-option, -fno-stack-protector)
> > > >  ccflags-y += -DDISABLE_BRANCH_PROFILING
> > > > +ccflags-y += $(CONFIG_CC_OPT_INLINE_MEMSET)
> > > >  ccflags-y += -ffreestanding -fasynchronous-unwind-tables
> > > >  ccflags-remove-y := $(CC_FLAGS_FTRACE)
> > > >  ldflags-y := -Wl,--hash-style=both -nostdlib -shared -z noexecstack $(CLANG_FLAGS)
> > > > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> > > > index 8dbf2532a573..c023046a3fd7 100644
> > > > --- a/arch/riscv/kernel/vdso/Makefile
> > > > +++ b/arch/riscv/kernel/vdso/Makefile
> > > > @@ -36,6 +36,7 @@ endif
> > > >  ccflags-y := -fno-stack-protector
> > > >  ccflags-y += -DDISABLE_BRANCH_PROFILING
> > > >  ccflags-y += -fno-builtin
> > > > +ccflags-y += $(CONFIG_CC_OPT_INLINE_MEMSET)
> > > >  ccflags-y += $(KBUILD_BASE_ISA)$(CFI_MARCH)
> > > >  ccflags-y += $(CFI_FULL)
> > > >  asflags-y += $(KBUILD_BASE_ISA)$(CFI_MARCH)
> > > > diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makefile
> > > > index 35c834b895ec..54bcf2984ca1 100644
> > > > --- a/arch/s390/kernel/vdso/Makefile
> > > > +++ b/arch/s390/kernel/vdso/Makefile
> > > > @@ -29,6 +29,7 @@ KBUILD_CFLAGS_VDSO := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_VDSO))
> > > >  KBUILD_CFLAGS_VDSO := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_VDSO))
> > > >  KBUILD_CFLAGS_VDSO += -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
> > > >  KBUILD_CFLAGS_VDSO += -fno-stack-protector $(DISABLE_KSTACK_ERASE)
> > > > +KBUILD_CFLAGS_VDSO += $(CONFIG_CC_OPT_INLINE_MEMSET)
> > > >  ldflags-y := -shared -soname=linux-vdso.so.1 \
> > > >              --hash-style=both --build-id=sha1 \
> > > >              $(call ld-option, --eh-frame-hdr) -T
> > > > diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/vdso64/Makefile
> > > > index 7c0790065b5e..c2353a065279 100644
> > > > --- a/arch/x86/entry/vdso/vdso64/Makefile
> > > > +++ b/arch/x86/entry/vdso/vdso64/Makefile
> > > > @@ -14,7 +14,7 @@ vobjs-$(CONFIG_X86_SGX)                       += vsgx.o
> > > >  vobjs-$(CONFIG_FUTEX_ROBUST_UNLOCK)    += vfutex.o
> > > >
> > > >  # Compilation flags
> > > > -flags-y                                := -DBUILD_VDSO64 -m64 -mcmodel=small
> > > > +flags-y                                := -DBUILD_VDSO64 -m64 -mcmodel=small $(CONFIG_CC_OPT_INLINE_MEMSET)
> > > >
> > > >  # The location of this include matters!
> > > >  include $(src)/../common/Makefile.include
> > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > index 8583d9f06c52..ff3f8475dd2f 100644
> > > > --- a/init/Kconfig
> > > > +++ b/init/Kconfig
> > > > @@ -173,6 +173,13 @@ config CC_HAS_ALLOC_TOKEN
> > > >  config CC_HAS_MULTIDIMENSIONAL_NONSTRING
> > > >         def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
> > > >
> > > > +config CC_HAS_OPT_INLINE_MEMSET
> > > > +       def_bool $(cc-option,-finline-stringops=memset)
> > > > +
> > > > +config CC_OPT_INLINE_MEMSET
> > > > +       string
> > > > +       default "-finline-stringops=memset" if CC_HAS_OPT_INLINE_MEMSET
> > > > +
> > > >  config LD_CAN_USE_KEEP_IN_OVERLAY
> > > >         # ld.lld prior to 21.0.0 did not support KEEP within an overlay description
> > > >         # https://github.com/llvm/llvm-project/pull/130661
> > > > diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> > > > index 2851afa9154f..f5cad5641985 100644
> > > > --- a/lib/vdso/getrandom.c
> > > > +++ b/lib/vdso/getrandom.c
> > > > @@ -29,6 +29,22 @@
> > > >         }                                                                       \
> > > >  } while (0)
> > > >
> > > > +#if __has_builtin(__builtin_memset_inline)
> > > > +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
> > > > +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> > > > +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
> > > > +#else
> > > > +static inline void *memset_inline(void *dst, int value, size_t size)
> > > > +{
> > > > +       char *d = dst;
> > > > +
> > > > +       while (size--)
> > > > +               *d++ = value;
> > > > +
> > > > +       return d;
> > > > +}
> > > > +#endif
> > >
> > > Does this work?
> > > https://godbolt.org/z/Tx6EaGMfb
> >
> > Hmmm...possibly.
> > https://godbolt.org/z/ec9rzd9Yf
> > I don't get it...
> 
> Just keep it under 2 pages, it will be fine:
> https://godbolt.org/z/qqoMqfxev

https://godbolt.org/z/9W9f5a7Wx

Apparently not on RISCV, which is what prompted this patch in the first
place. So I suspect Nathan's v2 here is the way to go.

Jason

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403E34E74D;
	Sat, 26 Sep 2026 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790420151; cv=none; b=iiFs8KyoRX7NuGgOXK4wHU+4IuQi7nL7VP7wu0m678Q2J7W6Bu157xaORJX/69E0x/+Ckd80EIc5riBaFQ1VZF+mp+VhH0IJk0oea1Oloc3DYnliHn7m0ANkubU7frMNHazomtxpb+lfWH2JfKk5QqMb75IuWMwcdBdTv3Qgwz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790420151; c=relaxed/simple;
	bh=yNDUdvk15wiQndcnyxC8neLqoZ2aSDfTLymCaeg9aI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShcG1Betpp2dE65IU/QbriFwpiam/Q92yoX6B7Uz/BfuUqIQM7gKEsfDgpsJjv5SMY11a8d0BvGWpF/VxVLiHf3YHYDdc4+5sox7WP8ZGxAipEHY8E6SdJTE+DSOvD57Ww6KA8FrQOIRqtL0SksDVHH7WuDgMowqsQMMJhfC72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHBSTyxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHBSTyxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF751F000FF;
	Sat, 26 Sep 2026 10:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790420149;
	bh=M3v70KpW/UEgjbC3QoaHE8/Wwn5JI4Q7Nay7Ujw/kRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IHBSTyxMLUw3GVcRSy3mO/ECQ4hJ1yBZZ2Fg+yVS1RarSpt8dFI4iFDIo95Lwa9PP
	 cfvHzKodI/lFDD0B3BiP+pmPS6/+dMiXZ2aYTlQwawo1uA30hTSbG1OzGWKCm4ceR/
	 1izip1d0LM1TP3PdLeyH/9HabEnFS8hE2+FPHy1cSMnD8uz2cVae8sQwCx9X7neF2a
	 h/mYvHClf0b2Gc5QDjffkFvIyKKai+xRudGhuP9ff+JJWIqFsSYpef0O2k7Z5UotR5
	 45FLjP0GWzu1GyLnWI1k8axuM4LPHOIjh+CUhWiw4yNmf82WYJU9QnBsbdZoxRdUfP
	 6jdo8KZfLDGTQ==
Message-ID: <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
Date: Sat, 26 Sep 2026 12:55:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
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
 llvm@lists.linux.dev
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <areYMjNcaqe86ds4@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jason,

Le 26/09/2026 à 12:02, Jason A. Donenfeld a écrit :
> On Fri, Sep 25, 2026 at 03:00:46PM -0700, Nick Desaulniers wrote:
>> On Fri, Sep 25, 2026 at 2:56 PM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>>>
>>> On Fri, Sep 25, 2026 at 2:53 PM Nick Desaulniers
>>> <ndesaulniers@google.com> wrote:
>>>>
>>>> On Fri, Sep 25, 2026 at 2:46 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>>>>
>>>>> After a recent change in LLVM [1], builds with the random vDSO
>>>>> implementation, such as PowerPC and RISC-V, fail when checking the vDSO:
>>>>>
>>>>>    arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not supported
>>>>>    arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
>>>>>
>>>>> memset() is now generated when zeroing params->reserved for some builds
>>>>> because LLVM has an optimization (now run in more instances) that can
>>>>> recognize at compile time when it is assigning a static value to a
>>>>> contiguous area of memory and turn that into a call to memset(). Both
>>>>> clang and GCC assume memset() is always available [2].
>>>>>
>>>>> clang provides a builtin, __builtin_memset_inline [3][4], that can be
>>>>> used to ensure an external function call is not generated when zeroing
>>>>> this memory. Use it when it is available.
>>>>>
>>>>> While GCC has no issues with the current code, it has generated memset()
>>>>> before, as seen in commit b7bad082e113 ("random: vDSO: avoid call to out
>>>>> of line memset()"). GCC 14 provides '-finline-stringops=memset' [5][6]
>>>>> with a similar guarantee to the clang builtin, so use it and
>>>>> __builtin_memset() when available.
>>>>>
>>>>> If no option is available, provide a simple memset_inline() like the one
>>>>> from lib/string.c to avoid adding an ugly ifdef.
>>>>>
>>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project%2Fcommit%2F90cebef1411617fc3eedd359bdf00cb44b1c2439&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659627802%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ku4l8Ol5OJ2qi%2BcSblspxxUKOA6rNpiUO3ZvGSoAb1s%3D&reserved=0 [1]
>>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fonlinedocs%2Fgcc-16.2.0%2Fgcc%2FStandards.html%23index-ffreestanding&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659651194%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=jQa1eTDLk3cPNTa3GEBwVEohHh67ukShaRHMZvA%2FHDg%3D&reserved=0 [2]
>>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project%2Fcommit%2F38637ee477541370a90b37f149069d8e5c0c2efd&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659668579%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=zY7Kr9ZZNNZR%2FVsnwYRlubPRpbMaKe9QtMD2snd8ZvA%3D&reserved=0 [3]
>>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fclang.llvm.org%2Fdocs%2FLanguageExtensions.html%23guaranteed-inlined-memset&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659678360%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=vUU2fhCVcUWsbQD3IsRaUzSO8KVSpxwSpgr9San4aq0%3D&reserved=0 [4]
>>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fgit%2F%3Fp%3Dgcc.git%3Ba%3Dcommit%3Bh%3D1ff6d9f7428b0668cd8ab0b3e3ab94f1d733124d&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659687815%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=qHRqxAO252imwH1W93yHlp6jdcFGkFOr2Y2hXbG2MLU%3D&reserved=0 [5]
>>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fonlinedocs%2Fgcc%2FOptimize-Options.html%23index-finline-stringops&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659698298%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=0ecc%2BXd6o3nozh3N71aq%2F98Xam%2Fdol7GUHmC637Iv7I%3D&reserved=0 [6]
>>>>> Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
>>>>> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>>>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Switch approach entirely (Jason, Nick)
>>>>>    - clang: use __builtin_memset_inline() to avoid external call
>>>>>    - GCC 14+: use __builtin_memset + -finline-stringops=memset (hence the
>>>>>      massive CC list increase)
>>>>>    - GCC < 14: no issues currently but avoid ifdef with simple memset
>>>>>      implementation
>>>>> - Link to v1: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch.msgid.link%2F20260916-vdso-getrandom-avoid-memset-llvm-24-v1-1-80a92f2e225a%40kernel.org&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659712983%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2Ftq3tUHqDmbXesqB69w6umXAuaTsfzOIhk54Jy76cwo%3D&reserved=0
>>>>> ---
>>>>>   arch/arm64/kernel/vdso/Makefile     |  2 +-
>>>>>   arch/loongarch/vdso/Makefile        |  1 +
>>>>>   arch/powerpc/kernel/vdso/Makefile   |  1 +
>>>>>   arch/riscv/kernel/vdso/Makefile     |  1 +
>>>>>   arch/s390/kernel/vdso/Makefile      |  1 +
>>>>>   arch/x86/entry/vdso/vdso64/Makefile |  2 +-
>>>>>   init/Kconfig                        |  7 +++++++
>>>>>   lib/vdso/getrandom.c                | 19 +++++++++++++++++--
>>>>>   8 files changed, 30 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
>>>>> index 7dec05dd33b7..f6619e1cb2ce 100644
>>>>> --- a/arch/arm64/kernel/vdso/Makefile
>>>>> +++ b/arch/arm64/kernel/vdso/Makefile
>>>>> @@ -41,7 +41,7 @@ CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
>>>>>                          $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>>>>>                          -Wmissing-prototypes -Wmissing-declarations
>>>>>
>>>>> -CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
>>>>> +CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables $(CONFIG_CC_OPT_INLINE_MEMSET)
>>>>>
>>>>>   CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
>>>>>   CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
>>>>> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
>>>>> index 9c9181bb4071..0b84892d084b 100644
>>>>> --- a/arch/loongarch/vdso/Makefile
>>>>> +++ b/arch/loongarch/vdso/Makefile
>>>>> @@ -16,6 +16,7 @@ ccflags-vdso := \
>>>>>          $(filter -m64,$(KBUILD_CFLAGS)) \
>>>>>          $(filter -march=%,$(KBUILD_CFLAGS)) \
>>>>>          $(filter -m%-float,$(KBUILD_CFLAGS)) \
>>>>> +       $(CONFIG_CC_OPT_INLINE_MEMSET) \
>>>>>          $(CLANG_FLAGS) \
>>>>>          -D__VDSO__
>>>>>
>>>>> diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
>>>>> index 368759f81708..0d1a49529885 100644
>>>>> --- a/arch/powerpc/kernel/vdso/Makefile
>>>>> +++ b/arch/powerpc/kernel/vdso/Makefile
>>>>> @@ -43,6 +43,7 @@ ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO
>>>>>   ccflags-y += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>>>>>   ccflags-y += $(call cc-option, -fno-stack-protector)
>>>>>   ccflags-y += -DDISABLE_BRANCH_PROFILING
>>>>> +ccflags-y += $(CONFIG_CC_OPT_INLINE_MEMSET)
>>>>>   ccflags-y += -ffreestanding -fasynchronous-unwind-tables
>>>>>   ccflags-remove-y := $(CC_FLAGS_FTRACE)
>>>>>   ldflags-y := -Wl,--hash-style=both -nostdlib -shared -z noexecstack $(CLANG_FLAGS)
>>>>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>>>>> index 8dbf2532a573..c023046a3fd7 100644
>>>>> --- a/arch/riscv/kernel/vdso/Makefile
>>>>> +++ b/arch/riscv/kernel/vdso/Makefile
>>>>> @@ -36,6 +36,7 @@ endif
>>>>>   ccflags-y := -fno-stack-protector
>>>>>   ccflags-y += -DDISABLE_BRANCH_PROFILING
>>>>>   ccflags-y += -fno-builtin
>>>>> +ccflags-y += $(CONFIG_CC_OPT_INLINE_MEMSET)
>>>>>   ccflags-y += $(KBUILD_BASE_ISA)$(CFI_MARCH)
>>>>>   ccflags-y += $(CFI_FULL)
>>>>>   asflags-y += $(KBUILD_BASE_ISA)$(CFI_MARCH)
>>>>> diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makefile
>>>>> index 35c834b895ec..54bcf2984ca1 100644
>>>>> --- a/arch/s390/kernel/vdso/Makefile
>>>>> +++ b/arch/s390/kernel/vdso/Makefile
>>>>> @@ -29,6 +29,7 @@ KBUILD_CFLAGS_VDSO := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_VDSO))
>>>>>   KBUILD_CFLAGS_VDSO := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_VDSO))
>>>>>   KBUILD_CFLAGS_VDSO += -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
>>>>>   KBUILD_CFLAGS_VDSO += -fno-stack-protector $(DISABLE_KSTACK_ERASE)
>>>>> +KBUILD_CFLAGS_VDSO += $(CONFIG_CC_OPT_INLINE_MEMSET)
>>>>>   ldflags-y := -shared -soname=linux-vdso.so.1 \
>>>>>               --hash-style=both --build-id=sha1 \
>>>>>               $(call ld-option, --eh-frame-hdr) -T
>>>>> diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/vdso64/Makefile
>>>>> index 7c0790065b5e..c2353a065279 100644
>>>>> --- a/arch/x86/entry/vdso/vdso64/Makefile
>>>>> +++ b/arch/x86/entry/vdso/vdso64/Makefile
>>>>> @@ -14,7 +14,7 @@ vobjs-$(CONFIG_X86_SGX)                       += vsgx.o
>>>>>   vobjs-$(CONFIG_FUTEX_ROBUST_UNLOCK)    += vfutex.o
>>>>>
>>>>>   # Compilation flags
>>>>> -flags-y                                := -DBUILD_VDSO64 -m64 -mcmodel=small
>>>>> +flags-y                                := -DBUILD_VDSO64 -m64 -mcmodel=small $(CONFIG_CC_OPT_INLINE_MEMSET)
>>>>>
>>>>>   # The location of this include matters!
>>>>>   include $(src)/../common/Makefile.include
>>>>> diff --git a/init/Kconfig b/init/Kconfig
>>>>> index 8583d9f06c52..ff3f8475dd2f 100644
>>>>> --- a/init/Kconfig
>>>>> +++ b/init/Kconfig
>>>>> @@ -173,6 +173,13 @@ config CC_HAS_ALLOC_TOKEN
>>>>>   config CC_HAS_MULTIDIMENSIONAL_NONSTRING
>>>>>          def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
>>>>>
>>>>> +config CC_HAS_OPT_INLINE_MEMSET
>>>>> +       def_bool $(cc-option,-finline-stringops=memset)
>>>>> +
>>>>> +config CC_OPT_INLINE_MEMSET
>>>>> +       string
>>>>> +       default "-finline-stringops=memset" if CC_HAS_OPT_INLINE_MEMSET
>>>>> +
>>>>>   config LD_CAN_USE_KEEP_IN_OVERLAY
>>>>>          # ld.lld prior to 21.0.0 did not support KEEP within an overlay description
>>>>>          # https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project%2Fpull%2F130661&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659727352%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=03eAQvPTDs%2FN28bYiiZAVYcx2JFSkuOM7x2iwFU%2F%2FxA%3D&reserved=0
>>>>> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
>>>>> index 2851afa9154f..f5cad5641985 100644
>>>>> --- a/lib/vdso/getrandom.c
>>>>> +++ b/lib/vdso/getrandom.c
>>>>> @@ -29,6 +29,22 @@
>>>>>          }                                                                       \
>>>>>   } while (0)
>>>>>
>>>>> +#if __has_builtin(__builtin_memset_inline)
>>>>> +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
>>>>> +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
>>>>> +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
>>>>> +#else
>>>>> +static inline void *memset_inline(void *dst, int value, size_t size)
>>>>> +{
>>>>> +       char *d = dst;
>>>>> +
>>>>> +       while (size--)
>>>>> +               *d++ = value;
>>>>> +
>>>>> +       return d;
>>>>> +}
>>>>> +#endif
>>>>
>>>> Does this work?
>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgodbolt.org%2Fz%2FTx6EaGMfb&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659741160%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Xv0rle85Js5BH2qNUL4q2Iv2ZwgJhJ4FaTuHYAvvEVo%3D&reserved=0
>>>
>>> Hmmm...possibly.
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgodbolt.org%2Fz%2Fec9rzd9Yf&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659754022%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=bLajY6c3CbYOZMJlBA4bYlVE3bNVc%2Fxe1KYk0rUJgjM%3D&reserved=0
>>> I don't get it...
>>
>> Just keep it under 2 pages, it will be fine:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgodbolt.org%2Fz%2FqqoMqfxev&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659763804%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Bcp1%2B%2Fir05tsPwf08OQkJx4vDkPliaSppam1e%2BTPprk%3D&reserved=0
> 
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgodbolt.org%2Fz%2F9W9f5a7Wx&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4df96063ffd94e6204df08df1bb54e3d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639260137659773169%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=YPGYXcKrnM4e1Q2nHdshRUaMT36w%2BRkHuIWIgcbpA94%3D&reserved=0
> 
> Apparently not on RISCV, which is what prompted this patch in the first
> place. So I suspect Nathan's v2 here is the way to go.


Don't you have -fno-builtin on RISCV like we have on powerpc ?

Or is it clang that is missing this option ?

Christophe

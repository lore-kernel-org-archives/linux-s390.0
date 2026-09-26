Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55D38D01B;
	Sat, 26 Sep 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404461; cv=none; b=Vp+NkSBYqM0b7U+fFfeDmNRA5iVfZY9qJjaElVoLSkJgv17P55e0e9T54urIEcMfj1hYB74Emjcw/SMFdVAILtQxkQ83ED3QY+Sc1RZPM//OIWuzb6LovOzrNtU0foMUkkJYHT+q2V8wTq82NgZObFa5oFtuUuMTU9Tll+VULVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404461; c=relaxed/simple;
	bh=EM8Aq0zba55JAF1PiqJZKwXUK24rdLNa8m9H7uIa2tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrnJHnCJ9x0qrsChV7c7MnUgi4wrbh6l9bnwTYR3xrGlfZ+3R9C66eT+uyqAf1e5icrKTbKmIl0qSxv3ciFyDKBQa17ATnkOpp78kAi+qkFXjzc46pqAZs74+EgK8YjYNZGjL0W8AYsjQUJoNWctLrpHrQGEaAlBUNBgQTplD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3keQOxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3keQOxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00571F000FF;
	Sat, 26 Sep 2026 06:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404459;
	bh=PGoBOYGQFMmgkg0THkTOdUI30C4ST2Titdv6ASdq6z8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=X3keQOxp1tBtuWVBA/GBtSTLiUQRxOBSNxRdAlOlbGfr7T3RKDQAP1hU9UbGqlC/w
	 3PJ85mcmhlsLwmq6yVlRoD28izVuDgabWq/+5UM7kpOBE3Pk4Go9B9ehwO9gn0Bhev
	 iTAl61Ikfsa33CGlRO1QkLudvPEperBl2X1NsI2lSzQMy65KohW5DWudmwPtA2CcV2
	 T66a7nZlZZzbltX3v1DTuvDm+99chPB2HuXc5lYYlWIkTQ+0UMV3AL4FjdI7+rMVN7
	 OF4JtgtAHZvxID7lezJ9eYLLkQQUepVcO0JWZGTfrVT0/Q7Lnt+hslscKk5CoLHGie
	 QdYcU5p96v9XQ==
Message-ID: <76f4039a-d591-4b6a-af7e-83eb90266719@kernel.org>
Date: Sat, 26 Sep 2026 08:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/09/2026 à 00:00, Nick Desaulniers a écrit :
> On Fri, Sep 25, 2026 at 2:56 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Fri, Sep 25, 2026 at 2:53 PM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>>>
>>> On Fri, Sep 25, 2026 at 2:46 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>>>
>>>> After a recent change in LLVM [1], builds with the random vDSO
>>>> implementation, such as PowerPC and RISC-V, fail when checking the vDSO:
>>>>
>>>>    arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not supported
>>>>    arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
>>>>
>>>> memset() is now generated when zeroing params->reserved for some builds
>>>> because LLVM has an optimization (now run in more instances) that can
>>>> recognize at compile time when it is assigning a static value to a
>>>> contiguous area of memory and turn that into a call to memset(). Both
>>>> clang and GCC assume memset() is always available [2].
>>>>
>>>> clang provides a builtin, __builtin_memset_inline [3][4], that can be
>>>> used to ensure an external function call is not generated when zeroing
>>>> this memory. Use it when it is available.
>>>>
>>>> While GCC has no issues with the current code, it has generated memset()
>>>> before, as seen in commit b7bad082e113 ("random: vDSO: avoid call to out
>>>> of line memset()"). GCC 14 provides '-finline-stringops=memset' [5][6]
>>>> with a similar guarantee to the clang builtin, so use it and
>>>> __builtin_memset() when available.
>>>>
>>>> If no option is available, provide a simple memset_inline() like the one
>>>> from lib/string.c to avoid adding an ugly ifdef.
>>>>
>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project%2Fcommit%2F90cebef1411617fc3eedd359bdf00cb44b1c2439&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683663121%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=TzFmsIf6K0ZNffmwZjFRWcrFHJ4akhMw%2FxcWeHR4hFY%3D&reserved=0 [1]
>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fonlinedocs%2Fgcc-16.2.0%2Fgcc%2FStandards.html%23index-ffreestanding&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683681786%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=A6PdZfaF0MvKQ0TEuJEnFWmXpMKD5CPz6Ko2fWh9ZGY%3D&reserved=0 [2]
>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project%2Fcommit%2F38637ee477541370a90b37f149069d8e5c0c2efd&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683693796%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ordMFwd99jKGsM6%2F5jqb6T%2FCzJZ%2BccJTNL6Zyyz38S4%3D&reserved=0 [3]
>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fclang.llvm.org%2Fdocs%2FLanguageExtensions.html%23guaranteed-inlined-memset&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683704121%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=mqgeAxJp0cTsBD1qngk%2BliTUC1kID648Z81H6hiKYDI%3D&reserved=0 [4]
>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fgit%2F%3Fp%3Dgcc.git%3Ba%3Dcommit%3Bh%3D1ff6d9f7428b0668cd8ab0b3e3ab94f1d733124d&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683713563%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=hNiJSMBbn6k7Pq4uBYQ5Bi6fO8ttW8KXVK6hPLEfJCM%3D&reserved=0 [5]
>>>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fonlinedocs%2Fgcc%2FOptimize-Options.html%23index-finline-stringops&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683722844%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=BwB1lUSynGcGGLwkspnlVbkBAkdeRo4ItXk19ffMU44%3D&reserved=0 [6]
>>>> Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
>>>> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>>> ---
>>>> Changes in v2:
>>>> - Switch approach entirely (Jason, Nick)
>>>>    - clang: use __builtin_memset_inline() to avoid external call
>>>>    - GCC 14+: use __builtin_memset + -finline-stringops=memset (hence the
>>>>      massive CC list increase)
>>>>    - GCC < 14: no issues currently but avoid ifdef with simple memset
>>>>      implementation
>>>> - Link to v1: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch.msgid.link%2F20260916-vdso-getrandom-avoid-memset-llvm-24-v1-1-80a92f2e225a%40kernel.org&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683731836%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Z1w8wFKZCVjlUIwkIjffeIBIPkDhRRln3l7xot3daRc%3D&reserved=0
>>>> ---
>>>>   arch/arm64/kernel/vdso/Makefile     |  2 +-
>>>>   arch/loongarch/vdso/Makefile        |  1 +
>>>>   arch/powerpc/kernel/vdso/Makefile   |  1 +
>>>>   arch/riscv/kernel/vdso/Makefile     |  1 +
>>>>   arch/s390/kernel/vdso/Makefile      |  1 +
>>>>   arch/x86/entry/vdso/vdso64/Makefile |  2 +-
>>>>   init/Kconfig                        |  7 +++++++
>>>>   lib/vdso/getrandom.c                | 19 +++++++++++++++++--
>>>>   8 files changed, 30 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
>>>> index 7dec05dd33b7..f6619e1cb2ce 100644
>>>> --- a/arch/arm64/kernel/vdso/Makefile
>>>> +++ b/arch/arm64/kernel/vdso/Makefile
>>>> @@ -41,7 +41,7 @@ CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
>>>>                          $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>>>>                          -Wmissing-prototypes -Wmissing-declarations
>>>>
>>>> -CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
>>>> +CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables $(CONFIG_CC_OPT_INLINE_MEMSET)
>>>>
>>>>   CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_REMOVE_VDSO)
>>>>   CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_REMOVE_VDSO)
>>>> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
>>>> index 9c9181bb4071..0b84892d084b 100644
>>>> --- a/arch/loongarch/vdso/Makefile
>>>> +++ b/arch/loongarch/vdso/Makefile
>>>> @@ -16,6 +16,7 @@ ccflags-vdso := \
>>>>          $(filter -m64,$(KBUILD_CFLAGS)) \
>>>>          $(filter -march=%,$(KBUILD_CFLAGS)) \
>>>>          $(filter -m%-float,$(KBUILD_CFLAGS)) \
>>>> +       $(CONFIG_CC_OPT_INLINE_MEMSET) \
>>>>          $(CLANG_FLAGS) \
>>>>          -D__VDSO__
>>>>
>>>> diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
>>>> index 368759f81708..0d1a49529885 100644
>>>> --- a/arch/powerpc/kernel/vdso/Makefile
>>>> +++ b/arch/powerpc/kernel/vdso/Makefile
>>>> @@ -43,6 +43,7 @@ ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO
>>>>   ccflags-y += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>>>>   ccflags-y += $(call cc-option, -fno-stack-protector)
>>>>   ccflags-y += -DDISABLE_BRANCH_PROFILING
>>>> +ccflags-y += $(CONFIG_CC_OPT_INLINE_MEMSET)
>>>>   ccflags-y += -ffreestanding -fasynchronous-unwind-tables
>>>>   ccflags-remove-y := $(CC_FLAGS_FTRACE)
>>>>   ldflags-y := -Wl,--hash-style=both -nostdlib -shared -z noexecstack $(CLANG_FLAGS)
>>>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>>>> index 8dbf2532a573..c023046a3fd7 100644
>>>> --- a/arch/riscv/kernel/vdso/Makefile
>>>> +++ b/arch/riscv/kernel/vdso/Makefile
>>>> @@ -36,6 +36,7 @@ endif
>>>>   ccflags-y := -fno-stack-protector
>>>>   ccflags-y += -DDISABLE_BRANCH_PROFILING
>>>>   ccflags-y += -fno-builtin
>>>> +ccflags-y += $(CONFIG_CC_OPT_INLINE_MEMSET)
>>>>   ccflags-y += $(KBUILD_BASE_ISA)$(CFI_MARCH)
>>>>   ccflags-y += $(CFI_FULL)
>>>>   asflags-y += $(KBUILD_BASE_ISA)$(CFI_MARCH)
>>>> diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makefile
>>>> index 35c834b895ec..54bcf2984ca1 100644
>>>> --- a/arch/s390/kernel/vdso/Makefile
>>>> +++ b/arch/s390/kernel/vdso/Makefile
>>>> @@ -29,6 +29,7 @@ KBUILD_CFLAGS_VDSO := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_VDSO))
>>>>   KBUILD_CFLAGS_VDSO := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_VDSO))
>>>>   KBUILD_CFLAGS_VDSO += -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
>>>>   KBUILD_CFLAGS_VDSO += -fno-stack-protector $(DISABLE_KSTACK_ERASE)
>>>> +KBUILD_CFLAGS_VDSO += $(CONFIG_CC_OPT_INLINE_MEMSET)
>>>>   ldflags-y := -shared -soname=linux-vdso.so.1 \
>>>>               --hash-style=both --build-id=sha1 \
>>>>               $(call ld-option, --eh-frame-hdr) -T
>>>> diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/vdso64/Makefile
>>>> index 7c0790065b5e..c2353a065279 100644
>>>> --- a/arch/x86/entry/vdso/vdso64/Makefile
>>>> +++ b/arch/x86/entry/vdso/vdso64/Makefile
>>>> @@ -14,7 +14,7 @@ vobjs-$(CONFIG_X86_SGX)                       += vsgx.o
>>>>   vobjs-$(CONFIG_FUTEX_ROBUST_UNLOCK)    += vfutex.o
>>>>
>>>>   # Compilation flags
>>>> -flags-y                                := -DBUILD_VDSO64 -m64 -mcmodel=small
>>>> +flags-y                                := -DBUILD_VDSO64 -m64 -mcmodel=small $(CONFIG_CC_OPT_INLINE_MEMSET)
>>>>
>>>>   # The location of this include matters!
>>>>   include $(src)/../common/Makefile.include
>>>> diff --git a/init/Kconfig b/init/Kconfig
>>>> index 8583d9f06c52..ff3f8475dd2f 100644
>>>> --- a/init/Kconfig
>>>> +++ b/init/Kconfig
>>>> @@ -173,6 +173,13 @@ config CC_HAS_ALLOC_TOKEN
>>>>   config CC_HAS_MULTIDIMENSIONAL_NONSTRING
>>>>          def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
>>>>
>>>> +config CC_HAS_OPT_INLINE_MEMSET
>>>> +       def_bool $(cc-option,-finline-stringops=memset)
>>>> +
>>>> +config CC_OPT_INLINE_MEMSET
>>>> +       string
>>>> +       default "-finline-stringops=memset" if CC_HAS_OPT_INLINE_MEMSET
>>>> +
>>>>   config LD_CAN_USE_KEEP_IN_OVERLAY
>>>>          # ld.lld prior to 21.0.0 did not support KEEP within an overlay description
>>>>          # https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project%2Fpull%2F130661&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683740883%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=JlYxG81FQsC5sm3aLe4M6uUIaU5QNmdbupcy3LuGPGQ%3D&reserved=0
>>>> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
>>>> index 2851afa9154f..f5cad5641985 100644
>>>> --- a/lib/vdso/getrandom.c
>>>> +++ b/lib/vdso/getrandom.c
>>>> @@ -29,6 +29,22 @@
>>>>          }                                                                       \
>>>>   } while (0)
>>>>
>>>> +#if __has_builtin(__builtin_memset_inline)
>>>> +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
>>>> +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
>>>> +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
>>>> +#else
>>>> +static inline void *memset_inline(void *dst, int value, size_t size)
>>>> +{
>>>> +       char *d = dst;
>>>> +
>>>> +       while (size--)
>>>> +               *d++ = value;
>>>> +
>>>> +       return d;
>>>> +}
>>>> +#endif
>>>
>>> Does this work?
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgodbolt.org%2Fz%2FTx6EaGMfb&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683749874%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3MCx7IwcEz2ieYYZzQ2dLdrxFTjJiUqH0c1qiOXeLlo%3D&reserved=0
>>
>> Hmmm...possibly.
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgodbolt.org%2Fz%2Fec9rzd9Yf&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683758681%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=5T4oq%2B4AfVJBqvBNA19kzNq19kRYM9u8YzYcP%2B8P7Mw%3D&reserved=0
>> I don't get it...
> 
> Just keep it under 2 pages, it will be fine:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgodbolt.org%2Fz%2FqqoMqfxev&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C8130be3fe7304659b8e308df1b507f25%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639259704683768107%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=FrwGHnEXsSp8scH8GtL%2BlqjymHfVokSrtaOqhp2iZPg%3D&reserved=0
> 

Doesn't work on powerpc (gcc 13.4):

foo:
         li 5,8192
         li 4,0
         b memset
foo2:
         li 5,8193
         li 4,0
         b memset

But that's the reason why vdso Makefile has option  -fno-builtin, that 
option gives instead:

foo:
         li 10,2048
         li 9,0
         addi 3,3,-1
         mtctr 10
.L2:
         stb 9,1(3)
         stb 9,2(3)
         stb 9,3(3)
         stbu 9,4(3)
         bdnz .L2
         blr
foo2:
         li 9,0
         li 10,2048
         stb 9,0(3)
         mtctr 10
.L10:
         stb 9,1(3)
         stb 9,2(3)
         stb 9,3(3)
         stbu 9,4(3)
         bdnz .L10
         blr



Christophe

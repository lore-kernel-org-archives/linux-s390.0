Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9B53ECF7;
	Tue,  8 Sep 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878506; cv=none; b=EcAJ1Bs0aSwDKIHyzZbifG4M5DM2iFEHwteVwkGwP3fh+/+85KGSfR+CPsjhF4R7Jg1T8bTfhvYViUJP8VX/e3vwfNyx/2KuhxDMA0GgO6LA7sRWfhpTpmEVC2Mec/HZpu/jkJe8xNjXfAvJc4awPacwNrNFzpanDD/6CDNf7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878506; c=relaxed/simple;
	bh=oDX/WcE11SZ/SdoliOgaRIcPYC+iHQXg06z0Mv3RUGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBUhIjzzWRI5dhwlqAy7zJCis/z6/yjFQoJIWJ7elpD9+gR+LaoyOfGvjHU2SXZ+gvC/Y9XVJTzD6EowYI70Qkpnc1WO8W8H4DX9rvLkDUbUZoT6UAfUehLbI/7Ks8A69kkOown04mSAEwMz8EKHGU7LRekIwfrubUiXj5SGf34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83611F00A3A;
	Tue,  8 Sep 2026 14:41:14 +0000 (UTC)
Message-ID: <7c9f6ec3-5886-41ea-8803-d81019321d29@kernel.org>
Date: Tue, 8 Sep 2026 16:41:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/24] powerpc/vdso: Enable the vdsocheck tool
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
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
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Nicolas Schier <nsc@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-17-3a93791af1cf@linutronix.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-17-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/09/2026 à 08:33, Thomas Weißschuh a écrit :
> The vdsocheck tool validates the object files and final .so library.
> It can detect if the compiler created relocations which are incompatible
> with the vDSO which need to be worked around.
> 
> Wire it up for the architecture.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   arch/powerpc/Kconfig              |  1 +
>   arch/powerpc/kernel/vdso/Makefile |  4 ++--
>   lib/vdso/check/vdsocheck.rs       | 27 +++++++++++++++++++++++++++
>   3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2580e27e4328..f19e225cfc5c 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -330,6 +330,7 @@ config PPC
>   	select SYSCTL_EXCEPTION_TRACE
>   	select THREAD_INFO_IN_TASK
>   	select TRACE_IRQFLAGS_SUPPORT
> +	select VDSO_CHECK
>   	select VDSO_DATASTORE
>   	select VDSO_GETRANDOM
>   	#
> diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
> index 368759f81708..ca20b91b4373 100644
> --- a/arch/powerpc/kernel/vdso/Makefile
> +++ b/arch/powerpc/kernel/vdso/Makefile
> @@ -81,9 +81,9 @@ targets += vdso64.lds
>   CPPFLAGS_vdso64.lds += -P -C
>   
>   # link rule for the .so file, .lds has to be first
> -$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
> +$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o $(vdsocheck) FORCE
>   	$(call if_changed,vdso32ld_and_check)
> -$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o FORCE
> +$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o $(vdsocheck) FORCE
>   	$(call if_changed,vdso64ld_and_check)
>   
>   # assembly rules for the .S files
> diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> index e45a1fbc6829..429bdcd65818 100644
> --- a/lib/vdso/check/vdsocheck.rs
> +++ b/lib/vdso/check/vdsocheck.rs
> @@ -69,6 +69,33 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
>               ..Default::default()
>           }
>           .into(),
> +        bindings::EM_PPC => AllowedRelocations {
> +            in_object_file: &[
> +                bindings::R_PPC_REL24,

Not sure this is correct, see commit 42ed6d56ade2 ("powerpc/vdso: Block 
R_PPC_REL24 relocations")

> +                bindings::R_PPC_REL14,
> +                bindings::R_PPC_REL32,
> +                bindings::R_PPC_REL16,
> +                bindings::R_PPC_REL16_LO,
> +                bindings::R_PPC_REL16_HI,
> +                bindings::R_PPC_REL16_HA,
> +            ],
> +            ..Default::default()
> +        }
> +        .into(),
> +        bindings::EM_PPC64 => AllowedRelocations {
> +            in_object_file: &[
> +                bindings::R_PPC64_REL24,

Not sure this is correct, see commit 42ed6d56ade2 ("powerpc/vdso: Block 
R_PPC_REL24 relocations")

> +                bindings::R_PPC64_REL14,
> +                bindings::R_PPC64_REL32,
> +                bindings::R_PPC64_REL64,
> +                bindings::R_PPC64_REL16,
> +                bindings::R_PPC64_REL16_LO,
> +                bindings::R_PPC64_REL16_HI,
> +                bindings::R_PPC64_REL16_HA,
> +            ],
> +            ..Default::default()
> +        }
> +        .into(),
>           _ => None,
>       }
>   }
> 


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528403;
	b=0fNp2C24aHpc9EXmRIe8UK4rbKJnjCl2cg8YE3ld5FxW22MbOxbVTkN6DEuBbJYy1S2N
	 35pvMWMoPprubLGxLztBtewNxkLRMb4chhMjPCgzkpuADuSk6Kf48Un+4y9d0doB9PiBN
	 QbNw3OPT1trqRTog7H4BIwwjfWl3IMjdQEu9L+obZNbSABQnTCVqdb8FFIg4lNnak4aKI
	 uDkN/i+vSDFbCA9o4l4q9NemRSjfaxGblfZQhrez/0JKGskNUGaXbCbrNknT/nVRJ2qYP
	 zrUjdD9e1G0KP6AvF5gUql4jDhL8hTSvIsPX+7fL6CrlFjHEhiei5HlmHyJKansDNGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HvrlI1buZ3E0IRhzK+P1F1aEhLGiGloUS49EF6BcS/M=;
	b=ylymvyVzrqxOz/a26tsoUrdQM6me22liyBd/Y11KZABuFVBDBbTF6FucI8AUsg2bshlN
	 j8DNYi4qOjhzDK3VlA/13B0o7zqK9RVxMOO676B+JYVUeQckJ9ZValX8DanourPTUnm+K
	 viZJ63uhDVELVDjgR0OiB8MqlmbE8pa2zh1AQFM37A3+/I7RdPKTaah1Dw2MHGqhsp3st
	 c3ucaBGEFMUh8UUpM5NYqyxi8yma603lPJ1zR5VxWT60tMhziBHbExVXNOi+nlzwyY8Xf
	 xImSnSbccwrxyoR3XfEe94WtBp7hq8CL/DwBD+yJUGN9gJSZ/7dpOjknF1ka3n1u04A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kho9japU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE13C606A31E;
	Tue, 24 Nov 2026 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kho9japU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A001F000C6;
	Tue, 24 Nov 2026 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528402;
	bh=HvrlI1buZ3E0IRhzK+P1F1aEhLGiGloUS49EF6BcS/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kho9japUfI5hDILsBuhf1RvYUh3RdAm113beEsgXkXArnLIfYvkbX3UfhbBJPpENY
	 pbHaL7iNYOzjnKeJCqiio8iPtnSt/YPOXD11PPejVFik7/inKO6oa2vKq12B64xsDO
	 zG6QaBDQVtF2GXzdF6RYD4Fok2hk3nMI/WXwXDFnXDOyaUUsiGk0Dp2cMDJ3MAdKTm
	 yoyuPwYTCUCHi3j/fPpHqX23aleEwYpt+7aMVebsm+yx6gV+vCsMGyMUWUjTZXRrxw
	 CzYx7fKU+LDKTdnlrKolrlZIoIrsxUmgqc66tWF9Q6SEMFh5biK7+mDaxtJnQUeUZq
	 fpJqNoBiXSvZg==
Message-ID: <sashiko-outbox-231265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/11] vDSO: Automatically enable VDSO_CHECK
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>, "Andy
 Lutomirski" <luto@kernel.org>, "Vincenzo Frascino" <vincenzo.frascino@arm.com>, "Kees
 Cook" <kees@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Richard
 Weinberger" <richard@nod.at>, "Anton Ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes
 Berg" <johannes@sipsolutions.net>, "Russell King" <linux@armlinux.org.uk>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Huacai Chen" <chenhuacai@kernel.org>, "WANG
 Xuerui" <kernel@xen0n.name>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Christophe
 Leroy" <chleroy@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org, "Jan
 Stancek" <jstancek@redhat.com>, "Arnaldo Carvalho de Melo" <acme@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>
In-Reply-To: <20261123-vdso-absolute-reloc-v6-11-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
 <20261123-vdso-absolute-reloc-v6-11-161e218dd217@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:53:20 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vdso: VDSO_CHECK disabled on 32-bit RISC-V and some MIPS
  configs
--

commit 7179dbe5f048cacac134800666e4651c26c46665
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

vDSO: Automatically enable VDSO_CHECK

This commit selects VDSO_CHECK from GENERIC_GETTIMEOFDAY and VDSO_GETRANDOM
in lib/vdso/Kconfig and removes the per-architecture VDSO_CHECK selects.

[ ... ]

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 9a3ce550c95dc..e2eb9627bd14c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -107,7 +107,6 @@ config MIPS
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select ARCH_HAS_ELFCORE_COMPAT
>  	select HAVE_ARCH_KCSAN if 64BIT
> -	select VDSO_CHECK
> =20
>  config MIPS_FIXUP_BIGPHYS_ADDR
>  	bool

[ ... ]

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f580d2afecf7e..f8e26c4bed2ba 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -229,7 +229,6 @@ config RISCV
>  	select THREAD_INFO_IN_TASK
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select UACCESS_MEMCPY if !MMU
> -	select VDSO_CHECK if MMU
>  	select VDSO_DATASTORE if MMU
>  	select VDSO_GETRANDOM if MMU && 64BIT
>  	select USER_STACKTRACE_SUPPORT

[ ... ]

> diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
> index 559f5534831e5..741de1abe9237 100644
> --- a/lib/vdso/Kconfig
> +++ b/lib/vdso/Kconfig
> @@ -6,6 +6,7 @@ config VDSO_DATASTORE
>  config GENERIC_GETTIMEOFDAY
>  	bool
>  	select VDSO_DATASTORE
> +	select VDSO_CHECK
>  	help
>  	  This is a generic implementation of gettimeofday vdso.
>  	  Each architecture that enables this feature has to
> @@ -21,6 +22,7 @@ config GENERIC_VDSO_OVERFLOW_PROTECT
>  config VDSO_GETRANDOM
>  	bool
>  	select VDSO_DATASTORE
> +	select VDSO_CHECK
>  	help
>  	  Selected by architectures that support vDSO getrandom().

[Severity: Medium]
Does selecting VDSO_CHECK only from GENERIC_GETTIMEOFDAY and VDSO_GETRANDOM
leave VDSO_CHECK disabled on 32-bit RISC-V and on MIPS configurations
without MIPS_GENERIC_GETTIMEOFDAY?

On RISC-V, both GENERIC_GETTIMEOFDAY and VDSO_GETRANDOM depend on MMU &&
64BIT, while 32-bit MMU builds only select VDSO_DATASTORE and still build
arch/riscv/kernel/vdso/ using cmd_vdso_check from lib/vdso/Makefile.include.
Selecting VDSO_CHECK from VDSO_DATASTORE would cover 32-bit RISC-V as well.

On MIPS, arch/mips/vdso/ is built unconditionally and runs cmd_vdso_check,
but GENERIC_GETTIMEOFDAY is only selected when MIPS_GENERIC_GETTIMEOFDAY is
enabled (which depends on CSRC_R4K || CLKSRC_MIPS_GIC), and MIPS does not
select VDSO_DATASTORE or VDSO_GETRANDOM.  When MIPS_GENERIC_GETTIMEOFDAY is
disabled, VDSO_CHECK will no longer be enabled and the build will skip
vdsocheck.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-vdso-absol=
ute-reloc-v6-0-161e218dd217@linutronix.de?part=3D11

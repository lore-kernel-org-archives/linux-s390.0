Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528390;
	b=jBi59U8mJTwgNZRzhye2r1wUTu8LeQTl+rXlgUp8cBtTZnAenoQ1OZ0CEWXjScIYJg0f
	 BYiPBzXGis/+ACxJ3HP0E+y2B2aY0UnbSfBX2JrjNuXYFWhiMm2tZEuhUsqGg6WZczfcl
	 lfxyvWkyuVDcBfDsF/tbYdVbGs7/89KbUPq/AHoAFIyz2H6dJlQfehA/ab6rWkwtwnfgS
	 juSRYMKuYByvm5vtm/FigbakLJkkbsXS3lf5eniRdb5u2X4sKe7dB3C6S/SPazBtrWHZ0
	 0mZtPc7c+op/N5GRDmvDttIXSCAxGfa2ayDJ+Du+8/aNzllTBvkjpbhQTl0+C7g0Oxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528390;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sgQKXZiGb5tBZBQ3K08NnOpAN072dn/neONJ7jc4HhM=;
	b=nOc9BMRCTDr36cZnagxfCB8gLgqjVPwhC3UyS3Aej1K4b1cw/858U/bJvh7ESdbxhREJ
	 Sr7S5dPcimdmFtN75GJtTbOzIHYLSx1J2edkidqMmzEx6CrRQLtJm6G7fFzfqv81YB5Bt
	 ifd67iUH4FhBy2F/QIC6YqCI1nWAVlEitPleMBL7+Au7xLqHSE3i/r6aBAIGz+4u21Sfl
	 VX+oBID1sF8ZVllp9I63l6+wV/mQce6spnfSdJ9Nmnh9nG3BATPfpf9PQxgiq6YrYfzC3
	 Md/yfDJL60/Uo6m7NNMXMZtcjGzQpb+Z0lCwtYPH4jshb3jD+rSCdm0SXU4Hck5Sfnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FA969aNu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78424606A31E;
	Tue, 24 Nov 2026 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FA969aNu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3751F00A19;
	Tue, 24 Nov 2026 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528389;
	bh=sgQKXZiGb5tBZBQ3K08NnOpAN072dn/neONJ7jc4HhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FA969aNuoUfYrCw580vZYFdb+V4E+YyjNSSdoOajzUkWYW+Au+vSXG4kF2jrHL3M/
	 TJBCbpp7XldUXu5ie3fkMOxuk7+qFtYgPw7x5GSScU6d5BTvsTQeiPt0UvyXrEqxU5
	 gUNqMcIDynHlqso6f1xb3ET6petdCz38IDn4i00PZTf9ri22atoGSkWb42PEzZAsy9
	 NL9DScw5nvgrRze1oDft5YcYz8tCAbRVqZbBbYx/rxSkXoyh6fDxzBwLoLIuiHOpIB
	 lAlyeJISbDi7N07gcnuUMOngsO8IrGeGdPYEQZLP2pCUlOl4E1oekSKMWDIQQybuFk
	 UwXExaJDlewdw==
Message-ID: <sashiko-outbox-231258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/11] arm64: vdso: Enable the vdsocheck tool
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
In-Reply-To: <20261123-vdso-absolute-reloc-v6-4-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
 <20261123-vdso-absolute-reloc-v6-4-161e218dd217@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:53:06 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] arm64: vdso: missing EM_ARM relocations in
  allowed_relocations_for_machine()
- [Low] arm64: vdso32: missing $(vdsocheck) prerequisite for vdso.so.raw
  target
- [Low] vdso: vdsocheck: missing R_AARCH64_JUMP26 in
  allowed_relocations_for_machine()
- [Low] vdso: vdsocheck: rejection of R_*_NONE relocations in
  validate_linked_dso()
--

commit c6172b0bea62f3a614a6024ef180d13da9b4e5c7
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

arm64: vdso: Enable the vdsocheck tool

This commit enables the vdsocheck tool on arm64 by selecting VDSO_CHECK,
updating the arm64 vDSO Makefile link rule, and adding allowed AArch64 obje=
ct
file relocations to vdsocheck.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5a51b0ef9440..1caaf4737f027 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -258,6 +258,7 @@ config ARM64
>  	select TRACE_IRQFLAGS_NMI_SUPPORT
>  	select HAVE_SOFTIRQ_ON_OWN_STACK
>  	select USER_STACKTRACE_SUPPORT
> +	select VDSO_CHECK

[Severity: Medium]
Does selecting VDSO_CHECK break arm64 builds when CONFIG_COMPAT_VDSO and
CONFIG_RUST_IS_AVAILABLE are enabled?

Selecting VDSO_CHECK activates cmd_vdso_check in lib/vdso/Makefile.include =
for
arch/arm64/kernel/vdso32/ as well.  That directory compiles vgettimeofday.c
with -fPIC -march=3Darmv8-a (and -mthumb by default under
CONFIG_THUMB2_COMPAT_VDSO).  When __arch_get_vdso_u_time_data() materializes
the address of vdso_u_time_data with Clang, or when the compiler emits
intra-object branches, vgettimeofday.o contains PC-relative ARMv8-A and
Thumb-2 relocations such as R_ARM_THM_MOVW_PREL_NC (49), R_ARM_THM_MOVT_PREL
(50), R_ARM_MOVW_PREL_NC (45), R_ARM_MOVT_PREL (46), R_ARM_THM_CALL (10),
R_ARM_THM_JUMP24 (30), R_ARM_CALL (28), and R_ARM_JUMP24 (29).

In lib/vdso/check/vdsocheck.rs, allowed_relocations_for_machine() only allo=
ws
R_ARM_NONE (0), R_ARM_REL32 (3), and R_ARM_PREL31 (42) for bindings::EM_ARM,
so vdsocheck rejects arch/arm64/kernel/vdso32/vgettimeofday.o with
ValidationError::InvalidRelocation.

> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Mak=
efile
> index 7dec05dd33b70..9fac0e54097dc 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -61,7 +61,7 @@ targets +=3D vdso.lds
>  CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
> =20
>  # Link rule for the .so file, .lds has to be first
> -$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
> +$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) $(vdsocheck) FORCE
>  	$(call if_changed,vdsold_and_vdso_check)

[Severity: Low]
Should $(obj)/vdso.so.raw in arch/arm64/kernel/vdso32/Makefile also list
$(vdsocheck) as a prerequisite?

arch/arm64/kernel/vdso32/Makefile runs $(cmd_vdso_check) via
$(call if_changed,vdsold_and_vdso_check), and cmd_vdsold already filters $^=
 to
%.lds and %.o, but without $(vdsocheck) in the target prerequisites Kbuild
will not re-run the check on the compat vDSO when vdsocheck is rebuilt.

[ ... ]

> diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> index e28ee59a900dd..0d5ceaca34d7c 100644
> --- a/lib/vdso/check/vdsocheck.rs
> +++ b/lib/vdso/check/vdsocheck.rs
> @@ -57,6 +57,18 @@ fn allowed_relocations_for_machine(machine: u16) -> Op=
tion<AllowedRelocations<'s
>              ..Default::default()
>          }
>          .into(),
> +        bindings::EM_AARCH64 =3D> AllowedRelocations {
> +            in_object_file: &[
> +                260, /* R_AARCH64_PREL64 */
> +                261, /* R_AARCH64_PREL32 */
> +                262, /* R_AARCH64_PREL16 */
> +                273, /* R_AARCH64_LD_PREL_LO19 */
> +                274, /* R_AARCH64_ADR_PREL_LO21 */
> +                283, /* R_AARCH64_CALL26 */
> +            ],
> +            ..Default::default()
> +        }
> +        .into(),

[Severity: Low]
Should the bindings::EM_AARCH64 list also allow 282 (R_AARCH64_JUMP26)?

R_AARCH64_CALL26 (283) covers 26-bit PC-relative BL calls, while tail-call
optimization or unconditional branches between functions in an object file
emit B instructions with R_AARCH64_JUMP26 (282), which would otherwise fail
validation with ValidationError::InvalidRelocation.

[Severity: Low]
Can validate_linked_dso() reject valid linked vDSOs when the linker emits
R_*_NONE dynamic relocations?

lib/vdso/Makefile.include notes that some GNU ld ports emit unneeded R_*_NO=
NE
relocations and filters them out with grep -v _NONE when vdsocheck is not
used.  When vdsocheck is enabled, validate_linked_dso() rejects any
elf::Section::Rel or elf::Section::Rela section outright without ignoring
R_*_NONE entries.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-vdso-absol=
ute-reloc-v6-0-161e218dd217@linutronix.de?part=3D4

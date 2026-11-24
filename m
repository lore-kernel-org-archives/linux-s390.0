Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528392;
	b=RY8wCntRemeZI4SuPzxqehtpy+Bb0Yukx2GdK13DOmujCIXoDs3NPp/kZDJAZPPEsQsm
	 JBTx+FWLlHPB6nRkIU44loN6SpEgTA3j4QwC3lyWAh2y3/ypJKfwhlUAWyHjRdUNAN+RY
	 pboV6hLraaAAxgnYYeY3gNF4a7+VaFH6J1FIow73j3vdezFoLd4HtHQL145KCUiq0Ci4C
	 tUbis9B8/9fdbpPd9jGDmpHLkm6bgyuf6pRaiPbXwRjJMSvYzeJKvA+i36wYuPCrWELom
	 s/Wl1lHTEcoLerCrpAXQOuj73CVJcb4xXaDUXIcCgyB0FS/6aiW85X8HgH+sDmfmUFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528392;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CGzthS/oSecoEAl06XI+zoE8510Hx1H6SJxp/B0Wigw=;
	b=aH5dClptuGi5Mfp73WVgyHqk+Y+u6et0p/+xe/LzeaKAFUW0PDWtifudsJ3hmww5BEzF
	 TOhUyVNp3UA+SeI4JcCO+12fXj90KNYLQYXo2qwRU5wfq4JPYvgfMnt/aGz2MqnNOML3D
	 T9SVcUYOD/IYU9t983zJopik0h0+Hy7CkK/Pt/AE34URwQ5i9/Gk6mAQYl9RpuRNgqCXe
	 KNQK5Jlzt1opr/wQn6N0Hq5ZMlNl37jYFXDp0TK9ivyxDsCuEh9bcIoPj8lfleMayl4tE
	 uUgvK8Xhmpkei8wdJXeq3SIuLNZPIlC2HTKXeCVgd6cj4hvUKlc8SL2gOwlSzqW5CLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QwblkD/w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A57606A31E;
	Tue, 24 Nov 2026 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwblkD/w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F6F1F000E0;
	Tue, 24 Nov 2026 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528392;
	bh=CGzthS/oSecoEAl06XI+zoE8510Hx1H6SJxp/B0Wigw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QwblkD/wTsvFPj9DlvP2mZak8aRfXqeZm5me6PO0oOZM4v7hQ+bxkWPFAxoTT8mg/
	 jPQKnCFDs6oQ+u2ArzzEJMMkxxxN7S5/31PRC+NxBJhk+i/mN0UZiiFurEgI0yrabr
	 xBc1K2ffMcX81w503jm/uF13WHY63tIJmd6ehI6b5aMn77wcmWwAVOoOdon1K/X3ME
	 Nr/C0qQ1Si1PAXsCyhJVerrJ9fQtHu4nmbflZzvvVgRw+OoWcrIK0+tkkocYShM9H3
	 x23H90UQ1Tou2N9SxgJYvycDUUMBxofLaItEWKOUdmHqKpTNAg5P3GB+lD5QxZSjBd
	 TsgEvyY+V845A==
Message-ID: <sashiko-outbox-231259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/11] powerpc/vdso: Enable the vdsocheck tool
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
In-Reply-To: <20261123-vdso-absolute-reloc-v6-5-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
 <20261123-vdso-absolute-reloc-v6-5-161e218dd217@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:53:09 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] powerpc/vdso: missing PCREL relocations in
  allowed_relocations_for_machine()
- [High] powerpc/vdso: unignored .rela.opd in
  allowed_relocations_for_machine()
--

commit 52616a4e4f7df565d936b44f34a023f9e1864af3
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

powerpc/vdso: Enable the vdsocheck tool

This commit enables the vdsocheck build-time validation tool for 32-bit and
64-bit PowerPC vDSO objects and defines their allowed ELF relocation types.

> diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> index 0d5ceaca34d7c..da58ff220eab6 100644
> --- a/lib/vdso/check/vdsocheck.rs
> +++ b/lib/vdso/check/vdsocheck.rs
> @@ -69,6 +69,33 @@ fn allowed_relocations_for_machine(machine: u16) -> Op=
tion<AllowedRelocations<'s
>              ..Default::default()
>          }
>          .into(),
> +        bindings::EM_PPC =3D> AllowedRelocations {
> +            in_object_file: &[
> +                10,  /* R_PPC_REL24 */
> +                11,  /* R_PPC_REL14 */
> +                26,  /* R_PPC_REL32 */
> +                249, /* R_PPC_REL16 */
> +                250, /* R_PPC_REL16_LO */
> +                251, /* R_PPC_REL16_HI */
> +                252, /* R_PPC_REL16_HA */
> +            ],
> +            ..Default::default()
> +        }
> +        .into(),
> +        bindings::EM_PPC64 =3D> AllowedRelocations {
> +            in_object_file: &[
> +                10,  /* R_PPC64_REL24 */
> +                11,  /* R_PPC64_REL14 */
> +                26,  /* R_PPC64_REL32 */
> +                44,  /* R_PPC64_REL64 */
> +                249, /* R_PPC64_REL16 */
> +                250, /* R_PPC64_REL16_LO */
> +                251, /* R_PPC64_REL16_HI */
> +                252, /* R_PPC64_REL16_HA */
> +            ],
> +            ..Default::default()
> +        }
> +        .into(),
>          _ =3D> None,
>      }
>  }

[Severity: High]
Does the bindings::EM_PPC64 entry break 64-bit vDSO builds when
CONFIG_PPC_KERNEL_PCREL is enabled?

With CONFIG_PPC_KERNEL_PCREL=3Dy, CFUNC() appends @notoc in
arch/powerpc/include/asm/ppc_asm.h, so cvdso_call in gettimeofday.S and
getrandom.S emits R_PPC64_REL24_NOTOC (116).  In addition,
vgettimeofday-64.o and vgetrandom-64.o are compiled with KBUILD_CFLAGS
(which includes -mpcrel) and emit R_PPC64_REL24_NOTOC (116) and
R_PPC64_PCREL34 (132), causing vdsocheck to reject the object files and fail
the build.

[Severity: High]
Will vdsocheck also fail the build on 64-bit big-endian kernels using ELFv1
(CONFIG_PPC64_ELF_ABI_V1=3Dy)?

Under -mabi=3Delfv1, the compiler emits function descriptors in .opd for the
global C functions in vgettimeofday-64.o and vgetrandom-64.o, producing a
.rela.opd section with R_PPC64_ADDR64 (38) and R_PPC64_TOC (51) relocations.
Although arch/powerpc/kernel/vdso/vdso64.lds.S discards *(.opd) during the
final link, vdsocheck runs on the intermediate object files first and
rejects .rela.opd unless it is listed in ignored_object_file_sections.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-vdso-absol=
ute-reloc-v6-0-161e218dd217@linutronix.de?part=3D5

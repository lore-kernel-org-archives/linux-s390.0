Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528396;
	b=JRkHCR3SJTFjjUkFzUOA1YL9BriaD+Z/R3qaxcUHSN1uuFEXffc38azlARzZXdeZQsLa
	 UQ/E4TedibIMg+Nkdytxsy9sXLjEqpTjzPX31IEI6wouj12rxoFDhIE/zKmT4nV177zIg
	 /TdBeOyM9sk3O6qnb8Ivps7lRH+tyFXSV9l6m7ipDMPHbXs2iA+GUPWnY+C6KYi/dUrqq
	 pN/nBHly4nQnkToELjkH3x4nSQXZudSzh9sUKpM60jL0ihJEfzU+4EZVgPp1CbbuBifIC
	 PnMMi2xKZIjw0nHfU0oaCdxQsoP8IhEd8xtyzwL2gurZ25niSGKOVY8oRAIZ/decjpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528396;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j8VuKYHsB4+QDN1OuGMMGRMKrc7oMUOuGmeu/s/80zI=;
	b=WEufORZQXN54pF19IkJy2cUzug0PYdvBloZRKo9gbkgkBxtvpjVFQ7xzFTikFpwJvRXv
	 arFBOI9N8vKTMtVZzOITJ3McEXiK3VV51hCtHEVrwHFl/i0pXjz9NKc1h/WJTQsNjyye7
	 CZJQFIRt5YQyZ4vPD5EQHOCW7Z0OsE02RXKuzf/ngqfBDt7js4bsm4ciV3JUVRgIlAJHp
	 zMIsEf5arbr+DXCBjE3bwupjRmc1BlItXgMnJTKZ2Y7c8cTF0UCFaYHShY0RQpO/PDSE7
	 ewNejL8DohGnB08RBCuF8hwMqVld95nLrr26vdoZ4smm/E+6CY84g3ztFTcP9u3tO4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFskeiZS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41BF606A321;
	Tue, 24 Nov 2026 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFskeiZS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72AF1F000C6;
	Tue, 24 Nov 2026 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528395;
	bh=j8VuKYHsB4+QDN1OuGMMGRMKrc7oMUOuGmeu/s/80zI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFskeiZSZSaGoVbhpd1h3zBuer2BkhTy9kP95ojqLHs3nKCQBWicJh9tF6KyPkWf+
	 XlSd6oKg8IeYUa5xajwCcuWokix5WhDP3kooszRlH3u/5NoTgLfUGRT2qH95ZX+V78
	 X+/4yGjj2RSeqaHDGJax6zw9DrGJzkZaCZ9V7HpXn1gRvvF/Vf+2pSFlICI81whzlO
	 1MwDZESPKvsL/4r0G1AqEme4Cdqh+d6xr97QPXqKolLAcGbahgTbJLsqxLRXDoD1bx
	 D6/TtT8mlZg7Q9OZ0eR+uyKSdR/NIC1iLyqKiQ/qFAg9pLjF0TzkCO8VuZfgT2F4Zw
	 Nb5b7OJDff93g==
Message-ID: <sashiko-outbox-231261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/11] LoongArch: vDSO: Enable the vdsocheck tool
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
In-Reply-To: <20261123-vdso-absolute-reloc-v6-7-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
 <20261123-vdso-absolute-reloc-v6-7-161e218dd217@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:53:12 +0000
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
- [Medium] LoongArch: vDSO: wrong R_LARCH_PCADD_LO12 value in vdsocheck
- [Medium] LoongArch: vDSO: missing relax and eh_frame relocations in
  vdsocheck
--

commit 2fb850dc718e09234a1d0b974829df4ce1c9ae9b
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

LoongArch: vDSO: Enable the vdsocheck tool

This commit selects VDSO_CHECK for LoongArch, wires vdsocheck into the
LoongArch vDSO Makefile, and adds the allowed object file relocations for
EM_LOONGARCH.

> diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> index 37455d3261109..7952ad6ba72b1 100644
> --- a/lib/vdso/check/vdsocheck.rs
> +++ b/lib/vdso/check/vdsocheck.rs
> @@ -122,6 +122,32 @@ fn allowed_relocations_for_machine(machine: u16) -> =
Option<AllowedRelocations<'s
>              ..Default::default()
>          }
>          .into(),
> +        bindings::EM_LOONGARCH =3D> AllowedRelocations {
> +            in_object_file: &[
> +                47,  /* R_LARCH_ADD8 */
> +                48,  /* R_LARCH_ADD16 */
> +                49,  /* R_LARCH_ADD24 */
> +                50,  /* R_LARCH_ADD32 */
> +                51,  /* R_LARCH_ADD64 */
> +                52,  /* R_LARCH_SUB8 */
> +                53,  /* R_LARCH_SUB16 */
> +                54,  /* R_LARCH_SUB24 */
> +                55,  /* R_LARCH_SUB32 */
> +                56,  /* R_LARCH_SUB64 */
> +                64,  /* R_LARCH_B16 */
> +                65,  /* R_LARCH_B21 */
> +                66,  /* R_LARCH_B26 */
> +                71,  /* R_LARCH_PCALA_HI20 */
> +                72,  /* R_LARCH_PCALA_LO12 */
> +                73,  /* R_LARCH_PCALA64_LO20 */
> +                74,  /* R_LARCH_PCALA64_HI12 */
> +                99,  /* R_LARCH_32_PCREL */

[Severity: Medium]
Should EM_LOONGARCH also allow R_LARCH_RELAX (100), R_LARCH_ALIGN (102),
R_LARCH_ADD6 (105), and R_LARCH_SUB6 (106)?

arch/loongarch/vdso/Makefile overrides KBUILD_CFLAGS and KBUILD_AFLAGS for
$(obj-vdso) using ccflags-vdso and cflags-vdso, which drops -mno-relax and
-mthin-add-sub from arch/loongarch/Makefile while enabling
-fasynchronous-unwind-tables.  As a result, toolchains with linker
relaxation enabled by default emit R_LARCH_RELAX and R_LARCH_ALIGN in the
vDSO objects, and .rela.eh_frame uses R_LARCH_ADD6 and R_LARCH_SUB6 for
DW_CFA_advance_loc, causing vdsocheck to fail the build.

> +                128, /* R_LARCH_PCADD_HI20 */
> +                128, /* R_LARCH_PCADD_LO12 */

[Severity: Medium]
Should R_LARCH_PCADD_LO12 be 129 instead of 128?  In
arch/loongarch/include/asm/elf.h, R_LARCH_PCADD_HI20 is 128 and
R_LARCH_PCADD_LO12 is 129, so any vDSO object using pcaddi-based
PC-relative addressing (where the two relocations are emitted as a pair)
will be rejected by vdsocheck with an InvalidRelocation error on 129.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-vdso-absol=
ute-reloc-v6-0-161e218dd217@linutronix.de?part=3D7

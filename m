Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528400;
	b=KL7HrMHe21s/h+Qwak1tOXnSPBkXN60xXzxA7z0lE3t8Ic/r+LHjvoUHAUzT5sR27WAs
	 NZ+fBRPnY0S61SkEGQrAOh8+M7qHTRHRiFUMgGZjnuc2lVnNbmIBJ064kIZz7y+rYJsMg
	 td/WdFGky5R3h70sht+W7NtsFRjL6DvbXi21zkEmYGyPuC3Xk8brK1ccOhzR1EN39mGm0
	 Mnj/Q0UE7CTSdvlbV/rua/g8VhUto8yMYhco27l0x3BJNsdxMNjVWWqaCcDGOexMvuTG5
	 k3G+qVJVKO1V8JfqrmjIw3SiqhqLwWjMw07WSwM7Yb7fUFYAzgMvssjVJZV1n7eTHUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528400;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IDRW3UODYLDeDsSDV5ah2aP06esfAD4UXbPE12d0+4c=;
	b=WvigJDwiNi8FzO48mNY5+J3vb0hUmxDSdZWWoCrEXm5jKBt15PjJT30jBV7Veu3MDKGx
	 arXEKsCwcf0r/keLRvUmx6Wwkn8GbeTQ9ay+YVErct2fFiuBZAr+3VlVN8mjk78A2DELR
	 773PJVMX2KlQorhl3Qo2E9vlKdzjSqwRro2FGhlb6ZtbjaC3VfttHraHnKh+9es5AY6n/
	 cpUSDCRX5BbiODHhW2Mi2HH/Br3DMqA8QW9UdM3/TDNM+VLI8hiFUTGQ9jm/CnCU8oW7y
	 K8smaqXkSuStVJL0QSZRu05vCEs5gVkte+gAZseY9LhBtF+IKuuDnLZc1aOxUx6SpUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSw53pwm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13B606A321;
	Tue, 24 Nov 2026 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSw53pwm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2081F000E0;
	Tue, 24 Nov 2026 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528399;
	bh=IDRW3UODYLDeDsSDV5ah2aP06esfAD4UXbPE12d0+4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kSw53pwmEmiFYNYQPpy68ECmj5Bx1omrwn06yw/ZMC7D3YfAL++Pgtj4yPP4TW6P/
	 tQxAvw/YPdI9ZWzlmRE5CpRzYDsV3NtxN/9DXisBwyazQLgN30UrBfAb+IHagdGCNb
	 389oGJ3NK08Vhr/hJb28oH/MbIG8lp/xtPbAwdj7wpXIVNCG0cjQr29tg7e5GXtzub
	 QjJEE44jWffKFWS1mTHpzAnorVZgbgiLktq9jgJuPAjl3QwkTUckYlC+M6S9OYMhRA
	 0juoxRmEnabSi0OiKqRcMezUKcq9AmAavHrrI1vgcCU1dH9M47jDNHLNJMphFO2leY
	 I05I0qdrrccKA==
Message-ID: <sashiko-outbox-231263@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/11] MIPS: vdso: Enable the vdsocheck tool
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
In-Reply-To: <20261123-vdso-absolute-reloc-v6-9-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
 <20261123-vdso-absolute-reloc-v6-9-161e218dd217@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:53:15 +0000
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
- [Low] vdso: vdsocheck misparses 64-bit MIPS ELF64 r_info relocations
--

commit 2aab3cbfe50b7d8f9c6cf9cb786fc8880a6ac472
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

MIPS: vdso: Enable the vdsocheck tool

This commit enables the vdsocheck tool for MIPS and defines the allowed
object file relocations for EM_MIPS in vdsocheck.

> diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> index 1ef3f240f886f..120d8fa551e6e 100644
> --- a/lib/vdso/check/vdsocheck.rs
> +++ b/lib/vdso/check/vdsocheck.rs
> @@ -157,6 +157,21 @@ fn allowed_relocations_for_machine(machine: u16) -> =
Option<AllowedRelocations<'s
>              ..Default::default()
>          }
>          .into(),
> +        bindings::EM_MIPS =3D> AllowedRelocations {
> +            ignored_object_file_sections: &[".rel.pdr", ".rela.pdr"],
> +            in_object_file: &[
> +                10,  /* R_MIPS_PC16 */
> +                60,  /* R_MIPS_PC21_S2 */
> +                61,  /* R_MIPS_PC26_S2 */
> +                62,  /* R_MIPS_PC18_S3 */
> +                63,  /* R_MIPS_PC19_S2 */
> +                64,  /* R_MIPS_PCHI16 */
> +                65,  /* R_MIPS_PCLO16 */
> +                248, /* R_MIPS_PC32 */
> +            ],
> +            ..Default::default()
> +        }
> +        .into(),
>          _ =3D> None,
>      }
>  }

[Severity: Low]
Does vdsocheck misparse 64-bit EM_MIPS relocation entries in
RelSectionIterator::next() and RelaSectionIterator::next()?

lib/vdso/check/elf.rs:RelSectionIterator::next() {
    ...
            ClassAlternative::Elf64(iter) =3D> iter.next().map(|n| {
                let type_ =3D n.r_info.to_cpu(iter.byteorder) as u32;
                Self::Item { type_ }
            }),
    ...
}

Unlike standard ELF64 where r_info is ((r_sym << 32) | r_type), the 64-bit
MIPS ELF ABI lays out the 8-byte r_info region as a 32-bit r_sym at byte
offsets 0..3 followed by 1-byte r_ssym, r_type3, r_type2, and r_type
fields at byte offsets 4..7 (see Elf64_Mips_R_Info in
arch/mips/include/asm/elf.h and get_rel_type_and_sym() in
scripts/mod/modpost.c).

On 64-bit little-endian MIPS (such as 64r6el_defconfig),
n.r_info.to_cpu(iter.byteorder) as u32 reads bytes 0..3, returning r_sym
instead of r_type and causing vdsocheck to fail the build when validating
64-bit vDSO object files whose symbol indices do not match the allowed
relocation numbers.  On 64-bit big-endian MIPS, it packs r_ssym, r_type3,
r_type2, and r_type into a single u32 instead of checking the individual
relocation slots.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-vdso-absol=
ute-reloc-v6-0-161e218dd217@linutronix.de?part=3D9

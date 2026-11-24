Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528386;
	b=YrBH1/jHb2WgQHWBEM+puK6r7+0vZIe1gpkxZcKfc3++tm/1c1ZDrW9Uq7tpnskZpZNb
	 yxC2f+WTso5UVcjJZ5Bpr8K3G3197Twk1R0E9UevknyDdKOEgF8Mo4gagidMInZ0in19l
	 e6O2CKYdm438nNnjTwHr0JFWDUZDhwGFXRfJiO+kXS9rO1TaZQMM7+9eJ8wJV/WfXnQh6
	 Klqmd2Oak8dpBr6LapOSdVcoaMiAgs1InWJjQ394I8X32zh1BueuA15f2Xiv5YfLixm++
	 lqJ7UhHgJS+lq8E2PcIiQiqAaiDYleHJkjU7WL+bbY6t+ujNlh1QnH/ZitUvP9rfBhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528386;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MuyrmrAt5zZMoD0IMFZe5saEEp+/G3mC1MLq3BDmO4E=;
	b=d7oJNvfWDr59YCn3B41WOLRrPiVNF/czqz0saj00cnT6QxoxGEjYoFQJlsTPl/4UW3w4
	 xmnduBNy60+OdoQ1cfnX3QKMi7t6Y+eYiSeWlvlBY34l8Noni/EJeRcObeexhg1jyPpB7
	 Jh3Ciw7zE60z0TTs2rChHI5Wh3OUSjYbsOHFa2cTdaWZZQ3NQyieE5c1RIMGE1lfoJFhv
	 +1wVyHXmXRSM8tAECRUriW25Aow4yjBDt+EGYa7DyPbfVhnGSkH5Plypw70e3vicQSpIJ
	 2CEg9AUVBNw+gTlm8kcLyHa/ew7BmVAS61zBV7//9FVlkrJrzegOV/vPKWgxXVJRTuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6V6vDa4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672E606A32E;
	Tue, 24 Nov 2026 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6V6vDa4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4361F000E6;
	Tue, 24 Nov 2026 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528385;
	bh=MuyrmrAt5zZMoD0IMFZe5saEEp+/G3mC1MLq3BDmO4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6V6vDa4OshPnLfFFF8xa6u+VXwPjEo3Xz2P+tsGKYAW2FdXHlCeUQD99f1+/WRMP
	 JuJdbs5N62yF5u7bjvgjRhGUTtwh4jJZl3YBYjlGTj60qkqatb03/BHk/lyQizEMUi
	 Qt3aFzd4HQyxO7LvjwZy75dOh6kcmjt7oOACTdJe1/VHWXiL492uRl1unpuAp7Q98T
	 bxtwBCy3rFgG402XiPBlq2yUKNqJkoOjYsjNtvoXumqPC6USC/oe9QKb35HFwbBsql
	 Oa2mOCfBel/xzZ9Hg5oMid2JyNRmgBvPfijgRDSybD+6ueSni0qhcFStFpmW7+mEbV
	 5pD92OWOIRaUA==
Message-ID: <sashiko-outbox-231257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/11] ARM: vdso: Enable the vdsocheck tool
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
In-Reply-To: <20261123-vdso-absolute-reloc-v6-3-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
 <20261123-vdso-absolute-reloc-v6-3-161e218dd217@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:53:03 +0000
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
- [High] ARM: vdso: incomplete EM_ARM allowlist in
  allowed_relocations_for_machine()
--

commit cb0c70494d3f8ce1bc0651e74508d837c36a4e17
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

ARM: vdso: Enable the vdsocheck tool

This commit enables the vdsocheck build-time validation tool for 32-bit ARM
vDSO builds and defines the allowed ELF object relocations for EM_ARM.

> diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> index 8cd8c7f3fec85..e28ee59a900dd 100644
> --- a/lib/vdso/check/vdsocheck.rs
> +++ b/lib/vdso/check/vdsocheck.rs
> @@ -48,6 +48,15 @@ fn allowed_relocations_for_machine(machine: u16) -> Op=
tion<AllowedRelocations<'s
>              ..Default::default()
>          }
>          .into(),
> +        bindings::EM_ARM =3D> AllowedRelocations {
> +            in_object_file: &[
> +                0,  /* R_ARM_NONE */
> +                3,  /* R_ARM_REL32 */
> +                42, /* R_ARM_PREL31 */
> +            ],
> +            ..Default::default()
> +        }
> +        .into(),
>          _ =3D> None,
>      }
>  }

[Severity: High]
Does the bindings::EM_ARM allowlist omit valid PC-relative relocations emit=
ted
for arch/arm/vdso/vgettimeofday.o?

When building with Clang (or with CONFIG_THUMB2_KERNEL=3Dy), accessing the
hidden vdso_u_time_data symbol under -march=3Darmv7-a -fPIC uses movw/movt =
pairs
with R_ARM_MOVW_PREL_NC (45) and R_ARM_MOVT_PREL (46) in ARM mode, or
R_ARM_THM_MOVW_PREL_NC (49) and R_ARM_THM_MOVT_PREL (50) in Thumb-2 mode.  =
In
addition, when static helpers in lib/vdso/gettimeofday.c are not inlined (s=
uch
as with CONFIG_DEBUG_SECTION_MISMATCH=3Dy), intra-object calls and tail jum=
ps
emit R_ARM_CALL (28), R_ARM_JUMP24 (29), R_ARM_THM_CALL (10), and
R_ARM_THM_JUMP24 (30).  All of these resolve at static link time without
producing dynamic relocations, but vdsocheck rejects vgettimeofday.o and fa=
ils
the build.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-vdso-absol=
ute-reloc-v6-0-161e218dd217@linutronix.de?part=3D3

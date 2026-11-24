Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528382;
	b=Y1ehidq8/8dJh4T62IM9y/bFYbJc04q0rQHLdrJAqSiUDGmk7QMquEhmy4PvFN7JEMhI
	 bKfmXKtAh21pEHVJQuvOaEWs6qCGGEdVFd59+vsvaR/CapecKN5KSGJXOkHOv5j8wDTKj
	 OmVkeDRhbs1ojrYm4EyE7eb23A2YfgD70BQvvyaveuK+kQBJHNcox8b91NR6p8jWVXl1r
	 P7YcP1Aw9F8+441ByZ8NTBrJrTAs94NGoLZ2VKABYAVEoxgXgyUvRI8MJ1xwSvJ+bbf5C
	 DOaiunP7MshwCEslZSf+qQ5AuZzSZpfJsM6O0rXSMuvBlzDOtokZ+ptaAzB7bX65psA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DWvMadnd77P5qOWpO7fx2KjLWBvQbyvwlTf6Vj6EPJU=;
	b=y/fa4S+SJ1Oz1GK4TCYH1Rd4chz7+A8yrIZnLE3CtFcA+uotdKmJ7th1zhBu0bst/4Mu
	 hAud1LW7b8jPALrpeYerj5oZCz1CyESPt73dMyAZjouq9SCN5lrIshdpmCrTym4X6qAwN
	 McSQLhnJ5jT2Y7nNx8Ts+OibhdUP8hT582DZHNrVbBzfeC/XDtscx2/L6i2RXLrShKusq
	 Nxm/wXqnKJscYbFGJmPrPQiScl69ImN4vLhZ4TkRKN9Sg51p4k2Ryo+j38iq2fxDi2cTV
	 05SgUyJgTKSwKNKanXriyesy2zSE348ILkRK4o/OtF2yz9J0yWC04gzgT4QrNqohNDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JvLdvSJ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C623606A337;
	Tue, 24 Nov 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JvLdvSJ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B70B1F000CF;
	Tue, 24 Nov 2026 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528382;
	bh=DWvMadnd77P5qOWpO7fx2KjLWBvQbyvwlTf6Vj6EPJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JvLdvSJ4ZQRhtMSVhYEQM8sCZYPJ08nvGnxURU9+rKpeQyJI0XxcQb+ZbrYwxQs5R
	 I+H308Vtx5KLDh4cToEa+cc2bPxZA6WcwV2VHLGaPcqT4I1xOpom7DXjNCXGdEQssz
	 /ZlyRghZvzRVqe/fXLNdQFXzPlOY/dZMD3VvrCXPP5VR4f3HK9kIzru3hDeSwprB+i
	 XKsHPRKmJ0THk6BoBKoUe5ccURiPstHFROGqKnjMY7LYuSRkiTuJm8SovGuqCctLcu
	 r8jx4jXKc9iJ9msojTtXGPo2RQWVsQ+U0Bhs2fYe26Z2QdrFNoEn4Qvo0SYp6/cw7e
	 Fa3xgHRVdKfzg==
Message-ID: <sashiko-outbox-231255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/11] vdso: Add the vdsocheck tool
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
In-Reply-To: <20261123-vdso-absolute-reloc-v6-1-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
 <20261123-vdso-absolute-reloc-v6-1-161e218dd217@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:52:59 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [Medium] vdso: vdsocheck uses Rust 1.87 APIs breaking 1.85.0 minimum
  version
- [Medium] vdso: unchecked slice in get_data_subslice() and SHT_NOBITS
  slicing
- [Medium] vdso: missing include/uapi in HOSTBINDGEN_FLAGS and + on
  host_rustlib
- [Medium] vdso: validate_linked_dso() rejects SHT_REL/SHT_RELA with
  R_*_NONE
- [Low] vdso: missing scripts_basic prerequisite on vdsocheck Makefile
  target
- [Low] vdso: vdsocheck main() prints errors to stdout instead of stderr
--

commit ba87ba62d5b7688443f8778322978989d53ab4f8
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

vdso: Add the vdsocheck tool

This commit adds a Rust host build tool, vdsocheck, along with Kbuild
rules to validate that vDSO object files and the linked vDSO shared object
do not contain invalid relocations.

[Severity: Low]
In Makefile (at the vdsocheck target, lines 1575-1577), does the vdsocheck
target need a dependency on scripts_basic?

Building bindings.rs, libbindings.rlib, and vdsocheck in
lib/vdso/check/Makefile uses if_changed_dep, which runs
scripts/basic/fixdep. In a parallel build from a clean tree (or via make
vdsocheck), vdsocheck can run before scripts_basic finishes and fail with a
missing fixdep binary.

[Severity: Medium]
In lib/vdso/check/Makefile (lines 18-24), can building bindings.rs fail
when the host lacks kernel UAPI headers or has an older
/usr/include/linux/elf-em.h?

tools/include/uapi/linux/elf.h includes <linux/types.h> (which includes
<asm-generic/int-ll64.h>) and <linux/elf-em.h>, which reside in
$(srctree)/include/uapi rather than $(srctree)/tools/include/uapi. Passing
only -I$(srctree)/tools/include/uapi in HOSTBINDGEN_FLAGS causes bindgen to
fall back to the host's /usr/include.

Also on line 24, the $(call if_changed_dep,host_rustlib) rule for
$(obj)/libbindings.rlib is missing a leading '+' prefix, so GNU Make closes
the jobserver file descriptors and rustc emits a jobserver warning that
fails the build under CONFIG_WERROR=3Dy.

[Severity: Medium]
In lib/vdso/check/elf.rs, inside get_data_subslice() (lines 87-96) and
SectionHeaderIterator::next() (lines 355-374), can get_data_subslice()
panic on out-of-bounds slices or on SHT_NOBITS sections?

get_data_subslice() checks start.checked_add(size) for integer overflow,
but then directly indexes &data[start..end] without checking end <=3D
data.len(), panicking instead of returning Err(ParseError::IndexOutOfRange)
when a section or header extends past the end of the file. In addition,
SectionHeaderIterator::next() unconditionally calls get_data_subslice() for
every section header using sh_offset and sh_size. Because SHT_NOBITS
sections (such as .bss) occupy no space in the file, their sh_offset +
sh_size can legitimately exceed file_data.len() and trigger a panic. Using
data.get(start..end).ok_or(ParseError::IndexOutOfRange) and passing a size
of 0 when sh_type =3D=3D bindings::SHT_NOBITS would avoid this.

[Severity: Medium]
In lib/vdso/check/elf.rs (SectionEntityIterator::new(), line 285) and
lib/vdso/check/vdsocheck.rs (main(), lines 134, 139, and 150), does this
fail to build on Rust 1.85.x and 1.86.x?

The minimum supported Rust version in Documentation/process/changes.rst is
1.85.0, and KBUILD_HOSTRUSTFLAGS passes -Zallow-features=3D to disallow
unstable features in host tools. However, usize::is_multiple_of() in
SectionEntityIterator::new() and OsStr::display() on the OsString values in
main() were only stabilized in Rust 1.87.0, causing E0658 compilation
errors on older supported compilers.

[Severity: Medium]
In lib/vdso/check/vdsocheck.rs (validate_linked_dso(), lines 78-92), does
validate_linked_dso() reject linked vDSOs that contain only R_*_NONE
relocations?

As noted in the comment above cmd_vdso_check in lib/vdso/Makefile.include
and in commit aff69273af61 ("vdso: Improve cmd_vdso_check to check all
dynamic relocations"), some GNU ld ports emit trailing R_*_NONE (type 0)
dynamic relocations in .rel.dyn or .rela.dyn, which the readelf fallback
explicitly filters out. validate_linked_dso() rejects any SHT_REL or
SHT_RELA section unconditionally without checking whether its entries are
all R_*_NONE.

[Severity: Low]
In lib/vdso/check/vdsocheck.rs (main(), lines 134, 139, and 150), should
these error messages use eprintln!() instead of println!()?

Silent kernel builds (make -s) redirect stdout of build commands to
/dev/null, so printing fatal errors to stdout hides the failure diagnostic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-vdso-absol=
ute-reloc-v6-0-161e218dd217@linutronix.de?part=3D1

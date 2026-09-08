Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78C395ADA;
	Tue,  8 Sep 2026 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849235; cv=none; b=N+gghTKEHLDJujAeyEjRLaIoRpgDPgEzBOHYxDoGIQ25RdIPtcSs02M7CXndb0oqqRHuuZAoJpW2phmOT86IzaLeHNUMMJM+YkZxaB/WqgmxkfCgN8UUEWBmZs1B8e6fkrocazo9SuFJTWpS1GP26tZCEIzGRFgnbRJbQoC/5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849235; c=relaxed/simple;
	bh=HrYSsshejm3MdwopK0QyrP0YNb7baHfULTYkmKafnyk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mEr0ORhe9u+2TM31VNLJqnVG1SMjeonQVBO2xQnqRcLTh6NOj381ToeCm9JUTRmo8NXiFlJ/Se49D5YZMc0Yp75Zn4JmI/BSA+hyfY/hh7jQAlqCg2JVtOBLtw4wFCPidTH1OQFEThf06EkJb3+v1fg6f6EB8oMV1CRLfJYtosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugOOuW9q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=An9/D7tx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugOOuW9q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="An9/D7tx"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cp0o8EDFYqgaI/CEiEvUg/mXT7EeRnDPR+/NOomvS88=;
	b=ugOOuW9qKhAU3jefF5rh08PT3vrE2IXdbueWnqZqCpmyV5bvOudbWlrbHjpeje1u8xgjfv
	AKlGo1M9CxgVkcWML1tdQGO/+Yr8wRNl4W1A12PQz3BNS1oUOkekAz+Ae2u3Y3gaWX6IOs
	JtboaftOyUindIxACXrEnFvSVVXEFw0jfPd2Zaq9Wtkkl+YHzfskypxnguHiNVMOQLXuwJ
	ChiyKIktCY98YbQi6nKlJ+gVx5YgpcujMOZYC1T+Yw0xzGUGXsCB76CVtAr/DucEjwjQ3A
	sF3OFbYIbiqCePh0eg5o0M79ii6HYcWDmcoD0jLFasuMbIDQ6s/LvL3pagYykA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cp0o8EDFYqgaI/CEiEvUg/mXT7EeRnDPR+/NOomvS88=;
	b=An9/D7tx9snxErbmaoktle4MclQvGq4BeA4eqME/OXmkgI1ozhe/GSz/tKB6Fu1fAZBtoW
	ktDVIIqBQgCerXCw==
Subject: [PATCH v5 00/24] vdso: Reject absolute relocations during build
Date: Tue, 08 Sep 2026 08:33:34 +0200
Message-Id: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Ny2rDMBCF4VcJWldFGl3dVd+jZKHLuBEYK0iOS
 Al+9yiBklK0/A/MNzdSsSSs5ONwIwVbqimvPdTbgYSTW7+RptibAAPFJFjaYs3U+ZqXy4a04JI
 DdQAaJhG40Zz0y3PBOV2f6tex9ynVLZef55PGH+uvNw29ximjkzWOuTly5tXnktbLVvKaru8Ry
 cNs8McRbOxAdxTOIQgfpAc9csTL0ZyPHdEdaexkohHGSj9y5MuxHMaO7I7mznrNFSoM/5193+9
 FRYP1kgEAAA==
X-Change-ID: 20250428-vdso-absolute-reloc-a226293c1761
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
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
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Christophe Leroy <chleroy@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=5051;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HrYSsshejm3MdwopK0QyrP0YNb7baHfULTYkmKafnyk=;
 b=6vZ688HbgWJhdTRQDorQBzK+M44QpmiNq6teG+NERQLRF70axqHuYGFGpQXkaBAwsvu/byckc
 GVjxkQ/ryyNA0SOqbZDiyxRuUih42hmJ5lsZUQGQM/E4vA20m25CVaf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The compiler can emit absolute relocations in vDSO code,
which are invalid in vDSO code.
Detect them at compile-time.

libc elf.h is missing some of the relocation constants,
so make use of the kernels own UAPI headers instead.

Patches 13 onward contain the architecture specific changes,
interesting for the architecture maintaines.

Kbuild and Rust folks: This contains custom definitions of hostprog
bindgen and rust library commands.
These are currently only defined inside the subsystem directory.
Let me know if they should go into scripts/Makefile.host.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v5:
- Rebase on v7.3-rc1
- s/HOSTRUSTLIB/HOSTRUSTC L/
- Pick up review tags.
- Also handle SPARC.
- Build 'vdsocheck' during the prepare phase.
- Drop now unnecessary riscv LTO preparation patches.
- Link to v4: https://lore.kernel.org/r/20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de

Changes in v4:
- Replace the inline shell logic with a dedicated build-time tool
- Link to v3: https://lore.kernel.org/r/20250611-vdso-absolute-reloc-v3-0-47897d73784b@linutronix.de

Changes in v3:
- Drop already applied bugfix for arm64
- Disable LTO for the riscv vDSO, as it is incompatible
- Link to v2: https://lore.kernel.org/r/20250430-vdso-absolute-reloc-v2-0-5efcc3bc4b26@linutronix.de

Changes in v2:
- Link to openend (invalid) GCC bug containing more explanations
- Refine commit messages
- Don't fail on commit absolute relocations in debug info
- Link to v1: https://lore.kernel.org/r/20250429-vdso-absolute-reloc-v1-0-987a0afd10b5@linutronix.de

---
Thomas Weißschuh (24):
      elf, uapi: Add a header for relocation constants
      x86/elf, um/x86/elf: Move relocation constants to UAPI
      ARM: elf: Move relocation constants to UAPI
      arm64: elf: Move relocation constants to UAPI
      powerpc/elf: Move relocation constants to UAPI
      riscv: elf: Move relocation constants to UAPI
      LoongArch: Move relocation constants to UAPI
      s390/elf: Move relocation constants to UAPI
      MIPS: ELF: Move relocation constants to UAPI
      sparc: elf: Move relocation constants to UAPI
      tools headers UAPI: Sync ELF headers with the kernel sources
      vdso: Add the vdsocheck tool
      x86/vdso: Enable the vdsocheck tool
      ARM: vdso: Enable the vdsocheck tool
      arm64: vdso: Enable the vdsocheck tool
      powerpc/elf: Add 32-bit REL16 relocation definitions
      powerpc/vdso: Enable the vdsocheck tool
      riscv: vdso: Enable the vdsocheck tool
      LoongArch: vDSO: Enable the vdsocheck tool
      s390/vdso: Enable the vdsocheck tool
      MIPS: ELF: Add more PC-relative relocation definitions
      MIPS: vdso: Enable the vdsocheck tool
      sparc: vdso: Enable the vdsocheck tool
      vDSO: Automatically enable VDSO_CHECK

 Makefile                                    |  19 +
 arch/arm/include/asm/elf.h                  |  24 -
 arch/arm/vdso/Makefile                      |   4 +-
 arch/arm64/include/asm/elf.h                |  55 ---
 arch/arm64/kernel/vdso/Makefile             |   4 +-
 arch/loongarch/include/asm/elf.h            | 130 -----
 arch/loongarch/vdso/Makefile                |   4 +-
 arch/mips/include/asm/elf.h                 |  55 ---
 arch/mips/vdso/Makefile                     |   8 +-
 arch/powerpc/include/uapi/asm/elf.h         | 201 --------
 arch/powerpc/kernel/vdso/Makefile           |   4 +-
 arch/riscv/include/uapi/asm/elf.h           |  66 ---
 arch/riscv/kernel/vdso/Makefile             |   4 +-
 arch/s390/include/asm/elf.h                 |  83 ----
 arch/s390/kernel/vdso/Makefile              |   4 +-
 arch/sparc/include/asm/elf_32.h             |  43 --
 arch/sparc/include/asm/elf_64.h             |  44 --
 arch/sparc/vdso/Makefile                    |   5 +-
 arch/x86/entry/vdso/common/Makefile.include |   2 +-
 arch/x86/include/asm/elf.h                  |  33 --
 arch/x86/um/asm/elf.h                       |  33 --
 include/uapi/linux/elf-r.h                  | 705 ++++++++++++++++++++++++++++
 include/uapi/linux/elf.h                    |   1 +
 lib/vdso/Kconfig                            |   7 +
 lib/vdso/Makefile                           |   2 +
 lib/vdso/Makefile.include                   |  14 +
 lib/vdso/check/.gitignore                   |   3 +
 lib/vdso/check/Makefile                     |  34 ++
 lib/vdso/check/elf.rs                       | 498 ++++++++++++++++++++
 lib/vdso/check/vdsocheck.rs                 | 299 ++++++++++++
 tools/include/uapi/linux/elf-em.h           |  71 +++
 tools/include/uapi/linux/elf-r.h            | 705 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/elf.h              | 112 ++++-
 33 files changed, 2479 insertions(+), 797 deletions(-)
---
base-commit: 2f737a133fad3808f9993f704fb27fd7791a0a41
change-id: 20250428-vdso-absolute-reloc-a226293c1761

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


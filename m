Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441881;
	b=kYV1kxE52Z+bqgRrRHsCMxPrrmWylKDpym5YbwyX9pOyU6Zl1za8CQe5DVC8mNyUyxV5
	 jaJvb24D1kQq9npq8Uy9lyj3LC2Z+dFm4Rdo9748gFg0KgyLHOlH86FLB7uR9qvoxYRFi
	 koPWCaW9Vvd6yDlb1x+m5FIeXArx95lRzUQKLO/dAwM/aBi31fRefpWfk7LGzPNBu5iAY
	 f/noHhD3JuSDRj3OD0qoJbDm5cz0gd09OYcyfZ/ITAkGcc/QBYX1k9SKhpuQFjb8COmZK
	 UhgDULclZ1lefKnDUUbXwD6YoO5QxGW6LdiqvVycoaoXlb7Q5KYLuvcAZeHwbp1tAxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441881;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:
	 X-Developer-Key;
	bh=eDaWEGVSberGT3lup7BUtg92+nPcoIl/POEYu2Hk/qs=;
	b=MxPfkibIl8G3RBe2neDrV/CmPvTg1kPL8yuJEKLNhswRnIqs7egor9mp/EWnsOrBqh7q
	 7vGViko4FszhM7Is4jWhmcXPdbr1dYT2aCgxIDTUe+jGoSG132FUCqV843GuT3oVcdt/j
	 3z7Z3dyh+dufcFq0fK+qtIrqdhD6US72T69DTO59EAWrAt0IFC5Xc01a0ESIuE/tncL9o
	 NeQYNZ+dUMs/rNcUkb+nyIVcGSrDu0NVfZtu3y1EZAeLxZop0wk756YbH2ucQjO6+8MLe
	 3zr0+AqF/ZZjQRreDVTe4V03MyIRxEgoMdGNZUJdHz+F9WKyljlux+375jKotEcK0pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dhUms7oH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SZJ7c1JZ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6939B606A31A;
	Mon, 23 Nov 2026 13:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6939B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dhUms7oH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SZJ7c1JZ
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795441877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eDaWEGVSberGT3lup7BUtg92+nPcoIl/POEYu2Hk/qs=;
	b=dhUms7oHgMAyTwjaFQ4RcmHZy3AcRiYZGHrtxzyko2OKJq9ppnxdmoYRgjmCHmDl72nUPK
	L/7fYN96Dq/EWTGaIbc6mSLcy31gm1eTfI4kwupFpFPjC112yyZkM8ESt8bMlcCF8FmAER
	KmEK8t92o7JvwtqkOPsvSFKiP0dHe4+qaQz5h0vFdUIKKWIuL0I9ZQNNlUKxBIx2c7YsVt
	9wFwFcCd8I9ee05oaCZWhsyhqcXGDWdhcn0TprHoLVGNWll7eYv0kGf1d15Xde8wEa17I2
	nVKIeHL9cL2tRun1gCxK7pNUw/9eoEPay1jdaqJRmlkyRrC7OYH3x68J6Bc0fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795441877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eDaWEGVSberGT3lup7BUtg92+nPcoIl/POEYu2Hk/qs=;
	b=SZJ7c1JZEJleqouSHibtjvawagbQZiztXnKad+RaVrzqS2CEbt3LfVh0aVKUf8rCz1vARk
	veQbOsz5bF+5U/DA==
Subject: [PATCH v6 00/11] vdso: Reject absolute relocations during build
Date: Mon, 23 Nov 2026 14:50:51 +0100
Message-Id: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QzWoDIRDA8VcJnmtx/LanvkfJQd3ZRljWohtJC
 PvuNYGQUjz+B+Y3MDdSsSSs5ONwIwVbqimvPfTbgcSTX7+Rpqk34YwrJrmlbaqZ+lDzct6QFlx
 ypJ5zzZ2IYDSQvvlTcE6Xh/p17H1Kdcvl+jjS4D59em7oNaCMOms88/MELKjPJa3nreQ1Xd4nJ
 Hez8T+OYGOHd0fhHKMIUQauR454ORpg7IjuSGOdmYwwVoaRI1+OBT52ZHc0eBs0KFQYR456Opo
 5Nv53U90R3gnjwM8Q5//Ovu+/Goaqs9oBAAA=
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
 Peter Zijlstra <peterz@infradead.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795441872; l=3723;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=838wXNltovAdYq5DnbIAatCSo/HDl9G1xi3tlTew/l4=;
 b=JGW/t5g7XakafXkEmZgN47zuaZVRMd5P5Z1iLiNybaoBHrfSDWqN9ASPR8Bxcs9mW00guv58q
 XTXxW/DfNA2DS7eGKT7s34DDNPA2BkV8xQIeN4+3mlNlEP2jFFXWeWs
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The compiler can emit absolute relocations in vDSO code,
which are invalid in vDSO code.
Detect them at compile-time.

The tool is written in Rust. However this does *not* introduce a Rust
dependency for kernel builds with CONFIG_RUST=n. If no Rust toolchain is
available, the new comprehensive check is skipped automatically.

libc elf.h is missing some of the relocation constants,
so hardcode the magic numbers instead.

Kbuild and Rust folks: This contains custom definitions of hostprog
bindgen and rust library commands.
These are currently only defined inside the subsystem directory.
Let me know if they should go into scripts/Makefile.host.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v6:
- Drop all UAPI header changes, hardcode relocation numbers instead.
- Add note about Rust *non*-dependency to cover letter.
- Link to v5: https://patch.msgid.link/20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de

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
Thomas Weißschuh (11):
      vdso: Add the vdsocheck tool
      x86/vdso: Enable the vdsocheck tool
      ARM: vdso: Enable the vdsocheck tool
      arm64: vdso: Enable the vdsocheck tool
      powerpc/vdso: Enable the vdsocheck tool
      riscv: vdso: Enable the vdsocheck tool
      LoongArch: vDSO: Enable the vdsocheck tool
      s390/vdso: Enable the vdsocheck tool
      MIPS: vdso: Enable the vdsocheck tool
      sparc: vdso: Enable the vdsocheck tool
      vDSO: Automatically enable VDSO_CHECK

 Makefile                                    |  19 ++
 arch/arm/vdso/Makefile                      |   4 +-
 arch/arm64/kernel/vdso/Makefile             |   4 +-
 arch/loongarch/vdso/Makefile                |   4 +-
 arch/mips/vdso/Makefile                     |   8 +-
 arch/powerpc/kernel/vdso/Makefile           |   4 +-
 arch/riscv/kernel/vdso/Makefile             |   4 +-
 arch/s390/kernel/vdso/Makefile              |   4 +-
 arch/sparc/vdso/Makefile                    |   5 +-
 arch/x86/entry/vdso/common/Makefile.include |   2 +-
 lib/vdso/Kconfig                            |   7 +
 lib/vdso/Makefile                           |   2 +
 lib/vdso/Makefile.include                   |  14 +
 lib/vdso/check/.gitignore                   |   3 +
 lib/vdso/check/Makefile                     |  34 ++
 lib/vdso/check/elf.rs                       | 498 ++++++++++++++++++++++++++++
 lib/vdso/check/vdsocheck.rs                 | 299 +++++++++++++++++
 17 files changed, 896 insertions(+), 19 deletions(-)
---
base-commit: 0e2fcd5208a4bbe53419a0e4359df3a614135649
change-id: 20250428-vdso-absolute-reloc-a226293c1761

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920423B637A;
	Tue,  8 Sep 2026 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849248; cv=none; b=aplsbK5wg0u3kbbDkxBg5+c+voAy5L2EDp9JmoYse5nxa4A9/FdjTgdA/iSfRvWU0PW7rIDYJ3tyKosl9KSZ287NtVrHJxoINaTgHn4dHZIogom8aAI1mjbFHk2VYbkBeEhbZDVwrlP411Dw6eRxsrW86qTbeneFznJrq6pcUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849248; c=relaxed/simple;
	bh=rB4eegSBfTJvyEpPR1AwSf8HHKeuiOU4EBXL8/NjovM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hRmLQfR8Mtfk8ekBP/iAovfU+VewjnJrVUdx74RdSunA2qlRV7gCNUJTXBubnJVM/83ZGBSQdi6e8o0dBwwUSq3r9ml2aIgnvv1COzbUw7NDQpRYeCJj3zG0MbHOBRsWcRN9BrJ4ZmYjH+7LGSYSJjyjFGF2I6rVQImYy+WPigc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hBTTSmMh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pnROhmeQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBTTSmMh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pnROhmeQ"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8S5zUcti2qRnvnqiwdZ99APOoLvCYmczAvcwW6T+78=;
	b=hBTTSmMhDdM2I6kdqJpAUOIrF69Iua1sqGHZrZEeJV+RrcDKO3Lh6TsXgdenOxFOnA4PoA
	412uPFiR4UGcIb6zo/ixzKsRV5LZO72namgWFB+cnr4EH1Utd/VSj8gvUK8F63ekFmUhqH
	e4ILH1GjbVqWGvLNLwK9XP+4Ygy6HN0YUB9kGB3oz57J5JzxQBb26TeNDe+cNb6xv87TOy
	Z4jMkBFqsKI4y45ukbIyST/V0/zEwljrr2NXcntK+uBr0cM363V1w55zye9RhNq6wnigOn
	7fYPjipzEFO17Oeq+ED1P9qQWrEtAGBcvP+xMvJvi49Am978rgJgX00l+QbCZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8S5zUcti2qRnvnqiwdZ99APOoLvCYmczAvcwW6T+78=;
	b=pnROhmeQiS3cU0albwBwH9dlRL1TxZa9HToYE3xYcsDLiQflLOIHiW/vhhcx0oenTo2D8f
	TUqAyVRELIZVMCDg==
Date: Tue, 08 Sep 2026 08:33:52 +0200
Subject: [PATCH v5 18/24] riscv: vdso: Enable the vdsocheck tool
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-18-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=3596;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rB4eegSBfTJvyEpPR1AwSf8HHKeuiOU4EBXL8/NjovM=;
 b=ckjkIaN/2GD1n4ZD/6VNQXvUS4c8EPXkV5wm26xnc8Ipzseks5mvPh9EdV3eGaQ2tZQZNlGho
 JgbUjoNJu6vBrX5nqStpT8ES8eXNkaNjgeSRWwJDzlvAf1sCbw19+8k
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vdsocheck tool validates the object files and final .so library.
It can detect if the compiler created relocations which are incompatible
with the vDSO which need to be worked around.

Wire it up for the architecture.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/kernel/vdso/Makefile |  4 ++--
 lib/vdso/check/vdsocheck.rs     | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f8e26c4bed2b..f580d2afecf7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -229,6 +229,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
+	select VDSO_CHECK if MMU
 	select VDSO_DATASTORE if MMU
 	select VDSO_GETRANDOM if MMU && 64BIT
 	select USER_STACKTRACE_SUPPORT
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 8dbf2532a573..7e707fdff26c 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -74,7 +74,7 @@ endif
 $(obj)/$(vdso_o): $(obj)/$(vdso_so)
 
 # link rule for the .so file, .lds has to be first
-$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) FORCE
+$(obj)/$(vdso_so_dbg): $(obj)/$(vdso_lds) $(obj-vdso) $(vdsocheck) FORCE
 	$(call if_changed,vdsold_and_check)
 LDFLAGS_$(vdso_so_dbg) = -shared -soname=linux-vdso.so.1 \
 	--build-id=sha1 --eh-frame-hdr
@@ -96,7 +96,7 @@ include/generated/$(vdso_offsets): $(obj)/$(vdso_so_dbg) FORCE
 # The DSO images are built using a special linker script
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdsold_and_check = VDSOLD  $@
-      cmd_vdsold_and_check = $(LD) $(CFI_FULL) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
+      cmd_vdsold_and_check = $(LD) $(CFI_FULL) $(ld_flags) -T $(filter-out FORCE $(vdsocheck),$^) -o $@.tmp && \
                    $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
                    rm $@.tmp && \
                    $(cmd_vdso_check)
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 429bdcd65818..67562d21f877 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -96,6 +96,32 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_RISCV => AllowedRelocations {
+            in_object_file: &[
+                bindings::R_RISCV_BRANCH,
+                bindings::R_RISCV_JAL,
+                bindings::R_RISCV_CALL,
+                bindings::R_RISCV_CALL_PLT,
+                bindings::R_RISCV_PCREL_HI20,
+                bindings::R_RISCV_PCREL_LO12_I,
+                bindings::R_RISCV_PCREL_LO12_S,
+                bindings::R_RISCV_ADD8,
+                bindings::R_RISCV_ADD16,
+                bindings::R_RISCV_ADD32,
+                bindings::R_RISCV_ADD64,
+                bindings::R_RISCV_SUB8,
+                bindings::R_RISCV_SUB16,
+                bindings::R_RISCV_SUB32,
+                bindings::R_RISCV_SUB64,
+                bindings::R_RISCV_ALIGN,
+                bindings::R_RISCV_RVC_BRANCH,
+                bindings::R_RISCV_RVC_JUMP,
+                bindings::R_RISCV_RELAX,
+                bindings::R_RISCV_32_PCREL,
+            ],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.55.0


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587173B961A;
	Tue,  8 Sep 2026 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849247; cv=none; b=GIMqRsIRKbEotYeR4UZvK3RTwxtTNSg2TMGRApjOis7y7UWjQTUsdqBbDD3vqLJEzsEErLIcTcIIidRoVWPEVHtSSYXquxZcOPhIlbFwDQxuFLOoyazg79B10FIMccWOWDeojz1J0HsZ43lTAvzZBLdrz8hvEEEah30vDliTLXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849247; c=relaxed/simple;
	bh=aHlYdAt+sn8SQz3z94dI4KWuFSXUUjVIfd41CT6XtAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lp7J8DerXqZc+0iEgX65LkzjYFLCzctHLWegKWC1ehnxyVBGX+OzPQDLZ7MNGaeUyB6G76ZjwUnEFzfkUNC/El+laGloUwrBf4gSsHsxRh44RYApPhYSyl7bbDBi638mQXeEefOQXsxnEA0+6/FHjd9BGaJmc3XeDe3my0F4pgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UQTMG5iO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7PR/0nIH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQTMG5iO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7PR/0nIH"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VIHtJxBKUV92ut5bUWYer42zzkTydvuwzOnHSs3Yeo=;
	b=UQTMG5iOQDvZsY4LSnJHyDsgt5WxYxOz6YK1J4hyy8PpdVm7HY/Y/mh6cvKrE7NVsFt+Nb
	5PHfF7NPgespT0taUkdG+2zsqwIaJCOc5lenErzQr2gJGmGCKDfglspuNebAKUicWnsEu/
	OgGtj7CqD3bcw77a8A5zUcMAVDpAYTrT40KMbS3vw/PGpc+2sK3wf2Nyn++rSXvk/89a/O
	dLBhqKZQpE19fpuoHY99u/fCxlDvRu6/J5A/dqsFfx74MtXtIoiuRmDCbLQFhLUUkESDb1
	xO22aa0FVTkzJtC0FgFtMHHa1CD0BMXsnGpP3cYNg8YMYtTrbp5jheTjAu2qTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VIHtJxBKUV92ut5bUWYer42zzkTydvuwzOnHSs3Yeo=;
	b=7PR/0nIH3jxM0NAu2RQ8Kza6MygB9kI69pTDRsPAwhdPDsSecImgz/0fj3o3HpGROjRbDh
	NRUyYikC3ZoRAoCQ==
Date: Tue, 08 Sep 2026 08:33:53 +0200
Subject: [PATCH v5 19/24] LoongArch: vDSO: Enable the vdsocheck tool
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-19-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=3278;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aHlYdAt+sn8SQz3z94dI4KWuFSXUUjVIfd41CT6XtAE=;
 b=2232qTauQU8ONuo72eWzPcWTOr/o5ANqNg5FnqG48nJxB/0T5MRVqjL9ipbJ1nOF+cXFluD1a
 gXrQgZJJqvQDq3tjn71NRUZG05NIlhIDdmmjTh/MawpE3ZVvYw59mEQ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vdsocheck tool validates the object files and final .so library.
It can detect if the compiler created relocations which are incompatible
with the vDSO which need to be worked around.

Wire it up for the architecture.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/Kconfig       |  1 +
 arch/loongarch/vdso/Makefile |  4 ++--
 lib/vdso/check/vdsocheck.rs  | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a21f51e5815e..5dc98a4b9c7f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -213,6 +213,7 @@ config LOONGARCH
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
 	select USER_STACKTRACE_SUPPORT
+	select VDSO_CHECK
 	select VDSO_DATASTORE
 	select VDSO_GETRANDOM
 	select ZONE_DMA32 if 64BIT
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 9c9181bb4071..b0dc58328664 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -50,7 +50,7 @@ ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
 #
 
 quiet_cmd_vdsold_and_vdso_check = LD      $@
-      cmd_vdsold_and_vdso_check = $(cmd_ld); $(cmd_vdso_check)
+      cmd_vdsold_and_vdso_check = $(cmd_ld_vdso); $(cmd_vdso_check)
 
 quiet_cmd_vdsoas_o_S = AS       $@
       cmd_vdsoas_o_S = $(CC) $(a_flags) -c -o $@ $<
@@ -79,7 +79,7 @@ $(obj-vdso): KBUILD_AFLAGS := $(aflags-vdso) $(native-abi)
 
 $(obj)/vdso.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) $(native-abi)
 
-$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) $(vdsocheck) FORCE
 	$(call if_changed,vdsold_and_vdso_check)
 
 $(obj)/vdso.so: OBJCOPYFLAGS := -S
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index 67562d21f877..4aeb7094e552 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -122,6 +122,32 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_LOONGARCH => AllowedRelocations {
+            in_object_file: &[
+                bindings::R_LARCH_ADD8,
+                bindings::R_LARCH_ADD16,
+                bindings::R_LARCH_ADD24,
+                bindings::R_LARCH_ADD32,
+                bindings::R_LARCH_ADD64,
+                bindings::R_LARCH_SUB8,
+                bindings::R_LARCH_SUB16,
+                bindings::R_LARCH_SUB24,
+                bindings::R_LARCH_SUB32,
+                bindings::R_LARCH_SUB64,
+                bindings::R_LARCH_B16,
+                bindings::R_LARCH_B21,
+                bindings::R_LARCH_B26,
+                bindings::R_LARCH_PCALA_HI20,
+                bindings::R_LARCH_PCALA_LO12,
+                bindings::R_LARCH_PCALA64_LO20,
+                bindings::R_LARCH_PCALA64_HI12,
+                bindings::R_LARCH_32_PCREL,
+                bindings::R_LARCH_PCADD_HI20,
+                bindings::R_LARCH_PCADD_LO12,
+            ],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.55.0


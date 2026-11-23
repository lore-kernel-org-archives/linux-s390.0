Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441884;
	b=kU839MMV4eys/XaDUORf1DB5/eoPSc8dMUWiR+P7qcwavYpf6uHqrP0mMpB6+dkVzuoe
	 UrSfSBsDbZBbJGyavHYa4YkqN3sFtAS2DbPhGcn9i6LPkeA1r4C+yIHaAV9DRfusyYf1h
	 Dj0wlc8JkaTOBxXgLSFUKHxV2kDuqjPp8VuS35j84fkwMn/fWQdEF5z/PBLW8XyiAuBaH
	 bp4dZiqTocZUJMpVZ8CmBFnWEPR/EjGoM0ztU6Ah2YVwjoG8PQZcyB7DO4ohBqFKRQ4wo
	 xQMh22b8hLvoIV9JjSg5YUoUpmwsrftfq5nJ1Ji8irBhzUsXOTPOQ0dCaDobU1U1rCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441884;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=Guhg1K0FMFBPE0u0CIJl3O+ZgtOjrn7cr+GEqqxWqko=;
	b=j04+4wsZWelRDRDC5S+bAAx2CEQctfHrYsGhgMb0p8pgHCUFRgxu7ghIJ3EvksUKthe4
	 253g8PzD49cxfpfWlvU+0CUCme+NldfFAvmwrALIg8s9utW09RDFIJko6gpJ08hfNz15C
	 FKvbmFH2bY73m4+mrN+iHRblpjpENan4crDoHsauGVnm9WSilQLB8ajuaiH2CS2m/rOIz
	 /MV2MlUG3UpNoMLESYYhN8fCLepFpgrQF7tH+7MXE/ulRgiSS7EGwQ1eMSVr/UjmFlB6K
	 Fe3IhDe73R3cASD/3K3ZZ4xbsebLVighkxheOIF9rimgN1O6m8iE4yeiI4TDljQLW+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=NuQxcyBf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Ee7e9mzF;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB01606A6A7;
	Mon, 23 Nov 2026 13:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FB01606A6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=NuQxcyBf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Ee7e9mzF
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795441881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Guhg1K0FMFBPE0u0CIJl3O+ZgtOjrn7cr+GEqqxWqko=;
	b=NuQxcyBfhV7EAPhhJJ0IrWwI8Sg6agHEvml/ui+39lfH4IvCvHOhVb3sTcEszxrptDYhzM
	KOTWGp0s724CoC63fsCVglfZK3pNCVB8Dpc4O3J+oZJetwugA7rRVDeJweiqPTc8fFxGvo
	RmhJHmEu3rwm40c8zSLI4bxEI1qi65sJ8cASKE5pWCVY38ce3oB6mbJaStD5r9bHbVd18/
	R42vVr0ltwptVz13BPAw5JmRofzhPG5tYJKVGp3gS5RHItjXpfpb6NKiTXVnBsh/nC0c3b
	8kgM8WRRit79N6lKDO5GVLdWFOxuL3Rdld+lG35LGAQjhk+TpvfZuqpuvy+zig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795441881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Guhg1K0FMFBPE0u0CIJl3O+ZgtOjrn7cr+GEqqxWqko=;
	b=Ee7e9mzFD85deKLGcm8e5YD0L+U1o17HaFbybIhTLTjFkWWkRB4gFePrbUFQEhupkaPgbn
	0vbj4CqmhgO4CrAg==
Date: Mon, 23 Nov 2026 14:50:55 +0100
Subject: [PATCH v6 04/11] arm64: vdso: Enable the vdsocheck tool
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
Message-Id: <20261123-vdso-absolute-reloc-v6-4-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
In-Reply-To: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795441872; l=2617;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ORz4l21C1iPuk7FCAsvH2byEFW0UweMz0824cCTy53M=;
 b=q7DXOLJiNCyz2OBeq2mHIOnoqJ70WoExeUnEefxSG/lSMIqTsqHDcIrncJ9VEiIXA1Umw12+U
 OOQlmf3HB4zBZUGjar3eMCLr8sFDPZAeV+wIvbVyQBy37Hse7yPcaaY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vdsocheck tool validates the object files and final .so library.
It can detect if the compiler created relocations which are incompatible
with the vDSO which need to be worked around.

Wire it up for the architecture.

The compat vDSO will be handled by the existing 32-bit ARM configuration.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/Kconfig              |  1 +
 arch/arm64/kernel/vdso/Makefile |  4 ++--
 lib/vdso/check/vdsocheck.rs     | 12 ++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1075bc661833..df22b4ed5e29 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -258,6 +258,7 @@ config ARM64
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select USER_STACKTRACE_SUPPORT
+	select VDSO_CHECK
 	select VDSO_GETRANDOM
 	select VMAP_STACK
 	help
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index f6619e1cb2ce..5d8c34c7be51 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -61,7 +61,7 @@ targets += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
 # Link rule for the .so file, .lds has to be first
-$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) $(vdsocheck) FORCE
 	$(call if_changed,vdsold_and_vdso_check)
 
 # Strip rule for the .so file
@@ -79,4 +79,4 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 
 # Actual build commands
 quiet_cmd_vdsold_and_vdso_check = LD      $@
-      cmd_vdsold_and_vdso_check = $(cmd_ld); $(cmd_vdso_check)
+      cmd_vdsold_and_vdso_check = $(cmd_ld_vdso); $(cmd_vdso_check)
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index e28ee59a900d..0d5ceaca34d7 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -57,6 +57,18 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
             ..Default::default()
         }
         .into(),
+        bindings::EM_AARCH64 => AllowedRelocations {
+            in_object_file: &[
+                260, /* R_AARCH64_PREL64 */
+                261, /* R_AARCH64_PREL32 */
+                262, /* R_AARCH64_PREL16 */
+                273, /* R_AARCH64_LD_PREL_LO19 */
+                274, /* R_AARCH64_ADR_PREL_LO21 */
+                283, /* R_AARCH64_CALL26 */
+            ],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.56.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441882;
	b=2tP8dU4HeuukSxSIjV4e9KA66wPOhsTJ6j8Rb9z9Ygm8jjBAWL8EBF88nQF06ItSDjk1
	 m1uVLOR0uHhy9XU6Quh8mooT0Xhs96rWPvjcWSNqvr8dmJJ8xnGMysBmHLf6jX6oGq8PC
	 j3E8k8a1Xnmmn10d2HepoKxV2qgUs/umq0Ik1ZEMjE2U06aMFFWUHiqNOQuLL9ZVG38dy
	 btlxzb+SamOEPjc7LKVEquEj5xQhD7K/vvouPaS+/Xw0G4r7oCISBfkAP6P5z+4Y93+2q
	 1F1NLhx/RF8dsywrC7nYrYNPHSsxtYsJECcjg2q2tCJN8r7CHBYz9rkTGkIzbre8mwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441882;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=9c4YRQQ6pnzSBpHUo5gQq1+MNXBhFp0V4WLQqxvRU3w=;
	b=xIxVnXKtFEdSWKmzO/r3QQhXh3TwD4GHS56su3awd8ixeMbNB0cvlhkULdBqtv309/t8
	 VhC559O4NCM73ongakJuMLLY/14D0bjsHAC/BQsll5wtAtw+PJ8gWB1CGLkfiMwALjqEv
	 CzoYRYsH4KDHW/Pyc2xRUAN5k/UdEAbLiBFe00zY9nd+e5G+uqoiHdm4mymrc36Wyxxqv
	 1Z82xW3ESrg7vRO/wAzjBG9D4yCzOgfkNbS9Rq/+5V8S2iEvkHV/9furmGTP14L72GuHG
	 XB+gLfsbCmczXcM26Q+HSvpEAODwSJdvQToOD2uf/+cVSSWtqzgM2rXqpw/U7FxT86Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=c51R8ppc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=yQt064qw;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C49606A331;
	Mon, 23 Nov 2026 13:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C49606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=c51R8ppc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=yQt064qw
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795441879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9c4YRQQ6pnzSBpHUo5gQq1+MNXBhFp0V4WLQqxvRU3w=;
	b=c51R8ppcFvgF+lecaj/yMlPRqDjEJqCxkHivVfbfMQYdSfZe4M6c4s4DoB+NYtz7vO+Y1t
	zZOi7noMVQNksc1y//WWdcFqSuEJJ5VrMKnXxTPR5jbhVw16t+8ig0vz2qxTFGsx97LlEV
	7Uxe5/+6DmvvvdKnLhZ5hkReO6ryCa6YDLcA6hFwgtuHyUBzoOOf8ceeoNaqPaklx7PIyF
	P7gF2nVtFX8AGncfEJvHENxFQOf+VcI4sDu8GW+0V/oxaZLjGmJxyoSPUsV/ExJ5sbdp1d
	ZKG7YGmqcArtssE05wbISs4JnXpKGfVfz5XJo+/b5IbUn7BR+NLokBi2wh91QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795441879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9c4YRQQ6pnzSBpHUo5gQq1+MNXBhFp0V4WLQqxvRU3w=;
	b=yQt064qwYnbu3hJCbzrs1LSu9wJF9vC0+skGBQRPBjGzvIEoRyyX+E0474vs7Sqd4TUE6E
	XDQAx4LTWCyhrtCA==
Date: Mon, 23 Nov 2026 14:50:53 +0100
Subject: [PATCH v6 02/11] x86/vdso: Enable the vdsocheck tool
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
Message-Id: <20261123-vdso-absolute-reloc-v6-2-161e218dd217@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795441872; l=2480;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QoUIl45MXZMRNJ380RzxrALVLspll1WbUT4Y7wjP5Nc=;
 b=h6xhrNJ/daWsX6d0KucIl1wYohqmJySrJ2C1jkqbSYPKJvt4SX6MThWjG3AJ53+HBHR3/pKpF
 7soB51VQ7nVDYQrnRCfrdx/gAbVU1MOH1o8b4GwEdR9wgqoPiEeBzvq
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vdsocheck tool validates the object files and final .so library.
It can detect if the compiler created relocations which are incompatible
with the vDSO which need to be worked around.

Wire it up for the architecture.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/Kconfig                            |  1 +
 arch/x86/entry/vdso/common/Makefile.include |  2 +-
 lib/vdso/check/vdsocheck.rs                 | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dce0b66179..09d3aa04ee82 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -302,6 +302,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
+	select VDSO_CHECK
 	select VDSO_GETRANDOM			if X86_64
 	select HOTPLUG_PARALLEL			if SMP && X86_64
 	select HOTPLUG_SMT			if SMP
diff --git a/arch/x86/entry/vdso/common/Makefile.include b/arch/x86/entry/vdso/common/Makefile.include
index 687b3d89b40d..510d5e79857e 100644
--- a/arch/x86/entry/vdso/common/Makefile.include
+++ b/arch/x86/entry/vdso/common/Makefile.include
@@ -71,7 +71,7 @@ quiet_cmd_vdso = VDSO    $@
 quiet_cmd_vdso_and_check = VDSO    $@
       cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
 
-$(obj)/vdso%.so.dbg: $(obj)/vdso%.lds FORCE
+$(obj)/vdso%.so.dbg: $(obj)/vdso%.lds $(vdsocheck) FORCE
 	$(call if_changed,vdso_and_check)
 
 $(obj)/%.so: OBJCOPYFLAGS := -S --remove-section __ex_table
diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
index f4c0730bc976..8cd8c7f3fec8 100644
--- a/lib/vdso/check/vdsocheck.rs
+++ b/lib/vdso/check/vdsocheck.rs
@@ -34,6 +34,20 @@ fn is_ignored_section(&self, section: &elf::Section<'_>) -> bool {
 
 fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'static>> {
     match machine as u32 {
+        bindings::EM_386 => AllowedRelocations {
+            in_object_file: &[
+                2,  /* R_386_PC32 */
+                9,  /* R_386_GOTOFF */
+                10, /* R_386_GOTPC */
+            ],
+            ..Default::default()
+        }
+        .into(),
+        bindings::EM_X86_64 => AllowedRelocations {
+            in_object_file: &[2 /* R_X86_64_PC32 */, 4 /* R_X86_64_PLT32 */],
+            ..Default::default()
+        }
+        .into(),
         _ => None,
     }
 }

-- 
2.56.1


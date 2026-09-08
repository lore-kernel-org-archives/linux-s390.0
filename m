Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F93B4E9A;
	Tue,  8 Sep 2026 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849244; cv=none; b=pKtOVOWLsNc1oBo7Qv7y7x3DXJVYxtMeIIOfelgUSDuqVBhJvoUogx6TITL3josPKdAQYbFncvEvQ+Zy7zuqgM5VNZ7hsbvVNrddQYsbwEqxKBuQr85kYY9lNLIM9RhuLTVIMS83OW7Idcx10doJm2IiPza5r9L1+zhdPGclx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849244; c=relaxed/simple;
	bh=gDavw4WAqw6o13GhA3u/II77o40pPBvpHsDECXNhldY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQlJsO7tsqDkygWaZ86zGfWV3vGcWIOPBWft0vbWdlSshkqNI9n/3DS4nmx/DfsywXz22GvwtE+wrCQAzk4GVw13GOpJOgt8NxgsLawmP+MI4137bKypGkpDtawOUBt4OMV//ypSDcSMftRKwODSGq6jCKxPbsiOpRG+capnNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srXUKKBv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rW7/VoVl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srXUKKBv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rW7/VoVl"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pdi6tJcXia5GQvjWLdDYxiQ6I89enT2mzL46ZqnmdMg=;
	b=srXUKKBvBnZWl7h+1tvBv5e+AlKq5znw4KLWobhNXWNfQAuYkrwrf6qLr9sX3I376tXpaL
	0gCLK9hvRcYej1aY+vuLNUXX8k0WaaNjh/gf2Si2JH/haTjazZxULX0a5f7Yw140D5KgYT
	mY6i1JDe2y9ffdmhX61Pp10Gxy+SfEXQxM2EnqvziywLYsrgXQI8aTTmQXJNqF3Wlg/vEp
	0gaYbr4thtj8q00nsmFu9BsDc1syHcFh5c6rh+d3Wwq5S09FzqW3vh3uH+fdVp1FSM314K
	eg0gs4ury6AuRJrLxdmHGTOamuoIr50Pr/4C3keU04Rznfn+4zwCC+V/Fh4gkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pdi6tJcXia5GQvjWLdDYxiQ6I89enT2mzL46ZqnmdMg=;
	b=rW7/VoVlTLF38Sp6NbEw24XpKKO0l53Bu8vFJSSAarrgsh5+3oOcPR3GCmN8eCmuxD/xDP
	pyuyJDO6nu5wCADA==
Date: Tue, 08 Sep 2026 08:33:50 +0200
Subject: [PATCH v5 16/24] powerpc/elf: Add 32-bit REL16 relocation
 definitions
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-16-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=1737;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gDavw4WAqw6o13GhA3u/II77o40pPBvpHsDECXNhldY=;
 b=at10aJs/4BEOnHQNfCkeHcofnKffueuw1V5jX3gearAcRNXGLUowN4VA80tWswO8yBV0CJAoU
 1lBC/PMHi3vDICsSQ0DEs5CGMsAX8t5/pR4/5NVDW4dQxNWMl/dsaZv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These are used by userspace and are necessary for the vdsocheck tool.
They share the numbers with their 64-bit variants.

Also update the copy in tools/ so they can be used by vdsocheck.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf-r.h       | 7 ++++++-
 tools/include/uapi/linux/elf-r.h | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 72fc9045a5d4..170888422400 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -182,8 +182,13 @@
 #define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
 #define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
 
+#define R_PPC_REL16		249
+#define R_PPC_REL16_LO		250
+#define R_PPC_REL16_HI		251
+#define R_PPC_REL16_HA		252
+
 /* keep this the last entry. */
-#define R_PPC_NUM		95
+#define R_PPC_NUM		253
 
 /* PowerPC64 relocations defined by the ABIs */
 #define R_PPC64_NONE    R_PPC_NONE
diff --git a/tools/include/uapi/linux/elf-r.h b/tools/include/uapi/linux/elf-r.h
index 72fc9045a5d4..170888422400 100644
--- a/tools/include/uapi/linux/elf-r.h
+++ b/tools/include/uapi/linux/elf-r.h
@@ -182,8 +182,13 @@
 #define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
 #define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
 
+#define R_PPC_REL16		249
+#define R_PPC_REL16_LO		250
+#define R_PPC_REL16_HI		251
+#define R_PPC_REL16_HA		252
+
 /* keep this the last entry. */
-#define R_PPC_NUM		95
+#define R_PPC_NUM		253
 
 /* PowerPC64 relocations defined by the ABIs */
 #define R_PPC64_NONE    R_PPC_NONE

-- 
2.55.0


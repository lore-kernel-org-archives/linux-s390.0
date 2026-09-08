Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44853BC68E;
	Tue,  8 Sep 2026 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849251; cv=none; b=aBgWlIzNZgM74bpR7CbitEfmcglhsfE/1V76pny1pFIS1Bxt/MGmPt0piiPSimiVRPKr3eWt4SWASOuolh1rKCzp+xXHXlMiGcPi8GWgzLwO3nJTfcq2VyVvQ/RUeg0EY/MUCpMWc+bXDktXW7yGIQFvong8iJ8A9Hvamvv57DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849251; c=relaxed/simple;
	bh=R3oIxCvKReHS31AXFavRgNPui6/4omq3e3P+29cRTsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8TKe9FN/Yol56hyRAM03IMSD0Yu2Y7D44wL+Xq2If6oii33HDmewQFFWGwDdiyOrpUfVrihBDLnj9wM5PDyFPC2jCxfmFTy6BKYcotS9eeH6LWWOLuitlEQ3sYj2M31CVtSNd0CFQaZLE9umVjKLR5D2o2UN0bB4aNZtawLTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YMIoDXx/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wz8zdRK+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YMIoDXx/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wz8zdRK+"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788849239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpMeGTA/JL9YkhE8VitmDDEUz8BAqAeVVV3RUo7s8KM=;
	b=YMIoDXx/ryyJO/wNSJr79hBrk/1uKFLoRwuyXWq2ERwfWyVqyJffleMbiT+vvuWtO204/K
	XO3RmXGCnqV4w7lfkhlRudbX45mFtdRD41W9PJVoty/pqKiHswGZXTaKvmOaxPSu5VZJVM
	xxsp4AJePJ+ALKIQ/EeGwO+kVJXptZyvKlxH78jJhdZkeOrN+Ww5q1WKtNHcy76t1B+jzv
	XQRYBH9ansqx4KI/6zXA4pK/oLhRKj+aRYBHIq9E7X1UO0E3YCVRVTfZ6ee2DiCObTk4zf
	wtUuUCDZU7XTwecLf7y0KofwzMRjqZcFYKJ6viLp4DkuxsMmnK/jJKnBlUZEnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788849239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpMeGTA/JL9YkhE8VitmDDEUz8BAqAeVVV3RUo7s8KM=;
	b=Wz8zdRK+ls5E3Iazhq49Wi6Kk0ecGxrc48ZY5jjgK217bXfYrQAd4sT7ItwhO6FCRyToCS
	ZOi8PKGbBnEfh/BQ==
Date: Tue, 08 Sep 2026 08:33:55 +0200
Subject: [PATCH v5 21/24] MIPS: ELF: Add more PC-relative relocation
 definitions
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-vdso-absolute-reloc-v5-21-3a93791af1cf@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788849226; l=1280;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=R3oIxCvKReHS31AXFavRgNPui6/4omq3e3P+29cRTsM=;
 b=rkjnjj70dplXDvHhkzfJOvBIecn20+RvsB4YJZT7kS6dmC1XplZqrPoTSbkM+YB0aLRxuxOb5
 Wp9eyI0SYfRAyhHyeFjnDOCIAqDeZA0dEsHaudn+dA9ns9ki2xZGWbR
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These are used by userspace and are necessary for the vdsocheck tool.

Also update the copy in tools/ so they can be used by vdsocheck.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf-r.h       | 4 ++++
 tools/include/uapi/linux/elf-r.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 170888422400..a6a4d7643c5d 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -646,6 +646,10 @@
  */
 #define R_MIPS_PC21_S2		60
 #define R_MIPS_PC26_S2		61
+#define R_MIPS_PC18_S3		62
+#define R_MIPS_PC19_S2		63
+#define R_MIPS_PCHI16		64
+#define R_MIPS_PCLO16		65
 /*
  * This range is reserved for vendor specific relocations.
  */
diff --git a/tools/include/uapi/linux/elf-r.h b/tools/include/uapi/linux/elf-r.h
index 170888422400..a6a4d7643c5d 100644
--- a/tools/include/uapi/linux/elf-r.h
+++ b/tools/include/uapi/linux/elf-r.h
@@ -646,6 +646,10 @@
  */
 #define R_MIPS_PC21_S2		60
 #define R_MIPS_PC26_S2		61
+#define R_MIPS_PC18_S3		62
+#define R_MIPS_PC19_S2		63
+#define R_MIPS_PCHI16		64
+#define R_MIPS_PCLO16		65
 /*
  * This range is reserved for vendor specific relocations.
  */

-- 
2.55.0


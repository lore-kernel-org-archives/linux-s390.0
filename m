Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DB36C9E2;
	Mon,  2 Mar 2026 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454350; cv=none; b=HqgXi2m9oPuv3kzO+WhmYYNQDiMvRXXmcr6h0k0oiYwQnh7Nvb33pFYvpZVAZs70kdoCAPhu5ddJaTSTE3WNC8z3zs2fvXbDQpYO8+QVQpKnRWe6IzvDpYujDuHs8gBmbNOpzvQ9e708OXqjaMpcRaO6G1Odmh3bYJSt1q2ofgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454350; c=relaxed/simple;
	bh=juGti0dpwtScxN3ZOParltAs+5PHUSX08Ot1ja9jIhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quCksy5BdHOFTc59v5IB9ZEd1lKEeYuXFkhAjmGe+YWxC1CClmknG98dsDzf8Wmzvr4fv/z/fBVLRxXRh2m+nTXTJ4GbGyuZQCQcBDOVn3sfgSVXYpuyWDvedXq5EjG8d8VE1XYt4seGJTAReDAvz6u5frCIFV0rYpUW4IldI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VSTpMZSg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G/2aXJAd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VSTpMZSg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G/2aXJAd"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772454346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHIzJvF5KQOpwYCYi9ql6W4HspVQ0yjpDjp6mM86yJw=;
	b=VSTpMZSg42IpjDoyq8x9+eZPlsHoPorC5Yp8YHj4lKeW+Q1Szd1xOG4fFF7EJLwDkmEElh
	Z3g2XNlLUEQXFYWtT1wTzzVrlTXkuKzTmGMw+x0EqKJ4LeUXrjJjJz9lJnK+89gpq3WLGy
	oN1SPmqhXJjTI1F26N/mPppPlsn4jQGpTDBXT0NDq/8fxvXULJkTzM2tpxTQVwaHLcuW1U
	Ae/LHkrGix4F6TnO6aBb8sxd1YFTkcIXW+VMaM4TNsJsrPLF9PBIQ54+mKt8MHtaGAITcS
	B+X5r0z7pzo5rFVib7xx/JWax0hdtUhV0alQE1QY5Ha1BrzXLHxtWhLz6E8YJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772454346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHIzJvF5KQOpwYCYi9ql6W4HspVQ0yjpDjp6mM86yJw=;
	b=G/2aXJAd/neq7Iq6LG5EvgJJLTyYQF8QAAaiLOtne55+AhOQkYy3dDXFI4V6jUcj/tzh18
	cH1j7O7IEeC/0FAg==
Date: Mon, 02 Mar 2026 13:25:27 +0100
Subject: [PATCH 03/15] asm-generic: add an in-kernel auxvec.h header
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-at-vector-size-arch-v1-3-a11f03ba2ca8@linutronix.de>
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772454343; l=2425;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=juGti0dpwtScxN3ZOParltAs+5PHUSX08Ot1ja9jIhY=;
 b=Xcrk5dRYDUnYdF4eUZUFljFjwJQobHGx53H0FPFSGhAS/a5w0rdNpYo278IFrTj31KWMPplHV
 UTZtJZTy+WEAZQyCi2JwlViZJY/10n5lJZhKwTiWSCLwCN/M5GCwyen
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Upcoming changes will create architecture-specific asm/auxvec.h headers.
Add asm-generic infrastructure to handle the fallbacks for architectures
which are not migrated yet and those which won't require their own
definition.

Extend the list of includes in linux/auxvec.h to cover all potential
low-level auxvec.h headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 MAINTAINERS                  | 2 ++
 include/asm-generic/Kbuild   | 1 +
 include/asm-generic/auxvec.h | 7 +++++++
 include/linux/auxvec.h       | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2c952d72bd..239c4e3ef5c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9573,12 +9573,14 @@ L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
 F:	Documentation/userspace-api/ELF.rst
+F:	arch/*/include/asm/auxvec.h
 F:	arch/*/include/uapi/asm/auxvec.h
 F:	fs/*binfmt_*.c
 F:	fs/Kconfig.binfmt
 F:	fs/exec.c
 F:	fs/tests/binfmt_*_kunit.c
 F:	fs/tests/exec_kunit.c
+F:	include/asm-generic/auxvec.h
 F:	include/linux/auxvec.h
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 9aff61e7b8f2..756a991aef67 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -6,6 +6,7 @@
 
 mandatory-y += atomic.h
 mandatory-y += archrandom.h
+mandatory-y += auxvec.h
 mandatory-y += barrier.h
 mandatory-y += bitops.h
 mandatory-y += bug.h
diff --git a/include/asm-generic/auxvec.h b/include/asm-generic/auxvec.h
new file mode 100644
index 000000000000..e4abd2a8c5ed
--- /dev/null
+++ b/include/asm-generic/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_AUXVAL_H__
+#define __ASM_GENERIC_AUXVAL_H__
+
+#define AT_VECTOR_SIZE_ARCH 0
+
+#endif
diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 943e8b80b41e..68c9d6b118a9 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -2,7 +2,9 @@
 #ifndef _LINUX_AUXVEC_H
 #define _LINUX_AUXVEC_H
 
+#include <uapi/asm/auxvec.h>
 #include <uapi/linux/auxvec.h>
+#include <asm/auxvec.h>
 
 #define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */

-- 
2.53.0


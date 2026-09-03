Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68DC42E414;
	Thu,  3 Sep 2026 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421292; cv=none; b=n3oaS/AsFhZAJH7BglqsKLdvVPBsfH14QSKRrsQpa2W2+Y2y0fnsjMh3zo+dImNR3AXkoaw0C7bs0cUBINruCkHSjKBl8V0fhXGOFwNkH6LGVbuFh5EDeW6u/qvgHLm+NJBbeykrT+CEIa3deAfw164tQO3n5L6yzWqOyCFH2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421292; c=relaxed/simple;
	bh=Dz+MzkOjlYnWkAvQ/wE+s+kQ2Hop+FhDIVkDntsCAkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlMaHSWUWtZb5pgqRXoQaSG6FGYZ0wnItCSTQBDdrMubRu+A7JHB5A/KbU/Wp8duJPBqCt0B6rOHrfX+zmmx6dAlSJCsX+cTWa8uVPDxrYUYEebT4mc5GOVcZgeQEHOHl7xFiJvvGi5H2LtADYE3y1UCnJTVnDI6hQPu6kgMwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EAotfmrF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ds0SsmUa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EAotfmrF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ds0SsmUa"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTIUO03+vTuzokz+0CLC3jJffqMKEhB1M1saHVAcdrI=;
	b=EAotfmrFrsbPTUu0GtvAGP5xKeex4onVnvkHIsoxrfK/u1t113B/VDkIfcQtC8ZTyOR6zO
	kkmeP5SkZKTSVkPaaQcUL+Q4beh+HHJbJpGVSGRRBhjIHoqdI8s4/u284bWB+YCx80DgAC
	KtJFVQhplo8B8/8GOlbgnK1W0C+YZ3AekXg8duKZYajxT2pX89dgXTjMPhpdVMksBpTcgB
	ZW39MOWr0/vLLnSDDHEFXhugb7f2eoEUWUp9IjQUni2MiRyPYBuQs4WqmdNmeZVBqM3DWP
	+OA+lFOzWNCma3+pGSIsnJ4ablQqkqlRC6JaA1x4up2cN4e0WRWTBK0AY8Vvmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTIUO03+vTuzokz+0CLC3jJffqMKEhB1M1saHVAcdrI=;
	b=ds0SsmUaK7hbdxAtIf8vYzrxvul23GNKluaEgREqtkFfgg60aDVcJOUqm3pGFw2WBvcEWa
	nRKqjPhNX/6RcIBA==
Date: Thu, 03 Sep 2026 09:41:18 +0200
Subject: [PATCH v2 03/15] asm-generic: add an in-kernel auxvec.h header
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-3-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
In-Reply-To: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=2467;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Dz+MzkOjlYnWkAvQ/wE+s+kQ2Hop+FhDIVkDntsCAkc=;
 b=ZpM1agafw8vnEzFvvYGBo4mc1Mri6kilHloCGhylalJY3bCPcuVwBQ47m1vZB5zJ4e44kqdg+
 OboO+VdSwkbC2yW6wGK+lHdE+2dw2GWeg6plS8qSz2kJau22a8VmvWB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Upcoming changes will create architecture-specific asm/auxvec.h headers.
Add asm-generic infrastructure to handle the fallbacks for architectures
which are not migrated yet and those which won't require their own
definition.

Extend the list of includes in linux/auxvec.h to cover all potential
low-level auxvec.h headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 MAINTAINERS                  | 2 ++
 include/asm-generic/Kbuild   | 1 +
 include/asm-generic/auxvec.h | 7 +++++++
 include/linux/auxvec.h       | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42715aea210b..6974f8dad1e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9808,12 +9808,14 @@ L:	linux-mm@kvack.org
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
index 2bc00c67dc54..90626358f94b 100644
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
index 4b364e639f08..de1c33c4a256 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -2,7 +2,9 @@
 #ifndef _LINUX_AUXVEC_H
 #define _LINUX_AUXVEC_H
 
+#include <uapi/asm/auxvec.h>
 #include <uapi/linux/auxvec.h>
+#include <asm/auxvec.h>
 
 #define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */

-- 
2.55.0


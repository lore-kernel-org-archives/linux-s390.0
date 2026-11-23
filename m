Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426650;
	b=q/bS6rMt3v/rGv+R5oqEFFoneJ8SUZSLJyoFD5Lsic1L+ZcpZks6VrYUKxdQ3Wawq01C
	 LcMDmXWOXzYV8Nd5My7hKlv80InWWJBbciMfccEfzoV17mPmHeV0Dh1V4bOwDMCV2T51X
	 0i4AcFPn/x4/45g2bM2cimFEKVkwnDMq3+Akn2p4F+4CLdvYzqA5fv2S6BVKail5FYBnS
	 jGOyyEffcAa4tWJRXo01jMDmPaxkjBT/J/OvNrZEt7g756aClA5UQdxaVdnn5EypzHAjA
	 D779c1qRdo9C6GEmA0ADv63M3Ka36ncm8kjBsV3rKuOKJZzmfS2RKEcEz1VbvI7txsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426650;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=dCjIARJZuyF2MKvJaqs9gktLzUWSriQ88u2CMxFe+40=;
	b=xXTL9giHlK+Xhm+Ng2qa6pbhfrK2qV7w4Ovy1mjeQiTzn9l0NGQFugpVHVInnh3CPCmp
	 ymIyfV1nBe+frz60yIxvYZqpSSjpaDjX7K17yrtujw5QmTKlj7h+qim0IdXoK2tBTpeHC
	 tKRMAnkCl63uclV4BsdMckOotd4V41Mzhk2N5NVMybB8Tr9dxW44ciGrxatz+on8f7knY
	 9XV0YHmUQ+f/2pMfeO8hq/r7CbFFWzA3BIi93aWBOzFOP/m/xGfhvAzCSy8sDoTBgXHDx
	 Hoa+ZRp+z6Ku+DHVkZ1zczSnQPPZnSg1eZbkuCXS1Uo9gvOs1gHIC3hijq0aaBaX7HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xIytSaYS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="2Pxz/VbW";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36592606A680;
	Mon, 23 Nov 2026 09:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36592606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xIytSaYS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2Pxz/VbW
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCjIARJZuyF2MKvJaqs9gktLzUWSriQ88u2CMxFe+40=;
	b=xIytSaYSFHN7/y9Cb6dzhLZoJdiOyeCxL5r4X+xqU1KFQodlzXHZ1+mdJGSlR3PQJg/1Uu
	fVEOi0x/TStTeHc0h3jLEkDxpbGD04A8mgZYbnKq9zmR2jvB8zm/yvcNnKATqqhSeRE4cs
	rbwbg8XerkQgAhVy0iuT2y0+x7S4fKS9pkrVkrtuYk0suVgPk0rhV4B6QeeuRr1V/2qiJK
	jJLheGc1xc/Ka1IE87KoIi9cqes27CLdqY+GeL9LX9NWEBINRVASPjjMH6az7WGiDShQU+
	qo0U9lTYqdekyvsiFR1cd6CavQlCKnS4Hj5w6SaaE4O6EZFYxKYRLwFmcf1K/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCjIARJZuyF2MKvJaqs9gktLzUWSriQ88u2CMxFe+40=;
	b=2Pxz/VbWqlx26KJWhfHWSW1lo3/0I1ylQ3IrkZhGN8RmXz3hJdqDbSsE/kFGz+dsGZWEYw
	0UR9RJ8W7uv7rIBA==
Date: Mon, 23 Nov 2026 10:37:08 +0100
Subject: [PATCH v3 03/15] asm-generic: add an in-kernel auxvec.h header
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
Message-Id: <20261123-at-vector-size-arch-v3-3-d342dae9e843@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
In-Reply-To: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=2500;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=bABQvj2R57kM1fjG2HzTA04qWWs5Q4Mt3h+20ozb1Bw=;
 b=c7YPyzew3rWzJzbI2YP0fm7hSzzpwV/lGlOxq0YhZpLxMX5aMMqlW9Ut22ftoTisF/UfC1sVF
 xSIj1kgJmJ8AVkpAm3KQ8rGCCmbjRYaF6z2sQQD5o8/QyTjOH9GD+al
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
index a659c9bfb0f0..8cee58e323a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10073,12 +10073,14 @@ L:	linux-mm@kvack.org
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
index b7a388bef6ea..6dc54359c4b1 100644
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
index 000000000000..b5f73f35e21c
--- /dev/null
+++ b/include/asm-generic/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_AUXVEC_H__
+#define __ASM_GENERIC_AUXVEC_H__
+
+#define AT_VECTOR_SIZE_ARCH 0
+
+#endif /* __ASM_GENERIC_AUXVEC_H__ */
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
2.56.1


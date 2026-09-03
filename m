Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41C446060;
	Thu,  3 Sep 2026 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421296; cv=none; b=gXrLJGOXFTocjiNBiMgxF71lU9iu+O3khzzdhc5MjLu3I1kSb1dZYA0KBeFnrMHV8EvAZbfIrRyHiwaHutO44r9+dskMNq5uWs5drRIQLRwuwix72PzGCIVnImFMn7ucNajurN6z7GhEWy4AMSW1rOrfP2OPyLTKDcXO1UnzAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421296; c=relaxed/simple;
	bh=jZmwpcTvA2lKNhTJtgt0mA5Nuuta8CO6fadzS1+09Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTVmjA8WM48/smevkU8/rcbffV6W1uo2GrcvuXcMXL+ci02d1k/6Qpml0FqaugWyPLHYKCZQeL1KHbvNrlKwaPiOns91geB/+jnkCIdBhYx2RIRudPZQV7c1rsbMF0QDsjQLyH4n3qb5+3B0dgjbzObpTyUUFxjyp5aDa59M5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RmnpqQcH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MutDSXtV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RmnpqQcH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MutDSXtV"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ctVC8jdqr6QFYd4YOzfCl075dK66bWX+194Sx7TuH4=;
	b=RmnpqQcHoiAbhcGu+Ye9voJADRcNlHd7//7UZSZpuweS6/azB8kBGlfXNGpZdw+zJFDhmb
	wVqfd/ReM/yvTEBcp2m8agJJbkA7AncmPKWHrzmhKzuSH1IVXory7WFsKLsmSfU+nfF4Fh
	hxpf6Zo0AWb/8lzdQ/XqwzDTqjMN/ZftsjIshCrqha3MqBXvjPJqrmx40U9dtdNY8urMWx
	+B2P0HKRbsRjXaKsVte8egNJzNOx0RSzNnBwbUTf/deLjmYm4421Lw0Q95xES95qHbtIp7
	OG0nZ4yrrLdrUs28+h/3y0b4ZZnyaG3bYORKfR7uKBROl70iqzLJhbBNyDZQmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ctVC8jdqr6QFYd4YOzfCl075dK66bWX+194Sx7TuH4=;
	b=MutDSXtVdZvrjMqfAE/yNMGtPAGK3IDThXDBVUv0sCpVzDTmiCqIuYuqvvtvE2gzScp5oD
	8MjD0OPK1RDnqHBQ==
Date: Thu, 03 Sep 2026 09:41:23 +0200
Subject: [PATCH v2 08/15] LoongArch: Remove AT_VECTOR_SIZE_ARCH from UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-8-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1767;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jZmwpcTvA2lKNhTJtgt0mA5Nuuta8CO6fadzS1+09Lc=;
 b=g6xbNGIMHGTFBPIVi/M+7w3xhJb6s8qCkfAEkcXz7LglyUP7ReGfFvVG9ZkdpA32UwGSvrRmY
 cx+niZaAeaKAcK6Qn9T2uEinyA/55qjVdDuG6KFn3ehAIJWX1I+ofN+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/loongarch/include/asm/auxvec.h      | 14 ++++++++++++++
 arch/loongarch/include/uapi/asm/auxvec.h |  8 +++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/auxvec.h b/arch/loongarch/include/asm/auxvec.h
new file mode 100644
index 000000000000..37dd717a3a22
--- /dev/null
+++ b/arch/loongarch/include/asm/auxvec.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
+#endif /* __ASM_AUXVEC_H */
diff --git a/arch/loongarch/include/uapi/asm/auxvec.h b/arch/loongarch/include/uapi/asm/auxvec.h
index 922d9e6b5058..79691c422c7e 100644
--- a/arch/loongarch/include/uapi/asm/auxvec.h
+++ b/arch/loongarch/include/uapi/asm/auxvec.h
@@ -6,12 +6,10 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 
-#ifndef __ASM_AUXVEC_H
-#define __ASM_AUXVEC_H
+#ifndef __UAPI_ASM_AUXVEC_H
+#define __UAPI_ASM_AUXVEC_H
 
 /* Location of VDSO image. */
 #define AT_SYSINFO_EHDR		33
 
-#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
-
-#endif /* __ASM_AUXVEC_H */
+#endif /* __UAPI_ASM_AUXVEC_H */

-- 
2.55.0


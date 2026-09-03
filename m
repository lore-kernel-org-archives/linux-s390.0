Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BE44E04A;
	Thu,  3 Sep 2026 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421299; cv=none; b=BMpsr/Ogy2kNgXi/ePcaeuZFje11i6vpg0MuIdFmgahzdd5VIpA5+Ug3wXF5IuOzZfvf67/rpfRoLmUAZA06pIwyHyGT7KoguwHVHuSvTN6tBSroctma3GSdKY0zF0fY7VcNcarj4OvC3smrgwcdciWTQtlmRCz2cus/wD5JXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421299; c=relaxed/simple;
	bh=YIjNA9GHIeGKIog+4ZRlNVoTyE7Q6c9+vbExkNBbN7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7vK/GuM//fD90o1Jrfz9D5TAG+tiM3Xqf7YZR95lB/OwomQU/oK29rYh0NkFKajvMqNofJrWPX74YovtruFLS2U1MwQT/RpizArZUW/dbqRZ8pdGWlAjXES7EtJAe8jFgddCidAsCkaYK2afmauBrO7JMDS9iQ90G3sQRAUiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x98/uR++; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=16lypqC7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x98/uR++";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="16lypqC7"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elVYzhuCvmXJBPRZ3gCfrokksTC2QjbDZG7uOX6NqdE=;
	b=x98/uR++5TGb1kE9DatfjBc7vccpt9Tv6Ybqo6Jpm1/OJSJD5KyNHVs69DNPs/A+utplx1
	kfB4ZZcdBUdFM9kNfHH3RmU8srMZxawE9tJ81+G0De8/k90wTz77UrJ/ZA5huABZSnoy1W
	8xIHZGOtgbMGRjdhG/MspxM5XvQ4jhFgE4/OvO5PFuyRioaV0ToxHelPuUjUoJCxVs1jmi
	a7XdgCUGnmhgYMH5GlU6reqy7m0j89/Z9cAyKN5l/lKlSrtK7RD4b4rQQwaWdRJ7D8nqy/
	x1IhVuGARBmfGfthpyoY88Qljhzj8StgQwCNy0bgCdFb3X+pqYUiWXjLOXJGQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elVYzhuCvmXJBPRZ3gCfrokksTC2QjbDZG7uOX6NqdE=;
	b=16lypqC7rW9J+MkVv+rFbiDQP8PUbNH9MQTLL3JpXOtqRwqdnyUyndlvLnhpDqwpWve5tX
	0DkewKfU+GC6NTBA==
Date: Thu, 03 Sep 2026 09:41:25 +0200
Subject: [PATCH v2 10/15] powerpc: Remove AT_VECTOR_SIZE_ARCH from UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-10-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1614;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=YIjNA9GHIeGKIog+4ZRlNVoTyE7Q6c9+vbExkNBbN7U=;
 b=tzh2nu86F+qh+b32xMEyYGMszxVH1qArmLc3sUe8halsMjfnsH1mlrvaUFUosJPsV2OmaGV3H
 9t4yw1mYDMtDty4LZwJAm85bi7LB7ZA/JDYQ5/xehieYzIxhOCKT4g4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/powerpc/include/asm/auxvec.h      | 7 +++++++
 arch/powerpc/include/uapi/asm/auxvec.h | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/auxvec.h b/arch/powerpc/include/asm/auxvec.h
new file mode 100644
index 000000000000..d6c180e9ac2c
--- /dev/null
+++ b/arch/powerpc/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_AUXVEC_H
+#define _ASM_POWERPC_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH	15 /* entries in ARCH_DLINFO */
+
+#endif
diff --git a/arch/powerpc/include/uapi/asm/auxvec.h b/arch/powerpc/include/uapi/asm/auxvec.h
index aa7c16215453..9ab5b6d17929 100644
--- a/arch/powerpc/include/uapi/asm/auxvec.h
+++ b/arch/powerpc/include/uapi/asm/auxvec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_POWERPC_AUXVEC_H
-#define _ASM_POWERPC_AUXVEC_H
+#ifndef _UAPI_ASM_POWERPC_AUXVEC_H
+#define _UAPI_ASM_POWERPC_AUXVEC_H
 
 /*
  * We need to put in some extra aux table entries to tell glibc what
@@ -50,6 +50,4 @@
 
 #define AT_MINSIGSTKSZ		51      /* stack needed for signal delivery */
 
-#define AT_VECTOR_SIZE_ARCH	15 /* entries in ARCH_DLINFO */
-
 #endif

-- 
2.55.0


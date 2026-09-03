Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8FF453A4F;
	Thu,  3 Sep 2026 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421300; cv=none; b=ivXkGRkZcd4t+mbgdhUDrsxxtTLx+RzQZOVFOJlBKrCMKuEGcM+FnoW69FTxSqCH/YVh4S6N4lETGoE3tn8PMIFzLK84hO9xcojyctcG9jixCYBxe4WVwJ/Mx8two4oke3sM4Bw10eK/nlcCV0Lkd1Oau4gLGjkNI8rHEQm44Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421300; c=relaxed/simple;
	bh=cs0IiOQ51smsz0pVBiUdFi4gN8rZXBN55vGK/+lYj0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdmafzawaWE1K5eFtd340I5vuYPvMVGyBzgqPIfKc2ihzEU4sPvJQO88BfovOlCNDAtrD32rmDxgkdPeCu/5NHEoLq/Ju9HE+bcw8MH/2g4YsQR/4SB2CDUc30iuAvpoOaRwQfSkKoM/RSnJDMiHw8thszI4nkV3d6HRvZzhDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zh5925hV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p+sdR1ZO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zh5925hV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+sdR1ZO"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsqBa4DYT6UOJOiQLZcJsY0z2uNBnuWhMaLFwrPj+rM=;
	b=zh5925hVYaFB8ZqXkqngvUmrw9+a6ujcjssEZbyneFYSTtX2htRdyVd+bPbvOpRgBkbHKS
	UyYRl8bVC/aCmhDACl6PUsAGjL6qD6UrgJ6fMtX0XrK73AXH+bTIM0RQh9RqQBqTE7PfWd
	sy46BX+9UVIXQQ8gXYqvn4EW9yJvpFkVlqSZcEgQdubafxa5Ht10HI2PyF6YkErVIB8+Pz
	tTtz7udMuul61G9wZ8BcAdTTwiUXTNFB24x65Fdz0iHU4ieKAxzzI8OryCDb0/Sujiis8f
	xSWrzR7JgVoAUIc97d1Z76rvV+zJZLsOMPXpSeI9zqAUC1bi8nMdiAkqTFv3cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsqBa4DYT6UOJOiQLZcJsY0z2uNBnuWhMaLFwrPj+rM=;
	b=p+sdR1ZOWyxm4iWpsvHvJ/zT475he8+gLNu/e+0exOHrUUoHvzRjT1tFhSKbw+QZymljTy
	5ABuxLobpVaHXeDQ==
Date: Thu, 03 Sep 2026 09:41:26 +0200
Subject: [PATCH v2 11/15] MIPS: Remove AT_VECTOR_SIZE_ARCH from UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-11-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1884;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cs0IiOQ51smsz0pVBiUdFi4gN8rZXBN55vGK/+lYj0w=;
 b=fgMzeADRsHBHDhQ0aBCRMVdgaCDOyOHavpx7wa8hChxiqtcHW4YZOAtPgh6azTmpGG9KLODsH
 xiGj8+MIrP/CxqeNABlDpjpPVwhKierLeYQje+RQU0pz9pb8sg6KNDG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/mips/include/asm/auxvec.h      | 17 +++++++++++++++++
 arch/mips/include/uapi/asm/auxvec.h |  8 +++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/auxvec.h b/arch/mips/include/asm/auxvec.h
new file mode 100644
index 000000000000..76c445e7890f
--- /dev/null
+++ b/arch/mips/include/asm/auxvec.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
+#endif /* __ASM_AUXVEC_H */
diff --git a/arch/mips/include/uapi/asm/auxvec.h b/arch/mips/include/uapi/asm/auxvec.h
index 612c2c41f60b..1331ac4d935e 100644
--- a/arch/mips/include/uapi/asm/auxvec.h
+++ b/arch/mips/include/uapi/asm/auxvec.h
@@ -9,12 +9,10 @@
  * option) any later version.
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426656;
	b=OqgD9o5ajRqJKay+6KPgxd8qCXnnVBVu/Y7bSk9LYJRIaGpiTChrBWxOkCg5EsyaEb0X
	 ARrN7Xe7LrPtCH9Uw5ZvtcD3r/lT7aOjqWhLi96KTvOqYeEInVJmzgEXOfsCCw0Ay4YJd
	 MkpMZhRRV4qQVY0Z/ARI0gLQXtr9HwW1tmzlhuUfwrRriZb7h8QNb1C4cpNDpjI+lpaId
	 2IreKk7wzUoEsthd4jMgdGzuBFeRDaYM774LWcFuBQ2o2yDCJLG9NQp/s/CWHJIZ6CVGy
	 EbvJRg7Hv+PrOa7TacbVozCon61HuX1fpef0OvWdzf8GYA283pVam9E5XHPB3PwaXZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426656;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=OFz11W/0Lqk00aPK2+1rfyP0U4LgLtsvecMTzf9C0fI=;
	b=QT1D+nmvvWMIBB0SzyjSyJNg1nPt46cyjQY1Kq44cZUBmhD9Hm5ZcN0mn+qVw3yHlWdB
	 RxOP/oGCOhfqdHhOcpLUteyLwmeyCuELtAEjnCjGvXefOJsL05opyE0NcRsh90EwSTSR7
	 r1DHx+YCECIwuOpSUZmTh3yrBDUZ+1hqnTDcEgZaNuPnYc6a2c104yGQOldw4GSayaWwn
	 LPCfp9AHmh30u/nJFOdLRjXtfTlOsJMYQ7eBuRBioDSFoanvP9CiIqeEKQAdegTtTOYdu
	 6JuMeDNxC1Q5kEYDQPVl9Z01m4aGsPEY5AJ+cx5yUYmEt0Qamu6RV9b8JMeB7ZnGenQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Qhjfuhg5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DJ5CQ+2g;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08EA60A263D;
	Mon, 23 Nov 2026 09:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F08EA60A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Qhjfuhg5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DJ5CQ+2g
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFz11W/0Lqk00aPK2+1rfyP0U4LgLtsvecMTzf9C0fI=;
	b=Qhjfuhg5BOpRdkpv0wg4HWnEWXpfOXKFeEV6Sz/b10Pv8ng2sR4CWRYNUMklJdLK+lfFhQ
	ciG8+VF0sDO41CzlncqE8Nn08rc0T60asEFi81sdelPgJ0xU5AdnXOBI+Fd5RUlN7xW6yQ
	suXN3LFNwZB08v4kbJY5Khoy+gIwVBMhJJcvRMo49tcKazxB2JkNFp7n0LqC/8/Dhebatb
	ZaMhDZgGsx/KdS26g/v+rWxCq4PFo03cy9ktkysnFIHbaU/A25ie0CbJdjqk6+NciQ2riA
	vFNQtU2TwgDZ6bNnr2LODBFP9Ko/KAHQ1WRx+mzOY2aLp/YG/M6n+1r8GRGmfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFz11W/0Lqk00aPK2+1rfyP0U4LgLtsvecMTzf9C0fI=;
	b=DJ5CQ+2glRL7KEbNa9Pi3LC8RLTKlXOHkKWu1TseL+8X5jKEfrdNP/q+t6jT6amybgKSCh
	JOB22dFWK0AzxLBA==
Date: Mon, 23 Nov 2026 10:37:16 +0100
Subject: [PATCH v3 11/15] MIPS: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20261123-at-vector-size-arch-v3-11-d342dae9e843@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1884;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/scq+fYP6ilitEq/RHaQnIRXIqOzidKEXbq390ysiEM=;
 b=VI0g7Ty5sUuiX3Qxq01gVzHhE4kwB7ooWl14HZPmX8PuM1fgFaPwF+XKQX6xfpE7avFmAUJaS
 6ukuvxThL4qDUbzZO3QI098ohACP5JqOVuaivPYQJ/IemhwRfmSZgvo
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
2.56.1


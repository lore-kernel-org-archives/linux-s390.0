Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426652;
	b=5tSbB7iymB72pk5k2nEWz1z1hIP6+Uc5z1OKSFYQANrGv9WOuDWkfAAmf6h/CsTG4D6G
	 wMsfw5ShkVpnk5CEAMiJZfU10Gqhh3PHFySZka3CX5Vsrb+Rdd2DFsxALpGpOpaj1Qu4+
	 SAV4hAuQYSUM7NDG3cA3XYkw7B9NO4pRSbGfCTIkxs3fLNl4bURvCYQFhtfTbiaJQj85u
	 t0svhaBu6pJxGi5PlECti8bk8E34yDQ++cidn5e64a1VkE7hFQXNzadr2zrtH1dr2kgzC
	 9zfq7k8ykmRQhQxHy/fbFXNpErFtbpNm4KFpc1Qn/aIpD3X4PxiIdLY4QueCb00NAHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426652;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=6O8o4jPy1JR2PVJ3l/7YMV8E/5cyWIFMpsjiqqNdK9Q=;
	b=CEk0XiluBuxAIHKvEkYzBPylPWo9A7Dalsf7lWQ03bwQf35vgXzoSRLKO4RTQPJJG5p4
	 fCpbpawSufloiMQUCD6MmKWpLrsEV7uEX8HygFOH0lHlMshs+8qyJaiUMX8ZREaOm/1E4
	 +rHUjoMIhbyY7yIZzlUvIky3oTpEjj1WaGM1cc0Bllus+tN8A3a18IbT1mAECU2BHfNgI
	 A+YaBX6L749IMB5ipZPOTy1eIcYgi+1DQit1cFY1pmNOyqO7OUtcfWUFiIVGNg18QJD5f
	 0vSB0Q9o3sAbpA3Z4PfG94yiHea13OWTR4suJzfSOY7MHiYW8eODxqKo4Lylkg7imsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=i0WDMFuA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7mhh8fkl;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA155606A699;
	Mon, 23 Nov 2026 09:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA155606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=i0WDMFuA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7mhh8fkl
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6O8o4jPy1JR2PVJ3l/7YMV8E/5cyWIFMpsjiqqNdK9Q=;
	b=i0WDMFuAdZ2j2rOtxrd1oZv/FkA8Zp0c0dAMiqHcxV9AQMvw9zWWBpAXxB01tlEHVKbl1c
	xx5XliI8ACdB9yBxdxLxGu7qzryOwbaFbW+i+rSoV3DxerMmyEaAO4cU1vDSWYAIXnfHvO
	21Sr6Q4wVLZzwo1Ob4tWM6RdWOFnjfDFcFmHBXgHfCeNVASJ6MpDdRqQ2Wb+MOX+6Ic/Zp
	oPsmXQYL9M79ldoIbg7c+oq/fVFbvWgqyoLx3myysEdv0KsG5lTMtACMg3B5SbicTWQUbG
	l5Zo+jNl6b7uMJwahvcGFmmIsImP3IPO3YVAJTn+TuAcogVLzylegCP7rhZmlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6O8o4jPy1JR2PVJ3l/7YMV8E/5cyWIFMpsjiqqNdK9Q=;
	b=7mhh8fklHnCbzFB7I+Q0iexBgbzBVixkvY0GBhA1YVDTjzBQjroLWJYnoRr5gGZ2or0Rlj
	Kd3zBjtkngEuJxCQ==
Date: Mon, 23 Nov 2026 10:37:13 +0100
Subject: [PATCH v3 08/15] LoongArch: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20261123-at-vector-size-arch-v3-8-d342dae9e843@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1767;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vBs3VQQa67rpUmE2rrBLqD26Zpyg2BNszpmqddnCDow=;
 b=cLRElbxW7EhCUz/xMdMTbFBzL6Lski3xa/GSrklt0Zpdw5U2z1v/lmUutRs/DZrC5RtEPdqXP
 iJPTytwMCD0A+UQ2BgjEc7a7FwJHbB1gtR61Pfli6wtUhfwog+Lxafo
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
2.56.1


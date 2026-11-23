Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426651;
	b=Ob/xwMm1r7kOEZmRKMGvVqGcGXAzuQeqsXBX5CrZyBxKcMFX53YCR0imb5RezTmpnRNW
	 Lcl0Ux9ESHd73obOayR3bK61+gPpolUmHIK5VO46J1EQDRLZcxYnTaIxTCghXeGoF/2I4
	 WYB9bTN05Z/dftoU2+YEYWbA8Xz2IB58rlI3+CDZiBe5zjcTbpQBcSI3NsIdtqZCR1gjz
	 umpL6dwvD8WAEU1Fo6Agpc6nNtfEgbQ67ud5xVGj7XqVWGTc/vXlxXLJnXgUNRPH2prnt
	 CyjC3SniQRj3qGJuNXX0FutmOvBABaBtbRFlQX3Hv9JRgiloR0WXoViHsypB39x4tlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426651;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=UIWLxGK1Vij7tiU90cRxSFqpScY7zQR7QJvEseKLzwo=;
	b=EdxfBPt6jjZByf9FDZc2nawCduTwlhwafqWE7ML7r59rWmBTK/WwAP2eLdkwmUElHLty
	 WX1Kl2EsYUBcaygBIV3CBtAWia5KZwCG2whoAGp0WjBbPRS69UllcTzDjhCuY2zrvtVEu
	 hilAnrsGl1GhlwqGMMbznielZz8SvoyAafoGPUvPG/bfUQgURjRgiqPzxQQtE41HphJsz
	 Pi+NLGCBtfwgmZD44hq58DgRWHrESQ2rCsOxPmPc1fE47PqVPNhLRK9FUZyd1TtqKOAfY
	 wmXNiDqn4jN4/m8ASYuvyb9mQnu9OPWcoi+xz/jNf9k4CRjeWD8Ukz6Srj+Haud82gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2z10FrIE;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UGWZ7T+q;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562FB60A2609;
	Mon, 23 Nov 2026 09:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562FB60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2z10FrIE;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UGWZ7T+q
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIWLxGK1Vij7tiU90cRxSFqpScY7zQR7QJvEseKLzwo=;
	b=2z10FrIENPAZxNBu/4FgnLVDlG3M7eRID7PzxUiXKydy/rln1DK0lZio8yE3noqkjRh9oT
	e/b+tC4rq+6YEoAcrjJ3cO7WlEfdLeLM1li0q/Tu0ADcA+or6b8Go/sgxFoq3u5Jml76nL
	wEJatTYHV8KEwJ04HLx5bycTT8ZyBzDv/EG6zYCj2bUXUfvkPNDwJxK6iLrH1+oKwxdDm0
	M6du5ER5mMXwAVZIpKmMPCoHzkl1ZHZHlS6RXzVJrU/FNTiYSQ/havtLOL4i6YJNQIQTNc
	2tz4Vmrf1kO+R+LB3ZbFcXy/yLpQ6jr/eCHfaUARFPi2Tkk0Cg45knkrepuvNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIWLxGK1Vij7tiU90cRxSFqpScY7zQR7QJvEseKLzwo=;
	b=UGWZ7T+qthHBHDZwO2ZfnZZ4wdrxxNgHz6eoMYh19mIUB2kturgEFENUaaOBWGQCMbjlCJ
	6yQtRb64pG3v47Aw==
Date: Mon, 23 Nov 2026 10:37:12 +0100
Subject: [PATCH v3 07/15] RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20261123-at-vector-size-arch-v3-7-d342dae9e843@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
In-Reply-To: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Andy Chiu <andybnac@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1592;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=d8drZZysn7iP84IJ7qJbdevEVmAtmC8DVsiKbIAXolk=;
 b=aNwL1kWJlo01PaCvebxGDmG5xP0glqFTyi1RyyWhaa+P/3M+1844nqqBisvg5ICRxsxQjd2Xb
 /DJ1mQEVkTCBkqSfISfQLtBeGU1DOULq9hjkJBkJp0rUsvPlCTIH+I2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv
Reviewed-by: Andy Chiu <andybnac@gmail.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/riscv/include/asm/auxvec.h      | 13 +++++++++++++
 arch/riscv/include/uapi/asm/auxvec.h |  2 --
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/auxvec.h b/arch/riscv/include/asm/auxvec.h
new file mode 100644
index 000000000000..0960bc07ccd0
--- /dev/null
+++ b/arch/riscv/include/asm/auxvec.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Regents of the University of California
+ */
+
+#ifndef _ASM_RISCV_AUXVEC_H
+#define _ASM_RISCV_AUXVEC_H
+
+/* entries in ARCH_DLINFO */
+#define AT_VECTOR_SIZE_ARCH	10
+
+#endif /* _ASM_RISCV_AUXVEC_H */
diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
index 95050ebe9ad0..0a725f2aa2e7 100644
--- a/arch/riscv/include/uapi/asm/auxvec.h
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -33,8 +33,6 @@
 #define AT_L3_CACHESIZE		46
 #define AT_L3_CACHEGEOMETRY	47
 
-/* entries in ARCH_DLINFO */
-#define AT_VECTOR_SIZE_ARCH	10
 #define AT_MINSIGSTKSZ		51
 
 #endif /* _UAPI_ASM_RISCV_AUXVEC_H */

-- 
2.56.1


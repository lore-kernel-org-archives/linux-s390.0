Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426650;
	b=tYxLq4h9QKOmgslqTbR41O/LOMvO496GcZFudpibj+j7nCvkNTiH0qDgJB4nBWR6COdv
	 dDn+R0kEdfucxNoXijnBMBPynETk4JseyOrp7iVfIVC7w6MorKtzYP4wzWdhD+e1EDX5y
	 WsH+iZPyt1KhPX4My8dx6KN2e2ZAyjm6cD9ezfEJfstPLjyQfnfMG4RmIcAzMXHqv8FvW
	 hNWDBwGr7vkiqvk2o3rDOv9xPtK8JAOow9iaYQVv03V15ZRQCYfoAkfH9kTtg0PyrioET
	 NZabVWNHCZ3qMPQvpCZu5K/QH/G49Bd7iWsQnfPMmzSZGeAZmI5xjedy/SJkyBNM97w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426650;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=8XqI/ovDzkmrLY2+2cJN8n7p6UWRDilYHLPeAY+Yquw=;
	b=Mbwz3CR5DrZAp4s05n8wx4tksIIvhmjkzzWL+hUY10BXqNSDhLw5C3Lmv6Ayu95/6J0C
	 aGYXXZ54USIneluCqjpWIZhDKqxm//2gOtjDORIRgCdH0BX9P+4B1O+e4BfrCq4oyGOva
	 u51zdkRV3+v9VVluERIclG/5ISMqT4MdZ2at6217YXGvzWKmJb/L69yKqFQBjrp63FJNh
	 flrEflIZK/73MtZGcKgvZyTb8DAH8Dhj+GEm7v+C0Ziq5qIpAFgnuwZylSXaxhGGpYgf4
	 xHuXIGc3QizZajdix6C4BPmemhIjIkPirmLk4zo20OimW11Tcy9nHIc/D0dPd+vSxvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zs2rFukl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PrBaN3N0;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53857606A6AC;
	Mon, 23 Nov 2026 09:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53857606A6AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=zs2rFukl;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PrBaN3N0
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XqI/ovDzkmrLY2+2cJN8n7p6UWRDilYHLPeAY+Yquw=;
	b=zs2rFuklTxUZu5QUQvubGD+p6Pyzu9fQaaPPpeVicdMWD9WrOngHzV4/XzWZBGRHsdJ3cc
	quUxa+FO+MT7Qm/1zSlCXev5I2WGMZIh/fLeXdR2vba6jrhmd5wv+j2JDbGxOR8rDRUZTq
	BrS2u4u2bVtIG6e9i5XPQgNb5b0xiqfa7c6Hy/FALHoQLbQ4PissJnR0w7x8W5wTyO+xDz
	W93AeGkWa+PBh71o7o+hiHRXY5BimtaJ7OVjOnYimFgvPF1vB7Sw1JBQRyGxXt9skYIxqX
	1OCyPLXO09TENfB/JZxU1yGMr5vNBBFPKGZp4DoiSMxG8+jwAwxfZJtkcpfl7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XqI/ovDzkmrLY2+2cJN8n7p6UWRDilYHLPeAY+Yquw=;
	b=PrBaN3N0mDSUo7jZ1zD0BdxjTZzR+Nlue0EyvgR0thKd8gbwBgsxQQULaCNGGe53D7j5Fj
	BqzY9hdcO8uUC/AQ==
Date: Mon, 23 Nov 2026 10:37:10 +0100
Subject: [PATCH v3 05/15] x86: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20261123-at-vector-size-arch-v3-5-d342dae9e843@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1994;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=AMxMWB4XLAUF07GFQRf/ET9aUWKjGb7vCuCYUiBHLok=;
 b=zxx6vGGdxpYVQVUw2UCdVcTPBGb0aQyLdwuRLfgrOIr0g0B+Y9UEJYR4JcBJhIcNn1mnVle0L
 jMOLDNcao4zATn0M7hA6ZDAZUGDgHq+8r7fL+5MoLrHIByaxlnXij9k
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/x86/include/asm/auxvec.h      | 12 ++++++++++++
 arch/x86/include/uapi/asm/auxvec.h | 13 +++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/auxvec.h b/arch/x86/include/asm/auxvec.h
new file mode 100644
index 000000000000..ed26ad09f3e3
--- /dev/null
+++ b/arch/x86/include/asm/auxvec.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_AUXVEC_H
+#define _ASM_X86_AUXVEC_H
+
+/* entries in ARCH_DLINFO: */
+#if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
+# define AT_VECTOR_SIZE_ARCH 3
+#else /* else it's non-compat x86-64 */
+# define AT_VECTOR_SIZE_ARCH 2
+#endif
+
+#endif /* _ASM_X86_AUXVEC_H */
diff --git a/arch/x86/include/uapi/asm/auxvec.h b/arch/x86/include/uapi/asm/auxvec.h
index bdde9e18f94e..6677c9ace117 100644
--- a/arch/x86/include/uapi/asm/auxvec.h
+++ b/arch/x86/include/uapi/asm/auxvec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_X86_AUXVEC_H
-#define _ASM_X86_AUXVEC_H
+#ifndef _UAPI_ASM_X86_AUXVEC_H
+#define _UAPI_ASM_X86_AUXVEC_H
 /*
  * Architecture-neutral AT_ values in 0-17, leave some room
  * for more of them, start the x86-specific ones at 32.
@@ -10,11 +10,4 @@
 #endif
 #define AT_SYSINFO_EHDR		33
 
-/* entries in ARCH_DLINFO: */
-#if defined(__KERNEL__) && (defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64))
-# define AT_VECTOR_SIZE_ARCH 3
-#else /* else it's non-compat x86-64 */
-# define AT_VECTOR_SIZE_ARCH 2
-#endif
-
-#endif /* _ASM_X86_AUXVEC_H */
+#endif /* _UAPI_ASM_X86_AUXVEC_H */

-- 
2.56.1


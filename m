Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426658;
	b=oBFnMs0b9TEaSqb7dalEvacfgahPHdJXsGTGu4VR0eEPa04nTvUtLPrj9y2Pr1etVYZg
	 XGTQ5LXSI9qfFYbZaPrlmWU/1xDwg9d7OYzXcyPBiH8qUPO5sNhjaYZEybSelLJQPMQTT
	 l1V84sgEuDHQQ7eV82RoL2iOvn4Kby06syxEBZ9zgPKU106Zq9H4Mnvoc4SM4MsgYHJCf
	 RwWlQ0JBypdJerxyjEOQ0+hT8RvAKf9n5YNXPI8cbfrJVb9+IaNJGZpZofS8PBPSUIIcH
	 dehcIF5kWQbiArT3yjtfy4mXGg6BCyMIy6JRTRS50Ak1t2YD5K7X3EyE0F5cnoYwFyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426658;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=l/BiTKNpCaOxND2c83McUOfReF7CsUOwl4ywWdEVIsc=;
	b=aHkchmqpDVhu98jZ4GDd7HkJJcvwG8OcpFnk5lZHpXWjjt9yLVlbDLmK2XSInd6r8XOL
	 Gyj/h2wU80CT9plrS/rRTUKkazMuAXvCaRER3HEo48+3RXyWlQTtm5nOpWba3rGkJACJr
	 XMG2q2o0bHsyZrmnyUNtftjixg1N7i8IPJJOxkt5sj4dEPAtLITF6Jk9pGADiE/rIfU5m
	 nsFUxgfVs12t1mnC548Dg9nu1A98CZwspEIG9HRiT4FEDe9F2ru6SVEr3IwCQrFrXqTUR
	 XxsBvUcTK2BuFuXcTsOgZ8ir3ox0GhKlT70275UFd9Nl9zZpakqciMdPwDgqjrBoV9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jkhqAnQN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KGBqyz3G;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C260A5BC5;
	Mon, 23 Nov 2026 09:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE9C260A5BC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jkhqAnQN;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KGBqyz3G
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/BiTKNpCaOxND2c83McUOfReF7CsUOwl4ywWdEVIsc=;
	b=jkhqAnQNELqjAUyPC+ah0b+ywki2lualhhUkxkV7P3TMrXvXwGyiycaGYRoCbZBpM0RcTn
	X2q9PPlCsravdT3r794YuvNNdQagbYQKFtf9bNwRN1Iu/5EZlLemXEjySqRl802oCFXXBN
	xFQ7t0rPYG02dO0BgPjMOt67Zar5eE6hJqTwbrFc8Ac6PQY+OebLC3xD9Ckcd97nVxtC2Q
	p8pcYvW94R0pQNY9SPNX3yq/qhkzYWAU70LE6jHJ8gf1Bkj3Spqu9mEzfFYbTQtQa2KpjV
	Y9THEgzS7mxC3lm/z8O4Wde4DU0UBYUi74rZ2qlM2nIFIOUzQujqAWDNxKjtsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/BiTKNpCaOxND2c83McUOfReF7CsUOwl4ywWdEVIsc=;
	b=KGBqyz3GdaK1oBFiUeoizJlsqPljXvKlT3ga2tV8p7wV+lhoSN1YNMjumnKIpgLiGs3g+I
	tWCAeCC0Wv8iJ9BA==
Date: Mon, 23 Nov 2026 10:37:19 +0100
Subject: [PATCH v3 14/15] alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20261123-at-vector-size-arch-v3-14-d342dae9e843@linutronix.de>
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
 Magnus Lindholm <linmag7@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1710;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vXjkxYJIlc0NCEosFzkpX8TeQp7Um4IKFK3k2WrdPLI=;
 b=EL3RVXJCnvkuQSc9r9Cl1BTDgl6XF0yfwf03AwNKQGGyAiPL6VTd53BWrWQo89v0CFbbKICYh
 V+VEt6hrynCCWJXvzqn4zeLgAiNjUEfCVNRVTmgGZhdW4+BddfJZUHx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/alpha/include/asm/auxvec.h      | 7 +++++++
 arch/alpha/include/uapi/asm/auxvec.h | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/auxvec.h b/arch/alpha/include/asm/auxvec.h
new file mode 100644
index 000000000000..fa90ee4f899c
--- /dev/null
+++ b/arch/alpha/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ALPHA_AUXVEC_H
+#define __ASM_ALPHA_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 4 /* entries in ARCH_DLINFO */
+
+#endif /* __ASM_ALPHA_AUXVEC_H */
diff --git a/arch/alpha/include/uapi/asm/auxvec.h b/arch/alpha/include/uapi/asm/auxvec.h
index 57cae8780d81..d21b87b6730a 100644
--- a/arch/alpha/include/uapi/asm/auxvec.h
+++ b/arch/alpha/include/uapi/asm/auxvec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_ALPHA_AUXVEC_H
-#define __ASM_ALPHA_AUXVEC_H
+#ifndef __UAPI_ASM_ALPHA_AUXVEC_H
+#define __UAPI_ASM_ALPHA_AUXVEC_H
 
 /* Reserve these numbers for any future use of a VDSO.  */
 #if 0
@@ -22,6 +22,4 @@
 #define AT_L2_CACHESHAPE	36
 #define AT_L3_CACHESHAPE	37
 
-#define AT_VECTOR_SIZE_ARCH 4 /* entries in ARCH_DLINFO */
-
-#endif /* __ASM_ALPHA_AUXVEC_H */
+#endif /* __UAPI_ASM_ALPHA_AUXVEC_H */

-- 
2.56.1


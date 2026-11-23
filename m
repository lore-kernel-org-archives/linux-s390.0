Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426653;
	b=qe/Qide5AV14lxB99Dd4sI2PVSFZiAAo7fxTIgWJldnwzsgzV8tdYdxlR3wlYd8njZ8n
	 9rBRcCY4r3gZ4y/DFUiVlz5tcO8qVYnP5W/eom+JyGj6iJFgjuFUhAqNqYBzH/e5T99gn
	 hos6AzAQ/vJ556EhqPO63L08knT4z2/67p+R+i30PhRHzKZU4QKMkcqrRbRrTGmrAb/4L
	 pdiJGw1DvLYiI5sMk397gp/23Wl+HDbvH+duXQugloYV2v2ntmWXvT/PbhXA8aP8LBvOH
	 SqNlliL4KTdQvbejFoutPso4+2pr6yVHYTN0xwv++yfSnKxIoZE3QwnHu5DqLekGyAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426653;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=OzqRCnJR602SPiJtJXTG2PDcd45+A0tgb/oYXFQovLs=;
	b=wCrnSZVBnXlKzyQiPWlnSe0M93Pc4ddCXBFvczxRouAk72AhFI8DPaAmRndy7RuXKwFO
	 Eq9XjxdJ4br1QfDrKVBC5CfNmj7OAbXA2sQhPzbmzbWdNtWBntPEBzgpN8tC4O5Btc2nk
	 zndSfD8TPbbtZeuAls0ZPRsqrbUwSJHHsnrAa0Kq9FOeVeGHS+X8C3OZbvRVux7cyaQgH
	 EiEk8K0GG4rLRC9eteuBm0NRHpiWKIWrn7dRxLAT3kn2Bv3qOILFnAucPmlB33MM7aLBr
	 7wPAruHtlf4bSHhV2HN1O81VypFgf94MPTfsEWQQuylIbYX8aBq0sxwolIaMrC4oOdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="TR8XczD/";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hoHVYH9x;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B660A2623;
	Mon, 23 Nov 2026 09:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 190B660A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=TR8XczD/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hoHVYH9x
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzqRCnJR602SPiJtJXTG2PDcd45+A0tgb/oYXFQovLs=;
	b=TR8XczD//6I1MR5e9lJz+GijeGBKJ/F77cjTzH8vVoII07f/tMCwr/xGjF4TQGtgulC1EP
	vACmE5JKgFiiOYT5KMeM2ILfQDDi13RwanO37c9TmxxeyyWSa0jXluHBhTGxRKR0Yl64Oo
	7CYJEReknofWyo9+snoBGSVkCzXAajtax1AaQ/4R5wOyeTS+P0v42R8b4YqyL/j18nRyhy
	mAwleNFjqSK+iTvML/y9rFNzZ0CRLbBTDuzjqKG2uRk179PYD2MCsPQ1UIFgLV23Hjv6Nc
	mYzD6KuLCKi+7tfSemTLaki6pb72ly81l56+DTIHo3Ug7lZ9pzlij7cZQsJJsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzqRCnJR602SPiJtJXTG2PDcd45+A0tgb/oYXFQovLs=;
	b=hoHVYH9xKLXuXyJAz+H1gDzElbvGfdJZ93NePphkmUT76//hgCh1ZCl3cIDoWvCVOzkPxm
	cENh6xJYPcEMYdBw==
Date: Mon, 23 Nov 2026 10:37:14 +0100
Subject: [PATCH v3 09/15] s390: Remove AT_VECTOR_SIZE_ARCH from UAPI
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
Message-Id: <20261123-at-vector-size-arch-v3-9-d342dae9e843@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1450;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XHafUQ8AvHq+zUf/VxtJZdze1xMjqQNOG6NhH665A6A=;
 b=oxMrqHfHeIxNkNvUbLxa7kn1LyC91rAIVfldoDncMK3YDOPceCuvoLmcVldlsZq98SdN6iXBt
 Y22qC0QCyKzCx4lysgpfyA2b5U5DJjnjaaEah8tYPviOHRifBjjXfLp
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/s390/include/asm/auxvec.h      | 7 +++++++
 arch/s390/include/uapi/asm/auxvec.h | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/auxvec.h b/arch/s390/include/asm/auxvec.h
new file mode 100644
index 000000000000..beaaefe12a84
--- /dev/null
+++ b/arch/s390/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASMS390_AUXVEC_H
+#define __ASMS390_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
+#endif
diff --git a/arch/s390/include/uapi/asm/auxvec.h b/arch/s390/include/uapi/asm/auxvec.h
index a056c4637ffc..54bbfd68d709 100644
--- a/arch/s390/include/uapi/asm/auxvec.h
+++ b/arch/s390/include/uapi/asm/auxvec.h
@@ -1,9 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASMS390_AUXVEC_H
-#define __ASMS390_AUXVEC_H
+#ifndef __ASMS390_UAPI_AUXVEC_H
+#define __ASMS390_UAPI_AUXVEC_H
 
 #define AT_SYSINFO_EHDR		33
 
-#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
-
 #endif

-- 
2.56.1


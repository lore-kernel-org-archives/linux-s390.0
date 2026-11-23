Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426649;
	b=G3FuSJSEn4vM3DyEm/OW8s+jldjypTA78tLkEDUijPoJFrQ4OixhYeDBwaYpell3eJP7
	 cz+x7WU/gse+dWgLq/CFRdZZuBRH57jHpCZ4OZpPoCfltiiNja3L6XrLZDGm+ODXQMyRa
	 PDoJf+GyjGqPn89oL9js+kdFh5c2GyzWn9ynnh9w5ow84NkgXwBiaKkCg3YVwJ/6k5vjz
	 ZofuXWVlW1iH+AODG9nP5UN8y1joIdlbcxvXrW39f7xZOXkkg4W4iNZvkmuZItVplRsPW
	 Tj+/K4xHne7AC4/zh9HPS467QhCvcAQoXqgn7KHoqTXqUX7tfHDThBGN0lHNCzbBC5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426649;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=dDtQZ0VAonHgAXv6V61xlzs7rkDt1P1WSeLVHahPhAk=;
	b=ZhkkUuo9H1uz8KMD9VJ07vK9z1EgWXChWiFs02/99fYkC6JMWuWfF8WZAOhw5YT9R2Dy
	 XU13R69No85d7UUfBkQAvhFucYab6S7NR9XS1brkirSzPh2GH7wmqfWT3+h4x3lCKfpxn
	 EB2VPOo6GgEbysA4DJGB5CJtMb3SiFQ6Uw+1n+7SIIp4tPA1fHHQoBBIw0gOKFemDLtVP
	 L06lcGnT/RLET9W9d9cfLIqbTgamLNfUPbgLBxT/kvWCStRqWSXUD8RmsC8nTpLHTrglV
	 jN54BJ7pBUtE5rTBg1BMqsCI1fIIUjjIC+UQyBjRiiMCJhDaCON+8Iig5OJVHRj1U0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0j5Gmmlj;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xKFKMpGl;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5F606A32C;
	Mon, 23 Nov 2026 09:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81E5F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0j5Gmmlj;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=xKFKMpGl
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDtQZ0VAonHgAXv6V61xlzs7rkDt1P1WSeLVHahPhAk=;
	b=0j5Gmmljkca/E2gltZCv/iUBQbTWeg/kQBkYf9XVAiAvA+qtjrKckZWXQHPA2f/1TeXecV
	/zE0P2DNvoi8HzN3ElVxpGGiQAEUlNEcd6UGF8hYrc/wSMLNce0GBczPBbKvIrUO5X19RR
	R1IdOvKig4vP9CGu5Hhx6vXZPUH55eQ55Cmk36Mb44np+ZIxlZSOLnCp0ymuePoAJEdl+5
	TwmUudfDzyUogJxAH8+mEPtUHitYqGo8y7Cn1b+rbDaEO5y1tmknjd9BzK8UJv7cfl21hY
	ru0ooQgiSTna2g0imjxfqNWRrK9ENYE5x9K6ykIbUErgd+RZ7TijW+6DyYVOYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDtQZ0VAonHgAXv6V61xlzs7rkDt1P1WSeLVHahPhAk=;
	b=xKFKMpGlecHS7QXXG/FYCxByPNPhxibU2GcZwDKmWF1WUgWqaJk6Gin5FmwBxGa5E4PlWb
	9bnxn8NrLGCuOXAA==
Date: Mon, 23 Nov 2026 10:37:07 +0100
Subject: [PATCH v3 02/15] auxvec.h: Move AT_VECTOR_SIZE definitions to
 linux/auxvec.h
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
Message-Id: <20261123-at-vector-size-arch-v3-2-d342dae9e843@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1309;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vTIIJIwUFOUw6+gUJjUOc4a2N37x7HojOq0oR0BBlzg=;
 b=GyKn4Bxu+C22SecrgL0rmVE25rtNo0/nZVqR9YcowgOuG6XWN+hFQ7LVwF48ESsfl68yPNaNg
 5OD4YumxPGrDTLDcZ/xMG4kmg7ZscPSTHPCE8zZxHWIbEnZdxHW3/L6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The auxvec.h header is a more fitting place for these definitions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 include/linux/auxvec.h   | 7 +++++++
 include/linux/mm_types.h | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 8bcb9b726262..4b364e639f08 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -6,4 +6,11 @@
 
 #define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
+
+#ifndef AT_VECTOR_SIZE_ARCH
+#define AT_VECTOR_SIZE_ARCH 0
+#endif
+
+#define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
+
 #endif /* _LINUX_AUXVEC_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1ed35d258d2e..c75626c5aad4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -26,12 +26,6 @@
 
 #include <asm/mmu.h>
 
-#ifndef AT_VECTOR_SIZE_ARCH
-#define AT_VECTOR_SIZE_ARCH 0
-#endif
-#define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
-
-
 struct address_space;
 struct futex_private_hash;
 struct mem_cgroup;

-- 
2.56.1


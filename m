Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88242DA3D;
	Thu,  3 Sep 2026 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421291; cv=none; b=V3+4C9L5kEGCJxeC7C29zxUJoS1MX2BdWoAEPrBUSXNOAME5vgyHL33mxLzW6+rlii9sBWJRq7vytZbW7nHUFX4VU32K7Ki0lnSrrbfT9hcZKa0x7j2HoKqQVsbUvo8M3eKVGyHhEuWh+0+n5X1XCOyfc/4E7x6knhUEOFK3vXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421291; c=relaxed/simple;
	bh=HWrppGtlxN68+J1EvLurdbOmIVycSJ5y0ost40gYay0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QH9NDb36Jdh7F2TvjYowKZ0+T5kzFWJP8O2407Jj3fHG6uzxV9XFm8GNrpSdrAx9WGthYuHsxudcZ5DKp3vCIaORXP1Rj57F3z8R2DLejdPr3A48Y80Yu+mkF10VTZBCQg7//afRPWJuh6JDP/D4ghwEk36LrciqUFNvg5Ka+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wnd6QEH5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3zO6Gdlo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wnd6QEH5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3zO6Gdlo"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzk8S7GGq/mqM3W6SmaZkZnDg7V0wPqYFRG/WWfPRl8=;
	b=wnd6QEH54/BjH3IqL+NmsSLdPMkIm3Ol4UY/fevb8PsoirNu25dRIf9FyoBeO21n7ryuiB
	4q8W5smEU5SP2xUhtsmAPB8t1AyD7BOnfk9PMF61YydeJW57H9S+LagF4bPuQfR4881WRX
	/4oCAgEv/Lb/GUwIYUiN9M5C/Nq2KJrUZLyuYIxmNF/rXmTaHpNExOd8dL/nTrYG1A8nqS
	1IJmvplNWiUa6b0Q2weqH1mz/Kn4SalyfB2YijMQ8/Vpp2jtuXuQxHZdB3BjakEgFTGG1+
	IzqqSnX5CGvvZly/aH0pQFeEH4/dWYMPZ/63MP3uHm5VaD0VlSxBYQTUsX1SgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzk8S7GGq/mqM3W6SmaZkZnDg7V0wPqYFRG/WWfPRl8=;
	b=3zO6GdloI0RIRQIUARPzBVJ6Z2WmANTijL9R9i7Ce0cPzMjNreKcy1VLDJ/BIWuW6HH1xn
	nh/lWOAWzbhNpfDQ==
Date: Thu, 03 Sep 2026 09:41:17 +0200
Subject: [PATCH v2 02/15] auxvec.h: Move AT_VECTOR_SIZE definitions to
 linux/auxvec.h
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-2-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1309;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HWrppGtlxN68+J1EvLurdbOmIVycSJ5y0ost40gYay0=;
 b=QtuUd8ndQfte3MxNSIPeA1ceK7WkBDpTjXLL5fb4pzWRDNSz/qxqD4exzasiSFQC/0O6qJggd
 TikOW26FC/0DEludcoZTMbhvBJm/noFxtE6Oqd7XYz5ZG5OybqRL4sw
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
index 6d815f6440c9..08a06b26375b 100644
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
2.55.0


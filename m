Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61436C9DA;
	Mon,  2 Mar 2026 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454348; cv=none; b=MLlmFRvyxPkmnpp9CLoohhW+0MFGuY1OWPoic8HAKlpTEYi1+rpE8RNDIqLS8Qi1rwHnyl3eiNssA9awtHk5ktAY2mXrI0uvIlmaLxtEfF5Q3C7v7tfr0f0NEAiE2atwuVdAqx71U9q5dRSbUrqDAkXDxuqVZjbnPDMeJjyiVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454348; c=relaxed/simple;
	bh=R6dPuK9hTEu2wzxXNEaPtc8TE7i9ikP4nTJiTP9bZT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=My7OKZ08AselRg4FtG8TFLT3yMv7JGCBjUQGQUBuGXfoRueKdzs6oYImQLUu+IGSAmZJykPqgWwthnrApamh3nFOgabsI6M4oCwYaK7oX449X0YE/gb794v9wJjnzzw9G/rNC6rnuovKZXmz71N19y4zO2bQWr07nHN+xecZqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZRJF2/RI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0RhC5Fte; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZRJF2/RI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0RhC5Fte"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772454345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgXUWuBQc37HPqUBgBljEt4K1lGTSpiCtiKFdFvnpEo=;
	b=ZRJF2/RIYlZzXdvvP4EyC5ziS1eYTGNaiCpGWGAlhlhh6WP8XJtMwKY10FScMfkRk07Kpn
	WAm0HrLrPe3V8GufiCyKFmoR+hIoDakEwVJRmOfrOG1vTfDvZthRNy9j1FqSQDBSumosRb
	lSJyQo7Ek9W6Irxwps/fZr6+32MXQ1g940bY7aUn2wgzoOpTYYGfSmYo1TtUi2eNGBzDXQ
	HoOKG9XkKlO6Lsynm5IwDc/mDANODBHa3D+7XWmQ4jr8Z4GRPHRxNIFyYedKVrZJWzUsgn
	Xi/TXpXkeaoOKoyyrYw2RkYIhmbqg4P5rd78zu1pTPRTbMW07FzruR62fY8Dzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772454345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgXUWuBQc37HPqUBgBljEt4K1lGTSpiCtiKFdFvnpEo=;
	b=0RhC5Fte5zjulHI4Ol2L/ovJ2Kd9lvvPGCNYvwBDoFq6AG8nEkIzJV8ldugwY4YHFGhnle
	Y1e4YJBTshKAKTBQ==
Date: Mon, 02 Mar 2026 13:25:26 +0100
Subject: [PATCH 02/15] auxvec.h: Move AT_VECTOR_SIZE definitions to
 linux/auxvec.h
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-at-vector-size-arch-v1-2-a11f03ba2ca8@linutronix.de>
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772454343; l=1267;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=R6dPuK9hTEu2wzxXNEaPtc8TE7i9ikP4nTJiTP9bZT8=;
 b=ZulijLjkAtvEzMGw3cQEKThTnvyrB3XWkn02AB0dxIROztyb5g4HrOCwXizPScG4JZMtRLaOM
 3hiDIzMjiB4ARdfLbg+OTnHYu6B/6h5UxzpDiSphCOmDSpy2QygkNcG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The auxvec.h header is a more fitting place for these definitions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/auxvec.h   | 7 +++++++
 include/linux/mm_types.h | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 407f7005e6d6..943e8b80b41e 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -6,4 +6,11 @@
 
 #define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table */
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
index 3cc8ae722886..64019dc29f4c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -25,12 +25,6 @@
 
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
2.53.0


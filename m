Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426658;
	b=LiKR3qBrfguMId1Hux80B5G+IwE2oZM6jkoGIHAhWGe1NVPpKZvbdOmgb1KNIBtudwJM
	 o9U/KOynNne/qAAnFnnc+y9rQLo1/PXwhNLThOuGOZf2Y52O1P1HKovYRND3B05NU2+Ei
	 PW9kdDbxifvXn4eZaJW5XxlVfrklna1R9kG9S1Y7pTCgUfiIWYAVEnhQz5GAxiGo8kCEn
	 WBwU9x91UlMfxZ9ktD7foGr3Blp7ecRarADeD16tgb7TX5OujIVMT0bV2c3GuTQaC2BDT
	 C18AaZFbFgkNgs5+AYDA22RfCL87xUACDi8U8yjmoimgDee+ThlEXjGMkYwQ1DWDxJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426658;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=YWYGWS4auZwM9Q07LV23QUYJ6/wrrSYEmZV3T9JL0KQ=;
	b=zn3UHYfqcw96YQNS3WxNHHgJq8xE5rAWNDezG9gzgUSM+s2X6f4q8g7OD9p8fwQKZ8Kf
	 b4B6t8R+8rgOKbdvJQBnvTkzZJjyVaGPIZuuQ57NWkh53DunjjqLkSs1pCOm+7IsHbUGQ
	 yvY3DWnp1uF/1+KmuFa27VajLga+iS9UoD3hZRcgv/9ZNKZcEGZogdayC6ysK3+m40LAn
	 0lYfjLFBxTdk/JJo1VxT3HNWpRvimRKTzUqLqxOBOvVyp/e8U0sQTtbVdZKkReMnWM4Wc
	 pxIcvYa8JLg13dETdiEXQ1zcaPklbcDhLZ4dO3FaEITtRsnMJrzhdkQEmKGRUFuOc7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=auLbbl2o;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qMqMlGFZ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E760A5BD7;
	Mon, 23 Nov 2026 09:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 566E760A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=auLbbl2o;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qMqMlGFZ
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWYGWS4auZwM9Q07LV23QUYJ6/wrrSYEmZV3T9JL0KQ=;
	b=auLbbl2oH4Ot5YpCeUEcYQ2dIFo74raPeSEpSgBeepfy72T3dv6ySqNZw8grm6xlh59KuT
	i7WWn60yQYtSqGOjySH/D5mPaenZdFLjQryxByxKOS8oKkotAVm++xQQ/BfFWq0WydplG7
	Bc3VI1YdNWooahhM59wa1198KWdmK1pmX5ZxVOlwkUPefFYYwSOgHhVMfbt1yaDxsxTQRw
	QvaT84wAf4K0nwWClg3Zan10Pwtp9aucgSxaEQ4bzDDgd19eRgjLZOyFQ8fPOY8Qe8yEg1
	B/xsSTsGNrZ0LAIMJP7x7jGA7J7+iD6ijUD8C4UHQUeo3CCHawC1aw7IuMaVeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWYGWS4auZwM9Q07LV23QUYJ6/wrrSYEmZV3T9JL0KQ=;
	b=qMqMlGFZf4t4nwAx7Fj+UHvCQee1C2mTmihf6zAwsYxwJeLug2K+qgxMTQI0UA9bbmc37v
	oXm3bpJIAE5VGxDg==
Date: Mon, 23 Nov 2026 10:37:20 +0100
Subject: [PATCH v3 15/15] auxvec.h: Drop fallback AT_VECTOR_SIZE_ARCH
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
Message-Id: <20261123-at-vector-size-arch-v3-15-d342dae9e843@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=772;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JAUB4d6w3tpvVvnJFyNZBhcXBgmmxi5dKlrBgo20+M4=;
 b=kCgAOd1xOlVd/uE/bDzZYB74ed4Qvm9zJWmY1xGZI3IKoxs4346rY6+SlaWFSlHZ/Fy/xnAaO
 7YsjYIIefxeCjUKx3kra6gHNuGjcu1KYMGOdN3sVIQWVAqnwsOe+Hdb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All asm headers now define this constant.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 include/linux/auxvec.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index de1c33c4a256..f7ddea1dbc8e 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -9,10 +9,6 @@
 #define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
 
-#ifndef AT_VECTOR_SIZE_ARCH
-#define AT_VECTOR_SIZE_ARCH 0
-#endif
-
 #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
 
 #endif /* _LINUX_AUXVEC_H */

-- 
2.56.1


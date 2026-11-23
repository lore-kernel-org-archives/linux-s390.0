Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426650;
	b=NFHGezJ9OeZHUhOsIpLW5c5NsxlIRmnwX92CAfUHBdoNhGT3fHsNXqRdmG1iZAV4+2IS
	 3SjUJWfgWquRQn6aWysVv7dbXM61zke3+fdvOjkeiMDCegdEt/ggQV2YiCembUfeKPAt2
	 4c703ZRMqhGhY2cNdUuZugdpm3bXXNr59q2xxLExYKnBTNv1GqMFwb/qjK5/72NzbsziD
	 jcUCthpG183O5D3kTSxGCpgB7VeOj2J5ZGUV3bfVW1o4u7ufWpq0XOdwV4bXlJRzs5oIP
	 BI9ngz3AcxJdznZ2vrzbVWaICxq7Zx/K6h0c9xcP7mFzLbl/vtrZ7mR7fqLXHDh+8eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426650;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=NCInxSxfWY/baS2gA67JI3oLj7pEl3r5Kks368DptXU=;
	b=Euk6OPMqJ1pmG65ooSAdtw0CC6ifT8iCYUDEPK8J+141D5yYbYSQeh5zvHPT2jSHttGL
	 szN87GSJJaydxSLuMav/uowx5CzL5QlqtnDM52P5nGAYm/BrYDuN37Kf/XUL6Ba9DPBJ4
	 orKApiZ/vYmdQLS0FrXfh6f8YfotA3dalsQkZgLqbeCwX4+U5zdjSZVp9GIHbh+j7xOWg
	 cOCwJ0Tx/AxZNUwUDmoy+7AFfahX0zzjHI7SNK0DLpwh8M7Zl+xX4nCR2gtdS2BaSOWCn
	 bB5P17Qn9e3SRPUj77FXY5XTnyJ8S80TMdd+1uF760sQAXFt6ZWif1bt5WhzQUZ7FeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vjEARtx3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Bv6jhs2k;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBD606A697;
	Mon, 23 Nov 2026 09:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7DBD606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vjEARtx3;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Bv6jhs2k
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCInxSxfWY/baS2gA67JI3oLj7pEl3r5Kks368DptXU=;
	b=vjEARtx3r8J59QJskATSoUZ4rv6pYKWSlfmjme3JMa5M4SMhc00pFtHMCDgyNo/RDm/jek
	LH4qTgii1hs/98kIl27mTmqCtZSi005DRO4Cjlc2DLVLNphLx+AmEpvn/Bo0ob0YX9+pRi
	JKPkk8wRQhRAMHgB6Hz4v/feQB1i6l2oWyVL0g82/uAuUTmASb7KSJTYlmmOGlOHSxLuDI
	qTwLjbVU4BCKhZW3Nr+zS+wL99k9eWL3ahDiUUJ9i066kUxhW342oFJsKah/cVGgfHJMKU
	gagoIjvT4cj9bTpv6rBImolLvfLwtzW6PjLz0ZdIa6vTYCH59nQyLSTMVlIjwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCInxSxfWY/baS2gA67JI3oLj7pEl3r5Kks368DptXU=;
	b=Bv6jhs2k/3Z98uYG/xj1eKvxvDv2iFmRJNmQwdjgG+GwwWdPZh42RSCDYrGiOJfkoCQKPE
	FuYdk9Hk+TZrO+Dw==
Date: Mon, 23 Nov 2026 10:37:09 +0100
Subject: [PATCH v3 04/15] ARM: drop custom asm/auxvec.h
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
Message-Id: <20261123-at-vector-size-arch-v3-4-d342dae9e843@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=523;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QV8Zwqe9GYXvbZYqVlVdwaxoS3NHmxQrRwiam48wlog=;
 b=fdt6Vfk48wvz262HQNr4SmvfAA10Ohk3rYDAIpAbpM/sJECol2LaeV8FpmmHNEQ1ymuzZ847s
 ZXFLZX7e+kYChBQotTOoDfC4e+OHkTMGZp7VlhKb0y5EVgfS9lHxPxn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With the introduction of asm-generic/auxvec.h, this header unnecessary.

Drop it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/arm/include/asm/auxvec.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/auxvec.h b/arch/arm/include/asm/auxvec.h
deleted file mode 100644
index fbd388c46299..000000000000
--- a/arch/arm/include/asm/auxvec.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <uapi/asm/auxvec.h>

-- 
2.56.1


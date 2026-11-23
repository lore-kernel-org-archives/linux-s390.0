Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426648;
	b=LNIGPM2Lf5qUfNE7JIEJq62G86FSlJuhs4BR8pvLLwGnqam+5cvTkzx7DUjFVfoQ6Tf/
	 /iBIFXAXn435zKf6YDyjzA6a1b9m53Tv/Moiz9ePjHKPGgg8KIM3kMN/jmx4TqRDHg3yA
	 r6UfWWSwURkV8ueMsioILtMD1jRHkDd2kvZVs2G1vBi69rzAcgENNo9HoiXvyMCVCCghp
	 ZLTDHTJq0Z3CoLhWPtqV9JoQC0fiYSf/HcZ/VsvnzOYUgXrskPT9P470XD/CG4jlGcdMU
	 2OAddrIIkh0iprNZ+WPCjtJsJ/QoBVQyBR7DD8Y2NwWZ/V6xGBcFivp0W20YTSWDRmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426648;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=E1kpH9qtmZAMmYTBOk6CnIKFezpBGJI84FmVahSpOrc=;
	b=v7MI2G+WLBer/WgWHaeL0GYzYOB+UNEVEQcx4/bVdfCSOB43XFryPNua06YcQjJH0Dfs
	 vqxDo+mZPo3GAQWRfvFbWjj1SZsgoxYt+gLf+yLQ5XFwXKm9o5YOGfBqpNmDcUXX/lBfQ
	 Ipfii489lVd1SUgT8yVgS6SJGt+LRVBrwaXGdbC4VEmx/RwUb6hgkKptc+0JMkoRurP9o
	 1cZ1N543kTxm0OWt8OA9fwdSnJHuboZwdRqYRxEBaMdVsrxZyU4+QYZzjK1p1ZjrAULaa
	 i3EPgFrl/6IukpNAcRGRWYg+DnxiYcemoS8cJvRgFatvK1JlX7iFDWXkLX9p1SUUZIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kEyAOZ+f;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="lIn2F/rY";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C8606A327;
	Mon, 23 Nov 2026 09:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 318C8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kEyAOZ+f;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lIn2F/rY
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1kpH9qtmZAMmYTBOk6CnIKFezpBGJI84FmVahSpOrc=;
	b=kEyAOZ+fXfpEFfXli9cKb4jaOvep+YD+wGpQAMUQQojZWoFAqgtWYb70a2ykA+VO1bRedq
	xJ1z/x/EoR0vCb1RSKcWCP09fC16ImShi/WU9K9AboAh6Pl6VYOpQX7L3Va0rbVF8sRgwZ
	j1VkZWwgTUUpmxL3P+j222I9Hpz4yBmTIIBjdDdZJBGCITy12dETeke7yfjVz6eOwfrX2T
	qwIgn0zPKXkYeYkzAhQRrFUZf3oInFDCx1beSUFl6BqCyxq769Dp3hpWe19ngJScL2Wjxr
	jwMUd1tmM8P3eypY0Zj/ISZvHtFUuVCqtBxqaoGWMGH3MzUX5NwVGjxH9YMJBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1kpH9qtmZAMmYTBOk6CnIKFezpBGJI84FmVahSpOrc=;
	b=lIn2F/rYSSMxABLTJM4B3AbW/3uEZC8vK5/mSmfekSgDDXw9MHlSZZVoCJyH3+Wc1EX+Zc
	QINruovqqc4qHEBA==
Date: Mon, 23 Nov 2026 10:37:06 +0100
Subject: [PATCH v3 01/15] MAINTAINERS: exec: Add more auxvec.h variants
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
Message-Id: <20261123-at-vector-size-arch-v3-1-d342dae9e843@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=979;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hyCnjfQwzbLi6OQVQUQL35+BD4s52Bt4na4vvI8iM88=;
 b=Yd3vnnMHSBep+pRQRmyi1AA40DEVjxA2c8/dBeFWV4J0rKudeRDSHvhOeNFfw6AFADdjfzkJf
 OYY7DU1b6DAAWfLpRxBPgKDgCI6NtpX+tyAlSPU38iJqHr9hcKiFypZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There are quite a few auxvec.h headers. Mark all of them maintained
as part of 'EXEC & BINFMT API, ELF'.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..a659c9bfb0f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10073,13 +10073,16 @@ L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
 F:	Documentation/userspace-api/ELF.rst
+F:	arch/*/include/uapi/asm/auxvec.h
 F:	fs/*binfmt_*.c
 F:	fs/Kconfig.binfmt
 F:	fs/exec.c
 F:	fs/tests/binfmt_*_kunit.c
 F:	fs/tests/exec_kunit.c
+F:	include/linux/auxvec.h
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
+F:	include/uapi/asm-generic/auxvec.h
 F:	include/uapi/linux/auxvec.h
 F:	include/uapi/linux/binfmts.h
 F:	include/uapi/linux/elf.h

-- 
2.56.1


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2D4854F6;
	Wed,  9 Sep 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943901; cv=none; b=qg9zlOsPHpfaoRj8Eusx8o3d8t3b0BxbilHpnz1dacjEmCoG9ZfytjuhU/ZZvUlDrPqTYywi9uImkd/ThHO89XlUBAZJREE7JQu9hyIgOwbjS0d+6afPdq/fIhy+OcWUbL/c8Ft0AgsCi0zexau1Cqfb8JoJ2Pw57pzF57D90/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943901; c=relaxed/simple;
	bh=p+b8xoqSRp+BaXpuv6UkhI9jSr9haopNWgF+UmEOVQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nGGFgaDWdonPS/rbMS3tkFmTNIEE+r40LeqV8Zs1eODpb6mFKx5s2w3KQxW5GM9a9E07dNUzS8gdVZ+mukO2jBpYMm+Px/Oykciv8AsGHbDbUEEuSP8Wgg4uadyRCRrSs/zAWiB5J5y1+HayLTm/gPIryNzuDwqpf2B8QDkpgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18ypzorm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V9tYUFNz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18ypzorm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V9tYUFNz"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sC8+6J9OLUakbA4e+Ap2B6uuZE9Tl7PwTVwk0psJD7w=;
	b=18ypzormw89rOzBf6uIIHYH1wJOPorGI4jxdXBGhkEdBQPZOLIVTm3KlRtbdVDtdGj9VG7
	Dyjho9sIcBEasT5u31Y6tYFz04xKu20FzftA5gy6Id8NhHbhfJut0d0PS+7ZjetZKmijCh
	u/3olgtjrDEgB4C5ITT4CpG3VJZ5DK2VcHCG/wOlxBKI+jSGLQNOi+m8a9Y5OivTRfFyAs
	2pKxnMgQ6QXgcLRV+3MsRlunL77unXFK+hIJ7P2eCY8PBRsZctieqL2rbr4yWOsH/yijps
	0oceS1P/fPh3YWLS+ARzngBQRl6bCpKYgOPJXYvTIYdpTZN4WO39XXP4Yc9OKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sC8+6J9OLUakbA4e+Ap2B6uuZE9Tl7PwTVwk0psJD7w=;
	b=V9tYUFNzgGBunIsna6vZfNbVMtIIjvl+n+kfHtNDv+819iutT7PUqChs4OihB+GRdxuasV
	MJxc+Wzwhfj+biBw==
Date: Wed, 09 Sep 2026 10:51:22 +0200
Subject: [PATCH 09/15] sparc/vdso: Delete asm/vdso/vsyscall.h inclusion
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-9-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=516;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=p+b8xoqSRp+BaXpuv6UkhI9jSr9haopNWgF+UmEOVQk=;
 b=M4PnWWjB8PtId1XPU1zVCslJBTDHYh9V/L0XSbIVM9OptHzq+tq0jklWaWwKlEoUCNwkyM6tW
 rJ+WK8pnGurDoAd2fM6SfaNEA6DETxYOyV8t6MVuFm8YlCVyu8Tziow
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The inclusion is unnecessary, remove it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/vma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index 60029d60f4d3..ab6626c1ee61 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -23,7 +23,6 @@
 #include <asm/page.h>
 
 #include <vdso/datapage.h>
-#include <asm/vdso/vsyscall.h>
 
 unsigned int __read_mostly vdso_enabled = 1;
 

-- 
2.55.0


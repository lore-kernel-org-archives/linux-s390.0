Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3448C8CE;
	Wed,  9 Sep 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943905; cv=none; b=YAutYKeoHS/mfWNNX+YtTWx6ZLMTKpOJOmKsihp7vI2vrVaXLpnYv1Q9e5PiM39ycvNHnZcLhR7WVnQStmJrv/Y3ryeAHvjraFephO8Ju2wQaLus9UAc4pZJqM80HPrExv8PR6CutsX99PSkFl72EH9FnufaGagipTm8pjtzklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943905; c=relaxed/simple;
	bh=WJuW0vHAzgVK65zYpMsMpkIoWVAhRqBIQ43ugL+Vfgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bM2U3r4LYn1tOZsj4L+ulD5XARPCJ8ZLAtH5EpwmoKQxSVOVDxDDH77BlzIh7e23c2o75gVbQWtPz08ICF1DMwdvJFLfcgg8Fr4w35oWSgvhoqy7OBCn95BBk//fLr7XpRUyVk31wn8G0o50qxwdfYji0ckXBWYJJnU4pZwuqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JaOyz+Gf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5gKHnSv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JaOyz+Gf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5gKHnSv"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BSSPIkVsfUiGZ/2/7JQoGktT3Bg/qW3vWeVl3H8t4I=;
	b=JaOyz+GffrY14/vqZR3mc3aRHefVc9sKFST/Y+iv6y2dWE5XkrXmA9ZJsAgqJ018f/vug2
	cBMChuc7FaXyUAF9yQKOHxlkPemVJ32YoyN5tLBaH5C5wxOmAtxy0Ukobemx+5ORO7uFfy
	Wiu0MtImMa+hOKQRUZBdB84qZjgFlKRYR7h4fdWiycJ85XrjCvCyV1y6fITwXy11WldYgg
	+vgzkpMELO8vXyECyskLAnuY5vVpDRCTsaR+01bT+hpNKuUJVRHkC5wWfCgNEJWMjBkGqg
	t+9mVcjwwU/JEljjnrLJ3bJK/1yy+XyvUm48H3zRCFfkamQLKNoJ6UlylCYASQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BSSPIkVsfUiGZ/2/7JQoGktT3Bg/qW3vWeVl3H8t4I=;
	b=y5gKHnSvh3NyUEy73IKx6RfvsCL+Ha6mwmh698IzxBvPV1anfbtnSec1fGWt7Tg3vCMaSo
	l6Cb8RNPcUh7xvDA==
Date: Wed, 09 Sep 2026 10:51:25 +0200
Subject: [PATCH 12/15] riscv/hwprobe: Include vdso/datapage.h
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-12-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=814;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WJuW0vHAzgVK65zYpMsMpkIoWVAhRqBIQ43ugL+Vfgo=;
 b=3v9PIQWIfY59Utoqf3u0a+2xyzC3K3qFiLXNZMe7AgOtEielmjn6RIPlrTTQkKqzrYA4P+N4f
 jrwA4Hzlo03Cus2D1tSaBop8ClV4dFKjXJ96j2IsAFgQehGy3G3Rb0w
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The symbol vdso_k_arch_data is provided by vdso/datapage.h,
which is currently not included explicitly. An upcoming refactoring will
remove the currently used transitive inclusion.

Add an explicit inclusion.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/riscv/kernel/sys_hwprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index bd6ca7d769da..0f42101ad935 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -18,6 +18,7 @@
 #include <asm/vendor_extensions/mips_hwprobe.h>
 #include <asm/vendor_extensions/sifive_hwprobe.h>
 #include <asm/vendor_extensions/thead_hwprobe.h>
+#include <vdso/datapage.h>
 #include <vdso/vsyscall.h>
 
 

-- 
2.55.0


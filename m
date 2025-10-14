Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7B29B79B;
	Tue, 14 Oct 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424557; cv=none; b=O4SL8Rrk2iJFHd3u7GEZCtXbQ3VC/BnZBtFdnNxkLimAj+HhacuAXGDDarTaE1KU03W4KKGW0aUlSV9iqsoIwRnyc5caDVkGo1VNjYPDKM2h/PEq7HraasPFozszXuXd9jWyuS1E3ef2m2akEwjy//gvnT+ovNzCLpNCnRgADvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424557; c=relaxed/simple;
	bh=/RM2+eho8hCHlVVsxMDHxgwRFdNnaqJNQrWh/y7GNvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MajT+C7447+lzSFaiKWziErySrVDVT90NiLeW1XKJCkqkQJrp7iBNB/+mxMRocia5vErXOLh2QUf9n0z6Pm9wLDMmQpwxWwWt3Qj+GX7f5xr1NImoyi75ta5dSydeJoB7KH6EQfzKm6fOsY/vknqA10O2wQ6RnVYXq750IULDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MAjI36Y2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JUFmi/+t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MAjI36Y2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JUFmi/+t"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYjHCuW3ZXlc6zM24pgVvQhnKhBaDHM/f7Xd1AFH00Q=;
	b=MAjI36Y283+dXlEtxfAzdph4Pel6t8l6YGuCTP11JXsg6aRhE3b1AGwDIAlpF+lyqIfx9C
	s+cjFOIjmmGXokhUxf3My7SWWEQIZDhoFAdnbPXThWMEhyjkFHw1AkRTSkrGb2Xnfw0vYM
	b+v1yG8xrAgrkauiQ01otJY+jwE6oBiXwGa1qssi9iN3J94OQZyLobIrdOroNzi729VPPY
	kyyXhR+GDsc7mJPRD/qfgNDcL7W4mjs+UQiEX1Jy1T/gpmYw5uXtaiE4UHJoS1pRy0eL7h
	m7CWx7ZIxnNb+nQQGhN6wwJU2/zMncnoNLl2+CKasi6iBnZzIyyI3Vaa8nl9TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYjHCuW3ZXlc6zM24pgVvQhnKhBaDHM/f7Xd1AFH00Q=;
	b=JUFmi/+tfhZ3CvW1S/ZCTu9YNZePfk1cYGvLNKTIafHWUzOiKAJXrC7eqzNJ9w6d/YqwDg
	2RqTYE9cSuJamaCA==
Date: Tue, 14 Oct 2025 08:48:48 +0200
Subject: [PATCH v4 02/35] arm64: vDSO: getrandom: Explicitly include
 asm/alternative.h
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-2-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=1038;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/RM2+eho8hCHlVVsxMDHxgwRFdNnaqJNQrWh/y7GNvw=;
 b=rjBCL/3dN6qPvUJmeUf+7JAVFBhUTYgdMTkfrSYQKsl+OmAQA2K02NnEfLgFpDeniiYgrvOsH
 uAKOAyqPBSxAYX8qmNwl563gDjmeysj+ss0ST5F/ep57HRa/GwRbvHk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The call to alternative_has_cap_likely(ARM64_HAS_FPSIMD) requires symbols
from asm/alternative.h. Currently this header is included transitively, but
that transitive inclusion is about to go away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/arm64/kernel/vdso/vgetrandom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/vdso/vgetrandom.c b/arch/arm64/kernel/vdso/vgetrandom.c
index 832fe195292b34e2029f593ea170347c98e06dac..0aef124c90899dc0c8956b0f32f54992aa3acf0b 100644
--- a/arch/arm64/kernel/vdso/vgetrandom.c
+++ b/arch/arm64/kernel/vdso/vgetrandom.c
@@ -2,6 +2,8 @@
 
 #include <uapi/asm-generic/errno.h>
 
+#include <asm/alternative.h>
+
 typeof(__cvdso_getrandom) __kernel_getrandom;
 
 ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)

-- 
2.51.0


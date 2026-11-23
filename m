Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426649;
	b=V5KBNB6PJUsxhfH+3ELthzLMb5SzBxVbd6z7AkCtgbYsMrLocVXiUyd3/Pkjl1hIEl9b
	 di9Nbj6vHVJ0TCOXKlPdTD1F/qpR7gmjtthWUBkR1s1wfK/tJqmdokAjKVpVULD3P9IMA
	 5SpBOPByErLurb5QgHtgxrTqTbKROd4vJGhkzA3r2UnehDCZ7Ke/j/eoaItOWMdWM5+R1
	 s9Cl9ll2ZkcRqml4roTPB0Gp+5K8kXTf+56sxg9i82aUOqLkD7OU/6wTAMz4NVIGckDT3
	 OVBWMexOkBLpw+zzAvJu+dCbh/oInY2vDIQEJsAoJyW+YnsWjbxF4UyWVnLpJ82nnWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426649;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:
	 X-Developer-Key;
	bh=12rCIot4Q1y046Vzp8EdeFdJZwXEj1gxqogCrSz0YUU=;
	b=ryP2xc2LkOx9V9tDgdpBxwOlPXOVnC00JKiFg614cwAuLsVujM3QV2ieFQfjpDX5GYbn
	 ABufLS1r5/dlgbKI8Z5vGpBmYA9RBA81a+YYS5YYFZ8keDMbKb8qUaV6KkBE7rwRbRT5X
	 93NS3fOv+wzfCROo1UhRlo/RA5sCy4pCjiCl9036JrcMsjglWU60lDeInxBFAe/GeAUTe
	 PaMO2PTp1jkRNJDrqeV7HaTGlGHw11B+FFXvInO2wSTck8+FXWPSonqa9UQHXNUPNO+f0
	 6wmuwvT/rd2VHov0MP9EnyTAfvt153W/OQaYwd/uMQImC/5T+MP1LA79g1iD+3e/Nkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eVR3Ru4Y;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=fb+iCiKk;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBDD606A31F;
	Mon, 23 Nov 2026 09:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BBDD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eVR3Ru4Y;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=fb+iCiKk
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=12rCIot4Q1y046Vzp8EdeFdJZwXEj1gxqogCrSz0YUU=;
	b=eVR3Ru4YMLUxoE2oBeLnHegybGHZ1wA0UbD4tiFIxf5sSlq+p3wJdzZpk1ObDTCcQrza1z
	sy98hHXx+8xzinXaJ18cQFrVUiJIc/UcxxCx104dR5eQpHKjKHCYzESkf81Gf3OdfKYFU/
	eii4VqnD+bVQRxDevExQLyGum7btdJKvvpx3Yr5ardHDzDIHP6aGihnfy+77XqVSz6ZQgt
	47xh6w/Vwimk/bHTNf5kdhLgywTu1BYGw396QHdIBvHSpQXvrSULdDcD2Khd3VZ6kMCHkn
	cKpXfzLviy+wczOkqv+t1GeRU7hURAtZmDFbfCzTh8szA5wnR/Jki6meRytmbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=12rCIot4Q1y046Vzp8EdeFdJZwXEj1gxqogCrSz0YUU=;
	b=fb+iCiKkolSfl3maExBNRcPmG1YtwmtD8FIgojBmtd/T7xWBvxDvLsmVcOv8h0gdh8FVpL
	vvdYhx+u/oAeYgDg==
Subject: [PATCH v3 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Date: Mon, 23 Nov 2026 10:37:05 +0100
Message-Id: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQ6CMBCF4auQrq2ZTiOCK+9hXJQylUlMMS02K
 OHuFly4kOU/yftmEpECUxSnYhKBEkfufQ69K4TtjL+R5Da3QMASFNTSDDKRHfogI79JmmA7WRI
 4pNq5qilFXj4COR5X9XLN3XHMg9f6JKnl+vU04KaXlARplHKgG4PWVOc7++cQes/jviWxmAl/T
 g1628HsHBqr0RwV6fbPmef5A6qlb4UCAQAA
X-Change-ID: 20260109-at-vector-size-arch-6e0f2e9ff8b6
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Andy Chiu <andybnac@gmail.com>, 
 Magnus Lindholm <linmag7@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=3299;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0K3qhqEWg64tqQPsXMhmXxkKgiRN0V2EEQPpHTYxv4A=;
 b=Fe8nQiRi3Kfc2ylHmmPvMPRVTTjkYlaqoKTjn4kvNkLesW4z62H7gN1D51+mJJRRBnWysks5K
 2YBQSucEVjaDRaSt/FqXQnlQcInw1lzhzM2T6nWBTe45/TAM3F1ehFZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to kernel-internal headers.

Meant to be applied through the asm-generic or execve tree.
The default recipient list was huge. I trimmed it to only the
architecture lists.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Rebase on v7.3-rc1.
- Fix some include guards.
- Link to v2: https://patch.msgid.link/20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de

Changes in v2:
- Rebase on v7.3-rc1.
- Pick up tags.
- Link to v1: https://lore.kernel.org/r/20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de

---
Thomas Weißschuh (15):
      MAINTAINERS: exec: Add more auxvec.h variants
      auxvec.h: Move AT_VECTOR_SIZE definitions to linux/auxvec.h
      asm-generic: add an in-kernel auxvec.h header
      ARM: drop custom asm/auxvec.h
      x86: Remove AT_VECTOR_SIZE_ARCH from UAPI
      arm64: Remove AT_VECTOR_SIZE_ARCH from UAPI
      RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
      LoongArch: Remove AT_VECTOR_SIZE_ARCH from UAPI
      s390: Remove AT_VECTOR_SIZE_ARCH from UAPI
      powerpc: Remove AT_VECTOR_SIZE_ARCH from UAPI
      MIPS: Remove AT_VECTOR_SIZE_ARCH from UAPI
      sparc: Remove AT_VECTOR_SIZE_ARCH from UAPI
      sh: Remove AT_VECTOR_SIZE_ARCH from UAPI
      alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
      auxvec.h: Drop fallback AT_VECTOR_SIZE_ARCH

 MAINTAINERS                              |  5 +++++
 arch/alpha/include/asm/auxvec.h          |  7 +++++++
 arch/alpha/include/uapi/asm/auxvec.h     |  8 +++-----
 arch/arm/include/asm/auxvec.h            |  1 -
 arch/arm64/include/asm/auxvec.h          |  7 +++++++
 arch/arm64/include/uapi/asm/auxvec.h     |  6 ++----
 arch/loongarch/include/asm/auxvec.h      | 14 ++++++++++++++
 arch/loongarch/include/uapi/asm/auxvec.h |  8 +++-----
 arch/mips/include/asm/auxvec.h           | 17 +++++++++++++++++
 arch/mips/include/uapi/asm/auxvec.h      |  8 +++-----
 arch/powerpc/include/asm/auxvec.h        |  7 +++++++
 arch/powerpc/include/uapi/asm/auxvec.h   |  6 ++----
 arch/riscv/include/asm/auxvec.h          | 13 +++++++++++++
 arch/riscv/include/uapi/asm/auxvec.h     |  2 --
 arch/s390/include/asm/auxvec.h           |  7 +++++++
 arch/s390/include/uapi/asm/auxvec.h      |  6 ++----
 arch/sh/include/asm/auxvec.h             |  7 +++++++
 arch/sh/include/uapi/asm/auxvec.h        |  8 +++-----
 arch/sparc/include/asm/auxvec.h          |  6 ++++++
 arch/sparc/include/uapi/asm/auxvec.h     |  8 +++-----
 arch/x86/include/asm/auxvec.h            | 12 ++++++++++++
 arch/x86/include/uapi/asm/auxvec.h       | 13 +++----------
 include/asm-generic/Kbuild               |  1 +
 include/asm-generic/auxvec.h             |  7 +++++++
 include/linux/auxvec.h                   |  5 +++++
 include/linux/mm_types.h                 |  6 ------
 26 files changed, 139 insertions(+), 56 deletions(-)
---
base-commit: a6b4ba7acc23ac0fb680449981982f308ea75036
change-id: 20260109-at-vector-size-arch-6e0f2e9ff8b6

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035E42B33E;
	Thu,  3 Sep 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421291; cv=none; b=YQ8vhp7UpVYOcyAYsnWKtGXvrIUx0JygDHkupOmJdsg2j5cRfPja5q8vFDzpj/SH0cFNOmISHJq/Usveg+6ZBD4bFgl1ke8hKQ/TiRFqOBGaYK2wgHeE/cPn8iZVGamoE0ttW0i+IqF81iDNV+Z2cenzJqUIoVd25XbPQxU6VcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421291; c=relaxed/simple;
	bh=3s3XptoE1X5UpOSAIz59e0R0lZLIvWXcerejp7RbE+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dBWdHXNVtek76E2YfvEyHdjQvpc5wj9aK7o7wDU8CDzKfxYhyLsCrYNSvkfmryAeUG9uokYJ4XntYmlGjErkBQR9Jx3v1xSrsMaKl+0Ekm6VWd7eQfEHeD1++YUQmYI7+ZCQ45zypJEDJ9k/Miey5jBFvUK66x50B2OXr9EzBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sP4GAzlf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=74b6hxEu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sP4GAzlf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="74b6hxEu"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5KW4JSiXbH9maSfkULvZaqX7CoVimn1QeXod/ruf3No=;
	b=sP4GAzlfiwyJ8SlAiXB9hhGatHqYn5Vcn3KyodxJkAO1wj/PHMlbdW77kFZude743RnLhd
	B5QZwXUkCLLV6Wvnob5GUovY1H43zZVNWtGF5UOAyDtw0h84ySpzYI64iVVJEIHvicRsJY
	pD1ld4DRhtbdgnX9NNClO75WOFLSWKxzBq3iHywNs/5YkMjYPN/hkHQCvUYgFe8rIWuTxq
	ufYRd2Yn9ZInjWVURzxboS8uymqnHI7MPJc3Ye+zTbYZ7DuMs5zMOjmE9Qpb0t7EMovaQc
	99zQAQl51CjfPmTlBPFogtZ+kwL7ycovS8bv8r+JCiyjj17qoIK0POFSFj9veQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5KW4JSiXbH9maSfkULvZaqX7CoVimn1QeXod/ruf3No=;
	b=74b6hxEuHiaYbO16J3R8hRN+sLyi/sfMIBBYDtJQpn5U/qxoOZMHYwATNk199oaBFFJwuk
	Q6njN3w1wiL/mPDw==
Subject: [PATCH v2 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Date: Thu, 03 Sep 2026 09:41:15 +0200
Message-Id: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7ZhpSQi48h6GRSlTmcQU05YGJ
 dzdiluX7yfv/Q0iB+EIl2qDwFmizL6APlVgJ+PvjDIWBk26IUUdmoSZbZoDRnkzmmAnbJic5s6
 5dmigmM/ATtajeusLTxKL8DpOsvquv15N+m8vKyQ0SjmqB6Otaa8P8UsKs5f1PDL0+75/AAd6e
 Um6AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=3129;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3s3XptoE1X5UpOSAIz59e0R0lZLIvWXcerejp7RbE+E=;
 b=XVy2EwXriKXi49fdKmjGDzcDgmWqDqa4Nz8coc0Bonz8f2R5uqRepUP5lWAxCUStMn+bsNf9+
 GanZj2c8Z3BAevBQ7Rcfu7kM1Xymj/tUjcr033fxv07isChfPk+ufoG
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
base-commit: 2698961599195990117a0fa240118ecf2f8e7453
change-id: 20260109-at-vector-size-arch-6e0f2e9ff8b6

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C4D78F39;
	Mon,  2 Mar 2026 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438333; cv=none; b=SEo97IB4KvMTfhBRQAlYU7wcYkp+JLbpHpAq+dmWvwm5BfdqB1sDxq0lfWjkpQ1vA/hGl/eYYLLJxJE90LtMmhEvn8CLH4vrReXtjIAq533eLv2rUcvdEmTTi18gGmDqO5Md8/lbDTsC38SvAMIFgx7lS22bbtuWhusc10m6Kec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438333; c=relaxed/simple;
	bh=o0N8GcMd8Wv1v1vLFraNSKorTTZyIWNgl6SVsYTfGvc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n/WNFfY8I67CbBVUp57RCHUXD8ntRV49yPHKoJjc2N+jwnbfMY5QWzAJqnxFVCHLgzZSGMppcgIl3xrJ5CEHEYl3Ik0o7wq+xgcMIhjmKiiFIDa5Z0u/s+0IzTIDNGu9wCYTr1CjaXcFF3RDDygVjDVYy0hcZnJRP6alroykOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+W0svcx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jXG8V5V3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+W0svcx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jXG8V5V3"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772438329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CppVINWDU69mplj8+k/K366WYv0fGhniEacGlAHg1DU=;
	b=v+W0svcxWjvODHkF4KURqjcM8wAaw+WlIdEMkq4ngppf4gT/fmy6MtWKqRhhTweq+J3rv8
	MJcgxRx7mpMjSCCQPGVkoJFl7mRQgcoc9+rGDVZPbI+fihzeJIW/4zF0F2V3IVerR3ZYqp
	vyU1MOH/cQvROAdZWsdPKd7avf1251DhOhqMAfMErDvAIxlF6nKqV8B1Bbka2UGI+6mWDG
	/bc70Ggm1t5GwcDxnt/a2R4uqA8ig168AcjV43SaBN/QWGRqqUQO670I7Jn6OCmmhI7hhN
	duE15ko8bozxDHYcROnHQyf2exgxGqmCLZLJwzn18w/SeSY48ZUv39cYJ7rD5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772438329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CppVINWDU69mplj8+k/K366WYv0fGhniEacGlAHg1DU=;
	b=jXG8V5V3pA2/haiPpMZ9guEgfY1AO2AitAlh9Qt758wRbbUDxScB4f1GL4CtxrJVmU5bBu
	YeF9Uo5nflKaYECw==
Subject: [PATCH v2 0/5] vDSO: Use 32-bit CHECKFLAGS for compat vDSO
Date: Mon, 02 Mar 2026 08:58:36 +0100
Message-Id: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNyw6CMBCF4VchXTumLTfjyvcwLHoZYCK2pMUGQ
 3h3C3uX/0nmm41FDISR3YuNBUwUybsc8lIwMyo3IJDNzSSXtRC8hWSjB+Pfs1rAjGhe/aSGCLX
 Vba1LXWllWD6eA/a0nvCzyz1SXHz4nn+SONaDbLgQzT8yCeBQqVtGe625LR8Tuc8SvKP1apF1+
 77/AFK5eUvAAAAA
X-Change-ID: 20251107-vdso-compat-checkflags-5db75b3b4bac
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 David Laight <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Sun Jian <sun.jian.kdev@gmail.com>, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772438327; l=1844;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=o0N8GcMd8Wv1v1vLFraNSKorTTZyIWNgl6SVsYTfGvc=;
 b=MZ2OUVAM3Gleol5ZSIQ3VTyufDy8HqTIN3psf4kzTZTtf9sT/PYCXgIptOdpvIFbxqTCLZjnl
 u+RXqDzMqNSCyLY/Zn0lSlGwSrdXlSVqa7nzpIWjfV2tcfFJB+c7vHz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
are used. These are combined with the 32-bit CFLAGS. This confuses
sparse, producing false-positive warnings or potentially missing
real issues.

Manually override the CHECKFLAGS for the compat vDSO with the correct
32-bit configuration.

Not all architectures are supported, as many do not use sparse for their
(compat) vDSO. These can be enabled later.

Also add some checks to bitsperlong.h to detect such issues earlier.

Based on tip/timers/vdso.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Simplify __BITS_PER_LONG consistency checks
- Fix an inconsistency in the powerpc audit code
- Move check to kernel headers instead of UAPI ones
- Use KBUILD_CPPFLAGS = -m64 on s390 instead,
  the previous include trimming turned out to require changes to many more files
- Rebase on v7.0-rc1
- Link to v1: https://lore.kernel.org/r/20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de

---
Thomas Weißschuh (5):
      x86/vdso: Use 32-bit CHECKFLAGS for compat vDSO
      sparc64: vdso: Use 32-bit CHECKFLAGS for compat vDSO
      s390: Add -m64 to KBUILD_CPPFLAGS
      powerpc/audit: directly include unistd_32.h from compat_audit.c
      asm-generic/bitsperlong.h: Add sanity checks for __BITS_PER_LONG

 arch/powerpc/kernel/compat_audit.c  | 3 +--
 arch/s390/Makefile                  | 3 +--
 arch/sparc/vdso/Makefile            | 3 +++
 arch/x86/entry/vdso/vdso32/Makefile | 4 ++++
 include/asm-generic/bitsperlong.h   | 9 +++++++++
 5 files changed, 18 insertions(+), 4 deletions(-)
---
base-commit: 740f1913cfa0d48222760eaa438c509ca9fc3710
change-id: 20251107-vdso-compat-checkflags-5db75b3b4bac

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


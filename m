Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2BD36C5AF;
	Mon,  2 Mar 2026 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454348; cv=none; b=rNziUHNU2F1QIcZ0L5nK0Lfhz+OHIhIIupjiu0+XYr9zYlZRNagDiGtVBJRU/9Otg9O92KLzqp3KTbbzs5z9kAiUeCQG1qqsE66iKBkkyGhlwoy4H/pp1OtXkJvFJPtfCGor/KE9L8MsjXMgYBUVwTQybpTw7vuieMwzbVIVNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454348; c=relaxed/simple;
	bh=JDTHLUTBRhLdtWzI+cYwcXmhsRHrVsJSh1vwEnoNL54=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p0BguTxadWStzSHRJiW1z1PlslEB1GwYpoy5I292zgVad4yQTmLWR0avTWeQqAMSfcJJZ+arEEhlpGRW2DnVEiRcpH6nFhfYoytXZFuNOy5rr9+bg7IPVO49o7EzSCYYKhz5JUViwaA9C29oQmCBGCRBpXVf8no7sVIOoOJPW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XTq/Qbds; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f3MlQqxs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XTq/Qbds";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f3MlQqxs"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772454344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q8M0BzYT+8nDvDRpeOPQrwaX+SE1r8gh99dGV2h1fFk=;
	b=XTq/Qbdsmdrjjgi15d+mbxPv7MA1pmSdTxIgk0x+7gQ1SBn3Qk50BPvaiHTGQy/qTkOET0
	CGc+OMjOeQ/n2dA3JdyCWwjrdxy0uscngADbfRLK8WmqnacdFL6h4HVWXe+3LbMBHdWR9X
	qZ74nUVL9W2j3VLfwuTKczYIjFgmRo5MMH5f83HQtqnIdi+gp6yskGE9pemAt/5epkD38A
	sdonFKgtjJGoOsIGmpIH2kKpN+TtX6hvt/oaC/e+zE3Kp4IcFO+phZTmHZCNcZy7Qe9ryj
	DSBSapJLSRTcmYCf4GVgZP161CF/lM2AnixGVHOK2waHFibtLc9ifGRmcjG1Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772454344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q8M0BzYT+8nDvDRpeOPQrwaX+SE1r8gh99dGV2h1fFk=;
	b=f3MlQqxsNMwSdSaceDHlFwzKoTlTmrVShpKlZNDhQVk9O7AG1ihqK0Tpn92+Xr2oztP91Z
	NrP6Rmm8D/oDiRBw==
Subject: [PATCH 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Date: Mon, 02 Mar 2026 13:25:24 +0100
Message-Id: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ5AMBBG4avIrE1SXTS4ilhU/WU2yFRESO+us
 fwW772UoIJEffWS4pIk+1bQ1BWF1W8LWOZissY605iO/ckXwrkrJ3nAXsPKDiZadDG2k6NSHoo
 o938dxpw/BDR+BWUAAAA=
X-Change-ID: 20260109-at-vector-size-arch-6e0f2e9ff8b6
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772454343; l=2953;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JDTHLUTBRhLdtWzI+cYwcXmhsRHrVsJSh1vwEnoNL54=;
 b=J6CYW4wsSS52A+nGxs9gwUdPdfHUZDIYWEVVGw/G+GXj/VTqu7W4L6C1R+uvBZbzZsf4FisCc
 r+YyP25hcjyC3G9P+jLo1JOj2qTAaURruN7qUwKyoqSA+FQdhvM39MD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to kernel-internal headers.

Meant to be applied through the asm-generic tree.
The default recipient list was huge. I trimmed it to only the
architecture lists.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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
base-commit: f6b3b0a4c85882ad75bce3b093173203e3f39f28
change-id: 20260109-at-vector-size-arch-6e0f2e9ff8b6

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


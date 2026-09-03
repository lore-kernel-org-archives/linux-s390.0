Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB67440A13;
	Thu,  3 Sep 2026 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421295; cv=none; b=MxreeP8pRr0Vo00jPBGV+VgmW0c3W1IG043a6vDYfWwnjGdC+J1r2x25RwDZnagk6YIAQL0US38TQm76gr+CepQPV0Xa+TObRj1ELRUIbpYnBDk7BJm477PJg9l+gh5KTrMXRu7dqpfEmT2oobhDoJSXgvfR9nYihKqZpIhCoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421295; c=relaxed/simple;
	bh=yzUJPF4+/uSgsYkr+YJKb+Uz3ZiMTGZCOEBRakgLSTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DL90syQYSN0vHoM0MSCXjzrQD8UN77TLkB/4WtdtK1OLt/1YDsXD9f5Qugi35H3qXK+J4xW5Q6WdfJcLOCo6QAePn/JSH9h2bk5dabKxJw/LFXJ4TIqT4a1ziJ8un6RW1eef1vS1StHF5SNzOKfQvuN8yC0NgDVuaOwRt0EcgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YUrsKLYp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aK0JbXjU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YUrsKLYp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aK0JbXjU"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7w6IVovisCb503Pkoci8pxom1cMDymO/FBqfuq2HGI=;
	b=YUrsKLYpR6VZq3FjSZ0tcH1u/iL3pnEqPkHzaoQflyy4+wMTPZ0gzLpbw3vB+4VDAnG5PH
	cZALG1imAlcNsXtsBsfkzXXtDu4/CILpTvEnECUkH4/6Eymd0VAAx2OHa8vO4HJB9WC50m
	pwxutgnUIdRLMt9P1NVK0ydGcpFQDiUaCW52VKIUOqjDwMcTn5pjVTRZhVUppMT8B99nvz
	MIRuXE5wp91zRf3+wqSlZ56x3BykPmTc2e+RiC/SINOmaTjzLo5hN58eiHfEc8+gpMUebh
	HBcSCjN8rFEv5nUId4u6Gcy7+jfPttRo4pHbHkYZ7T1rTYgSH02AWQdvWf6ZOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7w6IVovisCb503Pkoci8pxom1cMDymO/FBqfuq2HGI=;
	b=aK0JbXjU6gNUAZ7CUfQcDDU1452O226LFxU7OBZ5JiSzeBepGLdhKq3cRUyVBT8BcLiF64
	nYPh4Hh4QgFfyDAw==
Date: Thu, 03 Sep 2026 09:41:21 +0200
Subject: [PATCH v2 06/15] arm64: Remove AT_VECTOR_SIZE_ARCH from UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-6-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
In-Reply-To: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1590;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=yzUJPF4+/uSgsYkr+YJKb+Uz3ZiMTGZCOEBRakgLSTw=;
 b=DdZRWT9PaRUgrbKuk0FccoE0UqsO8Wy2gW0MV+ISuIpLSi+dZ054rE9E0nfEX8/hbjKwvu4k3
 XkEx0oppmjkBBuo9UIQSI5eFpWB/CFJrAubMUD+gSbssc81nC2HqkDn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/arm64/include/asm/auxvec.h      | 7 +++++++
 arch/arm64/include/uapi/asm/auxvec.h | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/auxvec.h b/arch/arm64/include/asm/auxvec.h
new file mode 100644
index 000000000000..de24eaaa06e2
--- /dev/null
+++ b/arch/arm64/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
+
+#endif
diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
index 743c0b84fd30..fb51e906813a 100644
--- a/arch/arm64/include/uapi/asm/auxvec.h
+++ b/arch/arm64/include/uapi/asm/auxvec.h
@@ -14,13 +14,11 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifndef __ASM_AUXVEC_H
-#define __ASM_AUXVEC_H
+#ifndef __UAPI_ASM_AUXVEC_H
+#define __UAPI_ASM_AUXVEC_H
 
 /* vDSO location */
 #define AT_SYSINFO_EHDR	33
 #define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery */
 
-#define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
-
 #endif

-- 
2.55.0


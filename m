Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8E337BB8;
	Mon,  2 Mar 2026 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438334; cv=none; b=WwGwB4Fh8pTStjqDmZ6Un0V0EDk4YuNx5mUcqqCaXkInlsKAdFQ4hWPUDSouZ/njTlWaSkFRrk04NEn8aD4uaPSim1280NNqoJNp/A3J/INdMJYqN57ZV4KaCoosC3Ebzc4NJGVCPOw6elA+f10y4AfA33HkuPG2eAD02pvQ6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438334; c=relaxed/simple;
	bh=BTq+tG721IWvmNZKRhmYuiBTJvXYohTSP94/jYKFkyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WMcwXZc4UgRYAjNTeKihX42Opw4H3uPUZWA5boA7dWiJqdDYTsST+7NVni6P/JFgUht6f4Rrm7ae+tyvWipOV2JHfOSZpytEG06vFC5RXcfZ9/AB31ujiTL03cG1e5Ai4c9sO8oo8vNysiwGh16KL2lzXv7Ez92T8WD/iPux8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ciydefi2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/oOqZJOd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ciydefi2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/oOqZJOd"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772438331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF10sktaE3a/u60QuU3fU7HqMA3bwXEWu54Wnq4Vn5g=;
	b=ciydefi2+IGpGjxuJ8S0Pi+V3OE2L2KTESiiSpFlWMdULYcmkYxxE1PJyxSZo34YX9HCvC
	otxxjHp2oFTPL9j9x3qD59f3ZnvENSKPwzlcjDF9gwOAoWjmGg+Kl2GOzjsuuqOkUN8EFR
	MpaBg4Wm8BR5LSNmS/vo72/wV/m8ujzC+zXJsxM/E5eHSDwg5a+SCYVX5LcbFGs9WLZx1o
	IqabJtHg5sn7IO0PwbjNhXU3mLreIj2ehewv2aXyfQnB+vS6/6g72GHvLiu7IUXCA2Dns3
	jj6Qctvz2ySNMQjcEbRkObXtPQ32W4ozS6FFjJEQYmO4+ZGx86/y86p5sT36/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772438331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF10sktaE3a/u60QuU3fU7HqMA3bwXEWu54Wnq4Vn5g=;
	b=/oOqZJOd60lffdI+2m/cDGB+gvLeO1GfCoV5HvJr4+3CHFqEyKt8w0Em37WkJfh2QW+Rxk
	lrrT3Gblc0IA2uBg==
Date: Mon, 02 Mar 2026 08:58:39 +0100
Subject: [PATCH v2 3/5] s390: Add -m64 to KBUILD_CPPFLAGS
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-vdso-compat-checkflags-v2-3-78e55baa58ba@linutronix.de>
References: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
In-Reply-To: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772438327; l=1115;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BTq+tG721IWvmNZKRhmYuiBTJvXYohTSP94/jYKFkyc=;
 b=sX+mpo7qFfoRgBke0bz6zAxXtqo1MhErKWEmsMFk1R+7DQ6DdvNT3JOeYuQjWk75pK4XrWWHX
 /ugF1GYyl71DtJ1gQ0FcfcZ9SjFd/F4MkzoR7GPOsO1elfICLhEYH+T
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some non-code files, like linkescripts, are preprocessed with the C
preprocessor and make use of regular kernel headers.
As -m64 is not passed to those preprocessor invocations this leads
to an inconsistency between __BITS_PER_LONG and the C type 'long'.
An upcoming consistency check will be tripped by this.

Make sure -m64 is also defined for those preprocessing steps.

As KBUILD_CPPFLAGS is inherited by both KBUILD_AFLAGS and KBUILD_CFLAGS,
drop -m64 from these variables.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/s390/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index d78ad6885ca2..02bc948a4a56 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -12,8 +12,7 @@ LD_BFD		:= elf64-s390
 KBUILD_LDFLAGS	:= -m elf64_s390
 KBUILD_AFLAGS_MODULE += -fPIC
 KBUILD_CFLAGS_MODULE += -fPIC
-KBUILD_AFLAGS	+= -m64
-KBUILD_CFLAGS	+= -m64
+KBUILD_CPPFLAGS	+= -m64
 KBUILD_CFLAGS	+= -fPIC
 LDFLAGS_vmlinux	:= $(call ld-option,-no-pie)
 extra_tools	:= relocs

-- 
2.53.0


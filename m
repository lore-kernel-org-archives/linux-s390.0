Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76151335562;
	Mon,  2 Mar 2026 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438333; cv=none; b=oxD14TsSMUZN/d8mmTYWIKUfBgrwYK9APxOO/w2hJOgRxX6YlkDyytUeL/Gmbs0XLwbqls+hew4VkKp0rBAS5HT5nz2o6WpGV3H1eXXuHQfbIrvDF2ECrSuuyiUg5cJRCMDjYn/+B6tItjVQSTVlzmulU0PMkvhRSuSpTjDEbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438333; c=relaxed/simple;
	bh=+ZNTvsS03cf/7hGvDJacLfCnOSDvf3VWGwKmuX5AIIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDeorQqSnzrfKJip8kzkSovdb79JpMlIXM40tc1Gb/4QZPp/fW0RplSpKoKtAubVHf7XcEXGLxW+WYQuG1C2ujOfUOMm80qQ0v/75oJVMP3QesXAC9ovNjKH+xWtoY/tCa9FxnMQQXaAFO3HudChtbH1LzbiiH7rDUE7uOsdckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uyjMEpDU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fr/HGqXy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uyjMEpDU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fr/HGqXy"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772438331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYzDmJLESQDE0WGZOLxDeZB0k8diDoIRXYV8eHmiP4I=;
	b=uyjMEpDU+Ms1HTL60KWTsXDcQuLD7b4yjxeGhF8tgVTjQ2kkhq75vsgmGnXpq+8cnTXa4D
	NlV740cDY97hzfhxaqf+46PapcgZHM3gq8CE8RIib4dlrrZ3dXD6rVbf3QDfoCPW+Wl9CV
	fIAojNCIpmwsadApQeVOp0XlGmzA+oCh36feTuw2rjfy8hvAU0NO5gPPZA5ZQz4FnwJ/6p
	krCJW8vtMkGUvKjS2hJDtWYE5zCYVvUYmirfs+VbjdnrpMiGWrnjkAGBsJkUvnf8rIMIAf
	/4rnpF5/Ap+e6KKVqMrxmtke0Oq/DcTrDVeTWQGALaRy8CLcZnadb4lYmSPpPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772438331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYzDmJLESQDE0WGZOLxDeZB0k8diDoIRXYV8eHmiP4I=;
	b=fr/HGqXyWU3Kci3r+yPCt6+p6Pqf+02Ssd1Pb1zEsVJbbH9+n0SKw2uwMCxMhExtDcG5VA
	3gqEiOxkN1sj6jDg==
Date: Mon, 02 Mar 2026 08:58:38 +0100
Subject: [PATCH v2 2/5] sparc64: vdso: Use 32-bit CHECKFLAGS for compat
 vDSO
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-vdso-compat-checkflags-v2-2-78e55baa58ba@linutronix.de>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <lkp@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772438327; l=1447;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+ZNTvsS03cf/7hGvDJacLfCnOSDvf3VWGwKmuX5AIIY=;
 b=kspaAO2Nd+J47AMHG0hbuL+BuqH4VXDaOrQx3Oh8u8q9Ts994YT8aym1Wgdi+yqmVAf1E3CFM
 xPP9byI6x8wC16gAJRbrSBAnEgOpEOXAIgsN+ha/IFSD+jCl89niAri
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
are used. These are combined with the 32-bit CFLAGS. This confuses
sparse, producing false-positive warnings or potentially missing
real issues.

Manually override the CHECKFLAGS for the compat vDSO with the correct
32-bit configuration.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202511030021.9v1mIgts-lkp@intel.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
The actual false-positive is only reported when SPARC is converted over
to the generic vDSO library. However the issue is already present.
To avoid dependencies between different patch queues, I have this patch
in this one.
---
 arch/sparc/vdso/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 13f1d7be00f1..7d6e3097ebfc 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -90,6 +90,9 @@ KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
 KBUILD_CFLAGS_32 += -mv8plus
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
+CHECKFLAGS_32 := $(filter-out -m64 -D__sparc_v9__ -D__arch64__, $(CHECKFLAGS)) -m32
+$(obj)/vdso32.so.dbg: CHECKFLAGS = $(CHECKFLAGS_32)
+
 $(obj)/vdso32.so.dbg: FORCE \
 			$(obj)/vdso32/vdso32.lds \
 			$(obj)/vdso32/vclock_gettime.o \

-- 
2.53.0


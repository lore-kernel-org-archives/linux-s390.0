Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAC201004;
	Mon,  2 Mar 2026 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438334; cv=none; b=WJdnvk2Jqy9ANuYI0jgp5Gi9+edP0xTJAgc1aXiSen/RNrFPMskCSb742cgOithDSOsHLFp0hVHM5MeW4CxdARoNFF2SB7hZahFwMTyRexEtFNy5CRBCQ5EagmUXhbMo723aM5yiCNwiHI9+H+6mhVPX3O5Gb2QRq7x69eNnohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438334; c=relaxed/simple;
	bh=5ZtWeLoIG1DUjNycBMtCEpprUXPJS/yxYX1kXl4i0fQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPO4o05hL95hL+oyFcfvmkwhD/jjwDg+e8u4U3Q82Ex5zFOFLN8rpjCOrV9JJ476WViszteLMnUr/8V3Jckg/OwKhF+LpYi2AlxFymrQH6prd/G9E56JAgS6jx7z35r43wUBXGDGgr391UcpYfFoPL2jn66rb2x6eeM4NqQkNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxHB4cE7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=efvxVqum; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxHB4cE7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="efvxVqum"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772438330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDCrcHt8O4dhTht762Lzzs+IBKZYqdQLeGb4eSwA3mw=;
	b=bxHB4cE7MnNYGC3LGFJQZbAqR1AX7Fj2u4K/iJg3DmTgTPv6SMfC+jLrKfrfo48cNHCdcS
	kHgm1LXOX3Ulk7YNyobEBm6LA3UE+JS/ajFt59GmEeArXLSu9TZbpwBY0V4leeH+yaR59D
	tZJTJ+Qk1vW2vXSbeMLxeaOej/OSpsZaSsUEoHAb0/9/wyJobZOuZeR+HK69qB0I/SQ2i0
	gU5Z769UJXIQa4xv9omtW2LTJtS2OQAUvJ10ZjYFfCCIgEfO9N3H2fTgFPSsZZnDq9OG47
	Jf/T4JWoaDBRD5aq5CZMdxKd01JAbK9NjJhb68w+D2/ObDrUR52dcQH+0oGmbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772438330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDCrcHt8O4dhTht762Lzzs+IBKZYqdQLeGb4eSwA3mw=;
	b=efvxVqumAur2T8LG28u5Yn0U0H8bRQKwT+Jh2uOlOmK4nUzUOsltLyESAuNhzX0970V5P6
	r2bYGqMgv6Z8JFCw==
Date: Mon, 02 Mar 2026 08:58:37 +0100
Subject: [PATCH v2 1/5] x86/vdso: Use 32-bit CHECKFLAGS for compat vDSO
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-vdso-compat-checkflags-v2-1-78e55baa58ba@linutronix.de>
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
 Sun Jian <sun.jian.kdev@gmail.com>, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772438327; l=1516;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5ZtWeLoIG1DUjNycBMtCEpprUXPJS/yxYX1kXl4i0fQ=;
 b=+NVtnS6EyY2Yoq5xKj8da3D2ktgjWUTfvnaXTMMqFJhyaa85rPvEJd4KytnY3lc96J0g8mRrj
 KMacJ1WhtFWAPq9kCvYgoREx0uRXMt7AQbPWjwUKsysaifcS2+RVPku
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
are used. These are combined with the 32-bit CFLAGS. This confuses
sparse, producing false-positive warnings or potentially missing
real issues.

Manually override the CHECKFLAGS for the compat vDSO with the correct
32-bit configuration.

Reported-by: Sun Jian <sun.jian.kdev@gmail.com>
Closes: https://lore.kernel.org/lkml/20260114084529.1676356-1-sun.jian.kdev@gmail.com/
Closes: https://lore.kernel.org/lkml/20260117215542.342638347@kernel.org/
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202602111941.PIhubgrb-lkp@intel.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/entry/vdso/vdso32/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso32/Makefile b/arch/x86/entry/vdso/vdso32/Makefile
index add6afb484ba..ded4fc6a48cd 100644
--- a/arch/x86/entry/vdso/vdso32/Makefile
+++ b/arch/x86/entry/vdso/vdso32/Makefile
@@ -15,6 +15,10 @@ flags-y			:= -DBUILD_VDSO32 -m32 -mregparm=0
 flags-$(CONFIG_X86_64)	+= -include $(src)/fake_32bit_build.h
 flags-remove-y          := -m64
 
+# Checker flags
+CHECKFLAGS := $(subst -m64,-m32,$(CHECKFLAGS))
+CHECKFLAGS := $(subst -D__x86_64__,-D__i386__,$(CHECKFLAGS))
+
 # The location of this include matters!
 include $(src)/../common/Makefile.include
 

-- 
2.53.0


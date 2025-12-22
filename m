Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEAC3314AB;
	Mon, 22 Dec 2025 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766392100; cv=none; b=dgGb4dPUaVcQgqAb3uu/A2tb2heM9XmJDP19DKfzqllnY/S+6LldYwRtGs0qG2yFUX/GENkwY/1QxtXvq9wuztoYBWLE66RXWIhM1VusMM77HLNgOWqSXaAtXtxXF/9/iwiV+2ru7FUW+/h6r26qMVIbMK0R/AuRSjwV4DIxqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766392100; c=relaxed/simple;
	bh=+7H8P2t2Cg6Y1jcwYDaM1vv03g34g5Sn6TyH9kl7aQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XHB/VjqkIYESQ+50crmE+XSx3nDaACuy/E8f+nb+Zrwn23z3100mBVb5cyVpvVel8HlB3rfDJOZrEO09dN1SYKDz1vM8BOveo7w3A7Z1PXN3ZrJv2eStyvhY3WATMV1bCZu2Q8ggLW7xtI9ex5SAEIg1Nu83zBfiufxYwVHWl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0WGaaH+5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S72SDsFA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0WGaaH+5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S72SDsFA"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766392097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qf0xf/wuYfHwsnCWZ/THan2qSw0jcCyZ+xwMVBurehA=;
	b=0WGaaH+5NtzbsB2KdEFWrJy+GgXjt9kf17we32nX2DkcwtQWdj5Xt7SKX2OCsWaFFq33dS
	uBhazBSFv3MX/GMd7TAtFF/OuxgORs7s4yVjQIOdTuo+BiZBva120Imt6i/PtpMV9n4Vig
	4R9aLXP0g23nSFVjvoVP2+oP9tPe/huHczawx2GoedpmuJgZSYWYJUq7oytP6wAv0xJyY2
	qWvu9GnwMoj2Wq6AU0nA+VErAbKT6I7/hIWPUiNJHdTZuGbnnNrqXBap03MxheDOnLElsI
	luR5Y2Hbtz1nW5x8tD//K5j+VrsFp+0nfHVolWNPUrK/6nu5sUIk7XLeIF4ejQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766392097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qf0xf/wuYfHwsnCWZ/THan2qSw0jcCyZ+xwMVBurehA=;
	b=S72SDsFAqPbyL2uMG81Vu7eqZMsOwKxpVbVJ47u+kpAzmsBGthp1ivh+k4BZyU2Z1TVv7g
	4UcY2odSgiur+rAg==
Date: Mon, 22 Dec 2025 09:28:17 +0100
Subject: [PATCH] s390: Implement ARCH_HAS_CC_CAN_LINK
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251222-cc-can-link-s390-v1-1-0b2c4998c066@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACABSWkC/x3MMQqAMAxA0atIZgM1paJeRRxKjBqUKi2IIL27x
 fEN/7+QJKokGKoXotya9AwFTV0Bbz6sgjoXAxlyDREhM7IPeGjYMdneIJEV9q1n0zko2RVl0ed
 fjlPOHzqtfvxiAAAA
X-Change-ID: 20251222-cc-can-link-s390-223eca6ac085
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766392096; l=1348;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=+7H8P2t2Cg6Y1jcwYDaM1vv03g34g5Sn6TyH9kl7aQw=;
 b=UvQzcBnlYP3RoltVXWOG1UCHYEsG2gJGAKU5g2cKxj++zeW2fn2QJPAb+gXMN+TW3sRfKyfgp
 2RuHIoHS5SWDC77IxnEXLmaVdnXGevzoySI5Tr8az3UhIc32SZm4by9
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic CC_CAN_LINK detection relies on -m32/-m64 compiler flags.
s390 toolchains use -m31 instead but that is not supported in the
kernel.

Make the logic easier to understand and allow the simplification of the
generic CC_CAN_LINK by using a tailored implementation.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/s390/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0e5fad5f06ca..cd856318ffe5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -85,6 +85,7 @@ config S390
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
+	select ARCH_HAS_CC_CAN_LINK
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
@@ -294,6 +295,14 @@ config PGTABLE_LEVELS
 
 source "kernel/livepatch/Kconfig"
 
+config ARCH_CC_CAN_LINK
+	bool
+	default $(cc_can_link_user,-m64)
+
+config ARCH_USERFLAGS
+	string
+	default "-m64"
+
 config ARCH_SUPPORTS_KEXEC
 	def_bool y
 

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-cc-can-link-s390-223eca6ac085

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69D4334A6;
	Thu,  3 Sep 2026 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421293; cv=none; b=qDEL9JCIIpbvjlKHcASJRsQUqr1Zqr/jWHAMTchTpRFx3Yl+VZ3FB7CIaloGDcpfQUzh9TAv5Ows2mdHUFc46DV1+lifF8dRjQqswJbQQuE88FfVPN9h2oiWoQTKbADEBeaQNkWqY9ntUcJ2Bi1HaYbWLAldHOlEr/vG8qNFKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421293; c=relaxed/simple;
	bh=4mJFyYPX7/9EiMcEouBDn+ZTTOxkaHBJ3RQn0m6AUq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZUYZMTGuwS3SG5Em+0q0BYOlXAVT3edqdSH7AjogGc+ps5JoXBhVacHsQ629k946IXSvdJGzM4gIr9/sbCtOP6METGecZpVItzFjVZSerxFqXI1dQv4E3TNpzFua54WG74WpxNSApt/rwlad/rVoHH+cMdGqFfpDIx4rxmS3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qygBbDf/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=99/QUoc8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qygBbDf/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="99/QUoc8"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ViTmWloD5J2eKVReHF1z7HtFirOwWOw1jQ1azvN/uQ=;
	b=qygBbDf/i/ChTAwdDHX/OMkpJmg3bx6WNehWxnz/a/QG/CS7FCGINzvET8JahA42fqomF9
	0tA/fgeQbgmMTbTiQjN7PdJlMV7Y11X8gID4ivpxX9BwP+ezfa5IJUGKanG/XPsFRFZvzW
	+w91JMBD2jwTIuY19qA66NaWObSbeT+v9qSA/aXqJ/r7GLtPWY+L4rF0kBBhrcq0sS9IS1
	YH38iFpVF78cVoohANLZiDMxyNqiEUlth5rF658DWk6HyldpYOdOSloQqohF0RloLbf5f+
	O1QY45sabtAAMz5DyzbmCTCGTzJvoZxmpqGlyZ73gD3OpdV5mqJKFQtQUXHgsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ViTmWloD5J2eKVReHF1z7HtFirOwWOw1jQ1azvN/uQ=;
	b=99/QUoc8tSeZF+1c6hGSR5xjtwKPDTxKJiyjGqHWes2RoXstjBOuax6m03o+e/SbOdYvh9
	hLslsBJWfKFMgqDg==
Date: Thu, 03 Sep 2026 09:41:19 +0200
Subject: [PATCH v2 04/15] ARM: drop custom asm/auxvec.h
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-4-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=523;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4mJFyYPX7/9EiMcEouBDn+ZTTOxkaHBJ3RQn0m6AUq0=;
 b=sVImdxunzIXRXXF2KzwDmKwk5x92lBY65ndCWzK3uf7dXH1bpo1cEYC44cBh8xKpT1XJtE/ZI
 nX8kEx7kkkRCESasFd8Wvn+OVgSU5t7OhvXleYrjtpeuaW16BitTJtC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With the introduction of asm-generic/auxvec.h, this header unnecessary.

Drop it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/arm/include/asm/auxvec.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/auxvec.h b/arch/arm/include/asm/auxvec.h
deleted file mode 100644
index fbd388c46299..000000000000
--- a/arch/arm/include/asm/auxvec.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <uapi/asm/auxvec.h>

-- 
2.55.0


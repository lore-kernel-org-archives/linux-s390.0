Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040B42BEA4;
	Thu,  3 Sep 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421290; cv=none; b=tyoqpiBxSE/+S/3k7lwSjdec6qYH1mBR35+tI+L/ga0PASZbMJtyV1wJG5gyxR6/hJm7Oe+u9i68uYIxiFpccwnrmvNSe63scAYHifRpzzkYeipCJMn9npWN1snvI6cIrR9xw4OzLfdmQUOcscL0u5HEdwp9y1fw+KyB1eYbWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421290; c=relaxed/simple;
	bh=Nm/6hJEAPks30y7LVA2Wwufq3vVlMHx1IoW0kUFRRys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4wJztjUsiFoleCM4/mOfvpF7QccTiAhgd8VCf3RkQ6pbIEfgkqDWq4HILfByPXiKXuPIN9SbKit242iA8JUA/BDl803Ve2+yyP0QSztl2qo+VFMHCAvHKyVH0g5ffecm7tR9DUkXAz80bn9lnUCvhw6pwcATk3dDaMzPgD3E4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zc+fw1vP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rh+ETLVc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zc+fw1vP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rh+ETLVc"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcMZPcEqwvVMhaVCt8MkUvZh7YAwKSLLYydvmnNx69g=;
	b=zc+fw1vPS28yXzWhjuVq688bLTlDJP+PQOO2TZg5QcxVNPZStsrnS4EMvXTkuI9WChAUF6
	e98Za95kruhvUKHM3/b34Kuksc7kVeCyI/v89gq/la6051sO7iVJiyemzT0SlIcVMLtp3V
	LBVntQcEnLcQP4mEFAOmRCGnVFjObZYQoy8t1OzlP6lakHcsrKvjUzVXe8XXr5xuJfGQOC
	1qK1oo84uH3RvHqkEN4CnRtgprm3+1bwVoDYK5JM2mCOVa3NMbngliORKzy3gImZ0p3Mdn
	KA4/eGPfFEVefv27hiUMV5YSZZf9/EbNiLhBwaHSRIcgEWjR+hD3IjTxfTw0+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcMZPcEqwvVMhaVCt8MkUvZh7YAwKSLLYydvmnNx69g=;
	b=rh+ETLVcunE+DHaXRlcjbRGQypXlRas7Gz8RSxyOEQznbIdmSjOOp7xhZp8qA1klyLJlHr
	4QVBYU6drJOyTJAg==
Date: Thu, 03 Sep 2026 09:41:16 +0200
Subject: [PATCH v2 01/15] MAINTAINERS: exec: Add more auxvec.h variants
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-1-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=977;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Nm/6hJEAPks30y7LVA2Wwufq3vVlMHx1IoW0kUFRRys=;
 b=qmIl+ksPTFbWALcvC6gLtF0MRDI5uk7fAOGtmCm6fQ86AWfo/5KOuP/P3VXL2cXkfCyJKwCbQ
 KGGjiCPlRFCAaRujs1d1gu5uZskagQtGmtcqSJJWjBWfEVKN728cCnc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There are quite a few auxvec.h headers. Mark all of them maintained
as part of 'EXEC & BINFMT API, ELF'.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..42715aea210b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9808,13 +9808,16 @@ L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
 F:	Documentation/userspace-api/ELF.rst
+F:	arch/*/include/uapi/asm/auxvec.h
 F:	fs/*binfmt_*.c
 F:	fs/Kconfig.binfmt
 F:	fs/exec.c
 F:	fs/tests/binfmt_*_kunit.c
 F:	fs/tests/exec_kunit.c
+F:	include/linux/auxvec.h
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
+F:	include/uapi/asm-generic/auxvec.h
 F:	include/uapi/linux/auxvec.h
 F:	include/uapi/linux/binfmts.h
 F:	include/uapi/linux/elf.h

-- 
2.55.0


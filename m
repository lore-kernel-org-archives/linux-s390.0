Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D320244EA1
	for <linux-s390@vger.kernel.org>; Mon,  4 Aug 2025 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300590; cv=none; b=lKRmaTjBiCkHfovP2gg07I8NV/7VGQgTDkWaoH6v5Wl4/fwfcaSGLaxg/021Aoa6Q30CMR5Kcpcc2tk306sxSo236pZMzuMV9lvL000N12bsIE+7fvAczcLqOp92diOZXVXit443DFn4bFpSzb82uyxdC+tbpolZH/+1K2TiS0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300590; c=relaxed/simple;
	bh=vo1IASJuWlpVy+ryYD9hXgIrcM4cEwqKaJR90WGf074=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WH9AMxFTC90ByaoLEoHMIL3DdNmiinVUQddlFsAY6znYNgVXuZW30XwasGPkuS2FEoKjnXcnBwL9Um1kerOW22gmdtj1c657x04tLKAD+Efbeh/MkFX8cE8oKdxWV0ezS1psCHSfevormGWP2vl3TcNH5bx7gxSAZyKEC1iAREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=ToxQobY2; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="ToxQobY2"
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	by smtp-o-3.desy.de (Postfix) with ESMTP id E546111F9A1
	for <linux-s390@vger.kernel.org>; Mon,  4 Aug 2025 11:33:36 +0200 (CEST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 41ADF13F648
	for <linux-s390@vger.kernel.org>; Mon,  4 Aug 2025 11:33:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 41ADF13F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1754300009; bh=Uq4X5g3VZoMz3vvQirTPUIXcQjxOl/VJcoqSulBgkAg=;
	h=From:To:Cc:Subject:Date:From;
	b=ToxQobY2EiZPzrd7HlvreX9M/Obb9wNrkFNClMQoZdk9qYF8vS9eyDK5dWKLSHPXK
	 ATeeUN7lu9+eSERNZ+cxcu4f+xFs0wr1flq0R3HM5w5RGbjKgUA8+7aiSLvuEmthtE
	 DfLhoTMuU9n9kKQYPN41StKHZAA834/N91mK/FHA=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 337D120056;
	Mon,  4 Aug 2025 11:33:29 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 2571D16003F;
	Mon,  4 Aug 2025 11:33:29 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 55869100035;
	Mon,  4 Aug 2025 11:33:28 +0200 (CEST)
Received: from zitpcx52830.desy.de (zitpcx52830.desy.de [131.169.185.171])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 2BF6E8004E;
	Mon,  4 Aug 2025 11:33:28 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: linux-s390@vger.kernel.org
Cc: gor@linux.ibm.com,
	hca@linux.ibm.com,
	agordeev@linux.ibm.com,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] debug: fix typo in debug_sprintf_format_fn function comment
Date: Mon,  4 Aug 2025 11:33:21 +0200
Message-ID: <20250804093321.434674-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 arch/s390/kernel/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 2a41be2f7925..c62100dc62c8 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1677,7 +1677,7 @@ EXPORT_SYMBOL(debug_dflt_header_fn);
 
 /*
  * prints debug data sprintf-formatted:
- * debug_sprinf_event/exception calls must be used together with this view
+ * debug_sprintf_event/exception calls must be used together with this view
  */
 
 #define DEBUG_SPRINTF_MAX_ARGS 10
-- 
2.50.1


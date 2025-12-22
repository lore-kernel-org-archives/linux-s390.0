Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C6322B9E
	for <linux-s390@vger.kernel.org>; Mon, 22 Dec 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766399989; cv=none; b=T6i5x5265fg3PIm+7t9oIEj5Zlgg0EVCVeavJRPG8E7dtFLOaKVDaZVmKMEEc0ULEGgYI9oFkPl0AFivjTaDLeh5f3jRNRN7z/gmZuwpKNThk4AC3AXTJF5kUnG7hGBbga34cJJ1yIeh+Bu9jZlp4pCeRZbItLlork1BziLkBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766399989; c=relaxed/simple;
	bh=6Kvj3j+JyJmJF6ph6iYiZFbe9YKpPNnW9BRw/TBVIZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZqlTV4VOu+yFn768BnpeS+YRjmDloyqVhTNDJq2FTwfI5oEm1p3K3X8d9htKVph+RO7bmVy1IUvk+kOe3nDBYbl15dYOYTo54Y54TK040LtlahjRzXjlGRPdTesBdWx+Eiyn2LQ3QfVV7Z6QHvJl9G2jqAsx/0DX7fdo70cQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XG6p1UvU; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XG6p1UvU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766399974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T/InfEgh1rmD6E2r53FYi8cfzL8MFjJ0vajZYP9KyzM=;
	b=XG6p1UvUhBaB0Q7XPYnOwdnSYikJw2IUozrP/5WyeXO23P+T2RknRzl3ueb2rtiN3fJEQU
	y4q2JdvjmGrWm2eFXOW2TphfV19wB1g0KcTAKYHhoM9bAnFrggAhBCODJ2H5TiGzxd8gb+
	XEmF6J6xB75vYCHLBxeZlnnsmiG+x3Y=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/cmm: Use max to simplify cmm_timer_fn
Date: Mon, 22 Dec 2025 11:39:17 +0100
Message-ID: <20251222103917.635026-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use max() to replace the open-coded version and simplify cmm_timer_fn().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/mm/cmm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 06512bc178a5..fa1318d748b1 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/gfp.h>
@@ -212,10 +213,7 @@ static void cmm_timer_fn(struct timer_list *unused)
 	long nr;
 
 	nr = cmm_timed_pages_target - cmm_timeout_pages;
-	if (nr < 0)
-		cmm_timed_pages_target = 0;
-	else
-		cmm_timed_pages_target = nr;
+	cmm_timed_pages_target = max(0, nr);
 	cmm_kick_thread();
 	cmm_set_timer();
 }
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


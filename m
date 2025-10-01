Received: from mail-108-mta36.mxroute.com (mail-108-mta36.mxroute.com [136.175.108.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6FA23771E
	for <linux-s390@vger.kernel.org>; Wed,  1 Oct 2025 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346362; cv=none; b=HZ5bfkC51XHqTP2qI3Kn0CRYv80fvyavUDrkZfLJeS4j78CEOmXamf0mVHflHdkPpPjFi3yR81DZu1CNLPcNplLwIu4yLYcOyWkiBc/BULGJiHYA9l+IGLdw+3HlK/aVCfItKHZyaq+N/sA1gWi/AA5G79Am+di6ClvNwi7rGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346362; c=relaxed/simple;
	bh=594h80OyON2XQmcAaxQpcVGMAMw2w4L+Qlb9R0x4JV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zjqn2k1qXge94C1/G4MxTuzbE7uW69CbD0pmqvuL25owTojiBiv+8ZIXHHYm736LOITRGqlo71UY+7Go2XwdvobXgVGoWGOuOpXvFzo+fria8TCLr2fQadrFuj49hMdC4CrRJotymz5DWr3LA0ifzUTGTT7qY44L0Cu9nk5kzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=Zm0O5wKX; arc=none smtp.client-ip=136.175.108.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="Zm0O5wKX"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta36.mxroute.com (ZoneMTA) with ESMTPSA id 199a1323bc1000c244.008
 for <linux-s390@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 Oct 2025 19:14:07 +0000
X-Zone-Loop: 482398f72c8b2b2493d7ba08abf3c82382f21336d902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2G+RTECY6xeBSpxrbg+lrExhrtNSlVzGXYIjlOQcgMw=; b=Zm0O5wKXbPijpkuRfpaOus4hz3
	6hbuArtzUx5saRNIJQcUh4r//ICv64qXvvRZOcfmAcBaZRZqJUrbWASp7m+UC7roUnpDUl1lI7TGv
	OxOt9fvmIBsOCILsl4FcHqYaeT3eyISeL7rQFFcyQOePLXD64kVzTL3YmGK+mZ5/v2IjBV4otIfJ6
	i+oH6jmI7IvuEMaBigYU2H7NrMmL49r3IAJQlAMWoWmycxqgl8itJN+H7LS3/b6ItnwEYB+zWWpew
	ANSlHRiEtXJcAZZJ5q6GVxsZjiRJU+ppMq7wmA29tNY8evBajLbIXTdlPQopi9TY3Fi0tEiujGtCV
	uNBVpA1A==;
From: Josephine Pfeiffer <hi@josie.lol>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/extmem: Replace sprintf with snprintf for buffer safety
Date: Wed,  1 Oct 2025 21:14:04 +0200
Message-ID: <20251001191404.239217-1-hi@josie.lol>
In-Reply-To: <20251001174055.192401-1-hi@josie.lol>
References: <20251001174055.192401-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

Replace unsafe sprintf() calls with snprintf() in segment_save() to
prevent potential buffer overflows. The function builds command strings
by repeatedly appending to a fixed-size buffer, which could overflow if
segment ranges are numerous or values are large.

Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/s390/mm/extmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index f7da53e212f5..b6464a322eb1 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -598,14 +598,16 @@ segment_save(char *name)
 		goto out;
 	}
 
-	sprintf(cmd1, "DEFSEG %s", name);
+	snprintf(cmd1, sizeof(cmd1), "DEFSEG %s", name);
 	for (i=0; i<seg->segcnt; i++) {
-		sprintf(cmd1+strlen(cmd1), " %lX-%lX %s",
-			seg->range[i].start >> PAGE_SHIFT,
-			seg->range[i].end >> PAGE_SHIFT,
-			segtype_string[seg->range[i].start & 0xff]);
+		size_t len = strlen(cmd1);
+
+		snprintf(cmd1 + len, sizeof(cmd1) - len, " %lX-%lX %s",
+			 seg->range[i].start >> PAGE_SHIFT,
+			 seg->range[i].end >> PAGE_SHIFT,
+			 segtype_string[seg->range[i].start & 0xff]);
 	}
-	sprintf(cmd2, "SAVESEG %s", name);
+	snprintf(cmd2, sizeof(cmd2), "SAVESEG %s", name);
 	response = 0;
 	cpcmd(cmd1, NULL, 0, &response);
 	if (response) {
-- 
2.51.0


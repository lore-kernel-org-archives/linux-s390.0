Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF71F30BB
	for <linux-s390@vger.kernel.org>; Mon, 10 Nov 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781358; cv=none; b=AEh3u/JskvRrRBaBSEsm+ExvU+gs/wL0wZhKggos9NeAhdbLjEYVtif9nXpySzrvyXJ41UmPXFf1EuhgYpoAh6HM0gcPmtBl+0DKX0FwtZVRcbpxc0ie6FIqZTORJrJdUNgEwOuAcor5MSlzEwDQRxHnL+tj+m4FajwVGN1WkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781358; c=relaxed/simple;
	bh=5dDjRHaeO+JtbPjyVlpUPFmS+ghtq7rnV7fEsu0CZUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOC4DUbfM+a8x2RRoF0lh+sIlkLOKIzT+HYTB0adNoqyl244uV6yrhavqWqkSUE5v47VX3bqfBbZ5hjaz6hwYsbOuoqXJu5YP/gPQQSGEtDCxm49bMlcUjhM23KiX/G4OZzjsKC4LGJd4LYXlPPfWyCD4ljYHoNhBPR3LxwiVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qCwf3er7; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qCwf3er7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762781352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eQIUSMn0SAMvH18fPzWa/uPooOxmD6oobH0S+38lb64=;
	b=qCwf3er7tTB6rDscpHyvYHfKXIqpX1EHXbdUsgCkncrrK2LFTBvwpNtWY67lgOJ7t/6eNd
	+dIrHi+hHmVQ6y8hdT1LzT8XRjsq5KqkhKsPYMDNGpOJzJ+fxGxzz23Peqjuc4e16xSoWG
	mhoEfzKuHAbK0bjxwZv176NsV9s1shA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] s390/ipl: Mark store_status as __noreturn
Date: Mon, 10 Nov 2025 14:27:51 +0100
Message-ID: <20251110132803.1520-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

store_status() performs a tail call (BR_EX) to the function passed as
the first parameter and does not return. Annotate the declaration with
the __noreturn attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/include/asm/ipl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
index b0d00032479d..637b29bf8a6d 100644
--- a/arch/s390/include/asm/ipl.h
+++ b/arch/s390/include/asm/ipl.h
@@ -164,7 +164,7 @@ enum diag308_rc {
 };
 
 extern int diag308(unsigned long subcode, void *addr);
-extern void store_status(void (*fn)(void *), void *data);
+extern void __noreturn store_status(void (*fn)(void *), void *data);
 extern void lgr_info_log(void);
 
 #endif /* _ASM_S390_IPL_H */
-- 
2.51.1


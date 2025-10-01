Received: from mail-108-mta141.mxroute.com (mail-108-mta141.mxroute.com [136.175.108.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3AC2773F3
	for <linux-s390@vger.kernel.org>; Wed,  1 Oct 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336901; cv=none; b=rtdrFnBhIiocmMYrCdD4uu6YcmDyQ/r3yAc+vGmk+IE5DGN+m+6UyyfpVEItVcjqK545dO5kJacF3i3IZcketphVqt5kygV8R/t94eJT3cAz93K6UvJP5c30/Em5ofTaonIIYqBn1qCn4m2d/jbuFjJLaPsaY9K/uuD5XkI3LWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336901; c=relaxed/simple;
	bh=swqdbT4jab/ALeaUUe5hxevREAFBu9sSDetdj/EqHyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfDF+AfHIksfzKSWaUgzgbuJNRiJxXWsXWeuwlGjvxEWieN5QHC+aVVDtLO1FrgIvPE/GeFJNQ4brHzeu0ehcg0a5f1wOzucUeuhADm9gmKK70+D0AEd5axTfqxumE45MNFZeiKx8Hqu6sRDlz/2Ibv0H1gkD2lAqv7hQ4zLymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=dn2qdvHS; arc=none smtp.client-ip=136.175.108.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="dn2qdvHS"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta141.mxroute.com (ZoneMTA) with ESMTPSA id 199a0a1dbec000c244.008
 for <linux-s390@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 Oct 2025 16:36:26 +0000
X-Zone-Loop: 958000758e91f7cfaa392b33b6ff4c3c9dde504d4c4a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=SmRueyWLp08d1J7X5zA7xIae/GZpHWZua3Wla6Pf5CU=; b=dn2qdvHSMctm
	SRjpStl6TdBIzwPfAE8IkSwQ5DXHRzSzuDBvA2N/2VUPdlnL38keEvli9YzJaIulKTSFf3/EfJTLJ
	lu3pfFAS7upFRbFjD1JlTMQUSw/El//bORea5cA1uKm314sjtJZngO2BZnvbquzPft9UXZjmkgYOS
	MDxglMInHIgYLGZMUhUhoob+Ro8bndzWbU1eS3kvEq1NcD7oIvXhbMMKWEP3b9x7CT+D4XhO9svdD
	a4IGguQe5HoRElRKWqY8Fxc73ppJnuvjGBt7aIuRcWX1LSamMCZRH7BgqruT5hYcNz2+X0PogNAhX
	/3E7MxXxP+9zMyTLyAtmQQ==;
From: Josephine Pfeiffer <hi@josie.lol>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/cmm: Replace sprintf with scnprintf for buffer safety
Date: Wed,  1 Oct 2025 18:36:22 +0200
Message-ID: <20251001163622.164143-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

Replace sprintf() with scnprintf() in cmm_timeout_handler() to prevent
potential buffer overflow. The scnprintf() function ensures we don't
write beyond the buffer size and provides safer string formatting.

Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/s390/mm/cmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index e2a6eb92420f..eb7ef63fab1e 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -321,8 +321,8 @@ static int cmm_timeout_handler(const struct ctl_table *ctl, int write,
 		cmm_set_timeout(nr, seconds);
 		*ppos += *lenp;
 	} else {
-		len = sprintf(buf, "%ld %ld\n",
-			      cmm_timeout_pages, cmm_timeout_seconds);
+		len = scnprintf(buf, sizeof(buf), "%ld %ld\n",
+				cmm_timeout_pages, cmm_timeout_seconds);
 		if (len > *lenp)
 			len = *lenp;
 		memcpy(buffer, buf, len);
-- 
2.51.0


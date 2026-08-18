Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3111384CC3
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036436; cv=none; b=LyrOjsTHERwwX3dmBrrRlMkwbJF6f0J0+wxqLHaASNm9MalyuDRlKo5DB0TBSnS22+WS8sL6/vq9xuMRlpX+jWc2YkcEwG0iM3/jW+sgUjNygl3JSj480P3Xql4O1p0TVyRbqtoYqeLZMXgaLzjjga53ceS8CBC8yJm9z9E71Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036436; c=relaxed/simple;
	bh=RmPMf2iX9Bi2ScNYsp8JG1JZjtJHkkgj20FjkZIt+uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhqrIcyVd97osfSl3WMFuW0J+kObg2yn8rXAceGFAnfpDEKmWXphTIW4TPM0flITCdyADkj+fhNEjQT0CRVAsby8+HzeWg5gpqHLERFnZrkzKUtXKL7GwdCBO+zd/GPRVWNLou94qcsqt38vuWZCsHsckM7UdGC56KnPbDj/SUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e99rpUfO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e99rpUfO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc891373e0so55726175ad.2
        for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036430; x=1787641230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R7tQNnTq6jHzOznuQxy1ZNm9UkJ7DFP3G0U0MlM8C7U=;
        b=e99rpUfOHI4h53KRH1lGv9I6gMv3e7ti1vG2sm/Ue5d49jwODVdNjjLiIDNQEnLkAL
         nJJntmE5wIgt0ZnFF4/sD2HerAfdTrVkRp4HBxp7y+t3W3xv9ASR6ieXCI0sbpzYDcYn
         iUdkiKRWI3uIZsa1uhJhqBlG5nW/i5KuSgjzQ639zRrWCjQqyNZLhNXzdH0MAnvI4YK2
         m7HX17jrugpLJNM72GY5hjrRwB9aXJ7u5rqxXYSUn/MVtwLPsbcphh21OFrXsaX2Cu6n
         u/y0zrm0mNhKnrSuk1ic5SeImpCi+i5id0OYsyzL2dy3LI+19mtk/5fw9EH8L6043Esb
         RstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036430; x=1787641230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R7tQNnTq6jHzOznuQxy1ZNm9UkJ7DFP3G0U0MlM8C7U=;
        b=gl7NfaiFU2UqbDzIUyLdncjXApxNxUdQHyeqIg5tN8RqZT3EjLc0xGr6f3vp6OTDsK
         tUM39SMbdmV+mcmTcktZdMdcrnfmra5NWWNNcf9Hy1/QJ0BUdPen6j4bBmBQDDXDDKVn
         Lmkrl7oJKh+AGcrapAwKedgwOU63B74ipzdYL22ftL38vj6OjO0th74iDQaMzAMX/R68
         jCHleoAda9RcjAHxXGDQ9W2Y4C66uRofDMCz8eFE62052AmU7lozAOIVA6ym++qT/aQ5
         ywN4baDSZ6NugI2KmXM67ecMJiNIGfUxzJ1ewIXGSLPBPbiQ/qlYlC3Y/Zf91WxYTZ+3
         N0iA==
X-Forwarded-Encrypted: i=1; AHgh+RqkbZkAykB5V2XgFEr5ix+i91uSpolYbXo61zNYRt4UADxBd+bErELXwigDGW+EQEmjdeb7HUvQH76Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JwaICqJR1byIzPnNqzqtkKCgCA3aoSrhER2/NGEt09ky3lQF
	6KqdwvaB5YpYMfKotOxuUsMZ9DXiEufJ9fHnvvs+ZAfBKduvTnrko74=
X-Gm-Gg: AR+sD121mTJG+unsILpSdk6EjP6lhvSisQrhNy4KZT1PJPzGKD1aNvu6m3KZ8x8Eonx
	44dEh1ai9eFSbgqXq8/ykiRYBliTxAeqUj9v4W17v8L4mUXe8HWKdE4jh9jZquYVWaea5sBPLmm
	Dib1HDLSUDKFIUOqpEjHGdiQleUcJQRwWtfb0bKmHbMYRAFtDVhBqEtH32McCc+W6Q1p5lNaxZ1
	ls8V9oBn6badan4mba5sZdHcxP6meVnmB2ihna+WCE1eLpZtH0rIQFIgueEHYRTDqqWc1TwOOkI
	ib9whGTPvJc2nTVyNwZMLpddb1HgoFIYlv+9nTx0YE1JlWypUlnXA3CUraJmFo13OaO5Kvvjq8i
	DBkkqgiyh1IR/FtdmJ09PFrZOLFB9bH2AIY2DjcIzgk85Xq8NNQNBebrXkyZbl9OfWkRvibDoYc
	y27Yp8xNF5M39J61AwZcOaejHomCYjFTEvJTKBB4r7Ty13H7/ahxDQ4NQS2wShurXHAVz8zTiRb
	A==
X-Received: by 2002:a17:903:2312:b0:2ca:ec6f:aeca with SMTP id d9443c01a7336-2d3b0dbbf0cmr317491465ad.8.1787036430183;
        Tue, 18 Aug 2026 00:00:30 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ed8b3esm10804285ad.73.2026.08.18.00.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:00:29 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: hca@linux.ibm.com
Cc: gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] s390: raw3270: Handle allocation failures
Date: Tue, 18 Aug 2026 14:00:23 +0700
Message-ID: <20260818070023.1654606-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return values of kzalloc_obj() and kzalloc() before using the
allocated memory. Free the allocated resources on subsequent initialization
failures to avoid leaking memory.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/s390/char/raw3270.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index aa9c4d81225c..69e0f69a3e14 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -814,15 +814,26 @@ struct raw3270 __init *raw3270_setup_console(void)
 		return ERR_CAST(cdev);
 
 	rp = kzalloc_obj(*rp, GFP_KERNEL | GFP_DMA);
+	if (!rp)
+		return ERR_PTR(-ENOMEM);
 	ascebc = kzalloc(256, GFP_KERNEL);
+	if (!ascebc) {
+		kfree(rp);
+		return ERR_PTR(-ENOMEM);
+	}
 	rc = raw3270_setup_device(cdev, rp, ascebc);
-	if (rc)
+	if (rc) {
+		kfree(rp->ascebc);
+		kfree(rp);
 		return ERR_PTR(rc);
+	}
 	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
 
 	rc = ccw_device_enable_console(cdev);
 	if (rc) {
 		ccw_device_destroy_console(cdev);
+		kfree(rp->ascebc);
+		kfree(rp);
 		return ERR_PTR(rc);
 	}
 
-- 
2.53.0


Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A755C1A;
	Sun, 23 Jun 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144225; cv=none; b=OE9hDQ3ou35EtINvZhAtUj/yP1/GkDRypZv4BcTPfYhsIJoSWTFBIS6VWKwJs1uBAgp33sNF9NQfFIQrHKq6bScEoHBLIeZoTT9mIItqwvgcpZ6czgs0HOEIRgYrJ8pVNvYUSF/NOrvraXoCm2uGYD/s2cpCU6z/8Gnun7VwbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144225; c=relaxed/simple;
	bh=1ejHMVfM/x1I9WH/AOfTOYsFcicOOrHVTNcQMO9V9T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Swqlo3YQ/ugPNXUm8dla/adkQNL6WetRMwyvEtmgLSRJWlgr0eEBxRiQ+woBLyc3jvyQU6BUEMfLN7pqD8Cv+laByqykN198XGY/XCZFF36L4QkQUTGLZusp5VE8MXZUvUguvHJ1plwlZHFb2Njlfg2fWJ+Oy/ZZEqExEl2EhhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKNkwzgp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKNkwzgp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f862f7c7edso26336325ad.3;
        Sun, 23 Jun 2024 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719144224; x=1719749024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnQ+CeHuZXlYO167FONNTk6/FjCBP/TpIYsSm5694xc=;
        b=JKNkwzgpdIdCAaS6JM06lmq811pEaKo5nHU9sQe6HWhOrZXBdlSAOcVqNQk61j3IJo
         WT0RJlbU6QT7qsq66Sx1/BNUPR6DLRY6nJOO0AFqQEG0ijZpZAfUoDmYUr9gnCqySnwY
         6FZihtuPa49liYqmaHoeRe3K7LRm1czzEJ2TiyhHKsm0JWLtmTYCTFj64hEPCJ/1qz2U
         uJNAJMhmUAfCl4sOW83adfUP0U4FElAKbcTejGHDLWrIuMhPXQKcq1Emg0IwbdS7vGo7
         wnVh5jGG3EOvSbNQoqICgShCm/xd4g3Yqq3oGzWxgQZhY9ewVbMhjFrxmUOuw5Lm547X
         clrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719144224; x=1719749024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnQ+CeHuZXlYO167FONNTk6/FjCBP/TpIYsSm5694xc=;
        b=p4AOJGvBn4hxxzreNgdhYZZ5bfIIequ67ETzSdsXBgIIUZjYlG1ZQ4b+mMi0mFPr3k
         nadjg2YldvFnBvnJiy4bbpMcOLSywCfgJ1rP6TIqZ4ueF7T6ZecrYXHmKipLlt8trD85
         IOKeoJoPqyE+ymakBWhMlhaHolR0+5CHsToqEtMwj5Zoo0bhG9YWdFDt7FacC7LLZdXC
         BtrzesYZU0vb1tG7p+vY9i7GNCBsncCoIlIngcWa0gEwwhKtGvUnB5cFbw8qdpT+VWLH
         C0P895prUCLSQHFWt2Tl9FlF53vMUXVyznqHJG/AMWk6k++8TMO4i62Ueh2NJL69tdLY
         0juA==
X-Forwarded-Encrypted: i=1; AJvYcCUWGi/CQDw1O8LTLeNC7xOtL7qIsWhba033Jta65mkp/N7qPzTANQJr/QOGEpKpP74hlSWPnwb+gIsAiica7e/89njk1uBTXSvme4NVhghXi/npE4/DF7io/q6bZTOdIDhOArDyBOw2ww==
X-Gm-Message-State: AOJu0YxVUCh1FcfkGeilfUy9zQcKywk5UnI+J8EDh51tj1xGUzMt27Wb
	aTgsX6CLVA2lSWEBfRs+JKcZiVfU48x0c4zQjgWakrLRz3Cb2ruE6aCgVw==
X-Google-Smtp-Source: AGHT+IEPb5xME3a9IS+fRFpSAE5BQuoZ6z9qef0vi9HrYc+oM9FrRBDiIFAhlEMXkvjwfyzWbKILkA==
X-Received: by 2002:a17:902:f693:b0:1f9:a602:5e41 with SMTP id d9443c01a7336-1fa1d3b7218mr27947185ad.1.1719144223417;
        Sun, 23 Jun 2024 05:03:43 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf962sm44141545ad.231.2024.06.23.05.03.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Jun 2024 05:03:42 -0700 (PDT)
From: yskelg@gmail.com
To: Harald Freudenberger <freude@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: shjy180909@gmail.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] s390/zcrypt: optimize memory allocation in online_show()
Date: Sun, 23 Jun 2024 21:01:49 +0900
Message-ID: <20240623120147.35554-3-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

Previously, when setting the online state for a card, the code would
allocate memory to store information about all attached queues,
regardless of whether their online state actually changed.
This patch improves efficiency by only allocating memory for the queues
that are truly affected by the online state change.

This allows for a more precise memory allocation (based on maxzqs) which
can reduce memory usage.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 drivers/s390/crypto/zcrypt_card.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_card.c b/drivers/s390/crypto/zcrypt_card.c
index 050462d95222..2c80be3f2a00 100644
--- a/drivers/s390/crypto/zcrypt_card.c
+++ b/drivers/s390/crypto/zcrypt_card.c
@@ -88,9 +88,10 @@ static ssize_t online_store(struct device *dev,
 	 * the zqueue objects, we make sure they exist after lock release.
 	 */
 	list_for_each_entry(zq, &zc->zqueues, list)
-		maxzqs++;
+		if (!!zq->online != !!online)
+			maxzqs++;
 	if (maxzqs > 0)
-		zq_uelist = kcalloc(maxzqs + 1, sizeof(*zq_uelist), GFP_ATOMIC);
+		zq_uelist = kcalloc(maxzqs, sizeof(*zq_uelist), GFP_ATOMIC);
 	list_for_each_entry(zq, &zc->zqueues, list)
 		if (zcrypt_queue_force_online(zq, online))
 			if (zq_uelist) {
@@ -98,14 +99,11 @@ static ssize_t online_store(struct device *dev,
 				zq_uelist[i++] = zq;
 			}
 	spin_unlock(&zcrypt_list_lock);
-	if (zq_uelist) {
-		for (i = 0; zq_uelist[i]; i++) {
-			zq = zq_uelist[i];
-			ap_send_online_uevent(&zq->queue->ap_dev, online);
-			zcrypt_queue_put(zq);
-		}
-		kfree(zq_uelist);
+	while (i--) {
+		ap_send_online_uevent(&zq->queue->ap_dev, online);
+		zcrypt_queue_put(zq_uelist[i]);
 	}
+	kfree(zq_uelist);
 
 	return count;
 }
-- 
2.45.2


Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA345C1C;
	Mon, 24 Jun 2024 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268369; cv=none; b=tyeASH1T2NHk7Ck1YL6x+DurN/nUvOq8oaTJW6tofQqIUQpjv9t973pCPhpl6YwaKJtmVskl3lr6OTAzwC6f6n5SP/oWSKVXSZq/mOfwAAMs0iqjt8B6knSXhwp/ABAVFvspKlKTPH5qxNoluGs3ewaSXdU8EdsuKljr8dGaOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268369; c=relaxed/simple;
	bh=aDarChGst5JU4FRRPlrSQu3s8UZa9gedrtszGLBRw8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulwdt8X5D84MozuZW/12VCEUji55SXQBjHj+allrYU6f+tWOLIU2A9UT+WY9XMKx3RbgZRHVv5siURQ5YLuN64pTuwXsAWTuW7obvHdTs1fQy+2HYQdGy9H8oSoIG8nQ4xHCjxZ95LQCrU4Tg5ztqhL/45TOZvPTDn+gyUhg+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awX8ePLS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awX8ePLS"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fa07e4f44eso21626935ad.2;
        Mon, 24 Jun 2024 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719268368; x=1719873168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EgTvBBG51/i76Zk1fIUJ5PiGRL4CV4PzSjno4NYiILU=;
        b=awX8ePLSkcxWQBzu26Kx/qDW6/hMoPn6s/B58TNZB5Y9IEM8blF0fLy+7FMne5LaL7
         neo4DMMLGNQb/KwZjMEGI2CpwFIKytrD9jJgQTgX6RBV3+LOKF7CGtaYx7sCrwhDcb1B
         v93C+xjd378uUFcdK6HKpcrdhW+6jK0uu1Rfi/Sp+vm+bnM1wDMn2JNiJ37w+owXzjd0
         0bX7Oe1mNUoYxkYOhnpnsyXQpg5pPxfXxeLlWBo6vUMUos1AnqxtmZ515Xg+EzsuIkMT
         1optpuL00v5mtRAuaq8/f4xEdQ3GxGM4HQWaHsS2eVgwCSUre4BTW8IdwuEQnDCfwTmY
         diGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719268368; x=1719873168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgTvBBG51/i76Zk1fIUJ5PiGRL4CV4PzSjno4NYiILU=;
        b=r4qbCq5DbgMUvIByiR5mpoqXWNhqaiE+WLD2Nvw7qAtb8KPbdPxCLqOWoLMIwVLCGQ
         m+EJXENGf5gB/MyYXFYhwqTFGQCqyl8l9XJ8K4hTVAO3MU1CH6r/IZQgbl+W8pfakiYg
         u3gITvcddqtrNwQHsRX4ZZplHi8RrMmQDN8w5HbDYrRgJWwXiO4N/5hTw/flux5be1Bg
         52E4EZr8Ll71RSL2eidHsGf2IXVMEGylONobC59FJx6TsE3CMD23/0AAtlHaYiQzd2vw
         1TGacW1PczrP/IH7+3bjC04kr9vUl+fSkGMFelRcjEt+lxzrf8ZK6jQL8vCMINaasF3x
         aM5A==
X-Forwarded-Encrypted: i=1; AJvYcCUteuIy9j9r870qdxvT/TgSHwbkcjNCxr1U1zhD/JshP+E4ntOZBk9mifMndGUIDrDoPwE0RNJiAPsCcJQ1YA0XTSM048TCTW/oTg7Hkgzarx3Rfl+X1tTt7e0kyUK8WYXJ28/C+QRTCw==
X-Gm-Message-State: AOJu0YwtrZp/i16K+TJODoCeQCg1OOnL9+s3YCETie53/3YpeNNAyx1I
	W5FQWcqCgxB3z0jRpYTc/OVFBozrXbU9ThoJbWcvn2DWBhqqg0Ze81HFzA==
X-Google-Smtp-Source: AGHT+IE82f+g69sHqQHJLYWvzBqwSk9cJrVlw+unAMg3RualR8uXKLfyCpACfyj+7tdgG8R9Tw2V4Q==
X-Received: by 2002:a17:902:f685:b0:1f7:1017:b2b3 with SMTP id d9443c01a7336-1fa23ef7defmr71120835ad.42.1719268367529;
        Mon, 24 Jun 2024 15:32:47 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa13fed3cbsm46357695ad.269.2024.06.24.15.32.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jun 2024 15:32:47 -0700 (PDT)
From: yskelg@gmail.com
To: Markus Elfring <Markus.Elfring@web.de>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: MichelleJin <shjy180909@gmail.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH RESEND v2] s390/zcrypt: optimizes memory allocation in online_store()
Date: Tue, 25 Jun 2024 07:31:39 +0900
Message-ID: <20240624223138.81769-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

Make memory allocation more precise (based on maxzqs) by allocating
memory only for the queues that are truly affected by the online state
changes.

Fixes: df6f508c68db ("s390/ap/zcrypt: notify userspace with online, config and mode info")
Link: https://lore.kernel.org/linux-s390/your-ad-here.call-01625406648-ext-2488@work.hours/
Cc: linux-s390@vger.kernel.org
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


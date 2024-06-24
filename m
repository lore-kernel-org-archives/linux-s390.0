Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253145C1C;
	Mon, 24 Jun 2024 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268236; cv=none; b=HYp9bhfxSG5n6eWwnISguO/9Y5OR0DmhrHqBDRHyH9pZxx66SV9kX+xs0styFpu6WX13ijbL3F7dHfd6aeFoseBEGb0ipNUeehXKzzqcT4syvhEhORH8x4tNHYAJSaHb++j9vOG5NX2tMSOQOMheBCGVel0lWpBxyNsWjjI0lNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268236; c=relaxed/simple;
	bh=aDarChGst5JU4FRRPlrSQu3s8UZa9gedrtszGLBRw8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ihzuma2eNGpbJ4Mw6d2YNfXxrHMr+s0w+RKCt+TonrN3l5rZVu2u+/sghdjnkUECNiKZby00YkqaAcrIY32n/t6kTI/JQGsojGp+me4OMesWStMEkNzeRSPhwGNGF3elf1cfR/KLalxAqmaUz/Eukl2e7e8YuHQ4C1v/OYKQqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS/p41G3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS/p41G3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f99fe4dc5aso36735675ad.0;
        Mon, 24 Jun 2024 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719268234; x=1719873034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EgTvBBG51/i76Zk1fIUJ5PiGRL4CV4PzSjno4NYiILU=;
        b=IS/p41G3d1j57vj6QlMzG/qcWm+XdGz4leK9953bD2P/vxROPSKHHMiAzb1zzRVGRj
         SpaFFynXjJosS1BlFQaAjIggjul3mZlAiJc9HK2XZUGGF5pAVB02a1A6HGbq47qZ/lA6
         sNP3s/EffrR/1ur5qceI6iMoEw2gi8Q87QOM44AYEeR0uBvBDUhWiyf82nvcc4ret2QM
         Wa3awzTQ7bqOfTNrJTJSmmusUNbI2awsuh4qJzbFz5aGYpEZ4RvPPiTsCbvxSPOcC/KD
         tx/n/WiAy+MGboCSelmhLKQrZxquUyEswq7cTMlYX2UbCJ8JoBGA8NvhrKRZ60GV8OJz
         BDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719268234; x=1719873034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgTvBBG51/i76Zk1fIUJ5PiGRL4CV4PzSjno4NYiILU=;
        b=Sq6x2ypeTZN3Kzxczcg1s7n5mL4mdRfz6II4wlChby0TMQSPmWGWxAO43Evt/v1Uzm
         Mx00/+Si5QW2/L45w3lg7K5NELgAEFecfPTuuboL0+MUe7LCp6meveAAtZCjCrsI6Oxb
         syGJwUIktfpUOU2kPExSqc/5JVjdxMDzG2G/1Ef+f1fKfKSeqSbpQZjiXe9AfJgdlbmD
         azGfEYW+vUkgTBC1fAHNEYcd6QFJXZbI8HhSNWkOu5yI//9UzKyqPNpnnKlousx/UKhl
         8yrYA8RUCS3o1ZHGh/Umm/OBqvg2Q3TadiMfuT2ss6arXmbI6nTAlo47h9VEDg2qbCSH
         Mz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnvmTRacbbMlII3TY2A9BbsXqK0EncuktRHYk6C5T8q5elumdAPoBj5kSSdsu7Qi4fGv45NK/Qpo9I/MvzpexXqqes063UuPS1A4dU8F36dYHCb1E35qhbEpNMlZey4KgzsR5wy8HEDA==
X-Gm-Message-State: AOJu0YwN2K8vQ+eqFMpr9B4CgkElovRtPCGgY5szlHJlRK3t6Q9X3tjR
	VeJRW/ad/OStsGPDB7LWrRe7nwBu82ISUZYy1ZB96k9bKtR/ZDY4o19BOQ==
X-Google-Smtp-Source: AGHT+IEXHA4y3ZnHrHZJTq9rQL4oJYIcK6tHQBf06oCUMzkBoIQWnfzg2owY2YLxUXepk0aawRHfeA==
X-Received: by 2002:a17:902:e5c1:b0:1f5:e635:21fc with SMTP id d9443c01a7336-1fa23f21fe2mr66101835ad.21.1719268233879;
        Mon, 24 Jun 2024 15:30:33 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb30b27asm67956615ad.48.2024.06.24.15.30.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jun 2024 15:30:33 -0700 (PDT)
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
Subject: [PATCH v2] s390/zcrypt: optimizes memory allocation in online_show()
Date: Tue, 25 Jun 2024 07:29:34 +0900
Message-ID: <20240624222933.81363-2-yskelg@gmail.com>
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


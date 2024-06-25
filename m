Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDF717727;
	Tue, 25 Jun 2024 01:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279287; cv=none; b=FrickQ+fMpAQ7E4BRLETv1HqkUcuiBm19upwITl8kj8J85/ExcXulK2Q4xQih+zGvLItQ/x/b5uqwZMRJT/ZOMLIgEkH4GfDndhnhMuOZvUIicMospoXSRqE55BrRd4QLLPVAsGJFU7ihUcA0keJgwOZFuuq7fLoxdryT4mNMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279287; c=relaxed/simple;
	bh=yYo8k4kUrpGzhRjzls2WGueKu0PGvyYBs46uyLt6T4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=In1ZpzjisNdajANvoJG4wk5IEV1J/MRQszzFtcmbrLUh3zA0MxbfXgICtdfywXuqNPbgDGa20ytKDXRkQ/wdbWrrKByjzJj4uH1+qDzbPcV5R7QtjK8gL4ykan9fOXRpc3MjX29RD4vmX/cdeY4M6+CEYzZi8zQPnwFxlNZC7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDScxk4y; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDScxk4y"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c1ef5ac47eso1012730eaf.2;
        Mon, 24 Jun 2024 18:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719279285; x=1719884085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2O2TW7XbF5ae+IR/yu9jsK1asKpGRJzGj2qHQztnGWg=;
        b=RDScxk4yjblGXPRl8Ttp3M2Gvpo/mnfDCdfjKF/b4lyByhG9weHlZtQqiBrpljiJ3M
         Z5VD5OQWFqW+nqg20Shp3y6CLPPTO1CXnWemnlBGhprwD3cd8rRF55HQFE4GoxQ6ZxwL
         xROXZe1RFHpc7g5A5DwOdbxNIdJNimO33mzZ53LSgqo2g0lHBbMKSxjGXyaHfbixFiFM
         kEew2RoMwoQkceOqnULctsDMGiUrzAu1O4dk9o0jdeyZBOxs4exkjRsIRlm55Xm8p6cA
         /qNQoeflwifVutk/vCV9wd20ukycA0x0KPY+TpaJCvLVpOMI7LoyOZHZnSVfqXAanyJ+
         Ebww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719279285; x=1719884085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2O2TW7XbF5ae+IR/yu9jsK1asKpGRJzGj2qHQztnGWg=;
        b=cIcCsNVIt0Si6it15WopbcWsw1W3m61yYqRRPY8lv9NmY58e88dP0MWwKt7dBRiYze
         EE+3KNn9+EYjeb1GTzmFhp9Ygug40eyPRwz85fJqYoR6MtwVbj8NJqwksK9H30MVXt5T
         uYOb8vhypqy5zy/S3WrZdZuERJrOHW+b34dnkqKxHg05vAIO4+ADEsi6jXUfbiBPFtLN
         XZZLPvCpQcMF/MSvZF43OXCCm2ikTIhvLN1uSELnjRS/9fuVXP2NDfVHX9Tq1QFC166d
         xudbF5g8lw+cJvSt0uCM4tQd0C7aq9yNChlIaBju7uCHF+qA+8ySBUYdKKZkCm1AlvGd
         adQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoSuID6Oqd74iHQqW145gqeZKd6xGk7m7jGWlt4wEnUYCsmdvo6r+0Mb+SkI98RYzkytX0QCL7WfuEL8ymzBzrM0wexiAs8qtQRZZExRl1ssUjWAKbfN+YrhrzQQpIfTOKkmX/ydIkig==
X-Gm-Message-State: AOJu0YxgXrKHZw1RNgkaicaPCDnn/m7yB+AFLCSeRYxxjjsh45A4QEB6
	UAnb4jEkGPegJZBv/XniKQtK3wDUiBFDTFYayUaqd4tH+NbHCQOEaj8z9g==
X-Google-Smtp-Source: AGHT+IGnmlhtAxgHfbyK08Mi8n5iC280q7zCZibuChaVXzMxvwHYN1zHlPlI2uxOgZmF9W/Oj4TFYA==
X-Received: by 2002:a05:6358:340f:b0:1a2:3a1b:58b with SMTP id e5c5f4694b2df-1a23a1b065cmr694725155d.30.1719279284702;
        Mon, 24 Jun 2024 18:34:44 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-718d5e33106sm4041921a12.59.2024.06.24.18.34.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jun 2024 18:34:44 -0700 (PDT)
From: yskelg@gmail.com
To: Harald Freudenberger <freude@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Markus Elfring <Markus.Elfring@web.de>
Cc: MichelleJin <shjy180909@gmail.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH v2] s390/raw3270: Handle memory allocation failures in raw3270_setup_console()
Date: Tue, 25 Jun 2024 10:32:26 +0900
Message-ID: <20240625013225.17076-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

A null pointer is stored in a local variable after a call of the function
"kzalloc" failed. This pointer was passed to a subsequent call of the
function "raw3270_setup_device" where an undesirable dereference will be
performed then. Thus add corresponding return value checks.
The allocated each memory areas are immediately overwritten by the called
function zero-initialisation be omitted by calling the "kmalloc" instead.
After "ccw_device_enable_console" succeeds, set the bit raw3270 flag to
RAW3270_FLAGS_CONSOLE.

Fixes: 33403dcfcdfd ("[S390] 3270 console: convert from bootmem to slab")
Cc: linux-s390@vger.kernel.org
Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 drivers/s390/char/raw3270.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index c57694be9bd3..4f3f98bcbc83 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -811,18 +811,28 @@ struct raw3270 __init *raw3270_setup_console(void)
 	if (IS_ERR(cdev))
 		return ERR_CAST(cdev);
 
-	rp = kzalloc(sizeof(*rp), GFP_KERNEL | GFP_DMA);
-	ascebc = kzalloc(256, GFP_KERNEL);
+	rp = kmalloc(sizeof(*rp), GFP_KERNEL | GFP_DMA);
+	if (!rp)
+		return ERR_PTR(-ENOMEM);
+	ascebc = kmalloc(256, GFP_KERNEL);
+	if (!ascebc) {
+		kfree(rp);
+		return ERR_PTR(-ENOMEM);
+	}
 	rc = raw3270_setup_device(cdev, rp, ascebc);
-	if (rc)
+	if (rc) {
+		kfree(ascebc);
+		kfree(rp);
 		return ERR_PTR(rc);
-	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
-
+	}
 	rc = ccw_device_enable_console(cdev);
 	if (rc) {
 		ccw_device_destroy_console(cdev);
+		kfree(ascebc);
+		kfree(rp);
 		return ERR_PTR(rc);
 	}
+	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
 
 	spin_lock_irqsave(get_ccwdev_lock(rp->cdev), flags);
 	do {
-- 
2.45.2


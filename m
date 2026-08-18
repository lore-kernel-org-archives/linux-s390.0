Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED882E7F3A
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038335; cv=none; b=NWsMP3DIQvwiEyr2LMALpcU0AdszYx8+NSi2GV1qivSNIyJkvx4P+R7kwyxrcHiD6qENpLKEkSN872VEWm0eBks2gZce5hj7/NSplQS+4nmggM/Ur8cprQKzNpkcLAjBU3ffKEi/s5HszVZLQhQf9GJCBZpsH0R8uEtua3rVTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038335; c=relaxed/simple;
	bh=TfjiOCbrVeiQ7FKcAcFUsQcN3uo2M+bO3SMnL1fpgWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ai/SVLoIKRM3E/83ab+tilA5cEY1iqvHIRxfpTjHDNts8W4vvJELOZSY8olUaGxLHGp7i9xUAeDTjITcAgIeYa87WYWQeoIUZGpmryoGojkDdDHpEOdqk0RAMLWzGPDUL+RfpfzywrBS7quwbu02x2EF4dLYDCLLH/UiVaNpBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl1DQ7YD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl1DQ7YD"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so5139030a12.2
        for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787038333; x=1787643133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LRXxlJ+/F37gt73zWnOLTZBqT2VhJb2gCFxX84MkoKY=;
        b=Rl1DQ7YD5sQkLBzp7B3KhI5gzT/p9M2EFo7t4aze+hmkh8ahT99m+VpLpEyl0AdlJ7
         0LzbmXSzCWS2eLyjb1t54HrKY05huZRurszbzmXJEc6LCmjBi77Y1wwOWascTG+pujqw
         NQUsqAsKyUbNt020dSb87SBcdhHDEqOfrdOZw9yDgO7UMi+fGbJjsQVFvJKLkn3fYaNf
         sKO+kvFOCH7Xf3R0rXJo48udyzhx9erFyG2y2nekyLYERntldrnLD2kfvff8gRwGMpuu
         uMSHgpOVKbCcp/x8J+HkWcM4BIuJc0kTQGVUc4fHSCsA0ajPGApLB8rAyLRDDh7NjGlC
         13Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787038333; x=1787643133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRXxlJ+/F37gt73zWnOLTZBqT2VhJb2gCFxX84MkoKY=;
        b=o+mzSULjhjuorIE5FjtZONPjZ8L8GDk8GYbAngJPN/zPjj50yT6zXXxgs355WC54CP
         c0RVPraXbwMHDMQPC6ENyLzbbPn98wrCaxm9DP3iSfsC04U5g80k/HPvX8RoTij9lfg9
         pUebgUmqU9olNA35AMci48NvCrI58YrH+68e6V5o0AfUCq0C8IvjANM4dqo3S0M4l5e4
         vGSjRdMzan71mm/udtEgVmADoLHzGzKEpzHU/cWqbUI4q0VS8AKInzgCvpiqLEJirMuo
         YGVSuRJQTXYFGs+ov42KNW4H4cm1MmUYWRUGIKKy+iG3h8OxqeVz99+jQyHH1gGbE1SN
         WC3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpv1GK1gNoP7FldWzBzKj1layUdfLzZKgIgONPTVNrTNdWnH/OlrhNhCNjp44ssTSV22SNw98ZE8d1P@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84tmaHaZGC4ek5ywLoZk5ybYZahEZLyq4OkICXaDbIb14dlpw
	HMFy/FVs1IlQRb9qoXY0y4Rl2sHtjGMbuj7HK6q5TQDZgw/WN9D6uaE=
X-Gm-Gg: AR+sD13abOqUG9/mHbYNMme3y+g3jWFc3KhyrCpNz12Bhn5owBOAEUGLBoE6sbIGZl/
	C/AAvDFCJ/UAmT4QvMv2kSrdFK8PuaUVMvtITxPXrVB2O7KmLljeFVHSpb2evg2+wJW0U5Y2TX1
	nUrWkE9DSh1JKo8Oc/BuPy9Mi556S0hOzWGwVvYm7lgA2wyyHcOvrfbV7vgxnpBCghBG9+zXtBn
	F5FfdjTkwiE5ZAoyxCcfoStmjJw5ElzMmr4waLUnWBX7cGmitNALbJ5XpUe1XXd2RGaClJfF4Kx
	HpHV9QeMblbbyGzj14L3f4JO3NZ8XygP7Zx1Hfme02qIoOoUpZZ6mXmTgJ4UOCD/Kt8Q4k2XAov
	NdrDkUgl/AccsJxc87ulZWMKIpnkmBLa/xJWfvMMTt3eMGoSeJFKflfOJK+AjLfWNhGJ3RBtWy3
	7/wmcS/Leo/HL8pkrNedHzsKj0QtG7+nyEIkq+y+8E1E0Z2VjH/AqE32XdAT02S5q92M/fkQF9w
	A==
X-Received: by 2002:a05:6a00:847:b0:84f:a82e:d32f with SMTP id d2e1a72fcca58-851b8744335mr7423155b3a.3.1787038333483;
        Tue, 18 Aug 2026 00:32:13 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fc1740sm1193362b3a.49.2026.08.18.00.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:32:13 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: hca@linux.ibm.com
Cc: gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH v2] s390: raw3270: Handle allocation failures
Date: Tue, 18 Aug 2026 14:32:05 +0700
Message-ID: <20260818073205.1669781-1-triet.hoang.dev@gmail.com>
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
Changes in v2:
- Destroy the console device on allocation failure.
- Do not free rp after raw3270_setup_device() success.
---
 drivers/s390/char/raw3270.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index aa9c4d81225c..ff397396b440 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -814,10 +814,23 @@ struct raw3270 __init *raw3270_setup_console(void)
 		return ERR_CAST(cdev);
 
 	rp = kzalloc_obj(*rp, GFP_KERNEL | GFP_DMA);
+	if (!rp) {
+		ccw_device_destroy_console(cdev);
+		return ERR_PTR(-ENOMEM);
+	}
 	ascebc = kzalloc(256, GFP_KERNEL);
+	if (!ascebc) {
+		ccw_device_destroy_console(cdev);
+		kfree(rp);
+		return ERR_PTR(-ENOMEM);
+	}
 	rc = raw3270_setup_device(cdev, rp, ascebc);
-	if (rc)
+	if (rc) {
+		ccw_device_destroy_console(cdev);
+		kfree(rp->ascebc);
+		kfree(rp);
 		return ERR_PTR(rc);
+	}
 	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
 
 	rc = ccw_device_enable_console(cdev);
-- 
2.53.0


Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4C2EE295
	for <linux-s390@vger.kernel.org>; Wed, 16 Jul 2025 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703938; cv=none; b=tOId3aaLi524PrdJMXcit9k1NvbMPToEPMMw1hikqyoOrnv9MSxHt/zvwDw37OAYrFRmUDZkqDV9z8A7x/ot0q1JywFSOygIFG0ZEWbVxU3D7cPbEk+KQ9QtaYcgsxRid/ikIvMN/15OjNTv+7ntI0xpWc5yPdbc+ihi2s0MZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703938; c=relaxed/simple;
	bh=6BbQ3JN8tkPu4H1UDgBRGfOofWpezL//959SPvzCPrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zlgl9yvypfttT+rUGxGFVuI5WwCWf30poXNMPiQYGF0r7md5mgFXIXqBeL/+tr8KHDAahLJjlU7f1f6aQGfJA+vSdWpfljpJ7vx8E1YbtUGkoNdf7Og2zlAbOWMyE5FBUgwlwy2rHjzEBrN2SUr6a2VmQCn+FYHzgqTm3xXmAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGq1Y9gQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGq1Y9gQ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4f64cdc2dso44935f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 16 Jul 2025 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752703934; x=1753308734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MV9JJ+jwpBErPBkuNfiEQ4mvMEWB/brJTpppbmas6tE=;
        b=gGq1Y9gQiPXn/FmiovJOMlVhmPi24qC641abFhoAmy/cbcK/y7znhoin40EXsRyHh0
         t6GfSbjv6/lTv3eAynTs1dAHspRL7JT4soQ7+vWQevyUG+oKF1ZHk1lJIAJvtCY9cSRy
         Ou5ZwJ/aiKW7QF2YVSdYlYinPZLPvH44xsCtA/kcS7/LepGw88LNe50jD5aggcd5pmJd
         bqedecAflOXnaAcI/HvILWgRKTky6ZCRWxEB2+FrMGBPo4YFnnRy2a8vX/peSldiuJwf
         sbZlewrTWnZNxxA4n0dar9qiHL8Q1+EKCX23STruV0tcGkIbB6Qrm6I54S7S74uvLIwI
         OtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703934; x=1753308734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MV9JJ+jwpBErPBkuNfiEQ4mvMEWB/brJTpppbmas6tE=;
        b=SbaE8ZgECwvGSRXbO5XV0asn0aX3wlHhu6D2IcLqCp9D2fw/0HLz64by1x4y1OI7x2
         E5QDPllk/M1l0b3QO7q3EDCNTF4cBldgYaQZc1YfkmFPRK0o/juChmzgYEgi+GErJ2We
         QXVR9BsOt6tXrCofZUlr5nCnEsJh6YQ6u6sLSjiXga1rFnUzwUjj4xpfmlKRFArH5kZ7
         6yizxJGU9L419qr5zpXUJOY+Ha6n+nNzUN5d1TnUjfrCi99V8r2LB2c/g8dBrSR+zrGy
         lYMSL5Pas7zDCrgq2iqcUGaIOBehhlXYkUnhrU63el3r1I+SRiddqbwYrFZF6KQDxxaC
         pTYg==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZwZXDDi+dvkOgowasjHV5twQdUetTW8zvksjbyhMIte9ZdqGj//++TqJVx62wW/79qtVs5hQb5KD@vger.kernel.org
X-Gm-Message-State: AOJu0YyeE9QqkyDdOlkE16oPiJHeYLP1r7Il/GHzjLtzdtStldgVRMgu
	Qf5/hzpoGPmudbt0Eoa+TTWMJ8wcmOR8fbvAsAbBGmFkfi6bLafIpUQ=
X-Gm-Gg: ASbGncv9u/LmZib04WT/W6hE5LtgmEOLhFYkCfuqzMknPTbuAKZf2ti+izKDItIT3QF
	HoGtTFTcKeL/X7+J6+/3696MjOrtyAg2tqJhmVqwfN7Uzs6fqjSalPITTLlL8YrPtvX6JZoTy/A
	oq7n1hEMBxPTrceZ1SC3qHwmrSrLlePGapkvzNQMFnnsp5n1z9eMDMTb0Od0uZiTDzOBGhqxcdP
	N82Dt1LTIro5uUTSXHdfXT+1QGsO27dQFz1S2SDE+DwDxFzVhb407xciPksDw/BZUniKvWeON/u
	yPtfDpolqaDcvkTsiTh5BlL0XwXduKGXEzD4phfL8j4pWm49uRdjUwMjnpkX84jIhi3WUaE5Hok
	/diFQYJItG/vaYs9hHBUi4Ux8Lfs8GgZmOXtmtG5wpfnVzuwk3i959qptZRAb8cX+MQ==
X-Google-Smtp-Source: AGHT+IHT/y2X7VZLJG0aOTd7F7Lm3MTvzdGjN07/gZK6mY+b0ugElWkhO5/yBySwP7PeM7XXLT+lYg==
X-Received: by 2002:a05:600c:548b:b0:456:23d4:4ef9 with SMTP id 5b1f17b1804b1-4562e0462d4mr19664965e9.3.1752703934056;
        Wed, 16 Jul 2025 15:12:14 -0700 (PDT)
Received: from localhost (179.red-80-39-133.dynamicip.rima-tde.net. [80.39.133.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e25e75sm18842595f8f.87.2025.07.16.15.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 15:12:13 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Nigel Hislop <hislop_nigel@emc.com>,
	Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Christophe Varoqui <christophe.varoqui@opensvc.com>,
	S390-ML <linux-s390@vger.kernel.org>,
	DM-DEVEL-ML <dm-devel@lists.linux.dev>
Subject: [PATCH] multipath-tools: add a comment about DASD arrays vendors
Date: Thu, 17 Jul 2025 00:12:11 +0200
Message-ID: <20250716221212.83597-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

vendorid for DASD devices is always identified as "IBM",
but EMC or HITACHI/HPE arrays are also supported.

Cc: Stefan Haberland <sth@linux.ibm.com>
Cc: Nigel Hislop <hislop_nigel@emc.com>
Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
Cc: S390-ML <linux-s390@vger.kernel.org>
Cc: DM-DEVEL-ML <dm-devel@lists.linux.dev> 
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
 libmultipath/discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libmultipath/discovery.c b/libmultipath/discovery.c
index c4bc6df6..a2fe28eb 100644
--- a/libmultipath/discovery.c
+++ b/libmultipath/discovery.c
@@ -1669,6 +1669,7 @@ ccw_sysfs_pathinfo (struct path *pp, const struct vector_s *hwtable)
 	if (!parent)
 		return PATHINFO_FAILED;
 
+	// Identified as IBM, but EMC or HITACHI/HPE arrays are also supported
 	sprintf(pp->vendor_id, "IBM");
 
 	condlog(3, "%s: vendor = %s", pp->dev, pp->vendor_id);
-- 
2.50.1


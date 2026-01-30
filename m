Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C32E6CA0
	for <linux-s390@vger.kernel.org>; Fri, 30 Jan 2026 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806106; cv=none; b=HoFMqEtMbEX4n8C+/wPA43FWcFIqT9JtXVMI6WTjIkTW/kH13oG3jE+X83LrcWSroa3lPV2adgwlDkwPHWILQN24VkhPesYU/dgtnA+s1pCD5bS2Bu6M2ukzHYmgFyjVTo8JRuFODq21ktaAwllZ5oLayxsS13u22HezhfeQku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806106; c=relaxed/simple;
	bh=WcTJzlSzYQ3GdQ4ZKrgKXfine1j1UbideT72PsQJz7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubAbNIOVCiFIW81EFSB4urW+0np3OqTcxl1pH5Qs3V6wYrMSJxBqZyDcwHKaW2yr/7iplAi3Hkn37Eh4TPJp1N7uHtLnVdIWWfATdRA2kHucLk/Qcj2a377vHvElHUSpzypaEZY7Jbtny+6y5oc9aw6uuAIH0BTP3cm+jVIHl1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxKbmbFb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxKbmbFb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee0291921so23434105e9.3
        for <linux-s390@vger.kernel.org>; Fri, 30 Jan 2026 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769806103; x=1770410903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyJyqKV6sfd+4rm1C0f1aBd4NEfWaqE99sc9YOO/X6o=;
        b=JxKbmbFbcnEPYltNFT+3kpskrhkR37I42Nem/xhMqrj9fcMPKmjAtUGewtlRd06Ov3
         UFRxklA6iVhnHZ3bPmsHs4w+U8Ct1aOXLclZwe/xKk3w64JEcNxi7uHnGihQt802LJAQ
         4AAswBSeXVjbQFGbp19pntzR+0oiJ48inkYfWb+qi2eY4G6Fly1mHVloMn5XIbYnbEo7
         SEFFLj0b8jgp2tgcj98Gij7vHpQCUPyY4QOFyOkr97p7hFhppxdG4KvhPlcH7nBv4SBG
         MKqTQ6dDr6wc3AA+J+T6FxGrXzWf8+1+ss65e+9YDb6qAdypHGS4E0mYqKCeoBNwpCyE
         kVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806103; x=1770410903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyJyqKV6sfd+4rm1C0f1aBd4NEfWaqE99sc9YOO/X6o=;
        b=riuKw5q0ra+4OYRDyIL9zB6ygdGQ+L7g1mxJ1n5hXRQeolqHjydUoL/yo8AOeIb2yf
         9ygDGYnTccUNCOELMa4+1wWvHj13CO5OstxSGoX7jMw2ERTR4C6MtFG7l5AEpGyyHHJ2
         I4Q07lhQiibcOJmTLgmdy62swKSC6qydaLlVCy3aOyB3OBwCKYgx09+DVg9eZcsZXeVB
         xejK+wivRnf5obX4tAil2KFYRdYaVr3+r9BAZJPOsIp9SpKhUZWer0/JaCIBpRWz4U84
         8rDdoDxgTSd+ntEytlK+e3SDig8pBTyptHkS+C/gJQwq6cczNvDk6ZaLs1mHFea7/zRE
         tESw==
X-Gm-Message-State: AOJu0YypBnLhwQA/3nwdMNCLo80N2YMKFhEDo1YmctIAXaFct0aQl9Hr
	OrzdKfbIw9UkPs0EovYGHD2DezqO7NLA1ob3vAk/vAvtQTCOXYke+hfR
X-Gm-Gg: AZuq6aI8RHtObN9ziN0WCTmaegZCpZlTFmeh28yntn+KhMsK8HV4rsN7LB7oEwXzXD/
	tlzCtBfYv1DeG8ohcv/AXP76VUdLp3C3gcIA13FmpSG3Cjv5pTzgdcZeABANsQf1FfMTBXyYSIP
	v5AV7bqtX6P0BBXMFlHawjMjafcoCAdwusoQXLSMoWwrg/YnFqXYSA0apRkCJGOGvXiSOXinc7e
	0WrWofOTG2U6pluEBNC6jGThiJOzkStm8IAwAg1PmKJaopRZiASvO+sx1J5G6qvK9rHAcPi5iTj
	s3dzx7PzqjGChWz1EHmnRx07o42aEt8T9fNckjRp94ZoDe9Qqk7bpIJ8F9JcCLlOZWJ7CAKXX1I
	ieFGLNzQ9FKqHKRdfvAOL8NfHJNmhcpVPVwMMOBrCHXJ1pTIFAI9J1iXevltMW54W4ph09E/94B
	I7OQt1pAD2F9C50NNe5Sj8Gq6QZWLaRl1QdfEp
X-Received: by 2002:a05:600c:3ba0:b0:47e:e71a:e13a with SMTP id 5b1f17b1804b1-482db4ee2camr47791655e9.32.1769806103186;
        Fri, 30 Jan 2026 12:48:23 -0800 (PST)
Received: from localhost.localdomain ([196.235.250.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cd8fadfsm221557985e9.0.2026.01.30.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 12:48:22 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] s390/cio: fix device lifecycle handling in css_alloc_subchannel()
Date: Fri, 30 Jan 2026 21:47:59 +0100
Message-ID: <20260130204800.217395-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`css_alloc_subchannel()` calls `device_initialize()` before setting up
the DMA masks. If `dma_set_coherent_mask()` or `dma_set_mask()` fails,
the error path frees the subchannel structure directly, bypassing
the device model reference counting.

Once `device_initialize()` has been called, the embedded struct device
must be released via `put_device()`, allowing the release callback to
free the container structure.

Fix the error path by dropping the initial device reference with
`put_device()` instead of calling `kfree()` directly.

This ensures correct device lifetime handling and avoids potential
use-after-free or double-free issues.

Fixes: e5dcf0025d7af ("s390/css: move subchannel lock allocation")

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/s390/cio/css.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 4c85df7a548e..ac24e019020e 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -235,7 +235,7 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
 	return sch;
 
 err:
-	kfree(sch);
+	put_device(&sch->dev);
 	return ERR_PTR(ret);
 }
 
-- 
2.43.0


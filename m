Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1D13C3C0;
	Sun, 23 Jun 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719148379; cv=none; b=oTHoWd6RRcEjd5RtC2O7owYm4upUkrOCO7D2gx0peYshZHNQIfOlCN9oeAk+44VVQQS7oJO253cfzg3nzqlklkFg7B8IvBBCllsCagCFbWqYW+Y6y/Hv7xOGULdI5WBmUSS1C00FwJvIY5ycPJkEA+H+txNJy5bJ99KAzNA7NnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719148379; c=relaxed/simple;
	bh=Y8cgz0iN6TvpHLfS6UmqF3SdYCcIUBZR7OpNtRcoF9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJjNSZ5O43S5/Z9ooBAtrpXFrqWPAWgk/T/riI+/gG9y/IMN6P17hyy+G2QJcHJwLu4QA+NHklCdKtfah+Ot0iT8oMdqUIPmELGwWdl+AsXjUpJCR4R/A6nF69nvVb2zLkavr8K8cVnqZHD+MJYzTYJB70mT6D7lZaHLbKpRzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8IjD30I; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8IjD30I"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7066c799382so877866b3a.3;
        Sun, 23 Jun 2024 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719148377; x=1719753177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0eMRMkArlJlGkTZQ9yNJafa6QgbQK/SySA6cQAcMaZQ=;
        b=E8IjD30IR2oVavooJapy3TLfAtIHA6gCZGffK7YNOqSm0B+PZl2/ZVn35uecUcMvQM
         vpoXhyTvB8cCXX4T0uhnT7tDJKeKMeZMp4X6IM7KDMqyY7aB+cTUZjT921btZTahJmJu
         IhqLdqBUuuIxhKsFq0jjCdn9W7viC5yYwzrlydYUslv87wlkq11aNyKelwGKQIRUYM3S
         VK8iwDSdl5qMgSJmzc7CPjknX2B40wNT+WFo4ifTrOmMVi0NdYIPoJoOb352SNSVF6Ll
         QrJw17PF7UU1CtOgqq9IlPe4O0mWx/d1eqFYgKErbGjj357Wtoj6Moo8o4z9BAv5UfZ+
         lrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719148377; x=1719753177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eMRMkArlJlGkTZQ9yNJafa6QgbQK/SySA6cQAcMaZQ=;
        b=fr+FULXHauBAaq21Q09zXIw+6uU/XhVbEa/MYj8uPUbHV2su8GOEX4V73qndDo319B
         AH4KowBCP6MQ47yAsrxAZWQq8qY0juCg7ikTVUepDiBOeC3SU5Vxsr9R+Xn1eyb/yYtZ
         Mat4v2LP4dky4R0VH0qwegOGuxA8mDPrXpnncFyMsbTbpGgJ9qU4gIeEi++zE7Py5RZm
         EuajGTp7qKQRXiLVR/8IVNW6Ba0PrIXA0hIc2ewJIzsC2AyEnMwqXrQcfzrpPQ6F+S4B
         kWX5XQh4tBdv/Up7GzCHvJpbCWGgfTb9A9kED3H8A2LAcoQtejC5d3uUG8iXNqI8RFL2
         Bsog==
X-Forwarded-Encrypted: i=1; AJvYcCU3KgY5M9uBC5ZtgspOX0aEC7jucUVQ35B2zh6HSSUP7CIA3xSkxUP2MkxSA6TBwuYu3twZfAocVzGXnA5TSkuTdgTy1zyn8boPPYhWGPF0+8TJIKwuLwokjqeKTyS+4UJqXX5Nu9J74fZ6ao0aWZ8hbjlgwB0+U2ZZJMf0eM6PEA==
X-Gm-Message-State: AOJu0YxkgWQyt/6Uw4HEfc2GWiQjM1LHNVacKn3Rkldjd3UN31rXVkPd
	NmFoKhHMqy8g2olajaj3j9iTHInT6Y2YH+5jyoMU3NVU0TXNhsRe
X-Google-Smtp-Source: AGHT+IHSMmq1tzJUepHXAuc62rJMWeMz54VK9TgPudVnnGsJXIylFYvN49avX8NpfQIDyz3pMCV1SQ==
X-Received: by 2002:a05:6a20:92a2:b0:1af:96e8:7b9c with SMTP id adf61e73a8af0-1bcf7fd11famr1955172637.47.1719148377216;
        Sun, 23 Jun 2024 06:12:57 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066ac98fc9sm2408207b3a.193.2024.06.23.06.12.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Jun 2024 06:12:56 -0700 (PDT)
From: yskelg@gmail.com
To: Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: shjy180909@gmail.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] s390/netiucv: handle memory allocation failure in conn_action_start()
Date: Sun, 23 Jun 2024 22:11:55 +0900
Message-ID: <20240623131154.36458-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

This patch handle potential null pointer dereference in
iucv_path_connect(), When iucv_path_alloc() fails to allocate memory
for 'rc'.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 drivers/s390/net/netiucv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index 039e18d46f76..c2df0c312d81 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -855,6 +855,10 @@ static void conn_action_start(fsm_instance *fi, int event, void *arg)
 
 	fsm_newstate(fi, CONN_STATE_SETUPWAIT);
 	conn->path = iucv_path_alloc(NETIUCV_QUEUELEN_DEFAULT, 0, GFP_KERNEL);
+	if (!conn->path) {
+		IUCV_DBF_TEXT_(setup, 2, "iucv_path_alloc: memory allocation failed.\n");
+		return;
+	}
 	IUCV_DBF_TEXT_(setup, 2, "%s: connecting to %s ...\n",
 		netdev->name, netiucv_printuser(conn));
 
-- 
2.45.2


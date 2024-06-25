Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83ED45023;
	Tue, 25 Jun 2024 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719283765; cv=none; b=hE4TVGt8A7GFTeCXnly+tUG34YZUBwFzUyjTAOhzAUeNjALOQyNRNlgHgQUhjSkse0WN4PNgS482+AmVMMwbDeqIGSqwMuBvVjvsqST4pONoOd1S2I1dmN5RSMrmSRQt7TEvd05ZUs9OrACSX+8363VQdCCDuwWLSjDVoewHoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719283765; c=relaxed/simple;
	bh=509+GNhEQ8YYX6xv0bIGyfDHnSczn/7YDklov7MbtAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMUu41mKjIEuo4kPLuV3LoXIhEcXI4A2qG5A0WZ7lUQmKhdX8TjHFoHdn2XMHPetB4A6zPnoVlTgDADwk6NvL7/OQ8xrajz10hPKw/hBhCa+zgGHhpR3T5h485zi1ZHGtI9MRDDu2NhWRLHhwWSLX5q+FyBfKW8wHMv2XkLAT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqSJJ+1J; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqSJJ+1J"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9b364faddso40753705ad.3;
        Mon, 24 Jun 2024 19:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719283763; x=1719888563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BAD7ABuZm4GDesGzFzNGFjb/h37/nr5QSGkLHEsIEPM=;
        b=kqSJJ+1J87zG64WxmzcTdE+x29CREDbCeqyr8MU++D15XDwiiRvpuJxpNzQQPgLrcL
         YAuidpje8lxRNvkJ4H38Prn1BJn/FZfe53425ZIOB1i10eobEdnZfHwO/3G0Jwb3o6en
         w/k7Yx7/8N83NmuqVLhE2nvXOrfv/FbpHWHl9bkHtbrXWgZMXTtOVYYPMhH62HFX9wOq
         wg2ztEbuXF3DmJZZQmg9WYw+FJpuiNbBtvIecCH2b2ojDxomgYdcYs5IkFMO5h9mOJJv
         4WN4v5g0IKuKwWaGxN01+bkovraWGE3sBArEUjKnb/vdj20dzhpy1b3JmlHh+XdADXcF
         WqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719283763; x=1719888563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAD7ABuZm4GDesGzFzNGFjb/h37/nr5QSGkLHEsIEPM=;
        b=lPFYp3fPdFXEb9Rj5AMGy4XG2eOASZmI+Rg7sDyt1UJoN+E55fwwNkGibfrbYjt9eM
         YV5nipQ6olgsT98v0+XFMte5l2IJ8sY8ZbkL8Tjexp95dHGKT+yI5nE54ORKay2LfHnI
         4mIs5yBGN8bJANGgbKSO1b2jIg8QtRdzeqc4Neund50j83lkIPBIBiSIJU0B1ckNWBoe
         eL6TYsWvv0ki9Q/U5SpltIE1K+BlqQvhgkLTUrYYMxz11OdJqJTY/8+8rMOk7F/wppI1
         3zrDHaKKQqQVFiIOkAYqk6gfEst1QIPFLrZhxGRj8d5IkcZeIXHdz0Ym2gcSIfSO741q
         ykDg==
X-Forwarded-Encrypted: i=1; AJvYcCU/2AeiHju7ZIp+AOJc6NzySXZKrGsXT7/yWfVsBLMWjlf4cFmPsnMuSZXcc8hYx3ke2E3x5XzMUzapUUAaW3ianNQjB9boa6p17Ru/ItHBCCB7D1IgurbWBlgLjOhsyEkLTHH9xoCoYXSSoOANySELjaTBWWNY9RsbTLQ7dBy26w==
X-Gm-Message-State: AOJu0YzrglC7BSJauvl0cZvim8RcKuJLQZM/SeRgV353FDqwDtJaYjGU
	ialEB+rRlO2FmWrnF6QJYTkmMUh8w0eAdaAb/U7+qydFuNnvoKYOKiNpRA==
X-Google-Smtp-Source: AGHT+IGyuUUN36z2RVQBhdHFHsXdwrm9JSIjRNl3p9e5eVYYZ0rAGd/YA/uXkn7bzLsHnfLPF9hanw==
X-Received: by 2002:a17:902:e5c1:b0:1f9:df83:8ab2 with SMTP id d9443c01a7336-1fa240c518bmr80858935ad.58.1719283763029;
        Mon, 24 Jun 2024 19:49:23 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9f1c27db0sm67393615ad.100.2024.06.24.19.49.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jun 2024 19:49:22 -0700 (PDT)
From: yskelg@gmail.com
To: Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Markus Elfring <Markus.Elfring@web.de>
Cc: MichelleJin <shjy180909@gmail.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH v2] s390/netiucv: handle memory allocation failure in conn_action_start()
Date: Tue, 25 Jun 2024 11:48:20 +0900
Message-ID: <20240625024819.26299-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

A null pointer is stored in the data structure member "path" after a call
of the function "iucv_path_alloc" failed. This pointer was passed to
a subsequent call of the function "iucv_path_connect" where an undesirable
dereference will be performed then. Thus add a corresponding return value
check. This prevent null pointer dereferenced kernel panic when memory
exhausted situation with the netiucv driver operating as an FSM state
in "conn_action_start".

Fixes: eebce3856737 ("[S390]: Adapt netiucv driver to new IUCV API")
Cc: linux-s390@vger.kernel.org
Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 drivers/s390/net/netiucv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index 039e18d46f76..d3ae78c0240f 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -855,6 +855,9 @@ static void conn_action_start(fsm_instance *fi, int event, void *arg)
 
 	fsm_newstate(fi, CONN_STATE_SETUPWAIT);
 	conn->path = iucv_path_alloc(NETIUCV_QUEUELEN_DEFAULT, 0, GFP_KERNEL);
+	if (!conn->path)
+		return;
+
 	IUCV_DBF_TEXT_(setup, 2, "%s: connecting to %s ...\n",
 		netdev->name, netiucv_printuser(conn));
 
-- 
2.45.2


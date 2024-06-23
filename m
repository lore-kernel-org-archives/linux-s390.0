Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072612E1CA;
	Sun, 23 Jun 2024 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719145546; cv=none; b=oGrZtYWMpKDhpXJR5OrTSpuH4W1QXnMWOrQqnOKQiHGd6S3VdcqgjyYJbFzZFnBTJYlLCoDZr2l4WA2E0aDGw0z7k/4ZTsiSiS82Oxq4+nau2P+8jDx/kdr9dEqcNh405GqFHv70LLvveoOairnjM0ksEVKb3zV+8DsaNfMmBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719145546; c=relaxed/simple;
	bh=6SWsetOiitGrbfge/pUBVlgh7ezPRdo0jeJuVPOlqFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SUqSdq83+aPefg8xK293cNC648Qr4s4G7blBEqEFlVlv33gVqU/2QNylNQN3aiXftj2uGilBZu/v66Lou3v/VhqthqWf5rWarsU1sCsT5D4FOhlRs90ASKYcpK5yrZ7WBrV9S4ONe6VpOyFgwjRQqLwLAMAPTcceaI3MMZErgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcP5yXuR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcP5yXuR"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70656b43fd4so1436249b3a.0;
        Sun, 23 Jun 2024 05:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719145544; x=1719750344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+GctSM144YZO1XxdYkn83b1ZZ0Ac+eYihI2mIQW6N8=;
        b=mcP5yXuR2QZney5q55alsbsPu3Yk8LMH1usksc3mnDWNpOtwLN/1uNkhgsd63PrC8j
         MVk+Z0sEIZlxIMRjwje0JSWfQLXE5ZetKr49hRPgstz7dG1UYIpOpw8+p4M0qGulWT4H
         GG5OKSklzBs4jLgyKMQeXL+XktctClwxqO5mqTSc0sEICGSxN9DxK+V2lRRPnwNuTRkK
         tpQQb+e8tRHaQaX2wWXJBsNj7YYhFq+/YGmD5REZLijaQSHPPUUqQy83tYVrpMD8cXj2
         n4cVSGvJ3QqHV2Eg6FUDhK1Fva3If4aANu8As9YlHakeJ28bTy7r78EQfIuGAfQapZpR
         qCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719145544; x=1719750344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+GctSM144YZO1XxdYkn83b1ZZ0Ac+eYihI2mIQW6N8=;
        b=G7wlCP52TUh23t+OqoFtJjPXOTYA0FTUseX8eWSFizthVzvTd1PdRVvVJ577YUCyCp
         i9UCGHpQyP5tkNPJwDKqLb7Q07qQ4FWpKQ5pU6t3t1Af96DPz+v2L9AEsfrjquwILlgX
         yYDhRXAhHruBic/TVU1u2f7kMXAUa/B/3xHRvLQLK5kOrRqp+6vJqpLL3jYAmPp4F3/l
         yf9hye7WV42PwP8TZOUogDIWZix+2DJVCy/IGi/Ny42EeXMeeIFaZ+8NX4725Ezca92U
         U/ry+eI3x5JQ/8TI05ZDlQAGE7YC6RUeuUsw3EBh8UubOvV9r9T6ccEYjTOuvO/WkS54
         4t5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbbhnN3yKV12VPkI+o8vB/I9bMdnGgr/FiW1niXD+WJD51i/97vC9VtOI8CEM8LWgF2eR7mqueT+P3gi2E+JNhchCb/IFNp5f+gXteLl1dABwG6Hmmj304epfs92SKks2m7G0+d1ALhQ==
X-Gm-Message-State: AOJu0YwEeSw3kaAJY00jhJMoNPne4Iq5VBNG+YdXlfmmCR+fRFqJkyPJ
	XwUY96WtCKnZkhi18VH0yHdwBlIL+CSVlLQ/dPSWDi5g/Swozz9pqaUdVg==
X-Google-Smtp-Source: AGHT+IHtvRq3e8bRIIlMnrQsbWA+be3/o6kjcW/zmZ6gv1I3/0MLPIac3YniKUjHOaBqaGQanbG/KA==
X-Received: by 2002:a05:6a20:f395:b0:1bc:ecc8:ca5d with SMTP id adf61e73a8af0-1bcf7e7861fmr1350756637.24.1719145544325;
        Sun, 23 Jun 2024 05:25:44 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7193f4a110csm2358296a12.20.2024.06.23.05.25.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Jun 2024 05:25:43 -0700 (PDT)
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
Subject: [PATCH] s390/raw3270: handle memory allocation failure in 'raw3270_setup_console()'
Date: Sun, 23 Jun 2024 21:24:49 +0900
Message-ID: <20240623122447.35847-3-yskelg@gmail.com>
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
'raw3270_setup_device()', When 'raw3270_setup_console()' fails to
allocate memory for 'rp' or 'ascebc'.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 drivers/s390/char/raw3270.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index c57694be9bd3..4e81040eea81 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -812,7 +812,13 @@ struct raw3270 __init *raw3270_setup_console(void)
 		return ERR_CAST(cdev);
 
 	rp = kzalloc(sizeof(*rp), GFP_KERNEL | GFP_DMA);
+	if (!rp)
+		return ERR_PTR(-ENOMEM);
 	ascebc = kzalloc(256, GFP_KERNEL);
+	if (!ascebc) {
+		kfree(rp);
+		return ERR_PTR(-ENOMEM);
+	}
 	rc = raw3270_setup_device(cdev, rp, ascebc);
 	if (rc)
 		return ERR_PTR(rc);
-- 
2.45.2


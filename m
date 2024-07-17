Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1111187868;
	Wed, 17 Jul 2024 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251576; cv=none; b=PCabPWFn6YG0XuYOC+KOFR71skpf2kpuutrk7puqPFvx88D345uY/qLCmgTqsQgA0iwGC8iJ9C7S4QjLe/D6tAX3DwkM5zHwHWi4u27AUHuwJKN2MBbDk+HjQLqJYy6naSPAV6hHBZXP03ztviwZdrF2Y/8ET+IUX+IjRjKYrMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251576; c=relaxed/simple;
	bh=3wxaWTKVliSXE8imUAoRvdQqAtXh5NgmHDAI61GGMnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nI0Mvq5Ce4GUqUlmMNybD2OlpghgONQJQChFCByUhumH41cg5oaMQAIIKxcEC5QfVXnLc3JIXT3JhFgXBFs8LDfyWbIN9j1N7EEkyrE/T/YY2usIkVE8zLz+AKDqwpIC0u1AOuDtpFyN/6xaPNvLMsuMJHxVyVT3KL3BPDhaizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYg4XSAw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYg4XSAw"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b703eda27so62677b3a.3;
        Wed, 17 Jul 2024 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721251574; x=1721856374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHDdazCxqygEylnbc0is8b457A5vOnmJDWNO0vFogxo=;
        b=eYg4XSAwvnQq0vXyIHp6ZwzLXnFhdvjZ9NyksimFH/kfidkmq/sug6PoyWWas4l81g
         4xH+RAbonbJSVgZOmxuAXAdTB6W9aRyqR+nZ0e8r1ivOPkiZnvVSFeQHLSljaFbb5Co3
         dqGuO0JbhxvLYJeDwiOl3ud8EICt57R2I8EgY9rsgHVfN3NBQTs/WgiLgbUuglssi1Ef
         1gQmMHChicE5oLSS710g+kN2Ui1zTh2tpU+Law1MrpZ3xGi7l2NxukeIxtdXenq67NiO
         VAE3lulg28xCvC2cwsfYBfVLhq6+OVWcULbkEPfIC2FaAvj8bnlOOKX7N9DEIFvbnnxn
         WktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251574; x=1721856374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHDdazCxqygEylnbc0is8b457A5vOnmJDWNO0vFogxo=;
        b=QtHqjDXQZsg8zr57rekXg8ODUHFcR//seXoWLp1D/1kg7RSNPFdniHaEo8pxp34DYv
         qSdDt6lXOUsjL5AJcmtm0ijFR/mNHsUdiOZAIINdlFg5JKWSTIgRsy4QO6u7Kox6gIDV
         XXqyBk/OAswXzIYaaAWTPem87jq3DlwT7rz7cd7bg8X5G5/cAX2mAswVIw4P4FCX4Uka
         PXwMQptwXTqi4RhzHBtVW7Y2Nd9uh0QfzYBrXwL3gyR+pSi8qKZDiWaTFCWvc+tb1WIN
         cxMUCjBm9ZEFVdKPSILlQ5pJP3NoLA59+HaDZdwAtC2YLLsnElwbkawXT3enVTY0Oqq5
         RDgw==
X-Forwarded-Encrypted: i=1; AJvYcCV4OfAc86rP5eRaJbYKJyybd/KPmmYtlDAazIwh5Xx4LNfReWdRt1Jlf8YfGcnWUF+03LUPDBgT22ORMoUHyM1MZmPtbGzyO6YzuiZFaVlmWok8KoDZ+CND7NGAjnZMKVEnWwWLW0+z1w==
X-Gm-Message-State: AOJu0Yw9zMAiTJwre/5+Jo9UvmlGV19NAOp/74h+u2GZkKt/8m3ZqSJ7
	OgpodpatXpyzMr5MOSoF0hvqOjGif1B3xo/AzE0E64sC0uh8//Hp
X-Google-Smtp-Source: AGHT+IEBMNM1ghhaGLxVIu1EPgIpeLiMZNJmswGCmSESDeC0a1peELIGUYh/sQzwFA8uAkkTpdyMjA==
X-Received: by 2002:a05:6a21:70cb:b0:1c3:ea28:3c01 with SMTP id adf61e73a8af0-1c3fdd5b00cmr3550236637.49.1721251574171;
        Wed, 17 Jul 2024 14:26:14 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb60117e61sm424911a91.33.2024.07.17.14.26.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jul 2024 14:26:13 -0700 (PDT)
From: Yunseong Kim <yskelg@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	MichelleJin <shjy180909@gmail.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/debug: optimize acquiring spinlock on failure in debug_info_copy()
Date: Thu, 18 Jul 2024 06:18:57 +0900
Message-ID: <20240717211857.4510-3-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize acquiring the spinlock once more and then exiting without any
additional actions, when handling of debug_info_alloc() failed.

Fixes: 942eaabd5d77 ("[PATCH] s390: debug feature changes")
Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 arch/s390/kernel/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 85328a0ef3b6..c64f17cc1ebe 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -333,9 +333,9 @@ static debug_info_t *debug_info_copy(debug_info_t *in, int mode)
 	do {
 		rc = debug_info_alloc(in->name, in->pages_per_area,
 			in->nr_areas, in->buf_size, in->level, mode);
-		spin_lock_irqsave(&in->lock, flags);
 		if (!rc)
-			goto out;
+			return rc;
+		spin_lock_irqsave(&in->lock, flags);
 		/* has something changed in the meantime ? */
 		if ((rc->pages_per_area == in->pages_per_area) &&
 		    (rc->nr_areas == in->nr_areas)) {
-- 
2.45.2


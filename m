Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FC21D3FD
	for <linux-s390@vger.kernel.org>; Wed,  9 Jul 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079123; cv=none; b=Jj3ZWhxMv9HyyFHy6DVNGmLdb3zz+hcbDPDgmVt920nOrbyDwy6/EsAkSCiYeTbwnkIpl88VQHyMRAH9RJda1EelPxC7eubP80L6cwtJ+iKrCll+nUYdlZACWSJOPal69L2g67H3J93J9KikxZ2lRbKZcM5EzSUWG7eP8lNv4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079123; c=relaxed/simple;
	bh=K3mGEVB9OXXy53IUpoSEGCGrzW+DpgCjD5x0ANJoyMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+IadDBjYGHvtqrgGBRyF9tdzA4iQGspuSERcXjN8oVnz6k5hdB3/BQ5M7G0cqzaEqMHpk4Mg/PEOR+o1q5yhn6TdUc8Hzx9uNhhwo4h+9lYaGUqQuVOu+dK6brtMmx8W5uon2PDvaOJtVumV2snrvY6FHnfd3va6KcpfpTCB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXbf1+KX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXbf1+KX"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4eed70f24so17146f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 09 Jul 2025 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752079120; x=1752683920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yKNxbdlhpE49Kl8ILq3eDcvgjYm6Tevsb2iR/FTQCb4=;
        b=VXbf1+KXFJLRxUXAx8E6tVVA9y+3pf/kLKr1MNynabQnnwiRz0raJveKqYhkg7TFOY
         vCu/q71me0Ki9ThnLJ94B3ZqraLHxKjLgll8zimns8D9wby0PB1rFJeW5cHH99bHNwQy
         DBaSVQu0B2i1WOLM/ffCdVtnme0e6loYPEXYjZgSpI3ROrJgj4QNhioWNrcX43cKUZel
         j5Vk7/zCHE8cLNiB4kX1lKVhyV+08z7eyh/MiXpGxvrLVEwT3rE4+siKOjV/mwsDXl6n
         VEoCG0i3Rk/bI2sbh7gD3jWJRSHifKzViORleICSZugx71iDvOvD47bZGT0FLpI7xQp+
         1nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752079120; x=1752683920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKNxbdlhpE49Kl8ILq3eDcvgjYm6Tevsb2iR/FTQCb4=;
        b=Gob76q/GOFafdoWEidm9AwQ6kbG2WI5M9hxGjN7BGnNjEiDN2nZlXe0efOvs19yKgK
         v4zzDFrnu8Y39OlsljS+rhHE5Xsc5LUVV7kvqKNFAsB5hDRR1mHdhL4ZxVh+nU3vy33+
         VUaAfpEFwd7dpaBtb9tUwXX0k6dQoddffl9kZDDi54SVu/wLFkUj5eeGKie708P1jaPk
         23WGqglqz7GiZuvNJKn8ju6kXTD9NjNbCTGFxzDHodJsJLSHSOk22+oyz8rzvWfgfJOx
         jWJd57BIMhHJa6zMTMwg4WF/m0842+dvf2dMUnngq34Et9AE6lSEChsnjpOQjwsuoEbU
         68rA==
X-Forwarded-Encrypted: i=1; AJvYcCWvnsyvJ0vSO/IBdEL30r+5Cwh8iGPSEc+hGvABQnkoi5WfXVyXNwQnrzIXtbsI8zfIsDAZGr8d5S3t@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1kMEJxGw0FdJ0gLAeQU/y3PIEVLEeJ7yMKP1hI+Ansd01w7Vh
	63lLpVLi/zhnDJxLaPlKk+bpFBCLT24ULZBaAkn0sdWejqrg6aUoEMY=
X-Gm-Gg: ASbGncv1/Hz5DyXMZtz/J4r7GMKbGZQIoi+6kmz+gKx6DvXE69qhgE0x5D5+vZEeSeo
	E9rff0wv+N+7kMao8mDd4ERy8duuCNjSfAND+/EIsP2mbHw/Cb2KFf80sQd+3IEKkM0lkaLrmXi
	oxZMfO9vYUygmbXL7ZpR57TuZs4psYXcIiBehL3RStpn/qC8Vm4Qg14NVY9SYp1n+uurt/N5N3H
	rKf7ib4wRIiD2+qfcqLv0JR47YOiokhDjVep4Yl1D/oix3uF8/5rkcxSXxYS/FBD/FQraGDD0yO
	PIFBL2eydo7vP/ugP0wP5zN98Lv6p4L+twCFjiDzuvfqzBJU7haJV/M52bqO0d9AfExsmlJQRO6
	7wzK0OUI0ABoaHLb398r+3inYZQ==
X-Google-Smtp-Source: AGHT+IGZSftk1CerjZZQT5Wf9gUwjnt4q3mg+UA81pqTtzJ8PmtOyT1Wo+qV8bkgZkzGKOfrMPmboQ==
X-Received: by 2002:a05:6000:4024:b0:3a4:eeeb:7e89 with SMTP id ffacd0b85a97d-3b5e44e9162mr931179f8f.7.1752079119552;
        Wed, 09 Jul 2025 09:38:39 -0700 (PDT)
Received: from localhost (182.red-80-39-24.staticip.rima-tde.net. [80.39.24.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd42sm16201650f8f.5.2025.07.09.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:38:39 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	S390 ML <linux-s390@vger.kernel.org>
Subject: [PATCH] s390/sclp_tty: Use macros for hardcoded values
Date: Wed,  9 Jul 2025 18:38:37 +0200
Message-ID: <20250709163837.8118-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Similar as in sclp_vt220

Cc: Heiko Carstens <hca@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/2=50%)
Cc: Vasily Gorbik <gor@linux.ibm.com> (maintainer:S390 ARCHITECTURE)
Cc: Alexander Gordeev <agordeev@linux.ibm.com> (maintainer:S390 ARCHITECTURE)
Cc: Christian Borntraeger <borntraeger@linux.ibm.com> (reviewer:S390 ARCHITECTURE)
Cc: Sven Schnelle <svens@linux.ibm.com> (reviewer:S390 ARCHITECTURE,commit_signer:1/2=50%)
Cc: S390 ML <linux-s390@vger.kernel.org> (open list:S390 ARCHITECTURE)
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
Trivial, but uncompiled!!
---
 drivers/s390/char/sclp_tty.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 0a92d08830e7..4e06dc70534c 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -23,6 +23,11 @@
 #include "sclp_rw.h"
 #include "sclp_tty.h"
 
+#define SCLP_TTY_MAJOR		TTY_MAJOR
+#define SCLP_TTY_MINOR		64
+#define SCLP_TTY_DRIVER_NAME	"sclp_line"
+#define SCLP_TTY_DEVICE_NAME	"sclp_line"
+
 /*
  * size of a buffer that collects single characters coming in
  * via sclp_tty_put_char()
@@ -550,10 +555,10 @@ sclp_tty_init(void)
 
 	tty_port_init(&sclp_port);
 
-	driver->driver_name = "sclp_line";
-	driver->name = "sclp_line";
-	driver->major = TTY_MAJOR;
-	driver->minor_start = 64;
+	driver->driver_name = SCLP_TTY_DRIVER_NAME;
+	driver->name = SCLP_TTY_DEVICE_NAME;
+	driver->major = SCLP_TTY_MAJOR;
+	driver->minor_start = SCLP_TTY_MINOR;
 	driver->type = TTY_DRIVER_TYPE_SYSTEM;
 	driver->subtype = SYSTEM_TYPE_TTY;
 	driver->init_termios = tty_std_termios;
-- 
2.50.0


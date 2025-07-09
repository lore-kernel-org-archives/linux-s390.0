Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F723E34D
	for <linux-s390@vger.kernel.org>; Wed,  9 Jul 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087575; cv=none; b=pArYyONgSFoTAMkX4CHT94bpp37sPlSh1Mv5W27a+FF8kMwGKTTDmCkBGBeTDUiFchP3bzpRRNpIXN45yXUecPI97C8bWUEjdTvRLFIuiWGswnsPKhyeGqUrYXpRXzfEWCg9XZ4etrAaADp1n8iFcs+b7bjG6spoMveX3ca1HBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087575; c=relaxed/simple;
	bh=R8t3zdw3r+4WHNNRwlpVl8ar8a83TGbLqOlVKhVrRoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmswYGoXpeDenqoiOaep9C4EAzVbl/9HshR7WzxuzBaJlmU0DnnV+3BawH3RhH8Gjbo1Nj/Z+vCfDZicg91AryH8e6hfwJZC6kprHL9WOpJk4gngbTvBWyzOnd8tgt1JAVazlu0Vk/I3Io2jfe8oJsCy/+t9y0K5Q2bSZHzusGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K50mRKRn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K50mRKRn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450828af36aso189185e9.1
        for <linux-s390@vger.kernel.org>; Wed, 09 Jul 2025 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752087572; x=1752692372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNWpsrfgacajioOpVMJqDuKNhgQw10ulFLOoEuTf6Eg=;
        b=K50mRKRnI7f9aAqmWNedg7IXmZ6kHoCPsA74enPVZBfTrAbhWzYXozpT27OzxLWAy6
         WxlcR33/As93koaAf8Ta78o/+nFGvj4k982rE2J8IUWTNEG3Vhnw7a6ODgX2gOAbl4yS
         zUfe0N3YLqCsHjQqyQICUMecQuIPN/WpCZhZZs/SJqbIQp3zOp8eMlwahbcX3UjkUfoe
         MVK/EwEZ8o3I0L3j+U4AeYTocRHYLDXOmWmJYi6zj5hG0xqyJjP59nFQTs1CDVUPLNhS
         MmnMAo7ZtyyRDYA0EVWd7R9iH6JiylphKoOIKUqB2OqC8Z3dtWvreF9i1Q1J0z94QbAJ
         8OTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752087572; x=1752692372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNWpsrfgacajioOpVMJqDuKNhgQw10ulFLOoEuTf6Eg=;
        b=mtDS9r2VyXZgAgifM1vtqzSzAhMcKYG69uJhhm8esiw0vCS67cyxErrFb+Yao6RBko
         TpRMbaTeBWbsBPMFWDGbPK20sfTH0EyAyFExQIUh+5QQO3GIsLHiFjf+dPBsv9d8E/NI
         b/JBQPQcs9oGSRoalSmwRiL/UYyKRwWGDqO588AKP8MFPp7c0UXW7UM61nXUdtvcR6sl
         2/uhYE4+Mz5Op4YqxmZJb1bByNo8n3F9OoHAc8b1vr9VyaHUEi1mLfq3GjGhguN9qpVD
         6fNhXJ2+5JMqpdoEJxnpCQgJ/aVvBPWRmWnTylmtgrtRBsgfJAH0Z06PzkUPtTxU50aM
         kp8g==
X-Forwarded-Encrypted: i=1; AJvYcCVd67AD5NlEN8xEoKO/ImQ5usDJWYr9AIZezYDfNQXSx8vdpwALJHiADK08Th6wSPoAK6dGY40ceLws@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZAuTqXg4p+2FcSiO1SAK2Q1rDaoeTzM2ZO9Et72kCaYBAqch
	/mXYFWcWPMhGnHrGvxevpB8LgcSSO3ykaldZBtKUfMZ5Sx4kgSZjpgdUEFP6yUK3pA==
X-Gm-Gg: ASbGncv9bp6uBQT9YWUD7mCXHWffhY028J6BhTqb8G2o+F4e1wQD8DBcQQueT6AN5/r
	B7s/T8mi+cxtQyiGulPuUTWaOJ8Siv5kjmEKawTTkgWpAvlLqdhyZyLCwoivI5zO2D7I1/HDNlt
	sF2rN+l58VO+WAJh6qkHj7uH17rjMdY9jgGXqvnKJBrIozwsM5ygq112TVrQ3x/YLJd1XvJbqR+
	TWTTP5MDH+jlHvI+7VojfTlX0JYwzZZ/UbpTr0exhWyIoJmqJB6r8Uswlsw5dHQtFKk5tFFhhnf
	lD7QOvyDjSwEH5Wy4s4fSqJfmA97FNrG6tZ12qL0tTgU7Z+O5lqXdbckOJb6yd0kLfBY30MZf2A
	Ab2RDoAM7KdTtOLjTWKg6SAxs6w==
X-Google-Smtp-Source: AGHT+IELeVtbKDZRyhavLPMDd5rnx7JKW9L+8zYxOQB0IQ8lt+kwSW1r/GSC8b5tPkTMDjqFOvg2xw==
X-Received: by 2002:a05:600c:45c8:b0:454:aac0:ce1e with SMTP id 5b1f17b1804b1-454d539bddfmr13649665e9.4.1752087571512;
        Wed, 09 Jul 2025 11:59:31 -0700 (PDT)
Received: from localhost (182.red-80-39-24.staticip.rima-tde.net. [80.39.24.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50702bdsm37138025e9.25.2025.07.09.11.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:59:31 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	S390 ML <linux-s390@vger.kernel.org>
Subject: [PATCH] s390/sclp_con: delete unused macros and standardize the name
Date: Wed,  9 Jul 2025 20:59:29 +0200
Message-ID: <20250709185930.13659-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

- delete sclp_console_major and sclp_console_minor, unused.
- standardize macro name, from sclp_console_name to SCLP_TTY_CONSOLE_NAME

Cc: Heiko Carstens <hca@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/2=50%)
Cc: Vasily Gorbik <gor@linux.ibm.com> (maintainer:S390 ARCHITECTURE)
Cc: Alexander Gordeev <agordeev@linux.ibm.com> (maintainer:S390 ARCHITECTURE)
Cc: Christian Borntraeger <borntraeger@linux.ibm.com> (reviewer:S390 ARCHITECTURE)
Cc: Sven Schnelle <svens@linux.ibm.com> (reviewer:S390 ARCHITECTURE,commit_signer:1/2=50%)
Cc: S390 ML <linux-s390@vger.kernel.org> (open list:S390 ARCHITECTURE
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
Trivial, but uncompiled!!
---
 drivers/s390/char/sclp_con.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index d8544c485808..17d7d0f0fc64 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -22,9 +22,7 @@
 #include "sclp_rw.h"
 #include "sclp_tty.h"
 
-#define sclp_console_major 4		/* TTYAUX_MAJOR */
-#define sclp_console_minor 64
-#define sclp_console_name  "ttyS"
+#define SCLP_TTY_CONSOLE_NAME	"ttyS"
 
 /* Lock to guard over changes to global variables */
 static DEFINE_SPINLOCK(sclp_con_lock);
@@ -256,7 +254,7 @@ static struct notifier_block on_reboot_nb = {
  */
 static struct console sclp_console =
 {
-	.name = sclp_console_name,
+	.name = SCLP_TTY_CONSOLE_NAME,
 	.write = sclp_console_write,
 	.device = sclp_console_device,
 	.flags = CON_PRINTBUFFER,
-- 
2.50.0


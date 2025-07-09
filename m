Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C91C32FF
	for <linux-s390@vger.kernel.org>; Wed,  9 Jul 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084060; cv=none; b=DLRBRBrHkXRr3Pew/eBdyyDkj1/X+DtdbYKJIjwvWhDvcnlmjsi4Tcw1rRJsqDrVR9iyzzmpqyDpDo0topixYQMn+8a6pmVZmTa4v3N4t1HzYY89V3Xb+WGmD4DpqZB/y9S9z8vu4MU5vC5VN9GwkBYVWw3LS6eNHe4KMbpJAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084060; c=relaxed/simple;
	bh=eGHK3zD0Q3DFY2imosHFQNEWSE76rgdsFgfkIffc2qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3XozRVbmOD8qT+/xuXD1RFLgC/46LWF2BilwgIyWJ5XJ+xdzbOBMQ8it8Bb3u8RZ+JcK7oJfJg4m23XYy6peFh2mHpnrY6plxJkoghtn+XBJa1svfd2WYK0wyWrqniP4pkN5Ho2mdRceBdA0JcaWCv/BNuuZg6LfXzYxijIqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4VVELbe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4VVELbe"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-453079c1e2eso132065e9.3
        for <linux-s390@vger.kernel.org>; Wed, 09 Jul 2025 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752084057; x=1752688857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAUGgsfQMDjexJKFxkYhLT/nfssoiaSMFk90WdCf1HM=;
        b=S4VVELbetTzeCT1wc7ZUzKwsZ4598PBQ8LSJsiujakd5cuzAmfYaKyaBLFRb/Ox5oE
         U2ad0C4jAJ7orUxgTCsakfj5SRIRWdXdFSBcSnk8u2iROUvWq7B9EHAdA+EMUSUTNaSn
         MwKqQUcSGiAtuRJREWobnK3yPpPj8W/0F4/dwWTmiLWq6jBa0r7c9r56rjjiEkky2gIZ
         3VVVEMR3z5pghCdP07ao13aTuqkeD0GryPRgZtGqogI0I5CPZ83PaX9y17eEMoo8HLJO
         eIJwCG32k9CMz/5uVklWcUL1pzgHY5Dei04dFxJ/NzMKYnrjRDWKXy5lbma8GUH7lSYB
         UiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752084057; x=1752688857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAUGgsfQMDjexJKFxkYhLT/nfssoiaSMFk90WdCf1HM=;
        b=p+fktN5vRRI4qheg4jGI9XqNt5MsJBNr2aeXfFjeuarKS2UTkDaYI8w92P2poihMwH
         F0WYfElo1HldcQtzktcFVKxCEG3J6q0QBxyHgh3AcGDEGUMjlordLxWdBIA18ksQJZiv
         IYqPBs576Pxrb5coPrQNIxOjpu6ivfuxcxVZ4wybu+OELuoQKYvzSPx5ZuWnXLsQT0Tt
         2SSdXzTYToonOvqWDOKCWbN2NFp0Q9AxEgU3E3bNNN2/Tg+YfBzpYSzFUOdQNDu/OMnY
         QuwC0fS0ClLiSpe8BEaN0+ajeYSflCKnB8zj2X9NQmHU7WlzlFFeQdg0WoVOiBkoUmcE
         QkFg==
X-Forwarded-Encrypted: i=1; AJvYcCXCP1CdB5Y0ANa8a2+k9ryHpAM9s6+OmxW5i6O9dtEfs9LvMsQbITrBaIg2to+lHh7TEvFA99N68Dx3@vger.kernel.org
X-Gm-Message-State: AOJu0YwOi5gRwsbXktm/M7QndBga6XI5PqAi7ZRFA58yY/rsw8cDd+QJ
	vQTlOn+ehveqwCoJtx8MgfHcor5f79f+6I9Fy+JBofsz+mgXLsyZ68E=
X-Gm-Gg: ASbGncs0ABj6PqhbjpsD50R32UNLGIFC8P95ddQzKAdPdU/QecWkSDH94pwzWuYb5TE
	dfITY0gZ9DjtpfyJ5OlH+Oh/uPJiGYxan5xNy3NcymnDPdDg+xW9kdhkTtupeAYYb9pQsKSrGDb
	2VrNzJ6rUO16xR/O/j4po5Hfgfj1ugzP2ZMkuY/PrI42tih7C5nsnVc00SykYFnbBCI25ItixGG
	UU/QSw6nGKdlLRpmc1facAVegFSZ+zvqveCMIpgio57VGwMU4SUNaqQmdzvioK0vMB4/w2R2Tz/
	FuLn/FPvm3bbfwNzziZwWOh1qrvQ2XL+aHynCr7YA8avlwEDud5qc6SQVJwgU1PACr3ghwopeX8
	W2arRwv7+X9wL+QKqiikQtevISg==
X-Google-Smtp-Source: AGHT+IFpece2RUdJuAQnTjtAXQjb6DIQw5QgidtwZ8fq71vF95mLAhRmwhEvc0Ofi5T5ZeqCEdkdUQ==
X-Received: by 2002:a05:600c:6592:b0:453:6124:e70e with SMTP id 5b1f17b1804b1-454d5449369mr14172725e9.9.1752084057077;
        Wed, 09 Jul 2025 11:00:57 -0700 (PDT)
Received: from localhost (182.red-80-39-24.staticip.rima-tde.net. [80.39.24.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cdb549absm45558755e9.1.2025.07.09.11.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:00:55 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	S390 ML <linux-s390@vger.kernel.org>
Subject: [PATCH] s390/con3215: Use macros for hardcoded values
Date: Wed,  9 Jul 2025 20:00:53 +0200
Message-ID: <20250709180054.11372-1-xose.vazquez@gmail.com>
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
Cc: S390 ML <linux-s390@vger.kernel.org> (open list:S390 ARCHITECTURE
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
Trivial, but uncompiled!!
---
 drivers/s390/char/con3215.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 56e43d43c713..1519694c48f0 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -35,6 +35,12 @@
 
 #include "ctrlchar.h"
 
+#define RAW3215_MAJOR		TTY_MAJOR
+#define RAW3215_MINOR		64
+#define RAW3215_DRIVER_NAME	"tty3215"
+#define RAW3215_DEVICE_NAME	"ttyS"
+#define RAW3215_CONSOLE_NAME	"3215"
+
 #define NR_3215		    1
 #define NR_3215_REQ	    (4*NR_3215)
 #define RAW3215_BUFFER_SIZE 65536     /* output buffer size */
@@ -813,7 +819,7 @@ static const struct attribute_group *con3215_drv_attr_groups[] = {
 
 static struct ccw_driver raw3215_ccw_driver = {
 	.driver = {
-		.name	= "3215",
+		.name	= RAW3215_CONSOLE_NAME,
 		.groups = con3215_drv_attr_groups,
 		.owner	= THIS_MODULE,
 	},
@@ -887,7 +893,7 @@ static struct notifier_block on_reboot_nb = {
  *  The console structure for the 3215 console
  */
 static struct console con3215 = {
-	.name	 = "ttyS",
+	.name	 = RAW3215_DEVICE_NAME,
 	.write	 = con3215_write,
 	.device	 = con3215_device,
 	.flags	 = CON_PRINTBUFFER,
@@ -1168,10 +1174,10 @@ static int __init tty3215_init(void)
 	 * proc_entry, set_termios, flush_buffer, set_ldisc, write_proc
 	 */
 
-	driver->driver_name = "tty3215";
-	driver->name = "ttyS";
-	driver->major = TTY_MAJOR;
-	driver->minor_start = 64;
+	driver->driver_name = RAW3215_DRIVER_NAME;
+	driver->name = RAW3215_DEVICE_NAME;
+	driver->major = RAW3215_MAJOR;
+	driver->minor_start = RAW3215_MINOR;
 	driver->type = TTY_DRIVER_TYPE_SYSTEM;
 	driver->subtype = SYSTEM_TYPE_TTY;
 	driver->init_termios = tty_std_termios;
-- 
2.50.0


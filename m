Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D46239E83
	for <linux-s390@vger.kernel.org>; Wed,  9 Jul 2025 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088095; cv=none; b=IT2+psw7ToMO5HrCsvCBTWpf/phX6EYHNeRYdY1iwqoUU/kae3d7vyBxaekH3yHfcjG48qUMlf6Ewhkz5SGnmdK/UCfume0SYe+e6HDe2m7Tm4j1EsON6VLvX1tqB4g5k/waQVax0AGMNewaMHze04StKFNkeH9USEhVJIrwOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088095; c=relaxed/simple;
	bh=ps3yrZCAtQtg/5L0eP5Q8B12990B3rtVn3str1Zb94A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rv4j8d7hf1QqkKz4kH2fI5xmYfRHlo24mlntYXwOef/KSDbvurENdGHJbvhjSYl5Zh1AYCTo8I+oewkEXFiAjmWeCgnTFNcowYIcK3Z3AmV5fN8JPzgbwxrkkqugL9Zpwnnx5ebv/fXM08GmDASHECBLtrOjkLrRragI5lZLaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPNmE9WM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPNmE9WM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45368313a7bso214945e9.3
        for <linux-s390@vger.kernel.org>; Wed, 09 Jul 2025 12:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752088092; x=1752692892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4forSa3+5oGt6Sqk1mksi/woCr4nP0Q138TWiMdpnwQ=;
        b=fPNmE9WM3K+6iLnr8BP7V7Hu4uOHy5fXLh1XkP/tBJTbya7XsfEp/j3OXzEyG2Rwhl
         tEOfKPhgYheJL1f3PbQPeyLZe5wT2AXLyDC5Kh7N1BLhENatWH9wpEQCCFEC3b9eHxvF
         /i/+aKSa/pYM7Wcwc2GWhgeFA1AA62m1lJWlbx2SXTzMpCI8v9Y9zbNRGrbTX0BEuG5n
         2wPEuGKhUg73v4VmtzWyo7qiU8lnPVjySq096Pl5xlkaO2jvxuT6wjsLOK0RRc35+z2v
         IW5I0EfIKn6Bg3hqLD46FF0TKLCQik54+zhON6UmFD2xaL5pscClaYohbFRzzw3Y/UZy
         WUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088092; x=1752692892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4forSa3+5oGt6Sqk1mksi/woCr4nP0Q138TWiMdpnwQ=;
        b=aWnwjrY/i0THNe9MrUuZqHIv7iom/1A7e39lQjrqx3Q27n+0yFewfKcGQXlvSADiP0
         CFXbBYAplV5HnHJNn9FZHd2UpRufMJThwT0z3OlcgI8QhakyBOGromebhwgtyZ9b1rgk
         LFd2on4dwxSJDmkbM3eHwInxzkfPJz7aH9Mid2D5xiy1MaY/GP9yKOwJtnqg5IMXV76W
         O0cUSX9WhCSk1NnwKJWGh+LMFTDsyaIeaWINZWGzIeomHESQ/xAD3vQZPDrEcUXsTkSJ
         Euo5TVEYhW0eJn5lxOhdGKpp1iVU9BmZC6QGnLNzTOg9W0ulV4dA2kzFEPpKSI7akJEE
         xKeA==
X-Forwarded-Encrypted: i=1; AJvYcCX/GGFmyKyRhf++vFhjOYItfOTGQETVAyNV3Vgo49DHOzMo8jc9+oYXGQhgDabP/CQbqbQnNcqmYwuW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4T3PS1Wd7KUxCNg7iyRDuzrFfyaEaemOrji7ICYtrXF++IeRl
	3muEq+PZLhqF7SkOalKYT+j3XjbVuDIcSTb42oQ5xGaxzPeAjJzlNn0/8kjqu7i9Iw==
X-Gm-Gg: ASbGncvW9VWPlo0vOebNrZIKWrDbYgEUV6eXaY2y9Q2HVb6dkZYECc/fYGvaH5x69DX
	4ZjkOQ9+q9+9KFyoL4dd+xSNWw3S39XlVbMmSeE6nXF+b8LKI4E6V0hI4kekYkL+dikKOGJmYcA
	orYg1d45/PV/1acvnP04D78OmHK7o6iv8w4XpYEadoxh568IwatJWx2jE0yW2OthgurSjqqV0Z6
	uhK62SsNNtfJeXMs9Cj2o0dMQbPgtYdG+/jYE8qR8hfW91E4e4CgPdRgkbh8IBky84Caw/yGaiP
	0ZoYZy8n+vAwTNGDn9OrxU4V3tCbZGTiP7aRE6H0NwzEhu0g0+UfktQYsd9UdIYxSNHzBawIwse
	GB8QJbRA5ZrXf+EEPoYxjaSHnOg==
X-Google-Smtp-Source: AGHT+IHCoQdbWnTnGKao3GylolQY1gfO6IgitolJ1NybQOZWMVTkCqTQUY/WGi2KtVm0G1Y4jgWPjw==
X-Received: by 2002:a05:6000:400a:b0:3a5:8b43:2c19 with SMTP id ffacd0b85a97d-3b5e45105b2mr1291730f8f.4.1752088091879;
        Wed, 09 Jul 2025 12:08:11 -0700 (PDT)
Received: from localhost (182.red-80-39-24.staticip.rima-tde.net. [80.39.24.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97f10sm17099656f8f.57.2025.07.09.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:08:11 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	S390 ML <linux-s390@vger.kernel.org>
Subject: [PATCH v2] s390/con3215: Use macros for hardcoded values
Date: Wed,  9 Jul 2025 21:08:09 +0200
Message-ID: <20250709190810.13885-1-xose.vazquez@gmail.com>
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

v2: fix RAW3215_CONSOLE_NAME

Cc: Heiko Carstens <hca@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/2=50%)
Cc: Vasily Gorbik <gor@linux.ibm.com> (maintainer:S390 ARCHITECTURE)
Cc: Alexander Gordeev <agordeev@linux.ibm.com> (maintainer:S390 ARCHITECTURE)
Cc: Christian Borntraeger <borntraeger@linux.ibm.com> (reviewer:S390 ARCHITECTURE)
Cc: Sven Schnelle <svens@linux.ibm.com> (reviewer:S390 ARCHITECTURE,commit_signer:1/2=50%)
Cc: S390 ML <linux-s390@vger.kernel.org> (open list:S390 ARCHITECTURE
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
Trivial, but uncompiled!!

Now easier to read/find:
$ git grep -E "define.*(DEVICE|CONSOLE)_NAME"

con3215.c:#define RAW3215_DEVICE_NAME   "ttyS"
con3215.c:#define RAW3215_CONSOLE_NAME  "ttyS"

con3270.c:#define TTY3270_DEVICE_NAME   "3270/tty"
con3270.c:#define TTY3270_CONSOLE_NAME  "tty3270"

sclp_tty.c:#define SCLP_TTY_DEVICE_NAME "sclp_line"
sclp_con.c:#define SCLP_TTY_CONSOLE_NAME        "ttyS"

sclp_vt220.c:#define SCLP_VT220_DEVICE_NAME             "ttysclp"
sclp_vt220.c:#define SCLP_VT220_CONSOLE_NAME            "ttysclp"
---
 drivers/s390/char/con3215.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 56e43d43c713..3dfddf769015 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -35,6 +35,12 @@
 
 #include "ctrlchar.h"
 
+#define RAW3215_MAJOR		TTY_MAJOR
+#define RAW3215_MINOR		64
+#define RAW3215_DRIVER_NAME	"tty3215"
+#define RAW3215_DEVICE_NAME	"ttyS"
+#define RAW3215_CONSOLE_NAME	"ttyS"
+
 #define NR_3215		    1
 #define NR_3215_REQ	    (4*NR_3215)
 #define RAW3215_BUFFER_SIZE 65536     /* output buffer size */
@@ -887,7 +893,7 @@ static struct notifier_block on_reboot_nb = {
  *  The console structure for the 3215 console
  */
 static struct console con3215 = {
-	.name	 = "ttyS",
+	.name	 = RAW3215_CONSOLE_NAME,
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


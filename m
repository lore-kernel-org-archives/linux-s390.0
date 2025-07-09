Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D81F0E50
	for <linux-s390@vger.kernel.org>; Wed,  9 Jul 2025 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081231; cv=none; b=ELZLidL3O214UZsIM3bmA6e8IqlPNsc9+XF2uBPTitUtrjpdC2VTsH+odmPdcrUzdAp/jV35YMhSCr/j7DnWQNAy48fTDFjfli2a6M65frKxxJdlqUmKjFd3qqhruvdo5HJkuO0bvx9ycmt3EA2jU3Dw47WHnrg5rh2AYs5BneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081231; c=relaxed/simple;
	bh=Gq5KWKRNn/Nqkug5OwhoDjU4OCbVq5XjTNUFNymJHIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nqpxSPPlmfvC8LMFTUP0pWan3bdOMMmVT5vYoXy6gDg6JqXjQAukBcBdCHLhgaX80s+BvtESFwIF1GvTC5j/kSoDKn2ChcA0OwrPj7Qnw5terlsFTAFhVl2ekABr5dg9wYqJe/50LNgeYm0jI+2ZFn8cmK902NGp3dnO71AlkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzXkdbQQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzXkdbQQ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b20fcbaf3aso24281f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 09 Jul 2025 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752081228; x=1752686028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iARGlcVhXws2CnW6LbTRwRY7NkEfssq5XUnN+zfsHA=;
        b=AzXkdbQQRVt1hM+NKOEkJyoH9olkw/R0hK8/oPt9+jwNRSk8RefJd22C8r+x50jPZu
         2TIndSxUQ/mMuTd2AdVJJhwv4TsXWY/GymI+b8tjeXMSGAmd20f2pKAYMvzAcT/+E04A
         XQ6gg8MX7b531jK+WfrbwoB6bPjaTgNZdeoWYE/GloLQCSce4VGVfFqvzU5FiLGduQqK
         fdAMHZhK/8jyYnvBrfJCMId1ySSqQbuWkonCL0Fc55hbVDW6XVVzrD7+gejOEpU3QXrU
         /pKB/5DE41O3CJ1h2D8VfmbVSLUX/6INybC2dLzmz32DpWjzAKAqJwWcPSEuYsUfmEBW
         6Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752081228; x=1752686028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iARGlcVhXws2CnW6LbTRwRY7NkEfssq5XUnN+zfsHA=;
        b=Qmd/CHuF52Yfj/YujqRvggcI7sByTplhJDTF6ZhxM0BaGKJHf7y8JsUVwIdHYFMLl2
         TdBfkeHmQYLXWk1mo9vFv0JzfqDlyGDvaNhjR/aiDb+nuc7VgasI0LicEikW1uD/FYAC
         qUmf0gDakDeC99igjQ4XfDjgFSpxtCHRRydY46u17Wx8wgXSxaa5B6u6JniSu19Bd1S8
         s0H7puqbfdKvN05HUSKqMn58+JklcmZzYNLTLYpZRdH0WWrJ9PoosOHtZcc3vIbS67Wm
         UDmntz1olTgteFwaO+jr6wfaebmhswfFasTIhdjRYOUuu4EhbQARxN+rtWehF/HSuqYL
         8KOA==
X-Forwarded-Encrypted: i=1; AJvYcCW9ISv6GnUd4lEmtMBdVhUzX0sn32EoENws82qYHAnkeR+0ZlPeTYlqSNM48Q0NfY8UG/vhIMWCKCO8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jErDH75Q4gYGydqfhFEG+Y9j8gk8Bj6ScLfJz9ZvCSoA09fT
	eLLhwGT9+j8TvW2ZLoVXFJenQfEiGJhXQhhhKVxNkwfqZhz+9pY2C6g=
X-Gm-Gg: ASbGncs3ZD1rUjTy13prsURqENRzYjx07iTcSRIgp2rWJjMK1W9jxbzZZkGYA5QM3O7
	k8Tv/c6644mHGHf0fYEDeaNmsMfgzpdqDQZhLbiJ12LG/yTeuEpHpE5LW2fpZLgrel9NGIMRNm3
	srFRWmQxRIOth40z823CH6wIW1IoYEhlpNTPTKhOKBT3/71ejfnVMhLXX/+/7AZo9/H2zbVVkjP
	iEyLHGPGyYH5NowX/Xbr8ZzYlDEEIC1ChNszmwrvuoCl5sllBv6l8LJVqnrPFKxZ8bSEYnHLJLB
	oZfBbiW8IrAgXFvmukDJvFH6XXYuBqMOc/qCKtKKkop4IG8A8Gc7Z+OG3SUQ9CGXr+Va2Ok1V8j
	NMQXPoi62RZPxNZ75iFtRx/L7wQzUOIcxqsdl
X-Google-Smtp-Source: AGHT+IFwX4f9ytN57Zy/5fCnc4xoMKMOt82QpESiy1X57diiYpyfPl/R//iH9D6MTk0R13EfFi94TQ==
X-Received: by 2002:a05:6000:2085:b0:3a4:eb46:7258 with SMTP id ffacd0b85a97d-3b5e4545f6dmr1133847f8f.15.1752081227830;
        Wed, 09 Jul 2025 10:13:47 -0700 (PDT)
Received: from localhost (182.red-80-39-24.staticip.rima-tde.net. [80.39.24.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030baa5sm16972402f8f.12.2025.07.09.10.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:13:47 -0700 (PDT)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	S390 ML <linux-s390@vger.kernel.org>
Subject: [PATCH] s390/con3270: Use macros for hardcoded values
Date: Wed,  9 Jul 2025 19:13:45 +0200
Message-ID: <20250709171346.9630-1-xose.vazquez@gmail.com>
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
 drivers/s390/char/con3270.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index b78b86e8f281..c99d7822b176 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -33,6 +33,10 @@
 #include "raw3270.h"
 #include "keyboard.h"
 
+#define TTY3270_DRIVER_NAME	"tty3270"
+#define TTY3270_DEVICE_NAME	"3270/tty"
+#define TTY3270_CONSOLE_NAME	"tty3270"
+
 #define TTY3270_CHAR_BUF_SIZE 256
 #define TTY3270_OUTPUT_BUFFER_SIZE 4096
 #define TTY3270_SCREEN_PAGES 8 /* has to be power-of-two */
@@ -2020,8 +2024,8 @@ static int __init tty3270_init(void)
 	 * Entries in tty3270_driver that are NOT initialized:
 	 * proc_entry, set_termios, flush_buffer, set_ldisc, write_proc
 	 */
-	driver->driver_name = "tty3270";
-	driver->name = "3270/tty";
+	driver->driver_name = TTY3270_DRIVER_NAME;
+	driver->name = TTY3270_DEVICE_NAME;
 	driver->major = IBM_TTY3270_MAJOR;
 	driver->minor_start = RAW3270_FIRSTMINOR;
 	driver->name_base = RAW3270_FIRSTMINOR;
@@ -2145,7 +2149,7 @@ static struct notifier_block on_reboot_nb = {
 };
 
 static struct console con3270 = {
-	.name	 = "tty3270",
+	.name	 = TTY3270_CONSOLE_NAME,
 	.write	 = con3270_write,
 	.device	 = con3270_device,
 	.flags	 = CON_PRINTBUFFER,
-- 
2.50.0


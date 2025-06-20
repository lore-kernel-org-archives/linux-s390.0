Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8962DFA35
	for <linux-s390@vger.kernel.org>; Fri, 20 Jun 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434423; cv=none; b=Y9Se4zPJGhI8rEHE1jlIAME9GkkwfO/jrtiGkQiVhdI+YU2mJuG7jd8nSFBrolxWFV5h3RQoKoQRT+yWDwQiEDRhfuoSu8SfmtQs+BmIzakXIj3lVd8HOhNVJ32096hdzZmH5pj7xqbRRucaVOTnNzIDi+3u814BYHi5E9ANgG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434423; c=relaxed/simple;
	bh=buqInb5mqkNDwL+7hQIeuQgXeAKtV/p8V+7Iql6hX8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTLEcG2lX70Snv+3NZ/FMW3+YaFLZZpeTLgSExW3QQ1nrIMzX4Qg0YCWU9MOMxiPEetgfht0g03XrBHDd8Y0CzBpbOCCf3DrU0bi3taMAgCXEKxcinh1f2JB1L6KkyZ7UdFxmFeSgiPf8DK4XccJRACeL8LTgHMwyuJ8dTpsXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QgYSFcVM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QgYSFcVM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453066fad06so13221715e9.2
        for <linux-s390@vger.kernel.org>; Fri, 20 Jun 2025 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750434419; x=1751039219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWO2G/DbpRwwDVi2ObC8ypf7TcnofMBz/4xVPLOm7vU=;
        b=QgYSFcVM+qtX+bYBHHiUvopNXM9Ya6ujRbKuCcKraZ5JKjbVk36l4Aa0jWZ0WRuBGu
         vCRv8WnlH6vzfvrqes22EdTigaRyRgOQZiQQDyZPaWjOiZGWMcY4F5u/7sEFoRc2xTZB
         oaiaPoYXfc7VNCdmt3+N1ZXGSAa1AWyPm1HtquIUveu7GALlvfhMluTCdm9fINNYaepL
         q3+iaZgtDilKA36Z7twzhzlKbWT0WM2Qqdaad6z4kXH4o8o810EU63X8lVBrINbgj5b+
         0Ggh2M1ltPZNvTJ1BUahDS6AhyVE+d8Ktgffx6NDhEEXF4BFkWAFMadkWQqTr5bLjrve
         DRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434419; x=1751039219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWO2G/DbpRwwDVi2ObC8ypf7TcnofMBz/4xVPLOm7vU=;
        b=uwaB55bA/4dWvU5moVgH6ciUPyqmen0RkFGEs36LiA/Zace6mLSpOle/2XXTj9zt3I
         ZmMrWJoSA03DlLYNBuC2jWiiGe8LEq/Xy2tHrhTSbOsIZnyTCz4gmkn7IJ+VoYFQNaA1
         kaA6fKi3B/YP6oVXL1lCC82v9exRrEgsqL92fKaYv81D5MtIsCwLp4usy3JBrG5W14Io
         FKge/+UHU080DTN/gLC/wA/Pk37RU1b3jfuQC3YC099mKFuCtQ6ATBCxHkE95s61LngS
         lW4DjMytMMy8wInBJ5guSjnZjeNwCSMWKAAkGz08WylH0PqJLiOGpRWy0tzCffpK4PKq
         yJNA==
X-Forwarded-Encrypted: i=1; AJvYcCVT6+977fi+WtqDxba/Voj9p16IjppOroXJj1OYLKGMb++FFsdwky5nPNcYEfOlq5+0BvrFWQTToYfB@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbRa3Gr9NyQ81/4my8KhHrHiQFiAorlTG8i/fySumMQoRWUBl
	LCiFo8cttN0ZWZEKDXJFKNBkAp52GBnYlUy5k7DwfuwDvgNy6JUFD4Zun5+ygwdeTy8EBbnn9lR
	bEXakkdotSg==
X-Gm-Gg: ASbGncuGaoBtgKl79pfsrS34UDByYdIeZWZhiEDgMv/b0mSqSJDCwEOH4ZpDtp0ZwbH
	htADtej+WZQtaSkr1dzCkkE6tMULsfS0RfnZU+0ThBxPVdGHgjx1/6CipP6YQucDrDoUCGkzp0I
	EiMhdZp+bErQriNGdwutI3mSW1KFmjZ0A9WvyQqJZGLQQhvQKFp/82MjZP7rq4TLgo7Nusni0R8
	zi2r/SDgQ3d1Xo9rFl9/QRU8vV/4RHUehhzGBEpIZfXQEpnUQtBNxX9vM1rzTVxN/Q1/cz/AqNn
	SgkNj84h1bWxub9FzIb92g0oNIGqrrYWYTSzW5U2L1iaRvo5S54NawpavCRd7Q==
X-Google-Smtp-Source: AGHT+IG+CZmZfbLPrVn3DthMJ9P4F7yBCo2NT+F1A0hHwe66P2j0wSF6m5Ao5UpWm9U/Nvwk9K1L7g==
X-Received: by 2002:a05:600c:1546:b0:453:1058:f8c1 with SMTP id 5b1f17b1804b1-45365392159mr33025775e9.3.1750434419139;
        Fri, 20 Jun 2025 08:46:59 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453647071f4sm29390755e9.34.2025.06.20.08.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:46:58 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] s390/boot: Use -D__DISABLE_EXPORTS
Date: Fri, 20 Jun 2025 17:45:49 +0200
Message-ID: <20250620154649.116068-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Files in the arch/s390/boot directory reuse logic from the rest of the
kernel by including certain C and assembly files from the kernel and lib
directories. Some of these included files contain EXPORT_SYMBOL directives.
For instance, arch/s390/boot/cmdline.c includes lib/cmdline.c, which
exports the get_option() function.

This inclusion triggers genksyms processing for the files in
arch/s390/boot, which is unnecessary and slows down the build.
Additionally, when KBUILD_SYMTYPES=1 is set, the generated symtypes data
contain exported symbols that are duplicated with the main kernel. This
duplication can confuse external kABI tools that process the symtypes data.

Address this issue by compiling the files in arch/s390/boot with
-D__DISABLE_EXPORTS.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/boot/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index bee49626be4b..0986c7c67eaf 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -19,8 +19,8 @@ CC_FLAGS_MARCH_MINIMUM := -march=z10
 
 KBUILD_AFLAGS := $(filter-out $(CC_FLAGS_MARCH),$(KBUILD_AFLAGS_DECOMPRESSOR))
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_MARCH),$(KBUILD_CFLAGS_DECOMPRESSOR))
-KBUILD_AFLAGS += $(CC_FLAGS_MARCH_MINIMUM)
-KBUILD_CFLAGS += $(CC_FLAGS_MARCH_MINIMUM)
+KBUILD_AFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
+KBUILD_CFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
 
 CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
 

base-commit: 75f5f23f8787c5e184fcb2fbcd02d8e9317dc5e7
-- 
2.49.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A51A9F85
	for <linux-s390@vger.kernel.org>; Thu, 15 Jan 2026 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437834; cv=none; b=N08QbavRKENEJiHnl5vgGjyrgHW2uTYP9goI1qIP7zwuxxpWWKA6XbIZGCWLvH6qZxmv5hc7Kma6V3Lksyvqa8ArUcPjPzjwPgoGuqUJ8KweIXttHvKPP1bpF5NOhz8D2xL5ZXhj6mQrqOp+8L4ybwqt+nOQ5crPdAbVosvqLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437834; c=relaxed/simple;
	bh=Y0ATaMAvk9FF6UrWskBp3SZEl/ZHtoXFGSHDeAjM2K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPJvWQ5bPjftZU3U1AkZ0qpvFo9Dvj2lomg09Mfg6VkZIqPNaN6DywmFu6fIjYV5setUhBwyNMQIQHSLp6lmwtfXuUOD8NrXfht2iU86yoc7hMHvJ/AWoy4u2fuIfzlpjUjXYDc5JRXzI/pn33GQD6ZT11ShepL9uLT9gvRdtuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqT/J0x9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5j1M9cA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqT/J0x9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5j1M9cA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768437829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOS7+j7UGsL6cnyDN4idqz9QGj6+I0W3PRCQ7QsCd/k=;
	b=QqT/J0x9hTNFba07TFk4kRIpQe11yexv3Q5auvN3bH54u205XgcQtXivMTpMtu3UnMW243
	6oGCeaFOw53rqtXslJeki20PdBoGsNGfChCnPcgGvZvT0rZGhXMu7W3C/bhyN68qb/IAFM
	cJbLzuWQrXkVdrewKuBEmlQu2JnyPso=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-3Dd0-re1PseevmrHh0NCTQ-1; Wed, 14 Jan 2026 19:43:48 -0500
X-MC-Unique: 3Dd0-re1PseevmrHh0NCTQ-1
X-Mimecast-MFC-AGG-ID: 3Dd0-re1PseevmrHh0NCTQ_1768437827
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81f4cb0fdd8so269912b3a.0
        for <linux-s390@vger.kernel.org>; Wed, 14 Jan 2026 16:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768437827; x=1769042627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOS7+j7UGsL6cnyDN4idqz9QGj6+I0W3PRCQ7QsCd/k=;
        b=X5j1M9cACyX8CdsEDA1GbtU327T62/OOHL7p4k+yq3vj2W9NP+8g3u/i4TEY+CVEVb
         Wd7txPF0HuTsXs/k4uPvkAkPnpcw0CPm5zIWNbbVG+uQQGW13t0OU3WDc0Io6WB6Sbr7
         5uQAvK8x+tH+9xTgZcYtdjAG9pTTi25SzNnQTRW3w6DMDzIMk/XfQ5K3P4aEMeztWDNF
         wQ/49U1lctaUfhpzUHE8Sq8lLktQVgxyuSc4rk+irW+UoSC7dfKh9LMzcni5ZacpYzIz
         IAmyQjvyBzUuXcPksIQ159bGsikNBoi/bjZpV5hokBFCYWkU3kryjsvpkLtWT3+3Kif0
         LITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437827; x=1769042627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KOS7+j7UGsL6cnyDN4idqz9QGj6+I0W3PRCQ7QsCd/k=;
        b=tePzobz1TE/G1K+fHqgLIkgHHgCEezZ+X8lU2qcDFStNX20tXtCv7PlXYYHganQLWo
         UjitzU/+cedEPf4t/VrlfdbVF8KZItgfirtlkAphcDoxd9W5ro5oYYkDxWW7wiSKFpOy
         1OccSYjQ99B43zizjL0p7SzBUuZkFvj9lIUl1GPouNWyx+L6o5bNCZ24nujS3DHTs0Wl
         luCMtaQ0phbG/pquzDPY6nGRgWo21Kj5lG8Oj8kxeHnuavI7TW/5xLC/pfTP1vP3IjGm
         1PGClHV1H/fkB7edGwMrsJxr6f9owl6sUfRITGg8giDVZoYMG+kpvPV80PHng0z5r6d2
         t7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPJtvEOUKgMJIG8q15WHOKOEqDqOllyvpgfDtEZygQDGXvVftjYbtO9LlNMpu7pxsUBR4DEjba9aRi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdjd9IIEmeSWN49uqr8PtRWEMg/n2jNEl4B6hKLRE5PiIjDGUq
	iaXRuqw9rWXTA+e4Uy4JrVWOso/wYcgbPhpd9ed1fYcTJCJ1w7axp4ThBJeyQIUCW+cyrbIo29y
	/zcbQLbGy8N4HJUgd1PZugC0ZIevnAb9oj9sFF0SiNP+5snFiBPth9fpKWbYapdk=
X-Gm-Gg: AY/fxX7cBdTP7gSaGgZGBJwc1AG1eRRYZKWma4I57WJemWYXk/Vca4ZYh9B89acSqZe
	TQ529620UPZJnu1c2ZF2cMiUk2d97LH3jcWdNNw9c3Gror2YbGw0ozbJ1/QVwjXrEbwi6qv3fqv
	Ee09fCCE5oMvlLiupZkBAR7mcKF9h8DpDxD/aObjpKrEH2Itb5eZlxB3E2ZiWOJ1WEXGPSm0htI
	AZzzIxl+iDF8wmHD6s7GUE0rU+di+TyFquoIuPWnXOPV4LjtIuC/UDzp0z9u9axM4HIV5XlGopZ
	8lTWYrILdDdjO3ihw1Pxs+rBn0p9xkwej5p60Xde+GcgLpIvv7uKF/lSULWnOlTVkhyHSSe2Wu+
	5
X-Received: by 2002:a05:6a00:2990:b0:81f:4bc9:2a1e with SMTP id d2e1a72fcca58-81f81d1002dmr3352985b3a.11.1768437827162;
        Wed, 14 Jan 2026 16:43:47 -0800 (PST)
X-Received: by 2002:a05:6a00:2990:b0:81f:4bc9:2a1e with SMTP id d2e1a72fcca58-81f81d1002dmr3352962b3a.11.1768437826604;
        Wed, 14 Jan 2026 16:43:46 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e6afbc6sm666936b3a.67.2026.01.14.16.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:43:46 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org (open list:S390 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] s390: Drop unnecessary CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
Date: Thu, 15 Jan 2026 08:43:25 +0800
Message-ID: <20260115004328.194142-4-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115004328.194142-1-coxu@redhat.com>
References: <20260115004328.194142-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b5ca117365d9 ("ima: prevent kexec_load syscall based on runtime
secureboot flag") and commit 268a78404973 ("s390/kexec_file: Disable
kexec_load when IPLed secure") disabled the kexec_load syscall based
on the secureboot mode. Commit 9e2b4be377f0 ("ima: add a new CONFIG
for loading arch-specific policies") needed to detect the secure boot
mode, not to load an IMA architecture specific policy. Since there is
the new CONFIG_INTEGRITY_SECURE_BOOT, drop
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT for s390.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/Kconfig           | 1 -
 arch/s390/kernel/Makefile   | 1 -
 arch/s390/kernel/ima_arch.c | 8 --------
 3 files changed, 10 deletions(-)
 delete mode 100644 arch/s390/kernel/ima_arch.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index db0383b19493..1095536c84a3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -77,7 +77,6 @@ config S390
 	#
 	# Note: keep this list sorted alphabetically
 	#
-	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 	imply INTEGRITY_SECURE_BOOT
 	select ALTERNATE_USER_ADDRESS_SPACE
 	select ARCH_32BIT_USTAT_F_TINODE
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index ee976a27e677..00a74dd15d16 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_STACKPROTECTOR)	+= stackprotector.o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
 obj-$(CONFIG_CERT_STORE)	+= cert_store.o
-obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
 obj-$(CONFIG_INTEGRITY_SECURE_BOOT)	+= integrity_sb_arch.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
diff --git a/arch/s390/kernel/ima_arch.c b/arch/s390/kernel/ima_arch.c
deleted file mode 100644
index 6ccbe34ce408..000000000000
--- a/arch/s390/kernel/ima_arch.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/ima.h>
-
-const char * const *arch_get_ima_policy(void)
-{
-	return NULL;
-}
-- 
2.52.0


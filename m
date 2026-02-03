Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F956322C78
	for <linux-s390@vger.kernel.org>; Tue,  3 Feb 2026 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770092102; cv=none; b=LoKo4E20jNjwNpT+2ZHsnmcJvyxIsdQzjMjgVZcBMogD48hCVo/W8/ye5kMjVwdIhDWQ3fjMnXHaAm7cj/HEIsHl3xS84OWg/ny2EQYMkcrklEwYcChEx6Om+VMnqMdQxVytG4rBhJ8ZhK/yBmfYa46a8fy7WXT2PkCJgTfc8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770092102; c=relaxed/simple;
	bh=6V5x4eZjC0hFctwCre+f1/5kPFFASW1PwXbyC2KH1uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1V2krGI1b+4Yun7Au3vScUdzKGgawtavUQhTp7/cEAQQ5IglyUPyt05Yn/CWUe0T4B++oZr8srsJZNo08DAcmlkPsGdW0fN0TJpflHS27iPp4mwmb9a3iI2gK71J816MnrBsO69ONcTp2lm2Ql2T9ZPKVEPUizcJmGRl7rHrmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkLjgWmh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5I5bvja; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkLjgWmh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5I5bvja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770092099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4Upg9+MeOzlqdVPPGSlv7n6ggK/vlBPBgeg9qsgORs=;
	b=SkLjgWmhXAmj0xHsF6zPJLDQd5FlZjzH3rm1hMKo4W/zJPd/6cVeaJmyHTA2872ogEMxBS
	XAw4IidgNTq3u652n15+YoiEzve1rKcYjwxGqSAOjDTE5IhwmkD8FpsBULvIH5h4YsS/Sj
	aF39LTlgaOB5spFr1QG1biTt5xoic5s=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-WOEEZkqNO2e5Uj1h9a900A-1; Mon, 02 Feb 2026 23:14:58 -0500
X-MC-Unique: WOEEZkqNO2e5Uj1h9a900A-1
X-Mimecast-MFC-AGG-ID: WOEEZkqNO2e5Uj1h9a900A_1770092097
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f53036ac9so4283348b3a.3
        for <linux-s390@vger.kernel.org>; Mon, 02 Feb 2026 20:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770092097; x=1770696897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4Upg9+MeOzlqdVPPGSlv7n6ggK/vlBPBgeg9qsgORs=;
        b=L5I5bvjaVZysA5Q34weL4+mT45JriWkl4hZiO9bXOANvr/0CV5Y9p/cQyz9Oar4rD1
         pgmnSE9MvrdJP8oiXi0Hf+HjhxQ8stWVhM/miDGenQoh3wJBvPvjwC9lCVe209omPkGw
         TLL2KWmRie/yorsStHvMvIj4hnq1O8uDwCpdd9ObVCaJBdbT87dIi1l0SFGb7CIivQzU
         JITKGRmjIF4EHW3AhfPxvVpTGbz0XYrAJdTtPQWcEJR8U1LczpaOYIyXzeeNXqF038HV
         3Gn+13GcyOp3/cKKZIaSKjdv2phu4Rq28HYY+r3gaDElTd6lbs1uvD+yt41IeFUzV5YM
         h4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770092097; x=1770696897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X4Upg9+MeOzlqdVPPGSlv7n6ggK/vlBPBgeg9qsgORs=;
        b=u+2p+SNM9I1H+sDggu/yk8eGengJSxo6wqzE/Xg0nRTzDtehVPpulpXixXHwHOBUrM
         +03sbhoNeJ+moAovEzPnriSmvRc2M/YXXlI0jozsSvLxnNhE0se77weUEk3P+bFWxvZ4
         nYphhGJHx0jSObVFAh9DbmgtU5FtQG4deexm9HW8YWE7K5R4AzB5Z4gbmB3pPkAXWmze
         VDc+V+/xJqiCIDAqV87qpWalYBXy0hPPDFEhZloSEx/FouVfxmNYS8UBQk4AIQpqEJsq
         zWYuUCID8+Ol1EM9H4xHYlR0SJLJMGGPH/t2h0rEhKI6Pg91fedt9H1/yJ8QidYQbYA/
         KFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe2QPOe+6uBkf86LSb42GflnmJE253v/JHV7u5FMOmxn35C3wI/UblpH3Rwnatm00SupvfgW1Tv4A8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3Q1krjYGL3/uu2NSDrfeqrw/bqTfemAaAru6kEx35GFe/SkB
	wUkHHxkcO2S5Yny/Hj4POzEnogUWhqbbuNQDhjfC0xYFpesFxVX0CgUVafMD2x5kIms/+9N0nd5
	gqLFRr9FDcvEQ8MoHUWLcqIrsqHOtFHW1wi7/vptmBPT13BpC5NNM0es6qpZsuKU=
X-Gm-Gg: AZuq6aKLSFa1f945ym+8OlEujtTpC95ncI4aivqNYk8T3gvT+HESRkzHzvU/6i9kpbd
	fbNbe5tm7JnbQNItqd11Q61NjgBp/IqlvDo16DeK86Notib6QD81heBg2qSYp9fF8nrsLcZiTBm
	e3WxynkXOsHFKgxMJrrJd9zurZI0qDDzzL0fitBtkwUJpMP7JU1pMGL70hxj4dbpnI1zQp3Gu6F
	YhZG3D4SPthSuLAle6/iIrMo2PSYKyIstXfa+O0LpwiJx0wzL2p74R9iwWqX2OJL43vTZNnFp9z
	0NFByZUXlRvD4Q9O5mTACNfr32IMc7MFPevMkH6mbXxFsFdrre6XgdwxVeyP9WjvFnfMoJbA7hh
	z
X-Received: by 2002:a05:6a00:248f:b0:81f:d605:b2c with SMTP id d2e1a72fcca58-823ab873c6emr9784941b3a.48.1770092097239;
        Mon, 02 Feb 2026 20:14:57 -0800 (PST)
X-Received: by 2002:a05:6a00:248f:b0:81f:d605:b2c with SMTP id d2e1a72fcca58-823ab873c6emr9784922b3a.48.1770092096753;
        Mon, 02 Feb 2026 20:14:56 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c64b4esm17118955b3a.69.2026.02.02.20.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 20:14:56 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org (open list:S390 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] s390: Drop unnecessary CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
Date: Tue,  3 Feb 2026 12:14:31 +0800
Message-ID: <20260203041434.872784-4-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203041434.872784-1-coxu@redhat.com>
References: <20260203041434.872784-1-coxu@redhat.com>
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
index 0e5fad5f06ca..d8e62c67d1ad 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -77,7 +77,6 @@ config S390
 	#
 	# Note: keep this list sorted alphabetically
 	#
-	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 	select ALTERNATE_USER_ADDRESS_SPACE
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 42c83d60d6fa..89a2c8078fe7 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_STACKPROTECTOR)	+= stackprotector.o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
 obj-$(CONFIG_CERT_STORE)	+= cert_store.o
-obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf.o perf_cpum_sf.o
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


Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82216221546
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930583; cv=none; b=CuX7Bcv81vBJRTTIbr5zM2cqQ6Ffmu1ALe6/3DAxgVQ2jvdnHDyNbTiZ09B87R7Nh21bovCb6gd4fXag/7UIwMgZgvONEeoEVBr/ExQCtHGWZJz0lcHl6vtaCJNXbkd9Gm4g3FySFEkdOJPPulSlukrfIodJHBeaTdi10WTCfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930583; c=relaxed/simple;
	bh=gil8oy+SZXRbzO7zlrgvmSXOvKIAYCw4UKga1gomgUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B80ZDXYd6npo7Vb3y7jrpBZF97eAmyoxecGC41bO5qROT/Wb73ojK/6n/4eL5hXDLkw4Z9vyaKZp4W9VB9XGu6/FHES6+8HIv+3Eqw5JV38yiFuLUD1PJvE/mUPZdrUJrLxTsJ7yEPU2gSdJI8UfnATDM7cOpb2szsJP1mgXecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYTSjOwm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYTSjOwm"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482e2fdf6ebso1009049f8f.1
        for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787930579; x=1788535379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2kBN1emgsyv6c1CXhhOYzrKk+x9zAWtQ0EZ9tbmR0A=;
        b=OYTSjOwmy4jZc+r8zS8XsUSJlwqz7MYQOiA3JaWpG/c9J79xNIG/VYUW/6PLFIRaCT
         JlVSdwuuSLpeDtARsIqwxXytIHRbl9tj7fLtPGlA8MfxH7csikE8HleQphX1qfEQG737
         +OEBmMdiMCZw7V5SzSs0w28irZ5Gv2B4cgEtS1kti/wo+rLUthgtNEGQCRkfdXsphI9L
         pAHfy9rd1AtljpltmJRkZxI6hITaOaFp7Vek+Zj7XwV5UqKa7OJxSX6kBurfHfjo9VWH
         Mb7nSm86jMpYIPtcV0j/+2d1d5IuLX4nwxWGlB/6HXa3RWVrvCXRpthpIUUWjz+ygmh8
         eZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787930579; x=1788535379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2kBN1emgsyv6c1CXhhOYzrKk+x9zAWtQ0EZ9tbmR0A=;
        b=PHV+zlHSS5MM7arPoiYuXcWz1cV5Na9VzHqO9T/+WtH51ttGULjb9CCs3i8sa2EXV/
         vLs5fc5m4jcm+dPoW0Z0pMQkLs/SR0wM+3sHahqo6KaiVWv83gGpsqJrgJSxKhuJvwbt
         +mSDEhrorljONbBEdjEkwGkHxu1inMLtxQKdY3Hirg/f4hC1LMrNx2oIvgj83z+IeGQf
         ArLmP7O+ZGepOesmxV+GmeUQhMLd46E8F6+lFFWLks21qcw4H/E/45d61Q3bxeL95uGz
         lOahDFH8Qi1hvdlehw8lnrx8ymjwCDEAzkpZV/5lrRgTtFm/nIE/iPXi0V4M4AWNRMPw
         s2Hg==
X-Forwarded-Encrypted: i=1; AHgh+RoHExbbJQgKodx7309kwDuszbBAkJ1aLAguduiDdncY0SOJaYomgq5GtKVMR8ynn267XBIEyF0qyagH@vger.kernel.org
X-Gm-Message-State: AFuF++mh3DsMNZ0AOJkUonKaY3SqqCIuOGD23AL8zsQF4h87KZW9RdJR
	tB/LUGJdDf4dWNhweMl7vED5vCmWcDtOTyKXyTeAhHC5yPQs7dkCVREyKWp36B+6W+c=
X-Gm-Gg: AR+sD12huwhAJ1B4qbP/JJRht1n5Tt0trGMmVmFHTddYCsRjwIMkbsrVfbZFiNCLJjq
	B/qOLRw/juEBeVvZ1VmI6WPZ5qQwtr2iTcWzZBoTRcZ9Q+gF436QKe3RMxU8TFIQ+VAp3dPg+Kf
	lcHUMjZCG099enUA5hx4g8jPfDRGs/NXvhYKQKQyRBWOQydyxcoxEab5CitdHafaPopZBCH+jDS
	CffsZefe2lnPt8g5FjujmaAytnZfuNXTnLqWGNtVg2wUnA/eD2ridNXvS5fU9bCTxNsY/7ADmz7
	8Ar6+swTphVQHp2M4eLRyE8V9lv/nOAG2o+dwEjMgb7dOmDaLG6olnJ0SXdnjC9iAmiaBkZ4j2G
	kubS+/rgxEe3jPGOksbCK2F0HRAIeH/X33pPCGtrry3eDP50GziUjOe9wh8rSxACx0bYrKf2XaU
	1EjVQG6RYilFdU3aQAlx+cgfJR4/KwC8HXh4Zb8cks9X3uBudeedHK5pjj6xPgvn0BGT3sCDSAG
	1uoi/DFZGHcJJyUVLmhDM/LexFfgI8umhUPelw=
X-Received: by 2002:a05:6000:2003:b0:482:eabd:642c with SMTP id ffacd0b85a97d-482f797606bmr10365669f8f.1.1787930579286;
        Fri, 28 Aug 2026 08:22:59 -0700 (PDT)
Received: from b315lp23.lnxne.boe ([129.41.47.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab3f16sm4566401f8f.1.2026.08.28.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:22:58 -0700 (PDT)
From: Joseph Cathcart <cathcartj08@gmail.com>
To: kexec@lists.infradead.org,
	linux-s390@vger.kernel.org
Cc: eoin.mcnamara@ibm.com,
	iii@de.ibm.com,
	Joseph Cathcart <cathcartj08@gmail.com>
Subject: [PATCH v1] kexec-tools/s390: Improve initrd memory reservation
Date: Fri, 28 Aug 2026 17:22:56 +0200
Message-ID: <20260828152256.6892-1-cathcartj08@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve memory reservation for initrd. Remove unnecessary initrd
range from memory_ranges[]. Initrd currently falls between
"System RAM" ranges, and is therefore already reserved.

Refactor so that arch_reuse_initrd() is responsible for populating
retained_initrd_base and retained_initrd_size, rather than
get_memory_ranges_s390().

Add die() case for when user uses --reuseinitrd while booting a
crash kernel.

Signed-off-by: Joseph Cathcart <cathcartj08@gmail.com>
---
 kexec/arch/s390/kexec-image.c |  8 ++++++--
 kexec/arch/s390/kexec-s390.c  | 19 ++++++++++---------
 kexec/arch/s390/kexec-s390.h  |  2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index 1a59a32..a9e5442 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -79,7 +79,8 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
 	}
 
 	if (reuse_initrd)
-		die("--reuseinitrd not supported with --kexec-file-syscall. Please use --kexec-syscall\n");
+		die("--reuseinitrd not supported with --kexec-file-syscall. "
+			"Please use --kexec-syscall\n");
 
 	if (ramdisk) {
 		info->initrd_fd = open(ramdisk, O_RDONLY);
@@ -143,6 +144,9 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 	if (ramdisk && reuse_initrd)
 		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
 
+	if (reuse_initrd && (info->kexec_flags & KEXEC_ON_CRASH))
+		die("Can't specify --reuseinitrd while booting a crash kernel\n");
+
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (parse_iomem_single("Crash kernel\n", &crash_base,
 				       &crash_end))
@@ -173,7 +177,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 				  ramdisk_origin, ramdisk_len);
 	} else if (reuse_initrd) {
 		ramdisk_origin = retained_initrd_base;
-		ramdisk_len = retained_initrd_size;
+		ramdisk_len = (off_t)retained_initrd_size;
 	}
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (load_crashdump_segments(info, crash_base, crash_end))
diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index 4e77fc4..fd0d87e 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -26,10 +26,17 @@
 
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 unsigned long long retained_initrd_base, retained_initrd_size;
-unsigned int reuse_initrd = 0;
+unsigned char reuse_initrd;
 
 void arch_reuse_initrd(void)
 {
+	uint64_t start, end;
+
+	if (parse_iomem_single("initrd\n", &start, &end))
+		die("Couldn't find initrd entry in /proc/iomem\n");
+
+	retained_initrd_base = (unsigned long long)start;
+	retained_initrd_size = (unsigned long long)end - retained_initrd_base + 1;
 	reuse_initrd = 1;
 }
 
@@ -158,7 +165,6 @@ int get_memory_ranges_s390(struct memory_range memory_range[], int *ranges,
 {
 	char crash_kernel[] = "Crash kernel\n";
 	char sys_ram[] = "System RAM\n";
-	char kernel_initrd[] = "initrd\n";
 	const char *iomem = proc_iomem();
 	FILE *fp;
 	char line[80];
@@ -182,16 +188,11 @@ int get_memory_ranges_s390(struct memory_range memory_range[], int *ranges,
 		sscanf(line,"%llx-%llx : %n", &start, &end, &cons);
 		str = line+cons;
 		if ((memcmp(str, sys_ram, strlen(sys_ram)) == 0) ||
-			((memcmp(str, kernel_initrd, strlen(kernel_initrd)) == 0) && reuse_initrd) ||
-			((memcmp(str, crash_kernel, strlen(crash_kernel)) == 0) && with_crashk)) {
+		    ((memcmp(str, crash_kernel, strlen(crash_kernel)) == 0) &&
+		     with_crashk)) {
 			memory_range[current_range].start = start;
 			memory_range[current_range].end = end;
 			memory_range[current_range].type = RANGE_RAM;
-			if (memcmp(str, kernel_initrd, strlen(kernel_initrd)) == 0) {
-				retained_initrd_base = start;
-				retained_initrd_size = end - start + 1;
-			}
-
 			current_range++;
 		}
 		else {
diff --git a/kexec/arch/s390/kexec-s390.h b/kexec/arch/s390/kexec-s390.h
index a990739..7e85976 100644
--- a/kexec/arch/s390/kexec-s390.h
+++ b/kexec/arch/s390/kexec-s390.h
@@ -35,6 +35,6 @@ extern int get_memory_ranges_s390(struct memory_range range[], int *ranges,
 				  int with_crashk);
 extern int command_line_add(struct kexec_info *info, const char *str);
 extern unsigned long long retained_initrd_base, retained_initrd_size;
-extern unsigned int reuse_initrd;
+extern unsigned char reuse_initrd;
 
 #endif /* KEXEC_S390_H */
-- 
2.55.0

base commit: 43c5cba85ad23cc69c423527d9587c59b89fa437

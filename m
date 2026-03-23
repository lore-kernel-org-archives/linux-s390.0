Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D43A7F57
	for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269346; cv=none; b=q2YtIMh7kmuq9CV/bk4/3kmwlyiIfYA2U9VbXATYFskMuowZqgfr9VETTCrdci8x4f06izoKrfuxAAKdi8jww9U//TrDrsbRUjVntTY+6FRoI9c2X/P3d2nLja73T0eEboI25o5wMZMfO3T8p2GgeOlGfJXfGykYJrvNyXAfK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269346; c=relaxed/simple;
	bh=/z1jAWc3CVaiCtuoFHewxT/g6Yg7tIbkouJ2QC1CE/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQblbWzTY9Jxewo0cTMc3FVhd8nsTJ/waflozgGHWjqDrIjuICnXXusB90Z3bCJAbvvzV79UBxNiFYkiK/yY2YadhdJt1SmJZgUCmmrOPZTFvTAy9MoAOiSc1iG0cVUNjL0wLJNW0loUDPydz70StEQtaIW5n5Hi9Pzbq5Dn+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TftC9/a3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TftC9/a3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486507134e4so1050905e9.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 05:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269341; x=1774874141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oWv9PdQjKwbFf/ig9F419KVNonKx4G//Z6OQwOa1arE=;
        b=TftC9/a3XCFAiQgBcNZzlbiJJEeew04itxzohG21BiCFevMawkdHo/3p3XrGUp2njG
         fo8nl7e4AEJ7hFeQ+YH2d0cM9ZGW+FItIOS9uDX02yVTkv5AnPyA3Iu/k5Tws2p7HLhY
         HMcwk3EfUaK+3OKmlF3eVCu4lb20voeWPz6Oqbra5fwQ8MavJTOtXwn7TzyLcE+4Qdjq
         HjwvFyjr2erznj4YDynJf8yVLHHXXO8uqoLVAIoBWKyVP4lv7AOzYueUnaUHcE3FVUkT
         GKDG1ZXv8Db/lNA5JhObYVw5UAdwe3GDMNx27OSOygw1SuEOcR/HWf3o8IdFHPQhVPVs
         8Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269341; x=1774874141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWv9PdQjKwbFf/ig9F419KVNonKx4G//Z6OQwOa1arE=;
        b=of7iE3qm+U7M/esEnkH8NMXkCXqotb1kjc5s6vCfn5POM81WGiKRv1KuizlhnKopQ1
         d5kuE7EDoMUscgWZIBb9DmLPz/ueX/wenZk65IN8s3aIZ1JiUWRUp+FK4PUJ1RQcX5Fw
         5IN3iKekDvGM/CVQPrGvZQt+nLdsW8f40a4JNZpCZ/Zwxdi7Kf6dSNyzmZgu0fdx06Y4
         wE2GSxAQXWmqPJxw2coyVk3AW9AQF6KmvLbYAiDNZ6PUk7d0qwFdnAQx1NRc4JuFL1E3
         Z/mupTY7WDu8TwQMkx5NtNs7LEnzW21hki+ADISZSuINSQFuZS5BRPNDNXhpHMVWWtKS
         nybw==
X-Forwarded-Encrypted: i=1; AJvYcCXLLplvRaonts8OikJ9Uw6c1kijNY0HsQmeZCuILAZUlncienAbavZvYDL36batyLvtixS9nWe3uM9B@vger.kernel.org
X-Gm-Message-State: AOJu0YztYimUj+xLpX1YoRPpvRu8FAECktF5HIngbmTHlGY1OU5pwdFy
	mBDBGOJK67yekJVK/5zLm7BJEzBFpPw3Icb+DnsS95E0y5QvaMLmsYJc
X-Gm-Gg: ATEYQzw+iJXCZ8ZSb/wRyZN4xkKNnVU5jMsQ3lrcvgWutObWFLBs8fBdxvcLk7eEQXn
	Jf7FyqsjN0PfnCmFijydUmoqAU7KJoX+E3GTy1DP+LrVRfkBSod2H3r/SPutWSXw9xHRpHxAr78
	qK8nt4TZdQ88kuh28xs2LYeVE3oGhOHROsKVlP0vKzxBcZVbF+mbygKdNpeF4XHOY/nR7N+Nsoj
	c36h2CJlh5dxHtWQ+iM8usLqOY9JVVCukS0saAM+6bmelmAuT2eMusYo/5hPxP+Y0B3kQsJ02Bi
	B84/kej16YTlaJFFj+88UuelBdcinmMVjJSfOhJByuGfYoqXRQSqc/Y69kknVd5hcq5cxLyBgat
	Ay+8l7cZ7U7cFwztT9KldkxPuP3EjT94jzYXfq7B+mahijODeSJZfcmdAETqrhfQBTVMeb2BinT
	j70E04k01KU5Ueu9mG6wJ3fSvoRCbYs/6vgkFM
X-Received: by 2002:a05:600c:8705:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-486feddb25amr182281845e9.13.1774269340892;
        Mon, 23 Mar 2026 05:35:40 -0700 (PDT)
Received: from nixos-office ([92.250.99.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1db3absm77635045e9.36.2026.03.23.05.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:35:40 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: gor@linux.ibm.com,
	hca@linux.ibm.com,
	iii@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] s390: fix dead defaults for S390_MODULES_SANITY_TEST and S390_UNWIND_SELFTEST
Date: Mon, 23 Mar 2026 12:35:36 +0000
Message-ID: <20260323123536.1413732-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These config options currently have unconditional defaults of 'n' from the
def_tristate statement, which shadow the later default of
'KUNIT_ALL_TESTS', causing it to be dead code.

It looks to me like the commit 25d36a85c61b ("s390/test_unwind: convert to KUnit")
added the KUNIT_ALL_TESTS default to S390_UNWIND_SELFTEST, but mistakenly
didn't remove the previous 'n' default.

Then, the later commit 90c5318795ee ("s390/module: test loading modules with a lot of relocations")
copied the Kconfig layout from S390_UNWIND_SELFTEST when adding the
S390_MODULES_SANITY_TEST config option, without noticing the existing mistake.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Fixes: 25d36a85c61b ("s390/test_unwind: convert to KUnit")
Fixes: 90c5318795ee ("s390/module: test loading modules with a lot of relocations")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/s390/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index edc927d9e85a..1b3afe89cb00 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -999,9 +999,8 @@ config S390_MODULES_SANITY_TEST_HELPERS
 menu "Selftests"
 
 config S390_UNWIND_SELFTEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	depends on KUNIT
-	default KUNIT_ALL_TESTS
 	prompt "Test unwind functions"
 	help
 	  This option enables s390 specific stack unwinder testing kernel
@@ -1023,9 +1022,8 @@ config S390_KPROBES_SANITY_TEST
 	  Say N if you are unsure.
 
 config S390_MODULES_SANITY_TEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	depends on KUNIT
-	default KUNIT_ALL_TESTS
 	prompt "Enable s390 specific modules tests"
 	select S390_MODULES_SANITY_TEST_HELPERS
 	help
-- 
2.51.2


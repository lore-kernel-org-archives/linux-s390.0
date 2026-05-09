Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F032720D
	for <linux-s390@vger.kernel.org>; Sat,  9 May 2026 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778356260; cv=none; b=L0YeSUxagV9eaVeJIx4W0iCxKRpFQURTk4Xr8fnYHEcGXenDka2Co5Jh+7bUEbxGaEMfiMNTRQpIPvxn5BaCL33+S/9kFQaD7Th3veDwQCAfPk5d8yZ0sgCROCQfg3QNJUgCo8K+n2J0szmuiiATDFLmUWtS2lrrcj8sSV3GqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778356260; c=relaxed/simple;
	bh=o1EjnzHyZhODTZ415VxWwjtvAsnecvgFKbsv2m0Dmc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWwbXysloSpD4DPaEC7FRPdPTzvOZCkJ0FZyanCBcjzB/szZxFeLt9feDoYnD6x8pyyT5XpWEw0xxgOXRUsohKNSrtRHN5niRew/7a1E1on/rCaj6Aof/dK1geqxCZK5svHbNs+lYtOCGlOMoD3z2xTxHbTTEW00JM2507rqdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehZEBHjJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehZEBHjJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so30304005e9.2
        for <linux-s390@vger.kernel.org>; Sat, 09 May 2026 12:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778356258; x=1778961058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iILYjv1QSXJF3m9JtN3x0yqcia4a4+vFdY5mp7r7BZ4=;
        b=ehZEBHjJ71m0usptJoUjv/FdcwrJiR5wcO1QZztxi71WyyQBSZ4Eqq8fS5nq9rG/pj
         AjvOXLmIkFBDisTUiC0ZG16gaY+8Necyi+k1898HtXYXarbCMBo410egvWrCCveq01Pm
         sFDykKDzblQVp9YuPDFhP3bHmSUzZsOLgLa14YjUE8jYALMRpsKoCbPPRVMgZz/nMidz
         rH68J7x1l2jC4R8hTJ914QFlWPKEpNz4TDF6bkO/azOVRvejAirXR2MBYbtJ1IhYSJyk
         uoYkVm/AUabR7lV8tDjLVgDGaIno4ep/gC4egX7O4IXjGoDM3tF7n8d7MhieIVvNBY0y
         R5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778356258; x=1778961058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iILYjv1QSXJF3m9JtN3x0yqcia4a4+vFdY5mp7r7BZ4=;
        b=YjHQZaT2oDS9YVAnbloAUykEyzo9KeEYD+nPo/dPUmcSX0CiE09/wxPJDrS2kjcnHi
         gePYOBjum7+n7lcb5Lxhv+h6KF47NMeADIOhssRoBHGGn+cVIDYFElBUriCb+rm0iNjc
         dA+BNez9dgAowstR4sLe4A2Z3exEZb9/sc3qvrXt2gJV2yB0sKVSY+zEh0ClC2mnOAMK
         g5XArYC2yb8vy5HNSm9GM5xEmsILsybXDruzc8FA/8I7ZWlLtV8kXQjlMJqRhc9iiHcd
         vivaFyh6+hjqrc8slEOEWeE9aj6N/T8miXyZC3Z3otCc/9Z52VAJO2053xszAlqh4L1Q
         n8mQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LHjEm7d4YFQ3KHZdKeaH92Xko/8UC7Xifv0Y1Gik4jiiIxnKFEv0hTixfsZ421OK0mF49y6p+jI5I@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FkO/rp7VF0xfVGUMHsXiKcr2DPseGrCQQfeQKLhUNIkFA6QH
	U8wUe/mOf8RxM3gv06i6lgbWUF6aU/QB5AiYw+C4c2mDWex0B68qK6ok
X-Gm-Gg: Acq92OENQKAXFQNcRzXtVDmmx0iOnwDbk0O96iNXvHdP2JUg41g8XlOF+UKgmI8RcLB
	i6MHolfDz4vY6a10Xo8ZKyn0LgSgZTzb3EuweHCf2/C9AiUYXemejBlFN0hoDFcljcRHKD7CO9X
	mgD60/4osatR8FrRTopt2vjrjoX/DXNkxv8Cwu0bK7h6riF/bCRIneyOo3CFmwzNNXSGzE62rfP
	dbzKQ03vPQhme8ubYSD/a39kQRO3u+F9GuDryXPVsHQdmwDSqZ5MFILJ46WrgRg21qG4KAOG2hp
	smLb1AQbHwBgTuM/G0P8/aBHcqMlKxWFlwwikwA0/EqnHl3KYxGNxNwgJ7jEED11vaoFRz1bvSo
	aHq7/FbZSi/i2L9xW0Ux1AcJaovtW810fOjPz2wTY8CGMijE16OoGFD3bQcGvsvrCNP/BrI1zAE
	rInCoK2OcNCO6BERV0TH8Slm4sowXRpMxgtxp5YRoerqTUvBMA8aX5ZJ0=
X-Received: by 2002:a05:600c:3e05:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-48e51f2a997mr309114625e9.10.1778356257580;
        Sat, 09 May 2026 12:50:57 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548eb75c29sm13958076f8f.9.2026.05.09.12.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:50:57 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	iii@linux.ibm.com
Cc: meted@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	akpm@linux-foundation.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] s390: fix dead defaults for S390_MODULES_SANITY_TEST and S390_UNWIND_SELFTEST
Date: Sat,  9 May 2026 20:50:43 +0100
Message-ID: <20260509195043.1133169-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
v2: remove Fixes tags
Link to v1: https://lore.kernel.org/all/20260414215651.151228-1-julianbraha@gmail.com/
---
 arch/s390/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..4bd1023a45a3 100644
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
 	depends on KUNIT && m
-	default KUNIT_ALL_TESTS
 	prompt "Enable s390 specific modules tests"
 	select S390_MODULES_SANITY_TEST_HELPERS
 	help
-- 
2.53.0


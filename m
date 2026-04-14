Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A43876AC
	for <linux-s390@vger.kernel.org>; Tue, 14 Apr 2026 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203817; cv=none; b=Ct0W0T7GberuR0Vl/BipbZC0w5wbd59/WAIhdqb9g3/zwnUi7AHi33S+sp9+xNyPtEz1BbIDs82mE1ufYUl+wJpTqf0tWeQbSO79hjiQYeesXXNW1Ahj8AMcpTr0vPhAjvpO8530/Tmre4bShYrwS6BJRPhjfLiDGLCvzch7fAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203817; c=relaxed/simple;
	bh=VjyphYDxJuD6shD9T+iAyy1PPkHnicv+dCgF1sxz6cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXoQvRO2VJU2cGofSVCThs89I0GWyjOowzoDjlw+74Q5Oyp7tFZsDpyraAUYqROacxKqq6JwMHebTlCAgJAriscbcwImj8Y/ofFdRO44+hWxLdHzLeTfONJ4zvFXJ6fUDB0jTYyx9LKiRVrETRx93WkDsqqt/Vrrz+taVkCxrsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+qtOouy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+qtOouy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so42352255e9.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Apr 2026 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776203814; x=1776808614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nKXCo1Zg374mnpyoQ0g0S9cmj+zlNgBNIT4+pAiNf8Q=;
        b=m+qtOouyhESPigFqvRKcpjildvBtZuSSFbRcA/gsZP2DC0D6v83MtJLvM5mDstIg66
         4IIv0clQFB99qU+ZHUbDoca999rm1N8MfJ2Ijzqkj2x/+OfkiO/Ut0tvyiLtM66ufD+G
         YDzM15Aj8BHbJlU3n26y8qtxtIHjt6p50jF/xqqRbqWSimccYAsGtspBsuPo7jtFmOPN
         i+j2syFoeYEKN2PdVGsB+5iMaErsDUYvBweB/CkdVluDhtPviC4icrJq6J2TnYr4my6i
         akvzLQZyZ/SkgFklya0UaFQQgp7Ou+4uewlQgYucvV0kcJuf+PORVm4soAy0lu5wcZPd
         9WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776203814; x=1776808614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKXCo1Zg374mnpyoQ0g0S9cmj+zlNgBNIT4+pAiNf8Q=;
        b=RmJCIG9UProYBxbToELl+G9uuX52TdNRn8N+ZuDTDZE9uhvVgAjE2o/8PfqE8PC8WU
         lyP5GMFYB8CQME8KESUCvqTA2D7PQK8XJSel9FHpkVH1KJYmujMylNSKOZ0jK9NX58Ck
         ckGltTp25HRmih7xcpXncSW66U6GiN4JDKOgUwUPywJKtcf+eXgAM/ye2gXkrncmtDAy
         FjfYGshJ1YQnKfy+2wrQoYxt6UE157B3DbbW9ti336jqxNnX8hZIMJ9J4DYDxMncbWXy
         aqpKg0bQbCQge3jTYoLqQMwvxNzgCWbQqTwXcD4NMmpF1PBJ9u1fI+4UatDYhEcTaNUN
         Q/5g==
X-Forwarded-Encrypted: i=1; AFNElJ89lOM2tqnRFqi+75fEEk8oYugFbuPgn3oL6IQ8OOoatyOrwHtN7rSkxgF22tai6QILe7YtXCaXwemh@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhopAsKYWfERnPxPWGyZVTEoIk/wuRWYPxMQOES3P0CH8R3jj
	zRn5/oV3dfHQpqPQXfO3jMVlBEIWotEHj8+5m4MbKECoMvWXNk8E+0Qz
X-Gm-Gg: AeBDieu+653xtNdyJ2jUNxfgixI4CjgTDpyW0EwHA3fRf7F8j8zUPsNr/GhcHKTcQC3
	ZSUmXOlPoJ0Ja/X9cyNHXWRkqaT+2BaT2weXsaN9ru1niig8Tevw6aBDmQPw7Ti5F8qNTC5UAVh
	tQzKxSs210lHFgOK7TbFvCz1Yn9u+9MVVpzVTS6qduLg7TkU8o/J+eOdSnusH70EGXs1lS9QhgW
	KPDuObJM4FZeIPWCiRIbgnavA+QTnnvEzubxM2WAFRCGYKgDBOxa+akVkZBCNj6dM3ZBmPcisLT
	lEn9FnYqHOIp/LeWGgNEBUSygtOe6qXbA0/ag4E3aLvLqkxGoAYbw+D1h9GyuwG2tVOWAirRVzh
	WoImr1YZn4nH9mmA8tHCrtBgVhUQCiLPsl+0wK7RL+0TPtjRiVECTw1ZRUnYVRQjqVPK/9lKlvv
	gZLK5dYVg+mP4V5vHY+8SB3Wut1XD/whsQQHHxzTYNFBEWp/rzGUHlljSDekHqWSmHXVGqPIvsc
	3Ma
X-Received: by 2002:a05:600c:3150:b0:488:c80c:c236 with SMTP id 5b1f17b1804b1-488d68057f3mr274715815e9.5.1776203814378;
        Tue, 14 Apr 2026 14:56:54 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede2b87asm76424365e9.10.2026.04.14.14.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:56:53 -0700 (PDT)
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
Subject: [RESEND PATCH] s390: fix dead defaults for S390_MODULES_SANITY_TEST and S390_UNWIND_SELFTEST
Date: Tue, 14 Apr 2026 22:56:51 +0100
Message-ID: <20260414215651.151228-1-julianbraha@gmail.com>
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
2.53.0


Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07F388E43
	for <linux-s390@vger.kernel.org>; Tue, 14 Apr 2026 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203930; cv=none; b=d0v93XSjEeY1Em/NX9A1mWncl5XsZ2D4V0iQu/JHZPPu7Sk1GxBIoKpEB1X3IJRJmxdNQ2AsYWuYlAQVNisRB2dvJL0YKUxrmQauSyJQa38NKAqtFKyhD/hzjGKNUrcoivvwH5MAgzZuS8tx/5BpXIFsvdn5MkvdAVeTz74M5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203930; c=relaxed/simple;
	bh=q0hhH5GkfJmDNO08vjk03G4j6nsXbjnOja+38Gs1Ces=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwSbWuacetZqxw6RZQBVOk1/4nGc3xT4grUJMa19hnOnf8vzMzzxljEQSEstSbqMhPc72B0xGhAE/4i+FBGRROOMbKEL4jpYVRpc3dAQAV/NNnFaIQXTHV2zeKG1dePGDBeZqcDyNYDL+suQ8O55I0GBeXfkWM+vEUiKue5m1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czulcol4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czulcol4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso94221995e9.3
        for <linux-s390@vger.kernel.org>; Tue, 14 Apr 2026 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776203928; x=1776808728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0U4FEZLCdjfLS9+QAdR9FfpppShPVKc3lTMwp/OQLN8=;
        b=czulcol4oVUSBNP91Dzl4v7km320Q0Cn4wK++1S0d/9+UagTSwLsWosvnG3KVwtS0v
         E7/GQ8QXvO55iax+XS/3BAlPeLVkKrBUEuSqbEjn5qNWShjUIq1W32zztiHZLxpri+V/
         +kEUBlfwUfZ8lBXKY3AaJSpR1GLOz0Ytp+hutGoGCm1X0LTsN1a8qwLKS48UqxBp8dMf
         2CH4xOA6RpgTU8opkJRatsdftMqEWVrPR1xgHH+Fx+Mc4NSuFWK264CPynoWBjgKAK2l
         8xTknErZz/FW2Ex0XRLPezeULVLjw2nNvptCn/QLAeVgivwvDFc5Jjkpan07h9HuBOf+
         3vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776203928; x=1776808728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0U4FEZLCdjfLS9+QAdR9FfpppShPVKc3lTMwp/OQLN8=;
        b=Mp+DoJiFZt3/gJRU3umIIadrygsHg3Vf56mtCS15iV0t4wb821JdB2UQyp0KZ3s8di
         BKodRHVRBKpm4HLz+mDENebPEL4h/hCJDtuA1axg0U/81lFjyGCVvky8CwX+dgAnJ0rv
         UBIhPaEycmAV/GNeIzKYv7kCcRRhvrtGyriU4UFwqBpQZ3aLLx1uoYRJmiwHD1N0n+It
         WFjXWpe46LABwd3HIhiofwRhi4Kaq9Y5GAW1y9rLgnam9gy2UDBfu4ADcHUXYyPpbvZ8
         DDqrkCF+KljZZL1+7XYJrANnqbNlxnmIfqw1T/I2OtCVpfFQkBt9qS4QkM5qCp2MMctM
         uuyA==
X-Forwarded-Encrypted: i=1; AFNElJ9yNWlBA0BZk7TaKXOR5q5qP3f8Y0mlb/jpPn7F/Z/XNHMPkIaSs0BT/DPuYG4mIqqiZREJBxxucA0p@vger.kernel.org
X-Gm-Message-State: AOJu0YwSU/VGe0wyCUR2xmVfqh5PVduEPmOfWC6raGtU28lAlEBsOeVh
	Tb9MRJ91v59lMGrMa1ogABhyw5TCJ+CyUMQZ2/AInFIHFtUbCbRri7q0yYjXJJkQ8uw=
X-Gm-Gg: AeBDiesCbbRx88K/fzMZvqny+t/hFnWfURyGPCtW7Z4b1AMwqNB6WCXxisK0gattrVa
	JXRSJpVsH672CYo+56qRGCN3T+awQakK+S0O98xCrxl1mpXGvW15oreKB0nMMEzEpInn+7LU+w3
	2/T0mdDlgjKlyZmqTkEMZTQwqt7R/Sfw/UNPBsOV7I+i0ze7eejFCxRXw7OGPJ6lLfH38y+URJI
	nKfqWvF3cB6J4S2A7Qrg+qm+vVle40PTXADRblv7gGMidT3O8ngh5oOjrS5tqKXFB9h0II4sljZ
	fCB5qFIk4/K7m/DzI5R12u4d5EBloxQmalbnOipgf5pHx5lnjPYX8d9VmOEtaZY+n4uYywVbfWH
	+7l1tTGFc2zomyBP/MGkY+fvg1Cw/m6G6TjMma/+j/G85L+pd73G2ZuHzXiDUdIRpZceh9YRk2r
	cRzukc48PGR+7MUNuLqRaz7rmH3clACgtX2rgpEjWVgjqVhOz5njmkx2s8dBPJiow+wg==
X-Received: by 2002:a05:600c:3b24:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-488d6872ed0mr267689925e9.25.1776203927527;
        Tue, 14 Apr 2026 14:58:47 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e826sm156454085e9.6.2026.04.14.14.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:58:47 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	iii@linux.ibm.com
Cc: meted@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [RESEND PATCH] s390: include S390_KPROBES_SANITY_TEST with KUNIT_ALL_TESTS
Date: Tue, 14 Apr 2026 22:58:38 +0100
Message-ID: <20260414215838.151689-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on similar config options (S390_MODULES_SANITY_TEST and
S390_UNWIND_SELFTEST), I think S390_KPROBES_SANITY_TEST should be included
with KUNIT_ALL_TESTS.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/s390/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 1b3afe89cb00..0d456d0c50e8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -1010,7 +1010,7 @@ config S390_UNWIND_SELFTEST
 	  Say N if you are unsure.
 
 config S390_KPROBES_SANITY_TEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	prompt "Enable s390 specific kprobes tests"
 	depends on KPROBES
 	depends on KUNIT
-- 
2.53.0


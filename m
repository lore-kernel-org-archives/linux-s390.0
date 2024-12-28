Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD00198A11;
	Sat, 28 Dec 2024 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411814; cv=none; b=bpj/Aoz6IMTvu4QdVj417hhjI5MjGVzz4lygx3HtLWcLT1fxhFP2OPyiYnX/lHDo3fgCLF7MTVuqMCKMErOZR2A4saSXA3+UtPKmYMwdEQ7xZeZ7fYnj1Zsp0e+hqfBzIEPMBznKVe9fMu1qALHGjuar38tVyKc8cVminY9el6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411814; c=relaxed/simple;
	bh=yMRokBhP5H9OnrWHlTrwNrH37XaeTKVZOm1a1AkboLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3i2scVtSp2PGa1Gr0FMP3SsygBHyVDUPOVvASUbaEOhOWAv3ykFgrZ+DXMQ+1WxMeDcOQtKtOSr+qH/gp8ioq8TjfQW/cKoAAlrJSCgdbk8emAUaJvUBzs8Fiy7quq+9rQyu+39QoXuLiIwH0S2tIqLC/jB+2iSMbtZHIfeyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFq7LJLG; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFq7LJLG"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so7767494276.2;
        Sat, 28 Dec 2024 10:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411811; x=1736016611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUFKYgpgMmlqbxBNoSqa7nmpKlvvBTB3tfvr1dpYSeQ=;
        b=KFq7LJLGwlK8YiJoXgRBelOVZZTnyvY2nytry0uZxSAR+MUgsbe3KfgeINbcdcgiXe
         5fkacVSUPxMaoDxGqqYwFAwgXUPSnD2NG0ZY+SZIMIGxiE4VqfSUBhUQf/k6TfZXJEZX
         4nE4cblpbuO0F8I/tc1P0GWgOfyqk8vQqpNP13iC2vczJ8CZGBe9qXETwvDqBFgdy7Qg
         uWujZaLjhojfTvSc91RHwlFxesJIfCtZ4Z8xpxo8WnICe7P6dcBRH2L2lvIHiaKoNc0B
         LD3JN6AmMHuAzBhpNq6Jsy5pi1JOUBd3bhklqKaeyPDuA7QraIHRHaqQ4+9Igdg9dmQm
         mH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411811; x=1736016611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUFKYgpgMmlqbxBNoSqa7nmpKlvvBTB3tfvr1dpYSeQ=;
        b=lrDLKbs4oqs1gZ0kvyPVwQlw8eY09T0CBlSj5DOObzNio/ScfOCIl+okvn1iS0NHmR
         Pg+OTdqRCaXXxSVsb9iQsaHS7M+fUzdz8wsPrHj5ywszFWCwIDRBWvqBCbDbl+NRvVdZ
         5A64/xMr3y+JiDRWlqKiaVJSnowN0pmmNhNsMPhrfKImIkbEnmvzqgqyGGkufIBW+wxg
         xKVpSwdMSCUI9p+9phb/RbCLkyVqLpBPobzOdr10tfz/4dTQe4qtC5/uPA0MmooM1ZnM
         9UxvALUBba4rpKIxJo7Z9Zq2Np2sQel9J7uGXfsesmZeB4r+Nm373iWK19zeaJpk3AdC
         /VHA==
X-Forwarded-Encrypted: i=1; AJvYcCX0k0RNLSWbTVVCAzQdlSmyiJPpQE+AepFqO+qJYk01yy4RTp2BcMEnHRq+lwxYQNgKuP++n7hTgfT3@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIGHeVN+2nnP9WatP6FUI9jtbYi4t2pMDw0BtZpSNcOxQspob
	gY2PDYbAEqsUvHyTfe86N9TGdIhB/lSIRe+SL4cuv+rca/LsJVqQlFnh0+CG
X-Gm-Gg: ASbGncv5o9BiBypxlfs8SFRWzI9WYFbCuz42GzuauuUirt1qI2fPqsG9VZDr92JBrRY
	3cARkQGHuqR1bxCpkFd6a1FHVQIEhPH8K1PxeI48vnKkQzrqy/z/IRGJaXHX0VlLd071zEXaWaS
	iyzaJoAecD82e9W+/EA1Ss2d1egZxL6k5THHg7gAgqX5Nc/xfJc2hK3aPtOqQSQHFpfFP5uB091
	L5HX23ImYRmr+wzAS/0wY+icVFv1KKXMFfuYfIJMZ18HUiTTXQNlZf+4iWojotLjwQwfiyzXnnh
	Eb+oUNkkEdd/iQwm
X-Google-Smtp-Source: AGHT+IGTNaVqC/daoVMVBtzDeK7oD1Vqtlp2wRGbrLq1WFGPzMvhTK30Z5nK9/LGFmnrqe2God+k4Q==
X-Received: by 2002:a05:690c:4986:b0:6ef:6107:69b9 with SMTP id 00721157ae682-6f3f80de66bmr240481937b3.7.1735411811562;
        Sat, 28 Dec 2024 10:50:11 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f484ea9ce7sm3024807b3.92.2024.12.28.10.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:50:10 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 09/14] s390: switch stop_machine_yield() to using cpumask_next_wrap()
Date: Sat, 28 Dec 2024 10:49:41 -0800
Message-ID: <20241228184949.31582-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228184949.31582-1-yury.norov@gmail.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling cpumask_next_wrap_old() with starting CPU equal to wrapping CPU
effectively means the request to find next CPU, wrapping around if needed.

cpumask_next_wrap() is the proper replacement for that.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/s390/kernel/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 42ca61909030..745649ad9779 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -72,7 +72,7 @@ void notrace stop_machine_yield(const struct cpumask *cpumask)
 	this_cpu = smp_processor_id();
 	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
 		__this_cpu_write(cpu_relax_retry, 0);
-		cpu = cpumask_next_wrap_old(this_cpu, cpumask, this_cpu, false);
+		cpu = cpumask_next_wrap(this_cpu, cpumask);
 		if (cpu >= nr_cpu_ids)
 			return;
 		if (arch_vcpu_is_preempted(cpu))
-- 
2.43.0


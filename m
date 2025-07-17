Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA852F8C47;
	Thu, 17 Jul 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762481; cv=none; b=fPfaYR1cRS9WZK4P7lUCKMRZMK3Kg3Tgqula499HwbX3/HB1qeyTmlt52z8bo9FSjNd5YrvZTzVHopKT5kgS3YCG/ey/h33S5zuIeH6F0akzTknRCdZQvb00l+IenP/o+n3qPzGldneXwq9yEE+ozGz7slBDu5jvVFseT1g8lOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762481; c=relaxed/simple;
	bh=13fOJSUT1Czga1bfp1m5xo8KIEdG5XIY1TAjVaD1C0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qLuE9wKg2ZSDm4Xl5eS/YvO6PPTsme8nubsa5UPlytUW4OK4nIi7S1Nevpi7gdihcA7zLJCO/SHFGAJmz2Tf7UZ7R/zO3d9ZqCmmrT1kGCvWSJpvYAUDXARIBIzQnOV3TnvmCgs+EHxf+FIwkdSfOjzkrq8B948hv/9c1KCAtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ5bTWAw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ5bTWAw"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55622414cf4so908989e87.3;
        Thu, 17 Jul 2025 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762478; x=1753367278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj0938MKzJL3dLX2pSfruVoI7qA5XRt5dsqIl4I0tCY=;
        b=hJ5bTWAwXBgDIMBeSlFEbVfyL7KOV5oMnrsiVShE04vygdTx8CePFgbV7QooJg3zNa
         Tj0cQ1oC8FydJG1wh1WIAj4XwHXpcKg8j8Zj5LONMf27oXSs4vBgsanmHGfga4axdRo/
         Tu5QpZrsFJktcuY01ZmHyLi+VOL3QqyvTj9stfYP1ukRo8VRIutECiIL/3368zfOb6UX
         ltLh8n/QpvqpuNqKromXzwNznr9n5Dz+jZlMTIbT11aKlpQZTWJ2bpb4Fy4jJvQteuEl
         GYzCAcUn3VjzvA/ojR8UnuqloydATqn3mk0LaVoVRLg1+NtldAB3MM6DG2j+PKufwgFo
         FyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762478; x=1753367278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj0938MKzJL3dLX2pSfruVoI7qA5XRt5dsqIl4I0tCY=;
        b=HdXi2Omhvl/2WuKogJp29YhrMunv+Yp9K1h/6VEVu7XdvRhkcqE7gTjtE5L6eJuNF8
         lCCk1LKihCOQQI2ZsQroUHxLxA+BIyG0dTrUGr3MbmIjvgLQJ4HhtomGu+0s5f9dZutE
         mTrqr9ywKdWf34qkAo/659zowk7QVaq1n70v/l2Ju3xKhemB16Y7JLYXY7eh2O/bWvd2
         sKvBLSnjVLLS/uryPE+fsYUb5T/rle5C/4k2+XWAtgi3da1gCvC26BE+70B4ZubEbJvh
         b0lGE4XtfVENsjibMT9t62l4LHa1FPmQeWUulEUeShgj5/BhY92JWsyiOQM0QbV7XmT9
         7FUg==
X-Forwarded-Encrypted: i=1; AJvYcCUAmZv3ubm/ReckkLcxYwL3wLHyzQIJp8thamjbg+GPyc7iLf2AFk2pd5y9EJ2ryIsbfZIdVA4HDMf4OQ==@vger.kernel.org, AJvYcCVpWnGfnmw2sm7CWcks+O0yw3c72tmZt+buB2JF82v5nfHsgyjKgBHs0wY6iOwrKBtrRMNLBTpXh543fQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7s3D+Nk/23ZuN4WHG2jPAuyiOpoh1ydxEk3gebbtBi9Gbr3G
	hDGbqj2/rXVXjZGEUwWmq3af5jq9OF2PrlKtt0gyqRP8RNrOBXKWcYQ0
X-Gm-Gg: ASbGnctLe7nUwXnly44370VSv36q3NpRdaqKFIfN4CRpSFFJL7ibUlrV6gS5Vn4JZiz
	4xWrW/3NvBHDwsZ6gh34GSu8haJgKwuwEQO4e3N3dJJr0pD0bta5QDLbheKjRI1kQXNIWOx4k6y
	IqX0V9vAyn5XWj77Cd6jekUzghkRKARWTLceMzScNVVi/AusxUhv1dGpMv+76dAsusZmIVyll+g
	xbxCRRU/iuc9IZ2NsseH8o+nMeIodHgv7e8QKWa4paGggSnSaUVIoHaIUHAOnMVhir6fdKukFa/
	iAcB7tl1MJYNrOuOcDxKsW1gB1YdwQ1KGJ2ztog/nzTgmgScSWb0khntpHP/lQDe6Fa8rghr6UC
	MY0TvKhI9UgDhRBKZaIRbJRaKKDkgbHCKacvwdyS0eXh33reIyEW5yM8rx96zyj9KQZ7Hz79mSO
	WYOAk=
X-Google-Smtp-Source: AGHT+IEgw9d3ZuJ+QMY1MR2nr/3qOXMGIgWnHA/W5FJZ5VigpFpebSW6/CzlCrWt32sYjXVTTwrchg==
X-Received: by 2002:a05:6512:360e:b0:553:d12c:fef7 with SMTP id 2adb3069b0e04-55a233137ecmr2448163e87.14.1752762477204;
        Thu, 17 Jul 2025 07:27:57 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:56 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v3 05/12] kasan/arm: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:25 +0500
Message-Id: <20250717142732.292822-6-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call kasan_init_generic() which handles Generic KASAN initialization
and prints the banner. Since arm doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, but kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/arm/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 111d4f70313..c6625e808bf 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -300,6 +300,6 @@ void __init kasan_init(void)
 	local_flush_tlb_all();
 
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
-	pr_info("Kernel address sanitizer initialized\n");
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 }
-- 
2.34.1


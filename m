Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728B2877F8;
	Wed, 25 Jun 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845220; cv=none; b=YrWx11fNOTmv5ixXPWmXinj5GB1XMitTduxo98jS9Wu5POUZU95Q/lfuF7Iu8m8+oh4G/KBq/4Jo6CXVaEH+MwfICyY8TuwfEc6isCTmWYCGZHWWsjvO6CNq7LR2dAQW7bPw6xPYN7rl02vZrBbnRoS7m/mQXM4HJb7y/MXlvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845220; c=relaxed/simple;
	bh=9TRhdQ972K330SQZmWrhzPzVpDmeg4Vy1yztZoga44U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPn/VzhqvxoUSAlYU0z/PtIHfrsd/A1NnlkmqSZzCEHYgHwR6vKYg9cITHOYLUO8UheCAqFfCd5zhyRgjqBd/UfhnL6wDLit6+MHocnyXyOEXnboW4caxUFLH62nktzq10eZtRdXDD45RtRYbOSCiuhZiIKd1PgvBwJt/nPhNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jprfp27f; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jprfp27f"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so65438521fa.1;
        Wed, 25 Jun 2025 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845214; x=1751450014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEyx1UFRvpVo+G4N42POvQdsD1hWzSpAcJ0U0Tlc1dQ=;
        b=Jprfp27fzlQQT7CxVTX+Od8aXOtzPsyzUnDT8NtfibwdVJ704rr6nflSkeizla1+fJ
         /Atj9QQ+AePV403dtsztyiyenRxawn0vcggHFpvoDsKNBUMByVAk/7oE674M22+looRV
         c9z0F060eOWrcPIQzajNtZGQ7vSU0EWKNw0m1UwPUnM8p5VSyixwbia+UQHLRTuC+t1m
         hUuDA9nZ891C2a5SadY7gWMxE+LFeQ4UG6Of+51YCDWDORYYmhjA9Ufbjupu/y2BHiNe
         vHT6xo2y+jRI+bi0I6mBAewDL6uXicOh45fW1dCHHxZTA+zuIC1iZxl6dBXaLya+g7ze
         EFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845214; x=1751450014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEyx1UFRvpVo+G4N42POvQdsD1hWzSpAcJ0U0Tlc1dQ=;
        b=lmwl6pXA8OEmXVK2A5JUVjbofgxfC13XPzA39byhyvcsHq8v7O9/I6atwXvRGcUPD8
         iEJWhnhqzz3F2QjtiTcJfLqQMCxENMNo/9BWfd+g433dkvAhZq45/Jcmf05HWn1EMZsV
         OEz5g59xyicqx1cAFFSeiFogqwYwqbAwOXemKH6fAK0pQMYRWn7FW5/5xX4GVxUPaPi0
         n9m15gmEt2UR9HFrW93iQvHKdqluW14IsuJJzPvA/p4APKDEbuChb8ZBhpwa0nVotJfd
         KriAXgBjvIYlAm3rUHonskeZHGjhNjJMAgOoA7woCJASLUbjD0y4js2CLlsZNLxwWsJD
         46dA==
X-Forwarded-Encrypted: i=1; AJvYcCWjxQo5W+ifcaSjKMu8Z7SRtNoNCRkAnTXEcKexw8pf8rikD/YnWmDk2R5Dr4vINO1G5l8/bHKqLDwovO4=@vger.kernel.org, AJvYcCXNSsUby5IcUtsREV1RTiba45UwvVHnqSHf2XytpCi+Z40oYjEpZr6/EpxpcKZPI8Xik3fX/5J8oGBMLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjz3oICco50rAqU+BpRqeGQnl2FQ6eN52RGk3PSenchDPt99kA
	Lt3DQRQ1yMyjYZyCZYPG8bQBVCVwPq4UD62Rns88bt+ksk28Bet3+Ye0
X-Gm-Gg: ASbGncvVi4QEmdy/7SXs+1zybuFECBnJZXd8izkZ/o0moYWVsrdQIKX4K7sYC0KlC54
	XHPVK5x3H8Co0x7BNqx8q5kvmd371oN48eeHL54lpzOVxtqO6JDUBixLuMDNjyGMTjUY6+TZZ84
	wPZEXpJpPgFLERlOUHhVO5bMHsCPuLkMBDIkz7+7h6XevtDmDoocoopY9XbeLd02n+CVIfklXuS
	ngoKm4T6rbGyfXZO+x6Otv7K5Q9dNkz12YsY+PPBF1P7Cuvb7rTxQQDU2Q099l5wqkeZTnBwWMj
	0TYR3CU8MMhsVTqUWgoVevnjMugWPB6vzJMNB4pBkmzcCJl1Rzk3Jq7cfja4DIYd0OEduv2o6gx
	/T4rgAOgBmhhu/rF/UBCfJ8DoICttmg==
X-Google-Smtp-Source: AGHT+IEcjLY1beu9wht7welDNsEE9aAi3GLekIAB8d1qrA4KC0EwxtCdVmkKJY06lTM1Yl9RfqTm0Q==
X-Received: by 2002:a05:651c:514:b0:32b:3c94:992d with SMTP id 38308e7fff4ca-32cc65755dbmr8009981fa.28.1750845213516;
        Wed, 25 Jun 2025 02:53:33 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:33 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com,
	geert@linux-m68k.org,
	rppt@kernel.org,
	tiwei.btw@antgroup.com,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH 8/9] kasan/s390: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:23 +0500
Message-Id: <20250625095224.118679-9-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call kasan_init_generic() which enables the static flag
to mark generic KASAN initialized, otherwise it's an inline stub.
Also prints the banner from the single place.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/s390/kernel/early.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 54cf0923050..da7a13d9ab7 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -65,7 +65,7 @@ static void __init kasan_early_init(void)
 {
 #ifdef CONFIG_KASAN
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 #endif
 }
 
-- 
2.34.1


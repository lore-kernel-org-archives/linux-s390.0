Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B0E2ECD33;
	Thu, 26 Jun 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951947; cv=none; b=aRyKre2TgpqF+vYZCrZmFWOrRsOhbZHVYPWeMABIPlIagmvs87q2xsOQ7i5Z10XusBGonQ4/cHGahocBIC0gQbr19uTMHdUoEzdtI2XkDFqToBddeN3rUO4NNVC1YmNWx3JyMQVBuoehayLVU8vk65wMW+c8U5OMpTXWk/v8oqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951947; c=relaxed/simple;
	bh=ghsO1F/BwKrN4WXjqdGwBv2veuOHZXcs2WsT9+fKO3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RmYowaTSl4Uc/RgrHTsC60n/243/I2CYnBFgCSLSfvjQAqOHxuWYfsHlUm9OR2JxBQc2Zq0lGUZR2AAYzRsjY0xFXqclYGqb8QJNGEyrb+VqJYghFgXQFWPW33OZNAE65zXwk2t5d2i+7Xvgyw2kGYdbtFcAkE7QVC3YAO+IWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g81jpyJg; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g81jpyJg"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b553e33e6so10275891fa.2;
        Thu, 26 Jun 2025 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951943; x=1751556743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCoYbCl3wZIeXCSyY3ZNY+HzBteHxI7NOqzCSDqwFag=;
        b=g81jpyJgPzEqCiI7nUNEVRN2CT9d5w7kq5aXyLm3O4qhPnumR2qkRd9AAYyl6Cre+G
         xNGYdN/u8t84RQQhY3jcGfcCUMB8yUKKBVJZmUtNS2Ul7kva8iMGA+AN3hTqjzN2BXs4
         ftJyhRINgNVVGUTNbwJtmXlKgAPSJ1+smqvut89BHs9FHTX/2ZJ19R1YzOhDX42e1xTE
         pM0paahXYvBhIs3DCTUjwp16KHgadtGQlN0sTNLRKYpFj3sCbSIbNTXO7TN6QK9VcnP5
         3u5v7P4HdckUwhJPTxPDFgSSx7SO8d+NYR/fF7J8CL+1YQBXDu3pWlJMpKa21UpvStFo
         uA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951943; x=1751556743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCoYbCl3wZIeXCSyY3ZNY+HzBteHxI7NOqzCSDqwFag=;
        b=vBz0BWtpqyhkPl9wTvBHJD0Wj1eIDjD8ijFsiXscN+cXZJdewqyTgi+NYqPSsC9l9+
         yHNWWhjKioZFr9q6R6eNLiC2pyk3WUYeblA3MOLyt7l2mntw9VSUMLecooxS16GQHmZ6
         wYT2IgZ54U+N6GhhXH42oBWsIbs690nS3cOUKCEvudpX4vsFWbeLS0UVL1xAI+fNfURG
         rx4nrEApseQ5twlFEIfTRAZgK4utGpwASlCJAej7siXnHbA/PVOtEnRTR1dEQWpPQ+LS
         UntwjwixNw0FbhxhGRVuO7S00WJenhxiH+44wMNveIOqa0gDj83WBAqV9z1ynRkBye6p
         Hc7w==
X-Forwarded-Encrypted: i=1; AJvYcCWaPQT1DU9uezQMUjefHcGu9fXo5lmTGH80xbAePTlge4p+mhtGxSZFvu4a5AgACFInrEkdOx51VPzb2Ns=@vger.kernel.org, AJvYcCXEZ4ps0WL96J9PgcDiYsSQqL5buVxsxwPQ6k87R/6qWRW/B1NfRbC4CZDymEO3Ifokz1t6i6hUalRAiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXyuMlMzkxV1s5DZfyv+y3lJHmM5IqHYAD4AK8xK9t3V32IFDe
	jJJib1iE+Zj5ABQ6+AsTvHUKJ7tsYcd2R4sBEMHVpYIepzCJQKAIUc1Q
X-Gm-Gg: ASbGncubTDADMkQe4NWitB2WRK/yHe08BlQhO5hG0YaVcm/b3mIXBqmHxIlNjYO7EIX
	qzNJGjrtVdEgPGYi3iJl1kCvsDrL5sV0Ko7vbrNOicKAB8+Qpr4qRpXRkL3Rp7o02cyNe0hs23v
	Jx8HzwtlZHhtFGGDl/rAOD8Z5eqhH9vhDa19U8KxErF7GsQmhD3hkvkwMJls7MgVvvr50sNaCu1
	1Yu/HJihgJgmyBbuDvp73+zyT/ttiT6obI/Un0N7zgX3f240BEs5x0HBFgEXm9nwPKDlsKJlKBN
	UF+2kdRDdkyI0doVQ3khD49NZ/LqOFtg3KugKFqMUKC9lA/vUPLQ3O7XMHmK35BDz6e5JkQXQCb
	foyZirjooduE/kiyW/mIY0gskhjOx4pcS1lBYiaYO
X-Google-Smtp-Source: AGHT+IEkjyG404mf0WVWC0akoOQBzKpFWvtutC6can+yvjxVSyNvAZo7Oo5uRf5TEFNgUYRmuuUuuA==
X-Received: by 2002:a05:6512:3da2:b0:553:26a7:70ec with SMTP id 2adb3069b0e04-5550b79db9cmr1980e87.0.1750951943188;
        Thu, 26 Jun 2025 08:32:23 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:22 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
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
	akpm@linux-foundation.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: arnd@arndb.de,
	rppt@kernel.org,
	geert@linux-m68k.org,
	mcgrof@kernel.org,
	guoweikang.kernel@gmail.com,
	tiwei.btw@antgroup.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	snovitoll@gmail.com
Subject: [PATCH v2 03/11] kasan/arm: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:39 +0500
Message-Id: <20250626153147.145312-4-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call kasan_init_generic() which enables the static flag to mark KASAN
initialized in CONFIG_KASAN_GENERIC mode, otherwise it's an inline stub.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
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


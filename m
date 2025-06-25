Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EC204C1A;
	Wed, 25 Jun 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845193; cv=none; b=q966ukwjLsxZa4RUkJlPRDMMyc1hTNQU290WanB2olSRX9QWNYiimRgpuQbbo0WRdXd3I/LUrr7JrPFVV1bukGZKvRipNKJFqgHGG5n4tR7jPue+GMIngFMeRpW9S6yABj7ZS/uquiAwKBXFnUauW7/CTilyhaPP7MFU6u/e3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845193; c=relaxed/simple;
	bh=zq/W/p2aekVSufwziK4dkt9mQbwxASXZ/X4u9Ay/wd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8ZE5YFOrxXYbUR8dXJsmP+F2wRF60JAETs05YKPwC0LPQixoosjpMhJTtZvMOH1Oi/6oNRkL2L8H6KWCblQ6/9uuh9jB0ysmI4gvb2vAQc0DjMGG30AlNUDtI72G4pDzFZ3xqnxmiG2819V/61y3pxqndVPZQn8mtXp09BOTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leuT0pnk; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leuT0pnk"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32addf54a00so50566421fa.1;
        Wed, 25 Jun 2025 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845190; x=1751449990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQiI3pji6r3skZCyeT+2q6FDZmdcyPERVGy1ENHzh48=;
        b=leuT0pnk8FneFMyWYyrss8YH98jRjYN7SrEViGNawLfrJYrsjDGhVCdmZPxqLJvx7N
         eNu6B2MYNPe9IkTz0ExLXWoD8n+Gjo3XOrLskxPc5iZegGomLtpplV3fpvFU0acSoqU/
         I9WQoCUBD0g+kkB0A7VW0l0uMV2iMGNT5KMn/tPuH3ZXrym5MEz36Mf0IELN3+4vWkQl
         8JSVPCo5MUT48u3aANtOH3ObTkdZg1PMomd7fdG3yj5WyzZU57nk/3n2nE/Ud+5zuEY6
         xQhgasSAtENwQProz07KgJrSYs1sYikRhn6btvu2xX/yoa0oAUqYEnns5BOuCHe8jV/T
         P5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845190; x=1751449990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQiI3pji6r3skZCyeT+2q6FDZmdcyPERVGy1ENHzh48=;
        b=GgEVqZTMmSD+Ccq4sR5zPcIboEmyncXYzXVFYlHOgJu0j/S/5hQ/u43t2ro/U8CQ3/
         Q1J7qklQnzG+RcBXdk3aMvxyMpMASEX2j6eCIFUk3ajvYVIyeuGyVTSM5xHaOZl3DsVn
         /m6k47H9NnyYgq9vOq29iMh6/T8WwtgUwmugkeujSFB0uNS9xYWDzLv0/G1R5YpZBb76
         V48gngNWmmfmc96Y8v/DibOiZrG6ajVNyq5NvaM+WQ7Tb1vMAN9ah1N7BqftMA8L37ZO
         M8Qm400oOas0zsR54Il4n6siQ0Jj5Nbw/U9ix+AEVS24amR/9/ACQS0vaAFVvj7/FNBS
         g/Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUpFNhbijJfAKGYSXyrb1aa8WA68hEdm0W98K37T0aXUrCUrFgd6wl5tOPAa4EPAK9bQWTgcSXqGoEUXw==@vger.kernel.org, AJvYcCUx1hKoNW9Q6wcgU63ZH70BM67s+XF4tCKP1jv71LpCUsNAyT5K5Vez/JBz4yju5sZQa1mGn0xGYtYPkyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZ2Z4MFV/5QAuy7zDXhisaG3sFX8P5xAGyTmjkzN/xZzN3lKc
	Yu6327uOr2HjszgCvWIux2ZBCBpuyBeQa1akb8dW7GGVhbwyd5EQeZiY
X-Gm-Gg: ASbGncv37SCkfKh8oQujfrSaaFrxhARe082Geu3tMqZI0TQQ/GK5YX1RaafZPILflYt
	sirKoTmgXMG4e7FwQUf9cET/hdjmxElA8JIjVzC9EPIINRhSpu8hymuFRwcuI+weSKc2QyUbRrr
	JtBth897SKY8u6Mnp2e1kH55smH7W7V/lZ6s8CxXrGTPF/JU13+q9nMau84E2fkaKOJKmzH/Dok
	sG2Dl2QLmJTIOz8yuglxPoIv1Apnkqufu7v1MDg/wEhcR+/Ax8qtayKjXrx0kui6EX/lOXA3PC/
	5y+2Lo8I/fnQoKnWJt7Re8FsvDhySCISlhtpxQuFI1rZ6RDyLnpomaL8QvOQPioXIFnRDsTgNAI
	upFkjYPnSyS2hkFktr7Wg380EZYai3MzMONS5utam
X-Google-Smtp-Source: AGHT+IEfK1Xq7ZnXyT0Os2Uk+Tl7A2yRnzkJG2IvrwiF+G9b2Q8GisEMs1F3MxkK27tqhocl20BnLg==
X-Received: by 2002:a2e:a54d:0:b0:32a:7270:5c29 with SMTP id 38308e7fff4ca-32cc6421a2bmr9358961fa.2.1750845189565;
        Wed, 25 Jun 2025 02:53:09 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:09 -0700 (PDT)
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
Subject: [PATCH 4/9] kasan/xtensa: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:19 +0500
Message-Id: <20250625095224.118679-5-snovitoll@gmail.com>
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

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/xtensa/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index f39c4d83173..0524b9ed5e6 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -94,5 +94,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages. */
 	current->kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
-- 
2.34.1


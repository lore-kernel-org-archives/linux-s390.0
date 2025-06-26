Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F02EA48F;
	Thu, 26 Jun 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951953; cv=none; b=tUTczGhAcG+pC7LPHLZM5BNec6OuBa+EHuFmdhifUeTfyqOtetcqKkLaNylsd8j0obg+4IqJmM3VZGYCZnd4TrCAxd4JORW4R+iUOc7rN6u1N4hGL0vyngJJjNVTFXeuCmCR3Qu2dNMmn6/9RV94v8z9GysDrDaBIpl3LWwR/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951953; c=relaxed/simple;
	bh=saCtcS6Cr0jusyPkwN8sq8hOZ3afQESk56CskNDvtIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kEg5+ECMxap9c2Oh1FSYPx5H02rfCgnYPTHeN+CpHi6tuXHtj7fNPnXAG1fzPFbTY+/I6Fg3e6rrhlR2BhwRqwdnd4in3lhtRT4MBnQCOQWSJIhjKeMmCwTNlyBA4egylZV+lElzwPxXbm60lASUnXd1hL5snyLUbmz6xYub4VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHTlI4GU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHTlI4GU"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553bcf41440so1196399e87.3;
        Thu, 26 Jun 2025 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951950; x=1751556750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nxtugr6OI+iAiBoQ5DVdScoZ4wigsSWWp7UsuEUnh5g=;
        b=DHTlI4GUcmkweCzSuhh8bwylnfXsH88b/zJM8FDkV7OOEXMER97sJbc4Ug5v8oepxR
         AwjXM6CcwlHCyf0aFlibejjQmalkSs8DWhSLCLfUf+hGBe9DjRk6MWD6yrdJ+JolMkQm
         ZAJdAvXp6XfuqLZtSx1ohCed+u+X7QKyfwzOkOLIlHyxSvgW9WpkIedcd/WXoDnQtyvt
         0fj7yuIfPkAkNrqfirgzPs9KuyS8rIQg3rU1HAf9uNGaD0f3oD9vzfB0IvsPET++Qyfa
         vTUaD30MyunV4gzcgxgVfVr7FxaKnq9lVlnVsxE40ZzukjqMDyf9yMJuhevCSi5hjKSN
         MF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951950; x=1751556750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nxtugr6OI+iAiBoQ5DVdScoZ4wigsSWWp7UsuEUnh5g=;
        b=jK3PlTrQym786Z1xCyYujf4Kovk9RdTzOqmsMFyyCM+nje9nGhoQ9kJDEfZdKBm9WH
         sOmLma8+2atDxbAtybpuboRL+NOJC/kVtJ1uhee7iB2t6p5MSoupT3rfj3IS8DsdcYXV
         L3a4GDHFKZ4nE2pWoTJa7SwFqVq0bZEOBBs884zSalxiqSpHvhhh15/KjvgH7NvGWHgc
         KtB5gKMU7GG7a00ixUIkgN6Bb0/g54L2qmyfzH0qEbtFJCyw5Dcw0SOGsRaYp4/Is3zc
         Czti68YlC7wpWyOCJzqeP+oyuby/L7TUVxZeCCXssTc7TaEOKGVISKgDRIylF8JmOaJ+
         leCA==
X-Forwarded-Encrypted: i=1; AJvYcCUubbcxj9l2pwCy8pAHWGTBo2nvBDuzNjxO7YTt0BTxHUasbbBD31Tz04GaIvGIfAs63kqewfmEzD5FmKo=@vger.kernel.org, AJvYcCV9Jve6MXshoZbT8corwwHtiZsrLNppAit608NvOIgXKQWnGTAtT+1UT7R97SR9TqtGQQEYt6ENNuTyOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YySkR4sMYJNbb3pqX8bJbGlJ8J00iygfV2DEr6kwbsuwLbCVsu2
	2h+3CiGt6LJuVVZTmA9y4V94nmsoDUUoDxB1r6HHx9bq43C3eThIx0ZQ
X-Gm-Gg: ASbGncuh5b5JuKQWzejx11c23PHEiLneXoBXXHGnwszhFGbmH5NZNBMWsJwG87Q81HO
	tot63X0BD8JcsD+8+Ti0Uc4I8fI4qF8xfu+SRbYC21eWjZfmAPKjD004UPo7YwbwHnLm1h2QeJH
	WWIJNhjCzqtxAKciWKz97Mp2eJyJcDW3TDfydP4Yt32NzNKEq10x3J+137cjQsZqyk4yM2ywHBe
	fd5llzWyZUaNZwlfiKQYXr80Rd3YqWQpohtXiuJJksWKx9n9rF7qAvqpZuXpL5SikFWz1yoe6vt
	5WmsOqRXpltNpLKtia+/Yf5ldLu/3WTzdMNQ6vdeK5iEZ1YnWXjEwpcIn3pVXX0XNKPH44QCd1/
	/4UT54Z48x3PjqK7gxzmmzEyYL286DA==
X-Google-Smtp-Source: AGHT+IGGt6yu06Z/Fb2uJjOxPY5fFcWkWfnfjRjUezmHyuS+t/QogNEJZXQVSUvZn1n0IiNOe7m/dw==
X-Received: by 2002:a05:6512:1193:b0:553:ccef:e31f with SMTP id 2adb3069b0e04-5550b4749c2mr141485e87.13.1750951949806;
        Thu, 26 Jun 2025 08:32:29 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:29 -0700 (PDT)
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
Subject: [PATCH v2 04/11] kasan/xtensa: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:40 +0500
Message-Id: <20250626153147.145312-5-snovitoll@gmail.com>
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

Call kasan_init_generic() which enables the static flag
to mark generic KASAN initialized, otherwise it's an inline stub.

Note that arch/xtensa still uses "current" instead of "init_task" pointer
in `current->kasan_depth = 0;` to enable error messages. I haven't changed
this because I can't test the change.

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


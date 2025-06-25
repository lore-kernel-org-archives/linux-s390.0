Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA829E0F9;
	Wed, 25 Jun 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845211; cv=none; b=hcUq5BhA3qY1eeUMuSqRUrTtNHQNqw7vTnTpjvKGCyE/hha19TyP5KUOOgShVncJXvye0Nk0+as3LYApWtoL1LMzVRA8oKoeoGgAIIysY1aXfybWUndiPcckwlnbL4TrExmMq8cZUlpbmEJNowE05Ba2H1HUK3nDHcGDpf1Btv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845211; c=relaxed/simple;
	bh=lhF1+oDAAfZTQLsvxX1VmCxIOVKQmNCDXyIFJsn0eiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uihtDvAPlJbOmaGjJ8ivtaq7ga/RM7XYZBsb4fYQzSFUo3N6+xYcHe7EDEVKMKgAVMTb4ldshPmOOiYHAVCoqx7sc4jTehjpH58IK8/AcS8DoJu7/TgndIvXqtSISQyGuske1fjrMUVpBdm+QZBktCinKB8wTx943T0RqbQctUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPqjimk7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPqjimk7"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b595891d2so12947931fa.2;
        Wed, 25 Jun 2025 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845208; x=1751450008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNdRW1IbQwaJLK3IU9ZGilulsvtFwP6FJhql802bOZE=;
        b=nPqjimk7/FsQJjAoB24yytSbXNE7dfVB2tzUSdlNHgzr5O+BcocuFtLPykTMWJl437
         /wLinRyH4w+jPobMpMRY3vSEaAAcV5mwtXuby6gSfUNcs8aRpLYGF9lq8iBjzqMcMTa/
         2CYlnrS6uvNJSb1kMH5ivIHbj0TVkW9aXUINEUZsWkQw5kaAe5IGvJj/TasBihGq6NrT
         UQfVGxHO5evwCMUfmtUhGGhHx0SefoxbdOZt4RdSnK5Ez37N8Q+suY4M3TguevIGWcT1
         XsvWnOhCu2R8IFls1QKRxyIfnysaSIvVTm54nzmKGdKm7XQQ6KrdjF4lhTPg1Kcod30l
         O5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845208; x=1751450008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNdRW1IbQwaJLK3IU9ZGilulsvtFwP6FJhql802bOZE=;
        b=GZS0oQdb7NMrzTHqUitU/aYvNVpSRXMGgJvqfZOZOt924wiTJWJaKqsvuj0DvkGbGs
         OvaVc9gUD7gsQ0pdPqD1JQS9wQru9L2JkO9npkDmEkQYELv/oNzFYeQpX6eZxPkdgrut
         oRjIH7Yjzel91ZMsxi18HFPsNj88ORpDsJXWiwMjvb0U8ovq6xS9ouZxyB54bqeVHojl
         7QTwF6i2YAlv8b3RNEDWo986yTdKOaKVTMJDjRHGxsfIiKocX8RKafz4ky1AOyr1XjMz
         b8x/mtI0gRQxCRxoBvY5WR3we3qYuP/7j3TrXNwAA9iQBYVpi6CYp08Ejm1jmbS+eqQQ
         k5kw==
X-Forwarded-Encrypted: i=1; AJvYcCWFd8jfv0ZEp2m+dULB8t/YWLZTkdCv38sVtXA01AJPqHZux0PIi4bp826MRaVtBzR+8KZgRBe4nDvkKQ==@vger.kernel.org, AJvYcCXCF+hESLKUZOgB4rjk/ZfCdWF/14K3m/KiD6luVrDsoSXbJqrxHyi1zmkkkWvm8PJVC5YchD8p8iTvFUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyPpYVPhAwGEximwJ5Nq+7vTE1lVwwUAX4ETH4tHyauPcKlTcP
	06CuJXOUBZLH/8l+Fj2j4yZvTl4/35EOs4iYQw2f6x2bxQRsSCf2Spgn
X-Gm-Gg: ASbGncuml7t7ydik+XjVdlv4iLCSJQSod3oBvvr/vH+5dtf+fU+OEX2NnY7OnZt6/4J
	W2sVGoLVlYABFiVsWqlnkZCMgwPgwPOXvn1PfYse90JUQLji+wnDQRRlkd1BKtFIW+JSxL8V/kz
	AAQJXeAFUSWOuqP4dwpvtS1ct+C5dpU808+OC6/7zqxumZ68ZZpqSKjG+15hWEm1HZPgF6JH2qa
	BxV8+Vy0lJqREEvjS3KrIJRfb+13mqDT318i4zsV1vItABi7Ln3CBzc8zCRivvpJBUpwAyjiNr/
	5rUEO85hnO9ckmr89WX6ap+Nvy+qF3iLyOYO3sLK3rqtvDr1Ooi1u3SE+rUkEUVvyUuHw3NcQVs
	trb6P4Hzng9tsVCPnb/5PvzVHedXtsw==
X-Google-Smtp-Source: AGHT+IEEyG7BglU4Us5Yezwlbfk1A7iCiSut02wYI0QnYJbbPrBalxPgrrZo+Iohs0E8JQ9l3Ex35w==
X-Received: by 2002:a05:651c:31cf:b0:32b:33c7:e0c9 with SMTP id 38308e7fff4ca-32cc64b7c27mr7419481fa.16.1750845207836;
        Wed, 25 Jun 2025 02:53:27 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:27 -0700 (PDT)
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
Subject: [PATCH 7/9] kasan/x86: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:22 +0500
Message-Id: <20250625095224.118679-8-snovitoll@gmail.com>
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
 arch/x86/mm/kasan_init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d21..998b6010d6d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -451,5 +451,5 @@ void __init kasan_init(void)
 	__flush_tlb_all();
 
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
-- 
2.34.1


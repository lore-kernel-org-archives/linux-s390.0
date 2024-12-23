Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4F194C94
	for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947011; cv=none; b=G6u+MdTrW/ScuOyRn6wjPUQ7ikEr1ZJiShqxrkqPFXnvcZRyMA+gW+W9JEhL4Oph7MfqAxwRJVgDDx+ClmQzQvau3ikPvEtcgB+3DaddQ+5A+mgo0BGRWcw4X/ScoZHLMy9TDz7FKivUgYcjYeu4Nh8AsYw7IYDpDxv7TzTYdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947011; c=relaxed/simple;
	bh=ju5DuzkKGwFmMyIwrlT1Lgl5SSQbM6pKt1IYE0Qmp1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HVsj82AGPKqy7CH+4m/uXs0zlMbylwMUD/q0ztIdRQH3psldfcnceg0Ykb0AgpFI+WvIQ6eQm3jqO2+a7DnOjrHhxKZbxhovtmLoDVXDz6GmQv6t42cw1uDbzwhwLru+dQOHBzja//o498xWGOleBZOV99+ycHmpAifxAN7J+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ikFqkr6B; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ikFqkr6B"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725c86bbae7so3476780b3a.3
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2024 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947009; x=1735551809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/tJ15+vmer/NbqXoUznjybhQp/MgC6GOdT/GuQUXpM=;
        b=ikFqkr6B0/3PS1wO+3Ey7F7j57aIAc5gjLbqDwTohFJrbACx++AluUPiHxN9uHBSQC
         IVPuuF6KnKEYEiKr/yQHxcdloQB5DmS29AvyvLbqeNU3NHLyX3a9I+gZbR15sRRD11He
         3WwSXngasVjY/nlqAjPJjwQfmR0c2XGTXEKlcXALQ5kf8ED99PA2Ayoi/O3MhrlmfPNn
         3D8gWkdGG66Ol9dqQ0sbt4gH8vLMHxGLBKAh+ZQlp5ldZC91qPk058gI+7dKBfDn/WE0
         E73kQOlr4lyiks0g4/4kKzB3pYIYnBkZGpw6tt/3pr2uNYDQk51eeBQEn8dRlp1a5OqM
         YufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947009; x=1735551809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/tJ15+vmer/NbqXoUznjybhQp/MgC6GOdT/GuQUXpM=;
        b=QzidmfPqisIR5NzfUqQEaXKN+xy186FPKsc1m2ONScm7okFZw94LBmqK2+sW8hjLlf
         PfRlyo/hDn+7GfkIq0buSgNRJw73MIlZIlqZRB/t3+loY1nrucL8eHMDetolg3JWaIV0
         A6qGBtxzmeOmupYwx/rkNX8uyI8ens29dEFEnDlXuEArsAaZzsXfBHNNMIbTtMlvcFQD
         kBmftjqYGEiiylVi8hrgPoI8ouFfLZQBOMEcn3w8PRTvrGmhZfohltjLdtJhxpeC6/fN
         jRVfqx5/AL2UBvsOBf7JMSXyAROPHbcd7GmzVqbx4ekHStzNF23qXuRHU+F+1VACCi/p
         xAvA==
X-Forwarded-Encrypted: i=1; AJvYcCVko5qny9UzkE9vXsxeaWLD7Mj8J7jByoMo4RzGUsbNhDvwdoVMtIwAeZmUJ2fTFfVthMvjiV7gXD9R@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7UdfMwQZJEsIdD5bXIG9f6JlsNVpIu2nmpwVsioHDIkqiGIHL
	8hPbUUkLmhAbujIOCn4ez+V9FtkqVXhVKPbdkfBz5j8sVf3OOMnQBO6EyDALd88=
X-Gm-Gg: ASbGncv6fHBUEp7dkVrLZoX+8rS/Fk/bjg1uMoy9hbnw7G4GSGPwYED5kIvo46MmgVo
	I11juG2DTtfWkgOZ9vOyo3F2JdkdQZEeYz/WreKPeoIu193rC6EiyruIYgy90V+I5LhR5xXcuEd
	q/aAm8Wv8E45G9KLtloceFLrJVOoOtoilBPa7isr28f2Wy0fRY+jSGlkbqpaPit+x1dv7cN2w1q
	gJNsJffV1UKTPf5B7/wk2z8pKmQi5tp5Y34OH+uwsrrFoSvy7GptOYCfKLPaZJbij1JgjhL2Tr2
	DefKY7jxux5DnhZRXq7mDA==
X-Google-Smtp-Source: AGHT+IGn0WgNlH4n6jFU+xV15Lu8l6dnMV2FFWuW4zvXTMVJTCCaTT+ZxewqFKpQcJgKvmYU0RJrVw==
X-Received: by 2002:a05:6a00:35ca:b0:724:f86e:e3d9 with SMTP id d2e1a72fcca58-72abdecbdb4mr16058641b3a.14.1734947008718;
        Mon, 23 Dec 2024 01:43:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:43:28 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 02/17] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
Date: Mon, 23 Dec 2024 17:40:48 +0800
Message-Id: <84ddf857508b98a195a790bc6ff6ab8849b44633.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Brodsky <kevin.brodsky@arm.com>

{pmd,pud,p4d}_alloc_one() is never called if the corresponding page
table level is folded, as {pmd,pud,p4d}_alloc() already does the
required check. We can therefore remove the runtime page table level
checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
the generic version, so we remove it altogether.

This is consistent with the way arm64 and x86 handle this situation
(runtime check in p4d_free() only).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index f52264304f772..8ad0bbe838a24 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -12,7 +12,6 @@
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
-#define __HAVE_ARCH_PUD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
@@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
 	}
 }
 
-#define pud_alloc_one pud_alloc_one
-static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	if (pgtable_l4_enabled)
-		return __pud_alloc_one(mm, addr);
-
-	return NULL;
-}
-
 #define pud_free pud_free
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
@@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		gfp_t gfp = GFP_PGTABLE_USER;
-
-		if (mm == &init_mm)
-			gfp = GFP_PGTABLE_KERNEL;
-		return (p4d_t *)get_zeroed_page(gfp);
-	}
+	gfp_t gfp = GFP_PGTABLE_USER;
 
-	return NULL;
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (p4d_t *)get_zeroed_page(gfp);
 }
 
 static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
-- 
2.20.1


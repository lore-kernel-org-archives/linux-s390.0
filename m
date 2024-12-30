Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA71A238C
	for <linux-s390@vger.kernel.org>; Mon, 30 Dec 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549834; cv=none; b=uIfVr0QmEouon6gRJxm+7kVEh0RscxXrR8Mvs0n4tMlJUItlpDFY6TIFx+OiE22Q7IFah83rVq3KjkEzKygwuuWyfNA7TJjLsVicyjrLeFATWHKxBPCKiG3yB92u9/lu00VhOkYDZP1XAX1upz1i6shMnhGmqhGZxybRRuWLHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549834; c=relaxed/simple;
	bh=w9Tb6kkg2Q49UGEfUZpSUyo28N/wow0+21NvTYUEzY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0zkjgkci2zIHSWXtfhy9Vr3T8nK1CvPLZS+zyONZTtmLoduJVcsOVSaEBBMdw3QRb41XiOfDt+8BzX3tzn3t/RmS9V4ZPb/ujPvVvTnAXQxlJM/5HSNH18bI8ZB5NPmQ3bWV0aUs3JQyCyMVRwXtuyv7dOOycInH3Lenfyn3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SMYXNOOE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SMYXNOOE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21619108a6bso107031565ad.3
        for <linux-s390@vger.kernel.org>; Mon, 30 Dec 2024 01:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549832; x=1736154632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=SMYXNOOERJ1ARyKG8MiDTgatbG+eULYxRlgQScb+bpKUq3Zq2boEUN08L5OOeHUkaY
         XEEVRHousYEFM98XYCW7AIpbW3FQjJ6fD5YBJBBBmw+oa+jjQGlMz9L4pxpTjhtDHOc+
         mzKJziqgTQCMgBTHzj2YA8F1aWpYo9nvXIarhYF86JwCQeoxb+lUkw+oa2X6RSW4W/Ky
         6WVpzuT/Z/O5vWT2bjKx46iOw4QX9zLIN7W2nm16mDkfWzkeDn+RflIkDsdGtntb1nSB
         sRfvEio/iYoSPfgmK0uOUW6TRrFBXYwATq/kmJaAjmKmADifjbYyxMmfkSU2CA+OWdvc
         +c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549832; x=1736154632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=w8xa4jvTXa8Z5aKv6nKAm8uKWMWQefTh644iMsGQjduay41cDKf3ae5V3ArvpEvvlS
         M95Nezjb9/kSDDyvSoEDzbwV2HG+H4PC6yhnX0Tc6+KJNDp3BcVPsYUFNS99mIdEzIXw
         mXnzsIqnqz8h4DakAKrbFN4CeSl4uuFkUvvEIjDxN1dBa8lfDzDleVSu0pd+aWQ7imIX
         +mJrBYo4nxMg3oWixt5bnF3DTVfP/jeRWpVlljy1/9CdDVb/XHvOVpChGKAtceGyWONv
         0tekvbARDfJJWs0lDfyjbxoWRxMas8TTX+crm4S1sMaS+LfLAJMn0wnIMg+a3BCn/ZPj
         PjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQyhS4DWMIoPgZiteaG1xDrxoNr9r+njQvL++rXhqAdlmDBtlcGq48R+5s0TZnqw8YloAeYzOyBvup@vger.kernel.org
X-Gm-Message-State: AOJu0YwXusonu/glE71IYYCNEd/jooDHj+eK05upEFJBkwhRaqGxNjNy
	Xoly5omsTZZAvj0CK3R7x6H7ITazweW8fgk9GVr3FdD6HQITaiBYVCkaB0/U18g=
X-Gm-Gg: ASbGnctD5YCUhPxzC7r5RsP4kho1LekX+yQKeUpm2+LtC3ZYKUnr5o9dhwwz+GOfSWs
	LP47dq3pulTf8IpUwpcNy5HLE+UZ828z4/WUtb0W/w0HXxVTQ/47E89T+SYiMknrCm3I+6Uvygm
	T+vD0tyiWOO25yZnJ5JYUU1EPsyGJnvjNoKZ8mjEqxEFh52zFmyT3+3Z3giIfiuK8f+oWjMxGP2
	eIyQvzzVR/n32DU44wag1S9fvWBK1h5D/fmAmAngTktAAebY2ykydNI2inFfT7oU/32+Vp00rVp
	mW4SosycAe42N2VB9FtqAg==
X-Google-Smtp-Source: AGHT+IGwnjGmNRtsc6wvIZAIM8FV7PRxiURIME1KaVRQ0EplG8wu3sXxm46oGULh37KJjV0x+YOVDQ==
X-Received: by 2002:a05:6a00:2181:b0:725:8c0f:6fa3 with SMTP id d2e1a72fcca58-72abdebb85dmr42631070b3a.22.1735549832564;
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	palmer@dabbelt.com,
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
Subject: [PATCH v4 09/15] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:44 +0800
Message-Id: <df71d1bd87ace445383b8ae62087ae14e35eac3b.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/tlb.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 408d0f36a8a8f..93591a80b5bfb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -9,11 +9,13 @@
 #define __ASM_TLB_H
 
 #include <linux/pagemap.h>
-#include <linux/swap.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #define tlb_flush tlb_flush
@@ -82,7 +84,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
@@ -92,7 +93,6 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -106,7 +106,6 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 	if (!pgtable_l4_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -120,7 +119,6 @@ static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
 	if (!pgtable_l5_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
-- 
2.20.1


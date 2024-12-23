Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD061991A9
	for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2024 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947087; cv=none; b=HzreL2XICt0wfA00Q8cNenV4J5Hkoa0LNvwnFXC+Ap9emIVz970+3O6irnzUz9HuUvsUHGcYOhQf7sHg6QNCDqn/96QR5/BMIVyb0UKrdtL2IGPe/H/mztF7i95L424J+5PZSwiq3v+J8UEnzHsrNK/o/AdoCwBeXSajcrFiHtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947087; c=relaxed/simple;
	bh=H/x1u07M3HXF9oVd+o3reuerQgd2pca8MMjlY49GFUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q03EiXn3PcsVNYWkdFbW3kqe7nk+wg7sA6ebOEk7e/JtImlItrhH46QzJTRPyOcd3+m+w88IbK41P3yg1xmAlVs9MQ55mqjYitqo5japeJ04VWwofGDNGb5pYGVDRpmyyLgD8QC3lxf9HiXZ0xp5ASupVIAPZzLv6HAQ0QxqWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WQBEl3A+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WQBEl3A+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725abf74334so3354391b3a.3
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2024 01:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947085; x=1735551885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=;
        b=WQBEl3A+mEOA3b5ceCxp8meUWkNWxaDq19onO6zzpsw8B6C1H7Mv2ClbIVM+aXCijy
         8OdVyNWPGfWsgQBZ3xX19CbOpxwNzVFXM1mZmPUCeJtUtlONy5pB0Tis1opn9oEk6a1r
         LyGcy0HD41FxpYv1jLY82v3cmHLPWej9P9aUI++2iOOLA3zpR5pzBf8t6XlrD3ay3qCO
         VxtSuWlhTz+SqOOdzMiIR046vfUShNoCt9H7Bgxdtps5fHUvcbGkXoY+LflF8sk2gvio
         6UhUH25G6Fb4mB2mTaOMD+F5eDM8prZVqjQ7uojLmx6dIG/mjzSEck4qD3ZQWVKIBaOz
         jt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947085; x=1735551885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=;
        b=no0jPDzvsKhosKjABt52nfGryNaWjbRPEMzLpAuNFT8HrOdVFlvZruvb10Da4Y0SL1
         eUtGYTkTGqSFS395LnpOOpU/csep0LWYUvXhwVGeG1zqa3xsogIVUNX6C39yro5hvO5J
         M+oD/gU+m654XshTEc514ke1VitAbpWjRqfQWPQJsw82PwCWg6qMRzHD+srohBldWlrM
         IzhzuTR8u0OGC0zELEiJQ5h29nPG9/3GTSlxVw7J2vVg0c027e1N9Mej1KULJi1poHwh
         R+rgL75dY40wbM/qdqFEtrC2E1/Uqi2pEi6WF3AyhtEOyyMjZeyjJpPcDBjO07epPvt8
         ADMw==
X-Forwarded-Encrypted: i=1; AJvYcCX55SoBfgwqRDunyTsGt3RmjRnODc1ACNX85FrrdeuCTbtnrhI61NclYbTd6w4AER8Yd6hp64wKnNrx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/V2a/jNYKZBTcTfYhkUmzfcGgw8X3/awYE+9c3L0OQEsnMOdf
	Rc8fuu6oPe17ZEz5YSFeZThL/6wS0V0t9Wm2w7vr0W7Gabv7KqrhSxHIaenqLAk=
X-Gm-Gg: ASbGnctz6EE9HOXUc4f1BH+mVlUXc9T5DYG5d5IKgfD81m7JcagGxbHl9aMYPVfwlEK
	UmGtjP1lVvSwMYF/P85FCGk7ByGxlqCxznczIfW4ccxeVExnvYueOlgFECrxdpRlW6LaeYH3lN7
	0QM2KovSoOK1JrSsakqHVWUCWBYSPY9sNw7IDlshaopfIdzUVBnfdyAU5Txdwohkgwvaom5qIOU
	3zZ1ya6jWQcHr8HwXpWim5KREiW7yfyciY6BX11Q8gZDJjg9uTL60KRpyPsm+QZwiDJgAZuHIcm
	qDF3x0UuB4Yg84doMb514A==
X-Google-Smtp-Source: AGHT+IEwnxNRxjpY566VNLJW6lRIrSoOOApqv/9DKS3yUbVNE+/391+nOnqyFIwO+T3gR5XgQach6A==
X-Received: by 2002:a05:6a00:330b:b0:728:e382:5f14 with SMTP id d2e1a72fcca58-72abdd7bae3mr14443469b3a.9.1734947085429;
        Mon, 23 Dec 2024 01:44:45 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:45 -0800 (PST)
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
Subject: [PATCH v3 08/17] arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:54 +0800
Message-Id: <955162bfbbcd9fbb3b074e1fe2aef4f64b61d6f9.1734945104.git.zhengqi.arch@bytedance.com>
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
 arch/arm/include/asm/tlb.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ef79bf1e8563f..264ab635e807a 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -26,12 +26,14 @@
 
 #else /* !CONFIG_MMU */
 
-#include <linux/swap.h>
 #include <asm/tlbflush.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #include <asm-generic/tlb.h>
@@ -41,8 +43,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
@@ -61,7 +61,6 @@ __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 #ifdef CONFIG_ARM_LPAE
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
-- 
2.20.1


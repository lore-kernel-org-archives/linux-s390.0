Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF8170A02
	for <linux-s390@vger.kernel.org>; Tue,  6 Aug 2024 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982500; cv=none; b=kT1Ej1YFufolSNzxie7l+t5p0J0wHAZYOLWBwweKf74mBkLPtCjyU6WHEP3VboFUaQKnZRLjGvi35/0JHCxGzKWMgxhZqE76vtTVhzWuOpxJMLjzbotTSwNqLQgK0ZggpYm+d6Rodc90thrU0t3pPUpEwWjVEiozhJLe5QB1Wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982500; c=relaxed/simple;
	bh=Ogo68UR/OsXc9UdIgAzdmezFiK2lZB543zE7hjBKpoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eG5c+AyaZGnwxUwd3s5++qlbiWqwUxqAHF2Wx+Ez0aMqk0NF/hTh/ucZN+1s/T2KAK7a5USgBAPztS1AOUQSRt1CwoeehjuBJg/gBE6F9hBdcP5XZFIfwc7oCO/JmghxwVHKp1sHSaqIvuDNJEL3icyz0FZgdCu3lmtP2y8dYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=YlV4UK0N; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="YlV4UK0N"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b78c980981so6076056d6.2
        for <linux-s390@vger.kernel.org>; Tue, 06 Aug 2024 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722982498; x=1723587298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpwrGsGSvnHFdGVf1tlm4Wyo1L4IUT4bE3I4p9OVTOM=;
        b=YlV4UK0Ns+x6vWW4pQb1PxiOCgj3UfN2LH3YTukO/FXGZ0bD92QPr48/UUmJ6Hq0RH
         zOBse55MvGDNU/iAqK3YB3o2rytTM0FQ2tJXc6eB3ckMwiPoKuu9AHg3qS/oOfmzm9vE
         KxUd7vQJ5i7LTHUBD1no49qrotXEgHqW9WzeimmlwRzfazm/Jo3Ywvw7lF33T/ClGrLQ
         lHvUjBP01T+yUrQH6obD0TfVR04vypt3/fmUnOVElDqWhm2y4zjsu5X+HhJ5e7El1vrV
         EYws6boRBqVOiWDRP7AKJjEAfRZ/WjfVfZMU7oYmw8C/b8kHsvKekeWsbp15264WBQHN
         6wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982498; x=1723587298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpwrGsGSvnHFdGVf1tlm4Wyo1L4IUT4bE3I4p9OVTOM=;
        b=GZwesLe2PYp24g25KnaVychmvEMztzYsBNmpEV9/j2A7UurWEfx/dI8YlTpTIbpX6+
         uH2sYxOlDetmFgZnqcXY/xUgVfgvw5V6++AytKB+5tOdUGBXZu/UipshjiH9hePfqqni
         Amu0xj8+KCl4ihsKCszC7nC9sYMk6XXe7/NRJ3GpnT6CkFzhNYEo/e7RxddC56n7EA7i
         iLAMxCJ1nMeTPjyL2TMVInXT/J96q+KJ8dPHcdmFqhRIBjEz021dCZQuDeH3g5f/k0Bz
         ndN9U7HkIyLvGaZbywia62pJFaEU7U2Uy6iJTOytS5kIG77sBir6n8jFDHqlPDjxK2IA
         HIgg==
X-Forwarded-Encrypted: i=1; AJvYcCV7FETRzrSSaeegAFcNLTH9XiK7EBBvKctBv6lWr4oGaZPjs0UFz9ZXr96Z405ZCT0mvFiXZABHDPzZrGICTQHwXrytAzwDwShntg==
X-Gm-Message-State: AOJu0Yxe9tzAvdiidPXn1xs6TimNzfL7aeFfaqLiVHn9jVTPVpR8OfMP
	NxOb2N3/g89w84x1y5iunoTRSkRdBbHhTiYuf1bKwmPHpjqH+RPapn/ZIlgkPSQ=
X-Google-Smtp-Source: AGHT+IGvHhFLKBv+CzG3kEzbceETNjAkvAWmYHLIEUsuY6FkehJnB//a5YH4EciwSMoOH9WpYcIhcQ==
X-Received: by 2002:a05:6214:5990:b0:6b0:86f9:64ad with SMTP id 6a1803df08f44-6bb98493eb3mr259732626d6.52.1722982497815;
        Tue, 06 Aug 2024 15:14:57 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c8778e1sm50584506d6.128.2024.08.06.15.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:14:57 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alexghiti@rivosinc.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	arnd@arndb.de,
	bhe@redhat.com,
	bjorn@rivosinc.com,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	chenhuacai@kernel.org,
	chenjiahao16@huawei.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	dawei.li@shingroup.cn,
	gerald.schaefer@linux.ibm.com,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	kent.overstreet@linux.dev,
	kernel@xen0n.name,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev,
	luto@kernel.org,
	maobibo@loongson.cn,
	mark.rutland@arm.com,
	mcgrof@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	muchun.song@linux.dev,
	namcao@linutronix.de,
	naveen@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	palmer@dabbelt.com,
	pasha.tatashin@soleen.com,
	paul.walmsley@sifive.com,
	peterz@infradead.org,
	philmd@linaro.org,
	rdunlap@infradead.org,
	rientjes@google.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	souravpanda@google.com,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	tzimmermann@suse.de,
	will@kernel.org,
	x86@kernel.org
Subject: [PATCH 1/2] mm: update the memmap stat before page is freed
Date: Tue,  6 Aug 2024 22:14:53 +0000
Message-ID: <20240806221454.1971755-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is more logical to update the stat before the page is freed, to avoid
use after free scenarios.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/hugetlb_vmemmap.c | 4 ++--
 mm/page_ext.c        | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 829112b0a914..fa83a7b38199 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -185,11 +185,11 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 static inline void free_vmemmap_page(struct page *page)
 {
 	if (PageReserved(page)) {
-		free_bootmem_page(page);
 		mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1);
+		free_bootmem_page(page);
 	} else {
-		__free_page(page);
 		mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
+		__free_page(page);
 	}
 }
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index c191e490c401..962d45eee1f8 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -330,18 +330,18 @@ static void free_page_ext(void *addr)
 	if (is_vmalloc_addr(addr)) {
 		page = vmalloc_to_page(addr);
 		pgdat = page_pgdat(page);
+		mod_node_page_state(pgdat, NR_MEMMAP,
+				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 		vfree(addr);
 	} else {
 		page = virt_to_page(addr);
 		pgdat = page_pgdat(page);
+		mod_node_page_state(pgdat, NR_MEMMAP,
+				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
-
-	mod_node_page_state(pgdat, NR_MEMMAP,
-			    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
-
 }
 
 static void __free_page_ext(unsigned long pfn)
-- 
2.46.0.76.ge559c4bf1a-goog


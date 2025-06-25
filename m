Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007B29ACF5;
	Wed, 25 Jun 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845181; cv=none; b=Azfdn/7dnClUuMp9SG1bRhoy7k3H6gDInEU2uNexJq0JvKHBPd9qXTPlCjh7bgCZHrtQ6o9Rp7zml+fCIuexN4hDajA0t3Vp20QE9Jc3yN75PxBnKLJrSyDgZ5rb483RvGShkubGjtKXMUyB+AviuFLOrreWofsGrdVajqYHu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845181; c=relaxed/simple;
	bh=3eVKIFY+WsG1SEi5ffClJGhexYokOf5VRAj3sHvFmZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6cLjn143q2BsuCN+cn0VCNPCWPp2M56Az/YGm9cNs/KDQ9j6+q9cib4TzbxnnRFiIpLSfqFxwEmpwBe8oFUMCejSkDwoRgznplao/ETYag352CWBuk29+hpzve2Ddn7p3a5tYNKOwh26LSGqYCVLiF1D/DNfWmMDFPKv3YHSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZYrbKQb; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZYrbKQb"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32add56e9ddso52457861fa.2;
        Wed, 25 Jun 2025 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845177; x=1751449977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spnPWYrTCugBtv3C0I1/Y7oTbF6XlJIePRXoFmRkZ78=;
        b=lZYrbKQbE05WzeNAhL2GzUMcj+7Hsx4+UHndRDLjZmJoh3ncYAbg3id2nFaNA07G0O
         2KFXjRxIBKT+3L74mWW6rzgMTDhCU7toOTbYpu0hK0KiX3bHN2/CmQMlLAcAiBqx3p+d
         fT9/3SBID+YZMyi96KgtHSOOTyM30Ypq9KEtwNcKhWXy3TKXS8dKs4J8vYjMW+ztVOwi
         pJ5E+Oo82Tnb6CNoE3xKZSP4qNPp9JvylYtb6jWdAEVLmpLk2TeccALn6CvZAWjnQXuo
         VDzxwvnbjRRSyM8LOgBjOYfdP9dJ4Q9aaGW+B7JI7tDpPE6lq+JRhV+I3nzc2RsP+qFm
         TyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845177; x=1751449977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spnPWYrTCugBtv3C0I1/Y7oTbF6XlJIePRXoFmRkZ78=;
        b=jhXkMrfK+VQjn0kU6kAeZjzPPpqVWRs8SG9bXMdvPfua2DZW98spYOMlP4BCdginoY
         b4EaxdGrMPg/lJ71kDKGFmlHNLUh/yGmzLbXpKLNx7yju3FTh9rqdhjMboINFTgYlwRj
         LufY4m1gN0UJEEDLjWuD2aRm9UdCI4arMVfGgnKaXJ+OECx6Yxl8icAPne7JTfM+Xilw
         CyYCl7Ldl/g0bWIX9hS7svAA2pnWyOvmTkMmHuFlvXDxlFziq7M5S+dLf+jHeduPq2Up
         gukLbo7Gw1U88ZVmwg/FsEfd28oISWJqv4d4UwFk/AoSqxnCMEkrB4TM+GOZXTYBz/hA
         0oHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmymCJs0b+SOrlCcrkRbyA7wS6eeFmUodNT7Ynsroi8VSeS/6NJwSk3Adlub1qLOZaxJQA1lk09wNhzQ==@vger.kernel.org, AJvYcCWqmDrB7crLTjWeAsgQpmBmqZbaMkCYTpOAd9F7J1MeEDmv7fbT7r4jujSuJqv9LOAVxe3YF1qJoi4+lSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvv8j2Pm3WFa6PBau2Q7UcK/fWh05CIEiorq3g+pmJN5qwtqK
	QX9ssDyfOny/Qds4c/TGe9+Td8DfnvNVNf8pPM8VkX0sTXR7q2itADBz
X-Gm-Gg: ASbGncur78GUXnA0i3n0sequZIjVsib7oF46uVUwjrkQ4JxiMAl1K6ZYLgbaNrMahSm
	LgAqW+EJ1eMyt8ZR9m53zrLvlyjeNt4tQ8XwBuTqFLcZsfkj8YH47+aNv+cxj5SfGM1/d8Osxdi
	QWuVHEMnMeGrTDXhfU0f77ZM/58Pb07dOJSUGlK7da0fS6vcZ7cqBTydK8+MBy8BDxumD1wg6gT
	97iWxRv7hSbiE5AwzePbCoR+JrY01IMaHeXV26UZFl+vPFXLar7+MvuSFgH/dlIIwNlAvAwPAYm
	AYcMkaLgGbHk/1tM3dvzpeul8KhgQd5gn50mMxcp1Ai9rbv9+ubmd/ZqSoDYLfPvhAWWde+Z849
	JQdMeol3o2r5XJicEkoOHU5evA9N9/w==
X-Google-Smtp-Source: AGHT+IF6eiwi1xoALYtMAE1ncL4ibtGAQqo+HifrEVfcQXGb5lhuCkRcCK0fus3Knli+XAnux0nRaA==
X-Received: by 2002:a2e:7806:0:b0:32c:a709:80ee with SMTP id 38308e7fff4ca-32cc6582a2emr4097091fa.39.1750845177105;
        Wed, 25 Jun 2025 02:52:57 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:52:56 -0700 (PDT)
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
Subject: [PATCH 2/9] kasan: replace kasan_arch_is_ready with kasan_enabled
Date: Wed, 25 Jun 2025 14:52:17 +0500
Message-Id: <20250625095224.118679-3-snovitoll@gmail.com>
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

Replace the existing kasan_arch_is_ready() calls with kasan_enabled().
Drop checks where the caller is already under kasan_enabled() condition.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 mm/kasan/common.c  |  8 ++++----
 mm/kasan/generic.c |  6 +++---
 mm/kasan/kasan.h   |  6 ------
 mm/kasan/shadow.c  | 15 +++------------
 4 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 525194da25f..0f3648335a6 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -257,7 +257,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
 bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 				unsigned long ip)
 {
-	if (!kasan_arch_is_ready() || is_kfence_address(object))
+	if (!kasan_enabled() || is_kfence_address(object))
 		return false;
 	return check_slab_allocation(cache, object, ip);
 }
@@ -265,7 +265,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 		       bool still_accessible)
 {
-	if (!kasan_arch_is_ready() || is_kfence_address(object))
+	if (!kasan_enabled() || is_kfence_address(object))
 		return false;
 
 	poison_slab_object(cache, object, init, still_accessible);
@@ -289,7 +289,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 
 static inline bool check_page_allocation(void *ptr, unsigned long ip)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return false;
 
 	if (ptr != page_address(virt_to_head_page(ptr))) {
@@ -518,7 +518,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 		return true;
 	}
 
-	if (is_kfence_address(ptr) || !kasan_arch_is_ready())
+	if (is_kfence_address(ptr) || !kasan_enabled())
 		return true;
 
 	slab = folio_slab(folio);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index ab9ab30caf4..af2f2077a45 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -176,7 +176,7 @@ static __always_inline bool check_region_inline(const void *addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return true;
 
 	if (unlikely(size == 0))
@@ -204,7 +204,7 @@ bool kasan_byte_accessible(const void *addr)
 {
 	s8 shadow_byte;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return true;
 
 	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
@@ -506,7 +506,7 @@ static void release_alloc_meta(struct kasan_alloc_meta *meta)
 
 static void release_free_meta(const void *object, struct kasan_free_meta *meta)
 {
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	/* Check if free meta is valid. */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 129178be5e6..e0ffc16495d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -544,12 +544,6 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
 
 #endif /* CONFIG_KASAN_GENERIC */
 
-#ifndef kasan_arch_is_ready
-static inline bool kasan_arch_is_ready(void)	{ return true; }
-#elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
-#error kasan_arch_is_ready only works in KASAN generic outline mode!
-#endif
-
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 void kasan_kunit_test_suite_start(void);
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d2c70cd2afb..9db8548ccb4 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -125,7 +125,7 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	/*
@@ -150,9 +150,6 @@ EXPORT_SYMBOL_GPL(kasan_poison);
 #ifdef CONFIG_KASAN_GENERIC
 void kasan_poison_last_granule(const void *addr, size_t size)
 {
-	if (!kasan_arch_is_ready())
-		return;
-
 	if (size & KASAN_GRANULE_MASK) {
 		u8 *shadow = (u8 *)kasan_mem_to_shadow(addr + size);
 		*shadow = size & KASAN_GRANULE_MASK;
@@ -390,7 +387,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	unsigned long shadow_start, shadow_end;
 	int ret;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return 0;
 
 	if (!is_vmalloc_or_module_addr((void *)addr))
@@ -560,7 +557,7 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	unsigned long region_start, region_end;
 	unsigned long size;
 
-	if (!kasan_arch_is_ready())
+	if (!kasan_enabled())
 		return;
 
 	region_start = ALIGN(start, KASAN_MEMORY_PER_SHADOW_PAGE);
@@ -611,9 +608,6 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	 * with setting memory tags, so the KASAN_VMALLOC_INIT flag is ignored.
 	 */
 
-	if (!kasan_arch_is_ready())
-		return (void *)start;
-
 	if (!is_vmalloc_or_module_addr(start))
 		return (void *)start;
 
@@ -636,9 +630,6 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
  */
 void __kasan_poison_vmalloc(const void *start, unsigned long size)
 {
-	if (!kasan_arch_is_ready())
-		return;
-
 	if (!is_vmalloc_or_module_addr(start))
 		return;
 
-- 
2.34.1


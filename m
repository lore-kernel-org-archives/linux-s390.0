Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2B30EF6D
	for <linux-s390@vger.kernel.org>; Wed, 25 Feb 2026 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007449; cv=none; b=QDxZ/TdxfrU++/c+e6nAxFQLJr3JZD/Vnx0CXhMdcYRIHBGgGv0sMgHtro6+j4a2XqedzrXfOC0kXu1/RQqAT+5C0TYPtWeCTTKC1EppijirzUm6M6RV4+VFgg0KensSu99ISDjkr6t0BagOxGKWh9A9ij03CMcf0uZwsOIUW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007449; c=relaxed/simple;
	bh=GZRNLbLZyPXE+uhRZMEWFIKDo4G2bYROWiAbH1IyQ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=AxsbEB741CtJ1o0BmFaMHIHGD+BciXsLgQXzh6Co0qcVtTiDg1jAJ1o9GS7f+sz3UB9uZPM9nXnqnD7la1rXVQh+b5PPolkwXKu/1GqE67rJM/yFXPs9ICM+BoKFSIEbZR73aV0kCl47cJLaKbckJK+o9FDjMvihOzubxff6gJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXiNa+Yj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXiNa+Yj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oV6MOc6IZ/eQSfEt7lDYf3QV1I2fYi7uzloZcjfdDk8=;
	b=PXiNa+YjYf9xRoxDJFv0X8xYotSgTZb+UCAGyQJpbI1XoG+ndyD3n7vbbvbV1Bx8e8Hn8h
	ycSwt6juZm7qhv1WeGlkglpJy1Z3i0/NWkv6bOk5LuKF5nCNECD8/KJIBIcXBHYlklkDhS
	RwrZYJJGLHUJG+ABKACsHbGi2Hkq404=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-d1eK6WOzOV6_MuYcbjoUdg-1; Wed,
 25 Feb 2026 03:17:22 -0500
X-MC-Unique: d1eK6WOzOV6_MuYcbjoUdg-1
X-Mimecast-MFC-AGG-ID: d1eK6WOzOV6_MuYcbjoUdg_1772007439
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33B381955E8C;
	Wed, 25 Feb 2026 08:17:16 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 657C01800465;
	Wed, 25 Feb 2026 08:17:04 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org,
	andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	linux-s390@vger.kernel.org,
	hca@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 15/15] mm/kasan: clean up unneeded ARCH_DEFER_KASAN and kasan_arch_is_ready
Date: Wed, 25 Feb 2026 16:14:12 +0800
Message-ID: <20260225081412.76502-16-bhe@redhat.com>
In-Reply-To: <20260225081412.76502-1-bhe@redhat.com>
References: <20260225081412.76502-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Since commit 1e338f4d99e6 ("kasan: introduce ARCH_DEFER_KASAN and unify
static key across modes"), kasan_arch_is_ready() has been dead code.
And up to now, ARCH_DEFER_KASAN is useless too because of code change
for 'kasan=on|off'.

Here clean them up.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/loongarch/Kconfig |  1 -
 arch/powerpc/Kconfig   |  1 -
 arch/um/Kconfig        |  1 -
 lib/Kconfig.kasan      | 12 ------------
 mm/kasan/kasan.h       |  6 ------
 5 files changed, 21 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d211c6572b0a..4b7802d02911 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -9,7 +9,6 @@ config LOONGARCH
 	select ACPI_PPTT if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
-	select ARCH_NEEDS_DEFER_KASAN
 	select ARCH_DISABLE_KASAN_INLINE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ad7a2fe63a2a..b51fbc25bdc9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -122,7 +122,6 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_32BIT_OFF_T if PPC32
-	select ARCH_NEEDS_DEFER_KASAN		if PPC_RADIX_MMU
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 098cda44db22..fd0bedd2c696 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,7 +6,6 @@ config UML
 	bool
 	default y
 	select ARCH_DISABLE_KASAN_INLINE if STATIC_LINK
-	select ARCH_NEEDS_DEFER_KASAN if STATIC_LINK
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_FINALIZE_INIT
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index a4bb610a7a6f..f82889a830fa 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -19,18 +19,6 @@ config ARCH_DISABLE_KASAN_INLINE
 	  Disables both inline and stack instrumentation. Selected by
 	  architectures that do not support these instrumentation types.
 
-config ARCH_NEEDS_DEFER_KASAN
-	bool
-
-config ARCH_DEFER_KASAN
-	def_bool y
-	depends on KASAN && ARCH_NEEDS_DEFER_KASAN
-	help
-	  Architectures should select this if they need to defer KASAN
-	  initialization until shadow memory is properly set up. This
-	  enables runtime control via static keys. Otherwise, KASAN uses
-	  compile-time constants for better performance.
-
 config CC_HAS_KASAN_GENERIC
 	def_bool $(cc-option, -fsanitize=kernel-address)
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index fc9169a54766..f08f7f75c285 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -552,12 +552,6 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
 
 #endif /* CONFIG_KASAN_GENERIC */
 
-#ifndef kasan_arch_is_ready
-static inline bool kasan_arch_is_ready(void)	{ return true; }
-#elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
-#error kasan_arch_is_ready only works in KASAN generic outline mode!
-#endif
-
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 void kasan_kunit_test_suite_start(void);
-- 
2.52.0


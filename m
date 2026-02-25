Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA03016E0
	for <linux-s390@vger.kernel.org>; Wed, 25 Feb 2026 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007331; cv=none; b=c95yD6Pnpw5fb/hi/poHv5LM1IhQaxvoaPWH/53K4Dfq4xY47JF61PdkqPGhM59gEqePGnFbhPmCSnZkYZRk6xB83LjvF2RsIhqR3bL1S9iDRxetrrV1n9iRO1gWpyaDdOuZJy8ubwuhupRFNeU1zhJhoi8JOfMKm0jblWcY+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007331; c=relaxed/simple;
	bh=LanImvKLX9Jg/kKmnRDnHcw1cAnp8QGv+qKVqiPRSHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=uHSgEF5GmghDSQuYf7g971st6OoSxg+x1lSJvKa/Fx5Lky1ruRMhhFn4d1Ybi9iUyZWyb5it19FHfaUvilgtnKR3FNkh78Ta0oukbu5F8Eza6FSuYbW+eQPMjlDVMXWDL8QU6u4vm9zpo7GZX5BjDxDPkd0Q8aTzMB8pnz8rcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnnvQlcn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnnvQlcn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ/15auNTcs4bEnKE4TKOadihs1pA/T7OdgqiTtaDyY=;
	b=EnnvQlcnvXG/kzahIj/uUPGHyA6y8E7bEe88bi57op0ezsij31kxu1G7FIRhQdvH42r4Kl
	yrA/57eQDprGLhgHvsVw/YskNccQUsPxXjJ6w4aPqZUFD0rfAudTvMJmOSGyF8HJAyukYh
	CyrUuqowhUtiJ5YK/N+FurQDujDvTxE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-MO7Loi8qMuGy7jOa06YqRg-1; Wed,
 25 Feb 2026 03:15:25 -0500
X-MC-Unique: MO7Loi8qMuGy7jOa06YqRg-1
X-Mimecast-MFC-AGG-ID: MO7Loi8qMuGy7jOa06YqRg_1772007319
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 320AA1800349;
	Wed, 25 Feb 2026 08:15:19 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFB231800465;
	Wed, 25 Feb 2026 08:15:08 +0000 (UTC)
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
Subject: [PATCH v5 04/15] mm/kasan: make kasan=on|off take effect for all three modes
Date: Wed, 25 Feb 2026 16:14:01 +0800
Message-ID: <20260225081412.76502-5-bhe@redhat.com>
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

Now everything is ready, setting kasan=off can disable kasan for all
three modes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kasan-enabled.h | 12 +++++-------
 mm/kasan/common.c             |  4 ----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index b7cb906825ca..cec21a08446e 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,10 +4,11 @@
 
 #include <linux/static_key.h>
 
-#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
+#ifdef CONFIG_KASAN
+extern bool kasan_arg_disabled;
+
 /*
  * Global runtime flag for KASAN modes that need runtime control.
- * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
  */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
@@ -25,18 +26,15 @@ static inline void kasan_enable(void)
 	static_branch_enable(&kasan_flag_enabled);
 }
 #else
-/* For architectures that can enable KASAN early, use compile-time check. */
 static __always_inline bool kasan_enabled(void)
 {
-	return IS_ENABLED(CONFIG_KASAN);
+	return false;
 }
 
 static inline void kasan_enable(void) {}
-#endif /* CONFIG_ARCH_DEFER_KASAN || CONFIG_KASAN_HW_TAGS */
+#endif
 
 #ifdef CONFIG_KASAN_HW_TAGS
-extern bool kasan_arg_disabled;
-
 static inline bool kasan_hw_tags_enabled(void)
 {
 	return kasan_enabled();
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 0d788a468e96..fc6513fa5795 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -33,16 +33,13 @@
 #include "kasan.h"
 #include "../slab.h"
 
-#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
 /*
  * Definition of the unified static key declared in kasan-enabled.h.
  * This provides consistent runtime enable/disable across KASAN modes.
  */
 DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
 EXPORT_SYMBOL_GPL(kasan_flag_enabled);
-#endif
 
-#ifdef CONFIG_KASAN_HW_TAGS
 bool kasan_arg_disabled __ro_after_init;
 
 /* kasan=off/on */
@@ -61,7 +58,6 @@ static int __init early_kasan_flag(char *arg)
 	return 0;
 }
 early_param("kasan", early_kasan_flag);
-#endif
 
 struct slab *kasan_addr_to_slab(const void *addr)
 {
-- 
2.52.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1630EF9A
	for <linux-s390@vger.kernel.org>; Wed, 25 Feb 2026 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007323; cv=none; b=iPu/8Uw0KPULP+b15OSLodaTGENy/5DNiGyBKxEOXz/C3E8wlslE1PotLqRJoadrMuHE8dY/vfy6ELJJuDq1ZM4PKKETbwlgHOhLX5Uc7PpRrz6QSq39CnKp6hy7yXDCOp/ZhVaZjDes6JrXzgbmFYKI2uWWZF+LdCGytKuxF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007323; c=relaxed/simple;
	bh=6y9yGb1KomQEBH/3B4vy/U8GsLaTCLQkmSCA7l0nNBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Zqx6t0lKEyN6QQ1ryHMGL7ADRFbPrzQWGqr9BEHmdUy09eWcud/zgztfqPJTV7GUKcImvRGYSiD0bVNubRFjmgU07f3SDGfoy69uW7DMVqix5j5ZBVybf+U8vYzvuzjrZUKfcB+HeEwEWjuOPMbq8e/4LDzhHhHcQ2Nf05tlTHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8lH5NRm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8lH5NRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krRB48lflglDsnK+MbRSOk31duSyM0PDe9SlLiivSrU=;
	b=L8lH5NRm1MJEeFnOge0c5hiH6crUmPFwlYZsZuD3ASdI1aJV4cXA2z7YzgRfdmuOVY98J3
	0OnP88tAQj9WMeOeHy2BhHg7gxlvvETuJl6K21P897vaYS/pK1Qc5gTfbov6Q53HutNV/x
	9eOGRAhzDb3ejKNEkUXPAUPpwityekY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-WO8-mb7BPemrfREQOcvRnw-1; Wed,
 25 Feb 2026 03:15:11 -0500
X-MC-Unique: WO8-mb7BPemrfREQOcvRnw-1
X-Mimecast-MFC-AGG-ID: WO8-mb7BPemrfREQOcvRnw_1772007308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14EC918004AD;
	Wed, 25 Feb 2026 08:15:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 860561800465;
	Wed, 25 Feb 2026 08:14:58 +0000 (UTC)
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
Subject: [PATCH v5 03/15] mm/kasan: mm/kasan: move kasan= code to common place
Date: Wed, 25 Feb 2026 16:14:00 +0800
Message-ID: <20260225081412.76502-4-bhe@redhat.com>
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

This allows generic and sw_tags to be set in kernel cmdline too.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kasan-enabled.h |  2 ++
 mm/kasan/common.c             | 21 +++++++++++++++++++++
 mm/kasan/hw_tags.c            | 18 ------------------
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 9eca967d8526..b7cb906825ca 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -35,6 +35,8 @@ static inline void kasan_enable(void) {}
 #endif /* CONFIG_ARCH_DEFER_KASAN || CONFIG_KASAN_HW_TAGS */
 
 #ifdef CONFIG_KASAN_HW_TAGS
+extern bool kasan_arg_disabled;
+
 static inline bool kasan_hw_tags_enabled(void)
 {
 	return kasan_enabled();
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b7d05c2a6d93..0d788a468e96 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -42,6 +42,27 @@ DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
 EXPORT_SYMBOL_GPL(kasan_flag_enabled);
 #endif
 
+#ifdef CONFIG_KASAN_HW_TAGS
+bool kasan_arg_disabled __ro_after_init;
+
+/* kasan=off/on */
+static int __init early_kasan_flag(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "off"))
+		kasan_arg_disabled = true;
+	else if (!strcmp(arg, "on"))
+		kasan_arg_disabled = false;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan", early_kasan_flag);
+#endif
+
 struct slab *kasan_addr_to_slab(const void *addr)
 {
 	if (virt_addr_valid(addr))
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 26a69f0d822c..9602ea4861e2 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -35,7 +35,6 @@ enum kasan_arg_vmalloc {
 	KASAN_ARG_VMALLOC_ON,
 };
 
-bool kasan_arg_disabled __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
 
@@ -75,23 +74,6 @@ unsigned int kasan_page_alloc_sample_order = PAGE_ALLOC_SAMPLE_ORDER_DEFAULT;
 
 DEFINE_PER_CPU(long, kasan_page_alloc_skip);
 
-/* kasan=off/on */
-static int __init early_kasan_flag(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	if (!strcmp(arg, "off"))
-		kasan_arg_disabled = true;
-	else if (!strcmp(arg, "on"))
-		kasan_arg_disabled = false;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-early_param("kasan", early_kasan_flag);
-
 /* kasan.mode=sync/async/asymm */
 static int __init early_kasan_mode(char *arg)
 {
-- 
2.52.0


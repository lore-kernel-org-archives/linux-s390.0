Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CF267B95
	for <linux-s390@vger.kernel.org>; Thu, 13 Mar 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866281; cv=none; b=Pd3lXKkJcmG2n5i9v/ixADmmMXPTZZhNF5t2V0vMrnMBHmp+YJeY0FNaWO4NnzCI/XDTa5BTi+0KfKBaGAVrAy0J2aQlRm9XE9woAqDwJzV+ODvpNrLD3upmOmG2mjQXYpyL7/awXgENCLahnQajhbh5PGhoEZR6BriZWL8Btzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866281; c=relaxed/simple;
	bh=u6Rwk0svFtWeF4hFVzbd7zjAA4nknN3Gap2PdMh7Y8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=I+boNXfLgg0Wh9X7r/iQPNidmGxoGjkwSfQ8uojlpp4rti6n7xQiG1gkdgakC0eaEn+ZNQuP5wS34BHJ8r1j/8ozAsyza2Kkuf+k2CTjJRQK19PT/cNecEO4SuAU6/mZdsucwCXx7pko8Z2qbzNlHPloCaexVvXbaO4uguCENB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbdDNbAK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbdDNbAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XY7u+VGe4o3zwipniM3kgRblYBzOD2SlUABTxKMSlI=;
	b=UbdDNbAKrVZHuFb+UAFgZOTMTUG/ThnAik3kirE8rbXsTY1rFOYCrlmEpru9uk2i301qlm
	ePInHf22mEU2pOw8aDZD1TLDD1oAQH+RW0gsZfLs0AaAlAl4m0PZHyf2Apd9GvYcIq9VmN
	C+ZykA1El4LjEtSTVeUvfcZ/9jDYWC0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-5VVX-RbvPtew6SeKygTQ1A-1; Thu, 13 Mar 2025 07:44:37 -0400
X-MC-Unique: 5VVX-RbvPtew6SeKygTQ1A-1
X-Mimecast-MFC-AGG-ID: 5VVX-RbvPtew6SeKygTQ1A_1741866276
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so558077f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 13 Mar 2025 04:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866276; x=1742471076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XY7u+VGe4o3zwipniM3kgRblYBzOD2SlUABTxKMSlI=;
        b=jZ4402dFslEuaXI/oQ6KCRV/UrW74hIEJdVXcPop5R+HFseayrd+DES3CtkjYgdyYN
         RuUvUo5proZT6mb6ObHXdtbtWBtuiT/YGxcnrNQC1Ob68MaqSlyMtsUdzrPndk22icer
         5kqmRiixiQIumZxJR9RdqQ/X66yQj6MBAILa5twHXa1DOBvJ+xO7gHEVriCd+bohd6mt
         g1jpQw3g3lijqt75rt8GDUv/9oak3dXWTi4KVYqSheSrrsxl/HxUQqDuJ20bq+SBjC1p
         VXRYwN5/VCi7mTBBQgFnIW2oYraE1k07HiNfDCohXq/trLwONNuWBqEqEGK7dgcuk1NP
         0jpw==
X-Forwarded-Encrypted: i=1; AJvYcCXrHH9geauSL7jgQoKuGZlPtNJzNvfBJmJwta/3SV8xr7n/mEY+TflNHFv9H0IUvFDiKXJyNoENto7R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xRIdNMPucgLBi1kvnsR0QRnw3RMY/ksqGvuZ5fh0mqc8AM3u
	AU5A9eMU4kXcRczCk0KW+sJ7KMFeK+uv6UKwWj8Z84dO+IdOGJR39USOsOEAzFuMNikQji3kVpl
	YNVH/LofRw3wNvrnwURUXX9977NEplGm5VgNOGYX4jdfSKC7IQ6KHNJAmZoE=
X-Gm-Gg: ASbGncvEvEynZ2J2S2O9wdohytfCFwgSkX662Enh6oyZTL7fxJS2AWdBzyO/fePp5DM
	8UMjC1ERuRYAQ9Pddm+YpG+CJ/bYYCZnecVSNou80+XruCuJOYcHO57/QK1YC6okNpOsGmW96Bn
	w+/PTPmaJXPJXVU5pUH/pKUpF10wTOSo9wgOuwDjgHBm9FOa4WAY/NJiUVdF/qxFKmLB/tj3UiV
	pKthbpZavpnLMsBd+mSDTTgunqXE/dJy5xcOC4ehhlikzhwR/98j0SIasoxwAEcvQZ5/IQ4whCO
	3KQ/9tbgfiJz6gZl+Y7U
X-Received: by 2002:a05:6000:402a:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-39132db8f39mr21017118f8f.50.1741866275639;
        Thu, 13 Mar 2025 04:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+VRMNblZ6UVVkAdfbP7euIJRbGF3K1/IwYQbvGRJNcsyt3iuZtEZMCMltjGjHXgTrURlOvQ==
X-Received: by 2002:a05:6000:402a:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-39132db8f39mr21017073f8f.50.1741866275187;
        Thu, 13 Mar 2025 04:44:35 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:34 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 03/14] kunit: Add test cases for backtrace warning suppression
Date: Thu, 13 Mar 2025 11:43:18 +0000
Message-Id: <20250313114329.284104-4-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Add unit tests to verify that warning backtrace suppression works.

If backtrace suppression does _not_ work, the unit tests will likely
trigger unsuppressed backtraces, which should actually help to get
the affected architectures / platforms fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 lib/kunit/Makefile                     |   7 +-
 lib/kunit/backtrace-suppression-test.c | 104 +++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 lib/kunit/backtrace-suppression-test.c

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 3195e861d63c..539a044a9f12 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -18,11 +18,14 @@ endif
 
 # KUnit 'hooks' and bug handling are built-in even when KUnit is built
 # as a module.
-obj-y +=				hooks.o \
-					bug.o
+obj-y +=				hooks.o
+obj-$(CONFIG_KUNIT_SUPPRESS_BACKTRACE) += bug.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
+ifeq ($(CONFIG_KUNIT_SUPPRESS_BACKTRACE),y)
+obj-$(CONFIG_KUNIT_TEST) +=		backtrace-suppression-test.o
+endif
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtrace-suppression-test.c
new file mode 100644
index 000000000000..8b4125af2481
--- /dev/null
+++ b/lib/kunit/backtrace-suppression-test.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for suppressing warning tracebacks
+ *
+ * Copyright (C) 2024, Guenter Roeck
+ * Author: Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <kunit/test.h>
+#include <linux/bug.h>
+
+static void backtrace_suppression_test_warn_direct(struct kunit *test)
+{
+	DEFINE_SUPPRESSED_WARNING(backtrace_suppression_test_warn_direct);
+
+	KUNIT_START_SUPPRESSED_WARNING(backtrace_suppression_test_warn_direct);
+	WARN(1, "This backtrace should be suppressed");
+	KUNIT_END_SUPPRESSED_WARNING(backtrace_suppression_test_warn_direct);
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(backtrace_suppression_test_warn_direct), 1);
+}
+
+static void trigger_backtrace_warn(void)
+{
+	WARN(1, "This backtrace should be suppressed");
+}
+
+static void backtrace_suppression_test_warn_indirect(struct kunit *test)
+{
+	DEFINE_SUPPRESSED_WARNING(trigger_backtrace_warn);
+
+	KUNIT_START_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	trigger_backtrace_warn();
+	KUNIT_END_SUPPRESSED_WARNING(trigger_backtrace_warn);
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(trigger_backtrace_warn), 1);
+}
+
+static void backtrace_suppression_test_warn_multi(struct kunit *test)
+{
+	DEFINE_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	DEFINE_SUPPRESSED_WARNING(backtrace_suppression_test_warn_multi);
+
+	KUNIT_START_SUPPRESSED_WARNING(backtrace_suppression_test_warn_multi);
+	KUNIT_START_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	WARN(1, "This backtrace should be suppressed");
+	trigger_backtrace_warn();
+	KUNIT_END_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	KUNIT_END_SUPPRESSED_WARNING(backtrace_suppression_test_warn_multi);
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(backtrace_suppression_test_warn_multi), 1);
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(trigger_backtrace_warn), 1);
+}
+
+static void backtrace_suppression_test_warn_on_direct(struct kunit *test)
+{
+	DEFINE_SUPPRESSED_WARNING(backtrace_suppression_test_warn_on_direct);
+
+	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE) && !IS_ENABLED(CONFIG_KALLSYMS))
+		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE or CONFIG_KALLSYMS");
+
+	KUNIT_START_SUPPRESSED_WARNING(backtrace_suppression_test_warn_on_direct);
+	WARN_ON(1);
+	KUNIT_END_SUPPRESSED_WARNING(backtrace_suppression_test_warn_on_direct);
+
+	KUNIT_EXPECT_EQ(test,
+			SUPPRESSED_WARNING_COUNT(backtrace_suppression_test_warn_on_direct), 1);
+}
+
+static void trigger_backtrace_warn_on(void)
+{
+	WARN_ON(1);
+}
+
+static void backtrace_suppression_test_warn_on_indirect(struct kunit *test)
+{
+	DEFINE_SUPPRESSED_WARNING(trigger_backtrace_warn_on);
+
+	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
+		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
+
+	KUNIT_START_SUPPRESSED_WARNING(trigger_backtrace_warn_on);
+	trigger_backtrace_warn_on();
+	KUNIT_END_SUPPRESSED_WARNING(trigger_backtrace_warn_on);
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(trigger_backtrace_warn_on), 1);
+}
+
+static struct kunit_case backtrace_suppression_test_cases[] = {
+	KUNIT_CASE(backtrace_suppression_test_warn_direct),
+	KUNIT_CASE(backtrace_suppression_test_warn_indirect),
+	KUNIT_CASE(backtrace_suppression_test_warn_multi),
+	KUNIT_CASE(backtrace_suppression_test_warn_on_direct),
+	KUNIT_CASE(backtrace_suppression_test_warn_on_indirect),
+	{}
+};
+
+static struct kunit_suite backtrace_suppression_test_suite = {
+	.name = "backtrace-suppression-test",
+	.test_cases = backtrace_suppression_test_cases,
+};
+kunit_test_suites(&backtrace_suppression_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC87E1FAC5A
	for <linux-s390@vger.kernel.org>; Thu, 13 Mar 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866285; cv=none; b=ep0HKHR7YsHHB9zw0gInViRMIB9jWHlH24zZo3eafLtJwiex7ZKCmQzbM8U905q20rTtVD4ye2ztaEShCisk5+eM1vTq7UeCxXdeCYN6hJiK5kaKOrudWMwZp0RxwiT2EpKBMhRifPt7ZTu5A1dFWpPaQ/duygwnKNQr5t09Vwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866285; c=relaxed/simple;
	bh=0zAXw8Fu4pWyrls3J/qZaqJC0Q8LMMCdN0t5bJavxBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-type; b=OGv8LV13NCVpJh2U0rD0/XKS5VUVpJVF7v0G83VYrUKIjtIGeDMnulVeFKryjYEpxeRuLFYXw1E+pkHKzG8QGPbpL5202ilMapeVJkQPU2IIpyr+gZs9XC6/S6l50zJgflguvPfKGyWIxATXojyeNBG10yYT0yvgfBx7CGBIMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdoCSBAi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdoCSBAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3r2g39Wllme+8/IppJMHdqpnHPlgxpExHUFAvvaA/g=;
	b=RdoCSBAiPYJ109xGNV3VC0uyjkz6ryHoOvMjHiNDyNN1RkcPylZZUkN6BBAaBFWzC4tsUy
	2rYVVhU8BlAZPFfTbCatOPp89VWeumbN734nm8v25tclawuOba+IWG0SboNZDCUiVE3Dmv
	1HIuZICOFH2oRkMKX6elrXkHSxthvl0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-CINsjJuVOJCu3ppVTC2Prg-1; Thu, 13 Mar 2025 07:44:41 -0400
X-MC-Unique: CINsjJuVOJCu3ppVTC2Prg-1
X-Mimecast-MFC-AGG-ID: CINsjJuVOJCu3ppVTC2Prg_1741866280
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3914608e90eso532343f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 13 Mar 2025 04:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866280; x=1742471080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3r2g39Wllme+8/IppJMHdqpnHPlgxpExHUFAvvaA/g=;
        b=HeoTkk/WBG7zkhWe+qJPIssfDUnP2VzXVf4alfpTb2V37jG0n55saVx+ejKQyuJeKT
         ziRVGSpfodRk+35YHZ0Vjt+uOribsbZiWyf8DEAQxHxxMqLJXpjVI8iW6tco6sIYm3F4
         Yc/cWOOBo06zxV4xkTkbkrR4U7NLJbO1DG7FaxP6zyw/awCEdKDZLQKT9sRsAqrrh1j4
         1aHXuvOIlL7JbcXuKvlvFAJjYl969dTWzrNILsij0EEyd/QocxEtJX6HlX1l4ObRH0Hc
         t5wbHBvuYvfuoHbZnQt2QuN3EK3LSr1Yk5/T/biNb8kwCuhnz+SkfKidh/4uHQrxVU7q
         sPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu2T1e+o6NXZoF9j+y7cQ9llfPKJwca7FQ2gC9qioR2XT1LyHKYEwJdRQ04HzDVQ0+RTObe72saxdn@vger.kernel.org
X-Gm-Message-State: AOJu0YyrFXxYGwZzYhyVdvLw8N9uYawqNGVArTEeoAcRdDdnEREPRPKk
	oRmUHaZNPOqd+P1lJnu9GPIQe0hZlbfCv6L0djDyH06AyUkN7NKSf5u7P4zpYQc15WNvw9pu04X
	rWIrmoLyKds358e1ZtRieAV00roQARxMb9C27HECOvNYGiX+vXiO3++3XS9s=
X-Gm-Gg: ASbGnctZ6cLjOGxMdzQ5LIMgN2nwkSgAPl0K6Spe3BH9ckeWBBmS/eJe9TtARNNALaP
	wOjAcuIOgOCz2h6Axt4JQgRyOgxwbjFEMgo1CBMPORBXgRV9obIOZs7j/CY+H04DvqGp2s39M44
	iW1Qua82iNlJic9KYaEfaFMdhGGPWpgO33s9e0HGFT7Ziu1e5ZzsPJ4Y36AUj8/unY5bEmYDJC0
	+DWBsDuk+Jvm69RIMMcxYUSsF7H6houxj8sCH4vJL7A7c9t4k1+7jfmxqgcHvs01EJEFQbmz4bG
	JRGcirnXYxRjwNf8oIfD
X-Received: by 2002:a05:6000:402a:b0:390:d73a:4848 with SMTP id ffacd0b85a97d-39132db1bdcmr22488992f8f.47.1741866280372;
        Thu, 13 Mar 2025 04:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX54DwhuuXuiX517uvSUEgVEhgO3UBbgNo/IaPOPi6DbNC92jX9q/7SC3qQwivycyOtbvIkA==
X-Received: by 2002:a05:6000:402a:b0:390:d73a:4848 with SMTP id ffacd0b85a97d-39132db1bdcmr22488963f8f.47.1741866280013;
        Thu, 13 Mar 2025 04:44:40 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:38 -0700 (PDT)
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
Subject: [PATCH v4 05/14] drm: Suppress intentional warning backtraces in scaling unit tests
Date: Thu, 13 Mar 2025 11:43:20 +0000
Message-Id: <20250313114329.284104-6-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
intentionally trigger warning backtraces by providing bad parameters to
the tested functions. What is tested is the return value, not the existence
of a warning backtrace. Suppress the backtraces to avoid clogging the
kernel log and distraction from real problems.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Maíra Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 drivers/gpu/drm/tests/drm_rect_test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 17e1f34b7610..e8d707b4a101 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -406,22 +406,38 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
 
 static void drm_test_rect_calc_hscale(struct kunit *test)
 {
+	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	/*
+	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	KUNIT_START_SUPPRESSED_WARNING(drm_calc_scale);
 	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	KUNIT_END_SUPPRESSED_WARNING(drm_calc_scale);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
 
 static void drm_test_rect_calc_vscale(struct kunit *test)
 {
+	DEFINE_SUPPRESSED_WARNING(drm_calc_scale);
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	/*
+	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	KUNIT_START_SUPPRESSED_WARNING(drm_calc_scale);
 	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	KUNIT_END_SUPPRESSED_WARNING(drm_calc_scale);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
-- 
2.34.1


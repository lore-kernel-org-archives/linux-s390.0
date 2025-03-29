Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C8B676
	for <linux-s390@vger.kernel.org>; Sat, 29 Mar 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743260689; cv=none; b=RzA9KIYSGNm+0n68OH2DV0AzMzhQee0p7f8E8shqbikma26CDKSVtAG69G9jQakzdDDneO10Z/MmErg2ubMeiYY+rCp4pDxGLMhhr2Nd4eEtxdx9ty3C3K4xeHOuy/CYHQWIbcUv1XxUn+gPaBdHCsQa2wkaawzsnZkZaFFfQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743260689; c=relaxed/simple;
	bh=puzgkOgCUPbE+wQ6SBvpkomea7X06UdpL4PsTVyABso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=HUJE+XsEbw8LeHTb83WOr+V4WuVnlNDx5mag3LXRcQFdjP1WqxGOaqRqX3FhgoNgkUCsd4quV0OnNvCp0EDoIz0agn13cUGDIUyuqRTD5vxfRmFOsPGVlQJLdcgpTn7ejUSlmxDqkl2sPTYlcGZuaFYyBZvH/xT8iMr6Q8ZD1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTDOxj/F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTDOxj/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743260685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9rZcFa00OKiutAluKujooWT6oAB0DkFh89UjHpXtZTM=;
	b=DTDOxj/FZO2gwVl/tOsvXe/ZggDEI6LglvEEgsuv4jncaYKdrOvciahpM3vvD+rHgRH4k7
	mcnXIi44ReQIH8gbA1MXdBytPiUc988YUaHQ4dgO7rVJzsZ6EkiiYnwvFfSZEuVfTzLVcA
	FhGsJ1R5Tz55imya+lAa8hbGDC1KCuc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-SFVGuvmCMpSnQtPkDBfN2A-1; Sat, 29 Mar 2025 11:04:43 -0400
X-MC-Unique: SFVGuvmCMpSnQtPkDBfN2A-1
X-Mimecast-MFC-AGG-ID: SFVGuvmCMpSnQtPkDBfN2A_1743260683
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913b2d355fso1179809f8f.1
        for <linux-s390@vger.kernel.org>; Sat, 29 Mar 2025 08:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743260683; x=1743865483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rZcFa00OKiutAluKujooWT6oAB0DkFh89UjHpXtZTM=;
        b=EPJpumf93bxKVuhH5kVdW2ng2+ZAsQ0r9If5vBzUB8ulsKUmxc1Uy4SKOduWm+4ui/
         IE/HnduCoGQZAf9BTcsmwXui5apysirWwN4bzp0L1VmSxOMmXgI7E4CEv073VwL9r/0P
         h/WM1bmX9Zt575v7NvVp8xvbA5bq/dH112Q4DKLoi18KDSz0E89A4xWVF7HTOPSlIXT5
         frQ7bmUEglUp3EXEiiKnC/B0VXY3QLVPHDTRw/MPpF9g9g6DPxxXntjcxCidey61kVv2
         sJcIt4PEbTqAbESFZ7heGgLpmfrchZ0dsV76jQGk0TveEuD36Zh9Lg8z9xq2eO6XTQBK
         6vYw==
X-Forwarded-Encrypted: i=1; AJvYcCUJtbPcRm4rT+veqLKJnQCVaNJ5XGcyTreNAxO7JXBATyAaCk63OGMZGQFWHwe4WAe4Tvf8qP1bv+uo@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrNM9wdZZJ+S75WRRwUVwdkOk/GZHVC4AUAZNIgM8AddpCRCu
	Mg5AdrdxyD5lXEhmK74TfLCcbrqIhmMYQ6fUcMEJS544zDgy2CmEUZ+3+iD80pYq3ydpUKz3ujw
	TSz/W0KR537LR4XSWq075OhHGbALOWAdjlrU9IFcvdhImqpVFR6YfSXMHcUA=
X-Gm-Gg: ASbGncurN3vvosgd/w2w4BjxJf93ke+7qlqOzg4fSV+jdnp0zeV8lXY7ACGXE5U6nn4
	kbsXUMfA3Uv0RzTBUIxr6mbMbLa2LnK+TXrz5t32m9DA8EEJQiIfL49Mz1UikZUoFcV4K8pd8xI
	FjFINCNJxdxOUd+DSfveVry9LCkRAEoIYX/cLXIVyxeT+bypOEkVYDvUepSuJl6GMhGnQFDoYD0
	GduVDP09qW+hBvozf/vXP5vhlXdgkIzLaQQIk5ixguMRja1XiuZXvNaNxPlNu8lQx0wDX9jiqnH
	E8FdRNgysfdUG7lPK36B
X-Received: by 2002:a5d:598c:0:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39c12119db3mr2073763f8f.49.1743260682745;
        Sat, 29 Mar 2025 08:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/2bHdcw2ELtkQnH3PJgr7VcNq4CZ6lA8znbzDKP3oWHKcunfSfI/tIlxfFak/s1ZEaKAEVg==
X-Received: by 2002:a5d:598c:0:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39c12119db3mr2073713f8f.49.1743260682362;
        Sat, 29 Mar 2025 08:04:42 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d8ff042bcsm63073205e9.28.2025.03.29.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 08:04:41 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mickael Salaun <mic@digikod.net>,
	Kees Cook <kees@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-next@vger.kernel.org,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH] kunit: fixes Compilation error on s390
Date: Sat, 29 Mar 2025 15:03:20 +0000
Message-Id: <20250329150320.331018-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

The current implementation of suppressing warning backtraces uses __func__,
which is a compile-time constant only for non -fPIC compilation.
GCC's support for this situation in position-independent code varies across
versions and architectures.

On the s390 architecture, -fPIC is required for compilation, and support
for this scenario is available in GCC 11 and later.

Fixes:  d8b14a2 ("bug/kunit: core support for suppressing warning backtraces")

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 lib/kunit/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 201402f0ab49..6c937144dcea 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -17,6 +17,7 @@ if KUNIT
 
 config KUNIT_SUPPRESS_BACKTRACE
 	bool "KUnit - Enable backtrace suppression"
+	depends on (!S390 && CC_IS_GCC) || (CC_IS_GCC && GCC_VERSION >= 110000)
 	default y
 	help
 	  Enable backtrace suppression for KUnit. If enabled, backtraces
-- 
2.34.1


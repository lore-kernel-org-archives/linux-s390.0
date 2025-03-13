Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458826A0A7
	for <linux-s390@vger.kernel.org>; Thu, 13 Mar 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866296; cv=none; b=MPDxVdrJBN8pnsYsoS2q6DnjnvPT7e0sQkpPRL/VvfS1L/iPyjdBTC7E3V4avoOkdpV8bBD0u3CHE80PjubnFP8LCZjqhbTETkkzmIsmVHLhvlxetLa4BfxuS/cqYcLonlx20bmWHXvsFiuu7+lIzaAsaG3imsX+14xCRpBwYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866296; c=relaxed/simple;
	bh=J4X8YZO4x00QVWpFsvAbnTlhyYgUvXZEkg17s47TCi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=hnclenmufB271fKsIeNSqrUbEz8vDNO9r+6FEK2eilmZKWOm9o8gDzrezh7PIBV9eammpWxG0bH/1U2z8DNInW7k6vWAYMejCCwQZFLkcKw12Xa6fftubvjcVyhPTaYxsUr6OnjnfsVgnXayU0pZ+vtGHoOc2fCV5bI7WHNiU+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDUwsku5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDUwsku5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdALik7flTFVSWTVblU8JKKGGV2JCoENkhxrfjNtUxw=;
	b=HDUwsku52T2ebFubb0fL46MZQa2MunEfwZq4PVi6xPrrywjQMxaQopf8+f5zCYoAxteEB3
	xaqk19lBYLT07dKklUnp691mkZuPMOxrSDdrxwt/7JWnnNAZVaKwAyHG7FmjJalo3EXW7g
	UU+C01IG94XqG+FyGX1MKTgk+UhH2ls=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-H1AZ0o8RNQieyinqYjkh0Q-1; Thu, 13 Mar 2025 07:44:52 -0400
X-MC-Unique: H1AZ0o8RNQieyinqYjkh0Q-1
X-Mimecast-MFC-AGG-ID: H1AZ0o8RNQieyinqYjkh0Q_1741866291
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912e4e2033so382903f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 13 Mar 2025 04:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866291; x=1742471091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdALik7flTFVSWTVblU8JKKGGV2JCoENkhxrfjNtUxw=;
        b=OMVV80HmQWVOxgHe4hugF6orMS0Qay5t8yAIzQ6mFzv1CNB8eJiSGz8tjJHgv5x1R7
         HL01LcukxuIcRvxOOLcg/O7dpJ+YRgWoehb2el9nB2W5z17auxpUa9hZCU4QFBepMD6w
         A4Z8LFaPG8Ts/ijc6dQt22u7V1CFGWn4RvB5legE/PZij+nWbzS2y+g7tZVr73X63lIb
         alg2V32O7azoSLg/7qhSuqQkIUWFOf03pJ2oBodNdgwpuzDMQmKqZcmRmIXEkhu0mf5I
         FIyNhMOXt6VJm4hTIAQc/S0HW+HiIFg9uaAFYg659NbRvLaXJDtT8oCsFxOxL3TsDgcD
         IGXA==
X-Forwarded-Encrypted: i=1; AJvYcCVtN/cyiQFMuVgf0k7LsgxD2szbbmXRzqUN7+LPhK/l27o6njIudtdAGnJuoyXLV/nmuT3nvMjfCOOe@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDtq79S9FQ7pTXHlcvxEPjsAI9ic5wTKI2mMCZjxk0YTE+5B0
	Dz/3n26ckW0iDXyAgcPA1uqjCJmffJQSdpi/UFO2uXD30wLtoAm72tAhDlsThogth8YLCyX2ig0
	cRJI8HHZSmutz+E0nH/U0knp/ywK/Jip6Fb/1u8QNRwNhOg9HQ6Z0Py0XdmU=
X-Gm-Gg: ASbGncuNaZMTQ8ho7i3CPdq48Dmmx6rKuqTi/F5Kd+bYQRSWHERR0VvgUt/Wp1jsqfh
	tDiPR30VC17pgbHXfTVsvfrcNIdPOv4hD/JdNFGYQQDA9OPfv3ZJ6bGWiCwrcje5uqv7uRvYzjd
	D91juvQUkd1ocxYm9IA2IYsG6n/RNXaPymNhjtrJTQTSw+5P2V0AXzym3E7iw70QSAahkiXWXh4
	gs5scZaaQFReh1ZovZYFWMMG/bp391VF8O6kAnX8fHwT6eyzgzfeX3mN/S6lbi6VlV8NCBVPJSX
	AIKeTMZ107rQQQGhs4WB
X-Received: by 2002:a5d:64a4:0:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-39132db7543mr19148442f8f.50.1741866291561;
        Thu, 13 Mar 2025 04:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc68icOs2UFLsGvYM02K+KaAXrxdUkEYYl5CYIXnV4BsTbvYwzMB6bzWlvY18H1nYSqaV5qQ==
X-Received: by 2002:a5d:64a4:0:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-39132db7543mr19148405f8f.50.1741866291178;
        Thu, 13 Mar 2025 04:44:51 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:50 -0700 (PDT)
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
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 10/14] s390: Add support for suppressing warning backtraces
Date: Thu, 13 Mar 2025 11:43:25 +0000
Message-Id: <20250313114329.284104-11-acarmina@redhat.com>
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

Add name of functions triggering warning backtraces to the __bug_table
object section to enable support for suppressing WARNING backtraces.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
parameter is replaced with a (dummy) NULL parameter to avoid an image size
increase due to unused __func__ entries (this is necessary because
__func__ is not a define but a virtual variable).

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 arch/s390/include/asm/bug.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index c500d45fb465..44d4e9f24ae0 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -8,6 +8,15 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"	.long	%0-.\n"
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC_PTR
+# define __BUG_FUNC	NULL
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define __EMIT_BUG(x) do {					\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
@@ -17,10 +26,12 @@
 		".section __bug_table,\"aw\"\n"			\
 		"2:	.long	0b-.\n"				\
 		"	.long	1b-.\n"				\
-		"	.short	%0,%1\n"			\
-		"	.org	2b+%2\n"			\
+		__BUG_FUNC_PTR					\
+		"	.short	%1,%2\n"			\
+		"	.org	2b+%3\n"			\
 		".previous\n"					\
-		: : "i" (__LINE__),				\
+		: : "i" (__BUG_FUNC),				\
+		    "i" (__LINE__),				\
 		    "i" (x),					\
 		    "i" (sizeof(struct bug_entry)));		\
 } while (0)
-- 
2.34.1


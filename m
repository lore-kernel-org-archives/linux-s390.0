Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891831197B
	for <linux-s390@vger.kernel.org>; Wed, 25 Feb 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007432; cv=none; b=IOj+08LMQ4S7BW0lQzWnM3yLrw/furXZ2jj1eE5UdqMpW6Mhz6ZMLvq+v+Cwn/vPO9cDJS5Bt9W6gbLHTuTEEue+zUpOlm10B0CYwhiev6jNQf8qxw2/ogX0Z/kPvQeDswy0TkswSxBEiPVOwBP/78UXzRjf3RNNUbVa98WlW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007432; c=relaxed/simple;
	bh=2qYkOHQ9ssN3m2WiDWJ2Jh88b8naTFxA0NJpRIww5Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=bOixwFhwpIOL2fiW+a4l7hOdoQXAA0ktj2qNnWg4OR4iaMKbkT9cGCQbWVh5KZ/v7mR3H13hPQ6bBGFGKZ+aTKO23/HpawhsID6GhxdaM1cDvA1XdTCautiA+KTFJuzfFzhLhRMl9OIJG1Wsy9vyGCA8MmI1okocWi1C0iNLsrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UyA4w6Sf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyA4w6Sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oT83zYbQb0MMseAk5Xm5Eaz7XNiK7MPHbcs4LQizA5Y=;
	b=UyA4w6SfPvwS7Xv996Sx9ieBzAb5I2kIksU4Z9AlfjcT3X+bC1x4KECxwpTNhcbe2tE2XT
	lFHtUFdGsCaFC8Y6ZuHcStK1GABgNLGeNUhyixH5AEUv7wtfIRFrhEPP54w0cOkU48lv0Y
	n6DW6QDNGVzvbjwpVLUCgtqucoSGfcw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68--PGROTGBN1uM5wyFliyqng-1; Wed,
 25 Feb 2026 03:17:06 -0500
X-MC-Unique: -PGROTGBN1uM5wyFliyqng-1
X-Mimecast-MFC-AGG-ID: -PGROTGBN1uM5wyFliyqng_1772007423
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA092195609D;
	Wed, 25 Feb 2026 08:17:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2EF4E1800465;
	Wed, 25 Feb 2026 08:16:52 +0000 (UTC)
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
Subject: [PATCH v5 14/15] mm/kasan: add document into kernel-parameters.txt
Date: Wed, 25 Feb 2026 16:14:11 +0800
Message-ID: <20260225081412.76502-15-bhe@redhat.com>
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

And also remove the relevant description in dev-tools/kasan.rst
which is hw_tags specificially.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 Documentation/dev-tools/kasan.rst               | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb850e5290c2..e0115fad9e60 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2899,6 +2899,10 @@ Kernel parameters
 	js=		[HW,JOY] Analog joystick
 			See Documentation/input/joydev/joystick.rst.
 
+	kasan=		[KNL] controls whether KASAN is enabled.
+			Format: off | on
+			default: on
+
 	kasan_multi_shot
 			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
 			report on every invalid memory access. Without this
diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index a034700da7c4..eaae83fcb5e4 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -129,8 +129,6 @@ Hardware Tag-Based KASAN mode is intended for use in production as a security
 mitigation. Therefore, it supports additional boot parameters that allow
 disabling KASAN altogether or controlling its features:
 
-- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
-
 - ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
   is configured in synchronous, asynchronous or asymmetric mode of
   execution (default: ``sync``).
-- 
2.52.0


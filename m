Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848F33F8A1
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996382; cv=none; b=MhR4Rp7NDDqv92aBoXnLkWHipRhOI4tYxKzAJFU7oYybqjTfvgUZOQQSHtKc4SSGstw5JjdPXLiJXqQAwavbY1jcSIprSvSuR6CFU0gYFKXk6pzratde53xx0zFfHDg0c4cplYd8ItXn40h3Oc4lWJ/IwIpwxXtheH6vEL7/Bw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996382; c=relaxed/simple;
	bh=OgU5gXUlLv5U2W5LPETZfCP4rOZqfZJQHAe9BKZ+SUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDtXwg4kVyalcUulmgD2dXY2FadNn8rP1m/jmWApVv6n9L709OJzUHm5O7gJCgJ+GggE1qRx4zf+JPfGu8MlkygH9PDD6zzAj02SSOUA0biCd56oLdDMkC8HdR+rzxpXDLsO+x601iTAIKb4jCy6wjMYPXECeVNyGrCpyVRRe88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFiB4iA0; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFiB4iA0"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484f26852dso2106515b3a.1
        for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 23:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785996380; x=1786601180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gz3BQ2fYyBKXfHfqnwVRQtDtnTfYUw4BfeW+CpBaGNw=;
        b=ZFiB4iA0rq12H1B1z2Do2TzXg/B3PuhY0bRKS+NnP77prN7RvAYgAvE6rXIvNSGTq9
         FKBy2TzX+LUq3CkL7a6ky9bozgbYTBMp5rBdtz3IGtEHk3PJj5HpcSxjWVO+Hv45X7nM
         df+yoWxcBH4sDGiCpn3Oh2lD8JNcJ4yMUvEouoxW0jeJuXOfGM7iGQlLmL/8tvDl8S45
         649KVuf20f3vdg6AQ0fyzOk0/m/kBBebxzVhWW4fjDZgxKWvtCpTiIJRsWkCf0FgZMda
         b4ZbHOYCpqH6fIwKKRsm7Yokza1Fm/nI9g+dPy85l6osgh0Pl2RA82j3ZmPzli2uKRY2
         jLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785996380; x=1786601180;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gz3BQ2fYyBKXfHfqnwVRQtDtnTfYUw4BfeW+CpBaGNw=;
        b=mfEjw/NYdUSBhjrRxLiGtTOVSJobyuM8+x7HBwblkZJqVA3T6+YxvPAmIHzZtSteNk
         qsUo3TAW9hpz+EuwgarGQ2eKWa/zr6lDXahmmzYOhCrUWlly6PaE/bNgxzYrPhvYiAYV
         Hllg6LgcWWXfwIXHEGsA5t+LUfpx9yOSas2/VlhdFp6/cMdQW9+TNgDi54bmUF8CplxQ
         8ExXWGOC8wULKex9mIiNwCTjuJoJXW8sFUICTt8Ng0jZGpZeLZZ89x5oZOHtcfQxLX1U
         TvXTqRftxnSDPcon0LcOx2btd/4gjCJ4/b2Xyk6WoV9HRNj+4/Q5DfKyxzw3fT5AH2wK
         HlnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnbUsf496JW2HiSJXY1KPiHdytUST4E3JnYwPpXkPsSHIsoUZCGwlHJHKprPW02vpcPFyoT43FdEVD@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVsAABZnD6ryD6GNLTSYhnli2NZZdJyOvw5eaBXKYeqnUNkLy
	IC0KrJ5+VPWn7qPqEtIZYfm++yT6m3OrGPych+CFg+vfynOXijgHVR7tM6hL8qEkHY4PpgdBrkZ
	WFPUxu+2qUQ==
X-Received: from pfaw13.prod.google.com ([2002:a05:6a00:ab8d:b0:848:4460:aed3])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4217:b0:845:45b5:9825
 with SMTP id d2e1a72fcca58-84f2e0c9cc8mr14067243b3a.37.1785996380097; Wed, 05
 Aug 2026 23:06:20 -0700 (PDT)
Date: Thu,  6 Aug 2026 06:05:47 +0000
In-Reply-To: <20260806060556.451370-1-wfelipe@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806060556.451370-1-wfelipe@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806060556.451370-2-wfelipe@google.com>
Subject: [PATCH 1/3] init/Kconfig: generalize config COMMAND_LINE_SIZE to all architectures
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry@kernel.org>, Wilson Felipe Pereira <wfelipe@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, only s390 has the ability to configure the maximum kernel
command line size via Kconfig (CONFIG_COMMAND_LINE_SIZE). Other
architectures define a hardcoded COMMAND_LINE_SIZE macro in their setup.sh
headers.

In some use cases, such as netboot kernels, rootfs configurations, larger
initramfs setups, require larger sizes. While for embedded workloads, it
can be reduced to save memory.

Move config COMMAND_LINE_SIZE out of arch/s390/Kconfig and into
init/Kconfig under General setup so that all architectures can configure
their maximum command line length. The default values were added to keep
the values unchanged.

Originally-by: Maciej =C5=BBenczykowski <maze@google.com>
Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>
---
 arch/s390/Kconfig |  8 --------
 init/Kconfig      | 12 ++++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d50..f5536e042ce29 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -511,14 +511,6 @@ endchoice
 config 64BIT
 	def_bool y
=20
-config COMMAND_LINE_SIZE
-	int "Maximum size of kernel command line"
-	default 4096
-	range 896 1048576
-	help
-	  This allows you to specify the maximum length of the kernel command
-	  line.
-
 config SMP
 	def_bool y
=20
diff --git a/init/Kconfig b/init/Kconfig
index 10f2013b53216..d42bb55cb2152 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1569,6 +1569,18 @@ config BOOT_CONFIG_EMBED_FILE
 	  This bootconfig will be used if there is no initrd or no other
 	  bootconfig in the initrd.
=20
+config COMMAND_LINE_SIZE
+	int "Maximum size of kernel command line"
+	default 4096 if S390 || LOONGARCH || MIPS || UM
+	default 2048 if X86 || ARM64 || POWERPC || SPARC64
+	default 1024 if ARM || PARISC || RISCV
+	default 256 if ALPHA || ARC || M68K || MICROBLAZE || SPARC32 || XTENSA
+	default 512
+	range 256 1048576
+	help
+	  This allows you to specify the maximum length of the kernel command
+	  line.
+
 config CMDLINE_LOG_WRAP_IDEAL_LEN
 	int "Length to try to wrap the cmdline when logged at boot"
 	default 1021
--=20
2.55.0.654.g21b8a5bc05-goog


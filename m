Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55A387345
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095048; cv=none; b=FhAyPkaV2D9q6U/Ov6eDtDs7x6e0PXRp/DjFXsy3fQmtFXKBPFzIpHxFerKkVNX/YJdShBUgc+SYVit6sHBipbrqOFCY3zCHHRL766r08rtZ9mXrfoEWnbaGpybj7Ue7fMv2LxpEHUvoGLdkIbIbUbfGHYDuy8/xtefP0NIjfZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095048; c=relaxed/simple;
	bh=zsQTRvQjt9bdnNmhTuMAFKOKF4rtZOj0YK4Iq/PG6CY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGtpJlWEa6PgNorHewRHnggDTVtc7gDVMWGhFjPK0KAtjyvZe6CELnlBsqvms6jUZjyZLeAZUcviBYbl1DTyrtHEuCTwiKRWde8cfzlbTp+wyTJ0pdWslylQqtIUlthmheDA+dAHW15dNWd8ZCLRKmJmmy+HS7ItO4yJ6tolVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udB85CbB; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udB85CbB"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso716396b3a.3
        for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787095046; x=1787699846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rjXE14dAOBmOI2yVIo34QsX8GPMTNdDLCrynw/1qs2g=;
        b=udB85CbB1agg2vYB8eQbys/Cx2IA458ydAWq9MzU2fIvTxb94aL0JVZfyZm4AjyrN7
         mvlpRd1QQmLEx89Uhn+SJYb3jRLmUXW5EHX3XEGk0bGZ2RHnonRm6W78MM1qTmIO4YPe
         VbhZJVnQBagBqwXfKuxlDr+sRw+y61UESBgIW3mS8c593VIHo2I/lfmFJ8smO2w3tT7Y
         jjfpRGn7GhA42VKzxffaLf2dDG246k8O9vR6S4G+2i7reUDWgeaZKsR9hxCap5tkLBee
         ur0Zt1LTC6pj5UbrZ1Y3UgGd7xlkUGMqrG8mMC/BkDWEwdwd9/LfMBjLZMEhI7fL/pbY
         2IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787095046; x=1787699846;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rjXE14dAOBmOI2yVIo34QsX8GPMTNdDLCrynw/1qs2g=;
        b=mb5KWcL6Y1KnIw4RZXblciYaZuyJ28j2aFR/+ncmemNy6/PoLyATwxgTt5BjeDAc3n
         uUZR/QxiQFEktJ/0m40ABsHuiQH1jNHYRSqe1TJzxy1QEuRCHVLUq6mrQsUVKKPowdPj
         9kTf9N3AMaFyyoNuMUk73WH6/Sw13lD99AYhlkAx0rujGWLW1vXn4Tju0MqgP3GkpdEX
         sFW6V4U/5iqwDOKMM1zNl4+fUO9dbxWz8Y4bzxNWiZ2Q+xzyQqf4kd9Xh1YLXawKQI5k
         0zaDmxTUvNONIqiLpbi17g67ZpHaC1wb2CquEQlCvS4AyTbr8s0e4jIo2ZtfNF5fi509
         +v5g==
X-Forwarded-Encrypted: i=1; AHgh+RosvdQ1T6/hI9wBDWL6TxaZD0F1SBxCwz3rQIIOo6t6LUgFOS5kkCrhwUXWMGAUmYtPZV6+8u2lMlNl@vger.kernel.org
X-Gm-Message-State: AOJu0YxOC8Dn7TNDsiJ/mCCV58pMLKAB8wDJJ1ijKVzoRvCe763bTVIx
	W7JVNoZVw1jxNGvqb7Pd2NOoJTAVKFqCP33Y7OLkatz6I0LEJzbGnTsuxaO7d5KiRYB6+1bKarJ
	uLda1FtZ+xA==
X-Received: from pglg36.prod.google.com ([2002:a63:1124:0:b0:cc1:522f:464c])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:807:b0:84e:7ec:aa42
 with SMTP id d2e1a72fcca58-851d3929f58mr305529b3a.10.1787095045945; Tue, 18
 Aug 2026 16:17:25 -0700 (PDT)
Date: Tue, 18 Aug 2026 23:16:32 +0000
In-Reply-To: <20260818231646.804507-1-wfelipe@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818231646.804507-1-wfelipe@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260818231646.804507-2-wfelipe@google.com>
Subject: [PATCH v2 1/2] init, arch: make CONFIG_COMMAND_LINE_SIZE globally configurable
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-arch@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wilson Felipe Pereira <wfelipe@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, s390 has the ability to configure the maximum kernel command
line size via Kconfig (CONFIG_COMMAND_LINE_SIZE). Other architectures
define a hardcoded COMMAND_LINE_SIZE macro in their setup.h headers.

In some use cases, such as netboot kernels, rootfs configurations, or
larger initramfs setups, a larger command line size is required. While
for embedded workloads, it can be reduced to save memory.

Move CONFIG_COMMAND_LINE_SIZE out of arch/s390/Kconfig and into
init/Kconfig under General setup, and update every architecture's setup.h
header to define COMMAND_LINE_SIZE as CONFIG_COMMAND_LINE_SIZE.

For user-space API (uapi) headers, wrap the definition in an
`#ifdef __KERNEL__` guard and retain the historical hardcoded default in
the `#else` block. When user-space headers are installed via
`make headers_install`, unifdef strips out the kernel section, ensuring
the same value as before for user-space applications including
`<asm/setup.h>`.

For S390, the range is kept the same, but other architectures have varying
constraints. S390 requires a minimum of 896 bytes to protect legacy
bootloaders from overwriting the .text section. ARM, M68K, and NIOS2
allocate the command line directly on severely constrained decompressor
stacks, so their ranges are strictly capped at 2048 bytes to prevent
deterministic stack exhaustion and boot panics. PowerPC (PPC) boot
wrappers silently truncate arguments past 2048 bytes, so it is also
capped at 2048 to prevent silent parameter loss.

The SuperH (SUPERH) boot parameter page allocates exactly PAGE_SIZE
(typically 4096 bytes), and placing a 4096-byte command line starting
at offset 256 would cause strscpy() to read out of bounds; it is
capped at 3840 bytes. Alpha physically limits its boot parameter block
to 256 bytes, so its limit is strictly locked to 256. All other
architectures are capped at 4096 bytes to prevent unreasonable
allocations.

Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>
---
 arch/alpha/include/uapi/asm/setup.h      |  4 ++++
 arch/arc/include/asm/setup.h             |  2 +-
 arch/arm/include/uapi/asm/setup.h        |  6 +++++-
 arch/arm64/include/uapi/asm/setup.h      |  4 ++++
 arch/loongarch/include/uapi/asm/setup.h  |  4 ++++
 arch/m68k/include/uapi/asm/setup.h       |  6 +++++-
 arch/microblaze/include/uapi/asm/setup.h |  4 ++++
 arch/mips/include/uapi/asm/setup.h       |  4 ++++
 arch/parisc/include/uapi/asm/setup.h     |  4 ++++
 arch/powerpc/include/uapi/asm/setup.h    |  4 ++++
 arch/riscv/include/uapi/asm/setup.h      |  4 ++++
 arch/s390/Kconfig                        |  8 --------
 arch/sparc/include/uapi/asm/setup.h      | 10 +++++++---
 arch/um/include/asm/setup.h              |  2 +-
 arch/x86/include/asm/setup.h             |  2 +-
 arch/xtensa/include/uapi/asm/setup.h     |  4 ++++
 include/uapi/asm-generic/setup.h         |  4 ++++
 init/Kconfig                             | 16 ++++++++++++++++
 18 files changed, 76 insertions(+), 16 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/setup.h b/arch/alpha/include/uapi/=
asm/setup.h
index f881ea5947cb..169f743ef765 100644
--- a/arch/alpha/include/uapi/asm/setup.h
+++ b/arch/alpha/include/uapi/asm/setup.h
@@ -2,6 +2,10 @@
 #ifndef _UAPI__ALPHA_SETUP_H
 #define _UAPI__ALPHA_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
=20
 #endif /* _UAPI__ALPHA_SETUP_H */
diff --git a/arch/arc/include/asm/setup.h b/arch/arc/include/asm/setup.h
index 1c6db599e1fc..60e158d58cec 100644
--- a/arch/arc/include/asm/setup.h
+++ b/arch/arc/include/asm/setup.h
@@ -9,7 +9,7 @@
 #include <linux/types.h>
 #include <uapi/asm/setup.h>
=20
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
=20
 /*
  * Data structure to map a ID to string
diff --git a/arch/arm/include/uapi/asm/setup.h b/arch/arm/include/uapi/asm/=
setup.h
index 8e50e034fec7..4aa93558af1e 100644
--- a/arch/arm/include/uapi/asm/setup.h
+++ b/arch/arm/include/uapi/asm/setup.h
@@ -17,7 +17,11 @@
=20
 #include <linux/types.h>
=20
-#define COMMAND_LINE_SIZE 1024
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
+#define COMMAND_LINE_SIZE	1024
+#endif
=20
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
diff --git a/arch/arm64/include/uapi/asm/setup.h b/arch/arm64/include/uapi/=
asm/setup.h
index 5d703888f351..2236890175a5 100644
--- a/arch/arm64/include/uapi/asm/setup.h
+++ b/arch/arm64/include/uapi/asm/setup.h
@@ -22,6 +22,10 @@
=20
 #include <linux/types.h>
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	2048
+#endif
=20
 #endif
diff --git a/arch/loongarch/include/uapi/asm/setup.h b/arch/loongarch/inclu=
de/uapi/asm/setup.h
index d46363ce3e02..03c7bfa1e5d9 100644
--- a/arch/loongarch/include/uapi/asm/setup.h
+++ b/arch/loongarch/include/uapi/asm/setup.h
@@ -3,6 +3,10 @@
 #ifndef _UAPI_ASM_LOONGARCH_SETUP_H
 #define _UAPI_ASM_LOONGARCH_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	4096
+#endif
=20
 #endif /* _UAPI_ASM_LOONGARCH_SETUP_H */
diff --git a/arch/m68k/include/uapi/asm/setup.h b/arch/m68k/include/uapi/as=
m/setup.h
index 25fe26d5597c..2d5b24a5345f 100644
--- a/arch/m68k/include/uapi/asm/setup.h
+++ b/arch/m68k/include/uapi/asm/setup.h
@@ -12,6 +12,10 @@
 #ifndef _UAPI_M68K_SETUP_H
 #define _UAPI_M68K_SETUP_H
=20
-#define COMMAND_LINE_SIZE 256
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
+#define COMMAND_LINE_SIZE	256
+#endif
=20
 #endif /* _UAPI_M68K_SETUP_H */
diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze/inc=
lude/uapi/asm/setup.h
index 16c56807f86a..e4b253064c7d 100644
--- a/arch/microblaze/include/uapi/asm/setup.h
+++ b/arch/microblaze/include/uapi/asm/setup.h
@@ -12,6 +12,10 @@
 #ifndef _UAPI_ASM_MICROBLAZE_SETUP_H
 #define _UAPI_ASM_MICROBLAZE_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
=20
 #endif /* _UAPI_ASM_MICROBLAZE_SETUP_H */
diff --git a/arch/mips/include/uapi/asm/setup.h b/arch/mips/include/uapi/as=
m/setup.h
index 7d48c433b0c2..8d6c474835ae 100644
--- a/arch/mips/include/uapi/asm/setup.h
+++ b/arch/mips/include/uapi/asm/setup.h
@@ -2,7 +2,11 @@
 #ifndef _UAPI_MIPS_SETUP_H
 #define _UAPI_MIPS_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	4096
+#endif
=20
=20
 #endif /* _UAPI_MIPS_SETUP_H */
diff --git a/arch/parisc/include/uapi/asm/setup.h b/arch/parisc/include/uap=
i/asm/setup.h
index 78b2f4ec7d65..cfa77e84205d 100644
--- a/arch/parisc/include/uapi/asm/setup.h
+++ b/arch/parisc/include/uapi/asm/setup.h
@@ -2,6 +2,10 @@
 #ifndef _PARISC_SETUP_H
 #define _PARISC_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	1024
+#endif
=20
 #endif /* _PARISC_SETUP_H */
diff --git a/arch/powerpc/include/uapi/asm/setup.h b/arch/powerpc/include/u=
api/asm/setup.h
index c54940b09d06..daa15ac4e94c 100644
--- a/arch/powerpc/include/uapi/asm/setup.h
+++ b/arch/powerpc/include/uapi/asm/setup.h
@@ -2,6 +2,10 @@
 #ifndef _UAPI_ASM_POWERPC_SETUP_H
 #define _UAPI_ASM_POWERPC_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	2048
+#endif
=20
 #endif /* _UAPI_ASM_POWERPC_SETUP_H */
diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uapi/=
asm/setup.h
index eb4f0209c696..a6c1f4b0987e 100644
--- a/arch/riscv/include/uapi/asm/setup.h
+++ b/arch/riscv/include/uapi/asm/setup.h
@@ -3,6 +3,10 @@
 #ifndef _UAPI_ASM_RISCV_SETUP_H
 #define _UAPI_ASM_RISCV_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	2048
+#endif
=20
 #endif /* _UAPI_ASM_RISCV_SETUP_H */
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 378fcd2b6181..a9b09d5ff8b8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -512,14 +512,6 @@ endchoice
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
diff --git a/arch/sparc/include/uapi/asm/setup.h b/arch/sparc/include/uapi/=
asm/setup.h
index 3c208a4dd464..7054f5249a3a 100644
--- a/arch/sparc/include/uapi/asm/setup.h
+++ b/arch/sparc/include/uapi/asm/setup.h
@@ -6,10 +6,14 @@
 #ifndef _UAPI_SPARC_SETUP_H
 #define _UAPI_SPARC_SETUP_H
=20
-#if defined(__sparc__) && defined(__arch64__)
-# define COMMAND_LINE_SIZE 2048
+#ifdef __KERNEL__
+# define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
 #else
-# define COMMAND_LINE_SIZE 256
+# if defined(__sparc__) && defined(__arch64__)
+#  define COMMAND_LINE_SIZE 2048
+# else
+#  define COMMAND_LINE_SIZE 256
+# endif
 #endif
=20
=20
diff --git a/arch/um/include/asm/setup.h b/arch/um/include/asm/setup.h
index 80ada899f254..bc83dc4d467d 100644
--- a/arch/um/include/asm/setup.h
+++ b/arch/um/include/asm/setup.h
@@ -6,6 +6,6 @@
  * command line, so this choice is ok.
  */
=20
-#define COMMAND_LINE_SIZE 4096
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
=20
 #endif		/* SETUP_H_INCLUDED */
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 914eb32581c7..b73caf64f219 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -4,7 +4,7 @@
=20
 #include <uapi/asm/setup.h>
=20
-#define COMMAND_LINE_SIZE 2048
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
=20
 #include <linux/linkage.h>
 #include <asm/page_types.h>
diff --git a/arch/xtensa/include/uapi/asm/setup.h b/arch/xtensa/include/uap=
i/asm/setup.h
index 5356a5fd4d17..dcf33a403527 100644
--- a/arch/xtensa/include/uapi/asm/setup.h
+++ b/arch/xtensa/include/uapi/asm/setup.h
@@ -12,6 +12,10 @@
 #ifndef _XTENSA_SETUP_H
 #define _XTENSA_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
=20
 #endif
diff --git a/include/uapi/asm-generic/setup.h b/include/uapi/asm-generic/se=
tup.h
index 88ac5100df35..b8d06e6d56bd 100644
--- a/include/uapi/asm-generic/setup.h
+++ b/include/uapi/asm-generic/setup.h
@@ -2,6 +2,10 @@
 #ifndef __ASM_GENERIC_SETUP_H
 #define __ASM_GENERIC_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	512
+#endif
=20
 #endif	/* __ASM_GENERIC_SETUP_H */
diff --git a/init/Kconfig b/init/Kconfig
index 10f2013b5321..d03d42ecb0e9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1569,6 +1569,22 @@ config BOOT_CONFIG_EMBED_FILE
 	  This bootconfig will be used if there is no initrd or no other
 	  bootconfig in the initrd.
=20
+config COMMAND_LINE_SIZE
+	int "Maximum size of kernel command line"
+	default 4096 if S390 || LOONGARCH || MIPS || UML
+	default 2048 if X86 || ARM64 || PPC || SPARC64 || RISCV
+	default 1024 if ARM || PARISC
+	default 256 if ALPHA || ARC || M68K || MICROBLAZE || SPARC32 || XTENSA
+	default 512
+	range 896 1048576 if S390
+	range 256 2048 if ARM || M68K || NIOS2 || PPC
+	range 256 3840 if SUPERH
+	range 256 256 if ALPHA
+	range 256 4096
+	help
+	  This allows you to specify the maximum length of the kernel command
+	  line.
+
 config CMDLINE_LOG_WRAP_IDEAL_LEN
 	int "Length to try to wrap the cmdline when logged at boot"
 	default 1021
--=20
2.55.0.737.g08866a6d13-goog


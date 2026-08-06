Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D230DD22
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996885; cv=none; b=fwqrkfkPM9UwNF0f5i0LBoDbzuq+dGVocgwyyJg9U3akIdci9ijeB8armzL65VXVzw8B4RwvYLNZhjNLxdS2EBQRXo9QfrSxYabuyf0FICJlFLAa2Jp1FEGC6VF+rLj4m6hWMGAMfI/R+6WAGiCf0BBc5GKX15iLieB5uIDS8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996885; c=relaxed/simple;
	bh=pHCAvs03OzSFVX+qIPqa6foOPR/K8ZFGe2uSb09lYXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RpZXCsiiIXxH0X6wa/OugwF0QcGJBW1ZD+b6bwVCzCYzU9imOwWXRtGLt3DA7z3mWH5muBZ8jGUpTSnSpyCVaFh7AjPevhCuVUAIR/r35rb0AAYSaDMbgiWxDaY26TmiTQUfICyHou6/cPZAqFmRKzxAucjQUuS/nVx04o0jjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tNlSqVGS; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNlSqVGS"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso2322753a91.3
        for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 23:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785996883; x=1786601683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aF1RSvmX8B7rc4Kxz4SwFfxHIvmLzbvgGhhj59rMhOs=;
        b=tNlSqVGS+OFstP5srcjJrjQib+TISKXldmtUvpD023dpe1BA+HZw9m3Epc1RZchAdf
         AzAE5wonx1dpHrGNSCKE6oLL0ezQ/CP5ccUU3WxbASP2mJD7bXpsUFL/xPxmhUUqdaSz
         668gJijCUY6+WLaaS38jGWavWV79aMmkCe5SR5jdtVseOaamWIf+5qgkNsP70B2NbxjN
         pUUo6txu5sAGitIIWSrPe3OuqSaQG2Ec2Hnd5ttMHnxIUJycfySpH4qJOfIbhWsym4yi
         Zr3YJEYMmKGt+k8bIjVUGhFZy0GyyXGySb/J84X/mNMS6ueLVavMOYa1pk5F/B986e39
         NQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785996883; x=1786601683;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aF1RSvmX8B7rc4Kxz4SwFfxHIvmLzbvgGhhj59rMhOs=;
        b=sPLX+R8hmaMBEO3d4UucBWGD/xG2VbDWIr6lilOxgfeCrD/Q41/E16vmhc0dzRRtO1
         KpkOmLGQ1ifQHMDP7IDEfJeBCLdYdPmn8sHVwFydP1McADbm6JwD6vtbuteivJSPA5tc
         7KkzjCZCXCFceU4Sghh+QAIUozIFRi1YJw+XVg/N2Jy49vt9MHc+zKUzxgTZKLJbcEvI
         b8WB1sfTSnHbrqlYqP1SVF1zEHV1Az9z8f3LxqBmED6LenBeHGw21osY9gAhq1Mua/iE
         nRFYur6GMwQ24Wx+G1ysJ1t7zUIGsguRH1e18zv6RYXpXaW7vFkib6vwHCGVMKCAmsmB
         Kmuw==
X-Forwarded-Encrypted: i=1; AHgh+RpKHEjtf7FTcWy+HXdEIdRbboezisgKonbL+S/ZtI1KjOYtanSnRqvrdNwoQFNUm3+t+pmOMndos+UU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Njrz+2LV7+y0DCXwqmDPptaJ5LBZ1+f1bgsUVqfcodh/YJVi
	KC7i5kfAz8OSWO8v3AfN62jrDEIJngjLgkRAxzJ4BJsdA5cl4ogokINAzdj+uG8Z9m7izW3KgMp
	oWfIRevxMPg==
X-Received: from pjhz8.prod.google.com ([2002:a17:90a:5408:b0:38d:f086:96])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c84:b0:38f:efed:5448
 with SMTP id 98e67ed59e1d1-3903c54ac31mr13199266a91.8.1785996882733; Wed, 05
 Aug 2026 23:14:42 -0700 (PDT)
Date: Thu,  6 Aug 2026 06:14:15 +0000
In-Reply-To: <20260806061429.474992-1-wfelipe@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806061429.474992-1-wfelipe@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806061429.474992-3-wfelipe@google.com>
Subject: [PATCH 2/3] arch: use CONFIG_COMMAND_LINE_SIZE across all architectures
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-arch@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Wilson Felipe Pereira <wfelipe@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now that CONFIG_COMMAND_LINE_SIZE is available in init/Kconfig for all
architectures, update every architecture's setup.h header to define
COMMAND_LINE_SIZE as CONFIG_COMMAND_LINE_SIZE.

For user-space API (uapi) headers, wrap the definition in an
`#ifdef __KERNEL__` guard and retain the historical hardcoded default in
the `#else` block. When user-space headers are installed via
`make headers_install`, unifdef strips out the kernel section, ensuring
same value as before for user-space applications including `<asm/setup.h>`.

Originally-by: Maciej =C5=BBenczykowski <maze@google.com>
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
 arch/sparc/include/uapi/asm/setup.h      | 10 +++++++---
 arch/um/include/asm/setup.h              |  2 +-
 arch/x86/include/asm/setup.h             |  2 +-
 arch/xtensa/include/uapi/asm/setup.h     |  4 ++++
 include/uapi/asm-generic/setup.h         |  4 ++++
 16 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/setup.h b/arch/alpha/include/uapi/=
asm/setup.h
index f881ea5947cbc..169f743ef7658 100644
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
index 1c6db599e1fcc..60e158d58cec7 100644
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
index 8e50e034fec73..4aa93558af1e7 100644
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
index 5d703888f3511..2236890175a5a 100644
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
index d46363ce3e024..03c7bfa1e5d9f 100644
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
index 25fe26d5597cc..2d5b24a5345f9 100644
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
index 16c56807f86a2..e4b253064c7d9 100644
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
index 7d48c433b0c27..8d6c474835aec 100644
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
index 78b2f4ec7d652..cfa77e84205dc 100644
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
index c54940b09d065..daa15ac4e94c6 100644
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
index eb4f0209c6960..a6c1f4b0987e3 100644
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
diff --git a/arch/sparc/include/uapi/asm/setup.h b/arch/sparc/include/uapi/=
asm/setup.h
index 3c208a4dd4640..7054f5249a3a6 100644
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
index 80ada899f2542..bc83dc4d467d3 100644
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
index 914eb32581c73..b73caf64f2199 100644
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
index 5356a5fd4d173..dcf33a403527a 100644
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
index 88ac5100df359..b8d06e6d56bd7 100644
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
--=20
2.55.0.654.g21b8a5bc05-goog


Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000E18DF89
	for <linux-s390@vger.kernel.org>; Tue, 30 Jul 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370525; cv=none; b=FagxHERH4RzBv71FbHYXf+zPpDQri8GYGkyhxa583ymmm0AzTIuF4YbmWMU7d59V4faMWNg8qHBrp50tT1TbStB9YLm+V1gZbPQSIBGtWFmY83lDD1R9nPO1r2Nl2tOmIm0IhY1G3JULWppC5PBv1fhJpvmIOd0aje+on18ZHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370525; c=relaxed/simple;
	bh=rsUtJOr5uf6xI/SHZkaRwLOdSyrVoVqLcTwk6EZKpNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=agi371KIFFtkHW0xqXuoX4mIAN9nfQVogyGkULCdJtjIzA6ZmpB5NYDDJ1KWX2CuVTQIDIYG/rrKF1WYIaK3RUpQCZ/chx5XLLLAC0q+8KpZzf0IpUEn3JWRLvlTAO/rpB/KHO/uUKTW1uZlOKBhyVZ4qN1DMV/RvKTl9rBSFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4YEdRqJn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4YEdRqJn"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428063f4d71so10455e9.1
        for <linux-s390@vger.kernel.org>; Tue, 30 Jul 2024 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722370522; x=1722975322; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GbC9UKeYMk5Ne4+C+5nQILNnrxv/5Wxp3vD/sA5rOPk=;
        b=4YEdRqJnF+6YwkSu0+EWgrStSYMalYAOxV6kSWvws8D0CgY2rMjanJ2rFvbZ0ORYvl
         vkNnNrV6PGD5WvBQNS7qpyZQHzlDBkwloQHXUOusxILwqsZ0Nocqm53yqPpComV3qlpy
         mX3wgFPt3Aghi225UVS3Nsvh0q5Z4lTeXzuYcZhBZmvgM0EJ6irCSLTGesNonXoWkANV
         46ofgQy6t+bCLbHjmiHRooFJSsaP4B34X/U5p35dIPp1DKZmaRlOfEkWmeYFEMaOanrK
         nLYbTEzTbH68ucSWpPCCweMQ3QyKzFDpBGJ+opXOO+F6W4GJuujo0gjincYCy5oU/GJD
         wQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722370522; x=1722975322;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbC9UKeYMk5Ne4+C+5nQILNnrxv/5Wxp3vD/sA5rOPk=;
        b=dphcxxA3m7KSechvqt2cmjVXRxHGtyOHVmpPoR5FuG9KX/iNTIg85QgRZMmfdByz65
         7Fioeqo2fdoeyfzSFOmfF59H7kamxap0p8i1TcEfRL84e0y5arYWRSRdxmHWc8PAN0me
         YEcmUvHg2mQMZ19o9mDJ8c+U72K3nNrg2EWkn9HSqfr/wfqJomTeWGJxl9n5nNUHJpS7
         orOvP1zulgur5SGlUdi2BqVgBGPBUmFovh4pngF+XOqR2+oD1BsYUfmjPxSRJCAeNBLC
         5uShoTf0YK/3+u5CJCQbtPJAoThHOPPA04FOeSP9kDqakaTVcSr0bhksNb3mDANJyXAV
         uK3A==
X-Forwarded-Encrypted: i=1; AJvYcCVRk+i8lGtT8jzxrS68MQSCIB+BooKoNTmH2VeM7GeEAqEaSfixSFpELfDq54EPjs3N0wJYcwVj/fGzbacy47aieICyH4UPdHt7ZQ==
X-Gm-Message-State: AOJu0YzO2Dmd1CMvBiVjNjELcs19Hbz3mDEGvP/6l0H76arN+uCMV5LW
	ALWXulgNwUy6lirDtxqJIOzerNPB+OeGsS+fXJFwDbLQkoe7fxCuGJfYOBeLYQ==
X-Google-Smtp-Source: AGHT+IFc88rxPpono4+Iwy5LAjLRDVlbjIErlSn/ZQzI/kRwLwwyWlo83gbzFy9/j160CW2PDZTnCQ==
X-Received: by 2002:a05:600c:4fc1:b0:428:31c:5a4f with SMTP id 5b1f17b1804b1-42829f4723fmr18055e9.3.1722370521005;
        Tue, 30 Jul 2024 13:15:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:be6a:cd70:bdf:6a62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b8f51eaf5sm2074784f8f.29.2024.07.30.13.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 13:15:20 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 30 Jul 2024 22:15:16 +0200
Subject: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
X-B4-Tracking: v=1; b=H4sIANNJqWYC/x3MTQqDQAxA4atI1gbiDxa9irgYxqhZNCPJWAri3
 Tt0+fHg3eBswg5TdYPxR1ySFjR1BfEIujPKWgwttT29OkK7NMubMSb1HDQ7Gm8h5mTY0biNw7D
 2DRGUwVmKfP/zeXmeHxICEJlsAAAA
To: Arnd Bergmann <arnd@arndb.de>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722370517; l=3172;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=rsUtJOr5uf6xI/SHZkaRwLOdSyrVoVqLcTwk6EZKpNE=;
 b=MlTEOhWkW4Bugg/+QlvwFd1FRN1rJ6V5BN337jS5TdJqtH26gADznIruIJvSeYBrOrhYaQ/zA
 PKWhOPq6oKVAUX6ZLZ2S2ZFYLegT0MkMNh5nJWOe+sXb9NFVCkqkbI1
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Refactor the list of constant variables into a macro.
This should make it easier to add more constants in the future.

Signed-off-by: Jann Horn <jannh@google.com>
---
I'm not sure whose tree this has to go through - I guess Arnd's?
---
 arch/arm64/kernel/vmlinux.lds.S   | 3 +--
 arch/s390/kernel/vmlinux.lds.S    | 3 +--
 arch/x86/kernel/vmlinux.lds.S     | 3 +--
 include/asm-generic/vmlinux.lds.h | 4 ++++
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 55a8e310ea12..58d89d997d05 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -261,14 +261,13 @@ SECTIONS
 		*(.init.altinstructions .init.bss)	/* from the EFI stub */
 	}
 	.exit.data : {
 		EXIT_DATA
 	}
 
-	RUNTIME_CONST(shift, d_hash_shift)
-	RUNTIME_CONST(ptr, dentry_hashtable)
+	RUNTIME_CONST_VARIABLES
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
 	HYPERVISOR_PERCPU_SECTION
 
 	HYPERVISOR_RELOC_SECTION
 
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 975c654cf5a5..3e8ebf1d64c5 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -187,14 +187,13 @@ SECTIONS
 	_eamode31 = .;
 
 	/* early.c uses stsi, which requires page aligned data. */
 	. = ALIGN(PAGE_SIZE);
 	INIT_DATA_SECTION(0x100)
 
-	RUNTIME_CONST(shift, d_hash_shift)
-	RUNTIME_CONST(ptr, dentry_hashtable)
+	RUNTIME_CONST_VARIABLES
 
 	PERCPU_SECTION(0x100)
 
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;		/* freed after init ends here */
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6e73403e874f..6726be89b7a6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -354,14 +354,13 @@ SECTIONS
 	}
 
 #if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
 #endif
 
-	RUNTIME_CONST(shift, d_hash_shift)
-	RUNTIME_CONST(ptr, dentry_hashtable)
+	RUNTIME_CONST_VARIABLES
 
 	. = ALIGN(PAGE_SIZE);
 
 	/* freed after init ends here */
 	.init.end : AT(ADDR(.init.end) - LOAD_OFFSET) {
 		__init_end = .;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ad6afc5c4918..54986eac2f73 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -916,12 +916,16 @@
 #define RUNTIME_CONST(t,x)						\
 	. = ALIGN(8);							\
 	RUNTIME_NAME(t,x) : AT(ADDR(RUNTIME_NAME(t,x)) - LOAD_OFFSET) {	\
 		*(RUNTIME_NAME(t,x));					\
 	}
 
+#define RUNTIME_CONST_VARIABLES						\
+		RUNTIME_CONST(shift, d_hash_shift)			\
+		RUNTIME_CONST(ptr, dentry_hashtable)
+
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
 		. = ALIGN(8);						\
 		BOUNDED_SECTION_POST_LABEL(.kunit_test_suites, __kunit_suites, _start, _end)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */

---
base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
change-id: 20240730-runtime-constants-refactor-309f966d4100
-- 
Jann Horn <jannh@google.com>


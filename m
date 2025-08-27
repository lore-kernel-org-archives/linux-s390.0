Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A268F34DCE8;
	Wed, 27 Aug 2025 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291361; cv=none; b=kMErJ7zV78gzipb/DELPTeZno+ZHyr4JSFU86rtas/H+DBzpf/7a3cN4bhS9X2cEbcj9HWkWq4VWWetYl06DccQyj+knCrGrgjiJzHdUBdT6tUefy8MXHCAHVi1iHin/aCh8PwwSKcfM2AyjEFgPzQGhmyIsPSELaznfoX6VH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291361; c=relaxed/simple;
	bh=GxK8Y/l6QMpHsSC5/lKRcWUThT3tPFQypyafdn6KEZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MEGfm5tPJNSsMIwc6pIf1rLWEG44YB3h3GZI323xpwUyqVFr+nTLCkfzOMvLQeJEeN9SQnHXsOfHK7M2XInWbPWIVBCmqcrIxa4BZ4g0nPdnEv6n+Ss0+/9zBMqwsdMIIgpgdSZQLdZMH4ymjmJSo0wjwTNLZwjZvpqI+lCDtuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a16441so1039589266b.2;
        Wed, 27 Aug 2025 03:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291358; x=1756896158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6X/wDuwMGXHolRz+V9ennd5Bffj6ymv9Jrzy1lUthU8=;
        b=TnX1Lni4pC80AArMqk35JkaJ8Q7l1UUImHFGQM3N7n3EP3tP+Kl/1vlVpBWxcH26zt
         DNYkEOTYPiJccIOclA8VGV4a/AwkGJYNS63oKPr8+4QYXrP3dZgUSXZThNqjcYOuNkBQ
         yJ7vfXPDXHU4RpLlX3a6NH6bXS8PJ6FUi+fDptWI8I0h6Bv2gfw8vkd90nEe10eUohzR
         A/U7tN5S/rENMckucQXgMmAo1Hd8g7taRJVojvq55kKks+LuszcFPDK+ap2PuCeGopnX
         wat749RuA7GqYm7cxUVEngXzkp4mLZeruzJCoe2+8Bi3CEUUl5Cwq0a8RSmNA6dOCTTY
         0oPA==
X-Forwarded-Encrypted: i=1; AJvYcCU+HKxoZ7NYoSpPSw6vh2TR5jR75zihRPg7FWOBlGUZf5IXg9MS4hApHsRD7w+uwUex1TRCw9tC0U+26DM=@vger.kernel.org, AJvYcCUfvAnKTbS8lW/zPwBUCRZ7EUMWijk3/q6x4Ae/GZFkYPTadKRaesSOieQp5FZdOydCWsQoNZ2Ax2hTTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJa+Qb2JY9hBflJjaoK9uhxBjvnb8WWbIhSHyEwbSVmoFM45Lb
	QqEmMn0pIVWyssVF37e3GjPA1d5wDwi1t/gVkYBT++qoXaEUZVBJ6tgM
X-Gm-Gg: ASbGncvRk0Q8RRunv5FmplxdqQcaRDk4124hD+6DJ2RS5NKzKYVs3J1PejCnzerx24a
	h4nbpAzrVn3H67Fzj80eDMObbnR1BAPV9bUzDkMKyiy87KpoVZR0NU3h2UF7xc3euSflVCNlsL5
	+5VUct9PpPZ84+KRizjj3IPjqULoVzZHEJdBRn7/bFLc26G1UqC/GrF50beOHhvYsWuuEer4/J/
	1xwFlz3ZMp0NOThccCACp5dYsMv9dSz2CR0cnCqo/lVxugN7jqS18FMXszk/15bfQOeeC5ZAfkY
	6NHM3pnjqMQ0xZ8ZC4sWqMWpNjLnmRqn6L/RB3mfFLQtLfLBO7z5qGmEBYF4ZhqLZoWcREzrey9
	Vedfu+/xpd7f5Mfa1sY52L9o=
X-Google-Smtp-Source: AGHT+IEt7HUfyMYn7wwTTBfAgAlW9baMBm2buHWzgRksugd2fL7uEBallbmWq6FW+jaBEaqaNP9fhw==
X-Received: by 2002:a17:907:934c:b0:add:fe17:e970 with SMTP id a640c23a62f3a-afe28fbaffcmr1737084966b.14.1756291357601;
        Wed, 27 Aug 2025 03:42:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afea4b5eafcsm365786666b.9.2025.08.27.03.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:42:37 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 27 Aug 2025 03:42:23 -0700
Subject: [PATCH 3/3] s390: kexec: Initialize kexec_buf struct
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-kbuf_all-v1-3-1df9882bb01a@debian.org>
References: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
In-Reply-To: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <bhe@redhat.com>, Coiby Xu <coxu@redhat.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880; i=leitao@debian.org;
 h=from:subject:message-id; bh=GxK8Y/l6QMpHsSC5/lKRcWUThT3tPFQypyafdn6KEZQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoruEXRx0x/sg5L8lF842+++ptuDPjC3oj8dadJ
 uKgX0JY7+mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaK7hFwAKCRA1o5Of/Hh3
 bf5WEACRmffaU59y0c07C3h33TU9GzbJO9HOZxapXThAtEqn33XPo4si1FFGv6sTYNargSr6Lzs
 MJosdJiWDHRZaXSxFawvJvBq5XBTfFYs+4tW2EiAU19diAu5I3J5dfl8lqww3GI6zzZIrB5wA4B
 r71V3ZUJK3cZ8l4gTpGp2zWNvG7Q+121ozv4yRD5kfazvucI93HIth7LZcXGKfNkpz+1aW8Y+Bo
 CECDcsH4Z4ZHW/73m7w0ThVouXFEkSIxWhyzVtYPFMWF/MmktJ0t7niZfKNMTRyu++v37nlGcmY
 uWpa1o6LmJUU93AJFkXojU93ztyTZZ2RC7FupVqYsQy5ZqvoIJ37Zd7oPpAULS1x5FX2xzbe7s4
 PYhfG2kBSlHriVV/gT/wRX6SMyVLWK0NQOszrjhZoQUHCkTPzfBdtRkf06wYGOoZHY8VV70IOSX
 fxXgT6OPXyi7xResv3bkLI4vLyEvNWjbQXsAOX3L/ZLQwvYKEpMDSd2eaoO2TSKIBnuQnArR846
 uDq8NSU+HoTOGc4chbxXxwQZH2qpGuNnndVelTsFCmtlb9I7yVtrk/qCAN/9fdHnGjVmU9f6grm
 TWCAnmqakjCXdNYLT+OhBxkDcorfJgKFH/44W4AXsfhUTjdTaRNM+uGkGeRohC2Vx/EUGQTChd+
 UYUwpwtf+a6rOTg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The kexec_buf structure was previously declared without initialization.
commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
added a field that is always read but not consistently populated by all
architectures. This un-initialized field will contain garbage.

This is also triggering a UBSAN warning when the uninitialized data was
accessed:

	------------[ cut here ]------------
	UBSAN: invalid-load in ./include/linux/kexec.h:210:10
	load of value 252 is not a valid value for type '_Bool'

Zero-initializing kexec_buf at declaration ensures all fields are
cleanly set, preventing future instances of uninitialized memory being
used.

Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/s390/kernel/kexec_elf.c          | 2 +-
 arch/s390/kernel/kexec_image.c        | 2 +-
 arch/s390/kernel/machine_kexec_file.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 4d364de437992..143e34a4eca57 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -16,7 +16,7 @@
 static int kexec_file_add_kernel_elf(struct kimage *image,
 				     struct s390_load_data *data)
 {
-	struct kexec_buf buf;
+	struct kexec_buf buf = {};
 	const Elf_Ehdr *ehdr;
 	const Elf_Phdr *phdr;
 	Elf_Addr entry;
diff --git a/arch/s390/kernel/kexec_image.c b/arch/s390/kernel/kexec_image.c
index a32ce8bea745c..9a439175723ca 100644
--- a/arch/s390/kernel/kexec_image.c
+++ b/arch/s390/kernel/kexec_image.c
@@ -16,7 +16,7 @@
 static int kexec_file_add_kernel_image(struct kimage *image,
 				       struct s390_load_data *data)
 {
-	struct kexec_buf buf;
+	struct kexec_buf buf = {};
 
 	buf.image = image;
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index c2bac14dd668a..a36d7311c6683 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -129,7 +129,7 @@ static int kexec_file_update_purgatory(struct kimage *image,
 static int kexec_file_add_purgatory(struct kimage *image,
 				    struct s390_load_data *data)
 {
-	struct kexec_buf buf;
+	struct kexec_buf buf = {};
 	int ret;
 
 	buf.image = image;
@@ -152,7 +152,7 @@ static int kexec_file_add_purgatory(struct kimage *image,
 static int kexec_file_add_initrd(struct kimage *image,
 				 struct s390_load_data *data)
 {
-	struct kexec_buf buf;
+	struct kexec_buf buf = {};
 	int ret;
 
 	buf.image = image;
@@ -184,7 +184,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 {
 	__u32 *lc_ipl_parmblock_ptr;
 	unsigned int len, ncerts;
-	struct kexec_buf buf;
+	struct kexec_buf buf = {};
 	unsigned long addr;
 	void *ptr, *end;
 	int ret;

-- 
2.47.3


Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976734A33B;
	Wed, 27 Aug 2025 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291359; cv=none; b=JA80iP2Twg7krDxiVq1ywrtz1RYAML79FjLaqlJbNEYTGUlKIfSBUbKmTFrvnmmkzDiv4R4Fx1kYAGZsOvDukzOcSPJZYcaQZiqC7H/HM/usmR/lwqM6S+bnhskO2nS7O5MCtgYHtAdUrgppblpxPNoNJtnRcM9HmUZ83NIEAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291359; c=relaxed/simple;
	bh=IQ8+TZrjuX8E+tz3NRY5WCQpnNUScYml/MBeP7a4Wmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AmUbiyfPyadfupPNbbSwFQRT6oW893pEgeQ0+hrTUFjogBmoDvqqaQkH3JlR1NAQCIFf6ONFidmGtsLqECIWZ+ltcXCGGoLjYSRY00pNmnwLooMS5hjLzE5ZdGmvUJd7RXGfrXkuWeVr/srj/gJcpZGKS55TVTAGVhiYpzktjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61caa266828so2063806a12.1;
        Wed, 27 Aug 2025 03:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291356; x=1756896156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vz82D6BOYc+hOsftCgRBc9qqs8ilQdlP6vhzKVwGwAc=;
        b=GVg3bp2KXGIle/sxL7aPvL/q1gMp+VP2Sd54UIn/pS6wGGiWQyentnwaGFHaJQp3PT
         jCyaoBDqQQ/APFe55qXQEQRN82S693ARmbq2v0cZtrmhCIDxH1G+6I14JM8fJHgBj7IG
         JruB8bQo0M7ZFcCmkd0zr7LWYdZrkMbUqt2V5CZ1UZlp0SYJ/Vxa8ZZFhtn0WTX2tIIv
         wXaoy1e8Q0LjRv1DgT6HuEjmsYAnU/0shNbKO8OB8mcQjGGZvlan2jr2AYBKCsdFUSB3
         Bt5djqlQS2A0vWnKSIpSps8uN63t8QYdFFPa92xDmMDstjp++pTe7YY4MXDoNAAJ39jE
         d7NA==
X-Forwarded-Encrypted: i=1; AJvYcCUmGwu3jEUjgBxPloODkNbhPlsSzGRl1e6yF8lCxK/hJaG2Vw5BHfkcWWdjdT6WAox5glJx627u9Xv9kYo=@vger.kernel.org, AJvYcCUt4boTqaPu/c1sYjxE+cpbrxLt5uSDL0tmP/CLqfrYCnZ7SD9o39RNmVwo7QYqGeX28yRdIi95gObc9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRE0bUCE8u7hctmNhh5c+JqP35Dipz4uZWv9vsW82GsMMCwV5
	f5XYT5M7bj5v601Z+eCL6dT/P3F++wkiyPIQwVU5wfT5H4vIJ4idxXQD
X-Gm-Gg: ASbGncvYEM9TKLfzOOFolXZW43h3fNNhpFX8k1q48+gGeSXXWYuHM8ljo/ov4KrENMd
	I28zQbl4jXrfHytwaKdQmvQfT/tXZ7liaA5fWbLDmWo9lIUzoyFOQNYwl3fnqxZV4pNDz0Y4X+j
	563b96ZgdFgcRipcaoKuPaNfsMlCEwvF8C8Wjh76E46iJsNw1YiIUnwtwU7Ktm9KAjsNzN7qtx3
	Xz9B8MjCqcaMu7daFeqhGPY5B8l4SO1y4sz+WBplnNFkp7bXpqFM3KB8Wc1blfMSmP67bEp8on2
	9C/n8b3Y6K4hPBfZCtLDkqub4UQ7Tf+iCRJuzlz0UfiS/8qH3HXJyGl6IwteonhGXt5LbdTpp1V
	UUgp7cr+BnVYceOCs0QDn7JQ=
X-Google-Smtp-Source: AGHT+IEYI41/g63i4kVWPeSOO7OZr1ZHqICmy0ei+m3f2f0i5tZ7DszcfvtA7dEeGXLX8TV7bTpnew==
X-Received: by 2002:a05:6402:5111:b0:61c:9970:a860 with SMTP id 4fb4d7f45d1cf-61c9970aca7mr3662005a12.21.1756291356044;
        Wed, 27 Aug 2025 03:42:36 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3119f79asm8721745a12.5.2025.08.27.03.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:42:35 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 27 Aug 2025 03:42:22 -0700
Subject: [PATCH 2/3] riscv: kexec: Initialize kexec_buf struct
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-kbuf_all-v1-2-1df9882bb01a@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2695; i=leitao@debian.org;
 h=from:subject:message-id; bh=IQ8+TZrjuX8E+tz3NRY5WCQpnNUScYml/MBeP7a4Wmc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoruEX/cLWQmBEx19TP+43KNp8/V/9NjghgKQHY
 biMCHC9P2KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaK7hFwAKCRA1o5Of/Hh3
 bZGzEACTv4Ns6J18i5vlqvkPmMxPbS8OBx9r2ReDTMJxi756yor2IOcJDgdV/O8CKL55E9CRL0r
 nv/XIqSPzCN6gLyLBoSlVRa3b8tTWp+amtioyjKmntVPKgpvv7gXyFFkQivC5YMH7cuC9iA5/iD
 fXa6VZP+rjMAIHij//GwyA3rb4qVjkioYseCO6N80FvE5HcA3ySipv02Mg0/XvQshQ6Jrhyf2+3
 EhFY0r0GAOFiZb4PidqHVyMFum1AhhFW1b0Ly97AofCw5ToGm7KT81vsRvFEkzKynizg8UcagMZ
 G+7iI0xmcgtEYDi6EEc87GX96VC16Q0b3hHY8B4Q0ccaU8SPq9cNYDtsjCmk/F2pK4mOsNqV5ML
 ftkUDrSYiS3PbB1iHE/s3yYfpEm3WcpOx53IQLXjBCesYQbvLwBn/31zd0JzrKpJPfgjJxqlDlG
 DkU4We+SpE1VBkKIFA4ZaP+FsQLNUBAJQg29JTcxUIb+TRyLdDhcXGf/Ls1Iugmu0fqvYZQJEdZ
 frSwQybk7ZO5+ZUGrIh78SpVDG0rTGydc9HSFEKrFS3ewQL8h+T5R6DJY2MP44Ji7iWbgyUTd5f
 c3n2NrWCCumDrX+3wBnhGTzxP+lM9I1ZjmJF4PF5HD5KX1gWD02qdTpSk2AOf8miz9alFrvMbPL
 ShqGSeZDkQoYvcQ==
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
 arch/riscv/kernel/kexec_elf.c          | 4 ++--
 arch/riscv/kernel/kexec_image.c        | 2 +-
 arch/riscv/kernel/machine_kexec_file.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/kexec_elf.c b/arch/riscv/kernel/kexec_elf.c
index 56444c7bd34eb..531d348db84d7 100644
--- a/arch/riscv/kernel/kexec_elf.c
+++ b/arch/riscv/kernel/kexec_elf.c
@@ -28,7 +28,7 @@ static int riscv_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 	int i;
 	int ret = 0;
 	size_t size;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	const struct elf_phdr *phdr;
 
 	kbuf.image = image;
@@ -66,7 +66,7 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 {
 	int i;
 	int ret;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	const struct elf_phdr *phdr;
 	unsigned long lowest_paddr = ULONG_MAX;
 	unsigned long lowest_vaddr = ULONG_MAX;
diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
index 26a81774a78a3..8f2eb900910b1 100644
--- a/arch/riscv/kernel/kexec_image.c
+++ b/arch/riscv/kernel/kexec_image.c
@@ -41,7 +41,7 @@ static void *image_load(struct kimage *image,
 	struct riscv_image_header *h;
 	u64 flags;
 	bool be_image, be_kernel;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	int ret;
 
 	/* Check Image header */
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index e36104af2e247..b9eb41b0a9751 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -261,7 +261,7 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 	int ret;
 	void *fdt;
 	unsigned long initrd_pbase = 0UL;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	char *modified_cmdline = NULL;
 
 	kbuf.image = image;

-- 
2.47.3


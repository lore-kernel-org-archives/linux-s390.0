Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA271F4E2C
	for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2024 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959688; cv=none; b=j2WWLPKfy7gMSH8xuENOY6lIv7+5TNfbzBPYTI8oTzpDnXT13+fgh2zjeZ3ACdvaBiG1v0drt573w8JniXSS6129/+OV+Je47hl9CY/1AokvTHKh3TdFAbYGCAiDvjnPa7vdmeCWyEJoY/DBwSclmnBq9EsxFKHSlXfag4GGocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959688; c=relaxed/simple;
	bh=2QMnrZNODJRgXg+9Jbu8htHUIP61bT8W2ZT8cLF7tfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SZzln3g4pxkd5JwHRYKGiSsn0jTD2nldrHhYZKcEWlkJ66/JN749vKNxKYkhEdx5sb5HDDykUq/k2vgJhVW/k4HxH5wRage8cBcyBsJSphBaA2WscAY5G+kjjvk/v05O0Hj9d086vtv2W9bhqPFfzMqvFDLoW6JYeKS0g1VmqwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJuilSx9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJuilSx9"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728efcaf454so14857b3a.2
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2024 15:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959686; x=1734564486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYJJcdIp4OFdB+jw/mn5ZasDVQdafEZmT3OPk14pFSA=;
        b=iJuilSx9ae6vsJfFvviFJ88vwaSqeue7iUQaqKlzapvMRGFvDvoC25KU+Vv+lwmtg6
         L4EHc2uqmG9mgLGTa+oiYiZZh6BmTeHMqxN80rFWDQ5rdKr3NGFmgpNzbIJhehQA9oCu
         N+K84hdj8u68XcRQ5cf1GWc1Bv6IH3OAv7VhzMQK1IdH2wJcnQ/wyFuSMyKwjbLOon07
         ArQOfWcFbsOVqlT3Ohxbb9UFpI1jK1yTzDuZckLcjnt00g0ZvPMuvNX/TYjn5I7C4rQN
         SRHRAt9wpvWRWoQqvfzbwpb0pUb91lX6VU4Gl7DLPAVw12T67pSUpD9DoX6BOPUtWBhH
         HClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959686; x=1734564486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYJJcdIp4OFdB+jw/mn5ZasDVQdafEZmT3OPk14pFSA=;
        b=pwnQwNyd97+tHmrcpjJISFpGVaxja68/zQIgwXQ1X4SN+x0jwO8VJm8Jc5iPkJPxei
         6hU7VDEwey2R6eyF/l1OHYuEeCbufJkjnLVBbXnlQe4SXYevXUiqGm43qce0onjcoUa/
         ff7r6FXh0aUte/j+Ts06hlb134HLCuGRbze1XRRRvJAAsUndanh5zhikCoHHAx+TcQAA
         VGZo9hHMl6kjVTGqF3PIt8qg49kqKjnhhSKYQEoLt3AzQUE+tjK5rlpYTuK8GX4Ro8FE
         SNyAquPKkL6zDFfNuA8D6LPqOGNk7c4gib+pVe+JeHxSLdoJNXjQYvBEyP0TPkhQBgM1
         yG4A==
X-Forwarded-Encrypted: i=1; AJvYcCUvpQzAlUT/z7nO/HkaJ/by+WLFkkqpy4XttEGR7Xcn6hg+3iy4SS2JlSF0DvDpDYMBpzydXIKeuS8B@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0T37TiuR1QG37OCaYqhiyhnYL7AJ5dnmpxsKFj7/iI6BScTM
	CAMkPgFJbP6x8K3eneHFiH6135x2p4XMT7gj6rf2LhA4NDW88ig+R7uxOa66aswhn5FDowuCS+D
	59iLm06vuTFmUzqJxefK/Ow==
X-Google-Smtp-Source: AGHT+IGKKVpJDJ1y2ylGaA50Z43wv3+APAJV0fjiCw5ytHmnD6GxlKgAyJQZQRFGHnrCD199ncZRE2+HH1UPCzOgAg==
X-Received: from pgbfy22.prod.google.com ([2002:a05:6a02:2a96:b0:7fd:4739:79be])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:328c:b0:1e0:c56f:7db4 with SMTP id adf61e73a8af0-1e1cea71c6cmr1602899637.2.1733959685721;
 Wed, 11 Dec 2024 15:28:05 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:42 -0800
In-Reply-To: <20241211232754.1583023-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-5-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 04/16] mm: alpha: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com, minchan@kernel.org, jyescas@google.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce alpha arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Consolidate error handling in arch_mmap_hint().

 arch/alpha/include/asm/pgtable.h |  1 +
 arch/alpha/kernel/osf_sys.c      | 31 ++++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 635f0a5f5bbd..372885a01abd 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -362,5 +362,6 @@ extern void paging_init(void);
 
 /* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
 #define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* _ALPHA_PGTABLE_H */
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 86185021f75a..308f832732dc 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1225,10 +1225,9 @@ arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
 	return vm_unmapped_area(&info);
 }
 
-unsigned long
-arch_get_unmapped_area(struct file *filp, unsigned long addr,
-		       unsigned long len, unsigned long pgoff,
-		       unsigned long flags, vm_flags_t vm_flags)
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
 {
 	unsigned long limit;
 
@@ -1241,8 +1240,15 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (len > limit)
 		return -ENOMEM;
 
-	if (flags & MAP_FIXED)
-		return addr;
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		       unsigned long len, unsigned long pgoff,
+		       unsigned long flags, vm_flags_t vm_flags)
+{
+	unsigned long limit;
 
 	/* First, see if the given suggestion fits.
 
@@ -1253,12 +1259,15 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	   That said, I can see the use in being able to suggest not
 	   merely specific addresses, but regions of memory -- perhaps
 	   this feature should be incorporated into all ports?  */
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
 
-	if (addr) {
-		addr = arch_get_unmapped_area_1 (PAGE_ALIGN(addr), len, limit);
-		if (addr != (unsigned long) -ENOMEM)
-			return addr;
-	}
+	/* "32 bit" actually means 31 bit, since pointers sign extend.  */
+	if (current->personality & ADDR_LIMIT_32BIT)
+		limit = 0x80000000;
+	else
+		limit = TASK_SIZE;
 
 	/* Next, try allocating at TASK_UNMAPPED_BASE.  */
 	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(TASK_UNMAPPED_BASE),
-- 
2.47.0.338.g60cca15819-goog


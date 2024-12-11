Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406321F63D1
	for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959693; cv=none; b=mDVOegggKRkpKSIXtA8JMZid2o/dnpx+OOltcCjPWLz40Hv4cELwF8f9CmTU3n5/0D9MXIcu1r2RRg1zDloWKb7sQWJm+12YcYFXtWYLIHhUcCNdA17M+DdfKU6OItvFRjH1c7KVKbdj/NHhTgoFCteqsEagAkxQhP7FDFnFIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959693; c=relaxed/simple;
	bh=OABjfOtbfmCcY7qx3gEUORn5iMVfTmN9C0DEpRCjQaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qj9SV+i1/ydFdFUFcm5Dm1noo9L29v5JhC6fjfDqjnxLtHbwPgiltPT7pbR/bGgnIjBq4TTlwJfMGHpmNb+shM7bHpZt9qllzhdjewEaJVopk12B8vcDwOo0Jkk8vF4v/a7rN9EF2nD5o4C5GXxCotKdLJHKeKJBkeM96vqlYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1umiCUIJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1umiCUIJ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725e3c6ad0dso46298b3a.0
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2024 15:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959689; x=1734564489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=My9IlOPq9ns5P/NZxzKqYlKU2U5PkE8SqDXKTXIHc1k=;
        b=1umiCUIJXXrwMzFakb0c0O/Owq7AyGBooM89qAg+AulPQYCTi3UxU3Zsya7zhx4eor
         LzieFlxrxhi+XKfVc59cl+B6h245L5CLopdq//H4KdlJ09V2OLMxyHx5c8aXtDrz7Z4X
         ixx4SRKQ77wHrBKXVuXkGS+f44de91rrIPRmK/YmMSxFzSr7dvcfDkVAzWPQifDqPJBO
         zybFPRDoYiVX7plxkIEDaUI8lg0qBFHj/pkzzQFgH5CiryyoEKugYePbhDcmPfHXt6ss
         UCZ6A3IdJOanzEXEceVpXcaWHRf0asu4bpAayHMaWxZZaQ2dGiZrpFpo7RSQZrwVqEOh
         Ndkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959689; x=1734564489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=My9IlOPq9ns5P/NZxzKqYlKU2U5PkE8SqDXKTXIHc1k=;
        b=tmzDngv7LJ8N6cHbkBwOC+hzyJUYWBnG4R+PGQqQCD/0oji/HDz9uAnbdgN57Daxkw
         2Vx6I9jLpI1Lj1Co7Qn5FMPUQTfJZ2A8qZJ8BI1LOHUz+Wi4xcHhsBvjeVSQXy7Kq12O
         C+6MEaKxtu5D+NxK5cyWoqmKnxu/QXvBg80oz4lN/x7ENvq9gT7M+yeQm4QZ8hU6/+Ou
         zJNDJkqs1raB+iWa9wxvmIZMeagSrT72e07Agwb/72744o0o9lEzkxuibekCk1BH+14V
         1IEaFrsIjLvW2h6AEIEa591Ia4UCm11FTDfnhHOVHhZ5mfvc1rMVms2CqWEibWcWXQkJ
         2nTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7mgjqemRfvRLFn651+GdIWsRv/29zZCD85NWBM56WvNt5cUazy5/KFKn3oYZvkm5EwkmK77XxO4uE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa/RSr0dsvcDoz8uABbJw4WqeD8CxS3JDcTnxGsZl6o4+9XY3X
	643Mq8gbDki5oqW7q1jlMPa1phttvCgYaUemDIXD5kc3vbC9kXd1xGIU2RovTEbUt+v4iWsFW+A
	dDrjKmZ8nYr+MWrx9ULr0KA==
X-Google-Smtp-Source: AGHT+IHgv+hz6lUV53h1smjsDXGUMrAdu+yMyNI0Y1qN6skLJAQw6jBsC8TmY8m6/oNaMxzzcfOLndyqCxWrzR4uSQ==
X-Received: from pgbee13.prod.google.com ([2002:a05:6a02:458d:b0:7fd:4d08:df94])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7890:b0:1db:e40d:5f89 with SMTP id adf61e73a8af0-1e1cebb5277mr1761320637.28.1733959689528;
 Wed, 11 Dec 2024 15:28:09 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:44 -0800
In-Reply-To: <20241211232754.1583023-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-7-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 06/16] mm: csky: Introduce arch_mmap_hint()
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

Introduce csky arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - MAP_FIXED case is also handled in arch_mmap_hint() since this is just a
    special case of the hint addr being "enforced", per Yang Shi.
  - Consolidate error handling in arch_mmap_hint().

 arch/csky/abiv1/inc/abi/pgtable-bits.h |  1 +
 arch/csky/abiv1/mmap.c                 | 68 ++++++++++++++------------
 2 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/pgtable-bits.h b/arch/csky/abiv1/inc/abi/pgtable-bits.h
index ae7a2f76dd42..c346a9fcb522 100644
--- a/arch/csky/abiv1/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv1/inc/abi/pgtable-bits.h
@@ -51,5 +51,6 @@
 					((offset) << 10)})
 
 #define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/abiv1/mmap.c b/arch/csky/abiv1/mmap.c
index 1047865e82a9..0c5c51a081e4 100644
--- a/arch/csky/abiv1/mmap.c
+++ b/arch/csky/abiv1/mmap.c
@@ -13,6 +13,39 @@
 	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
 	 (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	bool do_align;
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	/*
+	 * We only need to do colour alignment if either the I or D
+	 * caches alias.
+	 */
+	do_align = filp || (flags & MAP_SHARED);
+
+	/*
+	 * We enforce the MAP_FIXED case.
+	 */
+	if (flags & MAP_FIXED) {
+		if (flags & MAP_SHARED &&
+		    (addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (do_align)
+		addr = COLOUR_ALIGN(addr, pgoff);
+	else
+		addr = PAGE_ALIGN(addr);
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
 /*
  * We need to ensure that shared mappings are correctly aligned to
  * avoid aliasing issues with VIPT caches.  We need to ensure that
@@ -27,8 +60,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long flags, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	int do_align = 0;
+	bool do_align;
 	struct vm_unmapped_area_info info = {
 		.length = len,
 		.low_limit = mm->mmap_base,
@@ -36,37 +68,11 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		.align_offset = pgoff << PAGE_SHIFT
 	};
 
-	/*
-	 * We only need to do colour alignment if either the I or D
-	 * caches alias.
-	 */
-	do_align = filp || (flags & MAP_SHARED);
-
-	/*
-	 * We enforce the MAP_FIXED case.
-	 */
-	if (flags & MAP_FIXED) {
-		if (flags & MAP_SHARED &&
-		    (addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1))
-			return -EINVAL;
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
 		return addr;
-	}
-
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	if (addr) {
-		if (do_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
-
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
 
+	do_align = filp || (flags & MAP_SHARED);
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	return vm_unmapped_area(&info);
 }
-- 
2.47.0.338.g60cca15819-goog


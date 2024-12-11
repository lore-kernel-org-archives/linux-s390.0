Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955FE1F2C3C
	for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959682; cv=none; b=Bxwtm4EPk6BhSSyu6/TZAk+RYSQjZYOhZPm3ggHy7Wuq2FLWum3sDdBA6xD7ZRQdn8DIQHFN+8kus6ot0jdSlQlj7aamVbQLg/XQ8e3CbA06GcAbRTFqx80IYUmmiaXEZlyQx1P7ZvdpcUbbJLAzmjDQMJWnu0sADEgioRy18Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959682; c=relaxed/simple;
	bh=5kEtQOaPanyE2cx8lsqVLC93wX6vcTaHvurrW1k4Yig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTZAS0pW1+sRSsVnXsfK9nzUKw7Hu6L/mQTTlMM0TCqo9wFbMEA8rbIfB/iV70z5NcnB7i13WUAC9EFeo80r5rdZxOO1JV0pZ8JsS9qwKKALPjGjjFd0tsDRjVCwNYoxL+uXyABf3w4pigjGTMpLsWT3Qw1Fdpo2MG0e07D4I7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9mU/wIo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9mU/wIo"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea8c2b257bso43425a12.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2024 15:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959680; x=1734564480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4sLwXeXnZGwZmaOI+TJwHO8calXr1XpV7HCaSQYyYY=;
        b=q9mU/wIoJVgmu21ln5xeVjwpMGBbR3GaD+A9DgICdmHVElUhvydm8POdDunankc+9D
         VRQ/TSxUyov53jBrWDqVVZnluaU8i7njJnwglBIwRTNRvBlwXKcnB7sjJLncO68D3TKl
         tkIvGfDlEs4lh79XBvskOex67yRoMz/YgfxKb9IHmnbnvLgnzrzT1lJmTeUqqBqX5nsN
         etMq88yL/xI7zpo9I5ODI1ueR3E7yk0MhlksZdtDsiI13k2E1ptAZQVbFW2QT7F66cv0
         ANXNparaNz2whfZElMDHpqOSteQne1D11s9enIkSJxwGd80vSluJJPa/jAR2cACb6BTB
         wwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959680; x=1734564480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4sLwXeXnZGwZmaOI+TJwHO8calXr1XpV7HCaSQYyYY=;
        b=lH81SDFRFzLx2pI9zvmN2+1mU/t53l7yT0qUVIXLf9UalcHQQ6zHD31L99iydU3U0C
         lO13O4ikQSxd08+LngQWGAQ5iUKBSaRK3FZZEsIY+AyJEPJ8v9BCvp8kmFZQ+ZVrHAS3
         ow3VWf+jnMEFEeByDdw6XlFmgszJt+0cQ3KDHZ540J9PX3ia4hd6PIcnzwPVZ26ss9j9
         gQ6bzzuYrqYqNGSlYZ+Wh+xzRCte3qXsmfOKsuCnse0rzjyoDV+UYGrzM5J6nKSgAcVf
         R7m0C33sDF6gudHnf+yFLsXholy4RfWe4PaItEpDrdP6ThB9hKP9V1HZwWtksdWfzYnr
         Hzgg==
X-Forwarded-Encrypted: i=1; AJvYcCWdY/H4GJATRSAMqdJpLm85Xy40BVNpH/nfdn3JX2YhjDo6+v+l2vRWgdyln2vO6SOSDNvLGR90L0JC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxom45PM9/ACm/bRedUdO0S2LFm43h2nPyNifaByjbxVCvAGAjl
	ivSkZoQ1lVQ9KCeXc7qTsFQ8UmquGNzcvRL4MbTBv7e4Jm32WS6lillfY+VxIjdm4O7KbARSQhx
	igb/pdYwM52YdbbWgFWRPLQ==
X-Google-Smtp-Source: AGHT+IFtd/N2pCFnI2u1d5m96JgTZmL7tbAt9a9u3MHy4m9H51vxoRQ9F2QC80/CNULE+uh+FoVAQHYq51Gg3PfRrg==
X-Received: from pjf11.prod.google.com ([2002:a17:90b:3f0b:b0:2ea:29de:af10])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2790:b0:2ee:f80c:688d with SMTP id 98e67ed59e1d1-2f12802a503mr6866191a91.25.1733959679820;
 Wed, 11 Dec 2024 15:27:59 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:39 -0800
In-Reply-To: <20241211232754.1583023-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-2-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 01/16] mm: Introduce generic_mmap_hint()
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

Consolidate the hint searches from both directions (topdown and
bottomup) into generic_mmap_hint().

No functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - MAP_FIXED case is also handled in arch_mmap_hint() since this is just a
    special case of the hint addr being "enforced", per Yang Shi.
  - Consolidate error handling in arch_mmap_hint().

 include/linux/sched/mm.h |  4 +++
 mm/mmap.c                | 76 ++++++++++++++++++++++++----------------
 2 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 928a626725e6..edeec19d1708 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -201,6 +201,10 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm,
 					   unsigned long flags,
 					   vm_flags_t vm_flags);
 
+unsigned long generic_mmap_hint(struct file *filp, unsigned long addr,
+				unsigned long len, unsigned long pgoff,
+				unsigned long flags);
+
 unsigned long
 generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			  unsigned long len, unsigned long pgoff,
diff --git a/mm/mmap.c b/mm/mmap.c
index df9154b15ef9..382b4eac5406 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -620,6 +620,47 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 	return addr;
 }
 
+/*
+ * Look up unmapped area at the requested hint addr
+ *
+ * NOTE: MAP_FIXED is also handled here since it's a special case of
+ * enforcing the hint address.
+ *
+ * Returns:
+ *    ERR_VALUE: If the requested mapping is not valid
+ *    0: If there isn't a sufficiently large hole at the hint addr.
+ *    addr: If sufficient VA space is available at the hint address;
+ *          or MAP_FIXED was specified.
+ */
+unsigned long generic_mmap_hint(struct file *filp, unsigned long addr,
+				unsigned long len, unsigned long pgoff,
+				unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
+
+	/* requested length too big for entire address space */
+	if (len > mmap_end - mmap_min_addr)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED)
+		return addr;
+
+	if (!addr)
+		return 0;
+
+	addr = PAGE_ALIGN(addr);
+	vma = find_vma_prev(mm, addr, &prev);
+	if (mmap_end - len >= addr && addr >= mmap_min_addr &&
+	    (!vma || addr + len <= vm_start_gap(vma)) &&
+	    (!prev || addr >= vm_end_gap(prev)))
+		return addr;
+
+	/* Fallback to VA space search */
+	return 0;
+}
+
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.
  *
@@ -637,25 +678,13 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			  unsigned long flags, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma, *prev;
 	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
-	if (len > mmap_end - mmap_min_addr)
-		return -ENOMEM;
-
-	if (flags & MAP_FIXED)
+	addr = generic_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
 		return addr;
 
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma_prev(mm, addr, &prev);
-		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)) &&
-		    (!prev || addr >= vm_end_gap(prev)))
-			return addr;
-	}
-
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = mmap_end;
@@ -685,27 +714,14 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 				  unsigned long len, unsigned long pgoff,
 				  unsigned long flags, vm_flags_t vm_flags)
 {
-	struct vm_area_struct *vma, *prev;
 	struct mm_struct *mm = current->mm;
 	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
-	/* requested length too big for entire address space */
-	if (len > mmap_end - mmap_min_addr)
-		return -ENOMEM;
-
-	if (flags & MAP_FIXED)
-		return addr;
-
 	/* requesting a specific address */
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma_prev(mm, addr, &prev);
-		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
-				(!vma || addr + len <= vm_start_gap(vma)) &&
-				(!prev || addr >= vm_end_gap(prev)))
-			return addr;
-	}
+	addr = generic_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-- 
2.47.0.338.g60cca15819-goog


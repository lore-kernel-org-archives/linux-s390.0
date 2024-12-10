Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D951A38C2
	for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798490; cv=none; b=O2eoAZqCPnbMc5G7RQE3NCCbySBbvYcAmpNoLSnaTSirvJKYegA90RlpyxyGAgn21NfMrwWw5iP8RAKZ3/FNenpdBu9n05vPVRzuymlge0mu5Yb8MgRwG2ICeS7/LiwSGLBOGOqUCQ0iJDvJa0G+3dy6yn5QTj6RrlcpBReipno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798490; c=relaxed/simple;
	bh=19L6aWTbUklXgyuLwc9lQb9GeizOsqsDpK5qvojjnAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZMiUipJT2/bVnux2XPcjDAsustfXrRdakC4DiaEnu0oC/Kp5Ou4458QQEClKNLeV3gTGnXWtyrT/WvUxZKHPzs5O4csb1LaM1dbCoZlE7opFh+Dmi51ZzmNGCKu/XLW7BM+9SGOAPA+OGh4FB/Qkq5StLXaSeXdiNKlFnam/8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXNa8drT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXNa8drT"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee46799961so6426556a91.2
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2024 18:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798487; x=1734403287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BgI/2JSXOfwO1cJ/ZJEscy7eN8JKVXEE4s6V/DqQoM=;
        b=xXNa8drT5n7oR1fYVqo9MiAD7mrYMFMoxmxBzjDIZiuEBirtgRJgsHyD8NTpSlo04I
         V0apVcs1HbWXfC9F85A48KLE1oiTtbrqSfErPqKePBQATzgl6EUbJqFfnvhp30I8dc2/
         W+gLHORwM+z3LVmWnmaBlsHkNlHANMY6ClOV6bDf3itSf2ZBa8IQLONXxELMab2YHCfv
         P7C4Il5+r1k1SIPq1no3/QmD/NPoD6cNqT1Aa2JrlHj9k4NeQ/5YEOXdI4fzR6tTjoZ9
         jQ/6Fh6Mb3yJYWEhyzDssJ8lmUNXsDhlFTaSwCkZYHn8Lwsy5ian0BAXxSA+6JgyY9v7
         Ws5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798487; x=1734403287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BgI/2JSXOfwO1cJ/ZJEscy7eN8JKVXEE4s6V/DqQoM=;
        b=DYYh9Td052j/X7cVy8wWqC4lTyHzn0rEs/SDmkIBXCEOpjlazYfD5SJ2X2uhMO8w/Q
         or2Tx0/24UrRHEbcM3g//VIkOfxlTydIwwhuqy4bQqTOnXvIcj+PNhrejjw7+18dLMao
         jsk0FKQbC6iN7L04r0xflgXfBq4hxfxO9JF6hzETUy9a2rCHCd5KiRG/65fRdQ6HPz18
         EBwZJCnPATlJfsWwyUHb5BJlDFLpUgqMRAyg1yvqFYNSu8ydxQYHDlW3fxfPHJqt5QQN
         ZEm+YvZT6BI/qOgRP8XbBUtopDgtFjq0AVNlX4xY/1HluakjWRivs88HJpMQwMGCaiWb
         s1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCX5uAHSkqJcOx107C2NXXBf8VrAR5erIaG97SPTB/MNXCtppR8eVBOBHy6dBb3OVV5hYKyFuC8XSLUY@vger.kernel.org
X-Gm-Message-State: AOJu0YybT3BZfhYMLOdormJ4NpuD62VRrWDAKtbftxAuVOpTk/+Bx++u
	G5vOWzNJ0cwUJl3Q4NjGtgsilR41cyuPyZIizdqEIIQob+KJTIIJre2M1XDbOXRGuZ83EPo7YF9
	NYsmbpJ2+OSCgd6PkZyY7jQ==
X-Google-Smtp-Source: AGHT+IHGMMlno4Vk4yfFbORjSDqS/i277l7+d9BxYohAoyJsB+e3g5dCRC4WlkbDRxt5bsVXivF+KHNj2TLxNR/xQA==
X-Received: from pjbpd17.prod.google.com ([2002:a17:90b:1dd1:b0:2ef:d283:5089])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e43:b0:2ee:6d04:9dac with SMTP id 98e67ed59e1d1-2ef6ab27c90mr19454039a91.32.1733798487472;
 Mon, 09 Dec 2024 18:41:27 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:04 -0800
In-Reply-To: <20241210024119.2488608-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-3-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 02/17] mm: x86: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com
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

Introduce x86 arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/x86/include/asm/pgtable_64.h |  1 +
 arch/x86/kernel/sys_x86_64.c      | 49 ++++++++++++++++++-------------
 include/linux/sched/mm.h          |  4 +++
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index d1426b64c1b9..4472fd0040c3 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -245,6 +245,7 @@ extern void cleanup_highmap(void);
 
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_MMAP_HINT
 
 #define PAGE_AGP    PAGE_KERNEL_NOCACHE
 #define HAVE_PAGE_AGP 1
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 776ae6fa7f2d..95a39ef915b7 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -123,12 +123,32 @@ static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
 	return 0;
 }
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	unsigned long begin, end;
+
+	if (!addr)
+		return 0;
+
+	find_start_end(addr, flags, &begin, &end);
+
+	addr = PAGE_ALIGN(addr);
+
+	if (!mmap_address_hint_valid(addr, len))
+		return 0;
+
+	if (len > end)
+		return 0;
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
 unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len,
 		       unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	struct vm_unmapped_area_info info = {};
 	unsigned long begin, end;
 
@@ -140,13 +160,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len,
 	if (len > end)
 		return -ENOMEM;
 
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma(mm, addr);
-		if (end - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
 
 	info.length = len;
 	info.low_limit = begin;
@@ -168,8 +184,6 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr0,
 			  unsigned long len, unsigned long pgoff,
 			  unsigned long flags, vm_flags_t vm_flags)
 {
-	struct vm_area_struct *vma;
-	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info = {};
 
@@ -186,16 +200,9 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr0,
 		goto bottomup;
 
 	/* requesting a specific address */
-	if (addr) {
-		addr &= PAGE_MASK;
-		if (!mmap_address_hint_valid(addr, len))
-			goto get_unmapped_area;
-
-		vma = find_vma(mm, addr);
-		if (!vma || addr + len <= vm_start_gap(vma))
-			return addr;
-	}
-get_unmapped_area:
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index edeec19d1708..f12d094649f7 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -205,6 +205,10 @@ unsigned long generic_mmap_hint(struct file *filp, unsigned long addr,
 				unsigned long len, unsigned long pgoff,
 				unsigned long flags);
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags);
+
 unsigned long
 generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			  unsigned long len, unsigned long pgoff,
-- 
2.47.0.338.g60cca15819-goog


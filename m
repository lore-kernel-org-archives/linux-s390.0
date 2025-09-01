Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C830E82D
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718379; cv=none; b=rfRgXX0/3KzF4Y/I0Mkay1UAcYbO1QbYCvzJH6UUNgASL1hqj95j5JP5eE74U0o0KYsXNoTV4QQCcoYuGcAiCueWzW1CkFSIjN2iQVBmviCyQQInl1W3R2tN4EgRirgxcqZ4Mr1TnA43xtLimGPCMprMLPBXQYeteQeCAtDV/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718379; c=relaxed/simple;
	bh=TfvBp8NaXvn+VfxQh9MP9xDTHhgA71LSeNxAeqrwpZI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJf8UlMpMHyjQiTy+HsWpK8lg18Gkr0Mu6u0ZP8iJuSPGMW+L0LlBQOYUMSF3HHlnhkH0yfuKtTa7dresrHBfaN5IKWdqa8oEsIU8dVfCJBoJgXD2Fefi5DuWfJ8htDO4xumydo+oE+4ZioxJombtZo0oh1Vo1CPPwRJ0AVd294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=V1oS9kVW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="V1oS9kVW"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afee6037847so626140866b.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718375; x=1757323175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbwvQejYab/rePViSXLSZNeM/TCyXeV95uglwFlMcys=;
        b=V1oS9kVWlNMM+fTF+KaNHdoniy/e+376JDtPezoLf/v1KAARaqFE+SdEnImBVPA+Uj
         yDxGhqDHQP+I/S7gy+CdtDnJHCtbmNziBiarkIbs74DVg3CEpmYGWZk+MjcVXHxMqKrC
         ZtuQZ4XbUkQ/56rt+lYLeXibI6gPJ1DlsZgoEQA091PQkOUXBgYHmmMofi5fubkZYlRl
         YWhJwvzUUUB41tgXeUwHHtj53piLFdVpOhbwoe3WSgh+Bgr7M9KhAJKUEMwl3UHTwz0a
         ORVRl1Pvw2NWybh41TCTvvrGmim064+BXjawh3pf8v1bTqImHMyfMQ4W/4Qcrw4vCsbc
         wz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718375; x=1757323175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbwvQejYab/rePViSXLSZNeM/TCyXeV95uglwFlMcys=;
        b=lYNjW8pXpQkd773ru//jyKboUQHoYLeouKuYR4uAWqQEHFq+eLwL4iePrDRFqERFxV
         Bj+BLHbzCp/6ux2KKHzNArDyBIpm0kWxUvPRCSGbqzkX3eGdZMi0cc0LsWehaIX5PN6O
         EqrwR/q5CUS/rczJiSCgh5bD4vJijUp+rJCkWNEEy00e5EkSZksZ2A/HapOcSRtXAHoM
         u2Xu9AeNzBtJ5a4GX3mnQTLD3eoF2dukOKgFADn7GG6ENKRoe5ENVpQQHhFdfiYDZexC
         zcDkjEpw2VabEyUDNAbrnlsVZhi6hLn3O7Vx4ZrEChd6jQDQwp0tyji3qg2/azKV+sF2
         wTNg==
X-Forwarded-Encrypted: i=1; AJvYcCWPgET68z3AYnfigPUVmxJuchhEzL3WsR4BdPPF/0uYIHCnI03+w5j1laCotWy6pHQcaBV+tcSeJVg0@vger.kernel.org
X-Gm-Message-State: AOJu0YwSPtrmB82Mp0bxcf38b/+9BlLFxg81acLGQ45uCXQUXxdMAAi4
	nTJC1PQvklUPHU4OA26OTxluw8FAERJL+Jmyzx2gnyfPPZvYHUbq2V3R/QwoCAd0H+8=
X-Gm-Gg: ASbGncvchFwE+/VOuumvFtzzoEfvANZ/OUXINPfRdXjM4lrrW7qmDY3ROGZdhJPOsQ5
	BN0tLA49EqtIo3i4xAEq4zYsi2dyxgPOI8t5mPP6hBXaoX3xaKCNjwX1JBHIfwV/25N/2T1zpYa
	D22vnSeLVnNphQ90y/gvLdm8lwrqn3AwwAKDEvpZgdPRpXY8ecerULL+I5hom5EyTS7WmnuHSl1
	HcS79qpsLeXQdJ5mKuOW0vCXaJnZd+qPJa26kkOfp0NzRdG6aUEqtB2VpatQzDmj2qrrqKezfnJ
	nGMA5VEnEBxIu3n+r3hqyflIFvhsYkyRKxjruXyB+uaJVQxZT6bfI34yLcKTFXZPieiDRHpNl5x
	YyZEXCbX82x+iEe80MmM1sLDB5xlP9EIAQeO/6SRqQjBbBjd5BIhQd3jZ3uvwc3fHEf7mA3h8uP
	Nmk7D+hEgs4e1iA1cGE9D812Wl43gT+YUl
X-Google-Smtp-Source: AGHT+IFjLUezk0MNPBdl2gvK25UHEhY1rnJIkox6nR/OlA7eUuvIfWjMQ4n5LH61nexh9wBub/G+rQ==
X-Received: by 2002:a17:907:86aa:b0:afe:b5fa:2adc with SMTP id a640c23a62f3a-b01d8c7d928mr753689766b.24.1756718374952;
        Mon, 01 Sep 2025 02:19:34 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:34 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 06/12] mm/util, s390: add const to pointer parameters for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:09 +0200
Message-ID: <20250901091916.3002082-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifiers to rlimit, vm_area_struct, mm_struct,
and folio pointer parameters in mm/util.c and s390 arch code that do not
modify the referenced memory, improving type safety and enabling compiler
optimizations.

Functions improved:
- mmap_is_legacy() (both mm/util.c and s390)
- vma_is_stack_for_current()
- __vm_enough_memory()
- folio_mapping()

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/mm/mmap.c     |  2 +-
 include/linux/mm.h      |  6 +++---
 include/linux/pagemap.h |  2 +-
 mm/util.c               | 11 ++++++-----
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 547104ccc22a..c0f619fb9ab3 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -27,7 +27,7 @@ static unsigned long stack_maxrandom_size(void)
 	return STACK_RND_MASK << PAGE_SHIFT;
 }
 
-static inline int mmap_is_legacy(struct rlimit *rlim_stack)
+static inline int mmap_is_legacy(const struct rlimit *const rlim_stack)
 {
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f70c6b4d5f80..23864c3519d6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -986,7 +986,7 @@ static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false
 static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
 #endif
 
-int vma_is_stack_for_current(struct vm_area_struct *vma);
+int vma_is_stack_for_current(const struct vm_area_struct *vma);
 
 /* flush_tlb_range() takes a vma, not a mm, and can care about flags */
 #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
@@ -2585,7 +2585,7 @@ void folio_add_pin(struct folio *folio);
 
 int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
-			struct task_struct *task, bool bypass_rlim);
+			const struct task_struct *task, bool bypass_rlim);
 
 struct kvec;
 struct page *get_dump_page(unsigned long addr, int *locked);
@@ -3348,7 +3348,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
 
 /* mmap.c */
-extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
+extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
 bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1d35f9e1416e..968b58a97236 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -551,7 +551,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 #endif
 }
 
-struct address_space *folio_mapping(struct folio *);
+struct address_space *folio_mapping(const struct folio *folio);
 
 /**
  * folio_flush_mapping - Find the file mapping this folio belongs to.
diff --git a/mm/util.c b/mm/util.c
index d235b74f7aff..f5a35efba7bf 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -315,7 +315,7 @@ void *memdup_user_nul(const void __user *src, size_t len)
 EXPORT_SYMBOL(memdup_user_nul);
 
 /* Check if the vma is being used as a stack by this task */
-int vma_is_stack_for_current(struct vm_area_struct *vma)
+int vma_is_stack_for_current(const struct vm_area_struct *const vma)
 {
 	struct task_struct * __maybe_unused t = current;
 
@@ -410,7 +410,7 @@ unsigned long arch_mmap_rnd(void)
 	return rnd << PAGE_SHIFT;
 }
 
-static int mmap_is_legacy(struct rlimit *rlim_stack)
+static int mmap_is_legacy(const struct rlimit *const rlim_stack)
 {
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
  * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
  */
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
-			struct task_struct *task, bool bypass_rlim)
+			const struct task_struct *const task, const bool bypass_rlim)
 {
 	unsigned long locked_vm, limit;
 	int ret = 0;
@@ -688,7 +688,7 @@ struct anon_vma *folio_anon_vma(const struct folio *folio)
  * You can call this for folios which aren't in the swap cache or page
  * cache and it will return NULL.
  */
-struct address_space *folio_mapping(struct folio *folio)
+struct address_space *folio_mapping(const struct folio *const folio)
 {
 	struct address_space *mapping;
 
@@ -926,7 +926,8 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
  * Note this is a helper function intended to be used by LSMs which
  * wish to use this logic.
  */
-int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
+int __vm_enough_memory(const struct mm_struct *const mm,
+		       const long pages, const int cap_sys_admin)
 {
 	long allowed;
 	unsigned long bytes_failed;
-- 
2.47.2


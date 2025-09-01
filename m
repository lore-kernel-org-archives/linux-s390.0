Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF7278154
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759843; cv=none; b=hl3eEewqvnxZacz1+S1e3iCNHM5JYuKQa/OmJarTQppLiFSbmktkCOREr/wkM01RIvfphvAMopTwA+1H0C/x2pmezSZkknRsOLxTrvD1c5+Ri2jqrp8hoaiu9cKCj9UwuAiKNmyiTE3/hjOe+aM1FwwAZ3jEoszwN23i0Apw0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759843; c=relaxed/simple;
	bh=rDmpfZbO2s2x50UxmePctxd+ld3/Z2MAdzz2RJEbNaI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjXm3rAW/mdE3hJKezVRrbwAiZ26IHnvExmVdxhAa3Z8a35bCGyX3uzM1o3yfkFfdTx841CqwqyHy+nfI5ECoW/t5KrRLa1LkJtPX5WQhQDiONHr+q+EK0icyhB4FcI/ejzld6g230a1JENKFfuLpo58e6ZlkWa+QnImMlB2Ej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Lq7okukd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Lq7okukd"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0225483ca0so384264866b.2
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759839; x=1757364639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sn4h0BpPfxBDaFwO8h+hIU8dGesIzlZ2oiTQdwK6a9M=;
        b=Lq7okukdfOBSWr4CffmCP1G03PwNjT8b5lBzoFt8S1FlI8bEzAQ/sxIRecDtV4kqkg
         RITlIccDuo1La3TdCenYv5bcUP+yVIWz1rgQ/Xl0zQbuIqnsUSrOUO0RQQu0PFW0TOkG
         08PZZzGA4rdYmutoazD+LH4/DMQgDNFx+syh9dYuiNB+HopFS7b3zSGAIC/+bAUYbg9x
         SqdJJkDTP5E0GNfnBaLcgWs8axFmCwb7Rxt9Cf0xEB9jtY5Qcc6TtDIPmMdPJl8sj2Tu
         eNF78I2KVdaWTKK5o2YojxVUvJe4UwEH5foo86XmnNRWn4dXUgCPnwwfbEFpABW9fXyk
         ch1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759839; x=1757364639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn4h0BpPfxBDaFwO8h+hIU8dGesIzlZ2oiTQdwK6a9M=;
        b=hDtLIx/qfbOv2T8FB2+9Ol2EftkinWVNKSkWcFoMJiabpZpa4toju+GAIOw+2DwE8L
         a9pJbGnoNdFiaQcu2xQ5x04yQtgNjMUHSOJ0utoA35lgFVNgFt4kmz+HZ4RBKtBK95TE
         WW+fVvkxTNsipbAYEWkGRmUeAZ/LNggfGshwm6q7L8ZgXSWPgliW+ez8eSbihm98o9Vp
         dWMXOaujO79DoyFGat6p1nzNkny0BchqlaEZHhFQM3SLaB/Y11+X3+gwWJo8GSWptbBN
         kDNZ7vpYXWjPVeymtFsJyHNMpcJPTxEN1/ujulpLGFx5fLS39i4tjZkYRJ7L13ZiD35S
         UmZA==
X-Forwarded-Encrypted: i=1; AJvYcCWjblBXLToJWxWMl81gzlR3j9LlkC45ApD2H9h0UAek4U2cv76K588B8WV94ukZw/UFbpmgeKeZIZpB@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDKKP5rKFLRu3HdnwPzvrUyEbJDTT4wKdw3hSmkiEXzq1+0qU
	RoIEIixi6HyF1vevc2mWaEYxTMZM3UG11VbCufPuSiYBnWu3uXhHyMbgT4l+REkziLY=
X-Gm-Gg: ASbGncv42RlGBpSZ92rZoYT0QhULKUPTXWahFdrHVPLIsrbAzNqUmi3H+DOwFAv+MWL
	IFEjjsQuPwcnhXH31GayMs1/Ktn5bPb1yyqzJgcJSDdzbPCW6SXHKvqfxQoUZuAc2sFrnVSILnN
	dtmjOp3yMDlWp4dfEziozG1Hdq23kvGK7xgYNb/XnD+cMy4gSdLEgWeyvNsxRd/BLmMG/6slBEo
	0/0cian3i8dL2C3CT9x5Mbo+7typGUyXiryMnU0ZJCr06Q4K+c/JsTx4ffKjNxsH0EsJU7M+xWJ
	8yGVgyVWnLuGHkTOzB2qYyOgZAZoDpyUA7y408nRSkVg8pxWwMAUdOE3ceRlFNAJXCKlD/Ml9m/
	CMjv3n4WBExJY7Syh5QEP+5Rxe1jDpiFcUBgM5+Y1klZYp5LmAIXr6L2z5azYM8Wor718wWUnOy
	8cNMYuZ2kWxTJeM73sWtFY2g==
X-Google-Smtp-Source: AGHT+IH0D71brvthuz6NiuqLrZIK2MWi3wUSZ97rcXr8aVNySfvYxdzD2MYQW/mxQZhh964lwy06dA==
X-Received: by 2002:a17:906:ee85:b0:afe:9e58:7550 with SMTP id a640c23a62f3a-b01d8a7131dmr869222766b.19.1756759839098;
        Mon, 01 Sep 2025 13:50:39 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:38 -0700 (PDT)
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
Subject: [PATCH v6 06/12] mm, s390: constify mapping related test/getter functions
Date: Mon,  1 Sep 2025 22:50:15 +0200
Message-ID: <20250901205021.3573313-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

(Even though seemingly unrelated, this also constifies the pointer
parameter of mmap_is_legacy() in arch/s390/mm/mmap.c because a copy of
the function exists in mm/util.c.)

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/mm/mmap.c     |  2 +-
 include/linux/mm.h      |  6 +++---
 include/linux/pagemap.h |  2 +-
 mm/util.c               | 10 +++++-----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 547104ccc22a..e188cb6d4946 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -27,7 +27,7 @@ static unsigned long stack_maxrandom_size(void)
 	return STACK_RND_MASK << PAGE_SHIFT;
 }
 
-static inline int mmap_is_legacy(struct rlimit *rlim_stack)
+static inline int mmap_is_legacy(const struct rlimit *rlim_stack)
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
index 1d3803c397e9..185644e288ea 100644
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
index d235b74f7aff..241d2eaf26ca 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -315,7 +315,7 @@ void *memdup_user_nul(const void __user *src, size_t len)
 EXPORT_SYMBOL(memdup_user_nul);
 
 /* Check if the vma is being used as a stack by this task */
-int vma_is_stack_for_current(struct vm_area_struct *vma)
+int vma_is_stack_for_current(const struct vm_area_struct *vma)
 {
 	struct task_struct * __maybe_unused t = current;
 
@@ -410,7 +410,7 @@ unsigned long arch_mmap_rnd(void)
 	return rnd << PAGE_SHIFT;
 }
 
-static int mmap_is_legacy(struct rlimit *rlim_stack)
+static int mmap_is_legacy(const struct rlimit *rlim_stack)
 {
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
  * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
  */
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
-			struct task_struct *task, bool bypass_rlim)
+			const struct task_struct *task, bool bypass_rlim)
 {
 	unsigned long locked_vm, limit;
 	int ret = 0;
@@ -688,7 +688,7 @@ struct anon_vma *folio_anon_vma(const struct folio *folio)
  * You can call this for folios which aren't in the swap cache or page
  * cache and it will return NULL.
  */
-struct address_space *folio_mapping(struct folio *folio)
+struct address_space *folio_mapping(const struct folio *folio)
 {
 	struct address_space *mapping;
 
@@ -926,7 +926,7 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
  * Note this is a helper function intended to be used by LSMs which
  * wish to use this logic.
  */
-int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
+int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin)
 {
 	long allowed;
 	unsigned long bytes_failed;
-- 
2.47.2


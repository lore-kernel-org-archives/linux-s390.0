Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA36BFA5
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133511; cv=none; b=CtmBmooTedeMBJqC30l93rO9pCw6du3HUWh2r1m0J1hVQ0d4bMycsjizLWeHBgbzLGVl0XrOQ4kDvr4i9oB3gP4dEpcOPSPcLTAugU8bXLIiEyvQuZQwrkXFQDZxqKH8z/10kPbS4xAalWXNx94iv/+Hmg3YK/9KlKFTtTbx5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133511; c=relaxed/simple;
	bh=l4P/M5DPUnnyu7bgec2+SlA2MGE85helt9TVf9U4WCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyRt22edHs+4jxdkREc9EwtiqtNlC3j157oFZvH4Kf4i08JWJO/tZeQ/wHm+YWzI0x5hBSfOBmJ4tstu3Vuq93H5EbIEFmmCqyuuYsxHX6lhIhi/sjxpDaADMzRdx5q45o4hile3m3ofe3OpTye7ErbRRPNR0Eg4bOOHX1BIdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V8dP90NXPz29lXd;
	Wed,  3 Apr 2024 16:35:41 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B1225140410;
	Wed,  3 Apr 2024 16:38:26 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 16:38:25 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: <akpm@linux-foundation.org>
CC: Russell King <linux@armlinux.org.uk>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <surenb@google.com>, <linux-mm@kvack.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 4/7] powerpc: mm: accelerate pagefault when badaccess
Date: Wed, 3 Apr 2024 16:38:02 +0800
Message-ID: <20240403083805.1818160-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
References: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)

The access_[pkey]_error() of vma already checked under per-VMA lock, if
it is a bad access, directly handle error, no need to retry with mmap_lock
again. In order to release the correct lock, pass the mm_struct into
bad_access_pkey()/bad_access(), if mm is NULL, release vma lock, or
release mmap_lock. Since the page faut is handled under per-VMA lock,
count it as a vma lock event with VMA_LOCK_SUCCESS.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/powerpc/mm/fault.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 53335ae21a40..215690452495 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -71,23 +71,26 @@ static noinline int bad_area_nosemaphore(struct pt_regs *regs, unsigned long add
 	return __bad_area_nosemaphore(regs, address, SEGV_MAPERR);
 }
 
-static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code)
+static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code,
+		      struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct mm_struct *mm = current->mm;
 
 	/*
 	 * Something tried to access memory that isn't in our memory map..
 	 * Fix it, but check if it's kernel or user first..
 	 */
-	mmap_read_unlock(mm);
+	if (mm)
+		mmap_read_unlock(mm);
+	else
+		vma_end_read(vma);
 
 	return __bad_area_nosemaphore(regs, address, si_code);
 }
 
 static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long address,
+				    struct mm_struct *mm,
 				    struct vm_area_struct *vma)
 {
-	struct mm_struct *mm = current->mm;
 	int pkey;
 
 	/*
@@ -109,7 +112,10 @@ static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long address,
 	 */
 	pkey = vma_pkey(vma);
 
-	mmap_read_unlock(mm);
+	if (mm)
+		mmap_read_unlock(mm);
+	else
+		vma_end_read(vma);
 
 	/*
 	 * If we are in kernel mode, bail out with a SEGV, this will
@@ -124,9 +130,10 @@ static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long address,
 	return 0;
 }
 
-static noinline int bad_access(struct pt_regs *regs, unsigned long address)
+static noinline int bad_access(struct pt_regs *regs, unsigned long address,
+			       struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	return __bad_area(regs, address, SEGV_ACCERR);
+	return __bad_area(regs, address, SEGV_ACCERR, mm, vma);
 }
 
 static int do_sigbus(struct pt_regs *regs, unsigned long address,
@@ -479,13 +486,13 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (unlikely(access_pkey_error(is_write, is_exec,
 				       (error_code & DSISR_KEYFAULT), vma))) {
-		vma_end_read(vma);
-		goto lock_mmap;
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		return bad_access_pkey(regs, address, NULL, vma);
 	}
 
 	if (unlikely(access_error(is_write, is_exec, vma))) {
-		vma_end_read(vma);
-		goto lock_mmap;
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		return bad_access(regs, address, NULL, vma);
 	}
 
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
@@ -521,10 +528,10 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (unlikely(access_pkey_error(is_write, is_exec,
 				       (error_code & DSISR_KEYFAULT), vma)))
-		return bad_access_pkey(regs, address, vma);
+		return bad_access_pkey(regs, address, mm, vma);
 
 	if (unlikely(access_error(is_write, is_exec, vma)))
-		return bad_access(regs, address);
+		return bad_access(regs, address, mm, vma);
 
 	/*
 	 * If for any reason at all we couldn't handle the fault,
-- 
2.27.0


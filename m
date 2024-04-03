Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A95C909
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133510; cv=none; b=On4LL/BXnXxF1Hko0SH9US5regWNPNsfTIoOvDcTHENNTcaBQ+lboFBEYtHdb1PiO7ykygecc9b5fWEVx75ZV2z0cOKkU1osAj6fxqBMfa0lovbkxx4eGREGgCyXuK86D0Mm3I/Shtdz9+7663uodmQ9v9rHolJIHbw71L5Jogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133510; c=relaxed/simple;
	bh=yVhz44v2GeS+/rimzK4OF/+fK9LiPs43Ft+L/Xq5Tsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uhw3eiFgCOd4PvEfgVeT8aM3BkWE+xj2tf4umimTKJEJIGd5QQRuRl7LBzKbOk/9ytDory97z+c9TVnwytl4htSSBi9FhbW0NKaAZkkNCEBL4yxBxt/guvaTLPqq2poae+q4kQkCUhhe9A2hRK2xyVDVZPzvCmUBBb2BqlgxyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V8dP626VPz29lXb;
	Wed,  3 Apr 2024 16:35:38 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id EC3921A0172;
	Wed,  3 Apr 2024 16:38:23 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 16:38:22 +0800
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
Subject: [PATCH v2 1/7] arm64: mm: cleanup __do_page_fault()
Date: Wed, 3 Apr 2024 16:37:59 +0800
Message-ID: <20240403083805.1818160-2-wangkefeng.wang@huawei.com>
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

The __do_page_fault() only calls handle_mm_fault() after vm_flags
checked, and it is only called by do_page_fault(), let's squash
it into do_page_fault() to cleanup code.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/mm/fault.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8251e2fea9c7..9bb9f395351a 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -486,25 +486,6 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 	}
 }
 
-#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
-
-static vm_fault_t __do_page_fault(struct mm_struct *mm,
-				  struct vm_area_struct *vma, unsigned long addr,
-				  unsigned int mm_flags, unsigned long vm_flags,
-				  struct pt_regs *regs)
-{
-	/*
-	 * Ok, we have a good vm_area for this memory access, so we can handle
-	 * it.
-	 * Check that the permissions on the VMA allow for the fault which
-	 * occurred.
-	 */
-	if (!(vma->vm_flags & vm_flags))
-		return VM_FAULT_BADACCESS;
-	return handle_mm_fault(vma, addr, mm_flags, regs);
-}
-
 static bool is_el0_instruction_abort(unsigned long esr)
 {
 	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
@@ -519,6 +500,9 @@ static bool is_write_abort(unsigned long esr)
 	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
 }
 
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+
 static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 				   struct pt_regs *regs)
 {
@@ -617,7 +601,10 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		goto done;
 	}
 
-	fault = __do_page_fault(mm, vma, addr, mm_flags, vm_flags, regs);
+	if (!(vma->vm_flags & vm_flags))
+		fault = VM_FAULT_BADACCESS;
+	else
+		fault = handle_mm_fault(vma, addr, mm_flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
-- 
2.27.0


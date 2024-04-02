Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79643B182
	for <linux-s390@vger.kernel.org>; Tue,  2 Apr 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044401; cv=none; b=MBBq1CSOvebUlHv3jaeKDmAe9Wh6AFdQDcCAQGZJ59IDlinnP5H1LLBjIxXSsTRm4dPhjdYrQ9dSFeUrFsRXzvSA1Fh7NaozPAYXq1jHEurBcRilkVH7wZuYh7QZfRxYyOosfAatdDaHEp/N0CbGUjU2seQrKwdPOrYOxX7afOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044401; c=relaxed/simple;
	bh=f5Lfx8Z1LVutbiVem9ddvHtwjxzHzxAlFhUCIKFEenI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0U5nQ9J9Q5XyXwqjUxfKPX7ehFVgPVLY55fT4P5GUvwl2DQSdPQ3YiiYQ3D3IoPl68tGKmV1Ev0slkx4mxpXBbL+sQEizFv8Mf7cyKDTfnVHD3S/1Go+4qJhae9ejzuENd/lO5uceF1iW4b//0VTFMif6JZMo+uB3CEvemJ36M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V80RX18nRz1R9YK;
	Tue,  2 Apr 2024 15:50:32 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C3F0180060;
	Tue,  2 Apr 2024 15:53:17 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 15:53:16 +0800
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
	<linux-s390@vger.kernel.org>, <surenb@google.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH 2/7] arm64: mm: accelerate pagefault when VM_FAULT_BADACCESS
Date: Tue, 2 Apr 2024 15:51:37 +0800
Message-ID: <20240402075142.196265-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240402075142.196265-1-wangkefeng.wang@huawei.com>
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)

The vm_flags of vma already checked under per-VMA lock, if it is a
bad access, directly set fault to VM_FAULT_BADACCESS and handle error,
no need to lock_mm_and_find_vma() and check vm_flags again, the latency
time reduce 34% in lmbench 'lat_sig -P 1 prot lat_sig'.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/mm/fault.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9bb9f395351a..405f9aa831bd 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -572,7 +572,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 
 	if (!(vma->vm_flags & vm_flags)) {
 		vma_end_read(vma);
-		goto lock_mmap;
+		fault = VM_FAULT_BADACCESS;
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		goto done;
 	}
 	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
 	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
-- 
2.27.0


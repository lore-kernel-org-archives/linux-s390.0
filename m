Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236926286
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133512; cv=none; b=GpJfMTuKj+U5MPVTJNH7++fHDd4lAqSbDjizQwDaG9ptxbGjKmSwDYtxgxixFtf1PsfG4HeVqfozymQdrYwq2M0qJTdpE03FuNuajfpn8n7UUwMXgjddd2UVtj6EiX4UQYuxuWCrWp3sQkW8cPx5VysvuHEnCW6Y79NpNU9L2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133512; c=relaxed/simple;
	bh=9Yd+srGO1/97B/S8yGhfUZcetnDVYErpO2s9SYd/fZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQtLmQYRGVIAr5UhUqksY59UJdHUmz0cJ2hYYdnTSAiaxSluiBtP2RmkAXZTP2SDAPPOUhJnFaEGxWGAND6JhHmB62cX6Di7Ydg4G+ZXGGXmyi0S7kkPnA/t4tlvxMYEaKqCy5jLXrp3sE2vqR60kd0Fp8YPdPadKj56eSYXm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V8dPB65yQz29lXY;
	Wed,  3 Apr 2024 16:35:42 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BC4E180063;
	Wed,  3 Apr 2024 16:38:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 16:38:27 +0800
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
Subject: [PATCH v2 6/7] s390: mm: accelerate pagefault when badaccess
Date: Wed, 3 Apr 2024 16:38:04 +0800
Message-ID: <20240403083805.1818160-7-wangkefeng.wang@huawei.com>
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

The vm_flags of vma already checked under per-VMA lock, if it is a
bad access, directly handle error, no need to retry with mmap_lock
again. Since the page faut is handled under per-VMA lock, count it
as a vma lock event with VMA_LOCK_SUCCESS.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/s390/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index c421dd44ffbe..162ca2576fd4 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -325,7 +325,8 @@ static void do_exception(struct pt_regs *regs, int access)
 		goto lock_mmap;
 	if (!(vma->vm_flags & access)) {
 		vma_end_read(vma);
-		goto lock_mmap;
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		return handle_fault_error_nolock(regs, SEGV_ACCERR);
 	}
 	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
 	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
-- 
2.27.0


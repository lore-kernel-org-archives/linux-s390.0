Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A563D2BD1C
	for <linux-s390@vger.kernel.org>; Tue,  2 Apr 2024 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044401; cv=none; b=SR7c26jU6naR4uS9HNJzitGhStBu9XzjCthO4Y9pLmwUUax1B0L3gLCmA8fH2dcMZvs/9SzcVz6Z+au8aBVntFnNBvq0NLr7T6NzwSPErNn5nWdyY7jGtaXF/v9gTTRV7+bYId+4VAWXD3R47XLxxCyfjpBUzk5F9XaGHsbY1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044401; c=relaxed/simple;
	bh=IOqmJt1/AaAARoF+FylX1lGFuV+OIgMvhrmNtax4e2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h5qCYPxpRohjyXYLCYrH79XDD5EwFWMrOmFdZqXePy8YqRltYxk90Pyw0xy0KM9Au2Grqh3OzJoqkwD4p4eFwZVDiZfn7gqvAup+HsGzbW6btA1l81Tq+ly+LAaRChjUp2xiFcCiXWZaEwG8wNXzVsCC8QDgYlyndTSrNAsLHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V80RS5xc3zwRBB;
	Tue,  2 Apr 2024 15:50:28 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B67C140415;
	Tue,  2 Apr 2024 15:53:15 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 15:53:14 +0800
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
Subject: [PATCH 0/7] arch/mm/fault: accelerate pagefault when badaccess
Date: Tue, 2 Apr 2024 15:51:35 +0800
Message-ID: <20240402075142.196265-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
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

After VMA lock-based page fault handling enabled, if bad access met
under per-vma lock, it will fallback to mmap_lock-based handling,
so it leads to unnessary mmap lock and vma find again. A test from
lmbench shows 34% improve after this changes on arm64,

  lat_sig -P 1 prot lat_sig 0.29194 -> 0.19198

Only build test on other archs except arm64.

Kefeng Wang (7):
  arm64: mm: cleanup __do_page_fault()
  arm64: mm: accelerate pagefault when VM_FAULT_BADACCESS
  arm: mm: accelerate pagefault when VM_FAULT_BADACCESS
  powerpc: mm: accelerate pagefault when badaccess
  riscv: mm: accelerate pagefault when badaccess
  s390: mm: accelerate pagefault when badaccess
  x86: mm: accelerate pagefault when badaccess

 arch/arm/mm/fault.c     |  4 +++-
 arch/arm64/mm/fault.c   | 31 ++++++++++---------------------
 arch/powerpc/mm/fault.c | 33 ++++++++++++++++++++-------------
 arch/riscv/mm/fault.c   |  5 ++++-
 arch/s390/mm/fault.c    |  3 ++-
 arch/x86/mm/fault.c     | 23 ++++++++++++++---------
 6 files changed, 53 insertions(+), 46 deletions(-)

-- 
2.27.0


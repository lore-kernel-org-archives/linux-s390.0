Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AF26286
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133508; cv=none; b=etpcs4nwlm4bkVboEhc+H0XPpODv6Y+w+X3sY9PHO+O/MXWS7ikiQoX40hMGUJGFztOBvNxtKrtEK2talrOyGSbNgTTWXV5F8v9DLjHEcA+259VqTfI9qyKwk3aIVCMlXD/gy1i75Y/RcPEJdiQd1r1YJ9URhBZKClCdSyphR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133508; c=relaxed/simple;
	bh=vMisDMUcHSTYThda3djP3o+2BVunkpXIuGEnC1WISkI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rzlgDNY50wqktnsu5x2XdImMgViwtuzFpGvSIIPCqvU8yVsWDohre4i+IvjjUiUuLUNnzVgAiB5HxwgTROA1zbHvQgiAwp6BtAD1kYJAMS0w2YOlEdyAmMTEvs+BwCa/BMDeLFD/yeZHYMcfSeqmaHTrBM5q5clR+w4WTgf0zkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V8dP54B5kz1h5X1;
	Wed,  3 Apr 2024 16:35:37 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D7F8140410;
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
Subject: [PATCH v2 0/7] arch/mm/fault: accelerate pagefault when badaccess
Date: Wed, 3 Apr 2024 16:37:58 +0800
Message-ID: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
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

After VMA lock-based page fault handling enabled, if bad access met
under per-vma lock, it will fallback to mmap_lock-based handling,
so it leads to unnessary mmap lock and vma find again. A test from
lmbench shows 34% improve after this changes on arm64,

  lat_sig -P 1 prot lat_sig 0.29194 -> 0.19198

Only build test on other archs except arm64.

v2: 
- a better changelog, and describe the counting changes, suggested by
  Suren Baghdasaryan
- add RB

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


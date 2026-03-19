Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988F18859B;
	Thu, 19 Mar 2026 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890663; cv=none; b=iGf4qMcPpqd3AfeB8PR9YNG48j6svi0zOeEMut+0Ev1pAyt5ARixkk+ilzEbC8XWjojzA6+AJgMBTJ02iH8UBCtFwr9o2m6dtN3fRa37V64wnAoxdu6+gZ0TP+rATK6zWE2kyZusl2TSVGzCr4wmP5DcuA38M4/zpHxZrVUOcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890663; c=relaxed/simple;
	bh=R9dNdbyhlYfRDOhshT0d5PeBp+yAD63X5J7pR8+2fQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o00ETq+BFHU/4a8xel5QujPbOYUA4+BZjYE5nvZ7QdCST8Ocz0d69qwlOSArIz2eZIjU+7EPHVNVw+PctNOKa5+2mb/XoX+WH1UjPTwaxitz0VTX6zbp86JclmQNsUKQL7bellsq/eMBSZmuXFkHMofSYNo3rdBRCUayVZc1hjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KQz6GnBB; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KQz6GnBB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773890657; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Z8ArazpuHzwIU8/sGdkPDAUgZ5Tq6d2MPt9c5EGHyCA=;
	b=KQz6GnBBMvedaRsev9/OQtPcB9zHuccC9Xvw9Lfpl5oEC6CILwo3iss6nzZ7gBYUq0DyKiy8oNN7I8BXk8CvpS4Ra4Ntz17+8Ft4i+9aR4DUfm+8TZce6KhWACqlmqrhFvSc4hVYj48NX113JvNip9AA7uJznO9FxygH1KMXEeY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.GnNVC_1773890655;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.GnNVC_1773890655 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 11:24:16 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	baolin.wang@linux.alibaba.com,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org (open),
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] change young flag check functions to return bool
Date: Thu, 19 Mar 2026 11:23:59 +0800
Message-ID: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a cleanup patchset to change all young flag check functions to
return bool, as discussed with David in the previous thread[1]. Since
callers only care about whether the young flag was set, returning bool
makes the intention clearer. No functional changes intended.

Ran mm selftests on Arm64 and x86 machines, and no issues were found.

Note that I only CC'd the arch mailing lists to avoid disturbing too
many people.

[1] https://lore.kernel.org/all/d172d6bf-c60c-4cf5-9da9-f30de38cdfed@kernel.org/

Baolin Wang (6):
  mm: change to return bool for ptep_test_and_clear_young()
  mm: change to return bool for
    ptep_clear_flush_young()/clear_flush_young_ptes()
  mm: change to return bool for pmdp_test_and_clear_young()
  mm: change to return bool for pmdp_clear_flush_young()
  mm: change to return bool for pudp_test_and_clear_young()
  mm: change to return bool for the MMU notifier's young flag check

 arch/arm64/include/asm/pgtable.h             | 29 ++++----
 arch/arm64/mm/contpte.c                      |  8 +--
 arch/microblaze/include/asm/pgtable.h        |  2 +-
 arch/parisc/include/asm/pgtable.h            |  8 +--
 arch/parisc/kernel/cache.c                   |  8 +--
 arch/powerpc/include/asm/book3s/32/pgtable.h |  4 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h | 26 +++----
 arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
 arch/powerpc/include/asm/nohash/pgtable.h    |  4 +-
 arch/powerpc/mm/book3s64/pgtable.c           |  8 +--
 arch/riscv/include/asm/pgtable.h             | 14 ++--
 arch/riscv/mm/pgtable.c                      |  8 +--
 arch/s390/include/asm/pgtable.h              | 16 ++---
 arch/x86/include/asm/pgtable.h               | 20 +++---
 arch/x86/mm/pgtable.c                        | 28 ++++----
 arch/xtensa/include/asm/pgtable.h            |  6 +-
 include/linux/mmu_notifier.h                 | 76 +++++++++-----------
 include/linux/pgtable.h                      | 53 +++++++-------
 mm/internal.h                                | 16 ++---
 mm/mmu_notifier.c                            | 20 +++---
 mm/pgtable-generic.c                         | 14 ++--
 virt/kvm/kvm_main.c                          | 40 +++++------
 22 files changed, 201 insertions(+), 209 deletions(-)

-- 
2.47.3


Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B632B9B5;
	Sat, 21 Mar 2026 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774075402; cv=none; b=qYtewcRpIt3A80Y6FZgoAYswR3sFj073LVe+KtlmxedwX8028V26owAi//90wOcvpbOXJlJ+fqhQJfUORTg5VCKRUojIBiURJ+bfujqQM5AIdVF7dTSNM3OBQRc8XX8bboDjzcCO1U4iGolVrYYM8nKykw8Nfv42a9s4/cS58S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774075402; c=relaxed/simple;
	bh=8J37u0+lBt+p+5wkJuQFlBREzaXUEc4NP7GqaF+Wjqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTAYjIu0CEzrjY884ljv/W/Bnd2kW9fbTSf3beiCCDwy6iDcmPVvidl9HXDBlAfHjqevBeKby1Tk3FLsfm6+LEOy8onWh54GdaXprBlT+ufz9Nuxz6mSkhHG7A8RiE85g6lkaDrlaXMiLGjd6ftFn24HGh+5WTkAijRsTVD4VA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sXuPqm6g; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sXuPqm6g"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774075386; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CFe5F2qNF94aRecR5rQidH10sMhxbLDMuB5Obisunh4=;
	b=sXuPqm6gOoB4cfECJY0E34WGzrLrEk+Z8NldJtYM5iN5Zl61cVYO6OgDc9ibARWknHk4ym7jjl2diC5iwT1ou83XjSauV1i9m73HOAiKPx1wk8cW2fMaly0omRp/ZZXHXLDXbo9ZRWa9ZO9pxLdq7asKnywGplo0qYXoIJp9XpU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.O7gUx_1774075385;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.O7gUx_1774075385 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 14:43:06 +0800
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
Subject: [PATCH v2 0/6] change young flag check functions to return bool
Date: Sat, 21 Mar 2026 14:42:48 +0800
Message-ID: <cover.1774075004.git.baolin.wang@linux.alibaba.com>
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

Changes from v1:
 - Add reviewed tag from Lorenzo and Ritesh. Thanks.
 - Drop extern and use 2 tabs indentation, per Lorenzo.
 - Fix the incorrect conversion of the 'id' variable.

Baolin Wang (6):
  mm: change to return bool for ptep_test_and_clear_young()
  mm: change to return bool for
    ptep_clear_flush_young()/clear_flush_young_ptes()
  mm: change to return bool for pmdp_test_and_clear_young()
  mm: change to return bool for pmdp_clear_flush_young()
  mm: change to return bool for pudp_test_and_clear_young()
  mm: change to return bool for the MMU notifier's young flag check

 arch/arm64/include/asm/pgtable.h             | 38 +++++-----
 arch/arm64/mm/contpte.c                      | 14 ++--
 arch/microblaze/include/asm/pgtable.h        |  2 +-
 arch/parisc/include/asm/pgtable.h            |  9 +--
 arch/parisc/kernel/cache.c                   |  8 +--
 arch/powerpc/include/asm/book3s/32/pgtable.h |  4 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h | 26 +++----
 arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
 arch/powerpc/include/asm/nohash/pgtable.h    |  4 +-
 arch/powerpc/mm/book3s64/pgtable.c           |  8 +--
 arch/riscv/include/asm/pgtable.h             | 16 ++---
 arch/riscv/mm/pgtable.c                      |  7 +-
 arch/s390/include/asm/pgtable.h              | 16 ++---
 arch/x86/include/asm/pgtable.h               | 20 +++---
 arch/x86/mm/pgtable.c                        | 28 ++++----
 arch/xtensa/include/asm/pgtable.h            |  9 ++-
 include/linux/mmu_notifier.h                 | 76 +++++++++-----------
 include/linux/pgtable.h                      | 53 +++++++-------
 mm/internal.h                                | 16 ++---
 mm/mmu_notifier.c                            | 23 +++---
 mm/pgtable-generic.c                         | 14 ++--
 virt/kvm/kvm_main.c                          | 31 +++-----
 22 files changed, 202 insertions(+), 222 deletions(-)

-- 
2.47.3


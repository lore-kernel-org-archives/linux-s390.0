Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65817C98
	for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2025 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174008; cv=none; b=UQf5k9Yh4D3bmdmBRCW/37uuVfQwcZ0zuv20S7tRk0rbZw8xlabebJeP02i6W3g8ohFx3jSpA8dXCit3y5ZqguHrFosEeCIeECl+smoolTmNpAUPGIZsm/PHuHytxe/yq9uQFoVUcwmJUME2FLBja5DGE0eQAS4HVHljiW6whyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174008; c=relaxed/simple;
	bh=lwWcsi+mo8/lnzN6sBNde2cxo7z3DizDq/RavQTv+nY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fG1/NhfWc/MM7xyhY4GLvv2oRTf2m/P52yV/4jNJePxvq1IgqpW+1jxOJRHDv/gdce6xeMRpRhqpgieX6TFlcP06Le9ZpOsnvPc9jKPX+ZlV+TtiOQOI1/lSsm4mDkxI1O96N3+hOTCI9D4uFJ5i4O/onupg5eU6AFHRwAiQRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rNV3TKe9; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rNV3TKe9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738174003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+B61QA75bcpmapmJUSuhrmtpoD2G5tgQuCnVdv98XvQ=;
	b=rNV3TKe9G4VdkviYiZM+vAM3CJEe4QdGERHNJuMSSIEG/o8o+/esXo7K5JctRdjtLTNKYB
	kR3xltT7m3W9foag37FAzbIL1OsKBB/GQR2kUOcOnlRs7It+gcVLO24I6+k+4biAbLHx5R
	KfAFT0rs7vHiQV/D4vXRNGNVKQGRelA=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Seth Jennings <sjenning@redhat.com>,
	Dan Streetman <ddstreet@ieee.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 0/2] mm: zswap: remove z3fold and zbud
Date: Wed, 29 Jan 2025 18:06:30 +0000
Message-ID: <20250129180633.3501650-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

After 2 cycles of deprecating z3fold, remove it as well as zbud
(rationale in specific patches).

v1 -> v2:
- Remove zbud directly instead of deprecating it first as suggested by
  Johannes.

Yosry Ahmed (2):
  mm: z3fold: remove z3fold
  mm: zbud: remove zbud

 CREDITS                                       |    3 +
 Documentation/admin-guide/mm/zswap.rst        |   10 +-
 Documentation/mm/index.rst                    |    1 -
 Documentation/mm/z3fold.rst                   |   28 -
 Documentation/translations/zh_CN/mm/index.rst |    1 -
 .../translations/zh_CN/mm/z3fold.rst          |   31 -
 MAINTAINERS                                   |   14 -
 arch/loongarch/configs/loongson3_defconfig    |    3 +-
 arch/s390/configs/debug_defconfig             |    2 +-
 arch/s390/configs/defconfig                   |    2 +-
 include/linux/zpool.h                         |    5 +-
 mm/Kconfig                                    |   47 -
 mm/Makefile                                   |    2 -
 mm/z3fold.c                                   | 1447 -----------------
 mm/zbud.c                                     |  455 ------
 mm/zpool.c                                    |    4 +-
 16 files changed, 14 insertions(+), 2041 deletions(-)
 delete mode 100644 Documentation/mm/z3fold.rst
 delete mode 100644 Documentation/translations/zh_CN/mm/z3fold.rst
 delete mode 100644 mm/z3fold.c
 delete mode 100644 mm/zbud.c

-- 
2.48.1.262.g85cc9f2d1e-goog


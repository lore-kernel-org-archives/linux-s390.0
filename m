Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4024A394490;
	Wed, 23 Sep 2026 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137959; cv=none; b=tDxPp89yp56ZV86xR7NlfbPLwNtQ//BEC60LC89E4Bb9b8eBPeSbPcQG+/i/LaGCV3UYqW5PyYAaRRXQyHnwyC98c1sDQddIDvjApIpArkKpQuATQb3gExarkGVh1yUaSACatl3+CygRNNANLsOEQDavzgV2DF+k3xzUNfYkN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137959; c=relaxed/simple;
	bh=cfGeDdBc/7PspEKVwTNh0HU7/ywQqRYyVO7lq8n9E4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IJ/Yx1zLPD+g1wW91fwzWSFxuK/F3sr8F16/nSezsuFjEthrsszR5qrUFNMr0yexqshWcLg57lz3VDgCWod6vrTGwUMfm4QwQD9EWlbOuAu2hoaNMqD17UhQhBivseYogUaLHlOTW351Y3f4wrJ5z8LBpniJYalt5n7Azrvtej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AVafkVcc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AVafkVcc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF1CA1655;
	Tue, 22 Sep 2026 21:32:31 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EE8E3F86C;
	Tue, 22 Sep 2026 21:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790137955; bh=cfGeDdBc/7PspEKVwTNh0HU7/ywQqRYyVO7lq8n9E4E=;
	h=From:To:Cc:Subject:Date:From;
	b=AVafkVccv/oqCtPz4ef1y7Zons53fH6/HRvELt70+6WCLSFaR9up2j4bG6c7A0GJ+
	 LxWsp+Q/t6PNelQi/3s6xzDv4f6RT1NKsy5ZhdHluy7xZH3WpEH82mgt0R82VDco+1
	 Drocy/z2/CjoNEq3X5dSTtdh336qHOYKNA7aE91o=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Helge Deller <deller@gmx.de>,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arch/mm: Drop similar platform overrides for pxdp_get()
Date: Wed, 23 Sep 2026 10:02:19 +0530
Message-ID: <20260923043226.331880-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are many platforms with similar pxpd_get() overrides like the generic
memory default helpers which use READ_ONCE() for reading page table entries
These overrides could be dropped safely letting their platforms fallback on
the defaults instead. Although it requires some code movement from platform
headers to avoid build failures.

This series based on v7.3-rc4 although after the following patch.

https://lore.kernel.org/linux-mm/20260918064928.793742-1-anshuman.khandual@arm.com/

Cc: David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: “James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-mm@kvack.org
Cc: loongarch@lists.linux.dev
Cc: linux-s390@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (3):
  s390/mm: Drop all pxdp_get()
  loongarch/mm: Drop all pxdp_get()
  parisc/mm: Drop all pxdp_get()

 arch/loongarch/include/asm/pgtable.h | 20 ++--------------
 arch/loongarch/mm/init.c             | 19 +++++++++++++++
 arch/parisc/include/asm/pgtable.h    | 20 +---------------
 arch/parisc/mm/init.c                | 13 +++++++++++
 arch/s390/include/asm/pgtable.h      | 35 ++++------------------------
 5 files changed, 40 insertions(+), 67 deletions(-)

-- 
2.43.0


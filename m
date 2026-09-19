Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B2037CD47;
	Sat, 19 Sep 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789812840; cv=none; b=c+nMkZVMSDQSyQL49dd5FYd9mHaFaYoAHFXhwz1xjrmW+S+En0h2tZDe2hHFmfzqIr2kfPgfqhoZpTIRHRJiIR+MDoh4wh2YcY5i27gu+ehMYVCJA/tCZH5B/T5XkBnLWkbSMxnD6Z1+xtWfVPZtk+BOffNocj//CTC+tapcY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789812840; c=relaxed/simple;
	bh=I+CE+sjYRQ9D7SEGybEH6t6fkrM4V9KN8kvDc0ka/6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WLe33HHKq88vz+F0ZHNtSOQdGTlYqG1ZW+LGMq4JtI2qEYZjwJwGhq5yH8thR87bStSbonrRTx9Lf/3fPXR6QXgbG7XvE2oxmIyrEgLxJw4kHw1A8SLNCr3h0JqvRQeaM1uS6zaIg9Ozyp+p4b97geTqXjdqj0HY4AYfCO8zL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tCV8/ZEq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tCV8/ZEq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9120165C;
	Sat, 19 Sep 2026 03:13:51 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C4033F86F;
	Sat, 19 Sep 2026 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789812835; bh=I+CE+sjYRQ9D7SEGybEH6t6fkrM4V9KN8kvDc0ka/6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=tCV8/ZEqWEXIyFG1R0G2wD3x5uG5Uogvfzm4XNcsTOBLttYZmAN+ZMu3H9FTuPFzQ
	 Bj7ymrY6ha+YT98rT0C0HnIyvVreG1WESpy0g4HKGCTQSdkVyCCC6Cmlbdy7SVefvK
	 sBI+vsfK1ilDwzBaS8gOFcnUx9DI1OJ7fCkGqBmQ=
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
Date: Sat, 19 Sep 2026 15:43:38 +0530
Message-ID: <20260919101343.1959572-1-anshuman.khandual@arm.com>
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

This series based on v7.2-rc3 after the following patch.

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


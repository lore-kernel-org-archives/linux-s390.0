Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C23FB30
	for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952539; cv=none; b=hBagZPYaMs/IAYMEj/n+LUc5qeA97qThmScx9L7sh9iFumRCBHezf7TOC1GnI5r9gMxdlZn8GXAYrOPuwD5hrl7FDRLQCoiLOcd/atH5b7927GfAFyn2AAFmmIJ1MBSwdVfR4ywDEYzhGrfcFUtGZPbcR8hgV8WrKw7Kg0s9D6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952539; c=relaxed/simple;
	bh=i8mCWaJqHMbNcbnMf1JJRWyQrq3ljAKp8/8osEqiNeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3bEZIR9SyMkNUu51XcTF8A2h1LjNuTQI0AtV0m7Z8a7DygC1aFuDWc+6wGrY7nW4y+PecKsidBoc4BM1+HGdAsrOw68KUD+0eAxu2Y/85TeL/V71j8E7n0bPh+wHGaS3R/5syh6+1ZqPZPYbZ5JZplzMnvf7szKS6b+rkbdw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGaknW7G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGaknW7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705952536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qd9zQc8SwlMxJsbzyQie1UqPu3p8Wk+b2U2cDU4I5Gw=;
	b=JGaknW7GR7bFMr/F3YBRdL6d2zMD9vLCZwpgPXKUpi11A9bRSjxJeV8LnQwMT4F4Hpbf24
	Ggl6lQwFpNTc+j0G4ScZdrFHVifxwLm5JpZfECPwQeHb5NRfZxp7aIsueyneXivmJRv4Sz
	vuc1YNZFGGB7kQ9+na9H22FcjctTvB0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-x69pe3DCPsqpnwDc2t8HtA-1; Mon, 22 Jan 2024 14:42:11 -0500
X-MC-Unique: x69pe3DCPsqpnwDc2t8HtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEEA788D016;
	Mon, 22 Jan 2024 19:42:09 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 267043C2E;
	Mon, 22 Jan 2024 19:42:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v1 00/11] mm/memory: optimize fork() with PTE-mapped THP
Date: Mon, 22 Jan 2024 20:41:49 +0100
Message-ID: <20240122194200.381241-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Now that the rmap overhaul[1] is upstream that provides a clean interface
for rmap batching, let's implement PTE batching during fork when processing
PTE-mapped THPs.

This series is partially based on Ryan's previous work[2] to implement
cont-pte support on arm64, but its a complete rewrite based on [1] to
optimize all architectures independent of any such PTE bits, and to
use the new rmap batching functions that simplify the code and prepare
for further rmap accounting changes.

We collect consecutive PTEs that map consecutive pages of the same large
folio, making sure that the other PTE bits are compatible, and (a) adjust
the refcount only once per batch, (b) call rmap handling functions only
once per batch and (c) perform batch PTE setting/updates.

While this series should be beneficial for adding cont-pte support on
ARM64[2], it's one of the requirements for maintaining a total mapcount[3]
for large folios with minimal added overhead and further changes[4] that
build up on top of the total mapcount.

Independent of all that, this series results in a speedup during fork with
PTE-mapped THP, which is the default with THPs that are smaller than a PMD
(for example, 16KiB to 1024KiB mTHPs for anonymous memory[5]).

On an Intel Xeon Silver 4210R CPU, fork'ing with 1GiB of PTE-mapped folios
of the same size (stddev < 1%) results in the following runtimes
for fork() (shorter is better):

Folio Size | v6.8-rc1 |      New | Change
------------------------------------------
      4KiB | 0.014328 | 0.014265 |     0%
     16KiB | 0.014263 | 0.013293 |   - 7%
     32KiB | 0.014334 | 0.012355 |   -14%
     64KiB | 0.014046 | 0.011837 |   -16%
    128KiB | 0.014011 | 0.011536 |   -18%
    256KiB | 0.013993 | 0.01134  |   -19%
    512KiB | 0.013983 | 0.011311 |   -19%
   1024KiB | 0.013986 | 0.011282 |   -19%
   2048KiB | 0.014305 | 0.011496 |   -20%

Next up is PTE batching when unmapping, that I'll probably send out
based on this series this/next week.

Only tested on x86-64. Compile-tested on most other architectures. Will
do more testing and double-check the arch changes while this is getting
some review.

[1] https://lkml.kernel.org/r/20231220224504.646757-1-david@redhat.com
[2] https://lkml.kernel.org/r/20231218105100.172635-1-ryan.roberts@arm.com
[3] https://lkml.kernel.org/r/20230809083256.699513-1-david@redhat.com
[4] https://lkml.kernel.org/r/20231124132626.235350-1-david@redhat.com
[5] https://lkml.kernel.org/r/20231207161211.2374093-1-ryan.roberts@arm.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: sparclinux@vger.kernel.org

David Hildenbrand (11):
  arm/pgtable: define PFN_PTE_SHIFT on arm and arm64
  nios2/pgtable: define PFN_PTE_SHIFT
  powerpc/pgtable: define PFN_PTE_SHIFT
  risc: pgtable: define PFN_PTE_SHIFT
  s390/pgtable: define PFN_PTE_SHIFT
  sparc/pgtable: define PFN_PTE_SHIFT
  mm/memory: factor out copying the actual PTE in copy_present_pte()
  mm/memory: pass PTE to copy_present_pte()
  mm/memory: optimize fork() with PTE-mapped THP
  mm/memory: ignore dirty/accessed/soft-dirty bits in folio_pte_batch()
  mm/memory: ignore writable bit in folio_pte_batch()

 arch/arm/include/asm/pgtable.h      |   2 +
 arch/arm64/include/asm/pgtable.h    |   2 +
 arch/nios2/include/asm/pgtable.h    |   2 +
 arch/powerpc/include/asm/pgtable.h  |   2 +
 arch/riscv/include/asm/pgtable.h    |   2 +
 arch/s390/include/asm/pgtable.h     |   2 +
 arch/sparc/include/asm/pgtable_64.h |   2 +
 include/linux/pgtable.h             |  17 ++-
 mm/memory.c                         | 188 +++++++++++++++++++++-------
 9 files changed, 173 insertions(+), 46 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.43.0


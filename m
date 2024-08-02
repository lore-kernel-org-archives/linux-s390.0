Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3381537A0
	for <linux-s390@vger.kernel.org>; Fri,  2 Aug 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614143; cv=none; b=WRs71nSADP+ckLcla7Yt/8tXtZYD+x+M3PQ7D5AbliC9zga3aaT0bhtpleqbcC97dSm7bwoaVHhslXLVvVMXbw39UlpWfYoyob9uT7wikpg4fAlbeasDTtNkMnAMUE7nX/sxf1WRiWTjXt7Q8rglOWnCX0CrkgGtPY6Wfxc+1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614143; c=relaxed/simple;
	bh=aSl3GDoexr7Yt74Cnz0YsaFdausfDIyrzV3WsAcdZ9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXmHUiH3Gskb8VG/HsmkRfzLXuVITrlRDnnl+BIOTJtVpDZv6Orsk302iVewudwlq9EhjepezCATslR0KkZKVhhUL9MxEz3I2PhDrO0RIRY9gdwy1CQYFqGy1BhrlYfy256QOAYTXJgrXhmBul6KHPnRdGiw1a+DwuBnRCW0cA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6oC0Ftq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6oC0Ftq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L1rljUKvL0U4qJqT07GMyS3ShSSr+C5zU092arRl9Dk=;
	b=Z6oC0Ftqvnx2qAIyXre+8ay7+HY9Jww+sr9Bydj40TrwXLJoBQzaD0ykkB77sYl5GH+ey5
	LgETijeKtLeD1RD0a1Cn13BAbqif/IEFQ1rcYYaauG6nxjIfEVZwtUVbr8tXxOO2HBy0tY
	inv5kco7qXeUzOnzhbwRmL2BuW/SyaI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-nld39d-uMKGpUalxEQkpag-1; Fri,
 02 Aug 2024 11:55:35 -0400
X-MC-Unique: nld39d-uMKGpUalxEQkpag-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C34D1944AB0;
	Fri,  2 Aug 2024 15:55:33 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68195300018D;
	Fri,  2 Aug 2024 15:55:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH v1 00/11] mm: replace follow_page() by folio_walk
Date: Fri,  2 Aug 2024 17:55:13 +0200
Message-ID: <20240802155524.517137-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Looking into a way of moving the last folio_likely_mapped_shared() call
in add_folio_for_migration() under the PTL, I found myself removing
follow_page(). This paves the way for cleaning up all the FOLL_, follow_*
terminology to just be called "GUP" nowadays.

The new page table walker will lookup a mapped folio and return to the
caller with the PTL held, such that the folio cannot get unmapped
concurrently. Callers can then conditionally decide whether they really
want to take a short-term folio reference or whether the can simply
unlock the PTL and be done with it.

folio_walk is similar to page_vma_mapped_walk(), except that we don't know
the folio we want to walk to and that we are only walking to exactly one
PTE/PMD/PUD.

folio_walk provides access to the pte/pmd/pud (and the referenced folio
page because things like KSM need that), however, as part of this series
no page table modifications are performed by users.

We might be able to convert some other walk_page_range() users that really
only walk to one address, such as DAMON with
damon_mkold_ops/damon_young_ops. It might make sense to extend folio_walk
in the future to optionally fault in a folio (if applicable), such that we
can replace some get_user_pages() users that really only want to lookup
a single page/folio under PTL without unconditionally grabbing a folio
reference.

I have plans to extend the approach to a range walker that will try
batching various page table entries (not just folio pages) to be a better
replace for walk_page_range() -- and users will be able to opt in which
type of page table entries they want to process -- but that will require
more work and more thoughts.

KSM seems to work just fine (ksm_functional_tests selftests) and
move_pages seems to work (migration selftest). I tested the leaf
implementation excessively using various hugetlb sizes (64K, 2M, 32M, 1G)
on arm64 using move_pages and did some more testing on x86-64. Cross
compiled on a bunch of architectures.

I am not able to test the s390x Secure Execution changes, unfortunately.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

David Hildenbrand (11):
  mm: provide vm_normal_(page|folio)_pmd() with
    CONFIG_PGTABLE_HAS_HUGE_LEAVES
  mm/pagewalk: introduce folio_walk_start() + folio_walk_end()
  mm/migrate: convert do_pages_stat_array() from follow_page() to
    folio_walk
  mm/migrate: convert add_page_for_migration() from follow_page() to
    folio_walk
  mm/ksm: convert get_mergeable_page() from follow_page() to folio_walk
  mm/ksm: convert scan_get_next_rmap_item() from follow_page() to
    folio_walk
  mm/huge_memory: convert split_huge_pages_pid() from follow_page() to
    folio_walk
  s390/uv: convert gmap_destroy_page() from follow_page() to folio_walk
  s390/mm/fault: convert do_secure_storage_access() from follow_page()
    to folio_walk
  mm: remove follow_page()
  mm/ksm: convert break_ksm() from walk_page_range_vma() to folio_walk

 Documentation/mm/transhuge.rst |   6 +-
 arch/s390/kernel/uv.c          |  18 ++-
 arch/s390/mm/fault.c           |  16 ++-
 include/linux/mm.h             |   3 -
 include/linux/pagewalk.h       |  58 ++++++++++
 mm/filemap.c                   |   2 +-
 mm/gup.c                       |  24 +---
 mm/huge_memory.c               |  18 +--
 mm/ksm.c                       | 127 +++++++++------------
 mm/memory.c                    |   2 +-
 mm/migrate.c                   | 131 ++++++++++-----------
 mm/nommu.c                     |   6 -
 mm/pagewalk.c                  | 202 +++++++++++++++++++++++++++++++++
 13 files changed, 413 insertions(+), 200 deletions(-)

-- 
2.45.2


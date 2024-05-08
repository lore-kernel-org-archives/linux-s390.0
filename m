Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480B12D754
	for <linux-s390@vger.kernel.org>; Wed,  8 May 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193005; cv=none; b=nAao54gJNCBA+bJOyH24Yf9YuPHa8z4WaDY9OQKXtQ4TuPzWAuKfb9q2PsUR/DuB5GdY0BjlIMlDFXComJSVP6xfR1Uc7z8wKoig958PBHKRqFX6FeBFphqJ9bQcOZwLTS5PtqDxBB9hX9A258+pgJwOFlThR0lFbG2+H4Dm0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193005; c=relaxed/simple;
	bh=Af8N4wZvAUQNJQSK6fWTOSDCmGwfI/n8jS+x3krwiAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdN7DjNp/BLTImlr5eCGfpHBWeSBD/GZ/udyX8qDkloIRWC9yMvBc4nGa0g2P7K1j70tFc6zm5FQkieqDjB66k6lmWe/ie7Fi0imn3ZeGrIlDEa4mV7QCKV2oxx9oSQ22KskTSg5O8YWUMq/bgJh39UUtBs7IRYNsAG4/54AHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1qgpnqR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1qgpnqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715193002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZRQClyq6NCq+r6tZYqc96Ix/EYxfWTPYPd8njOlX/60=;
	b=g1qgpnqRqg1FEXop8OmnzKciXLR1HJYn6jqih4Arge+pa0+H44eUFYy6HkhVO0bT0DA9cw
	1PcAY3uXem4rJjw+VVRMwuUIG/DHaJE7OTi2lCEY1xeDGHb+CzCeJaJJLiBQvd26NuNLTJ
	CJmQan3oHG3Pwc5PqvIqMbIKzmKOPg0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-m407-a4UOv6tTjIN-Jxvqw-1; Wed, 08 May 2024 14:29:59 -0400
X-MC-Unique: m407-a4UOv6tTjIN-Jxvqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1198C8007BC;
	Wed,  8 May 2024 18:29:59 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4D36510000AD;
	Wed,  8 May 2024 18:29:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 00/10] s390: PG_arch_1+folio cleanups for uv+hugetlb
Date: Wed,  8 May 2024 20:29:45 +0200
Message-ID: <20240508182955.358628-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Rebased on 390x/features. Cleanups around PG_arch_1 and folio handling
in UV and hugetlb code.

One "easy" fix upfront. Another issue I spotted is documented in [1].

Once this hits upstream, we can remove HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
from core-mm and s390x, so only the folio variant will remain.

Compile tested, but not runtime tested with UV, I'll appreciate some
testing help from people with UV access and experience.

[1] https://lkml.kernel.org/r/20240404163642.1125529-1-david@redhat.com

v2 -> v3:
* "s390/uv: split large folios in gmap_make_secure()"
 -> Spelling fix
* "s390/hugetlb: convert PG_arch_1 code to work on folio->flags"
 -> Extended patch description

v1 -> v2:
* Rebased on s390x/features:
* "s390/hugetlb: convert PG_arch_1 code to work on folio->flags"
 -> pmd_folio() not available on s390x/features
* "s390/uv: don't call folio_wait_writeback() without a folio reference"
 -> Willy's folio conversion is in s390x/features
* "s390/uv: convert PG_arch_1 users to only work on small folios"
 -> Add comments
* Rearrange code and handle split_folio() return values properly. New
  patches to handle splitting:
 -> "s390/uv: gmap_make_secure() cleanups for further changes"
 -> "s390/uv: split large folios in gmap_make_secure()"
* Added more cleanups:
 -> "s390/uv: make uv_convert_from_secure() a static function"
 -> "s390/uv: convert uv_destroy_owned_page() to uv_destroy_(folio|pte)()"
 -> "s390/uv: convert uv_convert_owned_from_secure() to
     uv_convert_from_secure_(folio|pte)()"
 -> "s390/mm: implement HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE"

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Thomas Huth <thuth@redhat.com>

David Hildenbrand (10):
  s390/uv: don't call folio_wait_writeback() without a folio reference
  s390/uv: gmap_make_secure() cleanups for further changes
  s390/uv: split large folios in gmap_make_secure()
  s390/uv: convert PG_arch_1 users to only work on small folios
  s390/uv: update PG_arch_1 comment
  s390/uv: make uv_convert_from_secure() a static function
  s390/uv: convert uv_destroy_owned_page() to uv_destroy_(folio|pte)()
  s390/uv: convert uv_convert_owned_from_secure() to
    uv_convert_from_secure_(folio|pte)()
  s390/uv: implement HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
  s390/hugetlb: convert PG_arch_1 code to work on folio->flags

 arch/s390/include/asm/page.h    |   5 +
 arch/s390/include/asm/pgtable.h |   8 +-
 arch/s390/include/asm/uv.h      |  12 +-
 arch/s390/kernel/uv.c           | 207 +++++++++++++++++++++-----------
 arch/s390/mm/fault.c            |  14 ++-
 arch/s390/mm/gmap.c             |  10 +-
 arch/s390/mm/hugetlbpage.c      |   8 +-
 7 files changed, 172 insertions(+), 92 deletions(-)

-- 
2.45.0


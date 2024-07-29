Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089E1186E2D
	for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2024 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278350; cv=none; b=pPNmeHSkNMTatn6NTS3COVTmFN3l8xNwQBnsujCw7zgULKVAlmPFPuoZcsgrcE9dArh56fFLV3YRI4eAoyVJem2E67en6AhwGr33RmyP8UViQ2fXGcXxyvAeX4L1dqM31SBXVF0km/skQploDPiRVAXu7ZHBhgLicpXRz80uKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278350; c=relaxed/simple;
	bh=IWVi8Pr8sW021RhAGLAJlDE+PyLZkSOOvAS+fiTMESk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5MdG9WTxVHLLWRHGFhTtShKYRrrpxO4XZ/94pyN0Htm+4ivSicP3/JiWKudt1IWkmxgQg9xbdZU5GBZrd3SxjClHQT5TKTzipQckj14bk+wWOOnlXGhRMWbfZYWFJujaWMu6GgpHEeUe71NCWM1dgs4exJzX1YjzyEag+3Zob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbwjZqKK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbwjZqKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722278348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5PYsSiOWBQFI5JFl6WQemJ8OEXFzybl56PwzMET4SDg=;
	b=JbwjZqKKKsEeK6235IM5pO8TGM2wJJxmheePpL5wvFndnLbY8vbYcOmAMiaHFO+8e+601b
	nSzhsKADuXG6ZQcbby0E6z6XofusWilUpanoRvPd715LtVnuNzwo1AgCi2Zug2lAHQdcUy
	0fQNknPl/vSDr95lScLxkX/YH9NOJ1o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-fS78pyLtPMqfopk0SJeTEQ-1; Mon,
 29 Jul 2024 14:39:01 -0400
X-MC-Unique: fS78pyLtPMqfopk0SJeTEQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D43CD1955D56;
	Mon, 29 Jul 2024 18:38:58 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1ED91955D42;
	Mon, 29 Jul 2024 18:38:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 0/3] mm: remove arch_make_page_accessible()
Date: Mon, 29 Jul 2024 20:38:41 +0200
Message-ID: <20240729183844.388481-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Now that s390x implements arch_make_folio_accessible(), let's convert
remaining users to use arch_make_folio_accessible() instead so we can
remove arch_make_page_accessible().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>

David Hildenbrand (3):
  mm: simplify arch_make_folio_accessible()
  mm/gup: convert to arch_make_folio_accessible()
  s390/uv: drop arch_make_page_accessible()

 arch/s390/include/asm/page.h |  2 --
 arch/s390/kernel/uv.c        |  5 -----
 include/linux/mm.h           | 18 +-----------------
 mm/gup.c                     |  8 +++++---
 4 files changed, 6 insertions(+), 27 deletions(-)


base-commit: 3bb434b9ff9bfeacf7f4aef6ae036146ae3c40cc
-- 
2.45.2


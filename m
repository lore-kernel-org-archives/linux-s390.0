Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC34F054A;
	Wed, 16 Sep 2026 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560242; cv=none; b=B0uoiljGbQP2JnCdlshlDI5L8xi3LqIK+s7z0aUYyYUnyfu2wYF/t3WEkYsL0SHB1doZb5IAhfTVijQmrJiSKKSg0GADM1w14jSZR7cqXHlhfT7eupPkaZDXwfsCftVdSx/xC2PJsZdv2iXVSCJD8zTgf40D7+3DC41IG3xrJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560242; c=relaxed/simple;
	bh=JkkuCK1AjeZA2D774owh92o+U22DOEgW8Bl1T+VvjGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9jmrLgq4zFRwUlbAJsUUnqQ4/Fjtshy075rWES1M3Cr+a0egRadMa+2sDYabU+ISDFJrQg+ILm8BkL9YcbgdGmvwZONrjZXQimuS5/PweaHaLoe6r4uMkanKe5186v2wjfpYR8QYrUvcBRWVRZGdJsU/63xGmt8Adth6u1b2A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAce1fhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAce1fhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF581F0089A;
	Wed, 16 Sep 2026 12:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560235;
	bh=DJHDp9vqJXqFSbKUnrSygcbO2/M2tpxb0Oj00wJTPho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EAce1fhAsPPC3kF2ylU6CATF9nCbEqSmOzx7qUVC9VhipchN28lkPYShtYDFpnw4j
	 dG3GPyU88038isT2JPJkUb/bUoev57I/6LsEjI/rAZ11k37trd6BC27abxzYWYNOEP
	 H8PiUdqA53Oec/qZ6dq9sCFnuf9pCE9N9V6/stGDpGbA0b7pbDXmhE5D1y/G0/VJ/J
	 2qiOpv27g4mGTl+QUnws374gEYEEUDzSEcJOnMyPN0s68mMUJiCBc8HwmmxIRnEYRl
	 ZIefJntx8NH8HODnJHM5afimdQfkzB1S1+k2VPJAloypuVJusewfq99/PSFwFYZwes
	 Q41c2eDiC3Ixg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 16 Sep 2026 15:03:19 +0300
Subject: [PATCH v3 12/13] s390/qdio_setup: Use kmalloc() for the SSQD
 request
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-s390-cio-ready-v3-12-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
In-Reply-To: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Mike Rapoport <rppt@kernel.org>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.17-dev

qdio_setup_get_ssqd() allocates the request block for the Store
Subchannel QDIO Data (SSQD) CHSC command.

This memory can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/qdio_setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index d8e9c0872d15d..e1c5c6a8b3b27 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -249,7 +249,7 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
 
 	DBF_EVENT("getssqd:%4x", schid->sch_no);
 	if (!irq_ptr) {
-		ssqd = (struct chsc_ssqd_area *)__get_free_page(GFP_KERNEL);
+		ssqd = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!ssqd)
 			return -ENOMEM;
 	} else {
@@ -270,7 +270,7 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
 
 out:
 	if (!irq_ptr)
-		free_page((unsigned long)ssqd);
+		kfree(ssqd);
 
 	return rc;
 }

-- 
2.53.0


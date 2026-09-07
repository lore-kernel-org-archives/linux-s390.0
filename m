Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D546EC7B;
	Mon,  7 Sep 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776673; cv=none; b=upjwkanOVXm3BLRrAI3VHmzt82Lx9kvj0GEFZqMroR2H3cVf5Pagk7JfeAyTXLuWCrOa+qduuMvcfwxPubz+poeQPyozOCbG+a8DGs7+FXKQbRJmcpFE2U05tDkA+eYjZEx99doh67hVwY81N1cOhGu67bh7/ytzpg+UC2Q1DQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776673; c=relaxed/simple;
	bh=hgFVRlQObA6IRobzhqyVXdoXC8mayCY0Z2IgxlZSSuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9lAoYgtD5dFjXAvwWZHZCCpThkBAKm+YmpuAQhV96jsRmr6k6jbTE1EBSip712D0i1gvJiHGjFQAa7/iKwFCf0z0ygDNLvjUwB6jiusptYIRTX8BnvS8w9DXSIq1TdS8jDpUpq6DkcIIDwVm2smtIEYdI0UEJArQB1G7hoIJ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL/JmbwP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL/JmbwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2721F00A3F;
	Mon,  7 Sep 2026 10:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776672;
	bh=owHwZKjYQNBsdmW9cxprXhtWaMjXxhcOEf9UsPq09Zc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TL/JmbwP1pZl9GSwEJwmvn24ao2aheHc7bJv5s2IshIbPh1MQB/NdU0L4gfFarRX2
	 lNXJmprvh/3VECTEXa1m1TvtgDks8/LJxqDhwz7fhgTeygbWLnD2PWJ5Iz6hQmv3IF
	 IYc/0ddIHeu89RZTebsq1YkUcgQA/PH1tiQEmfuffLfXFeJxeD3rdc09oGtE7vJ8y3
	 1+bLY3jqAvOaEMObSG8ndYCTKMd+ER0wSeZ1MddZgQx2mIl7FOL9kBLAo+3hxeU92J
	 HR0Enzt20v2LPipI6Gozf4Jo6exwgXtvcvmTGWL5WE7DXLer6R+B9OJmKi59mATpAb
	 iWbc4mifNrExA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 07 Sep 2026 13:23:53 +0300
Subject: [PATCH 12/13] s390/qdio_setup: Use kzalloc() for the SSQD request
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-s390-cio-ready-v1-12-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
In-Reply-To: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
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

Replace use of __get_free_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/qdio_setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index 7ca8f61a2387b..c0215a7d29a81 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -249,7 +249,7 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
 
 	DBF_EVENT("getssqd:%4x", schid->sch_no);
 	if (!irq_ptr) {
-		ssqd = (struct chsc_ssqd_area *)__get_free_page(GFP_KERNEL);
+		ssqd = kzalloc(PAGE_SIZE, GFP_KERNEL);
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


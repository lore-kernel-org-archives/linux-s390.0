Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115353290C5
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577678; cv=none; b=PHUgMi5aZNrVO+oQqrVZqD3m8UAAg8TPBpf+ES/Dheo/VhFNFwKCX0ayzoo0ilefGrstJZoU+BZcRws1KGJCEjHPsbC4aOpSeKmHBA/Z1RIPO3WEnZ130vWD/okv0b+PIW4jqZ78LknJSaV28GD/l0MtqTWFRnfaiyXgfalFZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577678; c=relaxed/simple;
	bh=mdu1gHWmP4lEKNPX7Z6IBetlaX3ougDSSv4qLlbvfAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPwFtQTgXu5OAVgsNZtlQbik8laY4N0BfIQACWUjFdaBWkWGnO4SaQ3Cf0Oz1Zt4y9pfe3gQQxpcHMWntEitKD8VtKtDbvGRNrtz9m/XuJ4HlnpR9FYwuSMEpqf+op1RuTgiYe5CZF8IS46hWpAPw55jVEHz8S19JRrpg1D1tnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KJYNK18n; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KJYNK18n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsidUyaFSU2OL+6pIevfNbim9vED85JJGBowf2ctQP8=;
	b=KJYNK18nvflazGbUsGQzniopI3KPVpz1LShSWjjSbT+hxFnh/0tpkw+tfNe3j+MVojye1j
	wdQPu4/bxNWWVoy1HF/DFPdbf1u5jrpcQiHNSPWDNk1zHFhU0vPcRAGI2daPSXBje5u6Yr
	R2eLlqWUdaQ4fQFe4gaiAaU+oQXNXZY=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [v3 04/24] mm: thp: handle split failure in do_huge_pmd_wp_page()
Date: Thu, 26 Mar 2026 19:08:46 -0700
Message-ID: <20260327021403.214713-5-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

do_huge_pmd_wp_page() splits the PMD when a COW of the entire huge page
fails (e.g., can't allocate a new folio or the folio is pinned).  It then
returns VM_FAULT_FALLBACK so the fault can be retried at PTE granularity.

If the split fails, the PMD is still huge.  Returning VM_FAULT_FALLBACK
would re-enter the PTE fault path, which expects a PTE page table at the
PMD entry — not a huge PMD.

Return VM_FAULT_OOM on split failure, which signals the fault handler to
invoke the OOM killer or return -ENOMEM to userspace.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/huge_memory.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8ad43897bdf80..9f4be707c8cb0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2137,7 +2137,13 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	folio_unlock(folio);
 	spin_unlock(vmf->ptl);
 fallback:
-	__split_huge_pmd(vma, vmf->pmd, vmf->address, false);
+	/*
+	 * Split failure means the PMD is still huge; returning
+	 * VM_FAULT_FALLBACK would re-enter the PTE path with a
+	 * huge PMD, causing incorrect behavior.
+	 */
+	if (__split_huge_pmd(vma, vmf->pmd, vmf->address, false))
+		return VM_FAULT_OOM;
 	return VM_FAULT_FALLBACK;
 }
 
-- 
2.52.0


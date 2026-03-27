Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BD32A3F3
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577701; cv=none; b=kTt+NmqqEUW+g4bd0dsclhxBgtCnisbSgxn5j9OFujeQ1oC0lVtlOqICvJT18FmmTSauhmbx/kFMicjz12pA1Gglgbywnmsm+KvB9cwH1p+Q3UmkP1WNJtuKgorr0XiOKBRnGh5yZ5d2jvQ7QScYfl7/F28SNPnYUEd7hIEEsek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577701; c=relaxed/simple;
	bh=LXOvTkYyflxaR8Vr531g4vNHVKKvwGdDKMAogSQPWj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVuweFVyzK4zcdr+zqsvsCduzLWIOPogTIJag1FAJRjICMf0TL0OuLFm9uRjtG6l6NowWGoO1X9GyRNcGPqyQ17a987/cQOK0/as/vtG74ac8oC9PCYuH4TCiRIfDprJJRaEFfqsdEOFJjkuFKmogiWJ4+05o0lmjfMuRFCzjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u0/m9ASD; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u0/m9ASD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEV2JraEcWrcU0ZBvWVbflxwtxhTRk4GT952CPZuA50=;
	b=u0/m9ASDIyRTjYzRS9sw7YydNLKfppOx0RMOs35/i/y5Ni21Cb1jtxqZNy/yP+Kqi/QxXC
	k6dOK7+inks9R2SF5uInEMSGMi6RkUSEsV/nxpnQv+EtYjG/nOmRguIxK19Cw1btj+1eHv
	O/E1Nq01pdgTuk7/bByUiSP3Dm/a2Jo=
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
Subject: [v3 07/24] mm: thp: retry on split failure in change_pmd_range()
Date: Thu, 26 Mar 2026 19:08:49 -0700
Message-ID: <20260327021403.214713-8-usama.arif@linux.dev>
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

change_pmd_range() splits a huge PMD when mprotect() targets a sub-PMD
range or when VMA flags require per-PTE protection bits that can't be
represented at PMD granularity.

If pte_alloc_one() fails inside __split_huge_pmd(), the huge PMD remains
intact. Without this change, change_pte_range() would return -EAGAIN
because pte_offset_map_lock() returns NULL for a huge PMD, sending the
code back to the 'again' label to retry the split—without ever calling
cond_resched().

Now that __split_huge_pmd() returns an error code, handle it explicitly:
yield the CPU with cond_resched() and retry via goto again, giving other
tasks a chance to free memory.

Trying to return an error all the way to change_protection_range would
not work as it would leave a memory range with new protections, and
others unchanged, with no easy way to roll back the already modified
entries (and previous splits). __split_huge_pmd only requires an
order-0 allocation and is extremely unlikely to fail.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/mprotect.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 110d47a36d4bb..e39e96963da8b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -477,7 +477,16 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 		if (pmd_is_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
-				__split_huge_pmd(vma, pmd, addr, false);
+				ret = __split_huge_pmd(vma, pmd, addr, false);
+				if (ret) {
+					/*
+					 * Yield and retry. Other tasks
+					 * may free memory while we
+					 * reschedule.
+					 */
+					cond_resched();
+					goto again;
+				}
 				/*
 				 * For file-backed, the pmd could have been
 				 * cleared; make sure pmd populated if
-- 
2.52.0


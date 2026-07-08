Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F544CF3E;
	Wed,  8 Jul 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519899; cv=none; b=OS12ABCx3/GI/y9+XHtYB1zjR6B9odMGHTkgQwj8onAoI1COjSpmqKDgJCRBIREoR9rwmTyG54be5Ght0rQoB9GwMYuriehrWsrMtiQjXbiboAZrXqyxZL6GSz4G8J3ruZYSN7g2Xwx8rnjQBkRC1nBGI4dfBxKTmq8epufsFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519899; c=relaxed/simple;
	bh=tVonLJ4bqqR4yCaE2I3p2K0L3Lq6bKlSTWW24L9kh88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BiCcRrnqKYmFp0L71C5WFzkHRhS3xqIgw17ZNpu7pGeGYdOXa7+TORSUbxqktnh1WVimpihdV8lrfJwJf/K9N/WhuEaXBA8u1l4rBDmebT2JzSsG54fMFQouWw3ghGu372dCuotgnWltWrITtHW8PL80DV++CN6RQ8SA4R7O++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTU037Ex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTU037Ex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60E71F00A3A;
	Wed,  8 Jul 2026 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519898;
	bh=W4T3aSskSUL65uwGRfGm0A5PLww8rgg5Ag5MsYm7xYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XTU037Ex9ZyJNkj8bDU9iKKXKpwT9vrllIePkr0TNA7XmWt0vSkPMfhGC7qjhjdBR
	 +KFgz361KYVgiVFkg34SU9hGOGDQ2+oGXcj9aLZ/YjgQWnt+o3KXDAkdkZbjIZZ9Tx
	 8/LI7Misflb/4tiOvhr2pIcnpvw/pqOVIHz9z0UfS4ENkEU0ApQdtV1Dx5y2hlECdW
	 fWdsxetgVhTRVTt4l0Wk7ZWVD690psoOKu4yg0GGTmzsxzstVn73IQck2mQ2lEsQlE
	 2CvWWgXrOV2w5ZYiXwVPpEuyZHvSI9NGXXomQR0zkv/FmVkzOpgrUZFDRpuBJH2RPg
	 vaETbZy++DrHQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 08 Jul 2026 16:10:59 +0200
Subject: [PATCH 04/10] mm/bootmem_info: allow calling free_bootmem_page()
 on pages without a bootmem_type
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bootmem_info_part2-v1-4-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
In-Reply-To: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.15.2

As preparation for further changes, let's temporarily allow freeing
pages that were not previously registered.

This will allow freeing unregistered vmemmap pages allocated during boot
through free_bootmem_page() from hugetlb code, until we fully rip all
of that out.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/bootmem_info.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index f724340755e55..486acc6127039 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -44,12 +44,12 @@ static inline void free_bootmem_page(struct page *page)
 {
 	enum bootmem_type type = bootmem_type(page);
 
-	VM_BUG_ON_PAGE(page_ref_count(page) != 2, page);
-
-	if (type == SECTION_INFO || type == MIX_SECTION_INFO)
+	if (type == SECTION_INFO || type == MIX_SECTION_INFO) {
+		VM_WARN_ON_PAGE(page_ref_count(page) != 2, page);
 		put_page_bootmem(page);
-	else
-		VM_BUG_ON_PAGE(1, page);
+	} else {
+		free_reserved_page(page);
+	}
 }
 #else
 static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)

-- 
2.43.0


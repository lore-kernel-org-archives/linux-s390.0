Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003814314B5;
	Thu, 16 Jul 2026 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213524; cv=none; b=tGqYpRI2lWcNF0CMkfwjQVVMRL2gnkNo+HQliZObx931ZBUZ0v+1anwOC+1y7p8UmKJJzDnTy/ofNxoAfthx9tLUJ2u6nbSXjUek2bR6M0m7Jz/8tTL4/O83EpJy7Ktj/pIEzT29LgNUPWwd+VHPLiGy+B+Vy8DUUZ/S4VI1isw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213524; c=relaxed/simple;
	bh=kkrR5/K2jRi2BK96dPmByVsNULhGF25yHXR2DIL5Jp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUfrEaIsMoyJu6YCCvQs4ibnWeaDjP9tD0YDscOXnJo4ZtUQLHxN7/FBikDEwgBjTsMcvGOm7Xu2T3QxCL9fJFc772bH/E4m9/V5c7GhuZgbs8P3zjlJC5hj1v195d//3RyFaHiOpqYvyKOBX75Kxm/ThcG1hKdEsfjzI1CydM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiA1vCgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiA1vCgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBCE1F00A3D;
	Thu, 16 Jul 2026 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213522;
	bh=0SUuxKwpil1PsNN3ad6xF3FsvL/1fKwwClYjSl4zS5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AiA1vCgVvUnhSNKfBex/54MWcWvKze0Y7zHZRqaJLsYUh4uUcd4OQ5SV+DDxA7ytS
	 4uHdc3b6gUTTjJxDjbQQm4oWAury0jD7tdDTp9Esz083Ya7ujdcsccHOCoFZidSLop
	 i3LXTK44uEQZ4MO/spj4F16sa5/lQD1eSk5zaHkkX9FDBYpp3q7DRELn4nnhPVX8qn
	 bIZ1Uyl6YNWX7S9yASY5uretie2wFjZfcjne7EDEWSopA8ncJVwktlaUnctzfrpBOt
	 k7DPpZtZndfE7kk54mDXZYV3WUAXUfF1QC9PPWuUan6VO1zgd7bK3N9BOonH2ncKjp
	 t+SyFvXlHJkOQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 16 Jul 2026 16:51:08 +0200
Subject: [PATCH v2 09/10] mm/sparse: remove bootmem_info.h include
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-bootmem_info_part2-v2-9-4afc76c73d61@kernel.org>
References: <20260716-bootmem_info_part2-v2-0-4afc76c73d61@kernel.org>
In-Reply-To: <20260716-bootmem_info_part2-v2-0-4afc76c73d61@kernel.org>
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

No longer required, so let's remove it.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 058ef93003672..b5c74aab3379a 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -13,7 +13,6 @@
 #include <linux/vmalloc.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
-#include <linux/bootmem_info.h>
 #include <linux/vmstat.h>
 #include "internal.h"
 #include <asm/dma.h>

-- 
2.43.0


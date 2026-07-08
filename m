Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024644CAE0;
	Wed,  8 Jul 2026 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519938; cv=none; b=hmXL7Le8gCaSW7kS75MWmyt6uIMG9pP9bshpB2/w4tDK5ChBNwDDC6CemWgfy0+7MFykMIvvCrRjXtTjiZOEZeHmvQmro2AUKBXyLV3Dl6b/keFFGfOGr0Tywtd2cWu09biesYYfcEyaWT/axBYUjEPo+zwEXrm8VT9v7LIxdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519938; c=relaxed/simple;
	bh=KXoJcAB0qh0bVM4fvhz6WHM2BQBe4RU2eB7o5k6x37A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhtNmPIhePkFGIINyd1PpN6AB6lSqbN9eiklwC3Wo23P0tvF5Prphob3+UZmC9bOKULdzYQnoE5PaEMRRwAz3OKYOs/p4off/ymk0N4EtYWaGWqZf6aO1Ttm16aMOVvd8egEdCbFA14dm8N/F/aGCjFckQFic/qsAESs8+AKATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia1IsIGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia1IsIGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A671F00A3E;
	Wed,  8 Jul 2026 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519937;
	bh=fwd351vZMeylo11Xt7QUAJDGgeyO/aHkIwHIv82aQeE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ia1IsIGCAROHagJA8XwwjgWhiIfaUuC7J/9zrD3GRG8E6BcnaOGLwuncYlD8oQVsk
	 +EM+3WTRQpYEx01oCoCMobP5C2WKODaicATQyQ6Rf4uq0+0OavBC8GZnqmqvHOTIxF
	 cCBZOu4IGMudBC0VlX5FvTrPZpmkLDqId9OqDTKCiNY2LTM7A9LAn9zQD0+IAnbQe7
	 d3412Zn30tqetBcQvajn1+y4EVQxidTLUq46UfuKVpbcZ8I5I9ZNaf2y2O5SxJKkWH
	 +8z+E6pN6bz32RXtg43tJ77K0q7yVf+f1x2yciCv3NViPcVTt2If4TWKtyKs9uAoP6
	 06shHonGEWjAw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 08 Jul 2026 16:11:04 +0200
Subject: [PATCH 09/10] mm/sparse: remove bootmem_info.h include
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bootmem_info_part2-v1-9-156ce4986598@kernel.org>
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

No longer required, so let's remove it.

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


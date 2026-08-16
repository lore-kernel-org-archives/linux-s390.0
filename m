Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949CC3C9EED;
	Sun, 16 Aug 2026 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878017; cv=none; b=MHIeYjrXU9zjfQqocJnAlppACKlrWIwVmMbZ2CbJYaVrFgzvyxkH03QnVDjbeBGRrX+eM7Mb/qtTzCQyLFlz9nDqkvkCwTWaZOYoW7C4pBkmk8QOmAbn50RPZXkPjAVJmUK9GZ/HQBLqEjAMda+C95jIkst0LWxyBCiN8B8UAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878017; c=relaxed/simple;
	bh=UmhtuD89qvz0ko0YInjebJPc8jbDcISaWIEEz8ESWhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BG6vYvGo70ZFh3XUFn8MscfTcg+AUqAmo3185+dwfUQiiEYxCda+SL38Z40wcryXUaMdk7x9dxIXvJb192IvYxnewsMC1aR2CBYR/Dlwk+22A3u6Zl2CZrMPxHt2BkPa+r/ZozrFVxB0NoSWr1AMVnLzUCAta4yfVU+xiZbFp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn2tZkv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn2tZkv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC81B1F000E9;
	Sun, 16 Aug 2026 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786878016;
	bh=pVPiYTx5xsmZOnMUcbrtteXSXwIvJir7dW3VRw6OI/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wn2tZkv2GmmvVvChb74RK7g+ieOJXoK9nRUtAwcKG1NxkbRbiQnwxuFtGfZc934GF
	 ojnGXmG2CmOzyYd4WRDvKp74bLte24Nxofl5tovKCDjJt8Klp3pt15WXlZF0xsKWd/
	 VAZrWr9rmwXSRxftpWSw5h1IkcUwmiJS2YwRKrOxgPSde0/kgHE18LZwznsC9zVKob
	 RkLvq8BCC+Cb38ljwdvLoIU5DXXQkdqpAZkhq6nlU183ZRgqoCY/nK3PbTrZgcsh+x
	 gKDjsg7+EFabNEvmBTKl2HgmFZfhiaPb85PFS+49KLaXDpFuB/mB1UDggWiTDWKvSb
	 sgZxxI00zoBMg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 16 Aug 2026 13:59:27 +0300
Subject: [PATCH 4/6] mm/vmalloc: make set_area_direct_map HUGE_VMAP
 friendly
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-execmem-set-vm-perms-v0-2-v1-4-90944a3ad43f@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Gleixner <tglx@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, 
 Will Deacon <will@kernel.org>, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 loongarch@lists.linux.dev
X-Mailer: b4 0.17-dev

set_area_direct_map() always updates direct map alias permissions in
single page increments.

For HUGE_VMAP areas it's suboptimal. Not only the loop in
set_area_direct_map() needlessly has more iterations (e.g times 512 on
x86), but it also causes fragmentation of the direct map that could be
avoided for the HUGE_VMAP areas populated with large pages.

All pages in an area are always of the same order: either same-order
large pages when VM_ALLOW_HUGE_VMAP is set and all huge pages were
successfully allocated, or order-0 page when VM_ALLOW_HUGE_VMAP is
cleared or when huge pages allocation fails and fallback path is taken.

Instead of updating the direct map permissions for every order-0 page in
an area, use the area's page_order as the loop increment and update the
large pages in one call to set_direct_map_{invalid,default}_noflush().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/vmalloc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fc7993db4152..11170d1ee5be 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3361,12 +3361,15 @@ static inline void set_area_direct_map(const struct vm_struct *area,
 				       int (*set_direct_map)(struct page *page,
 							     unsigned int nr))
 {
-	unsigned long i;
+	unsigned int nr = (1U << vm_area_page_order(area));
+
+	for (unsigned long i = 0; i < area->nr_pages; i += nr) {
+		if (page_address(area->pages[i])) {
+			int err = set_direct_map(area->pages[i], nr);
 
-	/* HUGE_VMALLOC passes small pages to set_direct_map */
-	for (i = 0; i < area->nr_pages; i++)
-		if (page_address(area->pages[i]))
-			set_direct_map(area->pages[i], 1);
+			WARN_ON_ONCE(err);
+		}
+	}
 }
 
 /*

-- 
2.53.0


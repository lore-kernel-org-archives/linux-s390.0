Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C73CA497;
	Sun, 23 Aug 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787485625; cv=none; b=vGDFYv1/V1jedPaXYh2dpRMp+WTEhxkwMUgcd85b2HwKods9olnmSw9mmDR5m5hdc/d5Gn3Y0cUzkRZOTXkkHyOi3UQTyTNoAsF9Jg6UWu/iT9gKyK+9dXjLpoOEiEj1bGD9Ej1EgppySQqDb2Epqp6gzdtZLa0tA/x1netCFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787485625; c=relaxed/simple;
	bh=ObSy1Srnr2wwaKpK5XKSyY61dD30oFw71iPOumKLGOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqJ+myx0m+zBU6jNXM+6BWjRX2/T7UHwIYKwzCji3XLb+oGWPRCUIzRMDcCu4XAoBh4sD2oKNy5qKEA0jFZK89/dfrwRgixOPm6uKJy8Iovev0hMqp/qKTUm8r7lGtiXV7xnW0c8E8nauH2xrtagSJElDIwoT7hq4KqVf+5nZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIM7FsVq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIM7FsVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879281F000E9;
	Sun, 23 Aug 2026 11:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787485623;
	bh=JNbaKBJKZiPBWFXiQZSzBAcWECdyW1psqwwnhscXogA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MIM7FsVqFQDwxEVqELOzWyRouVAcV/zT99s47WF8sDGz0/F3hE64vb8Nc7ZGQ6TZQ
	 guKkDJgym0SQoUX7GbxQVEzrbPfAdBfUlyqfFTws30j9T4oZBaJ7m1FzhBRlM8Y541
	 hk6+RYrgiHCw7kuAJrpr8CJzF6KPkdCCz8i4QVZemN8l3ab46v110aaqS4AR28vYwb
	 XER8Eo2D0JhPLqBYOMP72mYryOFYB59Iciip8vmWeHAvcBSgfnOEyWj3W057KVdhr+
	 06QPG/smqTW3N4dHyZfBcpY04dITAwYDaqovV12DxZIUwhAjWFVLe3/5Bz9DqWxsND
	 NhbUa8zPT1Xug==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 23 Aug 2026 14:46:15 +0300
Subject: [PATCH v2 4/6] mm/vmalloc: make set_area_direct_map HUGE_VMAP
 friendly
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-execmem-set-vm-perms-v0-2-v2-4-b013a37d84b3@kernel.org>
References: <20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org>
In-Reply-To: <20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org>
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
index a3e2e4244c0f..395358b363fc 100644
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


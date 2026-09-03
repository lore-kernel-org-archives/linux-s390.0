Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808743F1653;
	Thu,  3 Sep 2026 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427751; cv=none; b=bcE/rHKKy54V3Ou0JnJW12m60IKqz1x2rB3Aptq0Ed6xYGzgLwHngXkwFfqio8PuqvxU9dxGZDeUAVHFt0XYV5TENUczJwMS5rUPhEpWy1uCljfYhi/yGbqxRbaIyKh97wS/Jkz1i36klFO2Co1XRY976KUSy35Vapb4qpBHhxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427751; c=relaxed/simple;
	bh=zczX6jTqo78FTBDR6VyH2wcKZdZF6Meq2ngXaSZTD7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ix1/sGG9uaY7nFtnZfS3CffT2PpzHpOZ137TrPGBgY3zdh3O/0ZGG9wsCkj9q0il18GpkbYi4Da1Y7aDHkH944uoVjmqus57NfEix5E9thR7ESLQK+xRO9JVE5V10If6w12jPvxb9/7/2leLUG/8naaqchJYaX+SYthnAdImqV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmZYbLMt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmZYbLMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58871F000E9;
	Thu,  3 Sep 2026 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427748;
	bh=W4k8gpB3IOAIIjG8UTpBirOTQDvbIToA9Mf39j4z3bA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EmZYbLMtgCfKR5SC0SQMKuy6UTCmihOaKfsjvsBiuS/XG7+bmTa0BttU4UQ8j7cdf
	 vlK1dC3HchMglytuOJLBFLTyRcNQdP+8ieRosdoaP3VM+qhi/JXSJgB9O2up6Q1cc9
	 dRF/zDGzuuK1aNW6SVIpMm/UtcIHCyGVBYN7VibK+4507rTi1xQ91nix1xb5JkwGBu
	 eFN0D1Me4+48CIg7BPzVdmq60AYdlg16dPhyhgO/Z7ijOZIcJlmmMweRgb+nq5ucgP
	 FcEhOb+cZpfl0fq+hYVBaIWbbUbVucc5yFPSZCZwxRRJs6GayaVzjn467NYhrYwBXC
	 ooT5d1FoGG3bg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 03 Sep 2026 12:28:29 +0300
Subject: [PATCH v3 3/6] mm/vmalloc: constify vm parameter of
 get_vm_area_page_order()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-execmem-set-vm-perms-v0-2-v3-3-949b64a9f755@kernel.org>
References: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
In-Reply-To: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
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

get_vm_area_page_order() and vm_area_page_order() do not need to modify
struct vm_struct passed to them.

Constify the parameter.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/vmalloc.c | 4 ++--
 mm/vmalloc.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 22aa554d123f5..5506b180f5c27 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3130,7 +3130,7 @@ EXPORT_SYMBOL(vm_map_ram);
 
 static struct vm_struct *vmlist __initdata;
 
-static inline unsigned int vm_area_page_order(struct vm_struct *vm)
+static inline unsigned int vm_area_page_order(const struct vm_struct *vm)
 {
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
 	return vm->page_order;
@@ -3139,7 +3139,7 @@ static inline unsigned int vm_area_page_order(struct vm_struct *vm)
 #endif
 }
 
-unsigned int get_vm_area_page_order(struct vm_struct *vm)
+unsigned int get_vm_area_page_order(const struct vm_struct *vm)
 {
 	return vm_area_page_order(vm);
 }
diff --git a/mm/vmalloc.h b/mm/vmalloc.h
index 8866ddcff6681..211869f365095 100644
--- a/mm/vmalloc.h
+++ b/mm/vmalloc.h
@@ -12,7 +12,7 @@ void __init vmalloc_init(void);
 int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages,
 		unsigned int page_shift, gfp_t gfp_mask);
-unsigned int get_vm_area_page_order(struct vm_struct *vm);
+unsigned int get_vm_area_page_order(const struct vm_struct *vm);
 #else
 static inline void vmalloc_init(void) {}
 

-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49389411A0E;
	Thu,  3 Sep 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427769; cv=none; b=NTMN+7SBMBlyB2GqjnzHZ/qwm4Ldrvgoo24s1F6ZecchMDNN+xhqXsTknoRV51/PzAeCLwjuOdu4YcuD5gIXe7gu0n7y4g1gx1wWaMApgA+ZRGz2BQ7LKb6QzP3diqlei65mabKah3Mt1IDpN3wIHEguFIBA/MUCjngzscCWxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427769; c=relaxed/simple;
	bh=GANaTsmhBJhv32/yhc8gi7G+dYWfdszS5LlzA2ScMKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBW3oH5olc7MjzWVXWUeZbCZhqdr5A9c0bqyIGj7xK12MLIX7GQZEERGoNDlAwx8h8u/IFpEcFv1pvkWMo+J7ieRc/RrwPKe/ziQ1sISf4Amx5E7xZ80zIYCqhUU694go7a/S0FnbVBJQUhaIvKbXDGDu/7o3UnB0lqblseDD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrdwkTOy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrdwkTOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD30A1F00A3D;
	Thu,  3 Sep 2026 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427767;
	bh=9taLyiYqD93JJjaXvNS2H0Tq/XxgRc4w/Y2D/omzLAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VrdwkTOyGAsb/ezHXc+RSd05q9lbZbkXr7tUSHsqn9+YHwi+EFYdLGxBjm5CEXVMa
	 5auPqef474FyEjKgj8ThRoUCvfHGgYnQrQthDskjPXuoECP/k/VPsudCaoY75xMYPe
	 xtW1Ik2FAt0F+TbQfVXOeFkTvnDfu7oeMBf1BzIBXeP6yqK6YCQrNsfEBrCap0Tjnd
	 AEHtUNOOUJvwzM8VRrjFghlSTKBiJJS98np8SWdOVL7n9OzZ0N5F+VXzsoYuEgNsT0
	 CrJbqG/BJ0ZyOoKN5/1tIx4deMMBTz6zHMCQzDcQyqbkmPUr9RlGTsoj/fbb33i1/Z
	 M4WhiG9yMbmJw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 03 Sep 2026 12:28:31 +0300
Subject: [PATCH v3 5/6] mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cache
 allocations
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-execmem-set-vm-perms-v0-2-v3-5-949b64a9f755@kernel.org>
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

Initially execmem completely removed direct map alias for the memory
allocated for the ROX cache in PMD_SIZE chunks. When that memory was
freed, its direct map was restored also in PMD_SIZE chunks to avoid
fragmentation of the direct map caused by vmalloc::vm_reset_perms().

This required execmem to implement the wrappers for set_direct_map APIs for
proper sequencing of removal and restoration of the direct map aliases.

Since then x86's CPA gained support for collapsing the direct map page
tables for ROX pages and execmem switched from removing ROX caches from the
direct map to making them ROX there, so execmem only needs to update direct
map alias permissions when freeing the ROX cache memory.

vmalloc already handles those updates for areas with VM_FLUSH_RESET_PERMS
set and vmalloc::vm_reset_perms() does not force split of the direct map
for PMD_SIZE chunks.

Set the area permissions with set_vm_flush_reset_perms() when populating
the execmem cache just before flipping the area to ROX.

This way freeing an allocated area on an error path won't incur two
updates of the direct map alias of that area and TLB flushing in
vm_reset_perms().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/execmem.c | 40 +++++++---------------------------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 74a178a87e758..ad07cae9ed585 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -113,28 +113,6 @@ static inline unsigned long mas_range_len(struct ma_state *mas)
 	return mas->last - mas->index + 1;
 }
 
-static int execmem_set_direct_map_valid(struct vm_struct *vm, bool valid)
-{
-	unsigned int nr = (1 << get_vm_area_page_order(vm));
-	unsigned int updated = 0;
-	int err = 0;
-
-	for (int i = 0; i < vm->nr_pages; i += nr) {
-		err = set_direct_map_valid_noflush(vm->pages[i], nr, valid);
-		if (err)
-			goto err_restore;
-		updated += nr;
-	}
-
-	return 0;
-
-err_restore:
-	for (int i = 0; i < updated; i += nr)
-		set_direct_map_valid_noflush(vm->pages[i], nr, !valid);
-
-	return err;
-}
-
 static int execmem_force_rw(void *ptr, size_t size)
 {
 	unsigned int nr = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -169,9 +147,6 @@ static void execmem_cache_clean(struct work_struct *work)
 
 		if (IS_ALIGNED(size, PMD_SIZE) &&
 		    IS_ALIGNED(mas.index, PMD_SIZE)) {
-			struct vm_struct *vm = find_vm_area(area);
-
-			execmem_set_direct_map_valid(vm, true);
 			mas_store_gfp(&mas, NULL, GFP_KERNEL);
 			vfree(area);
 		}
@@ -301,6 +276,8 @@ static void *execmem_cache_populate_alloc(struct execmem_range *range, size_t si
 	/* fill memory with instructions that will trap */
 	execmem_fill_trapping_insns(p, alloc_size);
 
+	set_vm_flush_reset_perms(p);
+
 	err = set_memory_rox((unsigned long)p, vm->nr_pages);
 	if (err)
 		goto err_free_mem;
@@ -312,18 +289,15 @@ static void *execmem_cache_populate_alloc(struct execmem_range *range, size_t si
 	 */
 	mutex_lock(mutex);
 	err = execmem_cache_add_locked(p, alloc_size, GFP_KERNEL);
-	if (err)
-		goto err_reset_direct_map;
-
-	p = execmem_cache_alloc_locked(range, size);
-
+	if (!err)
+		p = execmem_cache_alloc_locked(range, size);
 	mutex_unlock(mutex);
 
+	if (err)
+		goto err_free_mem;
+
 	return p;
 
-err_reset_direct_map:
-	mutex_unlock(mutex);
-	execmem_set_direct_map_valid(vm, true);
 err_free_mem:
 	vfree(p);
 	return NULL;

-- 
2.53.0


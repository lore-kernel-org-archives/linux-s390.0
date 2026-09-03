Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD153D171B;
	Thu,  3 Sep 2026 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427722; cv=none; b=DgpRmi/zsX05edcX1l1xg/RMXs7ZuiHfFfCzi/1LSzzX5amxnUAaz+JKssH2u+odqpwOADNAqZnDsdUVh6KFZTpUwCpTgy4uCAISw/ckfMBkiHciu5woyOs+Ui8BV/EkE1J0uC2VvECBe7CphjimpXBmodAxRpF2vNb9i9yQPbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427722; c=relaxed/simple;
	bh=lmwGINDGXjLtO5n4P1xYCpkJ0xj/DZY8fjZgj8WVzM8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OVV2cm7lOASGZaAFkdoAZby6xqYPN2F9Sf7o+xG/zrAoLgNQQwbuQwaFLv7ALU0ol4e4aUryfZ1v0yF/qtBpB7i32fmNzRBXHYjwu0jUL6UgmRLc+ucZdkG9wxR1gx9PMhBOiCY91ul9/H7I1CoFpAJuusKQXDRJdSzZx5nk3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjYdGsba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjYdGsba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F7C1F00A3A;
	Thu,  3 Sep 2026 09:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427720;
	bh=ey992VJ59vkyhnjjAc3vc3uxfb9JDJ9GYvnBCB4zM0s=;
	h=From:Subject:Date:To:Cc;
	b=RjYdGsba5HHZrGO3OCHTmn5IC/N6RTyFrp8Z5Ubj7a/i8bjv42piN/UnRLS/1Bh0f
	 T6WY+xo9hTACaiHWVLL1I64700TyI6CpONHAAc7NH1wFG8764Rix/yvus0e02RzHwJ
	 6lVfVHzvDDFZZPilK+iLbOrh5eOBUwY4cU1HWIxlQloKPJ5EF4Fp2HIhI0ZgNnmusl
	 YeF8CNVhBIJ2OM4LcTF0AHaHbrzgx1W2NTXtc9Jgo1VCc736L9QnA67+/FqNahfDAB
	 9puZjLKz3xoy7Jn4nRKUELzui6VgXVpeuLgM+vcsR88ND3i+tLMGGRuBI2XxCjpjEV
	 lNZ7OCD0gXGpw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v3 0/6] arch, mm/execmem: resolve confusion about
 set_direct_map_valid_noflush()
Date: Thu, 03 Sep 2026 12:28:26 +0300
Message-Id: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTQ6CMBAF4KuYrh0pbcOPK+9hXLQwQNUCabHBE
 O4uBRe6MS7f5M2XNxGHVqMjx91ELHrtdNcuge93pGhkWyPocsmEUZbQLE4ARywMGnA4gDfQozU
 OPAUGSmImUimqRFRk+e8tVnpc7fNly+6hrlgMAQwNJR2CsrItmnB605Hf9JWO1o7nod5oN3T2u
 W71cWD/meVjoJDTXAjJZSl4dbqhbfF+6GxNwi7PPijGf1FsoRSNueRpmQnFv6h5nl/7jJ1fTwE
 AAA==
X-Change-ID: 20260816-execmem-set-vm-perms-v0-2-bae847a4f64f
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

Recent discussion about implementation of execmem's ROX caches on arm64
revealed a confusion about how set_direct_map_valid_noflush()
implemented on different architectures.

On arm64 it sets or clears the PTE_VALID bit marking a PTE as present or
not present.

On other architectures it's a range version of
set_direct_map_invalid_noflush() and set_direct_map_default_noflush()

Unlike arm64::set_direct_map_valid_noflush(),
set_direct_map_default_noflush() not only marks PTE as present, but also
sets its default protection mode.

Other than that, initial design of execmem ROX caches didn't rely on
restoration of large mappings that's now available on x86, but
completely removed the memory allocated for the ROX cache from the
direct map to ensure that large mappings are not split. This precluded
usage of VM_FLUSH_RESET_PERMS for the ROX cache allocations and required
execmem to implement manipulation of the direct map alias.

Current implementation of ROX caches does not remove the direct map
alias but simply calls set_memory_rox() that updates the permissions in
both vmalloc address space and the direct map and relies on
collapse_large_pages() in x86 CPA to keep large mappings.

This allow using VM_FLUSH_RESET_PERMS for execmem ROX cache allocations
with small adjustments to set_direct_map APIs and vmalloc::reset_perms()
behaviour: adding number of pages parameter to set_direct_map APIs and
making resetting of the direct map permissions in vmalloc VMAP_HUGE
friendly.

Implement these adjustments, make execmem always use VM_FLUSH_RESET_PERMS
and revert set_direct_map_valid_noflush() changes.

This applies on the current mm-unstable with v2 reverted, the base-commit
b4 lists is bogus.

[1] https://lore.kernel.org/all/20260611130144.1385343-4-abarnas@google.com

---
This version does not address sashiko comments about the preexiting
issues, it only changes how VM_FLUSH_RESET_PERMS is set for ROX cache
areas. 

The fixes for pre-exising issues sashiko found are coming soon :)

v3 changes:
* set VM_FLUSH_RESET_PERMS to allocated area just before flipping the
  permissions rather than at allocation time

v2: https://lore.kernel.org/all/20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org
* move setting of VM area order back to __vmalloc_area_node()
* add tags, thanks!

v1: https://patch.msgid.link/20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org

---
Mike Rapoport (Microsoft) (6):
      set_memory: add number of pages parameter to set_direct_map APIs
      mm/vmalloc: set area's page_order after allocation succeeds
      mm/vmalloc: constify vm parameter of get_vm_area_page_order()
      mm/vmalloc: make set_area_direct_map HUGE_VMAP friendly
      mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cache allocations
      Revert "arch: introduce set_direct_map_valid_noflush()"

 arch/arm64/include/asm/set_memory.h     |  5 ++---
 arch/arm64/mm/pageattr.c                | 24 ++++----------------
 arch/loongarch/include/asm/set_memory.h |  5 ++---
 arch/loongarch/mm/pageattr.c            | 27 ++++------------------
 arch/riscv/include/asm/set_memory.h     |  5 ++---
 arch/riscv/mm/pageattr.c                | 23 ++++---------------
 arch/s390/include/asm/set_memory.h      |  5 ++---
 arch/s390/mm/pageattr.c                 | 20 ++++-------------
 arch/x86/include/asm/set_memory.h       |  5 ++---
 arch/x86/mm/pat/set_memory.c            | 16 ++++---------
 include/linux/set_memory.h              | 12 ++++------
 kernel/power/snapshot.c                 |  4 ++--
 mm/execmem.c                            | 40 ++++++---------------------------
 mm/secretmem.c                          |  6 ++---
 mm/vmalloc.c                            | 26 +++++++++++----------
 mm/vmalloc.h                            |  2 +-
 16 files changed, 61 insertions(+), 164 deletions(-)
---
base-commit: d7bc5ce72091180aef05d001dc05c90f6b14c18d
change-id: 20260816-execmem-set-vm-perms-v0-2-bae847a4f64f

--
Sincerely yours,
Mike.


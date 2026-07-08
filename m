Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54EB37BE7A;
	Wed,  8 Jul 2026 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519867; cv=none; b=gRHMKsyrfGpqtbpROIodOVTHANBNBN3c/gPlgzIxO5qszqdEomiV9sCVqB3zgiHaMx9n3EfrZmHwotdIgmtTAxt6pjo7g9vqDt2zD49nB+L24XrtUaLW9XjOQgbfRWfSK0J12ngXVItwj85C6xccy+FcANK6faO1Qh4yKWwBFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519867; c=relaxed/simple;
	bh=uc6ZOQ7T0n3e1exPQijjNLq/oiv/QGunVCeNk1bzDG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TizrTdUVsFBSEnLrfK49V8zqSiSaanjbtq8lTG6yszaRnMYbNKchEJY7UD9V+skjYS7AjBoUVjasdzFv7UGM2RQi+2oeviS2sNyxNuH6nOC4I35bIJc2ZcAIy09E3wJYL/8HHHW0dY73cb4u8r/BECp133+1bCiI3Q+bdJinu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN/SiEhT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN/SiEhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3D41F000E9;
	Wed,  8 Jul 2026 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519866;
	bh=Ko4Hdlv9loLHMeM4kMSWr4+ckWdvKkB6i/m+lF4LdTE=;
	h=From:Subject:Date:To:Cc;
	b=hN/SiEhTywl8ROd8W5sQTNgOaPwlrPqNaKn1PwiH4xjk4c8RCtMwP5MIq/zye8n/1
	 AMsqvOw8AsRS/YWKgazxPunLd+6nmh4gofbHsSwHmtNqxVxUiGpiaqc1RjhERCEoB3
	 OPMbft3hBw5/p9OOcBLH2fqZ7UktJBuHCDUd2o40KLGzqP3xMgGBakYiJhYl1fL+MW
	 JzRE+ebX2nGw/tvXWsl1Dbsno6N2eETLR6WoUtnJVpZFXLM7/LVqz8aA6ogU78XWSS
	 YJdJrLYcpV6XVxLChmpq8+8kLJa421lxsAwHRPeYYTgdNZ0ZjE+cK4ZTyeH96wODoT
	 GsPA3y9CHNA4A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 00/10] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 2)
Date: Wed, 08 Jul 2026 16:10:55 +0200
Message-Id: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG9aTmoC/x3MQQqAIBBA0avErBPKLKqrRISTU80iDZUIpLsnL
 d/i/wSBPFOAsUjg6ebAzmbUZQHroe1Ogk02yEp2lZK9QOfiSefCdnPLpX2UQiGiUq0ZsDGQw8v
 Txs8/neb3/QBoG3oHZAAAAA==
X-Change-ID: 20260428-bootmem_info_part2-4bbb445d9b3d
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

Let's remove the remaining pieces of CONFIG_HAVE_BOOTMEM_INFO_NODE,
performing some smaller cleanups around freeing of reserved vmemmap
pages on the way.

Tested on x86-64 with hugetlb vmemmap optimization in combination with
KMEMLEAK. Heavily cross-compiled.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (10):
      x86/mm: drop order parameter from free_pagetable()
      mm: provide free_reserved_pages(), removing x86 variant
      s390/mm: use free_reserved_pages() in vmem_free_pages()
      mm/bootmem_info: allow calling free_bootmem_page() on pages without a bootmem_type
      x86/mm: stop marking vmemmap as SECTION_INFO
      x86/mm: stop marking page tables as MIX_SECTION_INFO
      x86/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
      mm/hugetlb_vmemmap: remove bootmem_info leftovers
      mm/sparse: remove bootmem_info.h include
      mm/bootmem_info: remove CONFIG_HAVE_BOOTMEM_INFO_NODE

 MAINTAINERS                  |   1 -
 arch/s390/mm/vmem.c          |   4 +-
 arch/x86/mm/init_64.c        | 134 ++++---------------------------------------
 include/linux/bootmem_info.h |  89 ----------------------------
 include/linux/mm.h           |   8 ++-
 mm/Kconfig                   |   8 ---
 mm/Makefile                  |   1 -
 mm/bootmem_info.c            |  72 -----------------------
 mm/hugetlb_vmemmap.c         |   8 +--
 mm/page_alloc.c              |  33 ++++++++---
 mm/sparse.c                  |   1 -
 11 files changed, 46 insertions(+), 313 deletions(-)

---

base-commit: d11ba1f570615ec8d4814d6313ee1d7075a33787

change-id: 20260428-bootmem_info_part2-4bbb445d9b3d

--

Cheers,

David


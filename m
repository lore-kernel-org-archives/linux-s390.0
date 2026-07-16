Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D422301;
	Thu, 16 Jul 2026 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213481; cv=none; b=cGUtzle7lVWoiXZ8KyQNiecAs3u4uhq7F6yP5z+99qslqXuqKzz8YtAk0UK/oFvnWZ3Gmx4Xwk/OFLuOnbEtH3MS265bKsFSszjVvKQRDyZCj23qDFL/xMMJ6MQ6ISjI+xuTkVnW5IfztGuxX9VrpVdUpmwt7jerR7vY8J4sEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213481; c=relaxed/simple;
	bh=5posrEIIB3Jkb5HHkrEz5R3V+I/jIudcfLc0dgWA1hA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lmFSMgG01alUH1ilHGxb76TAOUC6GGPmbdPjLx4sL+EtX8HR66a8sC2hl9D1twN6lF5iGdkNur6TSH1z1GWxAJyLF0jmVI1+lDmNwEYlGN5MCn64ZcbV03bsAJqTWpkEKMTMMhH9h4ciPrKalBngDM+v7PLhqueSqfzwo0vvWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0LDeiCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0LDeiCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C26E1F000E9;
	Thu, 16 Jul 2026 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213479;
	bh=Zz+36yUziYF15DNC+aOn3O6eA/aUkcC+mnFUaLJ5lGc=;
	h=From:Subject:Date:To:Cc;
	b=D0LDeiCvT5iqD9YtMclprsJ7AvnZHg7GHs6EAfLO2QhyV0hIf2J4bJTCQPtwSSEYs
	 o2g+22Eehz/QPe1n4FEU34dGtWBcXwRGMIve8e2icBn3Eu1vhw10RwStIc49paCsqU
	 zdA7nZnUQNCssIe4UYt3HWDiqT/ePC6LYALmtRjHBeiIbeGiJsizjZhL+6cUAIgZJ/
	 vV7bGB3xRJOoqP02Bc0/jlKgnfMZys6osYRN/Dsv5Q4OL4uUxxltXWBU154sZ64QR7
	 R4K7WgEDAbr3eEeOJs3h+uDCVZX1YgoIdIGvsBxcpzBs2ldbZIwtFVF1fKBBBf03hM
	 DcaDqNQx3fu2A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 00/10] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 2)
Date: Thu, 16 Jul 2026 16:50:59 +0200
Message-Id: <20260716-bootmem_info_part2-v2-0-4afc76c73d61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANPvWGoC/22NQQ6CMBBFr0JmbU2pBYGV9zCEUBhgorRk2hAN4
 e5W3Lp8L/nvb+CRCT1UyQaMK3lyNoI6JdBNrR1RUB8ZlFS51KoQxrkw49yQHVyztByU0MYYrbO
 +NJce4nBhHOh1RO915Il8cPw+Ptb0a3+5q/ybW1MhRZrlHeqyyLOyuD2QLT7Pjkeo933/AMHki
 uq1AAAA
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
Changes in v2:
- In patch #2, reverse the order of setting the page count and clearing
  PG_reserved, and modify the patch description accordingly.
- Link to v1: https://patch.msgid.link/20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org

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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879803FBEC6;
	Mon, 11 May 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508378; cv=none; b=qWAix6oiQB66a6Zj8YuqI8XEnlr6pz2LBCne8CmHGX7FsnDG0LdREjSrsO0mDRVM0Cm11dtMlqcn/th0QV5/xYOXHaOWY3to1tZK/B0A5aQlO0qP4Rt8wI0fb5ntl0Qy9nARXT72qiB9t4EXyVeMy0Y2bXs8DZq/kOY2U19xKlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508378; c=relaxed/simple;
	bh=9/8M2sHV8SgEK+1FMWV6SnFszJKpiz3SzVlMOl5S/UQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbAQk+W3nnXVaI676K50IBoGUqVAsnM62rNhq0lFvlQHQWPYhZ1IuPEnGB7we2utgp14KPsdkD2+3GZwuQHCxrxoIB4i0WI6uv67IhwY13Ps9pCmV1QLVyaRQTe7c1u2jkF8rjmllJ9KktIbEoulnQxxePhWomcNna8+VsxK1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpwR2/9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpwR2/9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C15C2BCFB;
	Mon, 11 May 2026 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508378;
	bh=9/8M2sHV8SgEK+1FMWV6SnFszJKpiz3SzVlMOl5S/UQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qpwR2/9iNsX4kETinr2qHODBsLGHsPUUZrTsmeM9AESKVpqbk81P30B5Y9V29uk9A
	 tXiVq2FwNHSyozJ2+Ri3cRbL1te3EmQaN+VS+XQYpJYTlcm4xAPX27yYLrh7nmMTrD
	 gA0MD1DSzhX+9wxHm5shlRSunGZB+V2A7zDp7v7yvUne5T/2ZCeEFG/K7hMiMRiRtQ
	 gX4ninWFuT2qb9iDdfMe862XUG6AnojfBtmLDvIdhyWwqMS4Ma3gvo6DH1pHILXIua
	 TT8+gJHZ/sGaRLC2K7SHzvggQ6ftTyvU53+mUI/B+NKg17cQzQP7qfBknfq8GwUGkw
	 60KofuPliv/dg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:36 +0200
Subject: [PATCH 8/8] powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

register_page_bootmem_info_node() essentially only calls
register_page_bootmem_memmap(). However, on powerpc that function is a
nop. So there is not benefit in using CONFIG_HAVE_BOOTMEM_INFO_NODE
anymore, let's just drop it.

We can stop including bootmem_info.h.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/powerpc/mm/init_64.c | 8 --------
 mm/Kconfig                | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index b6f3ae03ca9e..64f0df5bb5cd 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -41,7 +41,6 @@
 #include <linux/libfdt.h>
 #include <linux/memremap.h>
 #include <linux/memory.h>
-#include <linux/bootmem_info.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -388,13 +387,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 
 #endif
 
-#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
-void register_page_bootmem_memmap(unsigned long section_nr,
-				  struct page *start_page, unsigned long size)
-{
-}
-#endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
-
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/mm/Kconfig b/mm/Kconfig
index e221fa1dc54d..97b079372325 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -537,7 +537,7 @@ endchoice
 
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
-	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
+	select HAVE_BOOTMEM_INFO_NODE if X86_64
 	depends on MEMORY_HOTPLUG
 	select MIGRATION
 

-- 
2.43.0


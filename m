Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691988;
	b=Ypp1XeSrU8Cp+cYbXY8X8W6BtX66csWTM4XTJJGvv9auRIj0J/hnGDZg63cU5xO7ObEN
	 dsGuMv4m7qac+ZuSSKol990k19BKQrisHZd0AJsj5BusUDU5AChW/JzDp+3DWz/IKS1Fh
	 D6hjE1jPvyTbRwxzhgokrI8YPlYmLtfgYdU9yW1ZHBjV+HlcpCAXHJOoZSJM/a7STpHl5
	 l6ZRedMd1btoFEfzjASGr2bD+9ujwkt7RabWSV3MVwCc0PZy8my3YwOF9RaC53wzCSOTB
	 0p6iDRpIpkjdMONliyi8lL8dhaSnoANceNCNK++wkQwfgjt2N5LP1hqrCfaPa3s1xFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691988;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=3baBQY1vcim/LIuBDd2iS5vp7cN9wnC3Urh2E32RyUQ=;
	b=MkN8fhqcouazcZg/Zc37hPo4rXWIJC4iu3ZA+z3fUUAY/t9QvytuxHofsBzRBVLtuEsd
	 gb31eVbpFKXllMPqrjtd3ITaakzWkkg2t9ZaJ3NN58s1pw4Uf87cCcOZP0B++DqrOnjiQ
	 dOPmdyj33DoYWjw63+zFhkzhpjlmzQl/YA6Et1Umr8Q7XFsJrLRs/XyonN5a5RMSZv1jY
	 irkbl4pk4JA1SLsfojQUtLGxKYkpTlgnEfNZ15aJ8zcOSneKziSkxwEu87jVBNvpLCEl2
	 Ga1T82kQMvIKXTAaOm5Imze1Fw+VtpBt+LR4J5974pQr0rDTLlcfRMvNBBHrKeTsJQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arH33Iw+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D1C606A31C;
	Thu, 26 Nov 2026 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arH33Iw+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3021F008B2;
	Thu, 26 Nov 2026 11:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691987;
	bh=3baBQY1vcim/LIuBDd2iS5vp7cN9wnC3Urh2E32RyUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=arH33Iw+PdWr+zlekYtf5nt+Op90L1TFCAIp15UEy+JOD/BMr6gM82izCzHJ1j53x
	 Rf7Bd3XB7buR8nKFBjOykUN3NzH886rFBdFTBPFTBNhX8nMAbZ26UqYbx9bGLW+g3i
	 /sQ2LSWtOosQOua5U2835M+MrgzYeEUFMalhl41+LsupVwAVt0II5/HrUmhS4p0NSh
	 NQAllOapJ7m1dfpO7PW+vkvGZTmiNe52cT0vTejwfyJiRSIEKrJTLRp8aAuN4g45//
	 GvISaE7BPJ/Lhx5ZN5KxgnwBOhwRJdneHwiwJQvKiPXC9/6nLeJSOz+UOUnwYZx5zs
	 1+Ng3jE8359qw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:46 +0200
Subject: [PATCH RFC v2 33/54] LoongArch: use pfn_is_nosave() to exclude
 firmware ranges from hibernation
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-33-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

Commit 619b52777a49 ("LoongArch: Fix kernel_page_present() for
KPRANGE/XKPRANGE") made kernel_page_present() filter out firmware pages,
such as EFI runtime services code and data, to prevent hibernation from
saving and restoring them.

kernel_page_present() reports whether a page is mapped in the kernel page
tables, while excluding physical memory from the hibernation image is what
pfn_is_nosave() is for.

Move the check for firmware pages to pfn_is_nosave().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/loongarch/mm/pageattr.c     | 3 +--
 arch/loongarch/power/hibernate.c | 6 +++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index a7dcff40f759..a728db40f9e0 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2024 Loongson Technology Corporation Limited
  */
 
-#include <linux/memblock.h>
 #include <linux/pagewalk.h>
 #include <linux/pgtable.h>
 #include <asm/set_memory.h>
@@ -168,7 +167,7 @@ bool kernel_page_present(struct page *page)
 	unsigned long addr = (unsigned long)page_address(page);
 
 	if (addr < vm_map_base)
-		return memblock_is_memory(__pa(addr));
+		return true;
 
 	pgd = pgd_offset_k(addr);
 	if (pgd_none(pgdp_get(pgd)))
diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hibernate.c
index 3de38ffb11c3..65dbf1aed4a7 100644
--- a/arch/loongarch/power/hibernate.c
+++ b/arch/loongarch/power/hibernate.c
@@ -4,6 +4,7 @@
 #include <asm/sections.h>
 #include <asm/time.h>
 #include <asm/tlbflush.h>
+#include <linux/memblock.h>
 #include <linux/suspend.h>
 
 static u32 saved_crmd;
@@ -44,7 +45,10 @@ int pfn_is_nosave(unsigned long pfn)
 	unsigned long nosave_begin_pfn = PFN_DOWN(__pa(&__nosave_begin));
 	unsigned long nosave_end_pfn = PFN_UP(__pa(&__nosave_end));
 
-	return	(pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+	if (pfn >= nosave_begin_pfn && pfn < nosave_end_pfn)
+		return 1;
+
+	return !memblock_is_memory(PFN_PHYS(pfn));
 }
 
 extern int swsusp_asm_suspend(void);

-- 
2.53.0


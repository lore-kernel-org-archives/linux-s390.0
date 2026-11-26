Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692074;
	b=PGfscv2XjnXPtVZ7Ukk7AbErBI7Nora3dU2Xzt0WhmBrOBh7g3Rfe839I4Y/BJ+Yjiit
	 bEe5crK1BqzBwUnJ+DfCbcGALg9vVjkYGxBJVvLshLAwUgXwX5dBRUTDe91Kigfmsc8Wy
	 wJj+hOhOiXrbUAicrkN+iI+F7SWbjrhyyehw6jfkl3c5+pJJloIXy/QkhOyKswtoY8lTH
	 /43v2/3QcB2u5L5SfxMQ+X0aRwRSTrvVo29+MXviKhCMcTkgKCe0vVftWR+DhODtlc61F
	 txlNzjnlslLmHkSOdIXLUPMVFHi454gzX2FkH6jRS+CHEMd6kTxazdbqTKthdzujLtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692074;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=acVZadH+VFBFC1d1dLbutXfDJETNRTgRtEhv1loN3Kc=;
	b=33eofR/qCmhE8+HLXrKgZBCk5P4QjdSVF6ktsoOLSQJiROlcvMgbuUzRBJxoakX9mSkP
	 8oS2KqYj23dUIufk3SLkqJXhjWmVnMIbLvO132YkkywMLmh8p2lN3utlEaBPCi+a0/vSl
	 SJisWANIwpVoTp20wjpsUCczwoV+rRpxD9jkWpe+mjr0ltK5UIoDZlEevwdOfOlZ5FJ+W
	 CDljNqPpXb2TvNot9QbQAJDbMwLlot/SxRQMAdTBz5KkZ6WsXP2U0r4n3BxYurg0ywMsD
	 qQB3WrG+r+fgHf7gOtiY/tTafiO5uapKN0EnRDWgjo4XeZMqeu9RA9V2tKmbKVfIAGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK4AqxJG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32232606A31C;
	Thu, 26 Nov 2026 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK4AqxJG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F331F000F0;
	Thu, 26 Nov 2026 11:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692073;
	bh=acVZadH+VFBFC1d1dLbutXfDJETNRTgRtEhv1loN3Kc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oK4AqxJGy9uqp40xlP/Jc0iEDwgFDT9uMRNK+Zl8qcl8G0bhKbCFVgHRfykGfNWh7
	 rtJNH451csTci9e1tSOqJ5qyT8T6vptgOd9P041BiJa0SV5y21pqGOAEXr1+d+1WCS
	 cIpdBKH1Fy/CULw7Wl50ENc3s+c3GzFxSO5iYs+XhEAWpLIAX9icNKRJR3koOxCV0Z
	 mHqfTR7sjYIttOG7RyHW9UfPkEmc9uo53WuWB6vqHW+ROeoi9ZN6xtbRTt34C0QJDV
	 AQKxlsm/4KiSBcg5omjktitzKas7r73CDVkNZYMMMl3IfwUGRR6riIvMyHQ81TcoJ/
	 UqKiSDECBOiuA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:55 +0200
Subject: [PATCH RFC v2 42/54] riscv: count the mappings of the linear map
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-42-723f1e33c3d8@kernel.org>
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

The CPA core keeps a counter of the linear map entries at every page table
level and displays the "Breakdown of page table sizes used in the kernel's
identity mapping of RAM" in /proc/meminfo.

When a large mapping is split, the counters of the split level and the one
below are updated as well as direct_map_level2_splits or
direct_map_level3_splits event counters displayed in /proc/vmstat.

The initial updates for these counters happen when an architecture creates
its linear map.

riscv doesn't seed these counters, so the CPA core cannot update them
during a split, and the split events stay at zero.

Count the linear map when it is created at boot and on memory hot-plug and
hot-remove.

Report the counters in /proc/meminfo, as x86 and s390 do.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/riscv/mm/init.c     | 20 ++++++++++++++++++++
 arch/riscv/mm/pageattr.c | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e1bcc3a16129..b466db515ee1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -28,6 +28,9 @@
 #include <linux/kfence.h>
 #include <linux/execmem.h>
 #include <linux/vmemmap-optimization.h>
+#ifdef CONFIG_MMU
+#include <linux/pageattr.h>
+#endif
 
 #include <asm/alternative.h>
 #include <asm/fixmap.h>
@@ -1201,6 +1204,15 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pt_ops_set_fixmap();
 }
 
+static enum pgtable_level __meminit linear_map_level(uintptr_t map_size)
+{
+	if (map_size == PUD_SIZE)
+		return PGTABLE_LEVEL_PUD;
+	if (map_size == PMD_SIZE)
+		return PGTABLE_LEVEL_PMD;
+	return PGTABLE_LEVEL_PTE;
+}
+
 static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
 						  uintptr_t fixed_map_size, const pgprot_t *pgprot)
 {
@@ -1214,6 +1226,7 @@ static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t
 
 		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
 				   pgprot ? *pgprot : pgprot_from_va(va));
+		direct_map_count_update(linear_map_level(map_size), 1);
 	}
 }
 
@@ -1599,6 +1612,8 @@ static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long addr, un
 		pte_clear(&init_mm, addr, ptep);
 		if (is_vmemmap)
 			free_vmemmap_storage(pte_page(pte), PAGE_SIZE, altmap);
+		else
+			direct_map_count_update(PGTABLE_LEVEL_PTE, -1);
 	}
 }
 
@@ -1620,6 +1635,8 @@ static void __meminit remove_pmd_mapping(pmd_t *pmd_base, unsigned long addr, un
 			pmd_clear(pmdp);
 			if (is_vmemmap)
 				free_vmemmap_storage(pmd_page(pmd), PMD_SIZE, altmap);
+			else
+				direct_map_count_update(PGTABLE_LEVEL_PMD, -1);
 			continue;
 		}
 
@@ -1648,6 +1665,9 @@ static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long addr, un
 				pud_clear(pudp);
 				if (is_vmemmap)
 					free_vmemmap_storage(pud_page(pud), PUD_SIZE, altmap);
+				else
+					direct_map_count_update(
+						PGTABLE_LEVEL_PUD, -1);
 			}
 			continue;
 		}
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index bb8629da0d1d..22826ba688c3 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -5,12 +5,27 @@
 
 #include <linux/pageattr.h>
 #include <linux/pgtable.h>
+#include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
 #include <linux/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/bitops.h>
 #include <asm/set_memory.h>
 
+#ifdef CONFIG_PROC_FS
+void arch_report_meminfo(struct seq_file *m)
+{
+	unsigned long levels = BIT(PGTABLE_LEVEL_PTE);
+
+	if (IS_ENABLED(CONFIG_64BIT))
+		levels |= BIT(PGTABLE_LEVEL_PMD);
+	if (pgtable_l4_enabled())
+		levels |= BIT(PGTABLE_LEVEL_PUD);
+
+	cpa_report_meminfo(m, levels);
+}
+#endif
+
 void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
 {
 	pte_t pte = ptep_get(leaf->kpte);

-- 
2.53.0

